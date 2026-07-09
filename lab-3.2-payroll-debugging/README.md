# Lab 3.2 — PAYROL00 / PAYROL0X Debugging

## Objective

Compile and run a working COBOL program (`PAYROL00`), then debug a broken version (`PAYROL0X`) that fails to compile, using the compiler's error message to identify and fix the root cause.

## Part 1 — PAYROL00 (baseline)

Compiled and executed successfully (RC 0000). The program moves literal values into working-storage variables, computes gross pay (`HOURS * RATE`), and displays the result.

## Part 2 — PAYROL0X (debugging)

Initial compilation failed with return code 12 and compiler message `IGYPA3146-S`, pointing to the `GROSS-PAY` picture clause.

### Root cause

```cobol
77  GROSS-PAY  PIC X(5).      " PAYROL0X (broken)
77  GROSS-PAY  PIC 9(5).      " PAYROL00 (working)
```

`GROSS-PAY` was declared as alphanumeric (`PIC X`) instead of numeric (`PIC 9`). Since `GROSS-PAY` is the target of a `COMPUTE` statement, COBOL requires it to be a numeric data item — an alphanumeric field can't receive the result of an arithmetic operation.

### Fix

Changed the picture clause from `PIC X(5)` to `PIC 9(5)`, matching `PAYROL00`. Re-submitted the JCL and confirmed successful compilation and execution (RC 0000).

## Files

- `PAYROL00.cbl` / `PAYROL00.jcl` — working baseline program
- `PAYROL0X.cbl` / `PAYROL0X.jcl` — debugged program (fixed version)

## Notes

This lab reinforced how COBOL's strict data typing (numeric vs. alphanumeric picture clauses) affects arithmetic operations, and how to read compiler diagnostic messages (`IGYPxxxx-S`) to trace an error back to its source line.