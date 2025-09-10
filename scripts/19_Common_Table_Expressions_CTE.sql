--#1 Step: Find the total sales per customer
WITH CTE_Total_Sales AS
(
  SELECT
    CustomerID,
    SUM(Sales) AS TotalSales
  FROM Sales.Orders
  GROUP BY CustomerID
)
--#2 Step: Find the last order date per customer
, CTE_Last_Order AS
(
  SELECT
    CustomerID,
    MAX(OrderDate) AS Last_Order
  FROM Sales.Orders
  GROUP BY CustomerID
)
--#3 Step: Rank customers based on yotal sales per customer
, CTE_Customer_Rank AS
(
  SELECT
    CustomerID,
    TotalSales,
  RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
  FROM CTE_Total_Sales
)
--#4 Step: Segment customers based on their sales
, CTE_Customer_Segment AS
(
  SELECT
    CustomerID,
    TotalSales,
    CASE WHEN TotalSales > 100 THEN 'High'
         WHEN TotalSales > 50 THEN 'Medium'
         ELSE 'Low'
    END CustomerSegments
  FROM CTE_Total_Sales
)
-- Main Query
SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  cts.StotalSales,
  clo.Last_Order,
  ccr.CustomerRank
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
  ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
  clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
  ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
  ON ccs.CustomerID = c.CustomerID

-- Generate a sequence of numbers from 1 to 20
WITH Series AS (
  --Anchor Query
  SELECT
    1 AS MyNumber
  UNION ALL
  -- Recursive Query
  SELECT
    MyNumber + 1
  FROM Series
  WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM Series
OPTION (MAXRECURSION 20)
