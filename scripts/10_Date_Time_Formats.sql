USE SalesDB

SELECT
  OrderID,
  CreationTime,
  FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
  FORMAT(CreationTime, 'dd-MM-yyyy') EURO_Format,
  FORMAT(CreationTime, 'dd') dd,
  FORMAT(CreationTime 'ddd') ddd,
  FORMAT(CreationTime 'dddd') dddd,
  FORMAT(CreationTime, 'MM') MM,
  FORMAT(CreationTime, 'MMM') MMM,
  FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders;

-- Show CreationTime using the following format: Day Wed Jan Q1 2025 12:34:56 PM
SELECT
  OrderID,
  CreationTime,
  'Day ' + FORMAT(CreationTime, 'ddd MMM') +
  ' Q' + DATENAME(quarter, CreationTime) + ' ' +
  FORMAT(CRreationTime, 'yyyy hh:mm:ss tt') AS CustomFormat
FROM Sales.Orders;

SELECT
  FORMAT(OrderDate, 'MMM yy') AS OrderDate,
  COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy');

SELECT
  CONVERT(INT, '123') AS [String to Int CONVERT],
  CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
  CreationTime,
  CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
  CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style: 32],
  CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style: 34]
FROM Sales.Orders;

SELECT
  CAST('123' AS INT) AS [String to Int],
  CAST(123 AS VARCHAR) AS [Int to String],
  CAST('2025-08-20' AS DATE) AS [String to Date],
  CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
  CreationTime,
  CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Order;

SELECT
  OrderID,
  OrderDate,
  DATEADD(year, 2, OrderDate) AS TwoYearsLater,
  DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
  DATEADD(day, -10, OrderDate) AS TenDaysBefore
FROM Sales.Orders;

-- Calculate the age of employees
SELECT
  EmployeeId,
  BirthDate,
  DATEDIFF(year, BirthDate, GETDATE()) AS Age
FROM Sales.Employees;

-- Find the average shipping duration in days for each moth
SELECT
  MONTH(OrderDate),
  ShipDate,
  AVG(DATEDIFF(day, OrderDate, ShippingDate)) AS AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

-- Find the number of days between each order and previous order
SELECT
  OrderId,
  OrderDate AS CurrentOrderDate,
  LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate.
  DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS NrOfDays
FROM Sales.Orders;

SELECT 
  ISDATE('123') AS DateCheck1,
  ISDATE('2025-08-20') AS DateCheck2,
  ISDATE('20-08-2025') AS DateCheck3,
  ISDATE('2025') AS DateCheck4,
  ISDATE('08') AS DateCheck5;

SELECT
  OrderDate,
  ISDATE(OrderDate),
  CASE WHEN ISDATE(OrdderDate) = 1 THEN CAST(OrderDate AS DATE)
       ELSE '9999-01-01'
  END NewOrderDate
FROM
(
  SELECT '2025-08-20' AS OrderDate UNION
  SELECT '2025-08-21' UNION
  SELECT '2025-08-23' UNION
  SELECT '2025-08'
) AS t
