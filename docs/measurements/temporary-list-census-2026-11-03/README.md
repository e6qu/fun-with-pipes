# Temporary list allocation census

[Protocol](../temporary-list-storage.md). Native measurements are not yet complete.
No compiler storage change or speed claim follows from the partial results.

## First attempt: diagnostic exit status repaired

Run `41572713222`, source `1668a17917d1cfadcbd74465b9edf14f6c36c7de`:

- Both native GCC hosts built successfully; all nine completed C compilations
  per host have empty diagnostic logs. The synthetic constructor workload's
  counts match in all seven phases.
- The invalid-site control correctly detected its injected defect, but `exit`
  ran the existing phase observer's shutdown hook. That hook replaced status 234
  with its unfinished-sequence status 233. The driver rejected the mismatch.
- Repair: flush the diagnostic and call `_Exit(234)`. This affects only malformed
  measurement instrumentation; production code and ordinary cleanup are unchanged.
- The separate archive audit correctly rejected the incomplete experiment.
  No real derivative case had run, and later controls/O2 remained unverified.

[ARM64 audit](attempt-1/aarch64-audit.json.gz) and
[AMD64 audit](attempt-1/x86_64-audit.json.gz) retain artifact identities, hashes,
commands and exact known-work results. Raw archives and full job logs are in the
same directory. Documentation job `125709063243` passed on this source.
