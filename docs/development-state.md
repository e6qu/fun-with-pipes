# Session handoff

## Next action

Branch: `runtime-storage-completion`, based on merged PR #168 at
`5258c6efd0418f19add23f5e2a763563178af823`. Its tree equals PR head `59845d04`.
The [delivery record](roadmap-history.md#self-tail-recursion-and-shutdown-repairs-pr-168)
records passing checks and the remaining failures; the merge is not acceptance.

[PR #169](https://github.com/e6qu/fun-with-pipes/pull/169) remains open.
Next: publish the batched CI repairs below, dispatch focused shutdown and language
runs, and audit all results. Focused shutdown now covers Linux AMD64 and both Mac
architectures. Require all nine production jobs plus docs on the final head
before squash merging with an explicit one-line subject and empty body.

## Current CI repair

Audited all nine jobs in full run `39218043349` at `0bb1d63d`, both focused
shutdown jobs in `39216746539`, language `39216749928` and docs `39216745819`.
Bench, language/tools and docs passed. All eight production execution jobs failed;
focused Mac failed and focused Linux exhausted its job deadline. Complete target
logs are in `/private/tmp/fwp-0bb-targets`; full logs are
`/private/tmp/fwp-0bb-full.log` and `/private/tmp/fwp-0bb-shutdown.log`.

Distinct failures and batched repairs:

- Collection/map probes omitted a final newline before `#ifdef`. Restore it;
  keep the exact-line anchors and strict zero-charge checks.
- The library stack-release negative control changed the unused executable
  cleanup routine. Restrict it to library teardown and require a unique match.
- The OpenCL executable negative control assumed adjacent CAF/OpenCL cleanup.
  Match the actual final OpenCL call; preserve the independent library control.
- Unoptimized exact-float linking lacked `softfloat_commonNaNToF128UI` because
  plain C `inline` requires an external definition. Configure header helpers as
  `static inline`; test native and WASI O0 in addition to O1/O2, including NaN
  conversions from F16/F32/F64 to F128.
- Intel REST completed 20 cases before the target's 1800-second total limit.
  Historical Intel runtime was already 1704 seconds. The runner now requires
  explicit `--idle-timeout`: completed harness cases renew the deadline, while
  arbitrary output cannot. It still kills stalled process groups, reports failure
  and continues other targets. Full-job deadlines and local limits are unchanged.

The stricter task, scope, socket, foreign-call, autodiff and golden-corpus ledgers
passed after static storage was implemented. The new dedicated static-constant
probe still needs a passing run after its O0 linking repair. Focused checks now
include every failed code target and the runner deadline controls. Previously
passing network/example targets remain in full production acceptance; removing
their duplicate focused runs prevents another focused-job timeout.

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

- `python3 scripts/test-native-test-runner.py`: all eleven pass, 8.55 seconds.
  The first new progress test was too tight under local throttling; its synthetic
  timing now allows startup overhead while still running longer than its deadline.
- `cc -std=c11 -O0 -I vendor/softfloat /private/tmp/fwp-nan-inline.c -o /private/tmp/fwp-nan-inline`:
  pass, 0.39 seconds; `/private/tmp/fwp-nan-inline`: pass, 0.26 seconds. This directly
  checks the missing helper's linkage and canonical F128 NaN bits, not the full compiler.
- `cargo fmt --all`: pass. Full builds and native/WASI verification stay on runners.

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
