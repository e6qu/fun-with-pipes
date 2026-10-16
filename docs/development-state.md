# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This worktree is preparation for the next delivery: `/private/tmp/fwp-owned-udp`,
branch `owned-udp-lifetimes`, based on `owned-values-delivery` at `4d9ecadd`.
There is only one open delivery PR.

## Current delivery and next action

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) reduces temporary memory
in hashing and numerical calculations. Its description now explains the changes,
a concrete calculation, the benchmark comparisons and their remaining limits.
Head `485665795e47f6d7d6e078d386bc56b9c8cdeded` has passing documentation
`38901011298` and seven of nine production jobs in `38901011355`. Linux AMD64 and
regular Intel macOS remain running. Do not merge before both pass.

Next: require all nine production jobs and documentation on that exact head,
then squash-merge with subject `Reduce temporary memory in hashing and numerical calculations`
and an explicitly empty body. Verify the merge tree, parent and exact message,
then cancel duplicate postmerge CI. Standing authorization covers these actions.

After acceptance, rebase only the `owned-values-delivery` delta after `c81b0c9f`
onto the accepted squash. Its current prepared head is `7b6775a8`; preserve the
CI optimization settings and final numerical changes from #152. Add this UDP
branch's delta after `4d9ecadd`, consolidate the handoff and open one combined PR.
Full production and documentation must then pass for the combined head.

## Prepared changes and evidence

The next batch fixes cleanup for decoded values, numerical results and temporary
network buffers. It removes a full temporary array from CPU calculations. UDP
socket copies share a handle, explicit close affects all copies, and the last
owner closes it. Function and task captures keep sockets alive for their original
scope. Linux now releases records for tasks waiting on closed sockets. Invalid
network addresses and compiler options produce explicit errors.

- [Owned values and numerical workers](measurements/owned-values-and-kernels-2026-10-16.json):
  six-host checks pass for the relevant runtime changes. A Windows export defect
  in the new unload fixture was repaired and all six unload checks pass. Both
  actual WASI checks pass for the recorded supported code.
- [DNS results](measurements/dns-ownership-2026-10-16.json): all six native and both
  WASI checks pass. Results preserve order without the old 64-address cutoff;
  tests exercise 81 addresses and all 162 result-allocation failures.
- Socket temporary-buffer repair `7224b3de`: all six jobs in `38898918147` pass.
- [UDP cleanup](measurements/udp-ownership-2026-10-16.json): all six native jobs
  in `38910056368` pass at `ffe6fc7d8c475ecabf72f9db7bcd9b2d0ebd984b`.
  Both actual WASI regression jobs `38908635005` pass at `7c3889ac`; relevant
  runtime and compiler ownership sources are identical between these revisions.
  This is shared-runtime regression coverage, not WASI networking support.
- [CI compiler settings](https://github.com/e6qu/fun-with-pipes/blob/7b6775a8/docs/measurements/ci-compiler-profiles-2026-10-16.json),
  committed in the prepared delivery: selected tests run faster with optimization
  level 1, while initial builds take longer. Both settings keep assertions and
  overflow checks. These measurements do not predict full-suite timing.

UDP evidence retains sources, executable hashes, outputs and exact job results.
Tests compare interpretation with compiled behavior, exercise 4096 create/release
cycles and 301 copies, fail every receive allocation, cancel waiting tasks, and
load/unload real libraries while a host socket remains usable. Deliberately
omitting cleanup makes the controls fail. Programs using reference counting
without tracing physically release memory; retaining released storage for reuse
checks is explicitly rejected in that mode.

The ARM64 macOS test executable was inspected with `nm` and `otool`. It updates a
64-bit owner count at byte offset 8 and requests a 16-byte socket header. The count
shares an existing field used by other socket kinds, avoiding a larger header.
This instrumented test binary establishes layout, not throughput or cache costs.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially with the existing disk, memory,
CPU and deadline limits. Full builds, tests and benchmarks run on GitHub. Earlier
local compiler and standalone C builds were refused by automatic review; do not
retry or bypass that restriction. About 92 GiB disk remains free.

The accepted reference compiler is
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`.
Guarded formatting, generated library documentation, interpreter examples and
primitive inventory checks pass. The inventory has 306 contracted declarations
and 37 distinct symbols still requiring review. The macOS schedule assigns all
229 integration targets. Evidence retention with
`python3 scripts/local-guard.py python3 /private/tmp/fwp-retain-udp-evidence.py`
passes in 0.49s. No local native build was run.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Deployment and primitive ownership; remove tracing GC |
| 2 | In progress | Remove remaining functional abstraction costs |
| 3 | In progress | Diagnose and reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation speed, memory scaling and precision |
| 5 | In progress | CPU kernels and the runtime OpenCL compilation gap |
| 6 | In progress | Repeatable comparisons across representative workloads |
| 7 | In progress | Larger numerical, collection-heavy and long-running programs |

## Remaining limits

Full combined acceptance has not run. General tracing removal, TCP/TLS handle
ownership, callbacks retained by external code, cycles and host re-entry remain
unfinished. Conservative function lifetimes can prevent some optimizations.
The existing OpenCL runtime compilation still conflicts with the no-JIT objective;
do not expand it or add a JIT. New backends and distributed execution remain
outside scope.
