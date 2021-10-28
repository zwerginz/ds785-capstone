USE AdventureWorksDataVault;
GO

DELETE FROM Hub_Order;
GO

INSERT INTO Hub_Order (SalesOrderNumber, LOAD_DATE, RECORD_SOURCE)
SELECT DISTINCT SalesOrderNumber, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Sales.SalesOrderHeader;
GO