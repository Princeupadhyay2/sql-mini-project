CREATE DATABASE BankDB;
USE BankDB;
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Phone VARCHAR(15),
    Address VARCHAR(100)
);
CREATE TABLE Account (
    Account_No INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(10,2),
    Transaction_Date DATE,
    FOREIGN KEY (Account_No) REFERENCES Account(Account_No)
);
INSERT INTO Customer (Name, Gender, DOB, Phone, Address)
VALUES
('Rohit Sharma', 'Male', '1995-04-15', '9876543210', 'Delhi'),
('Priya Singh', 'Female', '1998-07-22', '9876501234', 'Mumbai'),
('Aman Verma', 'Male', '1992-11-05', '9854721369', 'Chandigarh');
INSERT INTO Account (Customer_ID, Account_Type, Balance)
VALUES
(1, 'Savings', 25000.00),
(2, 'Current', 50000.00),
(3, 'Savings', 40000.00);
INSERT INTO Transactions (Account_No, Transaction_Type, Amount, Transaction_Date)
VALUES
(1, 'Deposit', 5000.00, '2025-10-25'),
(1, 'Withdrawal', 2000.00, '2025-10-26'),
(2, 'Deposit', 10000.00, '2025-10-27'),
(3, 'Withdrawal', 5000.00, '2025-10-28');
SELECT c.Name, a.Account_No, a.Account_Type, a.Balance
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID;
SELECT SUM(Balance) AS Total_Balance FROM Account;

SELECT c.Name, t.Transaction_Type, t.Amount, t.Transaction_Date
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID
JOIN Transactions t ON a.Account_No = t.Account_No
WHERE c.Name = 'Rohit Sharma';
SELECT c.Name, a.Balance
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID
WHERE a.Balance > 30000;
SELECT 
    Account_No,
    SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END) AS Total_Deposits,
    SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) AS Total_Withdrawals
FROM Transactions
GROUP BY Account_No;