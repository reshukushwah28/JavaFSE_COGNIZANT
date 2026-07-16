SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount IN NUMBER,
    p_interest_rate IN NUMBER,
    p_duration_years IN NUMBER
) RETURN NUMBER IS
    v_rate NUMBER;
    v_months NUMBER;
    v_instalment NUMBER;
BEGIN
    IF p_loan_amount IS NULL OR p_interest_rate IS NULL OR p_duration_years IS NULL THEN
        RETURN 0;
    END IF;
    
    IF p_loan_amount <= 0 OR p_duration_years <= 0 OR p_interest_rate < 0 THEN
        RETURN 0;
    END IF;
    
    v_months := p_duration_years * 12;
    
    IF p_interest_rate = 0 THEN
        v_instalment := p_loan_amount / v_months;
    ELSE
        v_rate := (p_interest_rate / 12) / 100;
        v_instalment := (p_loan_amount * v_rate * POWER(1 + v_rate, v_months)) /
                 (POWER(1 + v_rate, v_months) - 1);
    END IF;
    
    RETURN ROUND(v_instalment, 2);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END CalculateMonthlyInstallment;
/

SELECT LoanID, CustomerID, LoanAmount, InterestRate, 
       CalculateMonthlyInstallment(LoanAmount, InterestRate, 5) AS MonthlyEMI
FROM Loans;

DECLARE
    v_e1 NUMBER;
    v_e2 NUMBER;
BEGIN
    v_e1 := CalculateMonthlyInstallment(15000, 10.0, 2);
    v_e2 := CalculateMonthlyInstallment(18000, 0.0, 3);
    
    DBMS_OUTPUT.PUT_LINE('EMI 1: ' || TO_CHAR(v_e1, '$99,999.00'));
    DBMS_OUTPUT.PUT_LINE('EMI 2: ' || TO_CHAR(v_e2, '$99,999.00'));
END;
/
