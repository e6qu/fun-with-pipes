# WebAssembly task and browser-loader ownership

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

**Comparison:** JSPI (engine-supported suspension) versus Asyncify (rewritten
code that saves/restores execution state), plus deliberately broken cleanup
controls. The [report](wasm-host-owners-2026-10-18.json), `2e47a412`,
runs real wasm32 modules on Linux AMD64/ARM64. The browser loader is exercised
under Node, not actual browser engines.

**Work:** 16 rounds of tasks/channels, strings, repeated waits, returned values,
errors, cancellation and task-local state. O1/O2 ordinary/counting modules must
match raw interpretation, through WASI and the browser loader. Clang 18.1.3,
Binaryen 132, Node 24.21.0, `-ffp-contract=off`, 32 MiB main stack.
These recorded sizes describe that revision's fixture. The current fixture also
tests nested channel queues; its new checks do not update these historical sizes
or establish a speed comparison.

At shutdown, allocation/free-ledger totals and count entries must return to at
most the initialized baseline. Omitting task-state cleanup leaves 16 buffers /
2,048 bytes; omitting scheduler shutdown leaves 67,109,088 bytes, mostly 64 pooled
1 MiB task stacks. Both controls fail as required. The report inspects 72 modules,
including 32 broken controls, and retains exports, section sizes and hashes:

| Same task program, ordinary O2 build | Module file bytes | Code-section bytes |
|---|---:|---:|
| JSPI | 577,618 | 366,064 |
| Asyncify | 724,240 | 522,427 |

Asyncify adds 25.4% file bytes and 42.7% code bytes for this program. Names are
included in both. No elapsed-time or C/Rust comparison was collected.
Ordinary modules initially declare 32.0625 MiB memory; instrumentation adds
256 KiB static storage. Each task requests 1 MiB stack, with up to 64 completed
stacks pooled until cleanup. Asyncify also grows a 16 MiB-plus-one-page workspace.
Freed blocks are reusable but WebAssembly memory capacity does not shrink.
JavaScript promises, stacks, strings and host RAM are outside these counters.
Use `suite=wasm-hosts`; [PR #164](../roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records production acceptance.
