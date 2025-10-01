--used chatgpt to populate the data

/*************************************************
   Project Phase 1: Populate_database_SKS.sql
   SKS National Bank
   Group: Heather Hallberg, Gurniaz Singh, Ty Landry
   School of Technology, Bow Valley College
   DATA2201: Relational Databases
   Instructor: Michael Dorsey
   Due: Oct 31, 2025
**************************************************/

USE [SKS_National_Bank];
GO

-- Branches
INSERT INTO [dbo].[Branch] (Name, City, TotalDeposits, TotalLoans) VALUES
('Downtown', 'Springfield', 500000.00, 250000.00),
('Uptown', 'Shelbyville', 300000.00, 150000.00),
('Eastside', 'Springfield', 400000.00, 200000.00),
('Westend', 'Ogdenville', 350000.00, 175000.00),
('Northside', 'North Haverbrook', 280000.00, 140000.00),
('Riverside', 'Capital City', 600000.00, 300000.00),
('Hilltop', 'Springfield', 220000.00, 100000.00),
('Midtown', 'Shelbyville', 450000.00, 210000.00),
('Airport', 'Capital City', 520000.00, 240000.00),
('Harborfront', 'Ogdenville', 310000.00, 160000.00);
GO

-- Branch Locations
INSERT INTO [dbo].[BranchLocation] (Name, Address, City, LocationType, BranchID) VALUES
('Downtown Main', '100 Main St', 'Springfield', 'Main', 1),
('Uptown Center', '300 Center Ave', 'Shelbyville', 'Main', 2),
('Eastside Plaza', '400 East St', 'Springfield', 'Satellite', 3),
('Westend Hub', '500 West Rd', 'Ogdenville', 'Main', 4),
('Northside Mall', '600 North Ave', 'North Haverbrook', 'Satellite', 5),
('Riverside HQ', '700 River Blvd', 'Capital City', 'Main', 6),
('Hilltop Branch', '800 Hill Rd', 'Springfield', 'Satellite', 7),
('Midtown Tower', '900 Midtown St', 'Shelbyville', 'Main', 8),
('Airport Kiosk', '1000 Jetway Blvd', 'Capital City', 'Satellite', 9),
('Harborfront Dock', '1100 Harbor Rd', 'Ogdenville', 'Satellite', 10);
GO

-- Employees
INSERT INTO [dbo].[Employee] (FullName, HomeAddress, StartDate, Role, ManagerID) VALUES
('Alice Johnson', '123 Oak Rd', '2022-03-10', 'Branch Manager', NULL),
('Bob Smith', '456 Pine Ln', '2023-01-15', 'Personal Banker', 1),
('Carol Lee', '789 Maple Dr', '2022-08-01', 'Loan Officer', 1),
('David Kim', '321 Birch St', '2023-06-20', 'Teller', 1),
('Eva Martinez', '654 Walnut Ave', '2021-05-11', 'Branch Manager', NULL),
('Frank Nelson', '987 Chestnut Rd', '2023-04-19', 'Loan Officer', 5),
('Grace Chen', '246 Fir Ct', '2022-11-22', 'Personal Banker', 5),
('Henry Brown', '135 Cedar Blvd', '2024-02-14', 'Teller', 5),
('Irene Davis', '753 Aspen Way', '2023-03-01', 'Loan Officer', 1),
('Jack Wilson', '852 Poplar St', '2022-12-12', 'Personal Banker', 1);
GO

-- Employee Locations
INSERT INTO [dbo].[EmployeeLocation] (EmployeeID, LocationID) VALUES
(1, 1),  -- Alice Johnson at Downtown Main
(2, 1),  -- Bob Smith at Downtown Main
(3, 4),  -- Carol Lee at Westend Hub
(4, 5),  -- David Kim at Northside Mall
(5, 2),  -- Eva Martinez at Uptown Center
(6, 7),  -- Frank Nelson at Hilltop Branch
(7, 8),  -- Grace Chen at Midtown Tower
(8, 9),  -- Henry Brown at Airport Kiosk
(9, 3),  -- Irene Davis at Eastside Plaza
(10, 3); -- Jack Wilson at Eastside Plaza
GO

-- Customers
INSERT INTO [dbo].[Customer] (FullName, HomeAddress, PersonalBankerID, LoanOfficerID) VALUES
('Emily Clark', '11 Elm St', 2, 3),
('Frank Wright', '22 Cedar Ave', 2, 3),
('Grace Miller', '33 Willow Way', 2, NULL),
('Henry Adams', '44 Spruce Blvd', 2, 3),
('Ivy Thompson', '55 Alder Dr', 7, 6),
('James Parker', '66 Cypress Ln', 7, 6),
('Kelly Roberts', '77 Beech Ct', 7, NULL),
('Liam Scott', '88 Palm Ave', 7, 6),
('Mia Turner', '99 Magnolia Blvd', 10, 9),
('Noah Evans', '101 Sycamore Rd', 10, 9);
GO

