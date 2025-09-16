/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/
WITH base_query AS (
  SELECT
    f.order_number,
    f.product_key,
    f.order_date,
    f.sales_amount,
    f.quantity,
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name + ' ' + c.last_name) AS customer_name,
    DATEDIFF(year, c.birthdate, GETDATE()) age
  FROM gold.fact_sales f
  LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
  WHERE order_date IS NOT NULL
)

, customer_aggregation AS (
  SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT product_key) AS total_products,
    MAX(order_date) AS last_order_date,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
  FROM base_query
  GROUP BY
    customer_key,
    customer_number,
    customer_name,
    age
)

SELECT
  customer_key,
  customer_number,
  customer_name,
  age,
  total_orders,
  total_sales,
  total_quantity,
  total_products,
  last_order_date,
  lifespan
FROM customer_aggregation
