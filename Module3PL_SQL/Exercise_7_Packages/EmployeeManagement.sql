SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE EmployeeManagement IS

    PROCEDURE HireEmployee(
        p_emp_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_dept IN VARCHAR2,
        p_hire_date IN DATE
    );
    
    PROCEDURE UpdateEmployee(
        p_emp_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_dept IN VARCHAR2
    );
    
    FUNCTION CalculateAnnualSalary(
        p_emp_id IN NUMBER
    ) RETURN NUMBER;

END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement IS

    PROCEDURE HireEmployee(
        p_emp_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_dept IN VARCHAR2,
        p_hire_date IN DATE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_emp_id, p_name, p_position, p_salary, p_dept, p_hire_date);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Hired: ' || p_name || ' (ID: ' || p_emp_id || ')');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20081, 'Employee ID ' || p_emp_id || ' already exists');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999, 'Error: ' || SQLERRM);
    END HireEmployee;
    
    PROCEDURE UpdateEmployee(
        p_emp_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_dept IN VARCHAR2
    ) IS
        v_chk NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_chk FROM Employees WHERE EmployeeID = p_emp_id;
        
        IF v_chk = 0 THEN
            RAISE_APPLICATION_ERROR(-20082, 'Employee ID ' || p_emp_id || ' not found');
        END IF;
        
        UPDATE Employees
        SET Name = p_name,
            Position = p_position,
            Salary = p_salary,
            Department = p_dept
        WHERE EmployeeID = p_emp_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Updated ID: ' || p_emp_id);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END UpdateEmployee;
    
    FUNCTION CalculateAnnualSalary(
        p_emp_id IN NUMBER
    ) RETURN NUMBER IS
        v_sal NUMBER(15, 2);
    BEGIN
        SELECT Salary INTO v_sal FROM Employees WHERE EmployeeID = p_emp_id;
        RETURN v_sal * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20083, 'Employee ID ' || p_emp_id || ' not found');
    END CalculateAnnualSalary;

END EmployeeManagement;
/

DECLARE
    v_ann NUMBER;
BEGIN
    EmployeeManagement.HireEmployee(910, 'Fook Developer', 'Analyst', 55000.00, 'IT', TO_DATE('2022-04-01', 'YYYY-MM-DD'));
    
    v_ann := EmployeeManagement.CalculateAnnualSalary(910);
    DBMS_OUTPUT.PUT_LINE('Annual: ' || TO_CHAR(v_ann, '$999,999.00'));
    
    EmployeeManagement.UpdateEmployee(910, 'Fook Developer', 'Senior Analyst', 62000.00, 'IT');
    
    v_ann := EmployeeManagement.CalculateAnnualSalary(910);
    DBMS_OUTPUT.PUT_LINE('Updated Annual: ' || TO_CHAR(v_ann, '$999,999.00'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ex: ' || SQLERRM);
END;
/
