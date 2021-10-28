USE AdventureWorksDataVault;
GO

DROP TABLE IF EXISTS Hub_Territory;
GO

CREATE TABLE Hub_Territory (
    HubTerritoryID BIGINT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    LOAD_DATE DATETIME NOT NULL,
    RECORD_SOURCE NVARCHAR(100) NOT NULL,
    PRIMARY KEY (HubTerritoryID)
)

CREATE UNIQUE INDEX hub_territory_i1 ON Hub_Territory ([Name])