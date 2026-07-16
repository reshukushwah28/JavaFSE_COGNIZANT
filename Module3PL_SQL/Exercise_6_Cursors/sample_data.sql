DELETE FROM Transactions;
DELETE FROM Accounts;
DELETE FROM Loans;
DELETE FROM Customers;
DELETE FROM Employees;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
VALUES (1, 'Arthur Dent', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 5300.00, 'FALSE', SYSDATE - 10);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
VALUES (2, 'Tricia McMillan', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1400.00, 'FALSE', SYSDATE - 5);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
VALUES (3, 'Ford Prefect', TO_DATE('1975-11-10', 'YYYY-MM-DD'), 24600.00, 'TRUE', SYSDATE - 15);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1001, 1, 'Savings', 5300.00, SYSDATE - 10);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1002, 2, 'Checking', 1400.00, SYSDATE - 5);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1003, 3, 'Savings', 24600.00, SYSDATE - 15);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2001, 1001, SYSDATE - 5, 600.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2002, 1001, SYSDATE - 2, 150.00, 'Withdrawal');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2003, 1002, SYSDATE - 4, 250.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2004, 1003, SYSDATE - 1, 1200.00, 'Deposit');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (501, 1, 55000.00, 8.50, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2026-07-15', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (502, 2, 22000.00, 7.20, TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2027-05-01', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (503, 3, 31000.00, 6.80, TO_DATE('2021-10-10', 'YYYY-MM-DD'), TO_DATE('2026-07-25', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (901, 'Marvin Android', 'Manager', 78000.00, 'IT', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

COMMIT;
DBMS_OUTPUT.PUT_LINE('Sample data loaded.');
/