-- Accounts
INSERT INTO [dbo].[Account] (BranchID, AccountType, Balance, LastAccessed, InterestRate) VALUES
(1, 'Chequing', 1200.50, '2025-09-24', NULL),   
(1, 'Savings', 8000.00, '2025-09-20', 1.25),    
(2, 'Chequing', 550.75, '2025-09-23', NULL),    
(2, 'Savings', 12000.00, '2025-09-15', 1.50),   
(3, 'Chequing', 3000.25, '2025-09-21', NULL),   
(3, 'Savings', 15000.00, '2025-09-18', 1.35),   
(4, 'Chequing', 750.00, '2025-09-19', NULL),    
(5, 'Savings', 5000.00, '2025-09-22', 1.40),    
(6, 'Chequing', 2200.00, '2025-09-20', NULL),   
(7, 'Savings', 10000.00, '2025-09-25', 1.60);   
GO

-- Customer Accounts
INSERT INTO [dbo].[CustomerAccount] (CustomerID, AccountID, HolderRole) VALUES
(1, 1, 'Primary'),   -- Emily Clark, Chequing
(1, 2, 'Primary'),   -- Emily Clark, Savings
(2, 3, 'Primary'),   -- Frank Wright, Chequing
(3, 4, 'Primary'),   -- Grace Miller, Savings
(4, 5, 'Primary'),   -- Henry Adams, Chequing
(5, 6, 'Primary'),   -- Ivy Thompson, Savings
(6, 7, 'Primary'),   -- James Parker, Chequing
(7, 8, 'Primary'),   -- Kelly Roberts, Savings
(8, 9, 'Primary'),   -- Liam Scott, Chequing
(9, 10, 'Primary');  -- Mia Turner, Savings
GO

-- Overdrafts
INSERT INTO [dbo].[Overdraft] (AccountID, CheckNumber, OverdraftDate, Amount) VALUES
(1, 'CHK1001', '2025-09-10', 75.00),    
(3, 'CHK1002', '2025-09-12', 50.00),    
(1, 'CHK1003', '2025-09-14', 60.00),    
(3, 'CHK1004', '2025-09-15', 40.00),    
(5, 'CHK1005', '2025-09-17', 100.00),   
(7, 'CHK1006', '2025-09-18', 80.00),    
(9, 'CHK1007', '2025-09-19', 65.00),    
(2, 'CHK1008', '2025-09-20', 55.00),    
(4, 'CHK1009', '2025-09-21', 45.00),    
(6, 'CHK1010', '2025-09-22', 70.00);    
GO

-- Loans
INSERT INTO [dbo].[Loan] (BranchID, Amount, StartDate) VALUES
(1, 50000.00, '2025-07-01'),   
(2, 35000.00, '2025-08-15'),   
(3, 40000.00, '2025-07-10'),   
(4, 25000.00, '2025-09-01'),   
(5, 30000.00, '2025-07-20'),   
(6, 45000.00, '2025-08-05'),   
(7, 28000.00, '2025-09-05'),   
(8, 32000.00, '2025-07-25'),   
(9, 60000.00, '2025-08-30'),   
(10, 27000.00, '2025-09-10');  
GO

-- Loan Customers
INSERT INTO [dbo].[LoanCustomer] (LoanID, CustomerID) VALUES
(1, 1),  -- Emily Clark
(2, 2),  -- Frank Wright
(3, 3),  -- Grace Miller
(4, 4),  -- Henry Adams
(5, 5),  -- Ivy Thompson
(6, 6),  -- James Parker
(7, 7),  -- Kelly Roberts
(8, 8),  -- Liam Scott
(9, 9),  -- Mia Turner
(10, 10);-- Noah Evans
GO

-- Loan Payments
INSERT INTO [dbo].[LoanPayment] (LoanID, PaymentNumber, PaymentDate, Amount) VALUES
(1, 1, '2025-08-01', 1500.00),
(1, 2, '2025-09-01', 1500.00),
(2, 1, '2025-09-01', 1000.00),
(3, 1, '2025-09-10', 1200.00),
(4, 1, '2025-09-12', 800.00),
(5, 1, '2025-09-14', 900.00),
(6, 1, '2025-09-16', 1100.00),
(7, 1, '2025-09-18', 950.00),
(8, 1, '2025-09-20', 1050.00),
(9, 1, '2025-09-22', 2000.00);
GO
