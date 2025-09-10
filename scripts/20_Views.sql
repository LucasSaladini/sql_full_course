-- Find the running total of sales for each month
WITH CTE_Monthly_Summary AS (
  SELECT
    DATETRUNC(month, OrderDate) OrderMonth,
    SUM(Sales) TotalSales,
    COUNT(OrderID) TotalOrders,
    SUM(Quantity) TotalQuantities
  FROM Sales.Orders
  GROUP BY DATETRUNC(month, OrderDate)
)
SELECT
  OrderMonth,
  TotalSales,
  SUM(TotalSales) OVER (ORDER BY OrderMonth ASC) AS RunningTotal
FROM CTE_Monthly_Summary
-- View
CREATE VIEW V_Monthly_Summary AS
(
    SELECT
      DATETRUNC(month, OrderDate) OrderMonth,
      SUM(Sales) TotalSales,
      COUNT(OrderID) TotalOrders,
      SUM(Quantity) TotalQuantities
    FROM Sales.Orders
    GROUP BY DATETRUNC(month, OrderDate)
  )
-- Using view
SELECT
  OrderMonth,
  TotalSales,
  SUM(TotalSales) OVER (ORDER BY OrderMonth ASC) AS RunningTotal
FROM V_Monthly_Summary
