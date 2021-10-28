USE AdventureWorksDataVault;
GO

DELETE FROM Hub_CreditCard;
GO

INSERT INTO Hub_CreditCard (CardNumber, LOAD_DATE, RECORD_SOURCE)
SELECT DISTINCT CardNumber, 
	GETDATE(), 
	'AdventureWorks2019'
FROM AdventureWorks2019.Sales.CreditCard;
GO