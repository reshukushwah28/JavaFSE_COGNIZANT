SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (AuditID, TransactionID, Action, ActionDate, ActionUser)
    VALUES (
        seq_audit_log.NEXTVAL, 
        :new.TransactionID, 
        'TX: ' || :new.TransactionType, 
        SYSDATE, 
        USER
    );
END;
/

SELECT * FROM AuditLog;

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (801, 1001, SYSDATE, 350.00, 'Deposit');

SELECT AuditID, TransactionID, Action, ActionDate, ActionUser 
FROM AuditLog;

ROLLBACK;
