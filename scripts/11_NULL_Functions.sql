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
