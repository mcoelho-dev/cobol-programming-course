# Lab 2.6 — Hello World

## Objective

Connect to a z/OS system via VS Code + Zowe Explorer, view a simple COBOL program, write and submit JCL to compile and run the program, and verify the output.

## Files

- `HELLO.cbl` — COBOL program that displays "HELLO, WORLD!"
- `HELLO.jcl` — JCL to compile (step `COBRUN`, proc `IGYWCLG`) and run the program

## Execution

1. Connected to the system via Zowe Explorer (`LearnCOBOL` profile)
2. Submitted the `HELLO` JCL
3. Compilation completed successfully (RC 0000)
4. Program output confirmed in `GO:SYSOUT`: `HELLO, WORLD!`

## Notes

`HELLO.cbl` already existed in the `Z76689.CBL` dataset; the compile/execute JCL was written as part of this exercise.