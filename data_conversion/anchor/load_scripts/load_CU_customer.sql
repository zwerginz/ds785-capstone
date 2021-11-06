USE AdventureWorksAnchor;
GO

INSERT INTO lCU_Customer (CU_NAM_Customer_Name, CU_EML_Customer_EmailAddress, Metadata_CU)
SELECT DISTINCT FirstName + LastName, EmailAddress, 1
FROM AdventureWorks2019.Sales.Customer cust
JOIN AdventureWorks2019.Person.Person per ON per.BusinessEntityID = cust.PersonID
JOIN AdventureWorks2019.Person.EmailAddress email ON email.BusinessEntityID = per.BusinessEntityID;