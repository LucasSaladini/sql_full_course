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

-- Generate all possible combinations of customers and orders
SELECT *
FROM customers
CROSS JOIN orders;

-- Using SalesDB, retrieve a list of all orders, along with the related customer, product, and employee details
/*
       For each order, display:
              - Order ID
              - Customer's name
              - Product name
              - Sales amount
              - Product price
              - Salesperson's name
*/
USE SalesDB

SELECT
	o.OrderID,
	o.Sales,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.Product AS ProductName
	p.price,
	e.FirstName AS EmployeeFirstName,
	e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employee AS e
ON o.SalesPersonID = e .EmployeeID;
