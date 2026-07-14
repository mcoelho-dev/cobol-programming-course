# Lab 8.6 — CBL0006/CBL0007: IF Statement Syntax Debugging

## Objective

Extend the currency-formatted report from previous labs with a conditional counter (clients from Virginia), then debug a syntax error in a duplicate program caused by incorrect `IF` statement punctuation.

## Programs

- **`CBL0006`** — adds a `CLIENTS-PER-STATE` counter and paragraph `IS-STATE-VIRGINIA`, which checks `USA-STATE = 'Virginia'` and increments `VIRGINIA-CLIENTS` when true. The count is printed as the last line of the report.
- **`CBL0007`** — same logic, but implemented using a level-88 condition name (`88 STATE VALUE 'Virginia'.`) instead of a direct equality check, so the `IF` statement can simply test `IF STATE` instead of `IF USA-STATE = 'Virginia'`.

## Bug and fix

`CBL0007` failed to compile with error `IGYPS2113-E`, caused by:

```cobol
IF STATE ADD 1 TO VIRGINIA-CLIENTS.
END-IF.
```

The period after `VIRGINIA-CLIENTS` terminates the COBOL sentence immediately, leaving the following `END-IF` as an orphaned statement with no matching `IF`.

Fixed by moving the period to after `END-IF`, so the full conditional block is properly scoped:

```cobol
IF STATE
   ADD 1 TO VIRGINIA-CLIENTS
END-IF.
```

## Execution

- `CBL0006J` — compiled and ran successfully (RC 0000), report included the Virginia client count.
- `CBL0007J` — initially failed with RC 12 (`IGYPS2113-E`). After the fix, re-submission compiled and ran successfully (RC 0000), matching `CBL0006`'s output.

## Files

- `CBL0006.cbl`, `CBL0006J.jcl`
- `CBL0007.cbl` (fixed), `CBL0007J.jcl`

## Notes

This lab highlighted how COBOL's period (`.`) acts as a statement terminator and how misplacing it — even by one line — can break the scope of a conditional block. It also introduced level-88 condition names as a more readable alternative to repeating equality checks.