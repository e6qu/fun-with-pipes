# Current work

**Next:** publish the packed-input pass-order repair and native cleanup preflight,
finish the grouped measurement wiring, and monitor
[PR #256](https://github.com/e6qu/fun-with-pipes/pull/256). Preserve its exact head
`81bce309c4524058aefead68f203d6dfa3b5731a`. Production `41822132045` is running;
documentation `41822131973`, job `126547601776`, benchmark job `126547602413`
and both ARM64 macOS jobs pass; their full/target logs are audited (5.19/8.42s
guarded collections). The other six production jobs are running. No failed steps at
the latest check. Require all nine production jobs plus docs and full/target-log
audits before squash merge. Keep one active delivery PR.

Preparation worktree/branch: `.worktrees/packed-derivative-inputs` /
`packed-derivative-inputs`. [The contract](measurements/packed-derivative-inputs.md)
groups bounded scoped specialization, packed indexed records and overlapping
pair reads. Frozen at `cc425aba`, immutable tag
`roadmap/packed-derivative-inputs-protocol-2026-11-04`. Scoped specialization,
packed producer/consumer lowering and eight compiler proof controls compile/pass
at `0b274ca8`. Actual gradient selection failed; the repair and native controls
are written but unverified. Measurement wiring remains. No local build or timing.

Source diagnostic `41824802673`, job `126556701498`, passes at `3c091d3f`: all
12 emissions, 43 hashes and full log audited in 5.46s. It exposes the known
objective but leaves its input producer inside a temporary record. The
[binding proof](measurements/scoped-objective-review-2026-11-04/README.md) was
frozen at `3ccc9bf2`, tag `roadmap/packed-input-binding-proof-2026-11-04`, before
implementing bounded, resource-safe let reassociation. That implementation is
passed preflight `41827593617`, job `126566218264`, at `0b274ca8`, but all three
optimized gradient cases still missed packed-input selection. All twelve
compilations and the other nine selection controls pass. The full log and 43
file hashes are audited and [retained](measurements/packed-input-selection-2026-11-04/README.md).
Numeric-parameter lowering exposed field reads only after the new pass had
already rejected the callbacks. Move packed-input selection after it; retain
the strict proof and add a production-generation forwarding regression.

New native controls cover both window orders and range positions, scalar
captures, bounds/list sizes, caller aliases, each stage's trap/cancellation,
allocation failure, eager order, actual frees, disabled reuse and deliberate
missing-free/field-corruption controls. Raw/optimized interpreter and O1/O2
outputs are compared. These tests join existing `zip_unwind_ownership` coverage;
the source preflight now runs these two tests and focused Clippy on ARM64 GCC.
The unchanged #256 delivery head does not contain these next-group changes.

The updated `iteration-storage-review` suite now explicitly requires packed
producer and pair selections for all three optimized gradient inputs, absent
for raw/scalar/shared-history controls. It also runs both new proof-test groups
even if source selection fails. This is a short preflight, not the grouped
three-host native correctness or performance gate. No runtime timings have started.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve the frozen selection and ownership contract |
| 2 | Verified | Preserve native behavior and physical-cleanup checks |
| 3 | Verified | Keep complete measurements and missed limits explicit |
| 4 | In progress | Publish, pass final gates, audit and verify squash/tree |

## Previous delivery completed

[#255](https://github.com/e6qu/fun-with-pipes/pull/255) merged as
`24e099135f08403a95f36752e39f4e609a5d06cb` on November 4. Its tree equals
`19b91c059d223614124773ab6e356824514f69f1`; the raw squash message is one line,
under 80 characters, with no body or trailers. [History and complete gates](roadmap-history.md#final-iteration-values-without-histories-pr-255)
retain all ten successful jobs, full/target logs, the original upload failure
and Intel retry `126506098945`. Final collection passes in 12.14s; verified
retention passes in 0.14s. No further #255 checks are needed.

The matched-option branch rebased onto that squash without content changes.
Original history is retained at immutable
`roadmap/matched-option-pre-delivery-2026-11-04` (`4c378ce5`). Never move it or
any frozen contract/measurement tag. Duplicate main runs `41821619651` and
`41821619512` were cancelled only after tree equality and no-failure checks.

## Current group: matched optional results

Worktree/branch: `.worktrees/matched-option-fields` / `matched-option-fields`.
Compiler/runtime changes, controls and measurements are complete. Rebased onto
verified #255 with a byte-identical tree and published as PR #256. Its squash
subject is `Avoid temporary option allocations for matched list results`;
supply an empty body and verify the raw message and tree after passing CI.

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
- Final platform checks are running. Use `collect-matched-option-platforms.py`
  with `--run 41822132045 --source 81bce309c4524058aefead68f203d6dfa3b5731a
  --docs-job 126547601776 --output ../gradient-work/platforms-256`.
  It audits a recovered upload error only with successful retry and verified logs.
- Full evidence processing and final test gates belong on GitHub, not locally.

`82963531` also gives each macOS test-log upload one retry with identical files
and artifact name. Missing logs or a second failure fail CI; both attempts stay
visible. #255's workflow is unchanged. Audit any recovered upload error against
the exact retry step and artifact; do not blanket-ignore diagnostics.

### Local verification and workspace

- [Next source review](measurements/numeric-record-inputs-2026-11-04/README.md):
  run `41818502246`, job `126535365251`, source `82963531` passes all 12 compilation
  commands and 43 hashed files. Guarded collection 5.63s; archive/logs retained.
  Proposed group: bounded known scoped-call specialization, packed indexed
  numeric input records and overlapping reads. Preserve all three eager stages.
  The implementation contract is frozen above; no performance claim yet. Also corrected
  stale #251/#252 platform status in the compiler design guide.

- Latest `python3 scripts/local-guard.py python3 scripts/check-roadmap.py`: passes
  264 link sets, 106 immutable identities and four roadmap steps (2.59 seconds).
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
- Freed 1.55 GiB by removing nine verified download caches after confirming
  committed audits and live GitHub artifact hashes. Kept logs/reports and the
  inconclusive comparison's archive. Scratch manifest:
  `../gradient-work/removed-verified-downloads-2026-11-04.json`. The initial cleanup
  assertion expected a list rather than the audit's failure map and removed
  nothing; corrected check passes under the guard (5.04s).
