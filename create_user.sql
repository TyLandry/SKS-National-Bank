-- referenced: https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver15

USE SKS_National_Bank;

GO

-- Create a login and user named “customer_group_[?]” where [?] is your group letter. (For example, “customer_group_A”.)
-- o Their password should be “customer”.
-- o Their user account should only be able to read tables that are related to customers, 
-- based on your ERD. (For example, tables related to customer information, accounts, loans, and payments).

--Create a login and user named “accountant_group_[?]” where [?] is your group letter. (For example, “accountant_group_B”.)
-- o Their password should be “accountant”.
-- this creates the customer and accountant.
CREATE LOGIN customer_group_A WITH PASSWORD = 'customer';
CREATE USER customer_group_A FOR LOGIN customer_group_A;

CREATE LOGIN accountant_group_A WITH PASSWORD = 'accountant';
CREATE USER accountant_group_A FOR LOGIN accountant_group_A;

-- had to alter a user because I forget an N. :(
-- ALTER USER accoutant_group_A WITH NAME = accountant_group_A;   
-- ALTER USER accountant_group_A WITH LOGIN = accountant_group_A;
-- GO

GRANT SELECT ON Customer TO customer_group_A;
GRANT SELECT ON CustomerAccount TO customer_group_A;
GRANT SELECT ON Account TO customer_group_A;
GRANT SELECT ON Overdraft TO customer_group_A;
GRANT SELECT ON Loan TO customer_group_A;
GRANT SELECT ON LoanCustomer TO customer_group_A;
GRANT SELECT ON LoanPayment TO customer_group_A;

-- This only applies to accountant.
-- o Their user account should be able to read all tables.

GRANT SELECT ON Branch TO accountant_group_A;
GRANT SELECT ON BranchLocation TO accountant_group_A;
GRANT SELECT ON Employee TO accountant_group_A;
GRANT SELECT ON EmployeeLocation TO accountant_group_A;
GRANT SELECT ON Customer TO accountant_group_A;
GRANT SELECT ON CustomerAccount TO accountant_group_A;
GRANT SELECT ON Account TO accountant_group_A;
GRANT SELECT ON Overdraft TO accountant_group_A;
GRANT SELECT ON Loan TO accountant_group_A;
GRANT SELECT ON LoanCustomer TO accountant_group_A;
GRANT SELECT ON LoanPayment TO accountant_group_A;

-- o Their user account should not be able to update, insert or delete in tables that are related to accounts, 
-- payments and loans, based on your ERD. Those permissions should be revoked.
DENY INSERT, UPDATE, DELETE ON Account TO accountant_group_A;
DENY INSERT, UPDATE, DELETE ON CustomerAccount TO accountant_group_A;
DENY INSERT, UPDATE, DELETE ON OverDraft TO accountant_group_A;
DENY INSERT, UPDATE, DELETE ON Loan TO accountant_group_A;
DENY INSERT, UPDATE, DELETE ON LoanCustomer TO accountant_group_A;
DENY INSERT, UPDATE, DELETE ON LoanPayment TO accountant_group_A;

-- Provide SQL statements that test the enforcement of the privileges on the two users created above.

-- Test queries

-- Tests customer permissions
EXECUTE AS USER = 'customer_group_A';
SELECT TOP (2) * FROM Customer;   -- should work
SELECT TOP (2) * FROM Branch;     -- should fail (no access)
REVERT;
GO

-- test accountant permissions
EXECUTE AS USER = 'accountant_group_A';
SELECT TOP (2) * FROM Branch;     -- should work
UPDATE Account SET Balance = Balance WHERE 1 = 0;  -- should fail (denied)
REVERT;
GO