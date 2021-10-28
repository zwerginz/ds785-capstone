USE AdventureWorksDataVault;
GO

DELETE FROM Hub_Product;
GO

INSERT INTO Hub_Product (ProductNumber, LOAD_DATE, RECORD_SOURCE)
SELECT DISTINCT ProductNumber, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Production.Product;
GO