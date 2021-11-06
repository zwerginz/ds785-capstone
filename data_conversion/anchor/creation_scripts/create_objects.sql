USE AdventureWorksAnchor
GO

-- KNOTS --------------------------------------------------------------------------------------------------------------
--
-- Knots are used to store finite sets of values, normally used to describe states
-- of entities (through knotted attributes) or relationships (through knotted ties).
-- Knots have their own surrogate identities and are therefore immutable.
-- Values can be added to the set over time though.
-- Knots should have values that are mutually exclusive and exhaustive.
-- Knots are unfolded when using equivalence.
--
-- ANCHORS AND ATTRIBUTES ---------------------------------------------------------------------------------------------
--
-- Anchors are used to store the identities of entities.
-- Anchors are immutable.
-- Attributes are used to store values for properties of entities.
-- Attributes are mutable, their values may change over one or more types of time.
-- Attributes have four flavors: static, historized, knotted static, and knotted historized.
-- Anchors may have zero or more adjoined attributes.
--
-- Anchor table -------------------------------------------------------------------------------------------------------
-- CU_Customer table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.CU_Customer', 'U') IS NULL
CREATE TABLE [dbo].[CU_Customer] (
    CU_ID int IDENTITY(1,1) not null,
    Metadata_CU int not null, 
    constraint pkCU_Customer primary key (
        CU_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CU_NAM_Customer_Name table (on CU_Customer)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.CU_NAM_Customer_Name', 'U') IS NULL
CREATE TABLE [dbo].[CU_NAM_Customer_Name] (
    CU_NAM_CU_ID int not null,
    CU_NAM_Customer_Name varchar(100) not null,
    Metadata_CU_NAM int not null,
    constraint fkCU_NAM_Customer_Name foreign key (
        CU_NAM_CU_ID
    ) references [dbo].[CU_Customer](CU_ID),
    constraint pkCU_NAM_Customer_Name primary key (
        CU_NAM_CU_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- CU_EML_Customer_EmailAddress table (on CU_Customer)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.CU_EML_Customer_EmailAddress', 'U') IS NULL
CREATE TABLE [dbo].[CU_EML_Customer_EmailAddress] (
    CU_EML_CU_ID int not null,
    CU_EML_Customer_EmailAddress varchar(100) not null,
    Metadata_CU_EML int not null,
    constraint fkCU_EML_Customer_EmailAddress foreign key (
        CU_EML_CU_ID
    ) references [dbo].[CU_Customer](CU_ID),
    constraint pkCU_EML_Customer_EmailAddress primary key (
        CU_EML_CU_ID asc
    )
);
GO
-- Anchor table -------------------------------------------------------------------------------------------------------
-- OR_Order table (with 4 attributes)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.OR_Order', 'U') IS NULL
CREATE TABLE [dbo].[OR_Order] (
    OR_ID int IDENTITY(1,1) not null,
    Metadata_OR int not null, 
    constraint pkOR_Order primary key (
        OR_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- OR_NUM_Order_Number table (on OR_Order)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.OR_NUM_Order_Number', 'U') IS NULL
CREATE TABLE [dbo].[OR_NUM_Order_Number] (
    OR_NUM_OR_ID int not null,
    OR_NUM_Order_Number varchar(15) not null,
    Metadata_OR_NUM int not null,
    constraint fkOR_NUM_Order_Number foreign key (
        OR_NUM_OR_ID
    ) references [dbo].[OR_Order](OR_ID),
    constraint pkOR_NUM_Order_Number primary key (
        OR_NUM_OR_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- OR_DAT_Order_Date table (on OR_Order)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.OR_DAT_Order_Date', 'U') IS NULL
CREATE TABLE [dbo].[OR_DAT_Order_Date] (
    OR_DAT_OR_ID int not null,
    OR_DAT_Order_Date date not null,
    Metadata_OR_DAT int not null,
    constraint fkOR_DAT_Order_Date foreign key (
        OR_DAT_OR_ID
    ) references [dbo].[OR_Order](OR_ID),
    constraint pkOR_DAT_Order_Date primary key (
        OR_DAT_OR_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- OR_ONL_Order_IsOnline table (on OR_Order)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.OR_ONL_Order_IsOnline', 'U') IS NULL
CREATE TABLE [dbo].[OR_ONL_Order_IsOnline] (
    OR_ONL_OR_ID int not null,
    OR_ONL_Order_IsOnline bit not null,
    Metadata_OR_ONL int not null,
    constraint fkOR_ONL_Order_IsOnline foreign key (
        OR_ONL_OR_ID
    ) references [dbo].[OR_Order](OR_ID),
    constraint pkOR_ONL_Order_IsOnline primary key (
        OR_ONL_OR_ID asc
    )
);
GO
-- Static attribute table ---------------------------------------------------------------------------------------------
-- OR_STO_Order_SubTotal table (on OR_Order)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.OR_STO_Order_SubTotal', 'U') IS NULL
CREATE TABLE [dbo].[OR_STO_Order_SubTotal] (
    OR_STO_OR_ID int not null,
    OR_STO_Order_SubTotal NUMERIC(18,2) not null,
    Metadata_OR_STO int not null,
    constraint fkOR_STO_Order_SubTotal foreign key (
        OR_STO_OR_ID
    ) references [dbo].[OR_Order](OR_ID),
    constraint pkOR_STO_Order_SubTotal primary key (
        OR_STO_OR_ID asc
    )
);
GO
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- Static tie table ---------------------------------------------------------------------------------------------------
-- CU_by_OR_isPlaced table (having 2 roles)
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.CU_by_OR_isPlaced', 'U') IS NULL
CREATE TABLE [dbo].[CU_by_OR_isPlaced] (
    CU_ID_by int not null, 
    OR_ID_isPlaced int not null, 
    Metadata_CU_by_OR_isPlaced int not null,
    constraint CU_by_OR_isPlaced_fkCU_by foreign key (
        CU_ID_by
    ) references [dbo].[CU_Customer](CU_ID), 
    constraint CU_by_OR_isPlaced_fkOR_isPlaced foreign key (
        OR_ID_isPlaced
    ) references [dbo].[OR_Order](OR_ID), 
    constraint pkCU_by_OR_isPlaced primary key (
        CU_ID_by asc,
        OR_ID_isPlaced asc
    )
);
GO
-- KNOT EQUIVALENCE VIEWS ---------------------------------------------------------------------------------------------
--
-- Equivalence views combine the identity and equivalent parts of a knot into a single view, making
-- it look and behave like a regular knot. They also make it possible to retrieve data for only the
-- given equivalent.
--
-- @equivalent the equivalent that you want to retrieve data for
--
-- ATTRIBUTE EQUIVALENCE VIEWS ----------------------------------------------------------------------------------------
--
-- Equivalence views of attributes make it possible to retrieve data for only the given equivalent.
--
-- @equivalent the equivalent that you want to retrieve data for
--
-- KEY GENERATORS -----------------------------------------------------------------------------------------------------
--
-- These stored procedures can be used to generate identities of entities.
-- Corresponding anchors must have an incrementing identity column.
--
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kCU_Customer identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.kCU_Customer', 'P') IS NULL
BEGIN
    EXEC('
    CREATE PROCEDURE [dbo].[kCU_Customer] (
        @requestedNumberOfIdentities bigint,
        @metadata int
    ) AS
    BEGIN
        SET NOCOUNT ON;
        IF @requestedNumberOfIdentities > 0
        BEGIN
            WITH idGenerator (idNumber) AS (
                SELECT
                    1
                UNION ALL
                SELECT
                    idNumber + 1
                FROM
                    idGenerator
                WHERE
                    idNumber < @requestedNumberOfIdentities
            )
            INSERT INTO [dbo].[CU_Customer] (
                Metadata_CU
            )
            OUTPUT
                inserted.CU_ID
            SELECT
                @metadata
            FROM
                idGenerator
            OPTION (maxrecursion 0);
        END
    END
    ');
END
GO
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kOR_Order identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.kOR_Order', 'P') IS NULL
BEGIN
    EXEC('
    CREATE PROCEDURE [dbo].[kOR_Order] (
        @requestedNumberOfIdentities bigint,
        @metadata int
    ) AS
    BEGIN
        SET NOCOUNT ON;
        IF @requestedNumberOfIdentities > 0
        BEGIN
            WITH idGenerator (idNumber) AS (
                SELECT
                    1
                UNION ALL
                SELECT
                    idNumber + 1
                FROM
                    idGenerator
                WHERE
                    idNumber < @requestedNumberOfIdentities
            )
            INSERT INTO [dbo].[OR_Order] (
                Metadata_OR
            )
            OUTPUT
                inserted.OR_ID
            SELECT
                @metadata
            FROM
                idGenerator
            OPTION (maxrecursion 0);
        END
    END
    ');
END
GO
-- ATTRIBUTE REWINDERS ------------------------------------------------------------------------------------------------
--
-- These table valued functions rewind an attribute table to the given
-- point in changing time. It does not pick a temporal perspective and
-- instead shows all rows that have been in effect before that point
-- in time.
--
-- @changingTimepoint the point in changing time to rewind to
--
-- ANCHOR TEMPORAL BUSINESS PERSPECTIVES ------------------------------------------------------------------------------
--
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.Difference_Customer', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Difference_Customer];
IF Object_ID('dbo.Current_Customer', 'V') IS NOT NULL
DROP VIEW [dbo].[Current_Customer];
IF Object_ID('dbo.Point_Customer', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Point_Customer];
IF Object_ID('dbo.Latest_Customer', 'V') IS NOT NULL
DROP VIEW [dbo].[Latest_Customer];
GO
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.Difference_Order', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Difference_Order];
IF Object_ID('dbo.Current_Order', 'V') IS NOT NULL
DROP VIEW [dbo].[Current_Order];
IF Object_ID('dbo.Point_Order', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Point_Order];
IF Object_ID('dbo.Latest_Order', 'V') IS NOT NULL
DROP VIEW [dbo].[Latest_Order];
GO
-- ANCHOR TEMPORAL PERSPECTIVES ---------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each anchor. There are four types of perspectives: latest,
-- point-in-time, difference, and now. They also denormalize the anchor, its attributes,
-- and referenced knots from sixth to third normal form.
--
-- The latest perspective shows the latest available information for each anchor.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints, and for
-- changes in all or a selection of attributes.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
-- @selection a list of mnemonics for tracked attributes, ie 'MNE MON ICS', or null for all
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- @equivalent the equivalent for which to retrieve data
--
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.dCU_Customer', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[dCU_Customer];
IF Object_ID('dbo.nCU_Customer', 'V') IS NOT NULL
DROP VIEW [dbo].[nCU_Customer];
IF Object_ID('dbo.pCU_Customer', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[pCU_Customer];
IF Object_ID('dbo.lCU_Customer', 'V') IS NOT NULL
DROP VIEW [dbo].[lCU_Customer];
GO
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lCU_Customer viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[lCU_Customer] WITH SCHEMABINDING AS
SELECT
    [CU].CU_ID,
    [CU].Metadata_CU,
    [NAM].CU_NAM_CU_ID,
    [NAM].Metadata_CU_NAM,
    [NAM].CU_NAM_Customer_Name,
    [EML].CU_EML_CU_ID,
    [EML].Metadata_CU_EML,
    [EML].CU_EML_Customer_EmailAddress
FROM
    [dbo].[CU_Customer] [CU]
LEFT JOIN
    [dbo].[CU_NAM_Customer_Name] [NAM]
ON
    [NAM].CU_NAM_CU_ID = [CU].CU_ID
LEFT JOIN
    [dbo].[CU_EML_Customer_EmailAddress] [EML]
ON
    [EML].CU_EML_CU_ID = [CU].CU_ID;
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pCU_Customer viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[pCU_Customer] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE WITH SCHEMABINDING AS RETURN
SELECT
    [CU].CU_ID,
    [CU].Metadata_CU,
    [NAM].CU_NAM_CU_ID,
    [NAM].Metadata_CU_NAM,
    [NAM].CU_NAM_Customer_Name,
    [EML].CU_EML_CU_ID,
    [EML].Metadata_CU_EML,
    [EML].CU_EML_Customer_EmailAddress
FROM
    [dbo].[CU_Customer] [CU]
LEFT JOIN
    [dbo].[CU_NAM_Customer_Name] [NAM]
ON
    [NAM].CU_NAM_CU_ID = [CU].CU_ID
LEFT JOIN
    [dbo].[CU_EML_Customer_EmailAddress] [EML]
ON
    [EML].CU_EML_CU_ID = [CU].CU_ID;
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nCU_Customer viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[nCU_Customer]
AS
SELECT
    *
FROM
    [dbo].[pCU_Customer](sysdatetime());
GO
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.dOR_Order', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[dOR_Order];
IF Object_ID('dbo.nOR_Order', 'V') IS NOT NULL
DROP VIEW [dbo].[nOR_Order];
IF Object_ID('dbo.pOR_Order', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[pOR_Order];
IF Object_ID('dbo.lOR_Order', 'V') IS NOT NULL
DROP VIEW [dbo].[lOR_Order];
GO
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lOR_Order viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[lOR_Order] WITH SCHEMABINDING AS
SELECT
    [OR].OR_ID,
    [OR].Metadata_OR,
    [NUM].OR_NUM_OR_ID,
    [NUM].Metadata_OR_NUM,
    [NUM].OR_NUM_Order_Number,
    [DAT].OR_DAT_OR_ID,
    [DAT].Metadata_OR_DAT,
    [DAT].OR_DAT_Order_Date,
    [ONL].OR_ONL_OR_ID,
    [ONL].Metadata_OR_ONL,
    [ONL].OR_ONL_Order_IsOnline,
    [STO].OR_STO_OR_ID,
    [STO].Metadata_OR_STO,
    [STO].OR_STO_Order_SubTotal
FROM
    [dbo].[OR_Order] [OR]
LEFT JOIN
    [dbo].[OR_NUM_Order_Number] [NUM]
ON
    [NUM].OR_NUM_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_DAT_Order_Date] [DAT]
ON
    [DAT].OR_DAT_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_ONL_Order_IsOnline] [ONL]
ON
    [ONL].OR_ONL_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_STO_Order_SubTotal] [STO]
ON
    [STO].OR_STO_OR_ID = [OR].OR_ID;
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pOR_Order viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[pOR_Order] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE WITH SCHEMABINDING AS RETURN
SELECT
    [OR].OR_ID,
    [OR].Metadata_OR,
    [NUM].OR_NUM_OR_ID,
    [NUM].Metadata_OR_NUM,
    [NUM].OR_NUM_Order_Number,
    [DAT].OR_DAT_OR_ID,
    [DAT].Metadata_OR_DAT,
    [DAT].OR_DAT_Order_Date,
    [ONL].OR_ONL_OR_ID,
    [ONL].Metadata_OR_ONL,
    [ONL].OR_ONL_Order_IsOnline,
    [STO].OR_STO_OR_ID,
    [STO].Metadata_OR_STO,
    [STO].OR_STO_Order_SubTotal
FROM
    [dbo].[OR_Order] [OR]
LEFT JOIN
    [dbo].[OR_NUM_Order_Number] [NUM]
ON
    [NUM].OR_NUM_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_DAT_Order_Date] [DAT]
ON
    [DAT].OR_DAT_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_ONL_Order_IsOnline] [ONL]
ON
    [ONL].OR_ONL_OR_ID = [OR].OR_ID
LEFT JOIN
    [dbo].[OR_STO_Order_SubTotal] [STO]
ON
    [STO].OR_STO_OR_ID = [OR].OR_ID;
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nOR_Order viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[nOR_Order]
AS
SELECT
    *
FROM
    [dbo].[pOR_Order](sysdatetime());
GO
-- ANCHOR TEMPORAL BUSINESS PERSPECTIVES ------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each anchor. There are four types of perspectives: latest,
-- point-in-time, difference, and now. They also denormalize the anchor, its attributes,
-- and referenced knots from sixth to third normal form.
--
-- The latest perspective shows the latest available information for each anchor.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints, and for
-- changes in all or a selection of attributes.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
-- @selection a list of mnemonics for tracked attributes, ie 'MNE MON ICS', or null for all
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-EQ perspectives are provided in order to select a specific equivalent.
--
-- @equivalent the equivalent for which to retrieve data
--
-- Latest perspective -------------------------------------------------------------------------------------------------
-- Latest_Customer viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Latest_Customer] AS
SELECT
    [CU].CU_ID as [Customer_Id],
    [CU].CU_NAM_Customer_Name as [Name],
    [CU].CU_EML_Customer_EmailAddress as [EmailAddress]
FROM
    [dbo].[lCU_Customer] [CU];
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- Point_Customer viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[Point_Customer] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE AS RETURN
SELECT
    [CU].CU_ID as [Customer_Id],
    [CU].CU_NAM_Customer_Name as [Name],
    [CU].CU_EML_Customer_EmailAddress as [EmailAddress]
FROM
    [dbo].[pCU_Customer](@changingTimepoint) [CU]
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- Current_Customer viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Current_Customer]
AS
SELECT
    *
FROM
    [dbo].[Point_Customer](sysdatetime());
GO
-- Latest perspective -------------------------------------------------------------------------------------------------
-- Latest_Order viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Latest_Order] AS
SELECT
    [OR].OR_ID as [Order_Id],
    [OR].OR_NUM_Order_Number as [Number],
    [OR].OR_DAT_Order_Date as [Date],
    [OR].OR_ONL_Order_IsOnline as [IsOnline],
    [OR].OR_STO_Order_SubTotal as [SubTotal]
FROM
    [dbo].[lOR_Order] [OR];
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- Point_Order viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[Point_Order] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE AS RETURN
SELECT
    [OR].OR_ID as [Order_Id],
    [OR].OR_NUM_Order_Number as [Number],
    [OR].OR_DAT_Order_Date as [Date],
    [OR].OR_ONL_Order_IsOnline as [IsOnline],
    [OR].OR_STO_Order_SubTotal as [SubTotal]
FROM
    [dbo].[pOR_Order](@changingTimepoint) [OR]
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- Current_Order viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Current_Order]
AS
SELECT
    *
FROM
    [dbo].[Point_Order](sysdatetime());
GO
-- ATTRIBUTE TRIGGERS ------------------------------------------------------------------------------------------------
--
-- The following triggers on the attributes make them behave like tables.
-- There is one 'instead of' trigger for: insert.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_CU_NAM_Customer_Name instead of INSERT trigger on CU_NAM_Customer_Name
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_CU_NAM_Customer_Name', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_CU_NAM_Customer_Name];
GO
CREATE TRIGGER [dbo].[it_CU_NAM_Customer_Name] ON [dbo].[CU_NAM_Customer_Name]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @CU_NAM_Customer_Name TABLE (
        CU_NAM_CU_ID int not null,
        Metadata_CU_NAM int not null,
        CU_NAM_Customer_Name varchar(100) not null,
        CU_NAM_Version bigint not null,
        CU_NAM_StatementType char(1) not null,
        primary key(
            CU_NAM_Version,
            CU_NAM_CU_ID
        )
    );
    INSERT INTO @CU_NAM_Customer_Name
    SELECT
        i.CU_NAM_CU_ID,
        i.Metadata_CU_NAM,
        i.CU_NAM_Customer_Name,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.CU_NAM_CU_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @CU_NAM_Customer_Name;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.CU_NAM_StatementType =
                CASE
                    WHEN [NAM].CU_NAM_CU_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @CU_NAM_Customer_Name v
        LEFT JOIN
            [dbo].[CU_NAM_Customer_Name] [NAM]
        ON
            [NAM].CU_NAM_CU_ID = v.CU_NAM_CU_ID
        AND
            [NAM].CU_NAM_Customer_Name = v.CU_NAM_Customer_Name
        WHERE
            v.CU_NAM_Version = @currentVersion;
        INSERT INTO [dbo].[CU_NAM_Customer_Name] (
            CU_NAM_CU_ID,
            Metadata_CU_NAM,
            CU_NAM_Customer_Name
        )
        SELECT
            CU_NAM_CU_ID,
            Metadata_CU_NAM,
            CU_NAM_Customer_Name
        FROM
            @CU_NAM_Customer_Name
        WHERE
            CU_NAM_Version = @currentVersion
        AND
            CU_NAM_StatementType in ('N');
    END
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_CU_EML_Customer_EmailAddress instead of INSERT trigger on CU_EML_Customer_EmailAddress
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_CU_EML_Customer_EmailAddress', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_CU_EML_Customer_EmailAddress];
GO
CREATE TRIGGER [dbo].[it_CU_EML_Customer_EmailAddress] ON [dbo].[CU_EML_Customer_EmailAddress]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @CU_EML_Customer_EmailAddress TABLE (
        CU_EML_CU_ID int not null,
        Metadata_CU_EML int not null,
        CU_EML_Customer_EmailAddress varchar(100) not null,
        CU_EML_Version bigint not null,
        CU_EML_StatementType char(1) not null,
        primary key(
            CU_EML_Version,
            CU_EML_CU_ID
        )
    );
    INSERT INTO @CU_EML_Customer_EmailAddress
    SELECT
        i.CU_EML_CU_ID,
        i.Metadata_CU_EML,
        i.CU_EML_Customer_EmailAddress,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.CU_EML_CU_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @CU_EML_Customer_EmailAddress;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.CU_EML_StatementType =
                CASE
                    WHEN [EML].CU_EML_CU_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @CU_EML_Customer_EmailAddress v
        LEFT JOIN
            [dbo].[CU_EML_Customer_EmailAddress] [EML]
        ON
            [EML].CU_EML_CU_ID = v.CU_EML_CU_ID
        AND
            [EML].CU_EML_Customer_EmailAddress = v.CU_EML_Customer_EmailAddress
        WHERE
            v.CU_EML_Version = @currentVersion;
        INSERT INTO [dbo].[CU_EML_Customer_EmailAddress] (
            CU_EML_CU_ID,
            Metadata_CU_EML,
            CU_EML_Customer_EmailAddress
        )
        SELECT
            CU_EML_CU_ID,
            Metadata_CU_EML,
            CU_EML_Customer_EmailAddress
        FROM
            @CU_EML_Customer_EmailAddress
        WHERE
            CU_EML_Version = @currentVersion
        AND
            CU_EML_StatementType in ('N');
    END
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_OR_NUM_Order_Number instead of INSERT trigger on OR_NUM_Order_Number
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_OR_NUM_Order_Number', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_OR_NUM_Order_Number];
GO
CREATE TRIGGER [dbo].[it_OR_NUM_Order_Number] ON [dbo].[OR_NUM_Order_Number]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @OR_NUM_Order_Number TABLE (
        OR_NUM_OR_ID int not null,
        Metadata_OR_NUM int not null,
        OR_NUM_Order_Number varchar(15) not null,
        OR_NUM_Version bigint not null,
        OR_NUM_StatementType char(1) not null,
        primary key(
            OR_NUM_Version,
            OR_NUM_OR_ID
        )
    );
    INSERT INTO @OR_NUM_Order_Number
    SELECT
        i.OR_NUM_OR_ID,
        i.Metadata_OR_NUM,
        i.OR_NUM_Order_Number,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.OR_NUM_OR_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @OR_NUM_Order_Number;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.OR_NUM_StatementType =
                CASE
                    WHEN [NUM].OR_NUM_OR_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @OR_NUM_Order_Number v
        LEFT JOIN
            [dbo].[OR_NUM_Order_Number] [NUM]
        ON
            [NUM].OR_NUM_OR_ID = v.OR_NUM_OR_ID
        AND
            [NUM].OR_NUM_Order_Number = v.OR_NUM_Order_Number
        WHERE
            v.OR_NUM_Version = @currentVersion;
        INSERT INTO [dbo].[OR_NUM_Order_Number] (
            OR_NUM_OR_ID,
            Metadata_OR_NUM,
            OR_NUM_Order_Number
        )
        SELECT
            OR_NUM_OR_ID,
            Metadata_OR_NUM,
            OR_NUM_Order_Number
        FROM
            @OR_NUM_Order_Number
        WHERE
            OR_NUM_Version = @currentVersion
        AND
            OR_NUM_StatementType in ('N');
    END
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_OR_DAT_Order_Date instead of INSERT trigger on OR_DAT_Order_Date
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_OR_DAT_Order_Date', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_OR_DAT_Order_Date];
GO
CREATE TRIGGER [dbo].[it_OR_DAT_Order_Date] ON [dbo].[OR_DAT_Order_Date]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @OR_DAT_Order_Date TABLE (
        OR_DAT_OR_ID int not null,
        Metadata_OR_DAT int not null,
        OR_DAT_Order_Date date not null,
        OR_DAT_Version bigint not null,
        OR_DAT_StatementType char(1) not null,
        primary key(
            OR_DAT_Version,
            OR_DAT_OR_ID
        )
    );
    INSERT INTO @OR_DAT_Order_Date
    SELECT
        i.OR_DAT_OR_ID,
        i.Metadata_OR_DAT,
        i.OR_DAT_Order_Date,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.OR_DAT_OR_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @OR_DAT_Order_Date;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.OR_DAT_StatementType =
                CASE
                    WHEN [DAT].OR_DAT_OR_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @OR_DAT_Order_Date v
        LEFT JOIN
            [dbo].[OR_DAT_Order_Date] [DAT]
        ON
            [DAT].OR_DAT_OR_ID = v.OR_DAT_OR_ID
        AND
            [DAT].OR_DAT_Order_Date = v.OR_DAT_Order_Date
        WHERE
            v.OR_DAT_Version = @currentVersion;
        INSERT INTO [dbo].[OR_DAT_Order_Date] (
            OR_DAT_OR_ID,
            Metadata_OR_DAT,
            OR_DAT_Order_Date
        )
        SELECT
            OR_DAT_OR_ID,
            Metadata_OR_DAT,
            OR_DAT_Order_Date
        FROM
            @OR_DAT_Order_Date
        WHERE
            OR_DAT_Version = @currentVersion
        AND
            OR_DAT_StatementType in ('N');
    END
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_OR_ONL_Order_IsOnline instead of INSERT trigger on OR_ONL_Order_IsOnline
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_OR_ONL_Order_IsOnline', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_OR_ONL_Order_IsOnline];
GO
CREATE TRIGGER [dbo].[it_OR_ONL_Order_IsOnline] ON [dbo].[OR_ONL_Order_IsOnline]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @OR_ONL_Order_IsOnline TABLE (
        OR_ONL_OR_ID int not null,
        Metadata_OR_ONL int not null,
        OR_ONL_Order_IsOnline bit not null,
        OR_ONL_Version bigint not null,
        OR_ONL_StatementType char(1) not null,
        primary key(
            OR_ONL_Version,
            OR_ONL_OR_ID
        )
    );
    INSERT INTO @OR_ONL_Order_IsOnline
    SELECT
        i.OR_ONL_OR_ID,
        i.Metadata_OR_ONL,
        i.OR_ONL_Order_IsOnline,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.OR_ONL_OR_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @OR_ONL_Order_IsOnline;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.OR_ONL_StatementType =
                CASE
                    WHEN [ONL].OR_ONL_OR_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @OR_ONL_Order_IsOnline v
        LEFT JOIN
            [dbo].[OR_ONL_Order_IsOnline] [ONL]
        ON
            [ONL].OR_ONL_OR_ID = v.OR_ONL_OR_ID
        AND
            [ONL].OR_ONL_Order_IsOnline = v.OR_ONL_Order_IsOnline
        WHERE
            v.OR_ONL_Version = @currentVersion;
        INSERT INTO [dbo].[OR_ONL_Order_IsOnline] (
            OR_ONL_OR_ID,
            Metadata_OR_ONL,
            OR_ONL_Order_IsOnline
        )
        SELECT
            OR_ONL_OR_ID,
            Metadata_OR_ONL,
            OR_ONL_Order_IsOnline
        FROM
            @OR_ONL_Order_IsOnline
        WHERE
            OR_ONL_Version = @currentVersion
        AND
            OR_ONL_StatementType in ('N');
    END
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_OR_STO_Order_SubTotal instead of INSERT trigger on OR_STO_Order_SubTotal
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_OR_STO_Order_SubTotal', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_OR_STO_Order_SubTotal];
GO
CREATE TRIGGER [dbo].[it_OR_STO_Order_SubTotal] ON [dbo].[OR_STO_Order_SubTotal]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @OR_STO_Order_SubTotal TABLE (
        OR_STO_OR_ID int not null,
        Metadata_OR_STO int not null,
        OR_STO_Order_SubTotal NUMERIC(18,2) not null,
        OR_STO_Version bigint not null,
        OR_STO_StatementType char(1) not null,
        primary key(
            OR_STO_Version,
            OR_STO_OR_ID
        )
    );
    INSERT INTO @OR_STO_Order_SubTotal
    SELECT
        i.OR_STO_OR_ID,
        i.Metadata_OR_STO,
        i.OR_STO_Order_SubTotal,
        ROW_NUMBER() OVER (
            PARTITION BY
                i.OR_STO_OR_ID
            ORDER BY
                (SELECT 1) ASC -- some undefined order
        ),
        'X'
    FROM
        inserted i;
    SELECT
        @maxVersion = 1,
        @currentVersion = 0
    FROM
        @OR_STO_Order_SubTotal;
    WHILE (@currentVersion < @maxVersion)
    BEGIN
        SET @currentVersion = @currentVersion + 1;
        UPDATE v
        SET
            v.OR_STO_StatementType =
                CASE
                    WHEN [STO].OR_STO_OR_ID is not null
                    THEN 'D' -- duplicate
                    ELSE 'N' -- new statement
                END
        FROM
            @OR_STO_Order_SubTotal v
        LEFT JOIN
            [dbo].[OR_STO_Order_SubTotal] [STO]
        ON
            [STO].OR_STO_OR_ID = v.OR_STO_OR_ID
        AND
            [STO].OR_STO_Order_SubTotal = v.OR_STO_Order_SubTotal
        WHERE
            v.OR_STO_Version = @currentVersion;
        INSERT INTO [dbo].[OR_STO_Order_SubTotal] (
            OR_STO_OR_ID,
            Metadata_OR_STO,
            OR_STO_Order_SubTotal
        )
        SELECT
            OR_STO_OR_ID,
            Metadata_OR_STO,
            OR_STO_Order_SubTotal
        FROM
            @OR_STO_Order_SubTotal
        WHERE
            OR_STO_Version = @currentVersion
        AND
            OR_STO_StatementType in ('N');
    END
END
GO
-- ANCHOR TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_lCU_Customer instead of INSERT trigger on lCU_Customer
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[it_lCU_Customer] ON [dbo].[lCU_Customer]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    DECLARE @CU TABLE (
        Row bigint IDENTITY(1,1) not null primary key,
        CU_ID int not null
    );
    INSERT INTO [dbo].[CU_Customer] (
        Metadata_CU 
    )
    OUTPUT
        inserted.CU_ID
    INTO
        @CU
    SELECT
        Metadata_CU 
    FROM
        inserted
    WHERE
        inserted.CU_ID is null;
    DECLARE @inserted TABLE (
        CU_ID int not null,
        Metadata_CU int not null,
        CU_NAM_CU_ID int null,
        Metadata_CU_NAM int null,
        CU_NAM_Customer_Name varchar(100) null,
        CU_EML_CU_ID int null,
        Metadata_CU_EML int null,
        CU_EML_Customer_EmailAddress varchar(100) null
    );
    INSERT INTO @inserted
    SELECT
        ISNULL(i.CU_ID, a.CU_ID),
        i.Metadata_CU,
        ISNULL(ISNULL(i.CU_NAM_CU_ID, i.CU_ID), a.CU_ID),
        ISNULL(i.Metadata_CU_NAM, i.Metadata_CU),
        i.CU_NAM_Customer_Name,
        ISNULL(ISNULL(i.CU_EML_CU_ID, i.CU_ID), a.CU_ID),
        ISNULL(i.Metadata_CU_EML, i.Metadata_CU),
        i.CU_EML_Customer_EmailAddress
    FROM (
        SELECT
            CU_ID,
            Metadata_CU,
            CU_NAM_CU_ID,
            Metadata_CU_NAM,
            CU_NAM_Customer_Name,
            CU_EML_CU_ID,
            Metadata_CU_EML,
            CU_EML_Customer_EmailAddress,
            ROW_NUMBER() OVER (PARTITION BY CU_ID ORDER BY CU_ID) AS Row
        FROM
            inserted
    ) i
    LEFT JOIN
        @CU a
    ON
        a.Row = i.Row;
    INSERT INTO [dbo].[CU_NAM_Customer_Name] (
        Metadata_CU_NAM,
        CU_NAM_CU_ID,
        CU_NAM_Customer_Name
    )
    SELECT
        i.Metadata_CU_NAM,
        i.CU_NAM_CU_ID,
        i.CU_NAM_Customer_Name
    FROM
        @inserted i
    WHERE
        i.CU_NAM_Customer_Name is not null;
    INSERT INTO [dbo].[CU_EML_Customer_EmailAddress] (
        Metadata_CU_EML,
        CU_EML_CU_ID,
        CU_EML_Customer_EmailAddress
    )
    SELECT
        i.Metadata_CU_EML,
        i.CU_EML_CU_ID,
        i.CU_EML_Customer_EmailAddress
    FROM
        @inserted i
    WHERE
        i.CU_EML_Customer_EmailAddress is not null;
END
GO
-- UPDATE trigger -----------------------------------------------------------------------------------------------------
-- ut_lCU_Customer instead of UPDATE trigger on lCU_Customer
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[ut_lCU_Customer] ON [dbo].[lCU_Customer]
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    IF(UPDATE(CU_ID))
        RAISERROR('The identity column CU_ID is not updatable.', 16, 1);
    IF(UPDATE(CU_NAM_CU_ID))
        RAISERROR('The foreign key column CU_NAM_CU_ID is not updatable.', 16, 1);
    IF(UPDATE(CU_NAM_Customer_Name))
    BEGIN
        INSERT INTO [dbo].[CU_NAM_Customer_Name] (
            Metadata_CU_NAM,
            CU_NAM_CU_ID,
            CU_NAM_Customer_Name
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_CU) AND NOT UPDATE(Metadata_CU_NAM)
                THEN i.Metadata_CU
                ELSE i.Metadata_CU_NAM
            END, i.Metadata_CU),
            ISNULL(i.CU_NAM_CU_ID, i.CU_ID),
            i.CU_NAM_Customer_Name
        FROM
            inserted i
        WHERE
            i.CU_NAM_Customer_Name is not null;
    END
    IF(UPDATE(CU_EML_CU_ID))
        RAISERROR('The foreign key column CU_EML_CU_ID is not updatable.', 16, 1);
    IF(UPDATE(CU_EML_Customer_EmailAddress))
    BEGIN
        INSERT INTO [dbo].[CU_EML_Customer_EmailAddress] (
            Metadata_CU_EML,
            CU_EML_CU_ID,
            CU_EML_Customer_EmailAddress
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_CU) AND NOT UPDATE(Metadata_CU_EML)
                THEN i.Metadata_CU
                ELSE i.Metadata_CU_EML
            END, i.Metadata_CU),
            ISNULL(i.CU_EML_CU_ID, i.CU_ID),
            i.CU_EML_Customer_EmailAddress
        FROM
            inserted i
        WHERE
            i.CU_EML_Customer_EmailAddress is not null;
    END
END
GO
-- DELETE trigger -----------------------------------------------------------------------------------------------------
-- dt_lCU_Customer instead of DELETE trigger on lCU_Customer
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[dt_lCU_Customer] ON [dbo].[lCU_Customer]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE [NAM]
    FROM
        [dbo].[CU_NAM_Customer_Name] [NAM]
    JOIN
        deleted d
    ON
        d.CU_NAM_CU_ID = [NAM].CU_NAM_CU_ID;
    DELETE [EML]
    FROM
        [dbo].[CU_EML_Customer_EmailAddress] [EML]
    JOIN
        deleted d
    ON
        d.CU_EML_CU_ID = [EML].CU_EML_CU_ID;
    DELETE [CU]
    FROM
        [dbo].[CU_Customer] [CU]
    JOIN 
        deleted d 
    ON 
        d.CU_ID = [CU].CU_ID
    LEFT JOIN
        [dbo].[CU_NAM_Customer_Name] [NAM]
    ON
        [NAM].CU_NAM_CU_ID = [CU].CU_ID
    LEFT JOIN
        [dbo].[CU_EML_Customer_EmailAddress] [EML]
    ON
        [EML].CU_EML_CU_ID = [CU].CU_ID
    WHERE
        [NAM].CU_NAM_CU_ID is null
    AND
        [EML].CU_EML_CU_ID is null;
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_lOR_Order instead of INSERT trigger on lOR_Order
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[it_lOR_Order] ON [dbo].[lOR_Order]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    DECLARE @OR TABLE (
        Row bigint IDENTITY(1,1) not null primary key,
        OR_ID int not null
    );
    INSERT INTO [dbo].[OR_Order] (
        Metadata_OR 
    )
    OUTPUT
        inserted.OR_ID
    INTO
        @OR
    SELECT
        Metadata_OR 
    FROM
        inserted
    WHERE
        inserted.OR_ID is null;
    DECLARE @inserted TABLE (
        OR_ID int not null,
        Metadata_OR int not null,
        OR_NUM_OR_ID int null,
        Metadata_OR_NUM int null,
        OR_NUM_Order_Number varchar(15) null,
        OR_DAT_OR_ID int null,
        Metadata_OR_DAT int null,
        OR_DAT_Order_Date date null,
        OR_ONL_OR_ID int null,
        Metadata_OR_ONL int null,
        OR_ONL_Order_IsOnline bit null,
        OR_STO_OR_ID int null,
        Metadata_OR_STO int null,
        OR_STO_Order_SubTotal NUMERIC(18,2) null
    );
    INSERT INTO @inserted
    SELECT
        ISNULL(i.OR_ID, a.OR_ID),
        i.Metadata_OR,
        ISNULL(ISNULL(i.OR_NUM_OR_ID, i.OR_ID), a.OR_ID),
        ISNULL(i.Metadata_OR_NUM, i.Metadata_OR),
        i.OR_NUM_Order_Number,
        ISNULL(ISNULL(i.OR_DAT_OR_ID, i.OR_ID), a.OR_ID),
        ISNULL(i.Metadata_OR_DAT, i.Metadata_OR),
        i.OR_DAT_Order_Date,
        ISNULL(ISNULL(i.OR_ONL_OR_ID, i.OR_ID), a.OR_ID),
        ISNULL(i.Metadata_OR_ONL, i.Metadata_OR),
        i.OR_ONL_Order_IsOnline,
        ISNULL(ISNULL(i.OR_STO_OR_ID, i.OR_ID), a.OR_ID),
        ISNULL(i.Metadata_OR_STO, i.Metadata_OR),
        i.OR_STO_Order_SubTotal
    FROM (
        SELECT
            OR_ID,
            Metadata_OR,
            OR_NUM_OR_ID,
            Metadata_OR_NUM,
            OR_NUM_Order_Number,
            OR_DAT_OR_ID,
            Metadata_OR_DAT,
            OR_DAT_Order_Date,
            OR_ONL_OR_ID,
            Metadata_OR_ONL,
            OR_ONL_Order_IsOnline,
            OR_STO_OR_ID,
            Metadata_OR_STO,
            OR_STO_Order_SubTotal,
            ROW_NUMBER() OVER (PARTITION BY OR_ID ORDER BY OR_ID) AS Row
        FROM
            inserted
    ) i
    LEFT JOIN
        @OR a
    ON
        a.Row = i.Row;
    INSERT INTO [dbo].[OR_NUM_Order_Number] (
        Metadata_OR_NUM,
        OR_NUM_OR_ID,
        OR_NUM_Order_Number
    )
    SELECT
        i.Metadata_OR_NUM,
        i.OR_NUM_OR_ID,
        i.OR_NUM_Order_Number
    FROM
        @inserted i
    WHERE
        i.OR_NUM_Order_Number is not null;
    INSERT INTO [dbo].[OR_DAT_Order_Date] (
        Metadata_OR_DAT,
        OR_DAT_OR_ID,
        OR_DAT_Order_Date
    )
    SELECT
        i.Metadata_OR_DAT,
        i.OR_DAT_OR_ID,
        i.OR_DAT_Order_Date
    FROM
        @inserted i
    WHERE
        i.OR_DAT_Order_Date is not null;
    INSERT INTO [dbo].[OR_ONL_Order_IsOnline] (
        Metadata_OR_ONL,
        OR_ONL_OR_ID,
        OR_ONL_Order_IsOnline
    )
    SELECT
        i.Metadata_OR_ONL,
        i.OR_ONL_OR_ID,
        i.OR_ONL_Order_IsOnline
    FROM
        @inserted i
    WHERE
        i.OR_ONL_Order_IsOnline is not null;
    INSERT INTO [dbo].[OR_STO_Order_SubTotal] (
        Metadata_OR_STO,
        OR_STO_OR_ID,
        OR_STO_Order_SubTotal
    )
    SELECT
        i.Metadata_OR_STO,
        i.OR_STO_OR_ID,
        i.OR_STO_Order_SubTotal
    FROM
        @inserted i
    WHERE
        i.OR_STO_Order_SubTotal is not null;
END
GO
-- UPDATE trigger -----------------------------------------------------------------------------------------------------
-- ut_lOR_Order instead of UPDATE trigger on lOR_Order
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[ut_lOR_Order] ON [dbo].[lOR_Order]
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    IF(UPDATE(OR_ID))
        RAISERROR('The identity column OR_ID is not updatable.', 16, 1);
    IF(UPDATE(OR_NUM_OR_ID))
        RAISERROR('The foreign key column OR_NUM_OR_ID is not updatable.', 16, 1);
    IF(UPDATE(OR_NUM_Order_Number))
    BEGIN
        INSERT INTO [dbo].[OR_NUM_Order_Number] (
            Metadata_OR_NUM,
            OR_NUM_OR_ID,
            OR_NUM_Order_Number
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_OR) AND NOT UPDATE(Metadata_OR_NUM)
                THEN i.Metadata_OR
                ELSE i.Metadata_OR_NUM
            END, i.Metadata_OR),
            ISNULL(i.OR_NUM_OR_ID, i.OR_ID),
            i.OR_NUM_Order_Number
        FROM
            inserted i
        WHERE
            i.OR_NUM_Order_Number is not null;
    END
    IF(UPDATE(OR_DAT_OR_ID))
        RAISERROR('The foreign key column OR_DAT_OR_ID is not updatable.', 16, 1);
    IF(UPDATE(OR_DAT_Order_Date))
    BEGIN
        INSERT INTO [dbo].[OR_DAT_Order_Date] (
            Metadata_OR_DAT,
            OR_DAT_OR_ID,
            OR_DAT_Order_Date
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_OR) AND NOT UPDATE(Metadata_OR_DAT)
                THEN i.Metadata_OR
                ELSE i.Metadata_OR_DAT
            END, i.Metadata_OR),
            ISNULL(i.OR_DAT_OR_ID, i.OR_ID),
            i.OR_DAT_Order_Date
        FROM
            inserted i
        WHERE
            i.OR_DAT_Order_Date is not null;
    END
    IF(UPDATE(OR_ONL_OR_ID))
        RAISERROR('The foreign key column OR_ONL_OR_ID is not updatable.', 16, 1);
    IF(UPDATE(OR_ONL_Order_IsOnline))
    BEGIN
        INSERT INTO [dbo].[OR_ONL_Order_IsOnline] (
            Metadata_OR_ONL,
            OR_ONL_OR_ID,
            OR_ONL_Order_IsOnline
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_OR) AND NOT UPDATE(Metadata_OR_ONL)
                THEN i.Metadata_OR
                ELSE i.Metadata_OR_ONL
            END, i.Metadata_OR),
            ISNULL(i.OR_ONL_OR_ID, i.OR_ID),
            i.OR_ONL_Order_IsOnline
        FROM
            inserted i
        WHERE
            i.OR_ONL_Order_IsOnline is not null;
    END
    IF(UPDATE(OR_STO_OR_ID))
        RAISERROR('The foreign key column OR_STO_OR_ID is not updatable.', 16, 1);
    IF(UPDATE(OR_STO_Order_SubTotal))
    BEGIN
        INSERT INTO [dbo].[OR_STO_Order_SubTotal] (
            Metadata_OR_STO,
            OR_STO_OR_ID,
            OR_STO_Order_SubTotal
        )
        SELECT
            ISNULL(CASE
                WHEN UPDATE(Metadata_OR) AND NOT UPDATE(Metadata_OR_STO)
                THEN i.Metadata_OR
                ELSE i.Metadata_OR_STO
            END, i.Metadata_OR),
            ISNULL(i.OR_STO_OR_ID, i.OR_ID),
            i.OR_STO_Order_SubTotal
        FROM
            inserted i
        WHERE
            i.OR_STO_Order_SubTotal is not null;
    END
