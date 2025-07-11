SELECT
  FirstName,
  LastName
FROM Sales.Customers

UNION

SELECT
  FirstName,
  LastName
FROM Sales.Emplayees

-- Combine the data from employees and customers into one table
SELECT
  FirstName,
  LastName
FROM Sales.Employees
UNION
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

-- Combine the data from employees and customers into one table, including duplicates
SELECT
  FirstName,
  LastName
FROM Sales.Employees
UNION ALL
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

-- Find employees who are not customers at the same time
SELECT
  FirstName,
  LastName
FROM Sales.Employees
EXCEPT
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

-- Find employees who are also customers
SELECT
  FirstName,
  LastName
FROM Sales.Employees
INTERSECT
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

-- Orders are sotred in separate tables (Orders and OrdersArchive)
-- Combine all order into one report without duplicates
SELECT
  'Orders' AS SourceTable,
  OrderID,
  ProductID,
  CustomerID,
  SalesPersonID,
  OrderDate,
  ShipDate,
  OrderStatus,
  ShippingStatus,
  BillAddress,
  Quantity,
  Sales,
  CreationTime
FROM Sales.Orders
UNION
SELECT
  'OrdersAchive' AS SourceTable,
  OrderID,
  ProductID,
  CustomerID,
  SalesPersonID,
  OrderDate,
  ShipDate,
  OrderStatus,
  ShippingStatus,
  BillAddress,
  Quantity,
  Sales,
  CreationTime
FROM Sales.OrdersArchive
ORDER BY OrderID;
