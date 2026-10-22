# Session handoff

## Delivery now

Main is `f74c9d2998d595b4a3c15ee4a225a49963c1a6ea`, the verified squash of
[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194).
[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195) remains the sole open
PR at `a284eb0a338cae4efdd9534fd2d67c60a4f04e82`, branch
`native-command-ownership`, worktree `/private/tmp/fwp-native-command-delivery`.
Production run `39753716407` passes eight of nine jobs; Linux AMD64 is still
running without failed steps. Documentation run `39753716342` passes.
Do not change this head while its last gate runs.

#195 adds explicit native ARC selection, recovery/cleanup after root test failures,
concurrent executable-cache publication and Windows process cleanup, plus physical
derivative-storage measurements. Tracing remains the default; child traps/exits
remain process-fatal. Its six-host focused checks and all 84 actual image
inspections pass, as do both derivative jobs and all 104 image inspections.

**Next:** audit #195's last gate with `/private/tmp/fwp-audit-195-final.py`.
Once all nine production jobs and documentation pass, run the prepared
`fwp-merge-195.py` and `fwp-after-merge-195.py` helpers. They verify exact-head
acceptance, squash with one subject of at most 80 characters and an empty body,
verify tree/parent/message, and cancel only redundant same-tree production CI.
Publication and merge are already authorized. Fix any failed jobs together.

## Next combined PR: prepared and focused checks complete

Branch `compare-derivative-descent`, worktree `/private/tmp/fwp-ad-comparison`,
starts from #195's tested tree. It combines copied synchronous C callback strings,
array-owner moves, C/Rust application comparisons and the measurement repair.
No second PR is open. After #195 merges, replay these commits onto its identical
merge tree, verify the files, update delivery docs and publish one combined PR.
Require all nine production jobs and documentation at that final commit.

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
| #195 final checks and merge | `fwp-native-command-delivery-publication.json`, `fwp-195-final-acceptance.json`, `fwp-audit-195-final.py`, `fwp-merge-195.py`, `fwp-after-merge-195.py` |
| Compiler-focused evidence | `fwp-stack-array-publication.json`, `fwp-stack-array-acceptance.json`, `fwp-stack-array-evidence/026db07bacbe/` |
| Numerical measurement and controls | `fwp-balanced-descent-publication.json`, `fwp-balanced-descent-acceptance.json`, `fwp-balanced-descent-evidence/96967e9ba199/` |
| Earlier numerical runs | `fwp-stack-descent-evidence/026db07bacbe/`, `fwp-stack-descent-repeat-evidence/026db07bacbe/` |
| Final preparation and integration | `fwp-stack-array-final-preparation.json` (created after report commit), `fwp-integrate-array-callback-delivery.py` (requires #195 verified merge) |

The primary checkout is detached at #194 with this handoff as its only edit.
Run focused checks there, serially, through `python3 scripts/local-guard.py`.
Full builds, full suites and benchmarks stay on GitHub. Preserve 64 GiB free disk,
target data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second limit.
Do not raise limits. Earlier disk cleanup removed only completed downloaded
archives, preserving reports and hashes; receipt:
`fwp-completed-archive-cleanup-20261022.json`.

Recent guarded checks: `fwp-check-balanced-descent.py` passes in 6.28s (order
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
