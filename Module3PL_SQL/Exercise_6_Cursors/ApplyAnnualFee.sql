SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_accts IS
        SELECT AccountID, Balance
        FROM Accounts
        FOR UPDATE OF Balance;
        
    rec_a cur_accts%ROWTYPE;
    v_charge CONSTANT NUMBER(5, 2) := 50.00;
    v_updated_bal NUMBER(15, 2);
    v_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ANNUAL FEE DEDUCTION ===');
    OPEN cur_accts;
    LOOP
        FETCH cur_accts INTO rec_a;
        EXIT WHEN cur_accts%NOTFOUND;
        
        v_updated_bal := rec_a.Balance - v_charge;
        IF v_updated_bal < 0 THEN
            v_updated_bal := 0;
        END IF;
        
        UPDATE Accounts
        SET Balance = v_updated_bal,
            LastUpdate = SYSDATE
        WHERE CURRENT OF cur_accts;
        
        v_cnt := v_cnt + 1;
        
        DBMS_OUTPUT.PUT_LINE('Account: ' || rec_a.AccountID || ' | Old: ' || TO_CHAR(rec_a.Balance, '$99,999.00') || ' | New: ' || TO_CHAR(v_updated_bal, '$99,999.00'));
    END LOOP;
    CLOSE cur_accts;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Accounts updated: ' || v_cnt);
EXCEPTION
    WHEN OTHERS THEN
        IF cur_accts%ISOPEN THEN
            CLOSE cur_accts;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
