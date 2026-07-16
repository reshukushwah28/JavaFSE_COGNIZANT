# PL/SQL Exercise 4: Functions

This exercise covers the design of stored functions to compute values and validate business conditions.

## Files

1. `schema.sql`: Database schema tables setup.
2. `sample_data.sql`: Seeds tables with mock test data.
3. `CalculateAge.sql`: Function to calculate a customer's age in years based on their Date of Birth.
4. `CalculateMonthlyInstallment.sql`: Function to calculate equated monthly installments (EMI) for a loan.
5. `HasSufficientBalance.sql`: Function returning BOOLEAN to check if an account balance is sufficient for a transaction.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@CalculateAge.sql;
@CalculateMonthlyInstallment.sql;
@HasSufficientBalance.sql;
```
