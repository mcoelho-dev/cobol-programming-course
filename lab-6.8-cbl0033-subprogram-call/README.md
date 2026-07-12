# Lab 6.8 — CBL0033: Calling a Subprogram (CALL)

## Objective

Compile and run a COBOL program (`CBL0033`) that statically calls another compiled program (`HELLO`) as a subprogram, requiring a two-step compile process linked together into a single executable module.

## Program overview

`CBL0033` builds on the read/write loop pattern from `CBL0001`/`CBL0002`, adding:

- A `COUNTER` variable in `WORKING-STORAGE` used for a `PERFORM VARYING` loop
- Numbered paragraphs (e.g. `2000-`, `2100-`) each explicitly closed with a `-END` paragraph, used as a readability convention (similar to a closing brace)
- Several variations of the same read-loop logic, demonstrating different forms of `PERFORM`: `PERFORM ... TIMES`, `PERFORM ... THRU`, and `PERFORM VARYING ... UNTIL`
- A `CALL 'HELLO'` statement in paragraph `2400-CALLING-SUBPROGRAM`, invoking the `HELLO` program from Lab 2.6 as a statically linked subprogram

## JCL structure

Because `CALL 'HELLO'` is a static call, `HELLO` must be compiled into an object module and link-edited together with `CBL0033` before execution — a single `IGYWCLG` compile wouldn't resolve the external reference. The JCL used:

1. **STEP1** — compiles `HELLO` only (via `IGYWC`, compile-only proc), passing the resulting object deck to a temporary dataset (`&&HELLOOBJ`)
2. **COBRUN** — compiles `CBL0033` (via `IGYWCLG`), then at the link-edit (`LKED`) sub-step includes both the `CBL0033` object and the passed `HELLO` object, producing a single load module containing both programs
3. **GO** — executes the linked module, resolving the `CALL 'HELLO'` reference internally

## Execution

All steps completed successfully (RC 0000): `STEP1`, `COBRUN` (compile), `LKED` (link-edit), and `GO` (execution). Confirmed via `GO:SYSOUT`: `HELLO, WORLD!`, proving the subprogram call resolved correctly.

*Note: the `PRTLINE` report output could not be captured due to a display issue in Zowe Explorer's job spool tree, though the `GO` step's completion code confirms it executed successfully.*

## Files

- `CBL0033.cbl`, `HELLO.cbl`
- `CBL0033J.jcl`

## Notes

This lab illustrates static subprogram linking in COBOL/JCL — a common pattern for modularizing mainframe applications, where reusable routines are compiled once and linked into multiple calling programs.