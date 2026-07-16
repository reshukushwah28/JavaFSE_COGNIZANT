SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE
) RETURN NUMBER IS
    v_years NUMBER;
BEGIN
    IF p_dob IS NULL THEN
        RETURN NULL;
    END IF;
    
    v_years := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_years;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END CalculateAge;
/

SELECT CustomerID, Name, DOB, CalculateAge(DOB) AS CalculatedAge
FROM Customers;

DECLARE
    v_d1 DATE := TO_DATE('1991-04-18', 'YYYY-MM-DD');
    v_d2 DATE := NULL;
    v_y1 NUMBER;
    v_y2 NUMBER;
BEGIN
    v_y1 := CalculateAge(v_d1);
    v_y2 := CalculateAge(v_d2);
    
    DBMS_OUTPUT.PUT_LINE('Age 1: ' || NVL(TO_CHAR(v_y1), 'NULL'));
    DBMS_OUTPUT.PUT_LINE('Age 2: ' || NVL(TO_CHAR(v_y2), 'NULL'));
END;
/
