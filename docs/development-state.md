# Session handoff

Updated 2026-10-15. The user requested continued development after PR #138.
Current branch: `autodiff-registry-growth`. Publication, fixes and squash merge
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
| 9 | In progress | Geometric native AD registry growth and numeric workspace ownership |

## Accepted baseline

[PR #138](https://github.com/e6qu/fun-with-pipes/pull/138) merged as `d77b3fea`,
tree-identical to `f251fbd1`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103)
passed. [The operation-storage report](measurements/ad-operations-2026-10-15.json)
records the measured storage reductions and tradeoffs. Historical preparation
anchors are not work to replay.

## Current work

The accepted baseline reallocates the native registry for every new slot; this implementation
now doubles capacity from one slot, clamped at 65,535. Slot selection, generation
limits and scope links remain unchanged. Failed growth keeps the old registry.
The interpreter now creates managed tapes without taking numeric workspaces and
leaves an existing workspace intact when an empty tape retires, matching native
behavior. Allocation/capacity, forced relocation, token exhaustion, scope release
and allocator-failure controls pass locally. Four-host measurements and full
acceptance are still outstanding.

All commands below use `python3 scripts/local-guard.py` and pass within the
unchanged limits:

- `cargo test --lib tape_validation_tests -- --test-threads=1`: six tests, 12.96s.
- `cargo test --test autodiff_capacity_bounds -- --test-threads=1`: both tests,
  8.66s on the final harness, including O1/O2 tracing stress/reuse and ARC.
- `cargo test --test autodiff_workspace unused_tape_suffix_preserves_language_values_and_forward_traps -- --exact --test-threads=1`:
  raw interpreter/native values and traps, O1/O2 ARC/tracing, cache on/off, 28.97s.
- `cargo fmt --all`, `cargo clippy --all-targets -- -D warnings`: 1.09s/0.38s
  final checks; initial all-target clippy also passed in 16.68s.
- `actionlint .github/workflows/numerics.yml`: 0.89s; measurement Python AST
  syntax: 0.14s; `python3 scripts/check-roadmap.py`: 48 link sets, 106 immutable
  anchors and nine steps, 2.71s; `target/debug/fwp fmt tests/run/ad_registry_growth.fwp`: 0.01s.

During harness development, ARC rejected tracing/reuse flags; the final probe
uses valid settings and explicitly asserts its active mode. The first language
fixture lacked expression-list separators; the corrected tacit fixture passes.
These were test-construction failures, with no skipped acceptance checks.

The contribution guide's stale seven-job statement now lists all nine jobs.

## Boundaries

Registry allocation growth becomes geometric; first-reusable-slot search remains
linear. Spare registry capacity can increase live bytes between growth boundaries.
Numeric caches retain their 512 KiB bound. Native ARC still rejects unproved
cycles, mutable/retained graphs and State/AD lifetimes. Generic wide values and
some lazy producers can allocate. No general collector-free or speedup claim.

## Next action

Next: finish focused lifecycle regressions and equivalent registry allocation/binary
measurements, publish one draft PR, obtain focused four-host evidence, then run
all nine final-head production jobs and documentation before squash merge.
Keep the commit subject one line, at most 80 characters, with an empty body.
Full builds, suites and benchmarks run on GitHub; local checks remain serial,
guarded and below the existing disk, memory and 180-second limits.
