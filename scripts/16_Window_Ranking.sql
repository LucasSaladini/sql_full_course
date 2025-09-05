-- Rank the orders based on their sales from highest to lowest
SELECT
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders;

SELECT
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER (ORDER BY Sales DESC) SalesRank_Row,
  RANK() OVER (ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders;

SELECT
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER (ORDER BY Sales DESC) SalesRank_Row,
  RANK() OVER (ORDER BY Sales DESC) SalesRank_Rank,
  DENSE_RANK() OVER (ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders;

-- Find the top highest sales for each product
SELECT *
FROM (
  SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProducts
  FROM Sales.Orders
)t WHERE RankByProduct = 1;

-- Find the lowest 2 customers based on their total sales
SELECT *
FROM (
  SELECT
    CustomerID,
    SUM(Sales) TotalSales,
    ROW_NUMBER() OVER (ORDER BY SUM(Sales) ASC) RankCustomers
  FROM Sales.Orders
  GROUP BY CustomerID
)t WHERE RankCustomers <= 2;

-- Assin unique IDs to the rows of the 'Orders Archive' table
SELECT
  ROW_NUMBER() OVER (ORDER BY OrderID, OrderDate) UniqueID, 
  *
FROM Sales.OrdersArchive;

-- Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates
SELECT *
FROM (
  SELECT
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
    *
  FROM Sales.OrdersArchive
)t WHERE rn = 1;

--N TILE
SELECT
  OrderID,
  Sales,
  NTILE(4) OVER (ORDER BY Sales DESC) FourBucket,
  NTILE(3) OVER (ORDER BY Sales DESC) ThreeBucket,
  NTILE(2) OVER (ORDER BY Sales DESC) TwoBucket,
  NTILE(1) OVER (ORDER BY Sales DESC) OneBucket
FROM Sales.Orders;

-- Segment all orders into 3 categories: high, medium and low sales
SELECT *,
  CASE WHEN Buckets = 1 THEN 'High'
       WHEN Buckets = 2 THEN 'Medium'
       WHEN Buckets = 3 THEN 'Low'
  END SalesSegmentations
FROM (
  SELECT
    OrderID,
    Sales,
    NTILE(3) OVER (ORDER BY Sales DESC) Buckets
  FROM Sales.Orders
)t

-- In order to export the data, divide the orders into 2 groups
SELECT
  NTILE(2) OVER (ORDER BY OrderID) Buckets,
  *
FROM Sales.Orders;

-- Find the products that fall within the highest 40% of prices
SELECT 
  *,
  CONCAT(DistRank * 100, '%') DistRankPercentage,
  CONCAT(DistRankPercent * 100, '%') DistRankPercentage2
FROM (
  SELECT
    Product,
    Price,
    CUM_DIST() OVER (ORDER BY Price DESC) DistRank,
    PERCENT_RANK() OVER (ORDER BY Price DESC) DistRankPercent
  FROM Sales.Products)t
WHERE DistRank <= 0.4;
