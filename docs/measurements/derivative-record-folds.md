# Keep a numeric fold accumulator out of the heap

## Evidence and selected boundary

Baseline: verified [PR #239](../roadmap-history.md#numeric-record-zipmap-fusion-pr-239),
merge `1f35824928abc2d468a469c03622f095ce2a4742`. Its
[saved counts](derivative-callback-boxes-2026-11-02.json) identify three remaining
callback results in each Rosenbrock solve. The audit checks both archive digests,
48 generated-C hashes and all 96 observations: two native architectures, GCC
O1/O2, current/history forms, six inputs and workspace off/on.

| Result | Consumer and lifetime | Selected action |
|---|---|---|
| Input derivative value, `f167` in the largest saved ARM64 C | Stored in the input list; later callbacks read it | Keep its representation |
| Adjacent-pair calculation, `f164` | Stored in the mapped list before summation begins | Keep its representation and eager evaluation order |
| Addition accumulator, `f127` | Passed from one known fold callback to the next; only the final value leaves the fold | Keep fields direct between iterations |

These names identify saved generated functions, not language APIs. The last is
`Add[Rev[t]].add`: its worker already accepts and returns the numeric value and
tape index directly. The fold currently calls an entry that boxes that result.
Its next invocation unpacks and releases the preceding accumulator. The list
element also receives a temporary retain even though the worker only reads its
two immediate fields. The surrounding caller keeps the input list alive.

```text
Current:  boxed seed → add → boxed accumulator → add → boxed result
Selected: read seed fields → add → local fields → add → box final result
```

Both versions run every addition in the same order, after the preceding map
finishes. The selected version does not interleave mapping with summation.
The initial box is consumed once; an empty fold returns that original owner.
Aliases remain valid. Immediate numeric fields need no cleanup when a callback
fails, but the surrounding input/list owners must still unwind correctly.

## Requirements frozen before compiler edits

- Select only a known, uncaptured, left-fold expression callback with an existing
  direct worker. Its accumulator/result types must agree. Both parameters must be
  passed directly: immediate scalar values or fully unpacked flat records of
  immediate numeric fields. Require a nonempty flat record accumulator/result.
- Exclude resources, nested records, boxed wide numbers, dynamic callbacks,
  captured callbacks and right folds from this change. Keep their existing paths.
- Preserve callback effects, invocation count, arithmetic/trap order and input
  aliases. Preserve the empty-input owner. Check failures/cancellation, final
  result allocation failure and physical release; use deliberate leak controls.
- Compare raw interpretation, optimized interpretation and native GCC/Clang O1/O2.
  Cover named records, tuples, mixed scalar/record inputs, empty/singleton/long
  inputs, aliases, effectful callbacks, traps and excluded shapes. Keep derivative
  precision, nested tapes and workspace reuse coverage.
- Use the existing six solves and observer. For `d` coordinates and `u` updates,
  remove at least `max(d - 2, 0) * u` managed requests and 24 times that many
  requested bytes; remove at least `(d - 1) * u` effective retains. Raw storage
  must be unchanged, peak managed charge must not grow, and final managed/raw
  storage must be zero in every mode. Zero-update counts must remain unchanged.

| Coordinates | Updates | Current accumulator boxes | Minimum requests removed |
|---:|---:|---:|---:|
| 3 | 0 | 0 | 0 |
| 3 | 1 | 2 | 1 |
| 3 | 199 | 398 | 199 |
| 3 | 1,999 | 3,998 | 1,999 |
| 33 | 199 | 6,368 | 6,169 |
| 129 | 199 | 25,472 | 25,273 |

For a fold of `n > 0` elements, the direct worker must run `n` times, with no
per-iteration accumulator allocation or reference-count preparation. Box only
the final accumulator. Inspect generated C and actual native artifacts; a changed
helper name is not evidence of removal. Maximum static frame growth is 128 bytes;
`.text` growth is limited to 1,024 bytes per measured program.

Use a same-source reference with only this new selection disabled and retain its
exact patch. Reuse #239's six-case inputs, timing rounds, seed, warmups, output,
compiler flags and qualified hosts. Run two paired sessions per architecture;
identical-copy variation must be at most 2%. Candidate/reference median elapsed
time must be at most 1.02 for every case and at most 0.95 for each case with at
least 199 updates. One-update cases have a non-regression requirement because
the prior phase measurements show little process time is spent in forward work.
These are new candidate requirements; #239's ten failed limits and D2 remain open.
Preserve failed/noisy observations; do not repeat unchanged runs to seek a pass.

Run affected checks during implementation, then the final nine production jobs
and documentation once the complete batch is ready. Preparation commit
`7b300717` and tag `roadmap/derivative-record-fold-protocol-2026-11-02` freeze the
requirements above before compiler edits.

## Candidate and validation

[PR #240](https://github.com/e6qu/fun-with-pipes/pull/240) implements the selected
fold in `src/cgen.rs`. Focused numeric-fold checks and both native count audits
pass; older cleanup probes, timing and final production validation remain.
The [handoff](../development-state.md) tracks current source and job identities.

Use the `Numerical and ownership evidence` workflow with explicit inputs:

| Suite | Purpose | Additional inputs |
|---|---|---|
| `record-fold-checks` | GCC Linux ARM64/AMD64 and Clang macOS ARM64; semantic, alias, ownership and derivative regressions | None |
| `record-fold-measurements` | Both native Linux hosts; six-case allocation/memory observations and cleanup controls | None |
| `record-fold-count-report` | Independently recompute both native count archives on a runner; verify every file and preserve failed limits | `evidence_run`, exact `source_revision` |
| `record-fold-time` | Candidate versus a compiler with only direct record-fold selection disabled; C/Rust comparisons | `native_runner=all`, `comparison_session=both` |
| `record-fold-report` | Download and independently audit every timing outcome without executing saved binaries | `evidence_run`, exact `source_revision` |

`prepare-record-fold-reference.py` saves the exact `src/cgen.rs` patch, both
source hashes, unchanged ownership hash and reference compiler hash. It rejects
missing, duplicate or already-disabled selection blocks. Both compilers retain
all other optimizations, including #239's record zip/map fusion.

The timing report keeps all raw rounds, output checks, managed allocation counts,
raw derivative storage, peak RSS, generated C, native images and stack reports.
Elapsed time includes process execution; phase measurements separately identify
forward/backward work. C/Rust use explicit derivatives, so their ratios include
the cost of fwp's automatic differentiation, not just language overhead.
The [shared measurement description](descent-costs.md) defines the inputs and
scope. Failed thresholds and noisy identical-copy controls remain in the report.

## Initial native measurements: counts pass, ARM64 size limit fails

Source `a690733e`, before the `attempt` repair, completed count run
[41369934860](https://github.com/e6qu/fun-with-pipes/actions/runs/41369934860).
Independent audit [41371028926](https://github.com/e6qu/fun-with-pipes/actions/runs/41371028926)
verifies all 96 observations, saved-file hashes, analytic outputs, unchanged
work/tape storage and zero final live storage. The audit fails the unchanged
code-size requirement in 15 ARM64 cases. It is not a timing result or acceptance.

For 129 coordinates, 199 updates, current-vector form, GCC O2 and workspace off,
both native hosts report these **whole-solve** totals against #239:

| Metric | #239 | Initial direct folds | Difference |
|---|---:|---:|---:|
| Managed allocation requests | 233,359 | 208,086 | 25,273 fewer |
| Requested managed bytes | 7,214,534 | 6,607,982 | 606,552 fewer |
| Effective retains | 102,883 | 77,411 | 25,472 fewer |
| Peak managed charge | 21,888 B | 21,888 B | Unchanged |
| Final managed storage | 0 B | 0 B | Both released |

Across all 24 programs per host, instruction-section changes range from
−1,328 to +2,976 bytes on ARM64 and −1,328 to −928 bytes on AMD64.
All static-frame limits pass. The larger ARM64 images must remain explicit when
we assess elapsed time and working memory; no limit has been relaxed.

Retained [counts and failures](derivative-record-fold-counts-initial-2026-11-02.json.gz)
and [download identities](derivative-record-fold-counts-initial-artifacts-2026-11-02.json)
preserve the audit. Source tag: `roadmap/record-fold-initial-counts-2026-11-02`.
These measurements do not verify the later optimizer repair. Its own observations
and passing correctness checks are still required.

## Updated optimizer: same count savings and size failures

Source `0bca5f91` adds known-callback specialization for `attempt`. Count run
[41371032477](https://github.com/e6qu/fun-with-pipes/actions/runs/41371032477)
completed every measurement. Its two jobs fail separately because older cleanup
probes look up entry points removed by optimization. Those probes are being
repaired; this report does not claim that their checks passed.

Independent audit [41372228352](https://github.com/e6qu/fun-with-pipes/actions/runs/41372228352)
verifies all 96 count/memory observations and retains the same 15 ARM64 size-limit
failures. The largest solve has the same totals shown above. Keep the
[updated counts](derivative-record-fold-counts-2026-11-02.json.gz) and
[archive identities](derivative-record-fold-counts-artifacts-2026-11-02.json)
separate from the earlier compiler. Source tag:
`roadmap/record-fold-attempt-2026-11-02`.

The fixture repair changes no compiler or measurement source, so these count
observations can be reused once the cleanup checks pass. Elapsed time is still
unmeasured; allocation savings establish no speedup.

## Reproduce the source/count audit

Run `scripts/summarize-derivative-callback-boxes.py` with explicit `--summary`,
`--arm64`, `--amd64` and `--output`. The summary is
`derivative-record-zip-counts-2026-11-01.json.gz`; the input archives come from
candidate run `41324329567`. The audit reads saved source/counts and executes no
saved image. The [previous report](derivative-forward-costs.md) retains download
identities and independent native validation.
