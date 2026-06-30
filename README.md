# 🗄️ SQL — Northwind Database Analysis
### SQL Project | Eleazar Soto

## 📋 Project Overview
Business analysis using SQL queries on the classic Northwind database.
Covering sales, customers, employees, products and suppliers.

## 📊 Database
- **Database:** Northwind (SQLite)
- **Tables:** Customers, Orders, Products, Categories, Suppliers, Employees, Shippers, Order Details
- **Records:** 830 orders, 93 customers, 77 products, 9 employees

## 🛠️ SQL Concepts Used
- SELECT, FROM, WHERE
- IS NULL / IS NOT NULL
- ORDER BY ASC/DESC
- GROUP BY, HAVING
- COUNT, SUM, AVG, MAX, MIN
- INNER JOIN (2 and 3 tables)
- LIKE, IN, BETWEEN
- Aliases and subqueries
- UNION — combining results from multiple queries

## 🔍 Key Queries

### Sales Analysis
- Top 10 orders by total units
- Total orders per customer
- Orders processed per employee

### Customer Analysis
- Customers by country
- Customers with most orders
- Contacts by city and title

### Product Analysis
- Products by category
- Discontinued products
- Price analysis by category

### Employee Analysis
- Orders processed per employee
- Employees hired at 40+ years old

## 💡 Key Findings
- **Margaret Peacock** processed the most orders (156)
- **Jose Pavarotti** placed the most orders as a customer (31)
- **Confections** is the largest category with 13 products
- **Côte de Blaye** is the most expensive product at $263.50
- **62.3%** of Speedy Express shipments completed on time

## 📁 Files
- `queries.sql` — All SQL queries used in this analysis
- `northwind.db` — SQLite database

---
*Part of my [Data Analytics Portfolio](https://github.com/eleazarsoto/data-analytics-portfolio)*
