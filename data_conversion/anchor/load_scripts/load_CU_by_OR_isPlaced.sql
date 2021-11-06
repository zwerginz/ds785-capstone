USE AdventureWorksAnchor;
GO

INSERT INTO lCU_by_OR_isPlaced (CU_ID_by, OR_ID_isPlaced, Metadata_CU_by_OR_isPlaced)
SELECT DISTINCT lcust.CU_ID, lord.OR_ID, 1
FROM AdventureWorks2019.Sales.SalesOrderHeader ord
JOIN AdventureWorks2019.Sales.Customer cust ON ord.CustomerID = cust.CustomerID
JOIN AdventureWorks2019.Person.Person per ON per.BusinessEntityID = cust.PersonID
JOIN AdventureWorks2019.Person.EmailAddress email ON email.BusinessEntityID = per.BusinessEntityID
JOIN AdventureWorksAnchor.dbo.lCU_Customer lcust ON lcust.CU_EML_Customer_EmailAddress = email.EmailAddress
JOIN AdventureWorksAnchor.dbo.lOR_Order lord ON lord.OR_NUM_Order_Number = ord.SalesOrderNumber;