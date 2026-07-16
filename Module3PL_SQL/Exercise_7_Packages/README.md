# PL/SQL Exercise 7: Packages

This exercise demonstrates the use of PL/SQL packages to group related procedures and functions.

## Files

1. `schema.sql`: Database schema tables setup.
2. `sample_data.sql`: Seeds tables with mock test data.
3. `CustomerManagement.sql`: Package with `AddCustomer`, `UpdateCustomer`, and `GetCustomerBalance`.
4. `EmployeeManagement.sql`: Package with `HireEmployee`, `UpdateEmployee`, and `CalculateAnnualSalary`.
5. `AccountOperations.sql`: Package with `OpenAccount`, `CloseAccount`, and `GetTotalBalance`.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@CustomerManagement.sql;
@EmployeeManagement.sql;
@AccountOperations.sql;
```
