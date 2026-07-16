# PL/SQL Exercise 5: Triggers

This exercise covers triggers to automate audits, updates, and rules.

## Files

1. `schema.sql`: Sets up tables, sequence `seq_audit_log`, and the `AuditLog` table.
2. `sample_data.sql`: Seeds customers and accounts.
3. `UpdateCustomerLastModified.sql`: Trigger that automatically updates `LastUpdate` whenever a customer record changes.
4. `LogTransaction.sql`: Trigger that writes transaction audit records into `AuditLog` on transaction insertion.
5. `CheckTransactionRules.sql`: Trigger that checks for positive amounts and overdraft bounds before inserting a transaction.

## Usage

```sql
@schema.sql;
@sample_data.sql;
@UpdateCustomerLastModified.sql;
@LogTransaction.sql;
@CheckTransactionRules.sql;
```
