USE AdventureWorksDataVault;
GO

DELETE FROM Lnk_Orders;
GO

INSERT INTO Lnk_Orders (
    HubOrderID,
    HubPersonID,
    HubTerritoryID,
    LOAD_DATE,
    RECORD_SOURCE)
SELECT DISTINCT key1.HubOrderID, key2.HubPersonID, key3.HubTerritoryID, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Sales.SalesOrderHeader hdr
JOIN AdventureWorks2019.Sales.Customer cust ON cust.CustomerID = hdr.CustomerID
JOIN AdventureWorks2019.Person.EmailAddress emails ON emails.BusinessEntityID = cust.PersonID
JOIN AdventureWorks2019.Sales.SalesTerritory terr ON terr.TerritoryID = hdr.TerritoryID
JOIN AdventureWorksDataVault.dbo.Hub_Order key1 ON hdr.SalesOrderNumber = key1.SalesOrderNumber
JOIN AdventureWorksDataVault.dbo.Hub_Person key2 ON emails.EmailAddress = key2.EmailAddress
JOIN AdventureWorksDataVault.dbo.Hub_Territory key3 ON (terr.Name + ' - ' + terr.CountryRegionCode) = key3.Name
GO