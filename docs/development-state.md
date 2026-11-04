# Current work

**Next:** finish Intel macOS retry `126506098945`, audit its full/target logs, then
squash [PR #255](https://github.com/e6qu/fun-with-pipes/pull/255). Eight other production
jobs and docs already pass and are audited. Keep its head unchanged. In parallel,
retain the completed optional-result measurements below; open its PR only after #255.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve the frozen selection and ownership contract |
| 2 | Verified | Preserve native behavior and physical-cleanup checks |
| 3 | Verified | Keep complete measurements and missed limits explicit |
| 4 | In progress | Finish the Intel retry, audit, squash and verify the tree |

## Delivery: final iteration values

- Worktree/branch: `.worktrees/iteration-final-value` / `iteration-final-value`.
- Exact head: `19b91c059d223614124773ab6e356824514f69f1`, base `379bc9d5`.
- Production run `41796687665`, attempt 2: Intel regular macOS is running its test
  shard. The eight other production jobs pass. Docs `41796687483`, job
  `126462340110`, also pass. Require all nine plus docs before merging.
- Intended squash subject: `Return final iteration values without retaining their history`.
  Supply an empty body; verify the raw one-line message and tested tree afterward.
- [Native correctness](measurements/final-iteration-storage-2026-11-03/README.md),
  [runtime results](measurements/final-iteration-time-2026-11-04/README.md) and
  [compiler costs](measurements/final-iteration-analysis-2026-11-04/README.md) are complete.
  Preserve all six runtime misses and the compiler-noise case. Do not repeat timings.
- Measured code/tests/build inputs equal frozen `bb5433b6` byte for byte, retained
  by `roadmap/final-iteration-measurement-2026-11-04`. The contract and development
  history also have immutable tags; never move them.

[Attempt 1](measurements/final-iteration-storage-2026-11-03/upload-failure/README.md)
passed all 128 regular targets and later packaging, but artifact upload failed
with `ENOTFOUND`. Its full log has no other unexpected diagnostic. Only that job
was retried. The upload failure is not a compiler bug or a passing gate.

GitHub copied successful jobs to new IDs for attempt 2. The collector verifies
unchanged source, runner, steps and execution timestamps against each original
job, retaining both IDs. New creation times and absent zero-valued runner-group
metadata describe copied records, not repeated executions. Reconciliation passes.
Windows audits include all 155 targets per architecture from the final archive;
the earlier 57-log bundle is incomplete by design, not the whole Windows gate.

From the optional-result worktree, use the local guard for these scratch tools:

```text
python3 ../gradient-work/collect-final-iteration-platforms.py --run 41796687665 --source 19b91c059d223614124773ab6e356824514f69f1 --docs-job 126462340110 --output ../gradient-work/platforms-255
python3 ../gradient-work/retain-final-iteration-delivery.py --merge VERIFIED_SQUASH
```

Do not pass `--attempt 1`; select the current Intel retry. Collection skips pending
jobs, so require ten successful audit records before merging. Retain the verified
merge/gates in the next branch, reconcile it onto main, then publish its grouped PR.
Cancel duplicate main checks only after confirming their tested tree and no failures.

## Next group: matched optional results

Worktree/branch: `.worktrees/matched-option-fields` / `matched-option-fields`.
No PR yet. Compiler/runtime changes and controls are implemented; remaining work
is complete measurement retention, #255 reconciliation and final platform delivery.

| Evidence | Exact identity and status |
|---|---|
| Frozen contract | `4ec13baa`, tag `roadmap/matched-option-fields-protocol-2026-11-04` |
| Three-host correctness | `41808352672`, source `fb46193306de9c377a644138df8d1480e7ca7db3`, passes |
| Frozen measurement source | `82963531dddb6d9a5f32ec26657dc220736f4055`, tag `roadmap/matched-option-measurement-2026-11-04` |
| Compiler cost | `41811652687`, both jobs and all 480 command/raw-record audits pass |
| Initial runtime batch | `41811658838`: both ARM64 sessions and AMD64 session 2 pass; session 1 rejected before build/time |
| Initial raw audit | `41814391372` passes; all 4,002 file records and full logs reconcile |
| Final runtime session | `41814521814` passes; raw audit `41817009801` passes all 1,334 file records |

Compiler/runtime/library/tests/build inputs at the frozen measurement source match
passing `fb461933` byte for byte. Later edits only retain evidence and clarify docs.
Never move either frozen tag or rerun completed noisy/failing timings for a pass.

[Native checks](measurements/matched-option-fields-2026-11-04/README.md) pass per host:
268 units (four deliberate ignores), 57 integrations across 15 targets, seven
selection checks, 40 new controls, 506 native-image observations and eleven other
statuses. All 960 list-read, 80 iteration and 240 prior scalar count rows agree.
[The first failed fixture batch](measurements/matched-option-fields-2026-11-04/fixture-repair/README.md)
is retained; its repair did not change compiler/runtime code.

[Compiler costs](measurements/matched-option-analysis-2026-11-04/README.md) pass all
ten cases: maximum time ratio 1.00804, peak-RSS ratio 1.00386, copy variation 1.24%.
[All four runtime sessions](measurements/matched-option-time-2026-11-04/README.md)
and raw audits pass, reconciling 5,336 files. Each history-form solve saves one
request, 16 requested bytes and one retain; peak managed/raw storage is unchanged.
Some larger timings are up to 1.95% slower, within 2%; maximum frame growth is
16 bytes. Do not claim a general speedup or close older timing comparisons.

[Four rejected hosts](measurements/matched-option-time-2026-11-04/rejected-hosts/README.md)
are fully audited and retained. Each stopped before build/time. A later dispatch
returned HTTP 502; the run list confirmed no run existed before retry `41814521814`.
The final audit uses the frozen measurement tag and source; its complete
collection passes. No measured session was repeated.

### Collection and publication

Scratch tools live in `../gradient-work`; use `python3 scripts/local-guard.py`:

- `collect-matched-option-runtime.py --run AUDIT_RUN --prefix matched-option-runtime-amd1 --audit-source 82963531dddb6d9a5f32ec26657dc220736f4055 --source 82963531dddb6d9a5f32ec26657dc220736f4055`.
  Both collections now pass under prefixes `matched-option-runtime-all` and
  `matched-option-runtime-amd1`; do not repeat them.
- Retention, all 48 cross-session count comparisons and report generation pass
  (0.78/0.30/0.28s). Tools: `retain-matched-option-time.py`,
  `summarize-matched-option-memory.py`, `write-matched-option-time-readme.py`.
- Reconcile after #255, then update scratch `matched-option-pr.md` and publish
  one grouped PR. Final platform checks remain pending.
- Full evidence processing and final test gates belong on GitHub, not locally.

`82963531` also gives each macOS test-log upload one retry with identical files
and artifact name. Missing logs or a second failure fail CI; both attempts stay
visible. #255's workflow is unchanged. Audit any recovered upload error against
the exact retry step and artifact; do not blanket-ignore diagnostics.

### Local verification and workspace

- Latest `python3 scripts/local-guard.py python3 scripts/check-roadmap.py`: passes
  263 link sets, 106 immutable identities and four roadmap steps (2.68 seconds).
  Shortening the handoff initially removed its required status table; restored it
  and the recheck passes (2.83 seconds).
- Rust formatting, workflow lint, primitive inventory (395 declarations / 374
  contracts), source-reference, measurement-budget, raw-audit and report controls
  pass. No new Cargo target; native shard assignment is unchanged.
- Guarded collections: native 23.67/23.26/23.14s; ownership/image/count audit 2.34s;
  retention 4.79s. Compiler audits 28.59/31.15s; runtime collections 4.52/5.74s.
- The checksum-verified #255 macOS compiler package checked only the small fixture's
  formatting/types and raw/optimized interpreter outputs. No local compiler build,
  full suite or benchmark. Keep the fixed disk/RSS/target/deadline guard limits.
- Preserve dirty primary and old worktrees. Only this branch owns the current docs.
  Keep one active delivery PR. [#254's completed delivery](roadmap-history.md#float-bits-and-identity-array-maps-pr-254)
  is history, not remaining work.
