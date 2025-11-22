USE [SKS_National_Bank];
GO

CREATE TABLE dbo.Audit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Explanation NVARCHAR(500) NOT NULL,
    Timestamp DATETIME DEFAULT GETDATE()
);
GO

-- Overdraft enforcement trigger: only allow overdrafts for chequing accounts
-- Logs to the Audit table
IF OBJECT_ID('dbo.trgOverdraftChequingOnly', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trgOverdraftChequingOnly;
GO

CREATE TRIGGER dbo.trgOverdraftChequingOnly
ON dbo.Overdraft
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1) Check if any inserted overdraft is for a non-chequing account
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN dbo.Account a ON i.AccountID = a.AccountID
        WHERE a.AccountType <> 'chequing'
    )
    BEGIN
        -- 2) Log the invalid attempt
        INSERT INTO dbo.Audit (Explanation)
        SELECT CONCAT('Invalid overdraft attempt: AccountID ', i.AccountID, 
                      ' is type ', a.AccountType, ', not chequing. Amount: $', i.Amount)
        FROM inserted i
        JOIN dbo.Account a ON i.AccountID = a.AccountID
        WHERE a.AccountType <> 'chequing';

        -- 3) Reject the transaction
        RAISERROR('Overdrafts are only allowed for chequing accounts.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- 4) Log successful overdraft creation
    INSERT INTO dbo.Audit (Explanation)
    SELECT CONCAT('Overdraft created: OverdraftID ', i.OverdraftID, 
                  ' for AccountID ', i.AccountID, ', Amount: $', i.Amount)
    FROM inserted i;
END;

-- create account trigger
CREATE OR ALTER TRIGGER dbo.trg_LogNewAccount
ON dbo.Account
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Audit (Explanation)
    SELECT CONCAT(
               'Account created: ', i.AccountType,
               ' | Branch ', i.BranchID,
               ' | Balance $', FORMAT(i.Balance, 'N2')
           )
    FROM inserted i;
END;
GO

--update branch total loan trigger 
CREATE TRIGGER trg_UpdateBranchTotalLoans
ON Loan
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Sum amounts per BranchID first
    UPDATE b
    SET b.TotalLoans = COALESCE(b.TotalLoans, 0) + s.TotalAmount
    FROM Branch b
    JOIN (
        SELECT BranchID, SUM(Amount) AS TotalAmount
        FROM INSERTED
        GROUP BY BranchID
    ) s ON b.BranchID = s.BranchID;
END;
GO
--The trigger automatically increases the branch’s total loan amount every time a new loan is inserted .

GO


