# Session handoff

Updated 2026-10-15. The user requested continued development after PR #139.
[PR #140](https://github.com/e6qu/fun-with-pipes/pull/140), branch
`autodiff-registry-search`, is a draft at `4e99e5f1`. Publication, fixes and squash merge
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
| 9 | Verified | Geometric native AD registry growth and numeric workspace ownership |
| 10 | Implemented | Skip known unavailable AD registry slots in native and interpreter runtimes; focused local checks pass, runner evidence pending |

## Accepted baseline

[PR #139](https://github.com/e6qu/fun-with-pipes/pull/139) merged as `5d05cdd6`,
tree-identical to `917d28a3`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38690176314)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38690140952)
passed. [Focused AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38686797678)
passed on all four Linux/macOS hosts; both [focused WASM jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38686804116)
passed at the same compiler/runtime source. The squash message is exactly one
line with no body or trailers. Local main was verified clean against the tested tree.
[Permanent measurements](measurements/ad-registry-2026-10-15.json) retain the
registry-growth allocation and binary evidence. Prior acceptance is in
[history](roadmap-history.md); historical anchors are not work to replay.

## Current implementation and evidence

Both runtimes now track a cursor below which tape slots are live or permanently
generation-exhausted. Creation starts there; normal, failed and managed backward
and scope retirement lower the cursor when an earlier reusable slot is detached.
Native shutdown resets it. The interpreter stores the cursor with its slots under
the existing mutex. No surface semantics or token format changes are intended.

Regression work covers out-of-order holes, stale tokens, failed backward,
generation exhaustion, native relocation and shutdown, and an instrumented search
counter. Negative native controls restore restart-at-zero search, omit release
updates or omit cursor reset. A separate managed-release omission must fail too.
Existing allocator-failure, nested AD and ownership controls are retained.

All local commands used `python3 scripts/local-guard.py` without raised limits:

- `cargo test --lib tape_validation_tests -- --test-threads=1`: seven tests pass.
  The final managed-release addition also passed in a 28.25s filtered run; that
  command selected zero integration tests, so native validation ran separately.
- `cargo test --test autodiff_capacity_bounds -- --test-threads=1`: both native
  controls pass with the final managed-release negative variant (17.18s).
- `cargo test --test autodiff_workspace --test autodiff_nested --test ad_tape_scopes -- --test-threads=1`:
  all 14 tests pass (150.79s), including raw/native comparisons and failure paths.
- `cargo clippy --all-targets -- -D warnings` passes (17.70s); formatting passes.
- Actual generated-C measurement profiles pass C syntax checks (0.95s), without
  running a benchmark locally; workflow lint passes (0.26s).

The existing measurement script now requires explicit `--comparison growth` or
`--comparison search`. The latter records unavailable-slot scans, paired timings,
allocation/live-memory equality and native binaries at 1, 257, 4,096 and 16,384
simultaneous tapes. Four-host results and instruction inspection are pending.
No full build, test gate or benchmark has run locally.

Binary review of the first three passing reports found Apple Clang reconstructing
the backward slot with pointer subtraction and reciprocal multiplication. The
validated token already contains that slot. Native numeric and managed backward
now use its low 16 bits directly; release ordering and generation checks are
unchanged. This refinement changes runtime source and requires fresh focused
AD/evidence and WASM runs. Earlier measurements are preliminary, not final-head
acceptance. The three verified preliminary reports show identical allocations and
live storage, with 134,209,536 unavailable-slot visits removed at 16,384 tapes.

[Focused AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38705030679)
at `1bf9c626` exposed a stale generation-wrap negative control on macOS ARM64:
the cursor correctly bypassed the exhausted slot, so removing only the scan's
generation check no longer induced wraparound. The test now also starts that
intentionally broken search at zero. Expected failure status 46 is unchanged.
Local reproduction failed as expected before the fix; both `ad_tape_ownership`
tests pass after it (18.69s), including raw/native token comparisons. The runner
log confirms this was its only failed test; all measurement steps passed there.
The failed run is cancelled as superseded and supplies no acceptance gate.
[Corrected four-host AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38706130998)
is running at `4e99e5f1`; compiler/runtime sources remain those of `1bf9c626`.

[Focused WASM](https://github.com/e6qu/fun-with-pipes/actions/runs/38705039304)
passed both hosts at `1bf9c626`; a new run is required for the token-derived
backward-slot refinement.
Final local `cargo test --test autodiff_capacity_bounds --test ad_tape_ownership -- --test-threads=1`
passes all four tests after the refinement (51.42s); formatting also passes.
The draft production run was skipped and supplies no gate. Documentation run
`38704994147` and corrected-head docs `38706081994` passed. Roadmap/link/commit audit passed locally
(2.91s). Final four-host evidence is pending from the corrected-test revision.

Duplicate post-merge main CI `38701521745` was cancelled after verifying its tree
matches PR #139's fully passing head; it supplies no acceptance gate. Main docs
`38701521545` passed. The new PR requires its own final-head production run.

## Boundaries

The cursor eliminates repeated occupied-prefix scans during sequential creation.
Arbitrary holes can still require linear scanning. Registry capacity, the 65,535
slot bound and the 512 KiB numeric workspace budget are unchanged. No general
speedup or constant-time allocation claim is established. Existing ARC admission
and ownership boundaries remain as documented in [ownership](ownership.md).

## Next action

Next: publish the validated token-derived backward-slot refinement and dispatch
fresh focused AD/evidence and WASM runs. Collect and inspect
paired search measurements and actual native instructions. Fix any
failures, record permanent evidence and update these docs. Mark the PR ready,
and require all nine production jobs plus documentation at the final head before
squash merge. Keep this handoff current with actual outcomes.

Full builds, suites and benchmarks run on GitHub. Local checks stay serial and
guarded: preserve 64 GiB free disk, target below 2 GiB, sampled workload RSS below
1 GiB and the 180-second deadline.
