USE AdventureWorksDataVault;
GO

DELETE FROM Hub_Territory;
GO

INSERT INTO Hub_Territory ([Name], LOAD_DATE, RECORD_SOURCE)
SELECT DISTINCT Name + ' - ' + CountryRegionCode, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Sales.SalesTerritory;
GO