END
GO
-- DELETE trigger -----------------------------------------------------------------------------------------------------
-- dt_lOR_Order instead of DELETE trigger on lOR_Order
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[dt_lOR_Order] ON [dbo].[lOR_Order]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE [NUM]
    FROM
        [dbo].[OR_NUM_Order_Number] [NUM]
    JOIN
        deleted d
    ON
        d.OR_NUM_OR_ID = [NUM].OR_NUM_OR_ID;
    DELETE [DAT]
    FROM
        [dbo].[OR_DAT_Order_Date] [DAT]
    JOIN
        deleted d
    ON
        d.OR_DAT_OR_ID = [DAT].OR_DAT_OR_ID;
    DELETE [ONL]
    FROM
        [dbo].[OR_ONL_Order_IsOnline] [ONL]
    JOIN
        deleted d
    ON
        d.OR_ONL_OR_ID = [ONL].OR_ONL_OR_ID;
    DELETE [STO]
    FROM
        [dbo].[OR_STO_Order_SubTotal] [STO]
    JOIN
        deleted d
    ON
        d.OR_STO_OR_ID = [STO].OR_STO_OR_ID;
    DELETE [OR]
    FROM
        [dbo].[OR_Order] [OR]
    JOIN 
        deleted d 
    ON 
        d.OR_ID = [OR].OR_ID
    LEFT JOIN
        [dbo].[OR_NUM_Order_Number] [NUM]
    ON
        [NUM].OR_NUM_OR_ID = [OR].OR_ID
    LEFT JOIN
        [dbo].[OR_DAT_Order_Date] [DAT]
    ON
        [DAT].OR_DAT_OR_ID = [OR].OR_ID
    LEFT JOIN
        [dbo].[OR_ONL_Order_IsOnline] [ONL]
    ON
        [ONL].OR_ONL_OR_ID = [OR].OR_ID
    LEFT JOIN
        [dbo].[OR_STO_Order_SubTotal] [STO]
    ON
        [STO].OR_STO_OR_ID = [OR].OR_ID
    WHERE
        [NUM].OR_NUM_OR_ID is null
    AND
        [DAT].OR_DAT_OR_ID is null
    AND
        [ONL].OR_ONL_OR_ID is null
    AND
        [STO].OR_STO_OR_ID is null;
