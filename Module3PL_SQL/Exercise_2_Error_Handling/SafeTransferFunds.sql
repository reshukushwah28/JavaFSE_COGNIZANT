SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_source_acc_id IN NUMBER,
    p_dest_acc_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_src_bal NUMBER(15, 2);
    v_dst_bal NUMBER(15, 2);
    v_src_ok NUMBER;
    v_dst_ok NUMBER;
    
    ex_bad_amt EXCEPTION;
    ex_no_src EXCEPTION;
    ex_no_dst EXCEPTION;
    ex_no_funds EXCEPTION;
BEGIN
    IF p_amount <= 0 THEN
        RAISE ex_bad_amt;
    END IF;
    
    SELECT COUNT(*) INTO v_src_ok FROM Accounts WHERE AccountID = p_source_acc_id;
    IF v_src_ok = 0 THEN
        RAISE ex_no_src;
    END IF;
    
    SELECT COUNT(*) INTO v_dst_ok FROM Accounts WHERE AccountID = p_dest_acc_id;
    IF v_dst_ok = 0 THEN
        RAISE ex_no_dst;
    END IF;
    
    SELECT Balance INTO v_src_bal FROM Accounts WHERE AccountID = p_source_acc_id FOR UPDATE;
    SELECT Balance INTO v_dst_bal FROM Accounts WHERE AccountID = p_dest_acc_id FOR UPDATE;
    
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
    DBMS_OUTPUT.PUT_LINE('Success');
EXCEPTION
    WHEN ex_bad_amt THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Amount must be positive');
    WHEN ex_no_src THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Source account ' || p_source_acc_id || ' not found');
    WHEN ex_no_dst THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Destination account ' || p_dest_acc_id || ' not found');
    WHEN ex_no_funds THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Insufficient funds. Balance: ' || TO_CHAR(v_src_bal) || ', requested: ' || TO_CHAR(p_amount));
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLCODE || ' - ' || SQLERRM);
END SafeTransferFunds;
/

DECLARE
    v_s NUMBER := 1001;
    v_d NUMBER := 1002;
    v_a NUMBER := 500.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: Normal Transfer');
    SafeTransferFunds(v_s, v_d, v_a);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

DECLARE
    v_s NUMBER := 1001;
    v_d NUMBER := 1002;
    v_a NUMBER := 99999.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: Insufficient Funds');
    SafeTransferFunds(v_s, v_d, v_a);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
