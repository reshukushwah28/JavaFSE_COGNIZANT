SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE AccountOperations IS

    PROCEDURE OpenAccount(
        p_acc_id IN NUMBER,
        p_cust_id IN NUMBER,
        p_acc_type IN VARCHAR2,
        p_balance IN NUMBER
    );
    
    PROCEDURE CloseAccount(
        p_acc_id IN NUMBER
    );
    
    FUNCTION GetTotalBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER;

END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations IS

    PROCEDURE OpenAccount(
        p_acc_id IN NUMBER,
        p_cust_id IN NUMBER,
        p_acc_type IN VARCHAR2,
        p_balance IN NUMBER
    ) IS
        v_cust_chk NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_cust_chk FROM Customers WHERE CustomerID = p_cust_id;
        
        IF v_cust_chk = 0 THEN
            RAISE_APPLICATION_ERROR(-20091, 'Customer ID ' || p_cust_id || ' not found');
        END IF;
        
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastUpdate)
        VALUES (p_acc_id, p_cust_id, p_acc_type, p_balance, SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Opened Account: ' || p_acc_id || ' for Customer: ' || p_cust_id);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20092, 'Account ID ' || p_acc_id || ' already exists');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END OpenAccount;
    
    PROCEDURE CloseAccount(
        p_acc_id IN NUMBER
    ) IS
        v_chk NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_chk FROM Accounts WHERE AccountID = p_acc_id;
        
        IF v_chk = 0 THEN
            RAISE_APPLICATION_ERROR(-20093, 'Account ID ' || p_acc_id || ' not found');
        END IF;
        
        DELETE FROM Accounts WHERE AccountID = p_acc_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Closed Account: ' || p_acc_id);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END CloseAccount;
    
    FUNCTION GetTotalBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER IS
        v_total NUMBER(15, 2);
        v_cust_chk NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_cust_chk FROM Customers WHERE CustomerID = p_cust_id;
        
        IF v_cust_chk = 0 THEN
            RAISE_APPLICATION_ERROR(-20094, 'Customer ID ' || p_cust_id || ' not found');
        END IF;
        
        SELECT SUM(Balance) INTO v_total FROM Accounts WHERE CustomerID = p_cust_id;
        
        RETURN NVL(v_total, 0.00);
    END GetTotalBalance;

END AccountOperations;
/

DECLARE
    v_tot NUMBER;
BEGIN
    AccountOperations.OpenAccount(2005, 1, 'Savings', 3000.00);
    
    v_tot := AccountOperations.GetTotalBalance(1);
    DBMS_OUTPUT.PUT_LINE('Total Balance: ' || TO_CHAR(v_tot, '$99,999.00'));
    
    AccountOperations.CloseAccount(2005);
    
    v_tot := AccountOperations.GetTotalBalance(1);
    DBMS_OUTPUT.PUT_LINE('After Close: ' || TO_CHAR(v_tot, '$99,999.00'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
