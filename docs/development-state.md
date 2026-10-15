# Session handoff

Updated 2026-10-15. The user requested continued development after PR #138.
[PR #139](https://github.com/e6qu/fun-with-pipes/pull/139), branch
`autodiff-registry-growth`, has completed native focused validation and measurements at `957ba0cd`.
Publication, fixes and squash merge
after all nine exact-head production jobs plus documentation remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Verified | Seeded-prefix adjoint bounds and four-host memory/binary evidence; PR #137 merged with all gates |
| 8 | Verified | Operation-only AD metadata, partial weight-retain cleanup, regression controls and measured evidence |
| 9 | Implemented | Geometric native AD registry growth and numeric workspace ownership |

## Accepted baseline

[PR #138](https://github.com/e6qu/fun-with-pipes/pull/138) merged as `d77b3fea`,
tree-identical to `f251fbd1`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103)
passed. [The operation-storage report](measurements/ad-operations-2026-10-15.json)
records the measured storage reductions and tradeoffs. Historical preparation
anchors are not work to replay.

## Current implementation and evidence

Native registry capacity doubles from one slot and is clamped at 65,535. Slot
selection, generation limits and scope links are unchanged; failed growth keeps
the prior registry. Managed interpreter tapes no longer take numeric workspaces,
and empty tapes leave existing caches intact. Native zero-input backward passes
allocate no dummy adjoint and skip zero-length clearing without passing null to
memset. O1/O2 ARC/tracing controls cover forced relocation, initialization,
capacity/token limits, allocation failures, scope release and cache on/off. Their
negative variants restore incremental growth, stale shutdown capacity or the
unnecessary empty adjoint allocation and must fail.

[Focused AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38686797678)
passes on all four native Linux/macOS hosts at `957ba0cd`, including every test
and measurement step. [Focused WASM](https://github.com/e6qu/fun-with-pipes/actions/runs/38686804116)
is an additional acceptance check; require both Linux hosts to pass before merge.
At evidence publication ARM64 has passed and AMD64 is running. Earlier runs at
`53dfdbcf` were cancelled as superseded and supply no acceptance gate.

[Permanent measurements](measurements/ad-registry-2026-10-15.json) retain all four
reports, hardware/compiler/flags, raw timings and verified archive and per-file
hashes. At 4,096 simultaneous tapes, registry requests fall 4,096 → 13 with the
same 425,984-byte registry peak. At 257 tapes, spare capacity adds 26,520 bytes.
Managed counters are unchanged and every measured owner is reclaimed without GC.
No general speedup is claimed. Inspected instructions on all four hosts show a
capacity branch around realloc, register doubling/clamping, one-slot initialization
and zero-active-node branches around adjoint allocation and clearing.

Focused local commands used `python3 scripts/local-guard.py` with unchanged
limits. `cargo test --lib tape_validation_tests -- --test-threads=1` passed six
tests (12.96s). The final combined `cargo test --test autodiff_capacity_bounds
--test autodiff_workspace -- --test-threads=1` passed both capacity controls and
three workspace tests; an old prefix marker failed and was corrected. The exact
`cargo test --test autodiff_workspace backward_prefix_bounds_actual_native_storage_and_scans -- --exact --test-threads=1`
then passed (4.32s), retaining its negative controls. The four-host run now verifies
all of these tests together. Raw/native language comparisons cover ARC/tracing,
O1/O2 and cache on/off. Formatting, all-target clippy (17.36s final code check),
workflow lint, generated-C instrumentation/syntax and roadmap/link audits pass.
Four-host report/hash aggregation passes in 0.17s and archive verification in
0.15s. No local limit was raised; full builds and measurements ran on GitHub.

The contribution guide now lists all nine production jobs. The final publication
adds evidence/docs only; runtime/compiler code remains the measured `957ba0cd`.

## Boundaries

Registry allocation growth becomes geometric; first-reusable-slot search remains
linear. Spare registry capacity can increase live bytes between growth boundaries.
Numeric caches retain their 512 KiB bound. Native ARC still rejects unproved
cycles, mutable/retained graphs and State/AD lifetimes. Generic wide values and
some lazy producers can allocate. Service/remote/library/WASM executable ARC
admission remains outside this follow-up. No general collector-free or speedup claim.

## Next action

Next: inspect PR #139's current head, checks and merge state. If open, require
all nine exact-head production jobs, documentation and both focused WASM jobs
linked above. Fix failures and squash merge with one line of at most 80
characters and an empty body. If PR #139 has merged with those gates, step 9 is complete;
no implementation task remains from this follow-up. Do not replay old anchors.

Full builds, suites and benchmarks run on GitHub. Local checks stay serial and
guarded: preserve 64 GiB free disk, target below 2 GiB, sampled workload RSS below
1 GiB and the 180-second deadline.
