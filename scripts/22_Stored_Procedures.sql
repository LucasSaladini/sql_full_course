-- Setp 1: Write a query
-- for US customers find the total number of customers and the average score
SELECT
  COUNT(*) TotalCustomers,
  AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'

-- Step 2: turning the query into a stored procedure
CREATE PROCEDURE  GetCustomerSummary AS
BEGIN
  SELECT
    COUNT(*) TotalCustomers,
    AVG(Score) AvgScore
  FROM Sales.Customers
  WHERE Country = 'USA'
END

-- Step 3: Execute the stored procedure
EXEC GetCustomerSummary

-- For German customers find the total number of customers and the average score
ALTER PROCEDURE GetCustomerSummaryGermany AS
BEGIN
  SELECT
    COUNT(*) TotalCustomers,
    AVG(Score) AvgScore
  FROM Sales.Customers
  WHERE Country = 'Germany'
END

EXEC GetCustomerSummaryGermany

--Define stored procedure
CREATE PROCEDURE  GetCustomerSummary @Country NVARCHAR(50) AS
BEGIN
  SELECT
    COUNT(*) TotalCustomers,
    AVG(Score) AvgScore
  FROM Sales.Customers
  WHERE Country = @Country
END

-- Execute the stored procedure
EXEC GetCustomerSummary @Country = 'Germany'

EXEC GetCustomerSummary @Country = 'USA'

DROP PROCEDURE GetCustomerSummaryGermany
