SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :new.LastUpdate := SYSDATE;
END;
/

SELECT CustomerID, Name, LastUpdate 
FROM Customers 
WHERE CustomerID = 1;

UPDATE Customers
SET Name = 'Arthur P. Dent'
WHERE CustomerID = 1;

SELECT CustomerID, Name, LastUpdate 
FROM Customers 
WHERE CustomerID = 1;

ROLLBACK;
