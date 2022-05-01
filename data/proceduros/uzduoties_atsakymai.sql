
# Kiek yra pardavin?jama skirting? produkt?? 
DELIMITER $$ 
CREATE PROCEDURE DistinctProducts()
begin
select
	count(distinct productName) as 'Distinct Product'
from
	products;
END$$ 
DELIMITER ;

# Atraskite klientus, kurie neturi pardavimų atstovo. Grąžinkite klientų vardus ir miestus iš kur jie yra. 
DELIMITER $$ 
CREATE PROCEDURE ClientWithoutARepresentetive()
begin
select
	customerName,
	city
from
	customers
where
	salesRepEmployeeNumber is null ;
END$$ 
DELIMITER ;


# Kokie yra VP ir Managers vardai? Vardus ir pavardes išveskite viename stulpelyje.
DELIMITER $$ 
CREATE PROCEDURE ListVPAndManagers()
begin
select
	concat(firstName, ' ', lastName) as 'Full Name', jobTitle 
from
	employees
where
	jobTitle like '%VP%'
	or jobTitle like '%Manager%';

END$$ 
DELIMITER ;

call DistinctProducts();
call ClientWithoutARepresentetive();
call ListVPAndManagers();


# Raskite klientus, kurie yra is nurodyto miesto. Pvz. call ClientsByCity('Frankfurt');
DELIMITER $$ 
CREATE PROCEDURE ClientsByCity(IN countryName VARCHAR(255))
begin
select
	customerName,
	city
from
	customers
where city = countryName;
END$$ 

DELIMITER ;

call DistinctProducts();
call ClientWithoutARepresentetive();
call ListVPAndManagers();
call ClientsByCity('Frankfurt');

