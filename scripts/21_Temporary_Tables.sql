SELECT
  *
  INTO #Orders
FROM Sales.Orders

SELECT
  *
FROM #Orders

DELETE FROM #Orders
WHERE OrderStatus = 'Delivered'

SELECT
  *
  INTO Sales.OrdersTest
FROM #Orders
