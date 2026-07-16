SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_acc_id IN NUMBER,
    p_dest_acc_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_src_bal NUMBER(15, 2);
    v_dst_bal NUMBER(15, 2);
    
    ex_no_src EXCEPTION;
    ex_no_dst EXCEPTION;
    ex_no_funds EXCEPTION;
    ex_bad_amt EXCEPTION;
BEGIN
    IF p_amount <= 0 THEN
        RAISE ex_bad_amt;
    END IF;
    
    BEGIN
        SELECT Balance INTO v_src_bal FROM Accounts WHERE AccountID = p_source_acc_id FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_no_src;
    END;
    
    BEGIN
        SELECT Balance INTO v_dst_bal FROM Accounts WHERE AccountID = p_dest_acc_id FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_no_dst;
    END;
    
    IF v_src_bal < p_amount THEN
        RAISE ex_no_funds;
    END IF;
    
    UPDATE Accounts SET Balance = Balance - p_amount, LastUpdate = SYSDATE WHERE AccountID = p_source_acc_id;
    UPDATE Accounts SET Balance = Balance + p_amount, LastUpdate = SYSDATE WHERE AccountID = p_dest_acc_id;
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES ((SELECT NVL(MAX(TransactionID), 0) + 1 FROM Transactions), p_source_acc_id, SYSDATE, p_amount, 'Withdrawal');
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES ((SELECT NVL(MAX(TransactionID), 0) + 1 FROM Transactions), p_dest_acc_id, SYSDATE, p_amount, 'Deposit');
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Success. Transferred: ' || TO_CHAR(p_amount));
EXCEPTION
    WHEN ex_bad_amt THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20011, 'Amount must be positive');
    WHEN ex_no_src THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20012, 'Source account ' || p_source_acc_id || ' not found');
    WHEN ex_no_dst THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20013, 'Destination account ' || p_dest_acc_id || ' not found');
    WHEN ex_no_funds THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20014, 'Insufficient balance');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLERRM);
END TransferFunds;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: Normal Transfer');
    TransferFunds(1001, 1002, 1000.00);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: Insufficient Funds');
    TransferFunds(1001, 1002, 200000.00);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 3: Non-existent Dest Account');
    TransferFunds(1001, 9999, 100.00);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
