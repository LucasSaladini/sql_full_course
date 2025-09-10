-- Step 1: Find the total sales per customer
WITH CTE_Total_Sales AS
(
  SELECT
    CustomerID,
    SUM(Sales) AS TotalSales
  FROM Sales.Orders
  GROUP BY CustomerID
)
-- Main Query
SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  cts.StotalSales
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
  ON cts.CustomerID = c.CustomerID
