# PL/SQL Exercise 2: Error Handling

This exercise covers stored procedures with error handling, predefined system exceptions, user exceptions, and rollback strategies.

## Files

1. `schema.sql`: Database schema tables setup.
2. `sample_data.sql`: Seeds tables with mock test data.
3. `SafeTransferFunds.sql`: Procedure to transfer money between accounts with source/dest validations, row locking, and custom exception rollbacks.
4. `UpdateSalary.sql`: Procedure to update an employee's salary by a positive percentage with validation checking.
5. `AddNewCustomer.sql`: Procedure to insert new customer details after checking for ID duplication.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@SafeTransferFunds.sql;
@UpdateSalary.sql;
@AddNewCustomer.sql;
```
