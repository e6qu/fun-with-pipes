# Current work

**Next:** publish the current measurement-preparation changes, freeze
`roadmap/packed-input-measurement-2026-11-04`, then dispatch
`packed-input-analysis` with `evidence_run=41840527818`. Inspect both untimed
fixture checks and compiler-cost results before starting runtime comparisons.
No performance samples have run.

[Draft PR #257](https://github.com/e6qu/fun-with-pipes/pull/257) groups known scoped
objectives, packed numeric inputs and overlapping pair reads. Keep input
construction, pair mapping and folding as separate eager stages. Worktree/branch:
`.worktrees/packed-derivative-inputs` / `packed-derivative-inputs`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve selection, ownership and measurement contracts |
| 2 | Verified | Preserve the audited three-host compiler/cleanup coverage |
| 3 | In progress | Verify corrected cost inputs before timing; compare compiler/runtime costs; audit every outcome |
| 4 | Pending | Complete grouped evidence/docs; pass all final gates; verify squash/tree |

## Verified correctness

[Run 41840527818](https://github.com/e6qu/fun-with-pipes/actions/runs/41840527818)
passes at `ba23c6ea7226c31f626839530035e717f3ce05c7`:

- GCC ARM64 `126610608861`, GCC AMD64 `126610609022`, Clang ARM64 `126610608502`.
- Each: 277 unit checks (four existing ignored), contracts, twelve selections,
  93 integrations, 34 new probes, 642 native images and 655 saved statuses.
- All full/target logs, hashes, machine identities and expected observer failures
  are audited. No unexplained failures or compiler warnings remain.
- Documentation `41840511498` / `126610537046` also passes at that source;
  its printed test failure is an intentional runner control.

[Retained evidence](measurements/packed-input-checks-2026-11-04/README.md) has full
logs and 262 retained files per host, including all new C/native controls.
The current preparation changes only measurement scripts, CI setup and docs;
compiler/runtime/library/test/build inputs must still match `ba23c6ea` exactly.

## Measurement preparation

Generated C exposed ineffective compiler-cost fixtures before timing:
unused exports were not roots, constant inputs excluded the live specialization,
and the large body was a shared helper behind a small wrapper. Corrected inputs
reach all 64 calls and use a runtime line count. The large helper keeps 5,120
dynamic calls; direct oversized-body rejection has a separate unit test.

Before any compiler timing, both candidate and reference compile both inputs.
The checker requires actual scope-call counts, live specialization entries and
one large body; it retains both failures and timeout output. The nine driver
controls pass (1.98s), corrected inputs type-check, and both original CI outputs
are rejected by the new checker (0.59s). An intermediate function-valued `main`
was rejected locally and replaced with a value entry. Production verification
of the corrected inputs is pending in these untimed checks.

The [contract](measurements/packed-derivative-inputs.md) retains seven compiler
inputs, 48 balanced commands each, and unchanged acceptance limits. The reference
disables only scoped specialization and packed-input selection. It preserves
all previous ownership repairs. After compiler checks, dispatch
`packed-input-time` with explicit `native_runner=all`, `comparison_session=both`
and the matching correctness `evidence_run`. Then use `packed-input-report` for
independent raw audits. Preserve every failed/noisy outcome; no timing reruns
for a pass. Full nine-job production CI plus docs follows the completed batch.

## Sources and failure history

- Contract `cc425aba`: `roadmap/packed-derivative-inputs-protocol-2026-11-04`.
- Binding proof `3ccc9bf2`: `roadmap/packed-input-binding-proof-2026-11-04`.
- Original pre-rebase history: `roadmap/packed-input-pre-delivery-2026-11-04`
  (`db7ae09c`). Never move immutable tags.
- [Failed preflights and repairs](measurements/packed-input-selection-2026-11-04/README.md)
  retain premature pass ordering, missing synthetic List shapes, unsupported
  CLI options, hidden pipeline failure, the omitted export-box count, shallow
  history, invalid benchmark names and stale reference-patch context.
- Repair `ba23c6ea` is pushed. Standing authorization covers publication and
  squash merge after all final-head gates pass; keep one active delivery PR.

## Local checks and collection

Use `python3 scripts/local-guard.py` for serial focused checks/collectors.
Keep all resource limits; full builds, suites and benchmarks stay on GitHub.
Workflow lint passes (6.44s); roadmap links/statuses pass (10.86s). Check the
new evidence README after staging it, then publish the preparation.

Scratch helpers in `../gradient-work`:

- `collect-packed-input-checks.py --run 41840527818 --source
  ba23c6ea7226c31f626839530035e717f3ce05c7 --output ../gradient-work/packed-input-checks-2`
  collected all three hosts; no need to download again.
- `audit-packed-input-repair.py --directory ../gradient-work/packed-input-checks-2
  --host arm|amd|mac` completed all audits (0.83s/0.97s/0.94s).
- `retain-packed-input-checks.py` completed retention; Linux 2.24s, macOS 1.18s.

Leave dirty primary/older worktrees alone. This branch owns current work.

## Completed delivery

[PR #256](roadmap-history.md#matched-optional-results-pr-256) merged as
`cfb6dcc4223e281188cf6159e0623368501e2294`; its tree equals tested `81bce309`.
All nine production jobs and documentation passed and were fully audited. The
squash message is one line under 80 characters with no body/trailers. Redundant
same-tree main runs were cancelled. No further #256 validation is needed.
