SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_loans IS
        SELECT c.CustomerID,
               c.Name AS CustomerName,
               c.DOB,
               l.LoanID,
               l.InterestRate AS OldInterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;
        
    rec_l cur_loans%ROWTYPE;
    v_cust_age NUMBER;
    v_discounted_rate NUMBER(5,2);
    v_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== UPDATE LOAN RATES ===');
    OPEN cur_loans;
    LOOP
        FETCH cur_loans INTO rec_l;
        EXIT WHEN cur_loans%NOTFOUND;
        
        v_cust_age := FLOOR(MONTHS_BETWEEN(SYSDATE, rec_l.DOB) / 12);
        
        IF v_cust_age > 60 THEN
            v_discounted_rate := rec_l.OldInterestRate - 1.0;
            IF v_discounted_rate < 0 THEN
                v_discounted_rate := 0;
            END IF;
            
            UPDATE Loans
            SET InterestRate = v_discounted_rate
            WHERE LoanID = rec_l.LoanID;
            
            v_cnt := v_cnt + 1;
            
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec_l.CustomerName);
            DBMS_OUTPUT.PUT_LINE('Age: ' || v_cust_age);
            DBMS_OUTPUT.PUT_LINE('Old Rate: ' || TO_CHAR(rec_l.OldInterestRate, '99.99') || '%');
            DBMS_OUTPUT.PUT_LINE('New Rate: ' || TO_CHAR(v_discounted_rate, '99.99') || '%');
            DBMS_OUTPUT.PUT_LINE('---');
        END IF;
    END LOOP;
    CLOSE cur_loans;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Loans updated: ' || v_cnt);
EXCEPTION
    WHEN OTHERS THEN
        IF cur_loans%ISOPEN THEN
            CLOSE cur_loans;
        END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
