SET SERVEROUTPUT ON;

DECLARE
    v_col_cnt NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_col_cnt
    FROM USER_TAB_COLS
    WHERE TABLE_NAME = 'CUSTOMERS' AND COLUMN_NAME = 'ISVIP';
    
    IF v_col_cnt = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE Customers ADD (IsVIP VARCHAR2(5))';
        DBMS_OUTPUT.PUT_LINE('Column IsVIP added.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Column IsVIP already exists.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR cur_cust IS
        SELECT CustomerID, Name, Balance
        FROM Customers
        FOR UPDATE OF IsVIP;
        
    rec_c cur_cust%ROWTYPE;
    v_vip VARCHAR2(5);
    v_total NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== VIP CLASSIFICATION ===');
    OPEN cur_cust;
    LOOP
        FETCH cur_cust INTO rec_c;
        EXIT WHEN cur_cust%NOTFOUND;
        
        IF rec_c.Balance > 10000 THEN
            v_vip := 'TRUE';
        ELSE
            v_vip := 'FALSE';
        END IF;
        
        UPDATE Customers
        SET IsVIP = v_vip
        WHERE CURRENT OF cur_cust;
        
        v_total := v_total + 1;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec_c.CustomerID || ' | Name: ' || rec_c.Name || ' | Balance: ' || TO_CHAR(rec_c.Balance, '$99,999.00') || ' | VIP: ' || v_vip);
    END LOOP;
    CLOSE cur_cust;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total processed: ' || v_total);
EXCEPTION
    WHEN OTHERS THEN
        IF cur_cust%ISOPEN THEN
            CLOSE cur_cust;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
