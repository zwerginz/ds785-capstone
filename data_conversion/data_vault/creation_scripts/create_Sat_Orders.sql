USE AdventureWorksDataVault;
GO

DROP TABLE IF EXISTS Sat_Orders;
GO

CREATE TABLE Sat_Orders (
    LnkOrderID BIGINT,
    IsOnlineOrder BIT,
    CreditCardApprovalCode VARCHAR(15),
    SubTotal NUMERIC(18,4),
    TaxAmt NUMERIC(18, 4),
    Freight NUMERIC(18, 4),
    TotalDue NUMERIC(18, 4),
    Comment VARCHAR(MAX),
    LOAD_DATE DATETIME NOT NULL,
    RECORD_SOURCE NVARCHAR(100) NOT NULL,
    PRIMARY KEY (LnkOrderID, LOAD_DATE),
    FOREIGN KEY (LnkOrderID) REFERENCES Lnk_Orders
)