END
GO
-- TIE TEMPORAL BUSINESS PERSPECTIVES ---------------------------------------------------------------------------------
--
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.Difference_Customer_by_Order_isPlaced', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Difference_Customer_by_Order_isPlaced];
IF Object_ID('dbo.Current_Customer_by_Order_isPlaced', 'V') IS NOT NULL
DROP VIEW [dbo].[Current_Customer_by_Order_isPlaced];
IF Object_ID('dbo.Point_Customer_by_Order_isPlaced', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[Point_Customer_by_Order_isPlaced];
IF Object_ID('dbo.Latest_Customer_by_Order_isPlaced', 'V') IS NOT NULL
DROP VIEW [dbo].[Latest_Customer_by_Order_isPlaced];
GO
-- TIE TEMPORAL PERSPECTIVES ------------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each tie. There are four types of perspectives: latest,
-- point-in-time, difference, and now.
--
-- The latest perspective shows the latest available information for each tie.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- @equivalent the equivalent for which to retrieve data
--
-- Drop perspectives --------------------------------------------------------------------------------------------------
IF Object_ID('dbo.dCU_by_OR_isPlaced', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[dCU_by_OR_isPlaced];
IF Object_ID('dbo.nCU_by_OR_isPlaced', 'V') IS NOT NULL
DROP VIEW [dbo].[nCU_by_OR_isPlaced];
IF Object_ID('dbo.pCU_by_OR_isPlaced', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[pCU_by_OR_isPlaced];
IF Object_ID('dbo.lCU_by_OR_isPlaced', 'V') IS NOT NULL
DROP VIEW [dbo].[lCU_by_OR_isPlaced];
GO
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lCU_by_OR_isPlaced viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[lCU_by_OR_isPlaced] WITH SCHEMABINDING AS
SELECT
    tie.Metadata_CU_by_OR_isPlaced,
    tie.CU_ID_by,
    tie.OR_ID_isPlaced
FROM
    [dbo].[CU_by_OR_isPlaced] tie;
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pCU_by_OR_isPlaced viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[pCU_by_OR_isPlaced] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE WITH SCHEMABINDING AS RETURN
SELECT
    tie.Metadata_CU_by_OR_isPlaced,
    tie.CU_ID_by,
    tie.OR_ID_isPlaced
FROM
    [dbo].[CU_by_OR_isPlaced] tie;
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nCU_by_OR_isPlaced viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[nCU_by_OR_isPlaced]
AS
SELECT
    *
FROM
    [dbo].[pCU_by_OR_isPlaced](sysdatetime());
GO
-- TIE TEMPORAL BUSINESS PERSPECTIVES ---------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each tie. There are four types of perspectives: latest,
-- point-in-time, difference, and now.
--
-- The latest perspective shows the latest available information for each tie.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- @equivalent the equivalent for which to retrieve data
--
-- Latest perspective -------------------------------------------------------------------------------------------------
-- Latest_Customer_by_Order_isPlaced viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Latest_Customer_by_Order_isPlaced] AS
SELECT
    tie.CU_ID_by as [Customer_by_Id],
    tie.OR_ID_isPlaced as [Order_isPlaced_Id]
FROM
    [dbo].[lCU_by_OR_isPlaced] tie;
GO
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- Point_Customer_by_Order_isPlaced viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[Point_Customer_by_Order_isPlaced] (
    @changingTimepoint datetime2(7)
)
RETURNS TABLE AS RETURN
SELECT
    tie.CU_ID_by as [Customer_by_Id],
    tie.OR_ID_isPlaced as [Order_isPlaced_Id]
FROM
    [dbo].[pCU_by_OR_isPlaced](@changingTimepoint) tie
GO
-- Now perspective ----------------------------------------------------------------------------------------------------
-- Current_Customer_by_Order_isPlaced viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Current_Customer_by_Order_isPlaced]
AS
SELECT
    *
FROM
    [dbo].[Point_Customer_by_Order_isPlaced](sysdatetime());
GO
-- TIE TRIGGERS -------------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent ties, only changes that represent values different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_CU_by_OR_isPlaced instead of INSERT trigger on CU_by_OR_isPlaced
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo.it_CU_by_OR_isPlaced', 'TR') IS NOT NULL
DROP TRIGGER [dbo].[it_CU_by_OR_isPlaced];
GO
CREATE TRIGGER [dbo].[it_CU_by_OR_isPlaced] ON [dbo].[CU_by_OR_isPlaced]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    DECLARE @maxVersion int;
    DECLARE @currentVersion int;
    DECLARE @inserted TABLE (
        Metadata_CU_by_OR_isPlaced int not null,
        CU_ID_by int not null,
        OR_ID_isPlaced int not null,
        primary key (
            CU_ID_by,
            OR_ID_isPlaced
        )
    );
    INSERT INTO @inserted
    SELECT
        ISNULL(i.Metadata_CU_by_OR_isPlaced, 0),
        i.CU_ID_by,
        i.OR_ID_isPlaced
    FROM
        inserted i
    WHERE
        i.CU_ID_by is not null
    AND
        i.OR_ID_isPlaced is not null;
    INSERT INTO [dbo].[CU_by_OR_isPlaced] (
        Metadata_CU_by_OR_isPlaced,
        CU_ID_by,
        OR_ID_isPlaced
    )
    SELECT
        i.Metadata_CU_by_OR_isPlaced,
        i.CU_ID_by,
        i.OR_ID_isPlaced
    FROM
        @inserted i
    LEFT JOIN
        [dbo].[CU_by_OR_isPlaced] tie
    ON
        tie.CU_ID_by = i.CU_ID_by
    AND
        tie.OR_ID_isPlaced = i.OR_ID_isPlaced
    WHERE
        tie.OR_ID_isPlaced is null;
END
GO
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- it_lCU_by_OR_isPlaced instead of INSERT trigger on lCU_by_OR_isPlaced
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[it_lCU_by_OR_isPlaced] ON [dbo].[lCU_by_OR_isPlaced]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now datetime2(7);
    SET @now = sysdatetime();
    INSERT INTO [dbo].[CU_by_OR_isPlaced] (
        Metadata_CU_by_OR_isPlaced,
        CU_ID_by,
        OR_ID_isPlaced
    )
    SELECT
        i.Metadata_CU_by_OR_isPlaced,
        i.CU_ID_by,
        i.OR_ID_isPlaced
    FROM
        inserted i;
END
GO
-- DELETE trigger -----------------------------------------------------------------------------------------------------
-- dt_lCU_by_OR_isPlaced instead of DELETE trigger on lCU_by_OR_isPlaced
-----------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER [dbo].[dt_lCU_by_OR_isPlaced] ON [dbo].[lCU_by_OR_isPlaced]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE tie
    FROM
        [dbo].[CU_by_OR_isPlaced] tie
    JOIN
        deleted d
    ON
        d.CU_ID_by = tie.CU_ID_by
    AND
        d.OR_ID_isPlaced = tie.OR_ID_isPlaced;
END
GO
-- SCHEMA EVOLUTION ---------------------------------------------------------------------------------------------------
--
-- The following tables, views, and functions are used to track schema changes
-- over time, as well as providing every XML that has been 'executed' against
-- the database.
--
-- Schema table -------------------------------------------------------------------------------------------------------
-- The schema table holds every xml that has been executed against the database
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Schema', 'U') IS NULL
   CREATE TABLE [dbo].[_Schema] (
      [version] int identity(1, 1) not null,
      [activation] datetime2(7) not null,
      [schema] xml not null,
      constraint pk_Schema primary key (
         [version]
      )
   );
GO
-- Insert the XML schema (as of now)
INSERT INTO [dbo].[_Schema] (
   [activation],
   [schema]
)
SELECT
   current_timestamp,
   N'<schema format="0.99.6.3-2" date="2021-10-28" time="20:28:40"><metadata changingRange="datetime" encapsulation="dbo" identity="int" metadataPrefix="Metadata" metadataType="int" metadataUsage="true" changingSuffix="ChangedAt" identitySuffix="ID" positIdentity="int" positGenerator="true" positingRange="datetime" positingSuffix="PositedAt" positorRange="tinyint" positorSuffix="Positor" reliabilityRange="decimal(5,2)" reliabilitySuffix="Reliability" deleteReliability="0" assertionSuffix="Assertion" partitioning="false" entityIntegrity="true" restatability="true" idempotency="false" assertiveness="true" naming="improved" positSuffix="Posit" annexSuffix="Annex" chronon="datetime2(7)" now="sysdatetime()" dummySuffix="Dummy" versionSuffix="Version" statementTypeSuffix="StatementType" checksumSuffix="Checksum" businessViews="true" decisiveness="true" equivalence="false" equivalentSuffix="EQ" equivalentRange="tinyint" databaseTarget="SQLServer" temporalization="uni" deletability="false" deletablePrefix="Deletable" deletionSuffix="Deleted" privacy="Ignore" checksum="false" triggers="true"/><anchor mnemonic="CU" descriptor="Customer" identity="int"><metadata capsule="dbo" generator="true"/><attribute mnemonic="NAM" descriptor="Name" dataRange="varchar(100)"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="1008.01" y="625.48" fixed="false"/></attribute><attribute mnemonic="EML" descriptor="EmailAddress" dataRange="varchar(100)"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="950.53" y="563.63" fixed="false"/></attribute><layout x="953.22" y="648.40" fixed="false"/></anchor><tie><anchorRole role="by" type="CU" identifier="true"/><anchorRole role="isPlaced" type="OR" identifier="true"/><metadata capsule="dbo" deletable="false"/><layout x="919.19" y="709.44" fixed="false"/></tie><anchor mnemonic="OR" descriptor="Order" identity="int"><metadata capsule="dbo" generator="true"/><attribute mnemonic="NUM" descriptor="Number" dataRange="varchar(15)"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="891.44" y="871.82" fixed="false"/></attribute><attribute mnemonic="DAT" descriptor="Date" dataRange="date"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="753.94" y="862.63" fixed="false"/></attribute><attribute mnemonic="ONL" descriptor="IsOnline" dataRange="bit"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="705.66" y="790.42" fixed="false"/></attribute><attribute mnemonic="STO" descriptor="SubTotal" dataRange="NUMERIC(18,2)"><metadata privacy="Ignore" capsule="dbo" deletable="false"/><layout x="791.23" y="738.37" fixed="false"/></attribute><layout x="870.02" y="812.30" fixed="true"/></anchor></schema>';
GO
-- Schema expanded view -----------------------------------------------------------------------------------------------
-- A view of the schema table that expands the XML attributes into columns
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Schema_Expanded', 'V') IS NOT NULL
DROP VIEW [dbo].[_Schema_Expanded]
GO
CREATE VIEW [dbo].[_Schema_Expanded]
AS
SELECT
	[version],
	[activation],
	[schema],
	[schema].value('schema[1]/@format', 'nvarchar(max)') as [format],
	[schema].value('schema[1]/@date', 'datetime') + [schema].value('schema[1]/@time', 'datetime') as [date],
	[schema].value('schema[1]/metadata[1]/@temporalization', 'nvarchar(max)') as [temporalization],
	[schema].value('schema[1]/metadata[1]/@databaseTarget', 'nvarchar(max)') as [databaseTarget],
	[schema].value('schema[1]/metadata[1]/@changingRange', 'nvarchar(max)') as [changingRange],
	[schema].value('schema[1]/metadata[1]/@encapsulation', 'nvarchar(max)') as [encapsulation],
	[schema].value('schema[1]/metadata[1]/@identity', 'nvarchar(max)') as [identity],
	[schema].value('schema[1]/metadata[1]/@metadataPrefix', 'nvarchar(max)') as [metadataPrefix],
	[schema].value('schema[1]/metadata[1]/@metadataType', 'nvarchar(max)') as [metadataType],
	[schema].value('schema[1]/metadata[1]/@metadataUsage', 'nvarchar(max)') as [metadataUsage],
	[schema].value('schema[1]/metadata[1]/@changingSuffix', 'nvarchar(max)') as [changingSuffix],
	[schema].value('schema[1]/metadata[1]/@identitySuffix', 'nvarchar(max)') as [identitySuffix],
	[schema].value('schema[1]/metadata[1]/@positIdentity', 'nvarchar(max)') as [positIdentity],
	[schema].value('schema[1]/metadata[1]/@positGenerator', 'nvarchar(max)') as [positGenerator],
	[schema].value('schema[1]/metadata[1]/@positingRange', 'nvarchar(max)') as [positingRange],
	[schema].value('schema[1]/metadata[1]/@positingSuffix', 'nvarchar(max)') as [positingSuffix],
	[schema].value('schema[1]/metadata[1]/@positorRange', 'nvarchar(max)') as [positorRange],
	[schema].value('schema[1]/metadata[1]/@positorSuffix', 'nvarchar(max)') as [positorSuffix],
	[schema].value('schema[1]/metadata[1]/@reliabilityRange', 'nvarchar(max)') as [reliabilityRange],
	[schema].value('schema[1]/metadata[1]/@reliabilitySuffix', 'nvarchar(max)') as [reliabilitySuffix],
	[schema].value('schema[1]/metadata[1]/@deleteReliability', 'nvarchar(max)') as [deleteReliability],
	[schema].value('schema[1]/metadata[1]/@assertionSuffix', 'nvarchar(max)') as [assertionSuffix],
	[schema].value('schema[1]/metadata[1]/@partitioning', 'nvarchar(max)') as [partitioning],
	[schema].value('schema[1]/metadata[1]/@entityIntegrity', 'nvarchar(max)') as [entityIntegrity],
	[schema].value('schema[1]/metadata[1]/@restatability', 'nvarchar(max)') as [restatability],
	[schema].value('schema[1]/metadata[1]/@idempotency', 'nvarchar(max)') as [idempotency],
	[schema].value('schema[1]/metadata[1]/@assertiveness', 'nvarchar(max)') as [assertiveness],
	[schema].value('schema[1]/metadata[1]/@naming', 'nvarchar(max)') as [naming],
	[schema].value('schema[1]/metadata[1]/@positSuffix', 'nvarchar(max)') as [positSuffix],
	[schema].value('schema[1]/metadata[1]/@annexSuffix', 'nvarchar(max)') as [annexSuffix],
	[schema].value('schema[1]/metadata[1]/@chronon', 'nvarchar(max)') as [chronon],
	[schema].value('schema[1]/metadata[1]/@now', 'nvarchar(max)') as [now],
	[schema].value('schema[1]/metadata[1]/@dummySuffix', 'nvarchar(max)') as [dummySuffix],
	[schema].value('schema[1]/metadata[1]/@statementTypeSuffix', 'nvarchar(max)') as [statementTypeSuffix],
	[schema].value('schema[1]/metadata[1]/@checksumSuffix', 'nvarchar(max)') as [checksumSuffix],
	[schema].value('schema[1]/metadata[1]/@businessViews', 'nvarchar(max)') as [businessViews],
	[schema].value('schema[1]/metadata[1]/@equivalence', 'nvarchar(max)') as [equivalence],
	[schema].value('schema[1]/metadata[1]/@equivalentSuffix', 'nvarchar(max)') as [equivalentSuffix],
	[schema].value('schema[1]/metadata[1]/@equivalentRange', 'nvarchar(max)') as [equivalentRange]
FROM
	_Schema;
GO
-- Anchor view --------------------------------------------------------------------------------------------------------
-- The anchor view shows information about all the anchors in a schema
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Anchor', 'V') IS NOT NULL
DROP VIEW [dbo].[_Anchor]
GO
CREATE VIEW [dbo].[_Anchor]
AS
SELECT
   S.version,
   S.activation,
   Nodeset.anchor.value('concat(@mnemonic, "_", @descriptor)', 'nvarchar(max)') as [name],
   Nodeset.anchor.value('metadata[1]/@capsule', 'nvarchar(max)') as [capsule],
   Nodeset.anchor.value('@mnemonic', 'nvarchar(max)') as [mnemonic],
   Nodeset.anchor.value('@descriptor', 'nvarchar(max)') as [descriptor],
   Nodeset.anchor.value('@identity', 'nvarchar(max)') as [identity],
   Nodeset.anchor.value('metadata[1]/@generator', 'nvarchar(max)') as [generator],
   Nodeset.anchor.value('count(attribute)', 'int') as [numberOfAttributes],
   Nodeset.anchor.value('description[1]/.', 'nvarchar(max)') as [description]
FROM
   [dbo].[_Schema] S
CROSS APPLY
   S.[schema].nodes('/schema/anchor') as Nodeset(anchor);
GO
-- Knot view ----------------------------------------------------------------------------------------------------------
-- The knot view shows information about all the knots in a schema
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Knot', 'V') IS NOT NULL
DROP VIEW [dbo].[_Knot]
GO
CREATE VIEW [dbo].[_Knot]
AS
SELECT
   S.version,
   S.activation,
   Nodeset.knot.value('concat(@mnemonic, "_", @descriptor)', 'nvarchar(max)') as [name],
   Nodeset.knot.value('metadata[1]/@capsule', 'nvarchar(max)') as [capsule],
   Nodeset.knot.value('@mnemonic', 'nvarchar(max)') as [mnemonic],
   Nodeset.knot.value('@descriptor', 'nvarchar(max)') as [descriptor],
   Nodeset.knot.value('@identity', 'nvarchar(max)') as [identity],
   Nodeset.knot.value('metadata[1]/@generator', 'nvarchar(max)') as [generator],
   Nodeset.knot.value('@dataRange', 'nvarchar(max)') as [dataRange],
   isnull(Nodeset.knot.value('metadata[1]/@checksum', 'nvarchar(max)'), 'false') as [checksum],
   isnull(Nodeset.knot.value('metadata[1]/@equivalent', 'nvarchar(max)'), 'false') as [equivalent],
   Nodeset.knot.value('description[1]/.', 'nvarchar(max)') as [description]
FROM
   [dbo].[_Schema] S
CROSS APPLY
   S.[schema].nodes('/schema/knot') as Nodeset(knot);
GO
-- Attribute view -----------------------------------------------------------------------------------------------------
-- The attribute view shows information about all the attributes in a schema
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Attribute', 'V') IS NOT NULL
DROP VIEW [dbo].[_Attribute]
GO
CREATE VIEW [dbo].[_Attribute]
AS
SELECT
   S.version,
   S.activation,
   ParentNodeset.anchor.value('concat(@mnemonic, "_")', 'nvarchar(max)') +
   Nodeset.attribute.value('concat(@mnemonic, "_")', 'nvarchar(max)') +
   ParentNodeset.anchor.value('concat(@descriptor, "_")', 'nvarchar(max)') +
   Nodeset.attribute.value('@descriptor', 'nvarchar(max)') as [name],
   Nodeset.attribute.value('metadata[1]/@capsule', 'nvarchar(max)') as [capsule],
   Nodeset.attribute.value('@mnemonic', 'nvarchar(max)') as [mnemonic],
   Nodeset.attribute.value('@descriptor', 'nvarchar(max)') as [descriptor],
   Nodeset.attribute.value('@identity', 'nvarchar(max)') as [identity],
   isnull(Nodeset.attribute.value('metadata[1]/@equivalent', 'nvarchar(max)'), 'false') as [equivalent],
   Nodeset.attribute.value('metadata[1]/@generator', 'nvarchar(max)') as [generator],
   Nodeset.attribute.value('metadata[1]/@assertive', 'nvarchar(max)') as [assertive],
   Nodeset.attribute.value('metadata[1]/@privacy', 'nvarchar(max)') as [privacy],
   isnull(Nodeset.attribute.value('metadata[1]/@checksum', 'nvarchar(max)'), 'false') as [checksum],
   Nodeset.attribute.value('metadata[1]/@restatable', 'nvarchar(max)') as [restatable],
   Nodeset.attribute.value('metadata[1]/@idempotent', 'nvarchar(max)') as [idempotent],
   ParentNodeset.anchor.value('@mnemonic', 'nvarchar(max)') as [anchorMnemonic],
   ParentNodeset.anchor.value('@descriptor', 'nvarchar(max)') as [anchorDescriptor],
   ParentNodeset.anchor.value('@identity', 'nvarchar(max)') as [anchorIdentity],
   Nodeset.attribute.value('@dataRange', 'nvarchar(max)') as [dataRange],
   Nodeset.attribute.value('@knotRange', 'nvarchar(max)') as [knotRange],
   Nodeset.attribute.value('@timeRange', 'nvarchar(max)') as [timeRange],
   Nodeset.attribute.value('metadata[1]/@deletable', 'nvarchar(max)') as [deletable],
   Nodeset.attribute.value('metadata[1]/@encryptionGroup', 'nvarchar(max)') as [encryptionGroup],
   Nodeset.attribute.value('description[1]/.', 'nvarchar(max)') as [description]
FROM
   [dbo].[_Schema] S
CROSS APPLY
   S.[schema].nodes('/schema/anchor') as ParentNodeset(anchor)
OUTER APPLY
   ParentNodeset.anchor.nodes('attribute') as Nodeset(attribute);
GO
-- Tie view -----------------------------------------------------------------------------------------------------------
-- The tie view shows information about all the ties in a schema
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Tie', 'V') IS NOT NULL
DROP VIEW [dbo].[_Tie]
GO
CREATE VIEW [dbo].[_Tie]
AS
SELECT
   S.version,
   S.activation,
   REPLACE(Nodeset.tie.query('
      for $role in *[local-name() = "anchorRole" or local-name() = "knotRole"]
      return concat($role/@type, "_", $role/@role)
   ').value('.', 'nvarchar(max)'), ' ', '_') as [name],
   Nodeset.tie.value('metadata[1]/@capsule', 'nvarchar(max)') as [capsule],
   Nodeset.tie.value('count(anchorRole) + count(knotRole)', 'int') as [numberOfRoles],
   Nodeset.tie.query('
      for $role in *[local-name() = "anchorRole" or local-name() = "knotRole"]
      return string($role/@role)
   ').value('.', 'nvarchar(max)') as [roles],
   Nodeset.tie.value('count(anchorRole)', 'int') as [numberOfAnchors],
   Nodeset.tie.query('
      for $role in anchorRole
      return string($role/@type)
   ').value('.', 'nvarchar(max)') as [anchors],
   Nodeset.tie.value('count(knotRole)', 'int') as [numberOfKnots],
   Nodeset.tie.query('
      for $role in knotRole
      return string($role/@type)
   ').value('.', 'nvarchar(max)') as [knots],
   Nodeset.tie.value('count(*[local-name() = "anchorRole" or local-name() = "knotRole"][@identifier = "true"])', 'int') as [numberOfIdentifiers],
   Nodeset.tie.query('
      for $role in *[local-name() = "anchorRole" or local-name() = "knotRole"][@identifier = "true"]
      return string($role/@type)
   ').value('.', 'nvarchar(max)') as [identifiers],
   Nodeset.tie.value('@timeRange', 'nvarchar(max)') as [timeRange],
   Nodeset.tie.value('metadata[1]/@generator', 'nvarchar(max)') as [generator],
   Nodeset.tie.value('metadata[1]/@assertive', 'nvarchar(max)') as [assertive],
   Nodeset.tie.value('metadata[1]/@restatable', 'nvarchar(max)') as [restatable],
   Nodeset.tie.value('metadata[1]/@idempotent', 'nvarchar(max)') as [idempotent],
   Nodeset.tie.value('description[1]/.', 'nvarchar(max)') as [description]
FROM
   [dbo].[_Schema] S
CROSS APPLY
   S.[schema].nodes('/schema/tie') as Nodeset(tie);
GO
-- Key view -----------------------------------------------------------------------------------------------------------
-- The key view shows information about all the keys in a schema
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Key', 'V') IS NOT NULL
DROP VIEW [dbo].[_Key]
GO
CREATE VIEW [dbo].[_Key]
AS
SELECT
   S.version,
   S.activation,
   Nodeset.keys.value('@of', 'nvarchar(max)') as [of],
   Nodeset.keys.value('@route', 'nvarchar(max)') as [route],
   Nodeset.keys.value('@stop', 'nvarchar(max)') as [stop],
   case [parent]
      when 'tie'
      then Nodeset.keys.value('../@role', 'nvarchar(max)')
   end as [role],
   case [parent]
      when 'knot'
      then Nodeset.keys.value('concat(../@mnemonic, "_")', 'nvarchar(max)') +
          Nodeset.keys.value('../@descriptor', 'nvarchar(max)') 
      when 'attribute'
      then Nodeset.keys.value('concat(../../@mnemonic, "_")', 'nvarchar(max)') +
          Nodeset.keys.value('concat(../@mnemonic, "_")', 'nvarchar(max)') +
          Nodeset.keys.value('concat(../../@descriptor, "_")', 'nvarchar(max)') +
          Nodeset.keys.value('../@descriptor', 'nvarchar(max)') 
      when 'tie'
      then REPLACE(Nodeset.keys.query('
            for $role in ../../*[local-name() = "anchorRole" or local-name() = "knotRole"]
            return concat($role/@type, "_", $role/@role)
          ').value('.', 'nvarchar(max)'), ' ', '_')
   end as [in],
   [parent]
FROM
   [dbo].[_Schema] S
CROSS APPLY
   S.[schema].nodes('/schema//key') as Nodeset(keys)
CROSS APPLY (
   VALUES (
      case
         when Nodeset.keys.value('local-name(..)', 'nvarchar(max)') in ('anchorRole', 'knotRole')
         then 'tie'
         else Nodeset.keys.value('local-name(..)', 'nvarchar(max)')
      end 
   )
) p ([parent]);
GO
-- Evolution function -------------------------------------------------------------------------------------------------
-- The evolution function shows what the schema looked like at the given
-- point in time with additional information about missing or added
-- modeling components since that time.
--
-- @timepoint The point in time to which you would like to travel.
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._Evolution', 'IF') IS NOT NULL
DROP FUNCTION [dbo].[_Evolution];
GO
CREATE FUNCTION [dbo].[_Evolution] (
    @timepoint AS datetime2(7)
)
RETURNS TABLE AS
RETURN
WITH constructs AS (
   SELECT
      temporalization,
      [capsule] + '.' + [name] + s.suffix AS [qualifiedName],
      [version],
      [activation]
   FROM 
      [dbo].[_Anchor] a
   CROSS APPLY (
      VALUES ('uni', ''), ('crt', '')
   ) s (temporalization, suffix)
   UNION ALL
   SELECT
      temporalization,
      [capsule] + '.' + [name] + s.suffix AS [qualifiedName],
      [version],
      [activation]
   FROM
      [dbo].[_Knot] k
   CROSS APPLY (
      VALUES ('uni', ''), ('crt', '')
   ) s (temporalization, suffix)
   UNION ALL
   SELECT
      temporalization,
      [capsule] + '.' + [name] + s.suffix AS [qualifiedName],
      [version],
      [activation]
   FROM
      [dbo].[_Attribute] b
   CROSS APPLY (
      VALUES ('uni', ''), ('crt', '_Annex'), ('crt', '_Posit')
   ) s (temporalization, suffix)
   UNION ALL
   SELECT
      temporalization,
      [capsule] + '.' + [name] + s.suffix AS [qualifiedName],
      [version],
      [activation]
   FROM
      [dbo].[_Tie] t
   CROSS APPLY (
      VALUES ('uni', ''), ('crt', '_Annex'), ('crt', '_Posit')
   ) s (temporalization, suffix)
), 
selectedSchema AS (
   SELECT TOP 1
      *
   FROM
      [dbo].[_Schema_Expanded]
   WHERE
      [activation] <= @timepoint
   ORDER BY
      [activation] DESC
),
presentConstructs AS (
   SELECT
      C.*
   FROM
      selectedSchema S
   JOIN
      constructs C
   ON
      S.[version] = C.[version]
   AND
      S.temporalization = C.temporalization 
), 
allConstructs AS (
   SELECT
      C.*
   FROM
      selectedSchema S
   JOIN
      constructs C
   ON
      S.temporalization = C.temporalization
)
SELECT
   COALESCE(P.[version], X.[version]) as [version],
   COALESCE(P.[qualifiedName], T.[qualifiedName]) AS [name],
   COALESCE(P.[activation], X.[activation], T.[create_date]) AS [activation],
   CASE
      WHEN P.[activation] = S.[activation] THEN 'Present'
      WHEN X.[activation] > S.[activation] THEN 'Future'
      WHEN X.[activation] < S.[activation] THEN 'Past'
      ELSE 'Missing'
   END AS Existence
FROM 
   presentConstructs P
FULL OUTER JOIN (
   SELECT 
      s.[name] + '.' + t.[name] AS [qualifiedName],
      t.[create_date]
   FROM 
      sys.tables t
   JOIN
      sys.schemas s
   ON
      s.schema_id = t.schema_id
   WHERE
      t.[type] = 'U'
   AND
      LEFT(t.[name], 1) <> '_'
) T
ON
   T.[qualifiedName] = P.[qualifiedName]
LEFT JOIN
   allConstructs X
ON
   X.[qualifiedName] = T.[qualifiedName]
AND
   X.[activation] = (
      SELECT
         MIN(sub.[activation])
      FROM
         constructs sub
      WHERE
         sub.[qualifiedName] = T.[qualifiedName]
      AND 
         sub.[activation] >= T.[create_date]
   )
CROSS APPLY (
   SELECT
      *
   FROM
      selectedSchema
) S;
GO
-- Drop Script Generator ----------------------------------------------------------------------------------------------
-- generates a drop script, that must be run separately, dropping everything in an Anchor Modeled database
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._GenerateDropScript', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[_GenerateDropScript];
GO
CREATE PROCEDURE [dbo]._GenerateDropScript (
   @exclusionPattern varchar(42) = '%.[[][_]%', -- exclude Metadata by default
   @inclusionPattern varchar(42) = '%', -- include everything by default
   @directions varchar(42) = 'Upwards, Downwards', -- do both up and down by default
   @qualifiedName varchar(555) = null -- can specify a single object
)
AS
BEGIN
   set nocount on;
   select
      ordinal,
      unqualifiedName,
      qualifiedName
   into 
      #constructs
   from (
      select distinct
         10 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + ']' as qualifiedName
      from
         [dbo]._Attribute
      union all
      select distinct
         11 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + '_Annex]' as qualifiedName
      from
         [dbo]._Attribute
      union all
      select distinct
         12 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + '_Posit]' as qualifiedName
      from
         [dbo]._Attribute
      union all
      select distinct
         20 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + ']' as qualifiedName
      from
         [dbo]._Tie
      union all
      select distinct
         21 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + '_Annex]' as qualifiedName
      from
         [dbo]._Tie
      union all
      select distinct
         22 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + '_Posit]' as qualifiedName
      from
         [dbo]._Tie
      union all
      select distinct
         30 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + ']' as qualifiedName
      from
         [dbo]._Knot
      union all
      select distinct
         40 as ordinal,
         name as unqualifiedName,
         '[' + capsule + '].[' + name + ']' as qualifiedName
      from
         [dbo]._Anchor
   ) t;
   select
      c.ordinal,
      cast(c.unqualifiedName as nvarchar(517)) as unqualifiedName,
      cast(c.qualifiedName as nvarchar(517)) as qualifiedName,
      o.[object_id],
      o.[type]
   into
      #includedConstructs
   from
      #constructs c
   join
      sys.objects o
   on
      o.[object_id] = OBJECT_ID(c.qualifiedName)
   and 
      o.[type] = 'U'
   where
      OBJECT_ID(c.qualifiedName) = OBJECT_ID(isnull(@qualifiedName, c.qualifiedName));
   create unique clustered index ix_includedConstructs on #includedConstructs([object_id]);
   with relatedUpwards as (
      select
         c.[object_id],
         c.[type],
         c.unqualifiedName,
         c.qualifiedName,
         1 as depth
      from
         #includedConstructs c
      union all
      select
         o.[object_id],
         o.[type],
         n.unqualifiedName,
         n.qualifiedName,
         c.depth + 1 as depth
      from
         relatedUpwards c
      cross apply (
         select
            refs.referencing_id
         from 
            sys.dm_sql_referencing_entities(c.qualifiedName, 'OBJECT') refs
         where
            refs.referencing_id <> OBJECT_ID(c.qualifiedName)
      ) r
      join
         sys.objects o
      on
         o.[object_id] = r.referencing_id
      and
         o.type not in ('S')
      join 
         sys.schemas s 
      on 
         s.schema_id = o.schema_id
      cross apply (
         select
            cast('[' + s.name + '].[' + o.name + ']' as nvarchar(517)),
            cast(o.name as nvarchar(517))
      ) n (qualifiedName, unqualifiedName)
   )
   select distinct
      [object_id],
      [type],
      unqualifiedName,
      qualifiedName,
      depth
   into
      #relatedUpwards
   from
      relatedUpwards u
   where
      depth = (
         select
            MAX(depth)
         from
            relatedUpwards s
         where
            s.[object_id] = u.[object_id]
      );
   create unique clustered index ix_relatedUpwards on #relatedUpwards([object_id]);
   with relatedDownwards as (
      select
         cast('Upwards' as varchar(42)) as [relationType],
         c.[object_id],
         c.[type],
         c.unqualifiedName, 
         c.qualifiedName,
         c.depth
      from
         #relatedUpwards c 
      union all
      select
         cast('Downwards' as varchar(42)) as [relationType],
         o.[object_id],
         o.[type],
         n.unqualifiedName, 
         n.qualifiedName,
         c.depth - 1 as depth
      from
         relatedDownwards c
      cross apply (
         select 
            refs.referenced_id 
         from
            sys.dm_sql_referenced_entities(c.qualifiedName, 'OBJECT') refs
         where
            refs.referenced_minor_id = 0
         and
            refs.referenced_id <> OBJECT_ID(c.qualifiedName)
         and 
            refs.referenced_id not in (select [object_id] from #relatedUpwards)
      ) r
      join -- select top 100 * from 
         sys.objects o
      on
         o.[object_id] = r.referenced_id
      and
         o.type not in ('S')
      join
         sys.schemas s
      on 
         s.schema_id = o.schema_id
      cross apply (
         select
            cast('[' + s.name + '].[' + o.name + ']' as nvarchar(517)),
            cast(o.name as nvarchar(517))
      ) n (qualifiedName, unqualifiedName)
   )
   select distinct
      relationType,
      [object_id],
      [type],
      unqualifiedName,
      qualifiedName,
      depth
   into
      #relatedDownwards
   from
      relatedDownwards d
   where
      depth = (
         select
            MIN(depth)
         from
            relatedDownwards s
         where
            s.[object_id] = d.[object_id]
      );
   create unique clustered index ix_relatedDownwards on #relatedDownwards([object_id]);
   select distinct
      [object_id],
      [type],
      [unqualifiedName],
      [qualifiedName],
      [depth]
   into
      #affectedObjects
   from
      #relatedDownwards d
   where
      [qualifiedName] not like @exclusionPattern
   and
      [qualifiedName] like @inclusionPattern
   and
      @directions like '%' + [relationType] + '%';
   create unique clustered index ix_affectedObjects on #affectedObjects([object_id]);
   select distinct
      objectType,
      unqualifiedName,
      qualifiedName,
      dropOrder
   into
      #dropList
   from (
      select
         t.objectType,
         o.unqualifiedName,
         o.qualifiedName,
         dense_rank() over (
            order by
               o.depth desc,
               case o.[type]
                  when 'C' then 0 -- CHECK CONSTRAINT
                  when 'TR' then 1 -- SQL_TRIGGER
                  when 'P' then 2 -- SQL_STORED_PROCEDURE
                  when 'V' then 3 -- VIEW
                  when 'IF' then 4 -- SQL_INLINE_TABLE_VALUED_FUNCTION
                  when 'FN' then 5 -- SQL_SCALAR_FUNCTION
                  when 'PK' then 6 -- PRIMARY_KEY_CONSTRAINT
                  when 'UQ' then 7 -- UNIQUE_CONSTRAINT
                  when 'F' then 8 -- FOREIGN_KEY_CONSTRAINT
                  when 'U' then 9 -- USER_TABLE
               end asc,
               isnull(c.ordinal, 0) asc
         ) as dropOrder
      from
         #affectedObjects o
      left join
         #includedConstructs c
      on
         c.[object_id] = o.[object_id]
      cross apply (
         select
            case o.[type]
               when 'C' then 'CHECK'
               when 'TR' then 'TRIGGER'
               when 'V' then 'VIEW'
               when 'IF' then 'FUNCTION'
               when 'FN' then 'FUNCTION'
               when 'P' then 'PROCEDURE'
               when 'PK' then 'CONSTRAINT'
               when 'UQ' then 'CONSTRAINT'
               when 'F' then 'CONSTRAINT'
               when 'U' then 'TABLE'
            end
         ) t (objectType)
      where
         t.objectType in (
            'CHECK',
            'VIEW',
            'FUNCTION',
            'PROCEDURE',
            'TABLE'
         )
   ) r;
   select
      case 
         when d.objectType = 'CHECK'
         then 'ALTER TABLE ' + p.parentName + ' DROP CONSTRAINT ' + d.unqualifiedName
         else 'DROP ' + d.objectType + ' ' + d.qualifiedName
      end + ';' + CHAR(13) as [text()]
   from
      #dropList d
   join
      sys.objects o
   on
      o.[object_id] = OBJECT_ID(d.qualifiedName)
   join
      sys.schemas s
   on
      s.[schema_id] = o.[schema_id]
   cross apply (
      select
         '[' + s.name + '].[' + OBJECT_NAME(o.parent_object_id) + ']'
   ) p (parentName)
   order by
      d.dropOrder asc
   for xml path('');
END
GO
-- Database Copy Script Generator -------------------------------------------------------------------------------------
-- generates a copy script, that must be run separately, copying all data between two identically modeled databases
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._GenerateCopyScript', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[_GenerateCopyScript];
GO
CREATE PROCEDURE [dbo]._GenerateCopyScript (
	@source varchar(123),
	@target varchar(123)
)
as
begin
	declare @R char(1);
    set @R = CHAR(13);
	-- stores the built SQL code
	declare @sql varchar(max);
    set @sql = 'USE ' + @target + ';' + @R;
	declare @xml xml;
	-- find which version of the schema that is in effect
	declare @version int;
	select
		@version = max([version])
	from
		_Schema;
	-- declare and set other variables we need
	declare @equivalentSuffix varchar(42);
	declare @identitySuffix varchar(42);
	declare @annexSuffix varchar(42);
	declare @positSuffix varchar(42);
	declare @temporalization varchar(42);
	select
		@equivalentSuffix = equivalentSuffix,
		@identitySuffix = identitySuffix,
		@annexSuffix = annexSuffix,
		@positSuffix = positSuffix,
		@temporalization = temporalization
	from
		_Schema_Expanded
	where
		[version] = @version;
	-- build non-equivalent knot copy
	set @xml = (
		select
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + ' ON;' + @R
			end,
			'INSERT INTO ' + [capsule] + '.' + [name] + '(' + [columns] + ')' + @R +
			'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + ';' + @R,
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + ' OFF;' + @R
			end
		from
			_Knot x
		cross apply (
			select stuff((
				select
					', ' + [name]
				from
					sys.columns
				where
					[object_Id] = object_Id(x.[capsule] + '.' + x.[name])
				and
					is_computed = 0
				for xml path('')
			), 1, 2, '')
		) c ([columns])
		where
			[version] = @version
		and
			isnull(equivalent, 'false') = 'false'
		for xml path('')
	);
	set @sql = @sql + isnull(@xml.value('.', 'varchar(max)'), '');
	-- build equivalent knot copy
	set @xml = (
		select
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @identitySuffix + ' ON;' + @R
			end,
			'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @identitySuffix + '(' + [columns] + ')' + @R +
			'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @identitySuffix + ';' + @R,
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @identitySuffix + ' OFF;' + @R
			end,
			'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @equivalentSuffix + '(' + [columns] + ')' + @R +
			'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @equivalentSuffix + ';' + @R
		from
			_Knot x
		cross apply (
			select stuff((
				select
					', ' + [name]
				from
					sys.columns
				where
					[object_Id] = object_Id(x.[capsule] + '.' + x.[name])
				and
					is_computed = 0
				for xml path('')
			), 1, 2, '')
		) c ([columns])
		where
			[version] = @version
		and
			isnull(equivalent, 'false') = 'true'
		for xml path('')
	);
	set @sql = @sql + isnull(@xml.value('.', 'varchar(max)'), '');
	-- build anchor copy
	set @xml = (
		select
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + ' ON;' + @R
			end,
			'INSERT INTO ' + [capsule] + '.' + [name] + '(' + [columns] + ')' + @R +
			'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + ';' + @R,
			case
				when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + ' OFF;' + @R
			end
		from
			_Anchor x
		cross apply (
			select stuff((
				select
					', ' + [name]
				from
					sys.columns
				where
					[object_Id] = object_Id(x.[capsule] + '.' + x.[name])
				and
					is_computed = 0
				for xml path('')
			), 1, 2, '')
		) c ([columns])
		where
			[version] = @version
		for xml path('')
	);
	set @sql = @sql + isnull(@xml.value('.', 'varchar(max)'), '');
	-- build attribute copy
	if (@temporalization = 'crt')
	begin
		set @xml = (
			select
				case
					when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @positSuffix + ' ON;' + @R
				end,
				'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @positSuffix + '(' + [positColumns] + ')' + @R +
				'SELECT ' + [positColumns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @positSuffix + ';' + @R,
				case
					when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @positSuffix + ' OFF;' + @R
				end,
				'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @annexSuffix + '(' + [annexColumns] + ')' + @R +
				'SELECT ' + [annexColumns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @annexSuffix + ';' + @R
			from
				_Attribute x
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name] + '_' + @positSuffix)
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) pc ([positColumns])
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name] + '_' + @annexSuffix)
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) ac ([annexColumns])
			where
				[version] = @version
			for xml path('')
		);
	end
	else -- uni
	begin
		set @xml = (
			select
				'INSERT INTO ' + [capsule] + '.' + [name] + '(' + [columns] + ')' + @R +
				'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + ';' + @R
			from
				_Attribute x
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name])
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) c ([columns])
			where
				[version] = @version
			for xml path('')
		);
	end
	set @sql = @sql + isnull(@xml.value('.', 'varchar(max)'), '');
	-- build tie copy
	if (@temporalization = 'crt')
	begin
		set @xml = (
			select
				case
					when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @positSuffix + ' ON;' + @R
				end,
				'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @positSuffix + '(' + [positColumns] + ')' + @R +
				'SELECT ' + [positColumns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @positSuffix + ';' + @R,
				case
					when [generator] = 'true' then 'SET IDENTITY_INSERT ' + [capsule] + '.' + [name] + '_' + @positSuffix + ' OFF;' + @R
				end,
				'INSERT INTO ' + [capsule] + '.' + [name] + '_' + @annexSuffix + '(' + [annexColumns] + ')' + @R +
				'SELECT ' + [annexColumns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + '_' + @annexSuffix + ';' + @R
			from
				_Tie x
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name] + '_' + @positSuffix)
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) pc ([positColumns])
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name] + '_' + @annexSuffix)
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) ac ([annexColumns])
			where
				[version] = @version
			for xml path('')
		);
	end
	else -- uni
	begin
		set @xml = (
			select
				'INSERT INTO ' + [capsule] + '.' + [name] + '(' + [columns] + ')' + @R +
				'SELECT ' + [columns] + ' FROM ' + @source + '.' + [capsule] + '.' + [name] + ';' + @R
			from
				_Tie x
			cross apply (
				select stuff((
					select
						', ' + [name]
					from
						sys.columns
					where
						[object_Id] = object_Id(x.[capsule] + '.' + x.[name])
					and
						is_computed = 0
					for xml path('')
				), 1, 2, '')
			) c ([columns])
			where
				[version] = @version
			for xml path('')
		);
	end
	set @sql = @sql + isnull(@xml.value('.', 'varchar(max)'), '');
	select @sql for xml path('');
end
go
-- Delete Everything with a Certain Metadata Id -----------------------------------------------------------------------
-- deletes all rows from all tables that have the specified metadata id
-----------------------------------------------------------------------------------------------------------------------
IF Object_ID('dbo._DeleteWhereMetadataEquals', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[_DeleteWhereMetadataEquals];
GO
CREATE PROCEDURE [dbo]._DeleteWhereMetadataEquals (
	@metadataID int,
	@schemaVersion int = null,
	@includeKnots bit = 0
)
as
begin
	declare @sql varchar(max);
	set @sql = 'print ''Null is not a valid value for @metadataId''';
	if(@metadataId is not null)
	begin
		if(@schemaVersion is null)
		begin
			select
				@schemaVersion = max(Version)
			from
				_Schema;
		end;
		with constructs as (
			select
				'l' + name as name,
				2 as prio,
				'Metadata_' + name as metadataColumn
			from
				_Tie
			where
				[version] = @schemaVersion
			union all
			select
				'l' + name as name,
				3 as prio,
				'Metadata_' + mnemonic as metadataColumn
			from
				_Anchor
			where
				[version] = @schemaVersion
			union all
			select
				name,
				4 as prio,
				'Metadata_' + mnemonic as metadataColumn
			from
				_Knot
			where
				[version] = @schemaVersion
			and
				@includeKnots = 1
		)
		select
			@sql = (
				select
					'DELETE FROM ' + name + ' WHERE ' + metadataColumn + ' = ' + cast(@metadataId as varchar(10)) + '; '
				from
					constructs
        order by
					prio, name
				for xml
					path('')
			);
	end
	exec(@sql);
end
go
-- DESCRIPTIONS -------------------------------------------------------------------------------------------------------