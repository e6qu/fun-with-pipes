# Current work

**Next:** monitor PR #254's repaired head and publish the next group's focused
checks from `iteration-final-value`. Keep one delivery PR: open the next only
after #254 passes all final gates and its squash tree/message are verified.

## PR #254: final gates

- Active PR: https://github.com/e6qu/fun-with-pipes/pull/254.
- Repaired head: `8bf9c65bc247bbd94903d0a31fb0823d1e335391` on branch/worktree
  `scalar-array-identities`. Production `41713252299` and docs `41713252267` are
  queued; no repaired-head native job has run yet.
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
  Library comments generate the updated reference on CI; import that artifact
  after reviewing its diff. Do not edit `docs/stdlib.md` manually.

The `final-iteration-checks` manual numerical workflow groups compiler units,
primitive inventory, nine affected integration targets, tutorial execution and
library-doc generation on GCC Linux ARM64/AMD64 and Clang macOS ARM64. It retains
all partial logs and native probes. Windows now explicitly includes
`iteration_consumers` in its final matrix. No new integration target is added.

After focused checks: repair every finding in one batch; implement/audit the
same-source reference, then measure the frozen runtime/compiler/stack limits.
Both reference and candidate must contain count/cleanup repairs. Reference alone
restores reverse/head and disables history removal. No timing session has started.
Final nine-job plus docs verification remains required before delivery.

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
