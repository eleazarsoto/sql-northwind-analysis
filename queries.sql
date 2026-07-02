-- ============================================================
-- NORTHWIND DATABASE ANALYSIS
-- Eleazar Soto | Data Analytics Portfolio
-- github.com/eleazarsoto
-- ============================================================
-- Database: Northwind (SQLite)
-- Tables: Customers, Orders, Products, Categories, Suppliers,
--         Employees, Shippers, Order Details
-- Records: 830 orders | 93 customers | 77 products | 9 employees
-- ============================================================


-- ============================================================
-- LEVEL 1 — SELECT + FROM + WHERE + IS NULL
-- ============================================================

-- 01.
-- Show a table with all categories and their descriptions [8 rows].
SELECT CategoryName, Description
FROM Categories;


-- 02.
-- Show contact names, customer IDs, and company names for all customers from London [6 rows].
SELECT ContactName, CustomerID, CompanyName
FROM Customers
WHERE City = 'London';


-- 03.
-- Show all available columns for suppliers that have a FAX number [13 rows].
SELECT *
FROM Suppliers
WHERE Fax IS NOT NULL;


-- 04.
-- Count the total number of orders placed in 1997 [Result: 408].
SELECT COUNT(*) AS Total_Orders_1997
FROM Orders
WHERE OrderDate LIKE '1997%';


-- 05.
-- Show all contacts who are business owners from Mexico, Norway and Germany [5 rows].
SELECT ContactName, ContactTitle, Country
FROM Customers
WHERE ContactTitle = 'Owner'
AND Country IN ('Mexico', 'Norway', 'Germany');


-- 06.
-- Show the list of discontinued products [8 rows].
SELECT ProductName, UnitPrice, Discontinued
FROM Products
WHERE Discontinued = '1';


-- 07.
-- Show categories that start with 'Co' [2 rows].
SELECT CategoryName
FROM Categories
WHERE CategoryName LIKE 'Co%';


-- 08.
-- Show company names, cities, countries and postal codes of suppliers
-- whose address contains the word 'rue', ordered alphabetically by company name [5 rows].
SELECT CompanyName, City, Country, PostalCode
FROM Suppliers
WHERE Address LIKE '%rue%'
ORDER BY CompanyName ASC;


-- 09.
-- Show the top 10 order IDs along with their total units sold [10 rows].
SELECT OrderID, SUM(Quantity) AS Total_Units
FROM 'Order Details'
GROUP BY OrderID
ORDER BY SUM(Quantity) DESC
LIMIT 10;


-- 10.
-- Show the list of products within the 'Condiments' category [12 rows].
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Condiments';


-- ============================================================
-- LEVEL 2 — JOINS + LEFT JOIN + DATE FUNCTIONS
-- ============================================================

-- 11.
-- Show all employees who were 40 years old or older at the time of hiring [3 rows].
SELECT FirstName || ' ' || LastName AS FullName,
       BirthDate,
       HireDate
FROM Employees
WHERE date(BirthDate, '+40 years') <= date(HireDate);


-- 12.
-- Show products with total units in stock greater than 100.
-- Name the total field 'TotalUnits' [10 rows].
SELECT ProductName, UnitsInStock AS TotalUnits
FROM Products
WHERE UnitsInStock > 100;


-- 13.
-- Show contact names and addresses of customers whose orders were shipped via 'Speedy Express' [249 rows].
SELECT c.ContactName, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Shippers sh ON o.ShipVia = sh.ShipperID
WHERE sh.CompanyName = 'Speedy Express';


-- 14.
-- Show the list of customers who have never placed an order [4 rows].
SELECT c.ContactName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- 15.
-- Show employees and customers involved in orders shipped to Brussels via 'Speedy Express' [2 rows].
SELECT DISTINCT e.FirstName, e.LastName, c.ContactName
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Shippers sh ON o.ShipVia = sh.ShipperID
WHERE o.ShipCity = 'Bruxelles'
AND sh.CompanyName = 'Speedy Express';


-- 16.
-- Show the job title and full name of employees who sold at least one unit of 'Queso Cabrales' or 'Tofu' [9 rows].
SELECT DISTINCT e.Title, e.FirstName || ' ' || e.LastName AS FullName
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName IN ('Queso Cabrales', 'Tofu');


-- 17.
-- Show employees' full names and their manager's last name.
-- Include employees with no manager (NULL values) [9 rows].
SELECT e.FirstName || ' ' || e.LastName AS FullName,
       m.LastName AS ManagerLastName
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID;


-- 18.
-- Show distinct contact names, product names and supplier company names
-- for customers from London who bought products from 'Karkki Oy' or 'Pavlova, Ltd.' [9 rows].
SELECT DISTINCT c.ContactName, p.ProductName, s.CompanyName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE c.City = 'London'
AND s.CompanyName IN ('Karkki Oy', 'Pavlova, Ltd.');


-- 19.
-- Show distinct product names from orders where the customer or employee involved is from London [76 rows].
SELECT DISTINCT p.ProductName
FROM Products p
JOIN 'Order Details' od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.City = 'London' OR e.City = 'London';


-- 20.
-- Show all customers who have purchased products with a unit price below 3 [26 rows].
SELECT DISTINCT c.ContactName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.UnitPrice < 3;


-- ============================================================
-- LEVEL 3 — SUBQUERIES + SELF JOIN + ADVANCED FILTERS
-- ============================================================

-- 21.
-- Show full names of employees who have worked longer than any employee based in London [4 rows].
SELECT FirstName || ' ' || LastName AS FullName
FROM Employees
WHERE date(HireDate) < (
    SELECT MIN(date(HireDate))
    FROM Employees
    WHERE City = 'London'
);


