# uzklausa, kuria kviesime naudodamiesi procedura
SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;


drop procedure if exists GetCustomers;

# Proceduros kurimo blokas
DELIMITER $$ # turime pakeisti delimiter simboli, kad nebutu priestaros proceduros kode

/*
Delimiters other than the default ;  are typically used when defining functions, 
stored procedures, and triggers wherein you must define multiple statements. 
You define a different delimiter like $$ which is used to define the end of the entire procedure,
but inside it, individual statements are each terminated by ;.
That way, when the code is run in the mysql client, the client can tell
where the entire procedure ends and execute it as a unit rather
than executing the individual statements inside.
 */

CREATE PROCEDURE GetCustomers() # procedura priima 0 argumentu
begin # pradedame procedura
	SELECT 
		customerName, 
		city, 
		state, 
		postalCode, 
		country
	FROM
		customers
   ORDER BY customerName;
END$$ #  # kabliataskis nebera delimiter simbolis. Baigiame procedura ir uzbaigiame nauju delimeter
DELIMITER ; # atkeiciame delimeter i standartini ;

# pakvieciame procedura
call GetCustomers();

-- Procedura su kintamuoju

drop procedure if exists GetTotalOrder;

DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
	DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;

call GetTotalOrder();

-- Procedura su input/output

drop procedure if exists GetOfficeByCountry;
drop procedure if exists GetOrderCountByStatus;
drop procedure if exists SetCounter;

DELIMITER $$

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 	FROM offices
	WHERE country = countryName;
END$$

DELIMITER ;

call GetOfficeByCountry('France');

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$

DELIMITER ;

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

DELIMITER $$

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$

DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8

-- Procedura su salyga

drop procedure if exists GetCustomerLevel;

-- Klientai pagal kredito limita
SELECT 
    customerNumber, 
    creditLimit
FROM 
    customers
WHERE 
    creditLimit > 50000
ORDER BY 
    creditLimit DESC;
   
-- sukuriame procedura, kuri suskirsto klientus pagal kredito limita
DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$

DELIMITER ;

-- iskvieciame procedura ir ispausdiname kliento lygi
CALL GetCustomerLevel(141, @level);
SELECT @level;

SELECT 
    customerNumber, 
    creditLimit
FROM 
    customers
WHERE 
    customerNumber = 141;
   
-- Sukuriame procedura naujai su skirtingais klientu lygiais
drop procedure if exists GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END $$

DELIMITER ;

CALL GetCustomerLevel(447, @level); 
SELECT @level;

-- Procedura su case

drop procedure if exists GetCustomerShipping;

-- Procedura naudojant case ir nustatant pristatymo laikotarpi
DELIMITER $$

CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping       VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100);

SELECT 
    country
INTO customerCountry FROM
    customers
WHERE
    customerNumber = pCustomerNUmber;

    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$

DELIMITER ;

CALL GetCustomerShipping(112,@shipping);
SELECT @shipping;

-- Procedura naudojant case ir salygas
drop procedure if exists GetDeliveryStatus;

DELIMITER $$

CREATE PROCEDURE GetDeliveryStatus(
	IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
	DECLARE waitingDay INT DEFAULT 0;
    SELECT 
		DATEDIFF(requiredDate, shippedDate)
	INTO waitingDay
	FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
END$$
DELIMITER ;

CALL GetDeliveryStatus(10100,@delivery);
SELECT @delivery;

-- Procedura su ciklu

drop procedure if exists LoopDemo;

-- ciklas apibreziamas pavadinimu
-- ciklo viduje apibreziame uzklausas
-- apibreziame ciklo nutraukima nurodant LEAVE
-- sekanciai iteracija iskviesti naudojame ITERATE

/*
[begin_label:] LOOP
    statement_list
END LOOP [end_label]
 */

/*
[label]: LOOP
    ...
    -- terminate the loop
    IF condition THEN
        LEAVE [label];
    END IF;
    ...
END LOOP;
 */

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str,x,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

CALL LoopDemo();

-- funkciju kurimas

-- apibreziame funkcijos pavadinima
-- nustatome funkcijos parametrus, default skaitosi IN, bet galime naudoti IN, OUT, INOUT
-- apibreziame ka norime grazinti RETURN
-- nurodome DETERMINISTIC arba NOT DETERMINISTIC
-- DETERMENISTIC nusako, kad tam paciam input visada grazins vienoda output
-- NONE DETERMINISTIC grazina skirtinga output, tam paciam input

/*
DELIMITER $$

CREATE FUNCTION function_name(
    param1,
    param2,…
)
RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
END $$

DELIMITER ;
*/

DROP FUNCTION IF EXISTS CustomerLevel;

-- sukuriame funkcija kliento lygio nustatymui
DELIMITER $$

CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$
DELIMITER ;

SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;

