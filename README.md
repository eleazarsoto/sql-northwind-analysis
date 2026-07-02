# Northwind Database — SQL Analysis

**Author:** Eleazar Soto
**Portfolio:** [github.com/eleazarsoto](https://github.com/eleazarsoto)
**Tools:** SQL · SQLite · SQLiteViz · Google Sheets

---

## Overview

Business analysis of the Northwind database using SQL queries.
39 queries covering sales performance, customer behavior, employee productivity,
product analysis, and time series reporting.

---

## Database

| Detail | Value |
|--------|-------|
| Engine | SQLite |
| Orders | 830 |
| Customers | 93 |
| Products | 77 |
| Employees | 9 |
| Suppliers | 29 |
| Categories | 8 |

**Tables:** Customers · Orders · Products · Categories · Suppliers · Employees · Shippers · Order Details

---

## Table Relationships

```
Customers ──── Orders ──── Shippers
               Orders ──── Order Details ──── Products ──── Categories
               Orders ──── Employees                    └──── Suppliers
Employees ──── Employees (Self JOIN — manager hierarchy)
```

---

## SQL Concepts Applied

| Level | Concepts | Queries |
|-------|----------|---------|
| 1 | SELECT, FROM, WHERE, IS NULL, LIKE, IN, BETWEEN | 01 – 10 |
| 2 | INNER JOIN (2–5 tables), LEFT JOIN, Date Functions | 11 – 20 |
| 3 | Subqueries, Self JOIN, Advanced Filters | 21 – 26 |
| 4 | Ranking, TOP N, Business Aggregations | 27 – 30 |
| 5 | Date Analysis, Business Questions | 31 – 34 |
| 6 | Time Series, CASE Statements, Visualizations | 35 – 39 |

**Additional:** `GROUP BY` · `HAVING` · `DISTINCT` · `COUNT` · `SUM` · `AVG` · `MAX` · `MIN`
`strftime()` · `date()` · `JULIANDAY()` · `CURRENT_DATE` · String concatenation with `||`

---

## Key Findings

| Finding | Value |
|---------|-------|
| Top employee by revenue | Margaret Peacock — $232,890 |
| Top employee by orders processed | Margaret Peacock — 156 orders |
| Top customer by order count | Jose Pavarotti — 31 orders |
| Top shipping city by revenue | Cunewalde — $110,277 |
| Best-selling product by units | Camembert Pierrot — 1,577 units |
| Most expensive product | Côte de Blaye — $263.50 |
| Largest product category | Confections — 13 products |
| Customers who never ordered | 4 customers |
| Top freight revenue country | USA |
| Orders via Speedy Express | 249 orders |

---

## Project Structure

```
sql-northwind-analysis/
├── README.md                      — Project documentation
├── northwind_queries.sql          — All 39 SQL queries
├── northwind.db                   — SQLite database
└── SQL_Reference_Guide.pdf        — Complete SQL reference guide
```

---

## How to Run

1. Download `northwind.db`
2. Open [SQLiteViz](https://sqliteviz.com) or any SQLite client
3. Load the database
4. Run any query from `northwind_queries.sql`

---

## Related Projects

| Project | Description |
|---------|-------------|
| [HR Attrition Analysis](https://github.com/eleazarsoto/google-sheets-hr-attrition) | IBM dataset — 1,470 employee records |
| [Bike Shop Sales Analysis](https://github.com/eleazarsoto/google-sheets-bike-shop) | Multi-table retail dataset — 1,615 orders |
| [Uber Rides Analysis](https://github.com/eleazarsoto/google-sheets-uber-analysis) | Large-scale operational data — 150,000 records |

---

*Part of my [Data Analytics Portfolio](https://github.com/eleazarsoto/data-analytics-portfolio)*
