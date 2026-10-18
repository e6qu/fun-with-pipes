# Session handoff

## Next action

PR #167 is merged as `e8e22f1901e5396e1bf3555073ebeb9d5c65da41`, with the same
Git tree as tested head `7cb899faa86d3cafb1192529d7fd357e7067ca4b`. All nine
production jobs, documentation, four terminal probes and tools/browser checks
passed and their completed logs were audited. Duplicate queued post-merge runs
`39151593383` and `39151593381` were cancelled after checking tree identity.
[Delivery history](roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
records the acceptance links and limitations.

Current branch: `ownership-tail-recursion`, based on that merge.
Draft [PR #168](https://github.com/e6qu/fun-with-pipes/pull/168).
Next: complete the cycle-contract and self-tail-recursion batch, run focused
checks on GitHub, fix every failure, then publish one substantial PR with full
final-head acceptance before squash merge.

## Current batch

- Lower eligible direct self-tail recursion to the existing typed `loop`
  operation, shared by interpreter and native generation. Preserve evaluation
  order, ownership and cancellation safe points. Keep resource/handler cleanup
  and unknown captures outside the proof, with an explanatory IR diagnostic.
- Test scalar, swapped multi-argument and immutable shared-data states, failure
  order, cancellation, and rejection of non-tail/resource-bearing frames.
  Check deep execution at native O0/O2 and in the interpreter. Inspect generated
  C and real binaries, and measure allocations/live memory before claiming costs.
- Make checked-ARC diagnostics explain the ownership path that lacks a cycle
  proof. Exercise subscription lifetime, channel workers, cancellation and graph
  IDs/deletion using existing language facilities. Weak handles remain proposed;
  never imply an unproved lifetime is a demonstrated cycle.
- Update runnable examples and the plan in plain language. Keep explicit tool
  settings, empty Python initializers, top-level imports and no compatibility
  adapters. All seven roadmap areas remain open.

Implementation started in `src/tailrec.rs`, after ordinary simplification and
before higher-order specialization/ownership insertion. It uses the existing
Step/loop representation; no new source syntax or runtime continuation format.
First focused run `39152295142` at `d3830612` compiles and passes Clippy.
Twenty-five Rust tests pass; the sole failure is test setup enabling tracing
stress/verification for an ARC-only binary. The working tree corrects those
settings by mode and keeps reuse verification enabled. Before that rejection,
deep interpretation and tracing O0/O2 pass; cancellation passes independently.
All eleven Python tests and the installed-package browser check pass.
Full log audited: `/private/tmp/fwp-tail-d383.log`.

The working tree also adds lesson 23, ARC physical-reclamation and payload-path
checks, curried-argument/frame-safety tests, and a runner-only comparison with
explicit fwp loops. It records raw timings, allocation/live-memory profiles,
actual disassembly and per-function stack estimates. These additions still need
the next focused run; full final-head acceptance follows.

## Checks

- Guarded old CI compiler (`763e245b`) raw interpretation passes the small
  recursion reference (including curried arguments), 0.34 seconds; lesson 23
  outputs `(Some 7, None)`, `6`, `None`, `(None, Some [1])`, 0.26 seconds.
  The initial tutorial send-argument ordering mistake was fixed before publication.
- Guarded Python audit passes all 72 files, 0.37 seconds. Rust formatting and
  roadmap audit passed before the draft push; rerun for the combined changes.

- `python3 scripts/local-guard.py python3 /private/tmp/fwp-monitor-pr167-7cb8.py`:
  PASS, 28.18 seconds. All 15 merged-head jobs passed; no failed Rust executions.
  Linux: 758 passes per host. Regular Macs: 470 per host. Mac GC: 293 per host.
  Windows: 365 per host. Tools: 24 Rust checks, eleven Python tests and real
  Chromium. Four terminal hosts each ran both tests, with zero skips.
- Preserve the fixed local guard limits. Do not rebuild the compiler locally;
  focused checks may use downloaded CI binaries with their revision recorded.

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

The seven project work areas in [PLAN.md](../PLAN.md) remain open. Default tracing
removal is unfinished. JIT is excluded. After this delivery, the next substantial
work is cycle-safe ownership contracts and eligible tail-recursion elimination,
selected and checked against representative programs.
