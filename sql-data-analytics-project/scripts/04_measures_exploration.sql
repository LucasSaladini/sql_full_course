-- Find the total sales
SELECT
  SUM(sales_amount) AS total_sales
FROM gold.facts_sales;

-- Finde how many items are sold
SELECT
  SUM(quantity) AS total_quantity
FROM gold.facts_sales;

-- Find the average selling price
SELECT
  AVG(price) AS avg_price
FROM gold.facts_sales;

-- Find the total number of orders
SELECT
  COUNT(order_number) AS total_sales
FROM gold.facts_sales;

SELECT
  COUNT(DISTINCT order_number) AS total_sales
FROM gold.facts_sales;

-- Find the total number of products
SELECT
  COUNT(product_key) AS total_products
FROM gold.facts_sales;

SELECT
  COUNT(DISTINCT product_key) AS total_products
FROM gold.facts_sales;

-- Find the total number of customers
SELECT
  COUNT(customer_key) AS total_customers
FROM gold.facts_customers;

-- Find the total number of customers that has placed an order
SELECT
  COUNT(DISTINCT customer_key) AS total_customers
FROM gold.facts_sales;

-- Generate a report that shows all key metrics of the business
SELECT
  'Total Sales' AS measure_name,
  SUM(sales_amount) AS measure_value
FROM gold.facts_sales
UNION ALL
SELECT
  'Total Quantity',
  SUM(quantity)
FROM gold.facts_sales
UNION ALL
SELECT
  'Average Price',
  AVG(price)
FROM gold.facts_sales
UNION ALL
SELECT
  'Total Nr. Orders',
  COUNT(DISTINCT order_number)
FROM gold.facts_sales
UNION ALL
SELECT
  'Total Nr. Products',
  COUNT(product_name)
FROM gold.dim_products
UNION ALL
SELECT
  'Total Nr. Customers',
  COUNT(customer_key)
FROM gold.dim_customers
