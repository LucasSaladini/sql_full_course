-- Tip 1: Select Only What You Need
---- Bad Practice
SELECT * FROM Sales.Customers;

---- Good Practice
SELECT CustomerID, FirstName, LastName FROM Sales.Customers;

-- Tip 2: Avoid unnecessary DISTINCT & ORDER BY
---- Bad Practice
SELECT DISTINCT
  FirstName
FROM Sales.Customers
ORDER BY FirstName;

---- Good Practice
SELECT FirstName
FROM Sales.Customers;

-- Tip 3: For exploration purpose, limite the rows
---- Bad Practice
SELECT
  OrderID,
  Sales
FROM Sales.Orders;

---- Good Practice
SELECT TOP 10
  OrderID,
  Sales
FROM Sales.Orders;

-- Tip 4: Create nonclustered Index on frequently used columns in WHERE clause
SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus);

-- Tip 5: Avoid applying functions to columns in WHERE clauses
---- Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered';

SELECT * FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A';

SELECT * FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025;

---- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

SELECT * FROM Sales.Customers
WHERE FirstName LIKE 'A%';

SELECT * FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';

-- Tip 6: Avoid leading wildcards as they prevent index usage
---- Bad Practice
SELECT * FROM Sales.Customers
WHERE LastName LIKE '%Gold%';

---- Good Pratice
SELECT * FROM Sales.Customers
WHERE LastName LIKE 'Gold%';

-- Tip 7: Use IN instead of multiple OR
---- Bad Practice
SELECT * FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3;

---- Good Practice
SELECT * FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3);

-- Tip 8: Understand the speed of Joins & use INNER JOIN when possible
---- Best Performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

---- Sligghtly Slower Performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers c
RIGHT JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

---- Worst Performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers c
OUTER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

-- Tip 9: Use explicit Join (ANSI Join) instead of Implicit Join (non-ANSI Join)
---- Bad Practice
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID;

---- Good Practice
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

-- Tip 10: Make sure to Index the columns used in the ON clause
CREATE NONCLUSTERED INDEX IX_order_CustomerID ON Sales.Orders(CustomerID);
  
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Orders o
INNER JOIN Sales.Customers c
  ON c.CustomerID = o.CustomerID;

-- Tip 11: Filter Before Joining (Big Tables)
---- Best Practice For Small-Medium Tables
------ Filter After Join (WHERE)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

------ Filter During Join (ON)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
   AND o.OrderStatus = 'Delivered';

---- Best Practice For Big Tables
------ Filter Before Join (SUBQUERY)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN (
    SELECT OrderID, CustomerID
    FROM Sales.Orders
    WHERE OrderStatus = 'Delivered'
) AS o
    ON c.CustomerID = o.CustomerID;

-- Tip 12: Aggregate before joining (Big Tables)
---- Best Practice For Small-Medium Tables
------ Grouping and Joining
SELECT c.CustomerID, c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;

---- Best Practice For Big Tables
------ Pre-aggregated Subquery
SELECT c.CustomerID, c.FirstName, o.OrderCount
FROM Sales.Customers AS c
INNER JOIN (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Sales.Orders
    GROUP BY CustomerID
) AS o
    ON c.CustomerID = o.CustomerID;

