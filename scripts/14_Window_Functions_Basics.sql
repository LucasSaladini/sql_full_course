USE SalesDB
  
-- Find the total sales across all orders
SELECT
  SUM(Sales) TotalSales
FROM Sales.Orders;

--Find the total sales for each product
SELECT
  ProductID,
  SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID;

-- Find the total sales for each product,
-- additionally provide details such as order id and order date
SELECT
  OrderID,
  OrderDate,
  ProductID,
  SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders;

-- Find the total sales across all orders
-- additionally provide details such as order id and order data
SELECT
  OrderID,
  OrderDate,
  SUM(Sales) OVER () TotalSales
FROM Sales.Orders;

-- Find the total sales across all orders
-- Find the total sales for each produtc, additionally provide details such order id and order date
SELECT
  OrderID,
  OrderDate,
  ProductID,
  Sales,
  SUM(Sales) OVER () TotalSales,
  SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders;

-- Find the total sales for each combination of product and order status
SELECT
  OrderID,
  OrderDate,
  ProductID,
  OrderStatus,
  Sales,
  SUM(Sales) OVER () TotalSales,
  SUM(Sales) OVER (PARTITION BY ProductID) SalesByProducts,
  SUM(Sales) OVER (PARTITION BY ProductID, OrderSatus) SalesByProductsAndStatus
FROM Sales.Orders;

-- Rank each order based on their sales from highest to lowest,
-- additionally provide details such as order id and order date
SELECT
  OrderID,
  OrderDate,
  Sales,
  RANK() OVER (ORDER BY Sales DESC) RankSales
FROM Sales.Orders;

SELECT
  OrderID,
  OrderDate,
  OrderStatus,
  Sales,
  SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
                  ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM Sales.Orders;

-- Find the total sales for each order status, only for two products (101 and 102)
SELECT
  OrderID,
  OrderDate,
  OrderStatus,
  ProductID,
  Sales,
  SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101, 102);

-- Rank customers based on their total sales
SELECT
  CustomerID,
  SUM(Sales) TotalSales,
  RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID;
