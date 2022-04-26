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