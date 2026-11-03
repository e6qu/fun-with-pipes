# Current work

**Next:** publish the batched final-iteration repair and run `final-iteration-checks`
on all three native hosts. Monitor PR #254's repaired final gates in parallel;
open the next delivery PR only after its verified squash merge. No timing session
has started for final iteration storage.

## PR #254: final gates

- Active PR: https://github.com/e6qu/fun-with-pipes/pull/254.
- Repaired head: `8bf9c65bc247bbd94903d0a31fb0823d1e335391` on branch/worktree
  `scalar-array-identities`. Production `41713252299` is running with no failed
  steps reported. Benchmarks and docs `41713252267` / job `126186525051` pass,
  with full-log audits retained in scratch `platforms-254-repaired` (5.00 guarded
  seconds). Remaining native gates are running or queued.
- Previous production `41694728758` at `9061744b` completed: seven jobs and docs
  passed; both Windows jobs failed the same two float probes. Their custom C
  mains omitted binary-stream setup, producing CRLF. The repair checks `_setmode`
  on stdout/stderr and preserves exact-byte assertions. The audit verifies all
  1,600 conversion rows and 32 deliberate fatal-allocation exits. TLS unknown-CA
  output belongs to a passing untrusted-client rejection control.
- [Retained diagnosis](https://github.com/e6qu/fun-with-pipes/blob/8bf9c65bc247bbd94903d0a31fb0823d1e335391/docs/measurements/scalar-array-identities-2026-11-03/windows-repair/README.md).
  Full logs, target archives and collector are in scratch `platforms-254` under
  `.worktrees/gradient-work`. Audit every completed target and compiler diagnostic.
- All measurements are complete. The compiler/runtime/library still match frozen
  `beddd406153f1976fed00847292207bff9053e22`. Keep all 32 missed speed goals open;
  never repeat completed timing sessions for a pass. See [the complete report](measurements/scalar-array-identity-time-2026-11-03/README.md).
- Require nine production jobs plus docs at the exact repaired head. Squash
  subject: `Preserve float bits and remove redundant F64 array copies`. Empty
  body, one line, at most 80 characters, no trailers/attribution; verify merged
  tree equals the tested tree. Preserve the passing head while gates run.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve #254's conversion and exact selection contract |
| 2 | Verified | Recheck repaired probe streams in final native CI |
| 3 | Verified | Keep completed measurements and all missed speed targets |
| 4 | In progress | Pass repaired-head gates, audit and squash #254 |

## Next group: final iteration values

Worktree/branch: `.worktrees/iteration-final-value` / `iteration-final-value`.
No delivery PR yet. The [contract](measurements/final-iteration-storage.md) was
frozen at `2a257a3eea7b6005c350f1f860e27755b18b25c2`, tag
`roadmap/final-iteration-storage-protocol-2026-11-03`, before implementation.

Implemented, awaiting focused native verification:

- Direct `last` borrows a list and returns its final item in an owned option.
- Exact single-use `iterate` → `last` calls with numeric states or numeric
  lists/arrays keep only the current state. Shared histories and resource-bearing
  states remain excluded. Dynamic/captured callbacks keep their evaluation order.
- The interpreter matches native oversized-count rejection before callbacks.
- Fresh optional wrappers have cleanup protection while retaining children.
  A failed retain frees the wrapper without dropping an unacquired child.
- Tests compare old reverse/head, direct-last and selected-history paths, with
  exact scalar/wide bits, count boundaries, aliases, captured callbacks, array
  slices, both layouts, reuse, traps, cancellation and missing-cleanup controls.
  A generic-last file test checks that the selected stream remains open until its
  final owner is released. Source tests compare both interpreters and native O1/O2.
- The collections tutorial explains five iterations from 1 yielding `Some 16`.
  The matching generated library reference was imported from both GCC artifacts;
  its three added comment lines were reviewed. Do not edit it manually.

The `final-iteration-checks` manual numerical workflow groups compiler units,
primitive inventory, nine affected integration targets, tutorial execution and
library-doc generation on GCC Linux ARM64/AMD64 and Clang macOS ARM64. It retains
all partial logs and native probes. Windows now explicitly includes
`iteration_consumers` in its final matrix. No new integration target is added.

### First focused batch and repair

[Run 41715801311](https://github.com/e6qu/fun-with-pipes/actions/runs/41715801311)
at `f599dfba030b9fb70b53eb503bb001719a4ce8be` failed on both GCC hosts because
`iteration_consumers` imported private `fwp::interp::Value`. The repair imports
`fwp::value::Value`. Both hosts passed compiler build, 268 unit tests (4 ignored),
inventory, tutorial execution in both engines and identical generated docs.
The integration batch could not compile, so **no native ownership test ran**.
All completed full/step logs were audited; no second failure cause was found.
The still-queued macOS job was cancelled for this obsolete source. See
[retained failure evidence](measurements/final-iteration-storage-2026-11-03/compile-repair/README.md).

The repair also adds real-gradient selection checks and the measurement tools:

- The same-source reference restores `last = reverse | head` and disables only
  unused-history removal. Both compilers keep count validation and cleanup repairs.
- Five reference controls pass, including real tiny Git checkouts and corrupt
  manifest, patch, saved-source and partial-reference rejection.
- All 19 budget controls pass. History speed, current-only regressions, large
  history peak storage, traffic, ARC, cleanup and stack have separate limits.
- All 17 raw-evidence controls pass (19.42 guarded seconds). Saved edits are read
  as literals, never executed. Seven compiler-cost and three retention controls
  also pass; the latter controls plus reference checks take 1.73 seconds.
- Workflow lint passes (6.85 seconds); formatting passes (1.72 seconds).
  Real emitted-C selection checks run on CI before measurements. They require
  selection for eligible scalar/list/gradient inputs and exclude shared histories
  and the already current-only loop.

After the repaired focused batch passes, measure the frozen runtime/compiler/stack
limits. Do not repeat completed sessions for a pass. Final nine-job plus docs
verification remains required before delivery.

## Completed preparation and local checks

- Inspection `41698313044` at `13df096288aad41300f41d76f9a4f6c58440b192` passes:
  12 raw/optimized source/IR/C compilations, full log and all artifact hashes.
  [Evidence](measurements/final-iteration-storage-2026-11-03/README.md) retains
  real gradient and shared-history inputs. The source had no compiler changes.
- The retained Clang O2 source probe demonstrates the optional-wrapper leak
  (16 charged bytes) and protected cleanup (zero). This is source-level evidence;
  the new Rust-generator regression still requires native execution.
- Guarded formatting passes (1.61 seconds); workflow lint passes (6.86 seconds).
  Primitive inventory passes (0.89 seconds): 395 declarations, 385 symbols,
  374 contracts, no unresolved symbols, unchanged frozen baseline. Native shard
  coverage passes for all 255 integration targets (0.13 seconds).
- No local compiler build, full suite or timing run. Use `python3 scripts/local-guard.py`
  serially: 64 GiB free disk, target data below 2 GiB, workload RSS below 1 GiB,
  180-second deadline. Move larger work to CI; never raise/bypass limits.
- Leave the primary checkout's recovery edits and old worktrees alone. Reconcile
  this preparation branch with #254's verified merge before its final matrix,
  preserving frozen tags and uncommitted work. The old run `38888712709` is a
  service-status ghost with no active jobs; its original failures were repaired.
