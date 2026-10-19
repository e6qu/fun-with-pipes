# Session handoff

## Next action

Branch: `mixed-tail-recursion`, following accepted
[PR #170](https://github.com/e6qu/fun-with-pipes/pull/170). Its squash merge
`903482e856e33f4206a04f1cd1ddf73123fc6c29` has identical files to tested head
`142117d22e140049032dba4e2c61676210649373`. All nine production jobs
(`39259766176`) and documentation (`39259766267`) passed before merging.
[History](roadmap-history.md#acyclic-nested-channel-ownership-pr-170) records the
channel proof and Windows filename repair. The old run has no separate failures.
Duplicate post-merge production run `39275352369` was cancelled on the identical
accepted tree; cancellation is not acceptance.

Next: publish this recursion batch as one PR, audit every final-head production
job and the documentation check, and fix every failure before squash merging.
The new compiler behavior has not yet been rebuilt or executed. Full builds,
suites and benchmarks belong on GitHub runners. Do not repeat the accepted
channel work as a new task or claim the pending recursion checks have passed.

## Current batch

The compiler now considers tail calls independently of ordinary recursive calls
in the same function. A call used to compute an argument, binding, match condition
or later calculation keeps its ordinary frame. A direct self call whose result
is returned without further work can reuse the frame when its local types prove
plain immutable data. Resource, task, channel and unknown-capture restrictions
remain. Next arguments are evaluated before replacing the current frame; native
cleanup tokens and interpreter cancellation checks retain their existing paths.

Tests add a 200,000-step countdown with one pending addition, swapped/shared
strings, nested argument calls, effect/failure order, curried arguments and I128.
A small raw-interpreter run supplies an independent result reference. Deep runs
exercise the optimized interpreter, native tracing/ARC at O0/O2 and actual WASI
ARC at O0/O2. Native cleanup ledgers, tracing/reuse stress, WASI allocation checks
and omitted-free controls remain required. Both pure and mixed tail loops have
cancellation tests. Proof tests retain ordinary work and reject cleanup/debugger
regions. CI retains generated C, executable and disassembly artifacts through
`FWP_TAIL_ARTIFACTS`.

Lesson 22 explains mixed calls with a small executable example. The design,
compiler pipeline and benchmark guide distinguish bounded tail transfers from
ordinary recursion. Selecting frame reuse can prevent some local objects from
using stack storage; direct field representations remain available. This batch
makes no elapsed-time, zero-allocation or C/Rust parity claim. General tail calls,
mutual recursion and resource-owning frames remain separate work.

## Checks and limits

Every local command below ran through `python3 scripts/local-guard.py`, serially.
The existing `target/debug/fwp` predates this change: it validates source syntax
and small-case semantics, not the new proof or deep execution.

- `env FWP_NO_OPT=1 target/debug/fwp run --interp /private/tmp/fwp-mixed-tail-small.fwp`:
  passed in 0.73 seconds with the explicitly expected ten output lines. The file
  reduces 200000/200001 to 20/21 while preserving parity and results.
- `cargo fmt --all`: passed in 1.60 seconds after the test updates.
- `target/debug/fwp fmt tests/fixtures/mixed_tail_recursion.fwp docs/tutorials/22-recursion-and-sharing/main.fwp`:
  passed in 0.15 seconds.
- `env FWP_NO_OPT=1 target/debug/fwp run --interp docs/tutorials/22-recursion-and-sharing/main.fwp`:
  passed in 1.18 seconds; all six lines match `main.out`.
- The existing compiler's optimized small fixture also produced the same ten
  lines (0.60 seconds). It has no new tail proof, so this is not acceptance.
- `python3 scripts/check-roadmap.py`: passed in 3.29 seconds (60 document sets,
  106 immutable anchors and seven work areas). `git diff --check` passed.
  Final-head CI is next.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership/cycle contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven work areas in [PLAN.md](../PLAN.md) remain open. JIT is excluded.
After this batch, use representative applications to select the next ownership
or performance gap. Persistent subscriptions and weak handles remain design
work; default tracing removal is unfinished. Keep one current handoff and move
accepted delivery evidence to history.
