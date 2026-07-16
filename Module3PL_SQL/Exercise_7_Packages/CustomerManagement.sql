SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE CustomerManagement IS

    PROCEDURE AddCustomer(
        p_cust_id IN NUMBER,
        p_name IN VARCHAR2,
        p_dob IN DATE,
        p_balance IN NUMBER
    );
    
    PROCEDURE UpdateCustomer(
        p_cust_id IN NUMBER,
        p_name IN VARCHAR2,
        p_balance IN NUMBER
    );
    
    FUNCTION GetCustomerBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER;

END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement IS

    PROCEDURE AddCustomer(
        p_cust_id IN NUMBER,
        p_name IN VARCHAR2,
        p_dob IN DATE,
        p_balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
        VALUES (p_cust_id, p_name, p_dob, p_balance, 'FALSE', SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Added: ' || p_name || ' (ID: ' || p_cust_id || ')');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20071, 'Customer ID ' || p_cust_id || ' already exists');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLERRM);
    END AddCustomer;
    
    PROCEDURE UpdateCustomer(
        p_cust_id IN NUMBER,
        p_name IN VARCHAR2,
        p_balance IN NUMBER
    ) IS
        v_chk NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_chk FROM Customers WHERE CustomerID = p_cust_id;
        
        IF v_chk = 0 THEN
            RAISE_APPLICATION_ERROR(-20072, 'Customer ID ' || p_cust_id || ' not found');
        END IF;
        
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastUpdate = SYSDATE
        WHERE CustomerID = p_cust_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Updated ID: ' || p_cust_id);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END UpdateCustomer;
    
    FUNCTION GetCustomerBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER IS
        v_bal NUMBER(15, 2);
    BEGIN
        SELECT Balance INTO v_bal FROM Customers WHERE CustomerID = p_cust_id;
        RETURN v_bal;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20073, 'Customer ID ' || p_cust_id || ' not found');
    END GetCustomerBalance;

END CustomerManagement;
/

DECLARE
    v_b NUMBER;
BEGIN
    CustomerManagement.AddCustomer(10, 'Ford Prefect', TO_DATE('1975-11-10', 'YYYY-MM-DD'), 24000.00);
    
    v_b := CustomerManagement.GetCustomerBalance(10);
    DBMS_OUTPUT.PUT_LINE('Balance: ' || TO_CHAR(v_b, '$99,999.00'));
    
    CustomerManagement.UpdateCustomer(10, 'Ford P. Prefect', 26000.00);
    
    v_b := CustomerManagement.GetCustomerBalance(10);
    DBMS_OUTPUT.PUT_LINE('Updated Balance: ' || TO_CHAR(v_b, '$99,999.00'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
