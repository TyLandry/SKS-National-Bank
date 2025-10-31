/*************************************************
   Project Phase 1: SKSQueries.sql
   SKS National Bank
   Group: Heather Hallberg, Gurniaz Singh, Ty Landry
   School of Technology, Bow Valley College
   DATA2201: Relational Databases
   Instructor: Michael Dorsey
   Due: Oct 31, 2025
**************************************************/


-- These show specific tables. 
SELECT * FROM [dbo].[Branch];
SELECT * FROM [dbo].[Customer];
SELECT * FROM [dbo].[Account];
 
SELECT * FROM [dbo].[Branch];
SELECT * FROM [dbo].[Employee];
 
--1. Shows full name and role
SELECT FullName, Role FROM [dbo].[Employee];
 
--2. Shows all accounts with a balance over $:5,000
SELECT * FROM [dbo].[Account] WHERE Balance > 5000;
 
 
--3. Lists accounts and the customers who own them. 
SELECT c.FullName, a.AccountType, a.Balance
FROM [dbo].[Customer] c
JOIN [dbo].[CustomerAccount] ca ON c.CustomerID = ca.CustomerID
JOIN [dbo].[Account] a ON ca.AccountID = a.AccountID;

--4. List all employees and their manager’s name.
SELECT e.FullName AS EmployeeName, 
       m.FullName AS ManagerName
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID;
 
 
--5. Get the total number of loans and the average loan amount per branch.
SELECT 
    b.Name AS BranchName,
    COUNT(l.LoanID) AS TotalLoans,
    AVG(l.Amount) AS AvgLoanAmount
FROM Branch b
JOIN Loan l ON b.BranchID = l.BranchID
GROUP BY b.Name;
 
 
--6. Get the list of customers who have loans but have not made any payments yet.
SELECT 
    c.FullName AS CustomerName,
    l.LoanID
FROM Customer c
JOIN LoanCustomer lc ON c.CustomerID = lc.CustomerID
JOIN Loan l ON lc.LoanID = l.LoanID
LEFT JOIN LoanPayment lp ON l.LoanID = lp.LoanID
WHERE lp.LoanID IS NULL;
--This query finds customers who have loans but have not made any payments yet by using a LEFT JOIN on LoanPayment and checking for NULL values.
 
 
--7. Get a list of all branches, their locations, and the number of employees working at each location.
SELECT 
    b.Name AS BranchName,
    bl.Name AS LocationName,
    COUNT(el.EmployeeID) AS EmployeeCount
FROM Branch b
JOIN BranchLocation bl ON b.BranchID = bl.BranchID
LEFT JOIN EmployeeLocation el ON bl.LocationID = el.LocationID
GROUP BY b.Name, bl.Name;
--This query lists all branches, their locations, and the number of employees assigned to each location by using joins on the Branch, BranchLocation, and EmployeeLocation tables.


--8. Show all overdrafts for chequing accounts with customer info and account info.
SELECT 
    c.FullName AS CustomerName,
    a.AccountID,
    o.OverdraftDate,
    o.Amount,
    o.CheckNumber
FROM Overdraft o
JOIN Account a ON o.AccountID = a.AccountID
JOIN CustomerAccount ca ON a.AccountID = ca.AccountID
JOIN Customer c ON ca.CustomerID = c.CustomerID
WHERE a.AccountType = 'chequing';


--9.List all customers and what accounts they hold
SELECT 
    c.FullName,
    COUNT(ca.AccountID) AS TotalAccounts
FROM Customer c
LEFT JOIN CustomerAccount ca ON c.CustomerID = ca.CustomerID
GROUP BY c.FullName;


--10.Show all loans, with or without payment history
SELECT 
    l.LoanID,
    l.Amount AS LoanAmount,
    lp.PaymentNumber,
    lp.PaymentDate,
    lp.Amount AS PaymentAmount
FROM Loan l
LEFT JOIN LoanPayment lp ON l.LoanID = lp.LoanID
ORDER BY l.LoanID, lp.PaymentNumber;


--11.Calculate total balance of all account per branch
SELECT 
    b.Name AS BranchName,
    SUM(a.Balance) AS TotalBranchBalance
FROM Branch b
JOIN Account a ON b.BranchID = a.BranchID
GROUP BY b.Name;