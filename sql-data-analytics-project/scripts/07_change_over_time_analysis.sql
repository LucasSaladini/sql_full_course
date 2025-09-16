-- Analyze sales performance over time
SELECT
  YEAR(order_date) order_year,
  SUM(sales_amount) total_sales,
  COUNT(DISTINCT customer_key) AS total_customers,
  SUM(quantity) AS total_quantity
FROM gold.facts_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

SELECT
  MONTH(order_date) order_year,
  SUM(sales_amount) total_sales,
  COUNT(DISTINCT customer_key) AS total_customers,
  SUM(quantity) AS total_quantity
FROM gold.facts_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

SELECT
  YEAR(order_date) order_year,
  MONTH(order_date) order_year,
  SUM(sales_amount) total_sales,
  COUNT(DISTINCT customer_key) AS total_customers,
  SUM(quantity) AS total_quantity
FROM gold.facts_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) order_year, MONTH(order_date)
ORDER BY YEAR(order_date) order_year, MONTH(order_date);

SELECT
  DATETRUNC(month, order_date) order_date,
  SUM(sales_amount) total_sales,
  COUNT(DISTINCT customer_key) AS total_customers,
  SUM(quantity) AS total_quantity
FROM gold.facts_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);

SELECT
  FORMAT(order_date, 'yyyy-MMM') order_date,
  SUM(sales_amount) total_sales,
  COUNT(DISTINCT customer_key) AS total_customers,
  SUM(quantity) AS total_quantity
FROM gold.facts_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');
