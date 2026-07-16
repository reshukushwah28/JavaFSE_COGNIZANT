SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_cust_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER
) IS
    v_chk NUMBER;
    ex_dupe_cust EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_chk FROM Customers WHERE CustomerID = p_cust_id;
    IF v_chk > 0 THEN
        RAISE ex_dupe_cust;
    END IF;
    
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastUpdate)
    VALUES (p_cust_id, p_name, p_dob, p_balance, 'FALSE', SYSDATE);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Added ID: ' || p_cust_id);
EXCEPTION
    WHEN ex_dupe_cust THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20007, 'Customer ' || p_cust_id || ' already exists');
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20008, 'Unique constraint violation for ID ' || p_cust_id);
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20009, 'Query error');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLERRM);
END AddNewCustomer;
/

DECLARE
    v_id NUMBER := 12;
    v_nm VARCHAR2(100) := 'Fenchurch Prefect';
    v_db DATE := TO_DATE('1988-12-10', 'YYYY-MM-DD');
    v_bl NUMBER := 4500.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: New Customer');
    AddNewCustomer(v_id, v_nm, v_db, v_bl);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

DECLARE
    v_id NUMBER := 1;
    v_nm VARCHAR2(100) := 'Arthur Dent';
    v_db DATE := TO_DATE('1954-03-11', 'YYYY-MM-DD');
    v_bl NUMBER := 13500.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: Duplicate ID');
    AddNewCustomer(v_id, v_nm, v_db, v_bl);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
