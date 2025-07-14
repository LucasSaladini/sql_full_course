USE SalesDB

SELECT
  OrderID,
  CreationTime,
  '2025-08-20' AS HardCoded,
  GETDATE() AS Today
FROM Sales.Orders;

SELECT
  OrderID,
  CreationTime,
  YEAR(CreationTime) AS YEAR,
  MONTH(CreationTime) AS MONTH,
  DAY(CreationTime) AS DAY
FROM Sales.Orders;

SELECT
  OrderID,
  CreationTime,
  --DATETRUNC
  DATETRUNC(year, CreationDate) AS Year_dt,
  DATETRNC(day, CreationDate) AS Day_dt,
  DATETRNC(minute, CreationDate) AS Minute_dt,
  --DATENAME
  DATENAME(month, CreationTime) AS Month_dn,
  DATENAME(weekday, CreationTime) AS Weekday_dn,
  DATENAME(day, CreationTime) AS day_dn,
  DATENAME(year, CreationTime) AS year_dn,
  --DATEPART
  DATEPART(year, CreationTime) AS Year_dp,
  DATEPART(month, CreationTime) AS Month_dp,
  DATEPART(day, CreationTime) AS Day_dp,
  DATEPART(hour, CreationTime) AS Hour_dp,
  DATEPART(quarter, CreationTime) AS Quarter_dp,
  DEPART(wekk, CreationDate) AS Week_dp,
  YEAR(CreationTime) AS YEAR,
  MONTH(CreationTime) AS MONTH,
  DAY(CreationTime) AS DAY
FROM Sales.Orders;

SELECT
  DATETRNC(month, CreationTime) Creation,
  COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime);

SELECT
  OrderID,
  CreationTime,
  EOMONTH(CreationTime) AS EndOfMonth,
  CAST(DATETRUNC(month, CreationTime), AS DATE) AS StartOfMonth
FROM Sales.Orders;

-- How many orders were placed each year?
SELECT
  YEAR(OrderDate),
  COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);

-- How many orders were placed each month?
SELECT
  DATENAME(month, OrderDate),
  COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate);

-- Show all orders that were placed during the month of Frebuary
SELECT
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2;
