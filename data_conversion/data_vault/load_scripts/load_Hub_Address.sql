USE AdventureWorksDataVault;
GO

DELETE FROM Hub_Address;
GO

INSERT INTO Hub_Address (FullAddress, LOAD_DATE, RECORD_SOURCE)
SELECT COALESCE(TRIM(addr.AddressLine1), '') 
		+ ' ' 
		+ COALESCE(TRIM(addr.AddressLine2), '') 
		+ ', ' 
		+ COALESCE(TRIM(addr.City), '') 
		+ ', ' 
		+ COALESCE(TRIM(st.StateProvinceCode), '') 
		+ ' '
		+ COALESCE(TRIM(addr.PostalCode), ''), 
	GETDATE(), 
	'AdventureWorks2019'
FROM AdventureWorks2019.Person.Address addr
LEFT JOIN AdventureWorks2019.Person.StateProvince st ON st.StateProvinceID = addr.StateProvinceID;
GO