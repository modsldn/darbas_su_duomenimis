-- 1
SELECT CategoryName, Description
FROM northwind.categories
ORDER BY CategoryName;

-- 2 
SELECT ContactName, CompanyName, ContactTitle, Phone
From northwind.customers
ORDER BY Phone;

-- 3. 
SELECT UPPER(FirstName) AS FirstName, UPPER( LastName) AS LastName, HireDate
FROM northwind.employees
ORDER BY HireDate;

-- 4. 
SELECT OrderID, OrderDate, ShippedDate, CustomerID, Freight
FROM northwind.orders
ORDER BY Freight Desc
LIMIT 10;

-- 5. 
SELECT lower(CustomerID) AS ID FROM northwind.customers;

-- 6. 
SELECT CompanyName, Fax, Phone,Country, HomePage
FROM northwind.suppliers
ORDER BY Country DESC, CompanyName ;

-- 7. 
SELECT CompanyName,ContactName
FROM northwind.customers
WHERE City = 'Buenos Aires';

-- 8. 
SELECT ProductName, UnitPrice, QuantityPerUnit
FROM northwind.products
WHERE Discontinued = 1;

-- 9.  
SELECT ContactName, Address, City
FROM northwind.customers
WHERE Country NOT IN ("Germany","Mexico", "Spain");

-- 10. 
SELECT OrderDate, ShippedDate, CustomerID, Freight
FROM northwind.orders
WHERE OrderDate = '1996-05-21 ';

-- 11. 
SELECT FirstName,LastName,Country
FROM northwind.employees
WHERE Country <> 'USA';

-- 12. 
SELECT EmployeeID,OrderID,CustomerID,RequiredDate,ShippedDate
FROM northwind.orders
WHERE ShippedDate > RequiredDate;

-- 13. 
SELECT City,CompanyName,ContactName
FROM northwind.customers
WHERE City LIKE "A%" OR City LIKE "B%";

-- 14. 
SELECT OrderID
FROM northwind.orders
WHERE mod(OrderID,2)=0;

-- 15. 
SELECT *
FROM northwind.orders
WHERE Freight > 500;

-- 16. 
SELECT ProductName, UnitsInStock,UnitsOnOrder,ReorderLevel
FROM northwind.products
WHERE ReorderLevel = 0;

-- 17. 
SELECT CompanyName,ContactName,Fax
FROM northwind.customers
WHERE Fax IS NOT NULL;

-- 18. 
SELECT FirstName, LastName
FROM northwind.employees
WHERE ReportsTo IS NULL;

-- 19. 
SELECT OrderID
FROM northwind.orders
WHERE mod(OrderID,2)=1;

-- 20. 
SELECT CompanyName,ContactName,Fax
FROM northwind.customers
WHERE Fax IS NOT NULL
ORDER BY ContactName;

-- 21. 
SELECT City,CompanyName,ContactName,city
FROM northwind.customers
WHERE City LIKE "%L%"
ORDER BY ContactName;

-- 22.
SELECT FirstName, LastName,BirthDate
FROM northwind.employees
where BirthDate >= '1950-01-01'
AND BirthDate < '1960-01-01';
OR
SELECT FirstName, LastName,BirthDate
FROM northwind.employees
where BirthDate Between '1950-01-01'
AND '1959-12-31';

-- 23. 
SELECT LastName, FirstName, extract(year from Birthdate) AS BirthYear
FROM northwind.employees;

-- 24. 
SELECT OrderID, count(OrderID) as NumberofOrders
FROM northwind.`order details`
GROUP BY OrderID
ORDER BY NumberofOrders DESC ;

-- 25. 
SELECT s.SupplierID, p.ProductName, S.CompanyName
FROM northwind.suppliers s
JOIN northwind.products p
ON s.SupplierID = p.SupplierID
WHERE s.CompanyName IN ('Exotic Liquids','Specialty Biscuits, Ltd.','Escargots Nouveaux')
ORDER BY s.SupplierID;

-- 26. 
SELECT ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate,ShipAddress
FROM northwind.orders
WHERE ShipPostalCode = '98124';

-- 27. 
SELECT ContactName, ContactTitle, CompanyName
FROM northwind.customers
WHERE ContactTitle NOT LIKE "%Sales%";

-- 28. 
SELECT LastName, FirstName, City
FROM northwind.employees
WHERE City != "Seattle";

-- 29. 
SELECT CompanyName, ContactTitle, City, Country
FROM northwind.customers
WHERE Country IN ("Mexico","Spain")
AND City <> "Madrid";

-- 30. 
SELECT CONCAT( FirstName,' ', LastName ,' can be reached at ', 'x',Extension ) AS Contactinfo
FROM northwind.employees;

