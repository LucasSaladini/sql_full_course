SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName)

CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)

CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score)

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBCustomers

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers

DROP INDEX idx_DBCustomers_CS ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS_FirstName
ON Sales.DBCustomers

USE AdventureWorksDW2022;

-- HEAP
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales

-- RowStore
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX idx_FactsInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)

-- ColumnStore
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactsInternetSales_CS_PK
ON FactInternetSales_CS

USE SalesDB;

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products (Product)

INSERT INTO Sales.Products (ProductID, Product) VALUES (106, 'Caps')

CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA'

-- List all indexes on a specific table
sp_helpindex 'Sales.DBCustomers'

-- Monitoring Index Usage
SELECT 
  tbl.name AS TableName,
  idx.name AS IndexName,
  idx.type_desc AS IndexType,
  idx.is_primary_key AS IsPrimaryKey,
  idx.is_unique AS IsUnique,
  idx.is_disabled AS IsDisabled
  s.user_seeks AS UserSeeks,
  s.user_scans AS UserScans,
  s.user_lookups AS UserLookups,
  s.user_updates AS UserUpdates,
  COALESCE(s.last_user_seek, s.last_user_scan) LastUpdate
FROM sys.indexes idx
JOIN sus.tables tbl
  ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index>usage_stats s
  ON s.object_id = idx.object_id
  AND s.index_id = idx.idex_id
ORDER BY tbl.name, idx.name

SELECT * FROM sys.dm_db_index_usage_stats

-- Monitoring Missing Indexes
SELECT * FROM sys.dm_db_missing_index_details

-- Monitor Duplicate Indexes
SELECT
  tbl.name AS TableName,
  col.name AS IndexColumn,
  idx.name as IndexName,
  idx.type_desc AS IndexType,
  COUNT(*) OVER(PARTITION BY tbl.name, col.name) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id = ic.object_id AND idx.index_id = ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY tbl.name, col.name