-- 22.
-- Show full names and city of employees who have sold to customers in the same city [6 rows].
SELECT DISTINCT e.FirstName || ' ' || e.LastName AS FullName, e.City
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE e.City = c.City;


-- 23.
-- Show the average unit price per product category [8 rows].
SELECT c.CategoryName, AVG(p.UnitPrice) AS AvgPrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;


-- 24.
-- Show supplier company names that provide more than 4 products [2 rows].
SELECT s.CompanyName, COUNT(*) AS TotalProductos
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
HAVING COUNT(*) > 4;


-- 25.
-- Show employee IDs, full names, and the count of distinct products sold.
-- Order by employee ID ascending [9 rows].
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS FullName,
       COUNT(DISTINCT od.ProductID) AS TotalProducts
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID
ORDER BY e.EmployeeID ASC;


-- 26.
-- Show employee IDs, full names, and total revenue generated by each.
-- Order by employee ID ascending [9 rows].
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS FullName,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID
ORDER BY e.EmployeeID ASC;


-- ============================================================
-- LEVEL 4 — RANKING + TOP N + BUSINESS ANALYSIS
-- ============================================================

-- 27.
-- Show the top 5 shipping cities by total revenue [5 rows].
SELECT o.ShipCity,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY o.ShipCity
ORDER BY TotalSales DESC
LIMIT 5;


-- 28.
-- Show the top 5 products by total units sold [5 rows].
SELECT p.ProductName, SUM(od.Quantity) AS TotalUnits
FROM Products p
JOIN 'Order Details' od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalUnits DESC
LIMIT 5;


-- 29.
-- Show distinct customers who have purchased products in the 'Beverages' category [83 rows].
SELECT DISTINCT c.ContactName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories ca ON p.CategoryID = ca.CategoryID
WHERE ca.CategoryName = 'Beverages';


-- 30.
-- Show a ranking of suppliers by number of distinct products sold [29 rows].
SELECT s.CompanyName, COUNT(DISTINCT od.ProductID) AS TotalProductos
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN 'Order Details' od ON p.ProductID = od.ProductID
GROUP BY s.CompanyName
ORDER BY TotalProductos DESC;


-- ============================================================
-- LEVEL 5 — DATE ANALYSIS + BUSINESS QUESTIONS
-- ============================================================

-- 31.
-- How many orders were placed in June 1997?
SELECT COUNT(*) AS TotalOrdenes
FROM Orders
WHERE strftime('%Y-%m', OrderDate) = '1997-06';


-- 32.
-- Which day had the highest number of orders in 1998?
SELECT OrderDate, COUNT(*) AS TotalOrdenes
FROM Orders
WHERE strftime('%Y', OrderDate) = '1998'
GROUP BY OrderDate
ORDER BY TotalOrdenes DESC
LIMIT 1;


-- 33.
-- Which employee generated the highest total revenue?
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS FullName,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalVentas
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID
ORDER BY TotalVentas DESC
LIMIT 1;


-- 34.
-- Which shipping country generated the most freight revenue?
SELECT ShipCountry, SUM(Freight) AS TotalFlete
FROM Orders
GROUP BY ShipCountry
ORDER BY TotalFlete DESC
LIMIT 1;


-- ============================================================
-- LEVEL 6 — TIME SERIES + CASE + VISUALIZATIONS
-- ============================================================

-- 35.
-- Calculate total sales by year.
-- Present in tabular format and column chart.
SELECT strftime('%Y', o.OrderDate) AS Year,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
GROUP BY Year
ORDER BY Year ASC;


-- 36.
-- Calculate total sales by month for 1997.
-- Present in tabular format and line chart.
SELECT strftime('%m', o.OrderDate) AS Month,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
WHERE strftime('%Y', o.OrderDate) = '1997'
GROUP BY Month
ORDER BY Month ASC;


-- 37.
-- Calculate total sales by year for the 'Condiments' category.
-- Present in tabular format and bar chart.
SELECT strftime('%Y', o.OrderDate) AS Year,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories ca ON p.CategoryID = ca.CategoryID
WHERE ca.CategoryName = 'Condiments'
GROUP BY Year
ORDER BY Year ASC;


-- 38.
-- Show how many orders were shipped by each carrier: Speedy Express,
-- United Package y Federal Shipping.
-- Present in tabular format and pie chart.
SELECT sh.CompanyName, COUNT(*) AS TotalPedidos
FROM Shippers sh
JOIN Orders o ON sh.ShipperID = o.ShipVia
GROUP BY sh.CompanyName
ORDER BY TotalPedidos DESC;


-- 39.
-- Show monthly revenue for 1997 comparing the categories
-- 'Beverages' y 'Confections'. Cada fila debe representar un mes,
-- each row represents a month, each column a category.
-- Present in tabular format and line chart.
SELECT strftime('%m', o.OrderDate) AS Month,
       SUM(CASE WHEN ca.CategoryName = 'Beverages'
           THEN od.UnitPrice * od.Quantity * (1 - od.Discount)
           ELSE 0 END) AS Beverages,
       SUM(CASE WHEN ca.CategoryName = 'Confections'
           THEN od.UnitPrice * od.Quantity * (1 - od.Discount)
           ELSE 0 END) AS Confections
FROM Orders o
JOIN 'Order Details' od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories ca ON p.CategoryID = ca.CategoryID
WHERE strftime('%Y', o.OrderDate) = '1997'
AND ca.CategoryName IN ('Beverages', 'Confections')
GROUP BY Month
ORDER BY Month ASC;


-- ============================================================
-- END OF NORTHWIND ANALYSIS
-- Eleazar Soto | github.com/eleazarsoto
-- ============================================================
