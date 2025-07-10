USE MyDatabase

-- Retrieve all data from customers and orders as separate results
SELECT *
FROM customers;

SELECT * 
FROM orders;

-- Get all customers along with their orders, but only for customers who have placed an order
SELECT c.id,
       c.first_name,
       o.order_id,
       o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

-- Get all customers along with their orders, including those without orders
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;

-- Get all customers along with their orders, including orders without matching customers
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id;

-- Get all customers and all orders, even if there's no match
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = c.customer_id;

-- Get all customers who haven't placed any order
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

-- Get all orders without matching customers
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;

SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id = o.customer_id;

-- Find customers without orders and orders without customers
SELECT *
FROM orders AS o
FULL JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL 
OR o.customer_id IS NULL;

-- Get all customers along with their orders, but only for customers who have placed and order
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

-- 
