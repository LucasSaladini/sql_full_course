-- Find the products that have a price higher than the average price of all products
--Main query
SELECT
  *
FROM (
  --Subquery
  SELECT
    ProductID,
    Price,
    AVG(Price) OVER () AvgPrice
  FROM Sales.Products)t
WHERE price > AvgPrice

-- Rank customers based on their total amount of sales
-- Main query
SELECT
  *,
  RANK() OVER (ORDER BY TotalSales DESC) CustomerRank
FROM 
  -- Subquery
  (SELECT
    CustomerID,
    SUM(Sales) TotalSales
  FROM Sales.Orders
  GROUP BY CustomerID)t

