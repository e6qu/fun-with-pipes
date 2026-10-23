# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Prefer ownership and borrowing;
reserve ARC for necessary sharing and remove tracing. JIT is excluded.

## Accepted work and current delivery

[PR #201](https://github.com/e6qu/fun-with-pipes/pull/201) passed nine production
jobs, documentation and 1,986 saved binary inspections at `c6ad1aaf6d2f58fa41e11e326fe83ac8a5156f31`.
Verified squash: `c56f85547610b14bd1b8af9a9ad96413f3c494e9`. [History](roadmap-history.md#failed-loops-and-collection-cleanup-pr-201)
and the [inspection record](measurements/collection-cleanup-2026-10-23.json) retain evidence.

**Next:** complete the grouped ownership delivery. Audit all final-head jobs
and documentation, and inspect 569 saved binaries on each of six native hosts.
Merge only after all gates pass, using one subject of at most eighty characters
and an explicit empty body. Continue the ownership work in PLAN.md afterward.

This worktree is `/private/tmp/fwp-call-delivery`, branch `call-cleanup-delivery`, based on the verified
merge. Preparation `aa81e2756054e989a292313e1462af00ef4c6d42` and tag `roadmap/preparation-cached-cleanup-aa81e2756054` are preserved in
`/private/tmp/fwp-cached-value-cleanup`. Its Linux run of 38 test groups
`39974679542` passed with 179 library tests; both focused Windows runs
also passed their applicable tests: AMD64 run `39974684864` and ARM64 run
`39974689725`. Complete logs and 569 binaries per host passed inspection,
including 569 GCC binaries on Linux (1,707 saved images in total). Compiler, runtime, native tests, scripts and workflows match that
preparation. Final cross-platform acceptance still requires this delivery's source.

## Scope and checks

Ten existing test groups cover field selection, matching, returned aliases, reusable
storage, partial calls, folds, loop cancellation, cached values, escaping functions
and temporary containers. Both ARC and tracing retain explicit controls. Deliberate
missing cleanup must fail; unproved internal types must be rejected in ARC.
The [guide](measurements/record-cleanup.md) explains the programs and observations.
Compiler behavior and language syntax are unchanged; these are not speed claims.

Windows adds five omitted test groups: match context, reuse tokens, ARC corpus,
HTTP/2 body copying and temporary containers. A runner control checks production
coverage against the focused selections. Linux-only storage tests do not establish
Windows execution; Windows retains its own native storage target.

Cached values, functions and temporary containers passed 54 guarded ARM64 source
observations; the seven preceding groups have their own local and focused evidence. Fourteen
Python runner controls, formatting and documentation pass. Earlier preparation
failures were repaired: Clippy required `expect_err`; a local cache helper confused
remaining allowance with live bytes; another assumed trap exit 1 instead of 101.
Failed attempts remain preserved. No product-runtime defect was found by those
helper failures. Full final-head tests remain required even after focused success.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Full builds and suites stay on GitHub. Keep all resource limits.

## Resume records

`/private/tmp/fwp-collection-merge.json` records the accepted prior merge.
`/private/tmp/fwp-cached-preparation.json` identifies the tested preparation and runs;
its `fwp-cached-focused*acceptance.json` receipts retain complete log audits.
`/private/tmp/fwp-call-publication.json` identifies the final delivery once published.
`/private/tmp/fwp-audit-call-final.py` checks the full gates;
`/private/tmp/fwp-inspect-call-delivery-builds.py` checks actual saved binaries.
`/private/tmp/fwp-merge-call.py` requires exact-source acceptance before merging.

Preparation mutation and publication helpers COMPLETED; do not rerun them.
This delivery preparation helper COMPLETED the transplant and prior-acceptance docs.
Preserve original worktrees, source tags and all binary reports. The older
seven-target helpers must not omit the three added targets or overwrite the tested
coverage control. Local additions remain recorded in
`/private/tmp/fwp-cached-source-current-v2/initialization-results.json`,
`/private/tmp/fwp-cached-trap-current/results.json` and
`/private/tmp/fwp-closure-temporary-current/results.json`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The largest measured descent case still takes about 10–14 times the C/Rust time.
Fewer allocations alone do not establish parity. Preserve measured controls and
separate callback, indexing, output and buffer costs before selecting changes.
