# PL/SQL Exercise 1: Control Structures

This exercise uses PL/SQL control structures to manage tables like Customers, Accounts, Transactions, Loans, and Employees.

## Files

1. `schema.sql`: Sets up the database tables and drops any existing ones.
2. `sample_data.sql`: Seeds the tables with mock data for testing.
3. `scenario1_discount_interest.sql`: Cursor loop to apply a 1% interest rate discount to loans of senior citizen customers (age > 60).
4. `scenario2_vip_customers.sql`: Adds an `IsVIP` column and updates it to 'TRUE' for customers with balances over 10,000.
5. `scenario3_loan_reminder.sql`: Loops through loans and prints reminder notices for those maturing within 30 days.

## Usage

Execute the scripts in order:
```sql
@schema.sql;
@sample_data.sql;
@scenario1_discount_interest.sql;
@scenario2_vip_customers.sql;
@scenario3_loan_reminder.sql;
```
