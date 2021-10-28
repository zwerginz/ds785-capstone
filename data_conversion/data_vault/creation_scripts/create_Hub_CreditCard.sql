USE AdventureWorksDataVault;
GO

DROP TABLE IF EXISTS Hub_CreditCard;
GO

CREATE TABLE Hub_CreditCard (
    HubCreditCardID BIGINT IDENTITY(1,1) NOT NULL,
    CardNumber NVARCHAR(16) NOT NULL,
    LOAD_DATE DATETIME NOT NULL,
    RECORD_SOURCE NVARCHAR(100) NOT NULL,
    PRIMARY KEY (HubCreditCardID)
)

CREATE UNIQUE INDEX hub_creditcard_i1 ON Hub_CreditCard (CardNumber)