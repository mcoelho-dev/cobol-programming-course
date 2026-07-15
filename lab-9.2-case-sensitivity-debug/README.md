# Lab 9.2 — CBL006A: Case Sensitivity in String Comparison

## Objective

Debug a logical error (not a compilation error) where a report counting "New York" clients returns zero, despite New York clients existing in the input data, caused by a case-sensitivity mismatch in a string comparison.

## Program overview

`CBL006A` extends the report pattern from previous labs, counting clients from a specific state and printing the total as the last line of the report (`NEWYORK-CLIENTS`).

## Bug and fix

The condition in `IS-STATE-NEWYORK` compared `USA-STATE` against a string literal with incorrect casing:

```cobol
IF USA-STATE = 'new York' THEN
```

COBOL string comparisons are case-sensitive by default. Since the actual data in `id.DATA` stores the value as `'New York'` (capital N), the comparison against `'new York'` (lowercase n) never matched, so the counter stayed at zero despite matching records existing in the file.

Fixed by correcting the casing to match the data exactly:

```cobol
IF USA-STATE = 'New York' THEN
```

## Execution

- Before fix: job ran successfully (RC 0000), but the report showed `New York Clients = 000` — a logical bug, not a runtime error.
- After fix: re-submission (RC 0000) produced the correct count: `New York Clients = 005`.

## Files

- `CBL006A.cbl` (fixed)
- `CBL006AJ.jcl`

## Notes

This lab was a good reminder that a successful return code (RC 0000) only confirms the program ran without technical errors — it says nothing about whether the program's *logic* produced the expected result. Always verify the actual output content, not just the completion code.