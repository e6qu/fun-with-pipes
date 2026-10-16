# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This worktree is TCP constructor preparation, `/private/tmp/fwp-tcp-owners`,
branch `tcp-owner-preparation`, based on `bb6d2ea3`.

The current delivery is [PR #153](https://github.com/e6qu/fun-with-pipes/pull/153),
branch `owned-values-delivery` in `/Users/zardoz/projects/fun-with-pipes`. It combines decoded-value cleanup,
numerical worker storage and UDP socket lifetimes, including the passing UDP
preparation through `2fd73fe2`. Do not apply that preparation again.

## Current delivery and next action

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) was merged by the user
at 2026-10-16 14:18 UTC as `1fa0fec690b7747a9ffcf2d72903d16544889258`.
All nine production jobs `38901011355` and documentation `38901011298` pass
for `485665795e47f6d7d6e078d386bc56b9c8cdeded`. The merge tree matches that
head, its parent is accepted #151, and the one-line message has no trailers.
Duplicate postmerge run `38914679717` is confirmed canceled.

The combined delivery is rebased onto that accepted squash. Runtime and test
files are unchanged from `b4038995`; the rebase only adds #152's CI compiler
optimization settings and their explanation. Original preparation is retained by
remote tag `evidence/owned-values-before-152`. The plain-language PR draft is
`/private/tmp/fwp-owned-values-pr-body.md`.

Head `bb6d2ea3bacc5b9b5017e23dcca64943d893c44f` has production
`38915283341` and documentation `38915283274` running. This local status update
does not change that published head.

Next: require all nine production jobs plus documentation on that exact head. Fix any failures. Then squash-merge with the
explicit subject `Reduce temporary memory and clean up network resources` and
an empty body, verify the merge tree, parent and message, and cancel redundant
postmerge CI. Continue the ownership work without opening a competing delivery PR.
Standing authorization covers publication, fixes and these successive merges.

## Changes and focused evidence

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
- [CI compiler settings](measurements/ci-compiler-profiles-2026-10-16.json),
  both recorded hosts pass: selected tests run faster with optimization
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
primitive inventory checks pass. The accepted delivery inventory has 306 contracted declarations and 37 review
symbols. The new TCP/TLS preparation inventory passes with 335 contracted
declarations and 19 review symbols; these counts do not establish tested support. The macOS schedule assigns all
229 integration targets. Evidence retention with
`python3 scripts/local-guard.py python3 /private/tmp/fwp-retain-udp-evidence.py`
passes in 0.49s. Preparation documentation checks pass in 2.93s; the contributor
guide with explicit plain-language PR guidance passes in 2.82s. No local native
build was run.

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

Combined formatting passes under the guard in 1.07s and documentation in 2.57s.
The eight new integration targets are assigned to the macOS GC job; all previously
accepted assignments stay unchanged. In #152, Intel regular took 83m25s and Intel
GC took 70m27s, leaving more room in the latter under the 90-minute limit. This is
a coverage-preserving assignment, not a promise about future runtime. Full
combined acceptance has not run. General tracing removal, TCP/TLS handle
ownership, callbacks retained by external code, cycles and host re-entry remain
unfinished. Conservative function lifetimes can prevent some optimizations.
The existing OpenCL runtime compilation still conflicts with the no-JIT objective;
do not expand it or add a JIT. New backends and distributed execution remain
outside scope.

## Following preparation

`/private/tmp/fwp-tcp-owners`, branch `tcp-owner-preparation`, starts from the
current PR head. Review found that TCP listen and accept have no descriptor
cleanup registered while allocating their language-level handle; connect already
has such cleanup. The preparation now protects both construction paths with the existing pending
connection cleanup mechanism. Its regression uses real local TCP descriptors,
32 failed listen allocations and 32 failed accept allocations, then verifies
successful ownership transfer. It separately removes each cleanup to ensure
missing cleanup is detected. No socket layout or supported ownership mode changes. Require zero remaining
descriptors after injected failure, a deliberately missing-cleanup control, native
O1/O2 checks on all six hosts and shared-runtime regressions. This does not yet
extend checked ARC to TCP/TLS or change the socket representation. Bundle verified
work into the next substantial delivery after #153; do not open a competing PR.

Focused six-native socket validation and actual WASI shared-runtime regression
checks must pass before integration. Local native builds remain prohibited.

## Next ownership increment

Extend the same logical socket ownership to TCP connections and listeners, while
preserving original function/task lifetimes, explicit close through aliases and
TLS session transfer. A shared socket header holds the descriptor, kind and
64-bit owner count. Only TLS-enabled stream handles need an additional session
pointer; UDP and plain-TCP programs keep their current header size. This requires
no extra allocation for a counter and no new language syntax. The extra pointer
in TLS-enabled stream handles must be measured and documented.

Protect optional accepted connections, read results and certificate-subject
results during construction. Check ordinary and reference-counted execution,
real TCP/TLS traffic, allocation failures, cancellation, library unload and
existing HTTP/2 transfers. Keep the earlier constructor run as evidence for its
exact source. No broader TCP support is verified until the extended checks pass.

The original TCP constructor revision `985fc772` runs six-host sockets
`38916070418` and actual WASI `38916075039`. The broader socket ownership increment
is unverified. Its raw accepted-interpreter TCP fixture passes in 0.25s with
rebind, holder lifetime, transfer, timeout and concurrent-close output. Guarded
primitive inventory passes in 1.32s. Fresh native TCP/TLS and WASI checks are next.

The TCP suite runs real socket construction/lifetimes, UDP regressions, tasks and
mutual TLS (including ARC) on all six hosts. Existing POSIX-specific TLS teardown
and transfer probes run on Linux/macOS. Their results must not be described as
Windows teardown evidence; Windows traffic and layout checks are separate.

At `eaa42582`, ARM macOS passes task, TCP lifetime/zero-storage and all UDP
checks. The constructor test did not trigger its second allocation failure:
its hook missed `fwp_alloc_init`'s fast path. The hook now covers that path once,
without double-counting its fallback into the general allocator. No runtime code
changed for this repair. Independent TLS and POSIX teardown checks now run even
when a preceding test fails, preserving a failed overall job. Fresh TCP checks
are required; the exact-runtime WASI run `38918290525` remains applicable.
