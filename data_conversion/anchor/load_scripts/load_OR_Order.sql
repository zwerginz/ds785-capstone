USE AdventureWorksAnchor;
GO

INSERT INTO lOR_Order (OR_NUM_Order_Number, OR_DAT_Order_Date, OR_ONL_Order_IsOnline, OR_STO_Order_SubTotal, Metadata_OR)
SELECT DISTINCT ord.SalesOrderNumber, ord.OrderDate, ord.OnlineOrderFlag, ord.SubTotal, 1
FROM AdventureWorks2019.Sales.SalesOrderHeader ord