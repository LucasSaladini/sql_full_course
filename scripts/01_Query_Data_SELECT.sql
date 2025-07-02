USE MyDatabase
  
-- Retrieve All Customer Data
SELECT * 
FROM customers;

-- Retrieve All Order Data
SELECT * 
FROM orders;

-- Retrieve each customer's name, country and score
SELECT 
  first_name, 
  country, 
  score 
FROM customers;

-- Retrieve customers with a score not equal to 0 (zero)
SELECT *
FROM customers
WHERE score != 0;

-- Retrieve customers from Germany
SELECT 
  first_name,
  country
FROM customers
WHERE country = 'Germany';

-- Retrieve all customers and sort the results by the highest score first
SELECT *
FROM customers
ORDER BY score DESC;

-- Retrieve all customers and sort the results by the lowest score first
SELECT *
FROM customers
ORDER BY score ASC;

-- Retrieve all customers and sort the results by the country and then by the highest score
SELECT *
FROM customers
ORDER BY country ASC , score DESC;

-- Find the total score for each country
SELECT
  country,
  SUM(score) AS total_score
FROM customers
GROUP BY country;

-- Find the total score and total number of customers for each country
SELECT 
  country,
  SUM(score) AS total_score,
  COUNT(id) AS total_customers
FROM custoers
GROUP BY country

/* Find the average score for each country
  considering only customers with a score not equal to 0 (zero)
and return only those countries with an average score greater than 430
*/
SELECT
  country,
  AVG(score) AS average_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING  AVG(score) > 430;

-- Return Unique List of All Countries
SELECT DISTINCT
  country
FROM customers;

-- Retrieve only 3 customers
SELECT TOP 3 *
FROM customers;

-- Retrieve the Top 3 Customers with the Highest Scores
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

-- Retrieve the Lowest 2 customers based on the Score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

-- Get the two most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;

