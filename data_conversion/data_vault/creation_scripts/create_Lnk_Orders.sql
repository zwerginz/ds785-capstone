USE AdventureWorksDataVault;
GO

DROP TABLE IF EXISTS Lnk_Orders;
GO

CREATE TABLE Lnk_Orders (
    LnkOrderID BIGINT IDENTITY(1,1) PRIMARY KEY,
    HubOrderID BIGINT NOT NULL,
    HubPersonID BIGINT NOT NULL,
    HubTerritoryID BIGINT NOT NULL,
    LOAD_DATE DATETIME NOT NULL,
    RECORD_SOURCE NVARCHAR(100) NOT NULL,

    FOREIGN KEY (HubOrderID) REFERENCES Hub_Order(HubOrderID),
    FOREIGN KEY (HubPersonID) REFERENCES Hub_Person(HubPersonID),
    FOREIGN KEY (HubTerritoryID) REFERENCES Hub_Territory(HubTerritoryID)
)
GO