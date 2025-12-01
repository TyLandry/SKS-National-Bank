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