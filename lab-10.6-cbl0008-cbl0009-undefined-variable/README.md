# Lab 10.6 — CBL0008/CBL0009: Undefined Data Name Debugging

## Objective

Extend the financial report with limit/balance trailer totals, then debug a compilation error in a duplicate program caused by a renamed variable that wasn't updated consistently.

## Programs

- **`CBL0008`** — adds `TLIMIT`/`TBALANCE` accumulators in `WORKING-STORAGE`, computed per record in `LIMIT-BALANCE-TOTAL`, and printed as trailer totals (`TRAILER-1`/`TRAILER-2`) at the end of the report.
- **`CBL0009`** — same logic, but with a bug introduced in the data declaration.

## Bug and fix

The `WORKING-STORAGE` declaration renamed the limit accumulator, but the rest of the program still referenced the old name:

```cobol
01  TLIMIT-TBALANCE.
    05 TLIMITED    PIC S9(9)V99 COMP-3 VALUE ZERO.   " declared as TLIMITED
    05 TBALANCE    PIC S9(9)V99 COMP-3 VALUE ZERO.
```

while `PROCEDURE DIVISION` still used `TLIMIT`:

```cobol
COMPUTE TLIMIT = TLIMIT + ACCT-LIMIT END-COMPUTE.
MOVE TLIMIT TO TLIMIT-O.
```

Since `TLIMIT` was never declared (only `TLIMITED` was), the compiler failed with `IGYPS2121-S` (undefined data name).

Fixed by renaming `TLIMITED` back to `TLIMIT` in the declaration, so it matches all references in the `PROCEDURE DIVISION`.

## Execution

- `CBL0008J` — compiled and ran successfully (RC 0000), report showed limit/balance trailer totals.
- `CBL0009J` — initially failed to compile (`IGYPS2121-S`, undefined data name `TLIMIT`). After correcting the declaration, re-submission compiled and ran successfully (RC 0000).

## Files

- `CBL0008.cbl`, `CBL0008J.jcl`
- `CBL0009.cbl` (fixed), `CBL0009J.jcl`

## Notes

This lab reinforced that every data name referenced in the `PROCEDURE DIVISION` must exactly match its declaration in `WORKING-STORAGE` (or `FILE SECTION`) — a rename in one place without updating the other is a common source of compile-time errors in COBOL.