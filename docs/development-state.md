# Session handoff

## Next action

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) is the only active PR.
Combine the queued-function proof, consuming channel sends, measured `tap`
optimization and all CI repairs in this delivery. This replaces the earlier
instruction to open a separate transfer PR. Next: finish auditing the remaining
focused jobs, merge `measure-channel-transfers` into `queued-function-delivery`,
publish the combined head and run full acceptance plus the channel count checks.
The preparation worktree is `/private/tmp/fwp-channel-transfers`.

The remote PR head `6b246748` is not mergeable: GCC at O0 retains tracing routines
in ARC binaries. Local primary repair `e6135894`, preserved by
`roadmap/revision-arc-tracing-exclusion`, excludes those routines before C
optimization. The same repair is included in the combined preparation.

Require all nine production jobs and documentation on the final PR head before
squash merge. Use an explicit one-line subject, at most 80 characters, and empty
body. Verify the merged tree/message before cancelling redundant post-merge CI.
Older passing focused runs do not establish acceptance of the combined head.

## What this delivery changes

Checked ARC admits known queued functions with proved immutable captures:
numbers, strings, containers and other proved functions. Captured channels, tasks,
files, connections and streams remain rejected. The proof follows captures,
returns, queues and caught errors; calls use the receiver's State/autodiff scope.
Unknown function sources remain rejected. Traps and exits produce no function,
which fixes the autodiff rejection found in production. Recursive record-type
comparison visits each pair once. See [the example and limits](ownership.md#next-proof-functions-stored-in-channels).

Channel sends transfer the caller's owner into a queue. A blocked send protects
that owner until delivery, failure or cancellation; closed sends release it.
Independent aliases remain valid. Native callback sinks borrow during the call.
The runtime keeps typed cleanup and scheduling while excluding tracing routines
from ARC builds, including at O0. Tests inspect actual binaries and require a
tracing build as a positive control.

A narrow optimizer change removes an alias returned after `tap`, keeping its
action before the continuation. This removes the temporary tuple passed to
`exchange` in the measured programs. Their loop-state tuples still allocate.
Callback type inference also stops effects from later pipe stages leaking into
stored callback types. No new syntax is introduced.

## Measurements and checks

The [channel protocol and results](measurements/channel-transfer-protocol.md)
compare five fwp programs before/after each change on Linux ARM64 and AMD64.
They measure allocations, retains, managed memory, executable sizes and selected
machine-code stack frames. They do not measure speed or compare with C/Rust.

- Baseline `2b56fd1c`, run `39354805966`: both hosts pass, 180 audited samples.
- Consuming sends `34568f3d`, run `39356051237`: one fewer retain per fresh text
  or function message; shared totals and allocation counts unchanged. Run
  `39357990574` at `5d083f3f` repeats all 180 samples and binary sizes exactly.
- `tap` revision `f0747ab2`, run `39360310385`: both hosts pass, 180 audited
  samples. Each successful exchange saves one allocation and 32 bytes of peak
  managed charge; closed sends are unchanged. Shared text also saves one retain.
  All ARC profiles finish with zero charged storage and no collections. Size
  and stack tradeoffs are reported; these are not zero-cost channel claims.
- Proof repair `fd1275ea`: runs `39357056381` and `39357061326` each pass 158
  focused checks. Precision run `39357198059` passes 27 checks on each of four
  Linux/macOS hosts. All complete logs are audited.
- Collector exclusion `e6135894`, run `39361329677`: Linux and Windows, each on
  both architectures, pass all units and 38 integration checks with no ignored
  cases. Complete logs are audited. Linux explicitly uses GCC, matching
  production. macOS and WASI results still need the final audit.

## Failures repaired and remaining validation

Original production `39353280539` at `d1df84d9` found five autodiff failures
from the non-returning branch proof and, on both Linux hosts, a binary-symbol
failure from GCC retaining unused tracing code at O0. Every completed production
job log is audited, including both Windows hosts and both Linux hosts. Benchmark
and documentation gates passed. The repairs above address both causes.

Production `39359123801` at `6b246748` still lacks collector exclusion. Its
benchmark and documentation gates pass; audit the remaining jobs for any further
failures before the combined publication. Never merge this superseded head.

Preparation run `39357985210` passes 38 integrations on each native host and 18
on each WASI host; its one stale ownership-contract assertion is fixed in
`f0747ab2`. Expanded run `39360304008` passes all compiler units and both WASI
jobs. Completed native jobs expose the new loop test enabling GC-stress flags
in ARC mode, plus Windows C output using CRLF. Both are repaired locally:
tracing keeps stress/reuse checks, ARC uses its required settings, and the C
probe explicitly uses binary stdout. Intel macOS is the remaining job to audit.
Full Windows production now includes the four loop targets too.

## Local checks and accepted base

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`
for serial bounded checks. Formatting and `scripts/check-roadmap.py` pass before
this documentation update; rerun both after integration. Guarded raw interpretation
of the new tapped-loop cases agrees with expected effect order and kept aliases.
The exact standalone ownership-contract unit passes. Guarded
`/private/tmp/fwp-check-arc-preprocessing.py` passes C syntax and exclusion/control
checks in 0.63s without producing a binary. No local full compiler rebuild,
generated native build or timing run was performed.

Free disk is close to the 64 GiB floor; avoid large downloads and use runners for
heavy work. The old recursive-type reproducer exceeded the 1 GiB local guard;
its repaired native regression passed on focused runners. Do not retry the old
compiler locally or raise any guard limits.

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) is accepted as
`3ec71969089a7ab95ff065f7b611c74534fbe326`, after all nine jobs and docs passed.
Its merge tree and one-line message were verified. [History](roadmap-history.md#numeric-hashing-and-integer-output-pr-174)
retains its measurements and remaining C/Rust gaps. The old
`prove-queued-function-ownership` worktree is historical; do not resume it.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Persistent subscriptions,
resource captures, resource-owning tail frames and mutual recursion need further
proofs. JIT is excluded. Follow [AGENTS.md](../AGENTS.md): one active PR, all
final-head gates, bounded local work and one-line commits without trailers.
