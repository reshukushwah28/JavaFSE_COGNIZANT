SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_due IS
        SELECT c.Name AS CustomerName,
               l.LoanID,
               l.LoanAmount,
               l.EndDate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND (SYSDATE + 30);
        
    rec_l cur_due%ROWTYPE;
    v_days_left NUMBER;
    v_reminder_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== LOAN REPAYMENT REMINDERS ===');
    OPEN cur_due;
    LOOP
        FETCH cur_due INTO rec_l;
        EXIT WHEN cur_due%NOTFOUND;
        
        v_reminder_cnt := v_reminder_cnt + 1;
        v_days_left := CEIL(rec_l.EndDate - SYSDATE);
        
        DBMS_OUTPUT.PUT_LINE('Reminder: ' || v_reminder_cnt);
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec_l.CustomerName);
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || rec_l.LoanID);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(rec_l.LoanAmount, '$99,999.00'));
        DBMS_OUTPUT.PUT_LINE('Due Date: ' || TO_CHAR(rec_l.EndDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('Days Left: ' || v_days_left);
        DBMS_OUTPUT.PUT_LINE('Message: Dear ' || rec_l.CustomerName || ', your loan of ' || TO_CHAR(rec_l.LoanAmount, '$99,999.00') || ' matures on ' || TO_CHAR(rec_l.EndDate, 'YYYY-MM-DD') || '. Please arrange payment.');
        DBMS_OUTPUT.PUT_LINE('---');
    END LOOP;
    CLOSE cur_due;
    
    IF v_reminder_cnt = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans maturing in the next 30 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total reminders generated: ' || v_reminder_cnt);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF cur_due%ISOPEN THEN
            CLOSE cur_due;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
