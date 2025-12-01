USE [SKS_National_Bank];
GO

-- Add JSON column to Customer table
ALTER TABLE [dbo].[Customer]
ADD [ContactInfo] NVARCHAR(MAX);
GO

-- Populate with JSON sample data
UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "emily.clark@email.com", "phone": "403-555-0101"}'
WHERE CustomerID = 1;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "frank.wright@email.com", "phone": "403-555-0102"}'
WHERE CustomerID = 2;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "grace.miller@email.com", "phone": "403-555-0103"}'
WHERE CustomerID = 3;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "henry.adams@email.com", "phone": "403-555-0104"}'
WHERE CustomerID = 4;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "ivy.thompson@email.com", "phone": "403-555-0105"}'
WHERE CustomerID = 5;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "james.parker@email.com", "phone": "403-555-0106"}'
WHERE CustomerID = 6;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "kelly.roberts@email.com", "phone": "403-555-0107"}'
WHERE CustomerID = 7;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "liam.scott@email.com", "phone": "403-555-0108"}'
WHERE CustomerID = 8;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "mia.turner@email.com", "phone": "403-555-0109"}'
WHERE CustomerID = 9;

UPDATE [dbo].[Customer]
SET [ContactInfo] = N'{"email": "noah.evans@email.com", "phone": "403-555-0110"}'
WHERE CustomerID = 10;

GO

-- references: https://learn.microsoft.com/en-us/sql/relational-databases/spatial/spatial-data-sql-server?view=sql-server-ver17
-- https://learn.microsoft.com/en-us/sql/relational-databases/spatial/point?view=sql-server-ver17

-- adding a spatial column to the branch table.
ALTER TABLE dbo.Branch
ADD BranchLocation GEOGRAPHY
GO

-- using sample coordinates for 10 branches.


DECLARE @geo1 geography;
SET @geo1 = geography::STPointFromText('POINT(-114.0700 51.0500)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo1
WHERE BranchID = 1;


DECLARE @geo2 geography;
SET @geo2 = geography::STPointFromText('POINT(-114.0650 51.0450)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo2
WHERE BranchID = 2;


DECLARE @geo3 geography;
SET @geo3 = geography::STPointFromText('POINT(-114.0800 51.0600)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo3
WHERE BranchID = 3;


DECLARE @geo4 geography;
SET @geo4 = geography::STPointFromText('POINT(-114.0750 51.0400)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo4
WHERE BranchID = 4;


DECLARE @geo5 geography;
SET @geo5 = geography::STPointFromText('POINT(-114.0900 51.0550)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo5
WHERE BranchID = 5;


DECLARE @geo6 geography;
SET @geo6 = geography::STPointFromText('POINT(-114.0600 51.0480)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo6
WHERE BranchID = 6;


DECLARE @geo7 geography;
SET @geo7 = geography::STPointFromText('POINT(-114.0550 51.0520)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo7
WHERE BranchID = 7;


DECLARE @geo8 geography;
SET @geo8 = geography::STPointFromText('POINT(-114.0720 51.0580)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo8
WHERE BranchID = 8;


DECLARE @geo9 geography;
SET @geo9 = geography::STPointFromText('POINT(-114.0200 51.1200)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo9
WHERE BranchID = 9;


DECLARE @geo10 geography;
SET @geo10 = geography::STPointFromText('POINT(-114.0680 51.0420)', 4326);
UPDATE [dbo].[Branch]
SET BranchLocation = @geo10
WHERE BranchID = 10;


GO

/* these are tests. 
SELECT BranchID, Name, BranchLocation
FROM [dbo].[Branch];
GO

-- makes the coordinate dot bigger.
SELECT 
    BranchID,
    Name,
    BranchLocation.STBuffer(50) AS VisibleShape
FROM Branch;
*/
