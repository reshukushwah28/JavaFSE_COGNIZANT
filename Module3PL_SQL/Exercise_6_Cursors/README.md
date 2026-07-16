# PL/SQL Exercise 6: Cursors

This exercise focuses on using explicit cursors to navigate multi-row result sets and apply updates or generate statements.

## Files

1. `schema.sql`: Database schema tables setup.
2. `sample_data.sql`: Seeds tables with mock test data.
3. `GenerateMonthlyStatements.sql`: Retrieves transactions for the current month to output a statement list.
4. `ApplyAnnualFee.sql`: Applies a $50 maintenance charge to all accounts using `WHERE CURRENT OF`.
5. `UpdateLoanInterestRates.sql`: Adjusts interest rates on loans based on amount bounds.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@GenerateMonthlyStatements.sql;
@ApplyAnnualFee.sql;
@UpdateLoanInterestRates.sql;
```
