# Lab 2.7 — Zowe CLI & Automation

## Objective

Use the Zowe CLI to interact with the z/OS system from the command line — listing data sets, submitting jobs, and reviewing spool output — then automate the compile/link/go cycle using an npm script.

## Part 1 — Interactive CLI Usage

Commands used to explore and interact with the system directly from the terminal:

- `zowe config list --locations` — confirmed the CLI could see the `LearnCOBOL` team configuration
- `zowe zosmf check status` — verified connectivity to z/OSMF
- `zowe files list ds "Z76689.*"` — listed data sets under the userid
- `zowe files list am "Z76689.CBL"` — listed members of the COBOL PDS
- `zowe jobs submit ds "Z76689.JCL(HELLO)" --wfo` — submitted the job and waited for OUTPUT status
- `zowe jobs list sfbj <jobid>` — listed spool files for the submitted job
- `zowe jobs view sfbi <jobid> <spool-id>` — viewed a specific spool file's content

## Part 2 — Automation via npm

Created a Node.js project (`npm init`) and added a custom script to automate the full compile-link-go cycle:

```json
"scripts": {
  "clg": "zowe jobs submit ds \"Z76689.JCL(HELLO)\" -d ."
}
```

Running `npm run clg` submits the JCL, waits for completion, and downloads all spool output to the local folder automatically — replacing what would otherwise be several manual CLI steps.

## Files

- `package.json` — npm project with the `clg` automation script
- `output/` — downloaded spool files from the automated job run, including the linkage editor report and program output confirming `HELLO, WORLD!`

## Notes

This lab replaces the manual "Submit Job" step from Lab 2.6 with a CLI-driven, scriptable workflow — the same pattern used for CI/CD-style automation on mainframe systems.