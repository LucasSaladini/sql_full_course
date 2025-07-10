USE MyDatabase

-- Retrieve all customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

-- Retrieve all customers who are not from Germany
SELECT *
FROM customers
WHERE country != 'Germany';

-- Retrieve all customers with a score greater than 500
SELECT *
FROM customers
WHERE score > 500;

-- Retrieve all customers with a score of 500 or more
SELECT *
FROM customers
WHERE score >= 500;

-- Retrieve all customers with a core less than 500
SELECT *
FROM customers
WHERE score < 500

-- Retrieve all customers with a score of 500 or less
SELECT *
FROM customers
WHERE sscore <= 500

-- Retrieve all customers who are from the USA AND have a sscore greater than 500
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500;

-- Retrieve all customers who are either from the USA OR have a score greater than 500
SELECT *
FROM customers
WHERE country = 'USA' OR score > 500;

-- Retrieve all customers with a score NOT less than 500
SELECT *
FROM customers
WHERE NOT score < 500;

-- Retrieve all customers whose score falls in the range between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

SELECT *
FROM customers
WHERE score >= 100 AND score <= 500;

-- Retrieve all customers from either Germany OR USA
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA');

SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA';

-- Find all customers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%';

-- Find all customers whose first name ends with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n';

-- Find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%';

-- Find all customers whoe first name has 'r' in the third position
SELECT *
FROM customers
WHERE first_name LIKE '__r%';
