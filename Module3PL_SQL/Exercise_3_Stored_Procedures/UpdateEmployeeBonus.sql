SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_dept_name IN VARCHAR2,
    p_bonus_pct IN NUMBER
) IS
    CURSOR cur_emp IS
        SELECT EmployeeID, Name, Department, Salary
        FROM Employees
        WHERE Department = p_dept_name
        FOR UPDATE OF Salary;
        
    v_bonus NUMBER(15, 2);
    v_new_sal NUMBER(15, 2);
    v_cnt NUMBER := 0;
    
    ex_bad_bonus EXCEPTION;
BEGIN
    IF p_bonus_pct < 0 THEN
        RAISE ex_bad_bonus;
    END IF;

    FOR rec_e IN cur_emp LOOP
        v_bonus   := ROUND(rec_e.Salary * (p_bonus_pct / 100), 2);
        v_new_sal := rec_e.Salary + v_bonus;
        
        UPDATE Employees
        SET Salary = v_new_sal
        WHERE CURRENT OF cur_emp;
        
        v_cnt := v_cnt + 1;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec_e.EmployeeID || ' | Name: ' || rec_e.Name || ' | Bonus: ' || TO_CHAR(v_bonus, '$999,999.00') || ' | New Sal: ' || TO_CHAR(v_new_sal, '$999,999.00'));
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employees updated: ' || v_cnt);
EXCEPTION
    WHEN ex_bad_bonus THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Negative bonus');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UpdateEmployeeBonus;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: IT Department Bonus');
    UpdateEmployeeBonus('IT', 10);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: HR Department Bonus');
    UpdateEmployeeBonus('HR', 5);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 3: Negative Bonus');
    UpdateEmployeeBonus('IT', -5);
END;
/
