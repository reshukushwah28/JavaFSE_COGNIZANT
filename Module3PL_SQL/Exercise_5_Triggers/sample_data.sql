DELETE FROM AuditLog;
DELETE FROM Transactions;
DELETE FROM Accounts;
DELETE FROM Loans;
DELETE FROM Customers;
DELETE FROM Employees;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
VALUES (1, 'Arthur Dent', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 5100.00, 'FALSE', SYSDATE - 10);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
VALUES (2, 'Tricia McMillan', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1300.00, 'FALSE', SYSDATE - 5);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1001, 1, 'Savings', 5100.00, SYSDATE - 10);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
VALUES (1002, 2, 'Checking', 1300.00, SYSDATE - 5);

COMMIT;
DBMS_OUTPUT.PUT_LINE('Sample data loaded.');
/
