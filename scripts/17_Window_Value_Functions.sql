-- Analyze the month-over-month performance by finding the percentage change
-- in sales between the current and previous months
SELECT 
  *,
  CurrentMonthSales - PreviousMonthSales AS MoM_Change,
  ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT) / PreviousMonthSales * 100, 1) MoM_Percentage
FROM(
  SELECT
    MONTH(OrderDate) OrderMonth,
    SUM(Sales) CurrentMonthSales,
    LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderMonth)) PreviousMonthSales
  FROM Sales.Orders
  GROUP BY MONTH(OrderDate)
)t

-- Analyze customer loyalty by ranking customers based on the average number of days between orders
SELECT
  CustomerID,
  AVG(DaysUntilNextOrder) AvgDays,
  RANK() OVER (ORDER BY COLESCE(AVG(DaysUntilNextOrder), 999999) ASC) RankAvg
FROM (
  SELECT
    OrderID,
    CustomerID,
    OrderDate CurrentOrder,
    LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
    DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
  FROM Sales.Orders
)t
GROUP BY
  CustomerID

-- Find the lowest and highest sales for each product
-- Find the difference in sales between the current and the lowest sales
SELECT
  OrderID,
  ProductID,
  Sales,
  FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales ASC) LowestSales,
  LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales ASC
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
  FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2,
  MIN(Sales) OVER (PARTITION BY ProductID) LowestSales2,
  MAX(Sales) OVER (PARTITION BY ProductID) HigghestSales3,
  Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY SALES) AS SalesDifference
FROM Sales.Orders
