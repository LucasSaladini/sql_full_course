USE SalesDB

/* Create report showing total sales for each of the following categories:
   High (sales over 50), Medium (sales 21-50), and Low (sales 20 or less)
   Sort the categories from highest sales to lowest */
SELECT
  Category,
  SUM(SALES) AS TotalSales
FROM (
  SELECT
    OrderID,
    Sales,
    CASE
      WHEN Sales > 50 THEN 'High'
      WHEN Sales > 20 THEN 'Medium'
      ELSE 'Low'
    END AS Category
  FROM Sales.Orders;
) t
GROUP BY Category
ORDER BY DESC;

-- Retrieve employee details with gender displayed as full text
SELECT
  EmployeeID,
  FirstName,
  LastName,
  Gender,
  CASE
    WHEN Gender = 'F' THEN 'Female'
    WHEN Gender = 'M' THEN 'Male'
    ELSE 'Not Available'
  END AS GenderFullText
FROM Sales.Employees;

-- Retrieve customer details with abbreviated country code
SELECT
  CustomerID,
  FirstName,
  LastName,
  Country,
  CASE
    WHEN Country = 'Germany' THEN 'DE'
    WHEN Country = 'USA'     THEN 'US'
    ELSE 'n/a'
  END AS CountryAbbr
FROM Sales.Customers;

SELECT DISTINCT Country
FROM Sales.Customers;

SELECT
  CustomerID,
  FirstName,
  LastName,
  Country,
  CASE Country
    WHEN 'Germany' THEN 'DE'
    WHEN 'USA'     THEN 'US'
    ELSE 'n/a'
  END AS CountryAbbr
FROM Sales.Customers;

-- Find the average scores of customers and treat Nulls as 0 (zero)
-- And additionally provide details such as CustomerID & LastName
SELECT
  CustomerID,
  LastName,
  Score,
   CASE
      WHEN Score IS NULL THEN 0
      ELSE Score
   END ScoreClean,
   AVG(CASE
         WHEN Score IS NULL THEN 0
         ELSE Score
      END) OVER() AvgCustomerClean,
  AVG(Score) OVER () AS AvgCustomer
FROM Sales.Customers;

