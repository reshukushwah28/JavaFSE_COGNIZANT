DELETE FROM Transactions;
DELETE FROM Accounts;
DELETE FROM Loans;
DELETE FROM Customers;
DELETE FROM Employees;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastUpdate)
VALUES (1, 'Arthur Dent', TO_DATE('1954-03-11', 'YYYY-MM-DD'), 13500.00, SYSDATE - 10);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastUpdate)
VALUES (2, 'Tricia McMillan', TO_DATE('1983-06-21', 'YYYY-MM-DD'), 9200.00, SYSDATE - 5);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastUpdate)
VALUES (3, 'Ford Prefect', TO_DATE('1948-09-27', 'YYYY-MM-DD'), 27000.00, SYSDATE - 15);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastUpdate)
VALUES (4, 'Zaphod Beeblebrox', TO_DATE('1994-11-23', 'YYYY-MM-DD'), 4500.00, SYSDATE - 2);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1001, 1, 'Savings', 13500.00, SYSDATE - 10);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1002, 2, 'Checking', 9200.00, SYSDATE - 5);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1003, 3, 'Savings', 27000.00, SYSDATE - 15);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1004, 4, 'Checking', 4500.00, SYSDATE - 2);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2001, 1001, TO_DATE('2026-06-15', 'YYYY-MM-DD'), 1200.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2002, 1002, TO_DATE('2026-06-20', 'YYYY-MM-DD'), 600.00, 'Withdrawal');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2003, 1003, TO_DATE('2026-06-10', 'YYYY-MM-DD'), 4000.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2004, 1004, TO_DATE('2026-06-25', 'YYYY-MM-DD'), 300.00, 'Deposit');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (501, 1, 55000.00, 8.25, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2026-07-15', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (502, 2, 22000.00, 7.40, TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2027-05-01', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (503, 3, 35000.00, 6.50, TO_DATE('2021-10-10', 'YYYY-MM-DD'), TO_DATE('2026-07-25', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (901, 'Marvin Android', 'Manager', 78000.00, 'IT', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (902, 'Slartibartfast Planet', 'Analyst', 52000.00, 'Finance', TO_DATE('2018-09-10', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (903, 'Fook Developer', 'Developer', 64000.00, 'IT', TO_DATE('2021-02-01', 'YYYY-MM-DD'));

COMMIT;
DBMS_OUTPUT.PUT_LINE('Sample data inserted and committed successfully.');
/
