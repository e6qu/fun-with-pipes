# Current work

**Next:** publish the batched grouped-check/documentation repairs and dispatch
`packed-input-checks`; audit all three hosts before measuring.
[PR #256](https://github.com/e6qu/fun-with-pipes/pull/256) is verified and merged.
The branch now starts from its squash, with byte-identical content across the
rebase. Original history is preserved at immutable
`roadmap/packed-input-pre-delivery-2026-11-04` (`db7ae09c`). Compiler/runtime,
library and build inputs still match `adbe92ab`; the current repairs change
test expectations, measurement inputs, CI setup and documentation.
[Draft PR #257](https://github.com/e6qu/fun-with-pipes/pull/257) groups this work;
keep it in draft while correctness checks and measurements run.

Worktree/branch: `.worktrees/packed-derivative-inputs` / `packed-derivative-inputs`.
The [contract](measurements/packed-derivative-inputs.md) groups known scoped
objectives, packed numeric input records and overlapping pair reads. Keep input
construction, pair mapping and folding as separate eager stages.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve exact selection, ownership and measurement contracts |
| 2 | In progress | Audit the three-host batch and fix every failed control |
| 3 | Pending | Freeze matching source; measure compiler/runtime costs; audit all records |
| 4 | Pending | Group docs/evidence into one PR; pass all final gates; verify squash/tree |

## Current checks and source identities

- Contract: `cc425aba`, immutable `roadmap/packed-derivative-inputs-protocol-2026-11-04`.
- [Binding proof](measurements/scoped-objective-review-2026-11-04/README.md):
  `3ccc9bf2`, immutable `roadmap/packed-input-binding-proof-2026-11-04`.
- Failed preflight retained at `roadmap/packed-input-preflight-2026-11-04`
  (`9ad9d162`). Never move frozen tags.
- Grouped run `41834093801`: GCC ARM64 `126588461641`, GCC AMD64
  `126588461854`, Clang ARM64 `126588461334`. All completed and audited: each
  passes 277 units (four ignored), contracts, twelve selections and 92/93 native
  tests. Failures: omitted export-box allocation in the assertion, shallow
  checkout missing historical evidence, invalid generated `scope-0` names.
  All used the exact `adbe92ab` source above; retain this failed source.
- Documentation `41838130161` / `126602280596` failed at `a001184a`: stale
  gradient-array reference patch context. Refresh context only, preserving both
  new native bodies. Full log and audit retained with the grouped preflight.

[Preflight failures and repairs](measurements/packed-input-selection-2026-11-04/README.md):

1. `41824802673` at `3c091d3f` exposed the objective, but its producer remained
   inside a temporary record. Freeze the binding proof before normalization.
2. `41827593617` at `0b274ca8` passed eight proof tests but missed all three real
   gradient selections. Packing ran before numeric callees exposed field reads.
3. `41830904200` at `9ad9d162` selected all three gradient inputs; all twelve
   source/control compilations, Clippy, eight prior proof tests and twenty native
   cleanup images pass. The new unit fixture lacked List ownership shapes;
   output comparison used unsupported `run --memory`. Missing `pipefail` hid the
   latter from step status. All three repairs are in `adbe92ab`. Full source/native
   logs, 43 source files and 102 native files are audited and retained.

The batch adds one/two-field records, F32/F64 signed-zero/NaN bits, exact managed
object counts, both window/range orders, bounds, aliases, failure/cancellation,
actual frees, disabled reuse and deliberately broken cleanup/value controls.
Compare raw/optimized interpreters and native O1/O2. Keep existing autodiff scope,
workspace, precision, callback and ownership targets in the same batch.
These extend `zip_unwind_ownership`; no new Cargo target. Add an extra-allocation
negative control, fetch full history and use `scope0` names. Both cost inputs
now retain individual results even if one fails. Repaired checks need CI.

## Measurement and collection

Use `python3 scripts/local-guard.py` for every focused local check or collector.
Full builds, suites, benchmarks and large regeneration stay on GitHub.

- `../gradient-work/collect-packed-input-checks.py --run 41834093801
  --source adbe92abb855dfeea5c648fb122131433a1681f3 --output ../gradient-work/packed-input-checks-1`
  collected all jobs (78.18s). All artifact hashes, 619 native images and 630
  statuses per host were audited (3.61s); logs/new controls are retained in
  the preflight's `grouped-preflight` directory. No other failures or warnings.
- After the complete matching-source correctness gate, freeze the measurement
  source and dispatch `packed-input-analysis` and `packed-input-time` with that
  `evidence_run`. Runtime needs explicit `native_runner=all` and
  `comparison_session=both`. Then use `packed-input-report` to audit raw records.
- The reference disables only scoped specialization and packed-input selection.
  It preserves all earlier ownership fixes. Seven compiler inputs exercise
  ordinary work, shared specializations and an oversized rejected worker.
  No performance measurements have started. Keep every failed/noisy outcome.

## Local verification

Guarded checks pass: five reference controls, twenty-one budget tests, eighteen
raw-audit controls (19.46s), seven compiler-schedule/settings controls (2.17s),
workflow lint (6.73s), Rust formatting (1.83s), roadmap links/identities (2.87s).
The rewritten handoff first used unsupported `Not started` statuses; corrected
to `Pending`, and the roadmap audit passes again (2.55s).
The schedule fixture initially expected 240 commands; corrected to 336 for the
seven declared inputs. The reference collector rejected a mistyped source before
collecting the exact revision. Neither failed observation was treated as a pass.

Primitive inventory passes (0.63s): 395 declarations, 385 symbols, 40 aliases,
374 contracts, 19 IR templates and two scalar signatures. The verified #255
compiler only formats/type-checks small fixtures and confirms the single-field
interpreter result `True` (0.24s); it does not verify the new compiler.
No local build or benchmark. Preserve 64 GiB free disk and all guard limits.
Leave the dirty primary/older worktrees alone; this branch owns current work.

Repair checks: both generated inputs type-check (0.47s); corrected saved macOS
C passes O1/O2 and all cleanup loops (0.82s); seven driver controls pass (2.00s);
workflow lint passes (6.47s). Rust formatting caught one new long assertion;
corrected and passes (1.75s). Extra-allocation controls reject at O1/O2 (0.81s).
These do not establish GCC or regenerated support.
Six gradient-reference controls pass (0.60s); six related suites skipped in that
CI step pass (22 tests, 1.08s). Roadmap audit passes (2.49s).

## Completed delivery

[#256](roadmap-history.md#matched-optional-results-pr-256) merged November 4 at
13:17:18 UTC as `cfb6dcc4223e281188cf6159e0623368501e2294`. Its tree equals tested
`81bce309c4524058aefead68f203d6dfa3b5731a`. All nine production jobs
`41822132045` and documentation `41822131973` pass, with every full/target log
audited: 257 targets per Linux host, 131/126 per regular/ownership macOS job and
155 Windows probe targets per architecture. [Complete gates](measurements/matched-option-fields-2026-11-04/platforms/final-gates.json)
retain identities/logs; final collection 5.15s, verified retention 0.13s.
The raw squash message is exactly one line under 80 characters, with no body or
trailers. Duplicate same-tree main runs `41836731497` / `41836731217` were
cancelled only after no-failure checks. No further #256 validation is needed.
