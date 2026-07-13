# Lab 7.5 — CBL0004/CBL0005: Currency Symbol Formatting

## Objective

Compare two nearly identical report-generating COBOL programs, identify a formatting difference in the output, and fix it by editing the picture clause of the affected fields.

## Programs

- **`CBL0004`** — generates a financial report with headers, formatting currency fields using picture clause `PIC $$,$$$,$$9.99`, which floats a `$` symbol in front of the value.
- **`CBL0005`** — originally used `PIC ZZ,ZZZ,ZZ9.99` for the same fields. The `Z` character suppresses leading zeros (replacing them with spaces) but does not insert any currency symbol, so the report printed amounts without the `$`.

## Bug and fix

Both `ACCT-LIMIT-O` and `ACCT-BALANCE-O` in `CBL0005` were declared as:

```cobol
05  ACCT-LIMIT-O   PIC ZZ,ZZZ,ZZ9.99.
05  ACCT-BALANCE-O PIC ZZ,ZZZ,ZZ9.99.
```

Changed to match `CBL0004`'s formatting:

```cobol
05  ACCT-LIMIT-O   PIC $$,$$$,$$9.99.
05  ACCT-BALANCE-O PIC $$,$$$,$$9.99.
```

## Execution

- `CBL0004J` — ran successfully (RC 0000), report showed both `Limit` and `Balance` columns with `$`.
- `CBL0005J` — initially ran successfully but without `$` in either column. After fixing only `ACCT-BALANCE-O`, the `Balance` column showed `$` but `Limit` still didn't — a reminder that both fields needed the same fix. After correcting `ACCT-LIMIT-O` as well, re-submitting confirmed both columns now display the `$` symbol correctly.

## Files

- `CBL0004.cbl`, `CBL0004J.jcl`
- `CBL0005.cbl` (fixed), `CBL0005J.jcl`

## Notes

`$$,$$$,$$9.99` (floating currency symbol) vs `ZZ,ZZZ,ZZ9.99` (zero suppression only) are both edited picture clauses used for report formatting, but only the former inserts a currency symbol — a useful distinction for designing readable financial reports.