# Compiler cost of recording lookup reuse

Thirteen of fourteen input/architecture timing cases qualify. AMD64's large
callback worker is **inconclusive**: byte-identical candidate copies differ by
2.854%, above the frozen 2% limit. All observed candidate/reference time and
peak-memory ratios are below 1.05. That does not override the failed copy control.
The original samples are retained; no timing was repeated.

## What was measured

- Source `6a0ae280c4616f791df507b44cbd31935a16cd67`. The reference disables only
  recording lookup reuse; runtime code and earlier optimizations are identical.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  This covers compiler startup, parsing, typing, optimization, ownership analysis
  and C emission. It excludes compiler builds, C compilation and program execution.
- Seven inputs: field-owner transfer, the autodiff tutorial, three derivative
  solves, 64 calls through a shared scope callback, and a large callback worker
  with 5,120 dynamic callback calls. `33/199` means 33 coordinates and 199 updates.
- Two identical copies per compiler; two warmups and ten measured rounds each.
  Medians exclude warmups; maximum process RSS includes them. Each architecture
  runs 336 commands plus six untimed source/selection checks. RSS measures the
  whole compiler process, not the ownership analysis alone.
- Linux ARM64 implementer `0x41`, part `0xd49`, and AMD EPYC 9V45; Rust 1.99.1,
  compiler O1 with debug assertions/overflow checks, two build jobs and no LTO.
  GCC versions are 13.3.0 and 15.2.0. This compiler protocol checks architecture;
  the separate runtime protocol requires its own qualified CPUs.

## Results

Ratios divide candidate by reference: 1.01 means 1% more time or peak RSS.
Limits are 1.05 for both, plus at most 2% variation between identical copies.

| Input | ARM64 time | AMD64 time | ARM64 RSS | AMD64 RSS |
|---|---:|---:|---:|---:|
| Field-owner transfer | 0.9988 | 0.9910 | 1.0092 | 0.9977 |
| Autodiff tutorial | 0.9968 | 0.9842 | 1.0049 | 0.9992 |
| Derivative 3/0 | 1.0028 | 0.9901 | 1.0080 | 0.9983 |
| Derivative 33/199 | 0.9981 | 0.9953 | 1.0069 | 0.9989 |
| Derivative 129/199 | 0.9945 | 1.0058 | 1.0072 | 1.0023 |
| Repeated scopes | 0.9972 | 0.9910 | 1.0077 | 0.9991 |
| Large callback worker | 0.9967 | 1.0277 (inconclusive) | 1.0056 | 0.9974 |

## Saved-sample diagnosis

Question: does the failed copy comparison track execution order, CPU time or
recorded scheduling differences? [The review](sample-review.json), reproduced by
[this script](sample-review.py), uses all original samples and resource records.
It does not replace the frozen comparison or discard any observation.

| AMD64 copy | Median elapsed | Median CPU time | First five rounds | Last five rounds |
|---|---:|---:|---:|---:|
| Candidate 1 | 0.411264 s | 0.400 s | 0.397820 s | 0.414330 s |
| Candidate 2 | 0.423002 s | 0.415 s | 0.390774 s | 0.424420 s |
| Reference 1 | 0.405439 s | 0.395 s | 0.381380 s | 0.417815 s |
| Reference 2 | 0.400774 s | 0.390 s | 0.388431 s | 0.426978 s |

All four copies get slower in the later half. Candidate copies have matching
binary hashes; candidate and reference also emit identical C for this input.
Median major faults are zero and recorded output-write counts match. CPU records
have 0.01-second resolution. These observations establish variation, not a
scheduler, hardware or compiler root cause.

The two-order schedule gives each copy only two of four positions: copy identity
and position are partly confounded. A future diagnostic must separate those
factors explicitly before changing the measurement setup. Do not rerun this
unchanged session for a pass. Under the standing policy to retain verified
reductions with timing goals open, this compiler-time case remains open.

## Evidence

[Measurement run](https://github.com/e6qu/fun-with-pipes/actions/runs/42134169729)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42135475969).
All 672 compiler invocations succeed. The audit verifies every scheduled command,
raw resource record, input, generated-C hash, reference edit and compiler image.
The AMD64 job's only failure is the final copy-limit assertion.

- ARM64: [samples](aarch64-report.json.gz), [audit](aarch64-audit.json),
  [log](aarch64-job.log.gz), [reference](aarch64-reference.json).
- AMD64: [samples](x86_64-report.json.gz), [audit](x86_64-audit.json),
  [log](x86_64-job.log.gz), [reference](x86_64-reference.json).
- Both `*-records.zip` files retain inputs, generated C and per-command records.
  `*-retained-files.json` lists their hashes; compiler binaries remain in the
  identified original artifacts.
- [Audit metadata](audit-job.json), [full audit log](audit-job.log.gz) and
  [artifact digest](artifact.json) retain the audit's identity.

[Protocol](../recording-lookups.md) ·
[Focused correctness](../recording-lookup-checks-2026-11-06/README.md) ·
[Current handoff](../../development-state.md)
