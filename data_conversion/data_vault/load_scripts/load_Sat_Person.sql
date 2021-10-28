USE AdventureWorksDataVault;
GO

DELETE FROM Sat_Person;
GO

INSERT INTO Sat_Person (
    HubPersonID,
    CustomerID,
    LOAD_DATE,
    RECORD_SOURCE)
SELECT DISTINCT 
	key1.HubPersonID, 
	cust.CustomerID,
	GETDATE(), 
    'AdventureWorks2019'
FROM AdventureWorks2019.Sales.Customer cust
JOIN AdventureWorks2019.Person.Person per ON per.BusinessEntityID = cust.PersonID
JOIN AdventureWorks2019.Person.EmailAddress email ON email.BusinessEntityID = per.BusinessEntityID
JOIN Hub_Person key1 ON key1.EmailAddress = email.EmailAddress
GO