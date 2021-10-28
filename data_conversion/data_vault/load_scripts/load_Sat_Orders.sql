USE AdventureWorksDataVault;
GO

DELETE FROM Sat_Orders;
GO

INSERT INTO Sat_Orders (
    LnkOrderID,
    IsOnlineOrder,
    CreditCardApprovalCode,
    SubTotal,
    TaxAmt,
    Freight,
    TotalDue,
    Comment,
    LOAD_DATE,
    RECORD_SOURCE)
SELECT DISTINCT 
	key4.LnkOrderID,
    1,
	hdr.CreditCardApprovalCode,
    hdr.SubTotal,
    hdr.TaxAmt,
    hdr.Freight,
    hdr.TotalDue,
    hdr.Comment, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Sales.SalesOrderHeader hdr
JOIN AdventureWorks2019.Sales.Customer cust ON cust.CustomerID = hdr.CustomerID
JOIN AdventureWorks2019.Person.EmailAddress emails ON emails.BusinessEntityID = cust.PersonID
JOIN AdventureWorks2019.Sales.SalesTerritory terr ON terr.TerritoryID = hdr.TerritoryID
JOIN AdventureWorksDataVault.dbo.Hub_Order key1 ON hdr.SalesOrderNumber = key1.SalesOrderNumber
JOIN AdventureWorksDataVault.dbo.Hub_Person key2 ON emails.EmailAddress = key2.EmailAddress
JOIN AdventureWorksDataVault.dbo.Hub_Territory key3 ON (terr.Name + ' - ' + terr.CountryRegionCode) = key3.Name
JOIN AdventureWorksDataVault.dbo.Lnk_Orders key4 ON (key4.HubOrderID = key1.HubOrderID AND key4.HubPersonID = key2.HubPersonID AND key4.HubTerritoryID = key3.HubTerritoryID)
WHERE hdr.SalesPersonID IS NULL;
GO