-- 31. 
SELECT ContactName
FROM northwind.customers
where ContactName NOT like "_A%";

-- 32. 
SELECT round (avg (UnitPrice),0) AS AveragePrice,
SUM(UnitsInStock) AS TotalStock,
max(UnitsOnOrder) as MaxOrder
FROM northwind.products;

-- 33. 
SELECT s.SupplierID, s.CompanyName, c.CategoryName, p.ProductName, p.UnitPrice
FROM northwind.products p
JOIN northwind.suppliers s
ON s.SupplierID = p.SupplierID
JOIN northwind.categories C
On c.CategoryID = p.CategoryID;

-- 34. 
SELECT CustomerID, sum(Freight)
FROM northwind.orders
GROUP BY CustomerID
HAVING sum(Freight) > "200";

-- 35. 
SELECT od.OrderID, c.ContactName,od.UnitPrice,od.Quantity,od.Discount
FROM northwind.`order details` od
JOIN northwind.orders o
ON od.OrderID = o.OrderID
JOIN northwind.customers c
ON c.CustomerID = o.CustomerID
WHERE od.Discount != '0';

-- 36. 
SELECT a.EmployeeID,
CONCAT (a.LastName, " " ,a.FirstName )as employee,
CONCAT (b.LastName," " , b.FirstName ) as manager
FROM northwind.employees a
LEFT JOIN northwind.employees b
ON b.EmployeeID = a.ReportsTo
ORDER BY a.EmployeeID;

-- 37. 
SELECT avg(UnitPrice) AS AveragePrice,
min(UnitPrice)AS MinimumPrice,
max(UnitPrice)AS MaximumPrice
from northwind.products;

-- 38. 
CREATE VIEW CustomerInfo AS
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle, c.Address,
c.City,c.Country,c.Phone,o.OrderDate, o.RequiredDate, o.ShippedDate
FROM
northwind.customers c
JOIN
northwind.orders o ON c.CustomerID = o.CustomerID;

-- 39. 
RENAME TABLE customerinfo TO CustomerDetails;

-- 40. 
CREATE VIEW ProductDetails AS
SELECT
p.ProductID,S.CompanyName,
p.ProductName,c.CategoryName, c.Description,
p.QuantityPerUnit, p.UnitPrice, p.UnitsInStock, p.UnitsOnOrder,
p.ReorderLevel, p.Discontinued
FROM northwind.suppliers s
JOIN northwind.products p ON s.SupplierID = p.SupplierID
JOIN northwind.categories c
ON c.CategoryID = p.CategoryID;

-- 41. 
DROP VIEW IF EXISTS customerdetails;

-- 42. 
SELECT substring(CategoryName,1,5) as Short_info
FROM northwind.categories;

-- 43. 
DROP table IF exists shippers_dup;
CREATE TABLE shippers_dup (LIKE northwind.shippers);
INSERT INTO shippers_dup SELECT * FROM northwind.shippers;

-- 44. 
ALTER TABLE shippers_dup
ADD column Email VARCHAR(50);
UPDATE northwind.shippers_dup
SET Email ='speedyexpress@gmail.com'
WHERE ShipperID = '1';
UPDATE northwind.shippers_dup
SET Email ='unitedpackage@gmail.com'
WHERE ShipperID = '2';
UPDATE northwind.shippers_dup
SET Email ='federalshipping@gmail.com'
WHERE ShipperID = '3';

-- 45. 
SELECT s.CompanyName,p.ProductName
FROM northwind.categories c
JOIN northwind.products p
ON c.CategoryID = p.CategoryID
JOIN northwind.suppliers s
ON s.SupplierID = p.SupplierID
WHERE CategoryName = "Seafood";

-- 46. 
SELECT c.CategoryID, s.CompanyName, p.ProductName
FROM northwind.categories c
JOIN northwind.products p
ON c.CategoryID = p.CategoryID
JOIN northwind.suppliers s
ON s.SupplierID = p.SupplierID
WHERE c.CategoryID = "5";

-- 47. 
DROP table IF exists shippers_dup;

-- 48. 
SELECT LastName, FirstName, Title,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE, BirthDate)),"%y Years ")
AS Age from northwind.employees;

-- 49. 
SELECT c.CompanyName, count(c.CustomerID) AS NumberofOrders
FROM northwind.customers c
JOIN northwind.orders o
ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '1994-12-31'
GROUP BY c.CustomerID
having count(c.CustomerID) > 10;

-- 50. 
SELECT CONCAT( ProductName,' ', "weighs/is" ," ", QuantityPerUnit, " ", "and cost ","$",ROUND(UnitPrice) ) AS
ProductInfo
FROM northwind.products;SELECT LastName, FirstName, extract(year from Birthdate) AS BirthYear
FROM northwind.employees;

