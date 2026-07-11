# Lab 4.6 — Sequential vs Binary Search (SEARCH / SEARCH ALL)

## Objective

Compare two table search approaches in COBOL — linear (sequential) search using `SEARCH`, and binary search using `SEARCH ALL` — by loading account records from a dataset into an in-memory table and searching for a specific entry.

## Programs

- **`SRCHBIN`** — despite the name, performs a **sequential** search using `SEARCH ... VARYING TABLE-IDX`, scanning the table entry by entry for `LAST-NAME = "ROOSEVELT"`.
- **`SRCHSER`** — despite the name, performs a **binary** search using `SEARCH ALL`, which requires the table to be sorted (`ASCENDING KEY IS ACCT-NO`), searching for `ACCT-NO = 18011809`.

> Note: the program names are swapped relative to what they do — `SRCHBIN` is the sequential search, `SRCHSER` is the binary search.

## Key differences observed

- **Table definition**: `SRCHSER`'s table declares `ASCENDING KEY IS ACCT-NO`, required for `SEARCH ALL` to perform a binary search. `SRCHBIN`'s table has no key clause, since sequential search doesn't require sorted data.
- **Table loading**: both programs load the table the same way — reading `ACCT-REC` records into `ACCT-TABLE-ITEM` via a `PERFORM VARYING` loop until end-of-file or table max (45 entries).
- **Search statement**: `SEARCH` (sequential) checks a condition explicitly against the current index in a loop; `SEARCH ALL` (binary) evaluates a single equality condition against the key field and lets the compiler generate the binary search logic.

## Execution

Both programs compiled and ran successfully (RC 0000), reading records from `Z76689.DATA`:

- `SRCHBIN` output: `Roosevelt is found!`
- `SRCHSER` output: `User with Acct No 18011809 is found!`

## Files

- `SRCHBIN.cbl` / `SRCHBIN.jcl`
- `SRCHSER.cbl` / `SRCHSER.jcl`

## Notes

Binary search (`SEARCH ALL`) is significantly faster on large tables but requires the data to be sorted on the search key. Sequential search (`SEARCH`) works on unsorted data but is slower for large tables since it may need to check every entry.