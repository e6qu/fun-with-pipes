# Session handoff

## Next action

This is `specialize-numeric-hashes` in
`/private/tmp/fwp-specialize-numeric-hashes`, based on PR #173's tested head
`3e4d0a372a79461d5482503b4d1b454ed7b7e347`. PR #173 remains the only active PR.
Eight of its nine production jobs passed in `39312560218`; Linux AMD64 is running.
Documentation `39312560173` passed. Its acceptance handoff is in the primary
checkout. Preserve that head, audit every gate and squash-merge only after all
nine plus documentation pass. Use an explicit one-line subject and empty body.

Next: finish documenting the completed hash measurements below, then replay this
preparation on merged main and publish the next substantial PR. Require its own
nine final-head production gates and documentation. Focused evidence is not a
replacement for those gates. No focused failures remain.

## Prepared change

The compiler emits direct hashing code for inline integers, F32/F64, their flat
lists/arrays/sets, numeric maps and records composed of those types. Other types
keep descriptor traversal. Hashing borrows its input, with no new owner or encoded
buffer. Canonical widths, float bits, field/key order and length encoding stay
unchanged. Packed/full-word arrays and slices use their actual storage widths.
`FWP_TYPED_HASH=0` selects general traversal for controlled comparisons.
Recursive type shapes are not expanded indefinitely. No syntax or API changes.

The tests compare raw interpretation with ARC and stressed tracing at O0/O2,
with specialization and array packing independently on/off. They cover scalar
boundaries, NaN/infinity, slices, aliases, mixed map widths and named records.
Negative controls must detect deliberately inserted allocation and retain calls.
WASI runs the same fixture, including shutdown cleanup.

## Completed evidence

Measured source `6ffd2385a8207078cadd046d7dc2e3f3c389675f` is preserved by
`roadmap/revision-numeric-hash-6ffd2385`. Compiler generation is unchanged since
`c05e592e`; later ownership edits only move imports and correct a slice comment.
Collector/repeat source `524e917d46bc25e7c78a5ed09a3d25581411bc47` is preserved by
`roadmap/revision-numeric-hash-report-524e917d`.

- Six-native-host run `39317215955`: 69 tests per host, 414 total, none ignored.
  Both-Linux WASI run `39317221484`: 24 tests per architecture, none ignored.
- Four-host costs `39317226192` and report `39322404918` passed. The collector
  checks complete logs, source/binary hashes, sample balance, ownership counts,
  native sections and tracing symbols: 96 correctness and 48 measured binaries.
  [Initial report](measurements/numeric-hashing-2026-10-19.json).
- Repeat `39322408959` passed all four hosts using those verified binaries:
  24 balanced samples after two warmups, 1,152 timed executions.
  [Repeated report](measurements/numeric-hashing-repeat-2026-10-19.json).
- Linux ARM64 large-array/set repeated CPU medians improve 2.1%/1.5%; all 24
  pairs improve. Other hosts have overlapping samples. The first ARM macOS
  small-case slowdown does not repeat. Linux AMD64 sets remain 0.13%/0.21%
  slower in the two medians with overlapping ranges: no speedup or established
  regression there. AMD64 hardware changed from EPYC 9V45 to 9V74 between runs.
- Specialized/general ARC profiles match: two managed requests, zero retains,
  zero charge after cleanup. Output formatting accounts for the second request.
  C/Rust profiles count only their application input buffer. Small fwp workloads
  still cost up to 36.6% more CPU than C and 22.6% more than Rust.
- Actual code sections shrink 1,432–1,952 bytes. Inspected ARM inner loops have
  no calls or stack accesses; AMD64 saves a register around the function. The
  caller still stores a stack tuple and calls once per hash. No zero-stack,
  zero-heap or universal C/Rust parity claim follows.

[The benchmark guide](benchmarks.md#numeric-hash-specialization) explains workloads,
scopes, ratios and remaining costs. The separate
[production baseline](measurements/range-set-peers-2026-10-19.md) retains all six
benchmark programs from PR #173, including raw samples and slower results.

## Local checks and repairs

All workloads use the primary checkout's `python3 scripts/local-guard.py` with
unchanged limits. Full compiler builds and benchmarks ran only on GitHub.

- Formatting, Python syntax and documentation checks passed during preparation.
- Extracted actual numeric generator: 128 runtime-reference comparisons passed
  at O0/O2 with packed/full-word storage in 2.51 seconds. CI verifies integration.
- Raw interpretation of the 20-line fixture passed in 0.27 seconds; tiny Rust
  measurement-source/allocator checks passed in 1.58 seconds.
- Completed native/WASI log audit passed in 0.22 seconds. Report download and
  validation passed in 6.81 seconds; all four repeat reports in 6.84 seconds.
- Review fixed full-word array loads and the three-byte set length prefix. It
  also corrected an obsolete claim that all slices copy: views retain backing
  owners. Primitive-contract and measurement-source imports now stay at the top.
- `scripts/test-hash-evidence.py` passed four checks in 0.22 seconds: incomplete
  logs, wrong revision/status, changed saved binaries, and balanced repeat order.
- Documentation audit passed 61 document sets, 106 immutable anchors and seven
  work areas in 2.45 seconds. Its first run caught a missing roadmap-status table
  in the shortened handoff; restoring the table fixed it.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open: ownership/tracing removal,
functional costs, machine performance, autodiff, numerical kernels, dependable
comparisons and larger applications. Persistent subscriptions, unknown retained
captures, resource-owning tail frames and mutual recursion still need proofs.
JIT is excluded. Completed measurements do not complete these work areas.
