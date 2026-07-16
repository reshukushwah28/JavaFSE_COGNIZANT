SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_bal NUMBER(15, 2);
BEGIN
    IF :new.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Amount must be positive');
    END IF;
    
    IF :new.TransactionType = 'Withdrawal' THEN
        SELECT Balance 
        INTO v_bal 
        FROM Accounts 
        WHERE AccountID = :new.AccountID;
        
        IF :new.Amount > v_bal THEN
            RAISE_APPLICATION_ERROR(-20022, 'Insufficient balance. Available: ' || TO_CHAR(v_bal));
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20023, 'Account ' || :new.AccountID || ' not found');
    WHEN OTHERS THEN
        RAISE;
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: Overdraft');
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (951, 1001, SYSDATE, 15000.00, 'Withdrawal');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: Negative Deposit');
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (952, 1001, SYSDATE, -50.00, 'Deposit');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 3: Valid Deposit');
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (953, 1001, SYSDATE, 300.00, 'Deposit');
    DBMS_OUTPUT.PUT_LINE('Success');
    ROLLBACK;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
