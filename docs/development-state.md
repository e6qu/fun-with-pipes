# Current work

**Next:** finish auditing the cache/TLS repair's Intel macOS focused job in
`40270503961` and the final artifact upload in `40262766433`. Once all known
failures are repaired and focused checks pass, publish the evidence/docs update
and mark [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216) ready for all
nine production jobs, documentation and analysis budgets on the final head.
Draft skips do not count as acceptance. Do not raise startup or analysis limits.

Worktree: `/private/tmp/fwp-ownership-fault-matrix`, branch
`remove-tracing-runtime`. Published repair:
`577249f8bc4043d7eda033e3ed433806a0e9806d`; PR temporarily draft.
The primary checkout remains detached at #209; preserve its operational handoff
and untracked compiler-abort report. [PLAN.md](../PLAN.md) owns the roadmap.

## This delivery

The interpreter and native compiler now share queue, State and derivative
lifetime checks before program effects. Coverage includes returned functions,
macros, compile-time calls, REPL recovery and gRPC handlers. Native representation
and C ABI checks remain separate.

The shared check exposed a false rejection in nested differentiation: two partial
applications were merging their captures. The repair distinguishes finite IR
creation positions while keeping actual invocation scopes. Large raw REST inputs
then exposed repeated type walks; the latest repair caches complete type queries
and expression types within one proof. A recursive-type regression ensures a
partial negative answer cannot hide a callback field.

Allocation/reuse comparisons now use identical ARC-generated C with copying
selected explicitly, preserving reference counts and cleanup. Plans, guides and
tutorials explain the current weak-channel/callback contracts, numeric results,
macro checking order and benchmark boundaries. **Tracing is not deleted yet.**

## Verification

| Source/run | Result and scope |
|---|---|
| `577249f8`, analysis `40270501455` | Both hosts pass: 190 library tests, small worker scaling budgets and both raw REST budgets |
| `577249f8`, compiler/server `40270503961` | Linux passed completely; Intel macOS server/tool checks running; Clippy passed both |
| `793bf7da`, analysis `40268967670` | Failed: raw forms admission 11.36 s Linux, 48.92 s Intel macOS; superseded by the cache repair |
| `793bf7da`, compiler/server `40268976256` | Both hosts passed; superseded by the cache repair |
| `793bf7da`, docs `40268960183` | Passed; does not verify the later source |
| `0db38df8`, production `40262766433` | Failed; all native test logs audited, only known queue/startup failures; packaging passed; final artifact upload pending |

The [analysis report](measurements/ownership-analysis.md) and its raw records
separate compilation, lifetime checking and execution. Latest raw forms analysis:
6.20 s Linux / 7.10 s Intel macOS; second fixture: 3.90 s / 4.66 s. Limit: 10 s
each. These single samples from separate runner sessions are not a paired speedup
measurement. Cache entries are not cache bytes. Full server behavior still needs
its regression checks.

The previous full-head audit found only two failure categories so far:

- Three outdated queue tests expected interpreter success for rejected owning
  cycles. Revised expectations cover raw/optimized interpreter/native rejection
  before output. All 40 captured-compiler probes and focused Linux queue tests pass.
- Slow interpreted REST/HTTP/HTTPS startup. All four macOS shards, both Windows
  TLS/entry batches and all 256 logs from each Linux architecture are audited. Each Linux host
  had 932 passing tests and four failures; macOS ARM64 had 925 passes/five failures,
  Intel had 908 passes/22 failures. Windows failures match those causes.

TLS and long-running memory tests used a blocking startup read that could miss its deadline and
killed failed children without reaping them. They now use the existing bounded
helper, explicit announcement prefixes and an owned stderr-drain thread. The
three standalone helper tests pass. The memory harness also compiles at Rust O1
with warnings denied and passes its three helper tests. Its stderr drainer now
uses a sink instead of an unbounded byte vector. Server integration verification
is pending.

Logs are under `/private/tmp/fwp-216-final-*`,
`/private/tmp/fwp-216-repair-*` and `/private/tmp/fwp-216-cache-analysis-{linux,mac}`. Current Linux admission/server
logs: `/private/tmp/fwp-216-cache-admission-linux`; TLS certificate failures there
are expected invalid-client controls.
Earlier creation-site verification: `40259739899`; paired analysis baseline:
`40261359439`, source `092009f83a1ba217820f2495d459fdb5c3b10c74`.
Keep the original measurements intact rather than relabeling them as current.
The saved ARM64 crash was the deliberate task-cleanup abort control, not a
recurrence of the [unexplained Intel compiler abort](measurements/compiler-abort.md).

## Local checks

No full local build or suite ran. Commands use `python3 scripts/local-guard.py`:

- `python3 /private/tmp/check-fwp-callback-preparation.py`: formatting, metadata,
  native schedule (254 targets) and diff checks pass.
- `python3 scripts/check-roadmap.py`: 162 link sets, 106 preparation pairs/tags,
  eight roadmap rows and commit messages pass. The rewrite initially omitted
  the required status index; restoring it fixed the audit.
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-g5-primitive-inventory.json`:
  394 declarations, 384 symbols, 40 aliases, 373 contracts, 19 templates; no reviews.
- `python3 /private/tmp/fwp-check-rejection-expectations.py`: 40 old-compiler
  rejection probes pass. This does not verify the later performance repair.
- `python3 /private/tmp/fwp-check-server-startup.py`: three bounded-startup tests pass.
- `python3 /private/tmp/fwp-check-memory-startup.py`: changed memory harness
  compiles with warnings denied; its three bounded-startup tests pass.

## Verified base and next group

PR #215 merged as `4e7b74be8e11634fac9309e67cb4efccfb34d360`, with the same tree as
tested head `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`:
`dad73fe097358b3f5842b5d44dcfc13b84fb6bac`. Production `40221722197` and docs
`40221722121` passed. G3/G4 are delivered; [history](roadmap-history.md) records them.

`/private/tmp/fwp-delete-tracing`, branch `delete-tracing-collector`, contains
unpublished, incomplete G5 deletion based on `0db38df8`. Its handoff lists runtime,
code-generation, report and test migrations. Do not claim it builds. Rebase onto
verified merged #216 before publication; keep one active PR. The finite deletion
map is in [ownership diagnostics](ownership-diagnostics.md). A2–A6 then address
remaining reference counts, boxes, unique buffers and scoped workspaces.

Keep old #214/#215 publishers stopped; they would overwrite newer docs. No merge
watcher runs. After final-head gates pass, squash with an explicit single-line
subject of at most 80 characters and empty body, verify tree/message, then continue
PLAN.md. No trailers or AI attribution.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2/G5 final validation, then tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
