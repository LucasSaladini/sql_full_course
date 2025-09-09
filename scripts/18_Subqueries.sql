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

-- Show the products IDs, product names, prices, and the total number of orders (Scalar subquery)
SELECT
 ProductID,
 Product,
 Price,
 (SELECT COUNT(*) TotalOrders FROM Sales.Orders) AS TotalOrders
FROM Sales.Products

-- Show all customer details and find the total orders for each customer
SELECT
 c.*,
 o.TotalOrders
FROM Sales.Customers c
LEFT JOIN (
 SELECT
  CustomerID
  COUNT(*) TotalOrders
 FROM Sales.Orders
 GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID
