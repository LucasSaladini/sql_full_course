USE SalesDB

-- Find the total number of orders
SELECT
  COUNT(*) TotalOrders
FROM Sales.Orders;

-- Find the total number of orders
-- additionally provide details such as order id and order date
SELECT
  OrderID,
  OrderDate,
  COUNT(*) OVER() TotalOrders
FROM Sales.Orders;

-- Find the total number of orders
-- Find the total orders for each customers
-- additionally provide details such as order id and order date
SELECT
  OrderID,
  OrderDate,
  CustomerID,
  COUNT(*) OVER() TotalOrders,
  COUNT(*) OVER(PARTITION BY CustomerId) OrdersByCustomers
FROM Sales.Orders;

-- Find the total number of customers,
-- additionally provide all customer's details
SELECT
  *,
  COUNT(*) OVER () TotalCustomers
FROM Sales.Customers;

-- Find the total number of scores for the customers
SELECT
  *,
  COUNT(*) OVER() TotalCustomers,
  COUNT(Score) OVER() TotalScores,
  COUNT(Country) OVER() TotalCountries
FROM Sales.Customers;

-- Check whether the table 'Orders' contains any duplicate rows
SELECT
  OrderID,
  COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.Orders;

SELECT
  *
FROM (
  SELECT
    OrderID,
    COUNT(*) OVER(PARTITION BY OrderID) CheckPK
  FROM Sales.OrdersAchive
)t WHERE CHeckPK > 1;

-- Find the total sales across all orders and the total sales for each product
-- additionally, provide details such as order ID and order date
SELECT
  OrderID,
  OrderDate,
  Sales,
  ProductID,
  SUM(Sales) OVER() TotalSales,
  SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts
FROM Sales.Orders;

-- Finde the percentage contribution of each product's sales to the total sales
SELECT
  OrderID,
  ProductID,
  Sales,
  SUM(Sales) OVER () TotalSales
  ROIUND (CAST (Sales AS FLOAT) / SUM(Sales) Over() * 100, 2) PercentageOfTotal
FROM Sales.Orders;

-- Find the average sales across all orders
-- and find the average sales for each product
-- additionally provide details such as order id and order date
SELECT
  OrderID,
  OrderDatem
  Sales,
  ProductID,
  AVG(Sales) OVER() AvgSales,
  AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProduct
FROM Sales.Oders;

-- Find the average scores of customers
-- additionally, provide details such as customer id and last name
SELECT
  CustomerID,
  LastName,
  Score,
  COALESCE(Score, 0) CustomerScore,
  AVG(Score) OVER() AvgScore,
  AVG(COALESCE(Score, 0)) OVER() AvgScoreWithoutNull
FROM Sales.Customers;

-- Find all orders where sales are higher than the average sales across all orders
SELECT
  *
FROM (
  SELECT
    OrderID,
    ProductID,
    Sales,
    AVG(Sales) OVER() AvgSales
  FROM Sales.Orders
)t WHERE Sales > AvgSales;

-- Find the highest and lowest sales acress all orders
-- and the highest and lowest sales for each product
-- additionally, provide details such as order id and order date
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  MAX(Sales) OVER() HighestSales,
  MIN(Sales) OVER() LowestSales,
  MAX(Sales) OVER(PARTITION BY ByProductID) HighestSalesByProductID,
  MIN(Sales) OVER(PARTITON BY ByProductID) LowestSalesByProductID
FROM Sales.Orders;

-- Show the employees with the highest salaries
SELECT
  *
FROM (
  SELECT
    *,
    MAX(Salary) OVER() HighestSalary
  FROM Sales.Employees
)t WHERE Salary = HighestSalary;

-- Calculate the deviation of each sale from both the minimum and maximum sales amounts
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  MAX(Sales) OVER() HighestSales,
  MIN(Sales) OVER() LowestSales,
  Sales - MIN(Sales) OVER() DeviationFromMin,
  MAX(Sales) OVER() - Sales DeviationFromMax
FROM Sales.Orders;

