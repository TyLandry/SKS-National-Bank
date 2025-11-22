USE [SKS_National_Bank];
GO

--------------------------------------------------------
-- FOREIGN KEY INDEXES (Nonclustered)
--------------------------------------------------------

-- BranchLocation
CREATE INDEX idx_branchlocation_branch 
    ON dbo.BranchLocation (BranchID);

CREATE INDEX idx_branchlocation_address 
    ON dbo.BranchLocation (AddressID);

-- EmployeeLocation
CREATE INDEX idx_employeelocation_employee 
    ON dbo.EmployeeLocation (EmployeeID);

CREATE INDEX idx_employeelocation_location 
    ON dbo.EmployeeLocation (LocationID);

-- Employee (Manager + Address FKs)
CREATE INDEX idx_employee_manager 
    ON dbo.Employee (ManagerID);

CREATE INDEX idx_employee_address
    ON dbo.Employee (AddressID);

-- Customer (Address + employee banker/officer FKs)
CREATE INDEX idx_customer_address
    ON dbo.Customer (AddressID);

CREATE INDEX idx_customer_personalbanker 
    ON dbo.Customer (PersonalBankerID);

CREATE INDEX idx_customer_loanofficer 
    ON dbo.Customer (LoanOfficerID);

-- Account
CREATE INDEX idx_account_branch 
    ON dbo.Account (BranchID);

-- CustomerAccount
CREATE INDEX idx_customeraccount_customer 
    ON dbo.CustomerAccount (CustomerID);

CREATE INDEX idx_customeraccount_account 
    ON dbo.CustomerAccount (AccountID);

-- Overdraft
CREATE INDEX idx_overdraft_account 
    ON dbo.Overdraft (AccountID);

-- Loan
CREATE INDEX idx_loan_branch 
    ON dbo.Loan (BranchID);

-- LoanCustomer
CREATE INDEX idx_loancustomer_loan 
    ON dbo.LoanCustomer (LoanID);

CREATE INDEX idx_loancustomer_customer 
    ON dbo.LoanCustomer (CustomerID);

-- LoanPayment
CREATE INDEX idx_loanpayment_loan 
    ON dbo.LoanPayment (LoanID);

--------------------------------------------------------
-- ADDITIONAL PERFORMANCE INDEXES
--------------------------------------------------------

-- Employee role searching (useful for reporting)
CREATE INDEX idx_employee_role 
    ON dbo.Employee (Role);

-- Account type (fast filtering between chequing/savings)
CREATE INDEX idx_account_type 
    ON dbo.Account (AccountType);

-- Loan start dates (useful for time-based reports)
CREATE INDEX idx_loan_startdate 
    ON dbo.Loan (StartDate);

-- Payment date indexing (frequent date queries)
CREATE INDEX idx_loanpayment_date 
    ON dbo.LoanPayment (PaymentDate);
GO
