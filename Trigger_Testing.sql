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
