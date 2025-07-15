USE SalesDB

-- Find the average scores for the customers
SELECT
  CustomerID,
  Score,
  COALESCE(Score, 0) AS Score2,
  AVG(Score) OVER () AvgScores,
  AVG(COALESCE(Score, 0)) OVER () AvgScores2
FROM Sales.Customers;

-- Display the full name of customers in a single field
-- by merging their first and last names,
-- and add 10 bonus points to each customer's score
SELECT
  CustomerID,
  FirstName,
  LastName,
  FirstName + ' ' + COALESCE(LastName, '') AS FullName,
  Score,
  COALESCE(Score, 0) + 10 As ScoreWithBonus
FROM Sales.Customers;

-- Sort the customers from the lowest to hihgest socres, witth NULLS appearing last
SELECT
  CustomerID,
  Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag, Score ASC;

-- Find the sales price for each order by dividing sales by quantity
SELECT
  OrderID,
  Sales,
  Quantity,
  Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders;

-- Identify the customers who have no scores
SELECT
  *
FROM Sales.Customers
WHERE Score IS NULL;

-- List all customers who have scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NOT NULL;

-- List all details for customers who have not placed any orders
SELECT
  c.*,
  o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

WITH Orders AS (
  SELECT 1, Id, 'A', Category UNION
  SELECT 2, NULL UNION
  SELECT 3, '' UNION
  SELECT 4, ' '
)
SELECT
  *,
  DATALENGGTH(Category) AS CategoryLength,
  DATALENGTH(TRIM(Category)) AS Policy1,
  NULLIF(TRIM(Category), '') AS Policy2,
  COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;
