/*************************************************
   Project Phase 1: create_database.sql
   SKS National Bank
   Group: Heather Hallberg, Gurniaz Singh, Ty Landry
   School of Technology, Bow Valley College
   DATA2201: Relational Databases
   Instructor: Michael Dorsey
   Due: Oct 31, 2025
**************************************************/

--Drop DataBase if it exists

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'SKS_National_Bank')
BEGIN
    ALTER DATABASE [SKS_National_Bank] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [SKS_National_Bank];
END
GO

--Create Database

CREATE DATABASE [SKS_National_Bank];
GO


USE [SKS_National_Bank];
GO

--Address Table

CREATE TABLE [dbo].[Address]
(
[AddressID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[StreetNumber] NVARCHAR(255) NOT NULL,
[StreetName] NVARCHAR(255) NOT NULL,
[City] NVARCHAR(255) NOT NULL,
[Province] NVARCHAR(255) NOT NULL,
[PostalCode] NVARCHAR(20) NOT NULL
);
GO

--Branch Table

CREATE TABLE [dbo].[Branch] 
(
[BranchID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Name] NVARCHAR(255) NOT NULL,
[City] NVARCHAR(255) NOT NULL,
[TotalDeposits] DECIMAL(18,2) DEFAULT 0,
[TotalLoans] DECIMAL(18,2) DEFAULT 0
);
GO

--Branch Location Table

CREATE TABLE [dbo].[BranchLocation]
(
[LocationID] INT IDENTITY(1,1) PRIMARY KEY,
[AddressID] INT NOT NULL,
[LocationType] NVARCHAR(100) NOT NULL,
[BranchID] INT NOT NULL,
FOREIGN KEY (AddressID)	REFERENCES [dbo].[Address](AddressID),
FOREIGN KEY (BranchID)	REFERENCES [dbo].[Branch](BranchID)
);
GO

--Employee Table

CREATE TABLE [dbo].[Employee]
(
[EmployeeID] INT IDENTITY(1,1) PRIMARY KEY,
[Firstname] NVARCHAR(100) NOT NULL,
[Lastname] NVARCHAR(100) NOT NULL,
[StartDate] DATE,
[Role]  NVARCHAR(100),
[ManagerID] INT NULL,
[AddressID] INT NOT NULL,
FOREIGN KEY (ManagerID) REFERENCES [dbo].[Employee](EmployeeID),
FOREIGN KEY (AddressID) REFERENCES [dbo].[Address](AddressID),
CONSTRAINT EmployeeNotOwnManager CHECK ([EmployeeID] <> [ManagerID])
);
GO

--Employee Location Table

CREATE TABLE [dbo].[EmployeeLocation]
(
[EmployeeID] INT NOT NULL,
[LocationID] INT NOT NULL,
FOREIGN KEY (EmployeeID) REFERENCES [dbo].[Employee](EmployeeID),
FOREIGN KEY (LocationID) REFERENCES [dbo].[BranchLocation](LocationID),
CONSTRAINT PK_EmployeeLocation PRIMARY KEY (EmployeeID, LocationID)
);
GO

--Customer Table

CREATE TABLE [dbo].[Customer]
(
[CustomerID] INT IDENTITY(1,1) PRIMARY KEY,
[Firstname] NVARCHAR(100) NOT NULL,
[Lastname] NVARCHAR(100) NOT NULL,
[AddressID] INT NOT NULL,
[PersonalBankerID] INT NULL,
[LoanOfficerID] INT NULL,
FOREIGN KEY (AddressID) REFERENCES [dbo].[Address](AddressID),
FOREIGN KEY (PersonalBankerID) REFERENCES [dbo].[Employee](EmployeeID),
FOREIGN KEY (LoanOfficerID) REFERENCES [dbo].[Employee](EmployeeID)
);
GO
   
--Account Table

CREATE TABLE [dbo].[Account]
(
[AccountID] INT IDENTITY(1,1) PRIMARY KEY,
[BranchID] INT NOT NULL,
[AccountType] VARCHAR(50) NOT NULL, --need a check in place to check for chequing or savings
[Balance] DECIMAL(18,2) DEFAULT 0,
[LastAccessed] DATETIME,
[InterestRate] DECIMAL(5,4), --only for savings account
FOREIGN KEY (BranchID) REFERENCES [dbo].[BRanch](BranchID),
CONSTRAINT AccountType 
CHECK 
([AccountType] IN ('chequing', 'savings')),
CONSTRAINT InterestRate 
CHECK 
(
  ([AccountType] = 'savings' AND [InterestRate] IS NOT NULL) OR
  ([AccountType] = 'chequing' AND [InterestRate] IS NULL)
)
);
GO

--Customer Account Table

CREATE TABLE [dbo].[CustomerAccount]
(
[CustomerID] INT NOT NULL,
[AccountID] INT NOT NULL,
[HolderRole] VARCHAR(50),
FOREIGN KEY (CustomerID) REFERENCES [dbo].[Customer](CustomerID),
FOREIGN KEY (AccountID) REFERENCES [dbo].[Account](AccountID),
CONSTRAINT PK_CustomerAccount PRIMARY KEY (CustomerID, AccountID)
);
GO

--Overdraft Table

CREATE TABLE [dbo].[Overdraft] --only for chequing, will implement trigger for this
(
[OverdraftID] INT IDENTITY(1,1) PRIMARY KEY,
[AccountID] INT NOT NULL,
[CheckNumber] VARCHAR(50),
[OverdraftDate] DATETIME,
[Amount] DECIMAL(18,2),
FOREIGN KEY (AccountID) REFERENCES [dbo].[Account](AccountID)
);
GO

--Loan Table

CREATE TABLE [dbo].[Loan]
(
[LoanID] INT IDENTITY(1,1) PRIMARY KEY,
[BranchID] INT NOT NULL,
[Amount] DECIMAL(18,2) NOT NULL,
[StartDate] DATE,
FOREIGN KEY (BranchID) REFERENCES [dbo].[Branch](BranchID),
CONSTRAINT chk_LoanAmount_Positive CHECK (Amount > 0)
);
GO

--Loan Customer Table

CREATE TABLE [dbo].[LoanCustomer]
(
[LoanID] INT NOT NULL,
[CustomerID] INT NOT NULL,
FOREIGN KEY (LoanID) REFERENCES [dbo].[Loan](LoanID),
FOREIGN KEY (CustomerID) REFERENCES [dbo].[Customer](CustomerID),
CONSTRAINT PK_LoanCustomer PRIMARY KEY (LoanID, CustomerID)
);
GO

--Loan Payment Table

CREATE TABLE [dbo].[LoanPayment]
(
[LoanID] INT NOT NULL,
[PaymentNumber] INT NOT NULL,
[PaymentDate] DATE NOT NULL,
[Amount] DECIMAL(18,2) NOT NULL,
FOREIGN KEY (LoanID) REFERENCES [dbo].[Loan](LoanID),
CONSTRAINT PK_LoanPayment PRIMARY KEY (LoanID, PaymentNumber)
);

GO
