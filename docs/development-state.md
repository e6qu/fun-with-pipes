# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This worktree is `/private/tmp/fwp-tcp-owners`, branch `tcp-owner-preparation`,
based on PR #153's `bb6d2ea3`. It is preparation, not a second open delivery PR.

## Current delivery and next action

[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only open delivery.
The main workspace `/Users/zardoz/projects/fun-with-pipes` tracks its branch
`owned-values-delivery`. Head `bb6d2ea3bacc5b9b5017e23dcca64943d893c44f`
has production `38915283341` running; benchmarks and documentation `38915283274`
pass. Its decoded-value, numerical-worker and UDP changes are already combined.

Next: fix any failures and require all nine production jobs plus documentation
on that exact head. Squash-merge with explicit subject
`Reduce temporary memory and clean up network resources` and an empty body.
Verify the merge tree, parent and message, then cancel duplicate postmerge CI.
`/private/tmp/fwp-merge-153.py --merge` checks these gates. Standing authorization
covers publication, fixes and successive merges; do not request it again.

After #153 acceptance, rebase only this branch's delta after `bb6d2ea3` onto the
accepted squash. Integrate the following work only after its focused checks pass,
then publish one substantial PR and require fresh complete acceptance.

PR #152 is accepted as `1fa0fec6`, with all nine production jobs and docs passing,
matching tested files, a single-line commit message and no trailers. Duplicate
run `38914679717` is canceled. [Delivery history](roadmap-history.md) has the record.

## TCP and TLS preparation

The first repair closes an operating-system socket if allocating its returned
TCP handle fails. It uses the existing pending-connection cleanup mechanism.
[Constructor evidence](measurements/tcp-construction-2026-10-16.json) records
`985fc772b7f090e91d17ad26267e67ddf3c35b24`: six native jobs `38916070418`
and both actual WASI regression jobs `38916075039` pass. Real sockets, 32 failed
listen allocations, 32 failed accept allocations, successful transfers and
omitted-cleanup controls are retained. This earlier revision does not enable ARC
for TCP/TLS.

The broader runtime at `eaa42582` adds logical owners for TCP connections and
listeners, including TLS, and preserves function/task capture lifetimes. Copies
share the same handle; explicit close affects them all. The last owner also closes
it. Optional accepted connections, read bytes and certificate-subject text clean
up partially built results on failure.

Common socket headers retain the previous UDP/plain-TCP size. Only stream handles
in TLS-enabled programs add a session pointer, within the same allocation. There
is no separate counter allocation. This is not a claim of zero runtime overhead.
Compiler contracts and source inspection do not establish tested support.

The first broader run `38918284443` exposed a test hook that missed the
initialized allocator. Repair `59e9b082` covers it without double counting.
Replacement `38919269219` passes all five TCP tests, the UDP tests, task cleanup
and mutual TLS on ARM macOS. Its old POSIX controls need updates: two still search
for the previous cleanup text, the certificate-copy hook misses the new owned
result, and Linux ARM64 can retain a stale register after a root fence is removed.
The pending test repair checks actual premature session release instead of assuming
that a conservative collector must discard a particular register. It also tests
failure when wrapping certificate text in an optional result. These tests remain
unverified until the replacement run passes; the runtime itself is unchanged.

Both actual WASI regression jobs `38918290525` pass for runtime `eaa42582`.
New TCP library-unload coverage checks three retained descriptors over three real
load/unload cycles, including an intentionally omitted cleanup. Mutual TLS now
retains the executable and checks that tracing functions are absent. No second
PR is open; publish this preparation and run the focused native suite next.

The native suite compares raw and optimized interpretation with O1/O2 tracing
stress and ARC, checks cleanup without collections, and inspects ARC symbols.
It covers real TCP traffic, timeout, simultaneous accepts closed through an alias,
301 owners and optional-result allocation failures. Mutual TLS adds ARC execution
on every native host. Existing POSIX teardown/transfer probes run on Linux/macOS;
they are not Windows teardown evidence. Independent TLS steps run even if an
earlier test fails, while the overall job remains failed.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially with the existing CPU, memory, disk
and deadline limits. Full builds, native tests and benchmarks belong on GitHub.
Earlier local compiler and standalone C builds were refused by automatic review;
do not retry or bypass that restriction.

The accepted compiler `/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp` gives the
raw TCP fixture's expected output in 0.25s. Guarded Rust formatting passes in
1.10s. The lightweight standalone `tests/stdlib_doc.rs` generator builds in 0.61s,
regenerates in 0.50s and rechecks without blessing in 0.01s. Primitive inventory
passes in 1.32s: 335 contracted declarations, 19 remaining review symbols. These
are implementation counts, not support evidence. The documentation audit passes
in 2.46s. Constructor evidence retention passes in 0.13s. The new TCP library fixture
prints `True` under the accepted interpreter (guarded, 0.26s), and the updated
Rust formatting check passes in 1.12s.

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

## Remaining work

Finish and verify the TCP/TLS preparation, including the new library teardown
and TLS binary checks. Remaining primitive reviews are concentrated in
network-service callbacks and HTTP/2 streams, process exit and GPU execution.
Callbacks retained by external code, mutable cycles and host re-entry still need
explicit lifetime rules. Conservative handling of captured functions can prevent
optimizations. General collector removal is unfinished.

The existing OpenCL runtime compilation conflicts with the no-JIT objective.
Do not expand it or introduce a JIT. A new backend and distributed execution
remain outside scope. Continue the memory and performance work in the plan after
the current deliveries; completing a batch does not complete the roadmap.
