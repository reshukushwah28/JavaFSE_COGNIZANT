SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_emp_id IN NUMBER,
    p_percentage IN NUMBER
) IS
    v_old_sal NUMBER(15, 2);
    v_new_sal NUMBER(15, 2);
    v_name VARCHAR2(100);
    v_pos VARCHAR2(50);
    v_dpt VARCHAR2(50);
    
    ex_bad_pct EXCEPTION;
BEGIN
    IF p_percentage < 0 THEN
        RAISE ex_bad_pct;
    END IF;
    
    SELECT Name, Position, Salary, Department
    INTO v_name, v_pos, v_old_sal, v_dpt
    FROM Employees
    WHERE EmployeeID = p_emp_id;
    
    v_new_sal := v_old_sal * (1 + (p_percentage / 100));
    
    UPDATE Employees
    SET Salary = v_new_sal
    WHERE EmployeeID = p_emp_id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Updated ' || v_name || ' (ID: ' || p_emp_id || ') to salary: ' || TO_CHAR(v_new_sal, '$999,999.00'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20005, 'Employee ' || p_emp_id || ' not found');
    WHEN ex_bad_pct THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20006, 'Percentage cannot be negative');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLERRM);
END UpdateSalary;
/

DECLARE
    v_id NUMBER := 901;
    v_pc NUMBER := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 1: Normal Salary Update');
    UpdateSalary(v_id, v_pc);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/

DECLARE
    v_id NUMBER := 999;
    v_pc NUMBER := 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Test 2: Non-existent Employee');
    UpdateSalary(v_id, v_pc);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
