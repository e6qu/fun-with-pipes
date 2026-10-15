# Session handoff

Updated 2026-10-15. The user requested continued development after PR #140.
[Draft PR #141](https://github.com/e6qu/fun-with-pipes/pull/141), branch
`autodiff-metadata-block`, is published at runtime head `ff7f528a`, based on
accepted `09f1a029`.
Publication, fixes and squash merge after all nine exact-head production jobs
and documentation remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Verified | Seeded-prefix adjoint bounds and four-host evidence |
| 8 | Verified | Operation-only AD metadata and atomic weight retention |
| 9 | Verified | Geometric AD registry growth and workspace preservation |
| 10 | Verified | Registry cursor search; PR #140 merged with all gates |
| 11 | In progress | Paired native AD metadata allocations and relocation controls |

## Accepted baseline

Steps 1–10 in [PLAN](../PLAN.md) are verified. [PR #140](https://github.com/e6qu/fun-with-pipes/pull/140)
merged as `09f1a029`, tree-identical to `cdb76905`, with all nine production jobs,
documentation, four-host focused AD and both WASM checks passing. See
[history](roadmap-history.md#accepted-registry-cursor-follow-up-pr-140) for links.
Local main was clean and the one-line squash message was verified.
Historical preparation anchors are evidence, not work to replay.

## Current work: paired native AD metadata (step 11)

Implementation and focused native controls are complete; runner measurements and
full platform acceptance remain pending. No timing claim is made. Native
parents share one allocation with contiguous `pa`/`pb` regions. Numeric
derivatives similarly share a second allocation. Growth relocates initialized
second regions after allocating, and only base pointers own storage. Managed
weights remain separately typed and owned. Preserve old offsets during managed
weight growth because it can trap and leave the tape live. Preserve the existing
32-bit node limit, natural alignment, arithmetic order and workspace byte budget.
The interpreter stays unchanged as the semantic reference.

## Checks and resolved failures

All local checks used `python3 scripts/local-guard.py` with unchanged limits.
The final `cargo test --test autodiff_capacity_bounds -- --test-threads=1`
passed all three tests in 27.48s, including forced relocation, aligned regions,
clamped overlapping moves, recoverable managed-growth traps and deliberate
move/length/early-commit defects at O1/O2 in tracing and ARC modes.
`cargo test --test autodiff_workspace --test ad_tape_ownership --test autodiff_library -- --test-threads=1`
passed both unwind tests, library teardown and three workspace tests in 57.06s;
the input-padding negative control then failed because it reserved before
initializing the tape length. Moving that deliberate reservation after length
initialization fixes the control; its separate rerun passed in 4.14s. The matching
historical-comparison script is corrected too. An earlier ledger assertion still
expected five independent buffers; it now verifies three owning bases and no
interior-pointer frees. An initial ARC probe used forbidden reuse verification;
the corrected explicit tracing/ARC settings pass. These failures are resolved.

Final Rust formatting passed in 1.11s and all-target clippy in 17.45s. Measurement
instrumentation on actual emitted C passed syntax checking in 0.98s; a final
5.23s check also emitted checked ARC C for all five workloads without running
benchmarks. Workflow lint passed in 0.26s; the roadmap/link/commit audit passed
all 11 steps in 2.76s. Full builds, suites, timing samples and actual wasm32
controls remain runner work. A subsequent 11.18s paired-metadata rerun also
requires tracing collection to be armed and actually run; it passed. This extra
assertion is currently local and will be covered by final-head production CI;
the measured runtime remains identical to `ff7f528a`.

The first four-host run exposed a scope-ledger assumption that still expected
separate frees for interior regions. The completed macOS ARM log confirms this
was its sole failed test; all measurement steps passed. Local reproduction failed
with status 61 (2.06s), then the corrected full `ad_tape_scopes` target passed all
four tests in 33.16s. Both outer/nested scope ledgers now require one free per
base and none for interior pointers. Runtime sources remain unchanged. Preliminary
Mac ARM counters verify halved metadata requests and equal payload/live storage;
timing cases are mixed. The final measurement script now alternates variant
order after explicit warmups, avoiding block-order timing bias. Preliminary
measurements are not final acceptance evidence.

## Next action

Next: inspect four-host [AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38724114075)
and two-host [WASM](https://github.com/e6qu/fun-with-pipes/actions/runs/38724130547)
at `ff7f528a`. The native run has a known scope-ledger failure fixed locally; publish the fix
and dispatch a replacement native run. WASM continues; no final runner pass is
claimed yet. Draft CI
`38724099611` is skipped and is not a gate. Documentation `38724099571` passed.
Record actual evidence, streamline docs, and require all nine exact-head
production jobs plus documentation before the authorized squash merge.

Full builds, suites and benchmarks run on GitHub. Local checks stay serial via
`python3 scripts/local-guard.py COMMAND...`: preserve 64 GiB free disk, target
below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline.
