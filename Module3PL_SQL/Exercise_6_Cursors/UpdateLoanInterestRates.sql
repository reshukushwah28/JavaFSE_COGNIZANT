SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_ln IS
        SELECT l.LoanID,
               l.LoanAmount,
               l.InterestRate AS OldRate,
               c.Name AS CustomerName
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        FOR UPDATE OF l.InterestRate;
        
    rec_l cur_ln%ROWTYPE;
    v_updated_rate NUMBER(5, 2);
    v_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== LOAN INTEREST UPDATE ===');
    OPEN cur_ln;
    LOOP
        FETCH cur_ln INTO rec_l;
        EXIT WHEN cur_ln%NOTFOUND;
        
        IF rec_l.LoanAmount > 40000.00 THEN
            v_updated_rate := rec_l.OldRate - 0.50;
        ELSE
            v_updated_rate := rec_l.OldRate - 0.25;
        END IF;
        
        IF v_updated_rate < 0 THEN
            v_updated_rate := 0.00;
        END IF;
        
        UPDATE Loans
        SET InterestRate = v_updated_rate
        WHERE CURRENT OF cur_ln;
        
        v_cnt := v_cnt + 1;
        
        DBMS_OUTPUT.PUT_LINE('Loan: ' || rec_l.LoanID || ' | Customer: ' || rec_l.CustomerName || ' | Old Rate: ' || TO_CHAR(rec_l.OldRate, '99.99') || '% | New Rate: ' || TO_CHAR(v_updated_rate, '99.99') || '%');
    END LOOP;
    CLOSE cur_ln;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total updated: ' || v_cnt);
EXCEPTION
    WHEN OTHERS THEN
        IF cur_ln%ISOPEN THEN
            CLOSE cur_ln;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
