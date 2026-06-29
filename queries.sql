-- ============================================
-- NORTHWIND DATABASE ANALYSIS
-- Eleazar Soto | Data Analytics Portfolio
-- ============================================

-- ============================================
-- 1. SELECT + FROM
-- ============================================

-- Categories and descriptions
SELECT CategoryName, Description
FROM Categories;

-- Products with price
SELECT ProductName, UnitPrice
FROM Products;

-- Employees full info
SELECT FirstName, LastName, Title, City
FROM Employees;

-- ============================================
-- 2. WHERE
-- ============================================

-- Customers from London
SELECT ContactName, CustomerID, CompanyName
FROM Customers
WHERE City = 'London';

-- Products over $20
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 20;

-- Owners from Mexico, Norway and Germany
SELECT ContactName, ContactTitle, Country
FROM Customers
WHERE ContactTitle = 'Owner'
AND Country IN ('Mexico', 'Norway', 'Germany');

-- ============================================
-- 3. IS NULL / IS NOT NULL
-- ============================================

-- Suppliers with FAX
SELECT *
FROM Suppliers
WHERE Fax IS NOT NULL;

-- Customers without region
SELECT CompanyName, Region
FROM Customers
WHERE Region IS NULL;

-- ============================================
-- 4. COUNT
-- ============================================

-- Total orders in 1997
SELECT COUNT(*) AS Total_Orders_1997
FROM Orders
WHERE OrderDate LIKE '1997%';

-- Customers by country
SELECT Country, COUNT(*) AS Total
FROM Customers
GROUP BY Country
ORDER BY COUNT(*) DESC;

-- ============================================
-- 5. ORDER BY
-- ============================================

-- Most expensive products
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC;

-- Employees alphabetically
SELECT FirstName, LastName
FROM Employees
ORDER BY LastName ASC;

-- ============================================
-- 6. GROUP BY + HAVING
-- ============================================

-- Top 10 orders by total units
SELECT OrderID, SUM(Quantity) AS Total_Units
FROM 'Order Details'
GROUP BY OrderID
ORDER BY SUM(Quantity) DESC
LIMIT 10;

-- Categories with more than 10 products
SELECT CategoryID, COUNT(*) AS Total
FROM Products
GROUP BY CategoryID
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

-- Price stats by category
SELECT CategoryID,
       MAX(UnitPrice) AS Max_Price,
       MIN(UnitPrice) AS Min_Price,
       AVG(UnitPrice) AS Avg_Price
FROM Products
GROUP BY CategoryID
ORDER BY AVG(UnitPrice) DESC;

-- ============================================
-- 7. JOIN
-- ============================================

-- Products with category name
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

-- Products from Condiments category
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Condiments';

-- Customers and their orders
SELECT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Orders shipped by Speedy Express
SELECT c.ContactName, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Speedy Express';

-- Employees and total orders processed
SELECT e.FirstName, e.LastName, COUNT(*) AS Total_Orders
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY COUNT(*) DESC;

-- Customers with more than 10 orders
SELECT c.ContactName, COUNT(*) AS Total_Orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

-- Products with category, supplier and price over $50
SELECT p.ProductName, ca.CategoryName, s.CompanyName, p.UnitPrice
FROM Products p
JOIN Categories ca ON p.CategoryID = ca.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitPrice > 50;

-- Employees hired at 40+ years old
SELECT FirstName || ' ' || LastName AS FullName,
       BirthDate,
       HireDate
FROM Employees
WHERE date(BirthDate, '+40 years') <= date(HireDate);

-- ============================================
-- 8. LEFT JOIN
-- ============================================

-- All customers and their orders
SELECT c.ContactName, COUNT(*)
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

-- All categories and their products
SELECT ca.CategoryName, COUNT(*)
FROM Categories ca
LEFT JOIN Products p ON ca.CategoryID = p.CategoryID
GROUP BY ca.CategoryName;

-- All employees and orders processed
SELECT e.FirstName, e.LastName, COUNT(*)
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY COUNT(*) DESC;

-- All suppliers and their products
SELECT s.CompanyName, COUNT(*)
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
ORDER BY COUNT(*) DESC;

-- Customers with NO orders
SELECT c.ContactName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- ============================================
-- 9. CASE
-- ============================================

-- Products by price range
SELECT ProductName, UnitPrice,
CASE
    WHEN UnitPrice < 10 THEN 'Cheap'
    WHEN UnitPrice BETWEEN 10 AND 50 THEN 'Medium'
    WHEN UnitPrice > 50 THEN 'Expensive'
END AS PriceRange
FROM Products;

-- Customers classified by total orders
SELECT c.ContactName,
CASE
    WHEN COUNT(*) > 20 THEN 'VIP'
    WHEN COUNT(*) BETWEEN 5 AND 10 THEN 'Regular'
    ELSE 'New'
END AS CustomerType
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

-- Products by stock status
SELECT ProductName, UnitsInStock,
CASE
    WHEN UnitsInStock = 0 THEN 'Out of stock'
    WHEN UnitsInStock BETWEEN 1 AND 10 THEN 'Low stock'
    ELSE 'In stock'
END AS StockStatus
FROM Products;

-- Employees classified by performance
SELECT e.FirstName, e.LastName,
CASE
    WHEN COUNT(*) > 100 THEN 'Top Performer'
    WHEN COUNT(*) BETWEEN 50 AND 100 THEN 'Good'
    ELSE 'Average'
END AS Performance
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName;
