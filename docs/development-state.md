# Current work

**Next:** run consolidated validation for [PR #215](https://github.com/e6qu/fun-with-pipes/pull/215), the combined G3/G4 candidate.
Fix all failures from that run together before repeating affected checks. Do not
restart the old publisher or split this preparation into smaller PRs. G5 follows
once the replacement ownership checks pass; tracing has not been deleted.

Worktree: `/private/tmp/fwp-ownership-fault-matrix`; branch: `ownership-fault-matrix`.
Implementation checkpoint: `d4a2ca37` adds ARC unwind/file cancellation, wide-count
metadata checks, a recursive weak-channel example and the finite deletion map.
Earlier checkpoints after reparenting: `40a194ea` (weak channels), `b29efcb5`
(graph/serialization), `c900d301` (retained C callbacks), `201df98b` (direct libraries).

The accepted direction is inferred moves/borrows, count-free unique storage,
ARC for sharing, explicit weak links and rejection of unproved owning cycles.
Preserve returned functions and partial application. Every API may break; builds
must not depend on a previous fwp version or self-hosting. The optional old
executable used for bounded probes is not a build dependency.

## Delivery state

PR #215 is ready for review. Production run `40212350477` and documentation
`40212350054` test `aab769dd1b3fefe290d6cd285ceb83c8f05d70c1`. All nine production
jobs are scheduled. The C/Rust benchmark job passed; all eight native jobs are still running.
Windows ARM64 reported a failed socket/library step; its log is unavailable until
the job completes. Linux ARM64 passed native and WASM Clippy. Skipped draft jobs are not acceptance.

Draft documentation `40212299724` found a stale protocol-suite count: the evidence
report expected nine tests after two identity-serialization tests were added. The
local repair updates the report and log fixture to 11 (total 52); all eight
`test-collection-evidence.py` controls pass under the guard. Keep this repair in
the batch while auditing every completed production target; it is not pushed yet. Final-head docs failed on the same count. The batch also
connects the unwind/wide-count probes to the existing evidence helper, preserving
C, executables, output and status before assertions. Formatting and the native
schedule audit passed after that addition.

Source review found ARC variants in `library_resources`/`library_unload` still
enabling tracing/poisoning, including both Windows library paths. They now use
explicit mode-correct settings for normal and deliberately broken runs. Socket
scratch/constructor probes also override inherited stress/verification/poisoning.
`/private/tmp/extract-fwp-socket-faults.py` passed both extracted tests at O1/O2 in
ARC and tracing with all three settings initially inherited as `1` (14.67 seconds).
This checks saved #213 C with the current probe, not the candidate generator. The
library changes still require integrated execution.

Both Windows jobs now report socket/library and list-copy inspection failures.
The workflow skipped independent producers after the first failure; their missing
artifacts then caused secondary inspection failures. The candidate workflow now
runs those independent suites after a successful compiler check and accumulates
failures across the early Cargo groups. All 19 native-runner tests and targeted
Windows `actionlint` passed under the guard. No repair push yet; audit remaining
jobs and completed targets first. Do not assume all reported Windows failures
have the same cause until their retained logs are read. Full builds/suites run on GitHub; local checks stay serial under
`scripts/local-guard.py`. Standing authorization covers publication and squash merge
only after all nine production jobs and documentation pass for the final commit.
Follow [AGENTS.md](../AGENTS.md) for the one-line, at-most-80-character merge subject
and empty body. No trailers or attribution.

PR #214 passed [all nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394961)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394939).
Its verified squash merge is `6ee33396459986a0fa08464b182d23fd2fe6c136`, subject
`Check native ownership without retaining freed storage`, empty body. Its tree
`91f1a23c02328554986d703bf48fdf84a27e85c7` matches tested head
`1591ec72553a1168bc52d5745d1865059c15fede`. This preparation is now reparented onto that identical merge tree; comparison
with the pre-reparent implementation found no tree changes. Duplicate postmerge production run
`40197117132` completed/cancelled; postmerge docs `40197117071` passed.

Both old automation scripts must stay stopped. The #214 watcher recorded
`merged-and-verified` in `/private/tmp/fwp-214-merge-status.json`. The follow-on
publisher recorded `stopped-for-combined-gc-removal` in
`/private/tmp/fwp-fault-matrix-delivery-status.json`; restarting it would overwrite
newer docs and publish the wrong preparation.

## Included implementation

- **Weak channels:** interpreter, ownership rules and native/WASI runtime for
  explicit downgrade/upgrade. Final release expires metadata before destroying
  queued children. Upgrade allocates its result before retaining the target.
  Original strong-owner function frames survive optimization so expiration stays
  observable in the same order. Acquired owners still face conservative cycle
  checks. [The contract](weak-channels.md) explains identity and restrictions.
- **Six boundary examples:** weak queued callbacks; task-owned subscriptions;
  graph IDs with checked generations and 64 slot reuses; explicit retained C
  registrations; returned captures; existing bounded State/AD lifetime rules.
  New count-free parser regions remain A6. The admission matrix now states the
  accepted queue/task/stream restrictions instead of reopening their policy.
- **Retained C callbacks:** `--c-callback NAME` for selected native ARC exports.
  Registration owns copied leading arguments; invocation supplies the final
  argument. Close blocks new entry; release consumes the host owner; active calls
  defer capture destruction until return/unwind. Calls use the first caller's OS
  thread. Results have independent generated release functions. The host must
  stop delivery before release and finish all owners before library unload.
  [The guide](retained-callbacks.md) gives the complete protocol.
- **Replacement diagnostics:** native live-address and physical-byte checks;
  child/borrow/reuse faults; weak metadata; actual file/socket handles; unwind and
  cancellation; real library unload; WASI allocation/count tables. Wide-count
  metadata now has an independent physical malloc/free observer. The
  [diagnostic guide](ownership-diagnostics.md) maps deliberate faults and states
  exactly which collector-only assertions retire in G5.

## Repairs included with this work

Empty callback slices no longer use null pointer arithmetic or null `memcpy`
arguments. Library shutdown explicitly releases scheduler-root/State storage;
native and library shutdown release idle Linux descriptor-wait metadata. These
owners previously relied on complete heap teardown.

The WASI allocation observer now searches beyond empty slots before deciding an
address is new; holes are reused without hiding duplicate registration. Runtime
identities no longer satisfy Encode/Decode/canonical Hash. The old interpreter
accepted a channel through `json.write` and printed `null`; candidate protocol
tests reject direct/list/record forms. Weak equality compares target identity,
including expired targets and function-bearing payloads.

Direct library tests now run ARC alongside tracing and check allocation identity
before reading returned storage. Their signature-error tests no longer race with
positive tests by resetting process-global native settings. Native probe paths
use `.exe`; scoped-file tests use actual Windows handles and escaped source paths.
`retained_callbacks`, `stack_ownership`, `unwind_cleanup` and `wide_counts` are in
the Windows native lists. The macOS schedule assigns all 254 integration targets.

## Checks actually run

All local commands use `python3 scripts/local-guard.py`, serially. No full local
build, corpus or benchmark ran. Optional saved compiler: verified #213 at
`/private/tmp/fwp-compiler-213/fwp-macos-arm64/fwp`, SHA-256
`faf994ee0067f5249da86877a7f450efe7cedcfdd433084ebee046319fff47fa`.
Extracted probes validate the specified runtime/test fragments with Clang, not
the candidate Rust compiler, GCC, Windows or WASI.

| Check | Result and retained driver/evidence |
|---|---|
| Stack children, callback slices, reuse tokens, variant aliases and file owners | Passed their focused normal/fault cases; drivers `/private/tmp/extract-callback-tests.py`, `/private/tmp/check-variant-ledger.rs`; evidence `/private/tmp/fwp-{stack,callback,token,variant,file}-matrix-evidence` |
| Weak metadata | Clang O2, 1,024 rounds, missing expiration 221, missing anchor release 222, early retain on allocation failure 231; `/private/tmp/check-weak-allocation-failures.py` |
| WASI physical ledger's native control | Clang O1/O2: reuse 0, duplicate registration 245, duplicate removal 243; `/private/tmp/check-wasi-ledger-regression.py`; actual WASI pending |
| Retained runtime | 1,024 nested rounds; normal 0, early destruction 242, missing capture/context 241, missing completion 243; `/private/tmp/check-fwp-retained-runtime.py` |
| Retained integration | Adapted saved export bodies plus candidate runtime, Clang O2; first exposed root leak 205, passed after repair, including allocation errors/cancellation; `/private/tmp/check-fwp-retained-integration.py`; Linux waiter execution pending |
| ARC unwind/file cancellation | Dynamic/static O1/O2, 8/1,024 rounds; missing value/unwind/OS close/storage produce 231/232/235/236; `/private/tmp/extract-fwp-unwind.py owned_unwind_releases_values_files_and_tasks_without_tracing` |
| Scoped file source behavior | ARC/tracing O1/O2 matches raw interpreter; same extraction driver with `scoped_file_handlers_match_interpreter` |
| ARC wide counts | Dynamic/static O1/O2, 8/1,024 rounds, overflow 101, allocation failure 102, missing physical metadata free 239; `/private/tmp/extract-fwp-wide.py arc_wide_counts_release_values_and_metadata_each_round` |
| Graph fixture | Old raw interpreter matches nine expected lines, including 64 reuses and old snapshot |
| Primitive inventory | Frozen baseline passed: 394 declarations, 384 distinct, 40 aliases, 373 contracts, 19 templates, no review entries; `/private/tmp/fwp-weak-channel-inventory.json` |
| Documentation | Audit passed after retaining the required status table: 161 link sets, 106 immutable preparation pairs/tags, eight roadmap steps and commit messages |
| Formatting and scheduling | `/private/tmp/check-fwp-callback-preparation.py` passed after the unwind/wide-count edits; 254 targets assigned and whitespace clean |

The unwind probe initially used incomplete typed callback metadata, causing an
ARC escape trap. Correcting the probe's actual File-argument ownership fixed it;
the runtime contract was not weakened. The new wide-count probe initially called
a library-only teardown function from an executable probe; that call was removed.
All listed final focused runs passed. New weak recursive/class cases, candidate
C generation, retained shared-library loading and direct library ARC runs still
need the consolidated compiler/platform gate. Do not cite #214 as their evidence.

## Remaining roadmap work

[PLAN.md](../PLAN.md) is the task list. G2's ownership-analysis N/2N/4N baseline and
numeric regression budgets are still unmeasured; do not expand analysis precision
or claim linear cost without them. G3/G4 now need integrated acceptance. G5 removes
tracing selection, roots/mark/sweep code and collector-only assertions, converts the
named allocation/RSS comparisons to ARC, updates reporting, and checks binaries.
ARC minimization A2–A6, functional overhead, CPU/numerics/AD work and application
scale criteria remain separate milestones after GC removal.

Preserve [the unexplained Intel macOS compiler-abort evidence](measurements/compiler-abort.md).
Diagnose any recurrence from source lifetimes and inputs; passing reruns did not
establish its cause. The primary checkout remains detached at #209 with an
operational handoff and untracked abort report; preserve both. Earlier worktrees
and immutable preparation records are evidence, not a backlog to repeat.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2 analysis baseline; G3/G4 integrated gate; G5 tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
