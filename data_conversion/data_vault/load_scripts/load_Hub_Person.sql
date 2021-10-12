USE AdventureWorksDataVault;
GO

DELETE FROM Hub_Person;
GO

INSERT INTO Hub_Person (EmailAddress, LOAD_DATE, RECORD_SOURCE)
SELECT DISTINCT EmailAddress, GETDATE(), 'AdventureWorks2019'
FROM AdventureWorks2019.Person.EmailAddress;
GO