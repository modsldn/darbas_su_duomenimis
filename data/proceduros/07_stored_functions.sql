
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