/*Excercise 1.1*/
SELECT CustomerID, CompanyName, Address, City, Region, PostalCode, Country  
FROM Customers
WHERE City = 'Paris' OR City = 'London';

/*Excercise 1.2*/
SELECT ProductName, QuantityPerUnit 
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

/*Excercise 1.3*/
SELECT Products.ProductName, Products.QuantityPerUnit, Suppliers.CompanyName AS 'Supplier Name', Suppliers.Country
FROM Products
INNER JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID
WHERE QuantityPerUnit LIKE '%bottle%';

/*Excercise 1.4*/
SELECT Categories.CategoryName, Count( Products.ProductName) AS 'Amount of Products'
FROM Products 
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP By CategoryName
ORDER By 'Amount of Products' DESC;

/*Excercise 1.5*/

SELECT CONCAT(TitleOfCourtesy,' ', FirstName,' ', LastName) AS 'Name', City 
FROM Employees 
WHERE Country = 'UK'

/*Excercise 1.6 1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins)
with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers.*/

SELECT Region.RegionID, Region.RegionDescription, 
FORMAT(SUM(([Order Details].UnitPrice*[Order Details].Quantity)*(1-[Order Details].discount)), '##,###') AS 'TOTAL SALES'
FROM Region
INNER JOIN Territories ON Region.RegionID = Territories.RegionID
INNER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
INNER JOIN Orders ON EmployeeTerritories.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Region.RegionID, Region.RegionDescription
HAVING SUM(([Order Details].UnitPrice*[Order Details].Quantity)*(1-[Order Details].discount)) > 1000000
ORDER BY RegionID ASC;

/*Excercise 1.7*/
SELECT Count(Freight) AS 'Amount of Orders In UK & USA With Freight > 100.00'
FROM Orders
WHERE FREIGHT > 100.00 
AND (ShipCountry = 'UK' OR ShipCountry = 'USA');

/*Excercise 1.8*/

SELECT TOP 1 OrderID, ((SUM(UnitPrice*Quantity*Discount)) /(SUM(UnitPrice*Quantity))) AS 'Discount Applied' 
FROM [Order Details] 
GROUP BY OrderID
ORDER BY ((SUM(UnitPrice*Quantity*Discount)) /(SUM(UnitPrice*Quantity))) DESC

/*Excercise 2.1*/

CREATE TABLE spartansTable
(spartanID INT IDENTITY(1,1) PRIMARY KEY,
title VARCHAR(20) NOT NULL,
firstName VARCHAR(20) NOT NULL,
lastName VARCHAR(20) NOT NULL,
universityAttended VARCHAR(50),
courseTaken VARCHAR(50),
markAchieved DEC(2,1),
stream VARCHAR(20) NOT NULL,
startDate VARCHAR(8) NOT NULL)

/*Excercise 2.2*/

INSERT INTO spartansTable
VALUES ('Mr.', 'Anjum Ali', 'Saiyad', 'Queen Mary University of London', 'Mathematics', '2.2', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Joyel', 'Shaju', 'Coventry University', 'Computer Science', '1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES('Mr.', 'Victor', 'Granados', 'University of Granada', 'Information and Documentation', '2.1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Jack', 'Farmer', 'University of Leeds', 'Physics', '2.1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Mohammad', 'Khwaja', 'University of Westminster', 'Electronic Engineering', '2.2', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Thomas', 'Briggs', 'Bournemouth University', 'Exercise Science', '1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Shaqi', 'Abdullah', 'Brunel University London', 'Mechanical Engineering', '2.1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Zaid', 'Iqbal', 'Queen Mary University of London', 'Computer Science', '2.1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Paul', 'Brewer', 'University of Hull', 'Computer Science', '1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Ms.', 'Elizabeth', 'Nicholls', 'Canterbury Christ Church University', 'Sport and Exercise Science', '1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Daniel', 'Lippross', 'University of Hull', 'Chemistry', '2.1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Ms.', 'Ariadna', 'Gonzalez', 'London Metropolitan University', 'Business Information Technology', '1', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Ygor', 'Teixeira', 'University of Greenwich', 'Games Design and Development', '2.2', 'DevOps', '11/11/19');
INSERT INTO spartansTable
VALUES ('Mr.', 'Hussain', 'Fiaz', 'University of East London', 'Computer Science','2.2', 'DevOps', '11/11/19');

SELECT * FROM EMPLOYEES;

/*Excercise 3.1 List all Employees from the Employees table and who they report to. */
    

SELECT CONCAT(e1.FirstName, ' ', e1.LastName) AS 'Employee Name',
CONCAT(e2.FirstName, ' ', e2.LastName) AS 'Reports To'
FROM Employees e1
LEFT JOIN Employees e2
ON e1.ReportsTo = e2.EmployeeID



/*Excercise 3.2*/


SELECT Suppliers.CompanyName, SUM(([Order Details].UnitPrice*[Order Details].Quantity)*(1-[Order Details].discount)) AS 'TOTAL SALES'
FROM Suppliers 
INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID 
INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
GROUP BY Suppliers.CompanyName
HAVING SUM(([Order Details].UnitPrice*[Order Details].Quantity)*(1-[Order Details].discount)) > 10000
ORDER BY 'TOTAL SALES' DESC;

/*Excercise 3.3 */

SELECT TOP 10 Orders.CustomerID, SUM([Order Details].UnitPrice*[Order Details].Quantity) AS 'Value of Order'
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderDate BETWEEN '1998-01-01' AND '1998-12-31' AND ShippedDate IS NOT NULL
GROUP BY Orders.CustomerID
ORDER BY 'Value of Order' DESC

/*Excercise 3.4*/

SELECT CONCAT(YEAR(OrderDate),'-', CONCAT('0', MONTH(OrderDate))) AS 'YEAR/MONTH', AVG(DATEDIFF(d,OrderDate, ShippedDate)) AS 'Average SHIP TIME'
FROM ORDERS
GROUP BY CONCAT(YEAR(OrderDate),'-', CONCAT('0', MONTH(OrderDate)))
ORDER BY CONCAT(YEAR(OrderDate),'-', CONCAT('0', MONTH(OrderDate)));







