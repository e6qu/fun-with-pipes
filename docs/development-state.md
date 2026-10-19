# Session handoff

## Next action

Branch: `runtime-storage-completion`, based on merged PR #168 at
`5258c6efd0418f19add23f5e2a763563178af823`. Its tree equals PR head `59845d04`.
The [delivery record](roadmap-history.md#self-tail-recursion-and-shutdown-repairs-pr-168)
records passing checks and the remaining failures; the merge is not acceptance.

Next: publish this batch as one draft PR. Dispatch `numerics.yml` with
`suite=shutdown` and `suite=language`; audit every failed target and completed job.
After focused checks pass, mark ready for all nine production jobs plus docs.
Require the exact final head before squash merging with a one-line subject of
at most 80 characters and an empty body. Do not weaken leak checks or repeat
completed self-tail recursion work as a new task.

## Current work

The previous shutdown run `39211372965` finished on Linux AMD64 and macOS ARM64.
Network, TLS, services, AOT and tutorial sessions no longer stall. Language/tools
`39211377606` and documentation `39211352992` passed. Full runs `39215835611` and
`39215850976` were cancelled because they duplicate the known failing merged tree.
Complete failed logs are in `/private/tmp/fwp-598-shutdown-fail.log`.

Stricter allocation ledgers exposed retained startup constants: 16–336 bytes in
multiple golden programs, task results, scopes, sockets, foreign callbacks and
wide autodiff. The compiler built compound constants and wide literals on the
heap before the old baseline snapshot. This batch emits static storage for
records, variants, arrays, maps, 128-bit numbers and constant closure captures.
Pointer fields initialize without allocating. Packed arrays retain their selected
layout; immutable updates cannot reuse static storage. No collector or leak
allowance replaces ownership. Runtime-computed cached values keep ordinary owners.

The collection, map and new executable-shutdown probes also matched indented
OpenCL error cleanup calls. Their insertion anchors now match complete lines at
the generated program's final cleanup. This fixes test instrumentation, without
removing the allocation or missing-connection-closure negative controls.

`tests/static_constants.rs` compares interpreter output with O0/O2 native code,
ARC/tracing, packed/word arrays, aliases and immutable updates. It counts startup
allocation requests and checks zero final ARC charge. Injecting a startup request
must fail. The shutdown suite retains generated C, symbols and actual executables;
new target coverage includes macOS shards and native Windows. Full platform and
WebAssembly verification remain required; implementation alone is not support.

## Checks

All local checks use `python3 scripts/local-guard.py`; no local compiler build.

- `cargo fmt --all`: pass, 1.38 seconds.
- `/private/tmp/fwp-terminal-763-mac/fwp check tests/fixtures/static_constants.fwp`:
  pass, 0.26 seconds. This accepted older compiler checks fixture syntax only;
  it does not verify the current compiler change.

## Measurement limits

This batch tests allocation and representation, not elapsed-time parity with C.
Static data and startup stores still cost space and work. PR #168's recursive vs
explicit-loop timings compare fwp with fwp; O2 eliminated one countdown but not
the other, so those timings do not establish equivalent executed-loop performance.

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
work is the next ownership/performance gap selected from representative programs
and the measured results of this batch. Do not repeat this batch as a new task.
