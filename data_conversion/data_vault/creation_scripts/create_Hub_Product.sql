USE AdventureWorksDataVault;
GO

DROP TABLE IF EXISTS Hub_Product;
GO

CREATE TABLE Hub_Product (
    HubProductID BIGINT IDENTITY(1,1) NOT NULL,
    ProductNumber NVARCHAR(100) NOT NULL,
    LOAD_DATE DATETIME NOT NULL,
    RECORD_SOURCE NVARCHAR(100) NOT NULL,
    PRIMARY KEY (HubProductID)
)

CREATE UNIQUE INDEX hub_product_i1 ON Hub_Product (ProductNumber)