---- Bad Practice
------ Correlated Subquery
SELECT 
    c.CustomerID, 
    c.FirstName,
    (SELECT COUNT(o.OrderID)
     FROM Sales.Orders AS o
     WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers AS c;

-- Tip 13: Use Union instead of OR in Joins
---- Bad Practice
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OR c.CustomerID = o.SalesPersonID;

---- Best Practice
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID
UNION
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.SalesPersonID;

-- Tip 14: Check for nested loops and use SQL Hints
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID;

---- Good practice for having big table & small table
SELECT
  o.OrderID,
  c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
  ON c.CustomerID = o.CustomerID
OPTION (HASH JOIN);

-- Tip 15: Use UNION ALL instead of using UNION if duplicates are acceptable or there are no duplicates
---- Bad Practice
SELECT
  CustomerID
FROM Sales.Orders
UNION
SELECT
  CustomerID
FROM sales.OrdersArchive;

---- Best Practice
SELECT
  CustomerID
FROM Sales.Orders
UNION ALL
SELECT
  CustomerID
FROM Sales.OrdersArchive;

-- Use UNION ALL + DISTINCT instead of using UNION if duplicates are not acceptable
---- Bad Practice
SELECT
  CustomerID
FROM Sales.Orders
UNION
SELECT
  CustomerID
FROM Sales.OrdersArchive;

---- Best Practice
SELECT DISTINCT CustomerID
FROM (
  SELECT
    CustomerID
  FROM Sales.Orders
  UNION ALL
  SELECT
    CustomerID
  FROM Sales.OrdersArchive
) AS CombinedData;

-- Tip 17: Use Columnstore Index for aggregations on large tables
CREATE CLUSTERED COLUMNSTORE INDEX Idx_Orders_Columnstore ON Sales.Orders;

SELECT
  CustomerID,
  COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID;

-- Tipo 18: Pre-Aggreggate data and store it in new table for reporting
SELECT
  MONTH(OrderDate) OrderYear,
  SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT
  OrderYear,
  TotalSales
FROM Sales.SalesSummary;

-- Tip 19: JOIN vs EXISTS vs IN (Avoid using IN)
---- JOIN (Best Practice: If the Performance equals to EXISTS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

---- EXISTS (Best Practice: Use it for Large Tables)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE EXISTS (
    SELECT 1
    FROM Sales.Customers AS c
    WHERE c.CustomerID = o.CustomerID
      AND c.Country = 'USA'
);

---- IN (Bad Practice)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customers
    WHERE Country = 'USA'
);

-- Tip 20: Avoid redundant logic in your query
---- Bad Practice
SELECT
  EmployeeID,
  FirstName,
  'Above Average' Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT
  EmployeeID,
  FirstName,
  'Below Average' Status
FROM Sales.Employees
WHERE Salary < (SELECT (AVG(Salary) FROM Sales.Employees);

---- Good Practice
SELECT
  EmployeeID,
  FirstName,
  CASE
    WHEN Salary > AVG(Salary) OVER() THEN 'Above Average'
    WHEN Salary < AVG(Salary) OVER() THEN 'Below Average'
  END AS Status
FROM Sales.Employees;

-- Tip 21: Avoid data types VARCHAR & TEXT
---- Before
CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(MAX),
  LastName TEXT,
  Country VARCHAR(255),
  TotalPurchases FLOAT,
  Score VARCHAR(255),
  BirthDate VARCHAR(255),
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

---- After
CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(MAX),
  LastName VARCHAR(50),
  Country VARCHAR(255),
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

-- Tip 22: Avoid using (MAX) unnecessarily large lengths in data types
---- Before
CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(MAX),
  LastName TEXT,
  Country VARCHAR(255),
  TotalPurchases FLOAT,
  Score VARCHAR(255),
  BirthDate VARCHAR(255),
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

---- After
CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Country VARCHAR(50),
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

-- Tip 23: Use the NOT NULL constraint where applicable
CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

-- Tip 24: Ensure all your tables have a clustered primary key
CREATE TABLE CustomersInfo (
  CustomerID INT PRIMARY KEY CLUSTERED,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

-- Tip 25: Create a non-clustered index for foreign keys that are used frequently
CREATE TABLE CustomersInfo (
  CustomerID INT PRIMARY KEY CLUSTERED,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
);

CREATE NONCLUSTERED INDEX IX_Good_Customers_EmployeeID ON CustomersInfo(EmployeeID);

-- Tip 26: Avoid over indexing
-- Tip 27: Drop unused indexes
-- Tip 28: Update statistics weekly
-- Tip 29: Reorganize & rebuild indexes weekly
--Tip 30: For large tables (e.g., fact tables), partition the data and then apply a columnstore index for best performance results
