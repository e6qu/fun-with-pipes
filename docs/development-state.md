# Session handoff

## Current combined delivery

Main is `40dda0795fd150feb3dc0543052c3bf041e865c8`, the verified squash of
[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195). All nine production
jobs and documentation passed; tree, parent and one-line message were verified.
Redundant same-tree production CI was cancelled; documentation was preserved.
[History](roadmap-history.md#native-commands-and-test-recovery-pr-195) records
its native command, test-recovery and derivative-storage work.

Branch `array-moves-and-callback-inputs`, worktree
`/private/tmp/fwp-array-callback-delivery`, combines copied synchronous C callback
strings, array-owner moves, C/Rust application comparisons and the measurement
repair. The preparation at `ea4ce3f1f496513e5edddec6ff4483418ba50875` was replayed
onto #195's identical merge tree; files were verified before these delivery-doc
updates. This is the sole delivery PR. Its final production and documentation
gates are pending; focused checks alone do not authorize merge.

**Next:** publish the combined delivery, audit all final-head jobs and fix any
failures together. Require all nine production jobs and documentation for the
exact commit. Then squash-merge with an explicit one-line subject of at most 80
characters and empty body; verify tree, parent and message. Publication and merge
are already authorized. Continue the next ownership task afterwards.

## Focused checks and measurements

| Work | Focused evidence |
|---|---|
| [Copied callback strings](measurements/callback-inputs.md) | Source `6d8ef30bb428`, run `39758960569`; all six native hosts and 32-bit/WASI pass, with 186 native images and 12 WASI modules inspected |
| [Four-way derivative baseline](measurements/descent-peers.md) | Source `018581d6c071`, run `39755925964`; both Linux jobs and 72 images pass |
| [Packed-array baseline](measurements/packed-descent.md) | Source `1827c3bdc427`, run `39763694417`; both Linux jobs and 96 images pass |
| [Stack-array ownership](measurements/stack-array-ownership.md) | Compiler source `026db07bacbe`, run `39767702114`; all six native hosts and 32-bit/WASI pass, with 270 native images and 12 modules inspected |
| [Array-move measurements](measurements/array-owner-moves.md) | First/repeat runs `39767706345`/`39769019993`; revised protocol source `96967e9ba199`, run `39770344180`; all six Linux jobs and 372 images pass |

All complete logs are audited. The new ownership checks cover shared aliases,
failure/cancellation, tracing stress/verification and deliberately broken cleanup
controls at O0/O2. Missing C compilers fail explicitly. Callback return pointers,
retained callbacks and struct-valued C callback arguments remain outside the new
copied-input contract. No JIT, compatibility adapter or runtime wrapper was added.

The largest packed descent case now makes 25,671 retains instead of 51,342,
with unchanged 459 allocation requests and 7,200-byte managed peak. All repeated
cases halve retains, and managed/raw ledgers finish at zero. Timings do not
establish a general speedup. Earlier small-case slowdowns are preserved; revised
order balances positions and immediate predecessor pairs within rounds and adds
a byte-identical control. Identical bytes still vary by several percent. The
revised AMD64 runner is Intel, unlike the earlier AMD hosts; cross-run differences
cannot be attributed solely to ordering. ARM64's callback frame grows 48→64 bytes;
AMD64 stays at 48. Reports retain code/stack costs and all samples.

Count/storage requirements and focused correctness pass. Timing remains
inconclusive, with no speed threshold or parity claim. One retain per coordinate
still comes from the callback capture. The next compiler task is to prove
caller-owned borrowing through eligible known callbacks, preserving exceptional
cleanup. Before claiming speed, establish a timing budget and stable identical-code
controls. Broader ownership boundaries and all seven roadmap areas remain open.

## Resume files

Paths below are under `/private/tmp/`; keep accepted sources and receipts intact.

| Purpose | Files |
|---|---|
| Accepted #195 delivery | `fwp-195-final-acceptance.json`, `fwp-195-merge-runs.json` |
| Compiler-focused evidence | `fwp-stack-array-publication.json`, `fwp-stack-array-acceptance.json`, `fwp-stack-array-evidence/026db07bacbe/` |
| Numerical measurement and controls | `fwp-balanced-descent-publication.json`, `fwp-balanced-descent-acceptance.json`, `fwp-balanced-descent-evidence/96967e9ba199/` |
| Earlier numerical runs | `fwp-stack-descent-evidence/026db07bacbe/`, `fwp-stack-descent-repeat-evidence/026db07bacbe/` |
| Final preparation and integration | `fwp-stack-array-final-preparation.json`, `fwp-array-callback-delivery-integration.json` |

The primary checkout is detached at #195 with the live handoff as its only edit.
Run focused checks there, serially, through `python3 scripts/local-guard.py`.
Full builds, full suites and benchmarks stay on GitHub. Preserve 64 GiB free disk,
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Do not raise limits. Earlier disk cleanup removed only completed downloaded
archives, preserving reports and hashes; receipt:
`fwp-completed-archive-cleanup-20261022.json`.

Report validation `fwp-check-array-callback-reports.py` passes in 7.43s, including
the repaired required roadmap-status table. Recent guarded checks: `fwp-check-balanced-descent.py` passes in 6.28s (order
balance, seed reproducibility, workflow/docs); AMD64/ARM64 recorded-sample analysis
passes in 2.32s/2.20s; actual callback disassembly/frame inspection passes in 0.37s.
Native artifact inspection is complete; do not repeat downloads or measurements
without a new reason. Interpreter-only checks are not evidence for new C generation.

[PLAN.md](../PLAN.md) remains the project roadmap; [history](roadmap-history.md)
records completed delivery. All seven areas remain open. JIT is excluded.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Prove callback borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the finite application acceptance suite |
