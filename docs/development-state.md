# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing, prefer
ownership and borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Accepted work and current delivery

[PR #200](https://github.com/e6qu/fun-with-pipes/pull/200) passed nine production
jobs, documentation and 1,050 actual binary inspections at
`69c3b1e0135dd95961dba3729911ec27dc1736b6`. The verified squash is
`a57a2593a11178934cba33dffb3f0e2fafa15fcc`.

[PR #201](https://github.com/e6qu/fun-with-pipes/pull/201) is the sole open delivery,
at `c6ad1aaf6d2f58fa41e11e326fe83ac8a5156f31`, in
`/private/tmp/fwp-collection-delivery`. Production run `39955074782` and docs run
`39955074824` require ten passing jobs and six reports of 331 saved native images.
Its focused preparation passed 28 targets and 179 library tests, with 331 GCC
images inspected. Do not alter the final head or merge from focused evidence.

## Next action

**Next:** check and publish the three added call/fold/loop targets for the combined
35-target focused suite. Audit PR #201's independent full gates and saved
binaries in parallel. Merge #201 only after its exact-source acceptance; deliver
all seven related test targets together as one substantial PR afterward.

Four-target preparation: `/private/tmp/fwp-post-collection-aliases`, source
`5bbb8d297a4aacc80e15bf42c2d659e215d979ea`, focused run `39962527524`. Its earlier
run `39959341151` passed all 32 native targets and 179 library tests, but Clippy
rejected a new `.err().expect()` assertion. Both matching tests now use `expect_err`; preserve
the failed run and complete log. The repaired run must pass independently.

Added work: `/private/tmp/fwp-post-alias-calls`, branch `post-alias-call-cleanup`,
based on that repaired preparation. It adds partial-call/capture, right-fold and
loop-cancellation checks, preserving their existing measurement formats. No
second PR is open. Compiler and runtime are unchanged.

## Changes and checks

Field selection, pattern matching, returned aliases and temporary reusable
storage now have repeated ARC cleanup checks alongside tracing controls.
Negative cases deliberately omit cleanup or add owners. Erased internal child
types must be rejected in ARC. Reuse checks cover failure, unused cells and a
million-step native tail recurrence. Compiler/runtime behavior is unchanged.
[The guide](measurements/record-cleanup.md) explains the concepts and examples.

Windows was missing match-context, reuse-token, ARC corpus and HTTP/2 body-copy
targets; all four are now selected. Linux's `static_memory` is deliberately
Linux-only; Windows has native `windows_static_memory` checks. An earlier claim
that every shared focused target ran on Windows was too broad and is corrected.
Final Windows execution remains required for the added targets.
The two internal variant tests serialize changes to process-wide generator
options. Combined focused native CI selects 35 related targets, with one macOS
shard per target. Preserve source-program CLI builds and raw-interpreter comparisons.

Guarded local checks use accepted compiler `5e17fc10` with unchanged runtime:

- Field/match source checks: 24 ARM64 binary checks, including eight complete
  O1/O2 programs. `/private/tmp/fwp-field-source-current/results.json`.
- Reuse checks: 22 ARM64 binary checks, including four complete programs and
  six million-step tail cases. `/private/tmp/fwp-reuse-current/results.json`.
- Added call/fold/loop checks: 108 ARM64 binary checks, including twelve complete
  interpreter comparisons. Guard times: loop 18.66s, calls 20.00s, fold 53.66s.
- Returned-alias source: six observations from four O1/O2 binaries; eighteen
  ownership-setting cases. `/private/tmp/fwp-alias-program-current-v2/results.json`.

The first alias helper expected concatenation in the wrong order; raw
interpretation returns `laterlastfirst`. The helper was corrected and rerun;
the repository test already compares with the interpreter. Its failed first
attempt remains preserved. The four original new targets passed their native
cases in the initial focused run. The three additions still require Rust-harness and GCC execution. Complete
cross-platform acceptance remains required on the final delivery source.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Full builds and suites stay on GitHub. Keep all fixed resource limits.

## Resume records

`/private/tmp/fwp-collection-publication.json` identifies #201's source and runs.
`/private/tmp/fwp-audit-collection-final.py` is reentrant; its receipt records
complete job-log audits. `/private/tmp/fwp-inspect-collection-delivery-builds.py`
checks actual saved binaries on each host. `/private/tmp/fwp-merge-collection.py`
is UNRUN and requires exact-source acceptance. After verified merge, cancel only
redundant same-tree main production jobs; keep documentation.

The alias/reuse and call/fold/loop mutation helpers have COMPLETED; do not rerun
them. Added local receipts: `/private/tmp/fwp-loop-unwind-current/results.json`,
`/private/tmp/fwp-argument-current/results.json`, and
`/private/tmp/fwp-fold-unwind-current-v2/results.json`. The first
fold attempt caught a negative-test edit leaving an empty `else`; the omitted
release now leaves a valid empty statement. Preserve the failed attempt.
Their original files and local observations remain in `/private/tmp`.
`/private/tmp/fwp-field-source-verified-before-ir.json` preserves the source
functions that passed before internal-compiler tests were extended. Verify the
source-function identity when linking those results to the preparation.

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
