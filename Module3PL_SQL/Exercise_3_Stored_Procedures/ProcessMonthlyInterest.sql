SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest (
    p_interest_rate IN NUMBER DEFAULT 1.0
) IS
    CURSOR cur_savings IS
        SELECT AccountID, CustomerID, Balance
        FROM Accounts
        WHERE AccountType = 'Savings'
        FOR UPDATE;
        
    v_interest NUMBER(15, 2);
    v_new_bal NUMBER(15, 2);
    v_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== MONTHLY INTEREST PROCESS ===');
    
    FOR rec_s IN cur_savings LOOP
        v_interest := ROUND(rec_s.Balance * (p_interest_rate / 12) / 100, 2);
        v_new_bal  := rec_s.Balance + v_interest;
        
        UPDATE Accounts
        SET Balance = v_new_bal,
            LastUpdate = SYSDATE
        WHERE CURRENT OF cur_savings;
        
        v_cnt := v_cnt + 1;
        
        DBMS_OUTPUT.PUT_LINE('Account: ' || rec_s.AccountID || ' | Interest: ' || TO_CHAR(v_interest, '$99,999.00') || ' | New Bal: ' || TO_CHAR(v_new_bal, '$99,999.00'));
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total Processed: ' || v_cnt);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END ProcessMonthlyInterest;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: Default Rate');
    ProcessMonthlyInterest;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: 5% Rate');
    ProcessMonthlyInterest(5.0);
END;
/
