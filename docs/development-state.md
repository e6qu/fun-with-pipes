# Session handoff

Updated 2026-10-16. Independent preparation in `/private/tmp/fwp-wasi-arc`,
branch `checked-wasi-ownership`, anchored at `e5e05748`. Transfer only changes
after that anchor; its parents belong to the preceding zip/list/text delivery.
Do not replay them.

The only open delivery is [PR #149](https://github.com/e6qu/fun-with-pipes/pull/149)
at `5748f749`, with exact-head production
[38841142126](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126)
still running and documentation passed. The root worktree owns that handoff.
The following substantial batch is prepared in `/private/tmp/fwp-zip-map`, with
combined native/WASI checks
[38847420495](https://github.com/e6qu/fun-with-pipes/actions/runs/38847420495)
at `5c222c4b`. Its two actual-WASI count jobs and Mac ARM native job pass; other
native jobs are running. This preparation has no PR and must not displace either
delivery. Their own handoffs preserve detailed evidence and remaining failures.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs plus documentation pass for the exact final head. Commit subjects
are one line, at most 80 characters, with empty body and no trailers/attribution.
JIT is excluded. Local checks use `python3 scripts/local-guard.py COMMAND...`
without raising limits; full builds/gates and measurements run on GitHub.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Prove checked ownership for synchronous WASI entries |
| 2 | In progress | Accept preceding zip/list allocation and cleanup changes |
| 3 | In progress | Preserve preceding native instruction and count evidence |
| 4 | In progress | Accept reduced derivative intermediates; broader costs remain |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable timing and physical storage evidence |
| 7 | In progress | Extend maintained-program checks across deployment boundaries |

Next: prepare checked ARC for synchronous WASI main/function/CLI entry points,
keeping unproved browser re-entry, libraries and asynchronous host fibers
explicitly rejected. First review the non-tracing allocator's count removal and
startup policy, then prove physical reclamation and semantic agreement. Continue
monitoring the two preceding deliveries; only one PR may be active.

## Scope and acceptance before implementation

WASI is a WebAssembly environment that supplies standard streams and file access.
The current compiler rejects `--gc arc` for every WebAssembly target, although
its runtime already uses typed destruction and an out-of-line count table there.
Unlike native tracing, WebAssembly cannot scan engine-held locals. Unproved
shared values therefore remain retained today; removing the rejection alone
would not establish checked ownership.

The candidate must use the existing compiler ownership checks, reject a counted
owner escaping to permanent shared retention, and distinguish removal of count
metadata during legitimate last-owner destruction from sharing. Startup must
reject requests for tracing/stress/reuse-retention just as native ARC does.
No new surface notation, fallback memory mode, JIT or backend is proposed.

Initially reject browser entry points and asynchronous host fibers until their
retained callbacks and re-entry lifetimes have evidence. Native behavior must
stay covered. Also reject native-library build flags combined with a WebAssembly
target: the current library branch ignores that target instead of producing a
WebAssembly library. No new library ABI is in scope.

Acceptance needs actual WASI O1/O2 execution, raw-interpreter agreement for
collections, closures, text files and scoped derivatives, repeated main/function
and CLI workloads, and both live-count and actual malloc/free evidence. Counts
alone do not prove physical reclamation. Include deliberately missing free/share
guards, overflow and unwinding controls, invalid mode options, and required
toolchain assertions rather than skips. Inspect emitted modules for absent
tracing. Native six-platform regressions and the final nine-job gate still apply.

The prototype separates count removal from rejected sharing, applies the same
ARC environment checks to both allocators, allows synchronous WASI targets,
and rejects browser/service/host-fiber entry and WebAssembly library flags.
The actual-WASI suite is required on both Linux production hosts; focused suite
`wasi-arc` runs it alongside native ARC and existing WebAssembly resource checks.

Local checks use the guard and remain supplemental. The accepted #148 compiler
plus edited runtime passes O1/O2 physical frees, rejected sharing, overflow and
invalid-option controls (2.60 s). Missing free and share-guard controls fail with
237 and 239. Formatting passes (1.09 s). The standalone test harness compiles
(0.37 s); an initial invocation omitted Cargo environment metadata and was
corrected. The repeated list fixture prints 2560 with accepted interpretation
(0.25 s). These do not establish actual WASI or changed-compiler support.

The new test-only libc ledger tracks live allocation addresses and byte sizes
independently of reference-count metadata. Candidate programs cover repeated
list/state construction, retained closures, UTF-8 reads and scoped derivatives.
At O1/O2 they must match raw interpretation, return physical storage and counts
to their entry baseline, and reject deliberately omitted object frees. The
small allocator fixture also exercises 300 aliases, real 64-bit count overflow,
rejected permanent sharing and startup option rejection. All runner checks are
pending; do not describe this prototype as supported WASI ARC yet.

Next: dispatch focused actual-WASI checks, fix all failures, add function/CLI
entry coverage and inspect the produced modules for absence of tracing. Only
then update supported-target documentation. The accepted #148 compiler at
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp` remains available for small
edited-C mechanism probes. No full compiler build was run locally.
