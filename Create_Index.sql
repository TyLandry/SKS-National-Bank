--Primary Keys (already indexed by default)

-- Foreign Key Indexes (non clustered)
CREATE INDEX idx_branchlocation_branch ON BranchLocation(BranchID);
CREATE INDEX idx_employeelocation_employee ON EmployeeLocation(EmployeeID);
CREATE INDEX idx_employeelocation_location ON EmployeeLocation(LocationID);
CREATE INDEX idx_employee_manager ON Employee(ManagerID);
CREATE INDEX idx_account_branch ON Account(BranchID);
CREATE INDEX idx_loan_branch ON Loan(BranchID);
CREATE INDEX idx_loancustomer_loan ON LoanCustomer(LoanID);
CREATE INDEX idx_loancustomer_customer ON LoanCustomer(CustomerID);
CREATE INDEX idx_customeraccount_customer ON CustomerAccount(CustomerID);
CREATE INDEX idx_customeraccount_account ON CustomerAccount(AccountID);
CREATE INDEX idx_overdraft_account ON Overdraft(AccountID);
CREATE INDEX idx_loanpayment_loan ON LoanPayment(LoanID);

-- Additional Indexes (For query performance on common filters)
CREATE INDEX idx_employee_role ON Employee(Role);
CREATE INDEX idx_customer_personalbanker ON Customer(PersonalBankerID);
CREATE INDEX idx_account_type ON Account(AccountType);
CREATE INDEX idx_loan_startdate ON Loan(StartDate);
CREATE INDEX idx_loanpayment_date ON LoanPayment(PaymentDate);

