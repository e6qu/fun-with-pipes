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

**Next:** finish and audit the field/alias/reuse preparation's focused CI while PR #201's
full checks run. After all #201 gates and binary inspections pass, squash-merge
with its verified helper, then deliver this coherent four-target batch on that
merge as one PR. Preserve the tested code when transplanting; record accepted
#201 evidence in history. Full acceptance remains required for the new PR.

Preparation worktree: `/private/tmp/fwp-post-collection-aliases`, branch
`post-collection-alias-ownership`, based on `96dce6277c00d0afa9751b207686bc01e127c2d1`.
No second PR is open. Initial preparation `99b5762efe070796cade23541b09c1ce6f7c4fa7`
ran in `39959341151`. All 32 native targets and 179 library tests passed. The
complete log contains one failure: Clippy rejects `.err().expect()` in the new
field assertion. Both field and match assertions now use `expect_err`; no
warning is suppressed. The next focused run must pass the repaired source.
`/private/tmp/fwp-alias-preparation.json` records revisions and run IDs.

## Changes and checks

Field selection, pattern matching, returned aliases and temporary reusable
storage now have repeated ARC cleanup checks alongside tracing controls.
Negative cases deliberately omit cleanup or add owners. Erased internal child
types must be rejected in ARC. Reuse checks cover failure, unused cells and a
million-step native tail recurrence. Compiler/runtime behavior is unchanged.
[The guide](measurements/record-cleanup.md) explains the concepts and examples.

Windows was missing match-context and reuse-token targets; both are now selected.
The two internal variant tests serialize changes to process-wide generator
options. Focused native CI selects 32 related targets, with one macOS shard per
target. Preserve source-program CLI builds and raw-interpreter comparisons.

Guarded local checks use accepted compiler `5e17fc10` with unchanged runtime:

- Field/match source checks: 24 ARM64 binary checks, including eight complete
  O1/O2 programs. `/private/tmp/fwp-field-source-current/results.json`.
- Reuse checks: 22 ARM64 binary checks, including four complete programs and
  six million-step tail cases. `/private/tmp/fwp-reuse-current/results.json`.
- Returned-alias source: six observations from four O1/O2 binaries; eighteen
  ownership-setting cases. `/private/tmp/fwp-alias-program-current-v2/results.json`.

The first alias helper expected concatenation in the wrong order; raw
interpretation returns `laterlastfirst`. The helper was corrected and rerun;
the repository test already compares with the interpreter. Its failed first
attempt remains preserved. All new Rust harness and internal-compiler cases passed the initial focused
run. Its Clippy failure remains a failed gate until the repaired source passes;
cross-platform acceptance still requires the full final matrix.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Full builds and suites stay on GitHub. Keep all fixed resource limits.

## Resume records

`/private/tmp/fwp-collection-publication.json` identifies #201's source and runs.
`/private/tmp/fwp-audit-collection-final.py` is reentrant; its receipt records
complete job-log audits. `/private/tmp/fwp-inspect-collection-delivery-builds.py`
checks actual saved binaries on each host. `/private/tmp/fwp-merge-collection.py`
is UNRUN and requires exact-source acceptance. After verified merge, cancel only
redundant same-tree main production jobs; keep documentation.

The four alias/reuse mutation helpers have COMPLETED; do not rerun them.
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
