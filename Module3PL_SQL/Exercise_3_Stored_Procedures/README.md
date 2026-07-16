# PL/SQL Exercise 3: Stored Procedures

This exercise demonstrates the use of stored procedures to manage interest calculations, funds transfers, and bonus adjustments.

## Files

1. `schema.sql`: Database schema tables setup.
2. `sample_data.sql`: Seeds tables with mock test data.
3. `ProcessMonthlyInterest.sql`: Procedure to apply monthly interest to all savings accounts.
4. `TransferFunds.sql`: Procedure to transfer money between two accounts, validating existence and balances with transactional rollbacks.
5. `UpdateEmployeeBonus.sql`: Procedure to award a percentage salary bonus to all employees in a specified department.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@ProcessMonthlyInterest.sql;
@TransferFunds.sql;
@UpdateEmployeeBonus.sql;
```
