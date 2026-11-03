# Final iteration values: runtime measurements

**Measurements are running; no speed or peak-memory conclusion yet.**
The [frozen contract](../final-iteration-storage.md) defines every limit.
[Three-host native checks](../final-iteration-storage-2026-11-03/README.md) pass.

## Comparison

- Source `bb5433b688c26c60f0b2561a59420deb0f0e95ed`, tag
  `roadmap/final-iteration-measurement-2026-11-04`.
- Candidate keeps only the final value for eligible unused numeric iteration
  histories and reads ordinary lists' final items without reversing them.
- Reference uses the same source, restoring `last = reverse | head` and disabling
  only history removal. Both contain count-validation and cleanup repairs.
- Six coordinate/update pairs, each written with an explicit current-value loop
  and with `iterate ... | last`. The latter source form no longer implies a
  retained history in the candidate. Outputs and arithmetic order must agree.
- Two sessions on each qualified native architecture: AMD EPYC 7763 and ARM
  Neoverse N2. Each uses the frozen balanced 98-round schedule, seven processes
  per sample, GCC flags and workspace settings.
- Report elapsed time, requested allocations/bytes, ARC operations, peak managed
  and raw storage, process RSS, code size and stack use separately. This compares
  two fwp builds; it does not measure isolated overhead against C, Rust or Swift.

## Runs

| Run | Sessions | State |
|---|---|---|
| [41729376533](https://github.com/e6qu/fun-with-pipes/actions/runs/41729376533) | ARM64 1/2 | Measuring |
| Same run | AMD64 1/2 | Host rejected before build or timing |
| [41730462251](https://github.com/e6qu/fun-with-pipes/actions/runs/41730462251) | AMD64 1/2 | Qualified replacements, measuring |

The rejected AMD64 hosts were Intel Xeon 6975P-C, outside the frozen CPU contract.
[Retained host records](host-rejections/41729376533/session-1.json) and
[second record](host-rejections/41729376533/session-2.json) include job/step
identities and proof that compilation and timing were skipped. Full logs and
original host artifacts are retained beside them. No completed timing session
was repeated.
