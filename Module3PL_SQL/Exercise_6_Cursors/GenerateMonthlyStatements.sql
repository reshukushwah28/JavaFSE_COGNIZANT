SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_monthly_tx IS
        SELECT c.Name AS CustomerName,
               a.AccountID,
               t.TransactionID,
               t.TransactionDate,
               t.TransactionType,
               t.Amount
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE TRUNC(t.TransactionDate, 'MM') = TRUNC(SYSDATE, 'MM')
        ORDER BY c.Name, a.AccountID, t.TransactionDate;
        
    rec_t cur_monthly_tx%ROWTYPE;
    v_cnt NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== MONTHLY TRANSACTIONS ===');
    OPEN cur_monthly_tx;
    LOOP
        FETCH cur_monthly_tx INTO rec_t;
        EXIT WHEN cur_monthly_tx%NOTFOUND;
        
        v_cnt := v_cnt + 1;
        
        DBMS_OUTPUT.PUT_LINE('Record: ' || v_cnt);
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec_t.CustomerName);
        DBMS_OUTPUT.PUT_LINE('Account: ' || rec_t.AccountID);
        DBMS_OUTPUT.PUT_LINE('TxID: ' || rec_t.TransactionID);
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(rec_t.TransactionDate, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('Type: ' || rec_t.TransactionType);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || TO_CHAR(rec_t.Amount, '$99,999.00'));
        DBMS_OUTPUT.PUT_LINE('---');
    END LOOP;
    CLOSE cur_monthly_tx;
    DBMS_OUTPUT.PUT_LINE('Total transactions: ' || v_cnt);
EXCEPTION
    WHEN OTHERS THEN
        IF cur_monthly_tx%ISOPEN THEN
            CLOSE cur_monthly_tx;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
