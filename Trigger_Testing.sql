USE [SKS_National_Bank];
GO
-- Testing fro overdraft trigger
--1) Overdraft Trigger


--Verify audit table exists
SELECT * FROM dbo.Audit;
GO

--Verify Trigger exists
SELECT 
    name AS TriggerName,
    OBJECT_NAME(parent_id) AS TableName,
    is_disabled
FROM sys.triggers
WHERE name = 'trg_Overdraft_ChequingOnly';
GO

--Find a chequing account
SELECT TOP 1 AccountID, AccountType, Balance 
FROM dbo.Account 
WHERE AccountType = 'chequing';
GO

--Insert trigger into that account
INSERT INTO dbo.Overdraft (AccountID, CheckNumber, OverdraftDate, Amount)
VALUES (1, 'CHQ-TEST', GETDATE(), 25.00);
GO

--Check the Audit table for a log
SELECT * FROM dbo.Audit ORDER BY AuditID DESC;
GO

--Find a savings account
SELECT TOP 1 AccountID, AccountType, Balance 
FROM dbo.Account 
WHERE AccountType = 'savings';
GO

--Try to insert overdraft into savings, error will display
BEGIN TRY
    INSERT INTO dbo.Overdraft (AccountID, CheckNumber, OverdraftDate, Amount)
    VALUES (2, 'SAV-INVALID', GETDATE(), 50.00);
END TRY
BEGIN CATCH
    PRINT 'Error caught: ' + ERROR_MESSAGE();
END CATCH;
GO

--End of Overdraft Trigger testing



    
-- Account trigger testing

-- create a new savings account.
INSERT INTO dbo.Account (BranchID, AccountType, Balance, LastAccessed, InterestRate)
VALUES (2, 'savings', 2500.00, GETDATE(), 1.25);

SELECT TOP (1) * FROM dbo.Audit ORDER BY AuditID DESC;

-- create a new chequing account
INSERT INTO dbo.Account (BranchID, AccountType, Balance, LastAccessed, InterestRate)
VALUES (2, 'chequing', 1200.00, GETDATE(), NULL);

SELECT TOP (1) * FROM dbo.Audit ORDER BY AuditID DESC;

-- error check
DECLARE @before INT = (SELECT COUNT(*) FROM dbo.Audit);

BEGIN TRY
    INSERT INTO dbo.Account (BranchID, AccountType, Balance, LastAccessed, InterestRate)
    VALUES (2, 'savings', 3000.00, GETDATE(), NULL); -- invalid
END TRY
BEGIN CATCH
    PRINT 'Error triggered (expected): ' + ERROR_MESSAGE();
END CATCH;

-- verify audit count unchanged
SELECT
    BeforeCount = @before,
    AfterCount  = COUNT(*),
    Difference  = COUNT(*) - @before
FROM dbo.Audit;


-- runs all logs/shows record of all triggers used.
SELECT COUNT(*) AS TotalAuditRows FROM dbo.Audit;
SELECT TOP (5) * FROM dbo.Audit ORDER BY AuditID DESC;

-- End of Account Trigger Testing


-- Branch TotalLoans trigger test

    --CASE 1 Normal Single Loan Insert
    INSERT INTO Loan (BranchID, Amount, StartDate)
    VALUES (1, 10000, '2025-10-01');
    --Verify
    SELECT BranchID, TotalLoans
    FROM Branch
    WHERE BranchID = 1;

    --CASE 2 Multi-Row Insert
    INSERT INTO Loan (BranchID, Amount, StartDate)
    VALUES 
    (1, 5000, '2025-10-03'),
    (1, 7000, '2025-10-04'),
    (2, 4000, '2025-10-03');
    --Verify
    SELECT BranchID, TotalLoans
    FROM Branch
    WHERE BranchID IN (1, 2);

    --CASE 3 Insert Loan for a Branch with NULL TotalLoans
    
    --setting a TotalLoans value NULL for testing
    UPDATE Branch SET TotalLoans = NULL WHERE BranchID = 3;
    --Inserting a new loan in the loan table
    INSERT INTO Loan (BranchID, Amount, StartDate)
    VALUES (3, 25000, '2025-10-05');
    --Trigger should treat NULL as 0 because of COALESCE
    --Verify
    SELECT BranchID, TotalLoans FROM Branch WHERE BranchID = 3;

--End of Branch TotalLoan trigger testing
   
