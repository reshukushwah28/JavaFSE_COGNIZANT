SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount IN NUMBER
) RETURN BOOLEAN IS
    v_bal NUMBER(15, 2);
BEGIN
    IF p_amount < 0 THEN
        RETURN FALSE;
    END IF;
    
    SELECT Balance
    INTO v_bal
    FROM Accounts
    WHERE AccountID = p_account_id;
    
    IF v_bal >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account ' || p_account_id || ' missing');
        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
END HasSufficientBalance;
/

DECLARE
    v_acct NUMBER := 1001;
    v_val NUMBER := 3000.00;
BEGIN
    IF HasSufficientBalance(v_acct, v_val) THEN
        DBMS_OUTPUT.PUT_LINE('Test 1: Sufficient');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Test 1: Insufficient');
    END IF;
END;
/

DECLARE
    v_acct NUMBER := 1002;
    v_val NUMBER := 8000.00;
BEGIN
    IF HasSufficientBalance(v_acct, v_val) THEN
        DBMS_OUTPUT.PUT_LINE('Test 2: Sufficient');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Test 2: Insufficient');
    END IF;
END;
/

DECLARE
    v_acct NUMBER := 9999;
    v_val NUMBER := 100.00;
BEGIN
    IF HasSufficientBalance(v_acct, v_val) THEN
        DBMS_OUTPUT.PUT_LINE('Test 3: Sufficient');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Test 3: Insufficient');
    END IF;
END;
/
