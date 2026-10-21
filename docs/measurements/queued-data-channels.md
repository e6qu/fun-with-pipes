# Checking callbacks that retain data queues

Automatic reference counting (ARC) releases shared storage when its last owner
finishes. Tracing collection instead finds live objects by following references.
The `--gc arc` mode uses reference counts without a tracing collector.

A queued callback is a function saved in a channel for a later call. That function
can keep another queue alive. Checked `--gc arc` now accepts this when the captured
queue comes from `channel.make`, stores data without functions, and has proved
nested owners. Unknown or native queue producers remain rejected as captures.
The [ownership guide](../ownership.md#functions-stored-in-channels) explains the
rule with a complete example that prints `Some "hello"`.

These are correctness and cleanup checks against fwp's raw interpreter, not a
speed benchmark or a comparison with C/Rust. They do not measure retain/release
traffic or total-process memory. Default execution still includes tracing.

## Programs and counters

The [fixture](../../tests/fixtures/queued_data_channels.fwp) repeats 64 rounds.
It tests delivery and repeated reads, shared aliases, records, lists, nested data
queues, empty captures, undrained and closed queues, caught errors, blocked sends
and cancellation. Successful execution prints `data queues released` once.

Native tests compare ARC and tracing at O0/O2 on Linux, macOS and Windows, each on
ARM64 and AMD64. Test-only counters inserted into generated C require at most 64
live queue objects, at least one created queue, and none remaining at teardown.
ARC must also return all managed allocator charges and run no tracing collections.
Tracing controls enable collection stress, collection verification and reuse
verification. These counters exclude storage owned by external libraries and the
operating system.

A deliberately broken ARC program omits release of queued values. Captured data
queues then accumulate; the 64-live-queue limit must detect this with exit 198.
This control runs at both native optimization levels. All 24 native binaries have
matching architecture, output, generated C and disassembly. ARC excludes collector
scan/mark/sweep routines; tracing controls retain marking.

## WebAssembly execution

Node 24 runs the fixture on Linux ARM64 and AMD64, using both WASI (the WebAssembly
system interface) and the browser loader. Each uses JSPI or Asyncify to suspend
and resume asynchronous work, at O1/O2. These are alternative execution modes,
selected explicitly by the test.

Each combination runs four modules: ordinary, measured, missing scheduler cleanup
and missing queued-value release. That is 32 modules per host. The measured module
checks physical allocations, bytes and reference-count table entries against the
entry baseline. Ordinary and measured modules must succeed; both deliberately
broken variants must exit 244. Every variant must print the expected result.

The report records module hashes, saved C and successful-run symbol listings;
collector routines are absent. It does not claim a separate local WebAssembly
disassembly audit or execution in an actual browser engine.

## Reproduce and inspect

Dispatch `.github/workflows/numerics.yml` with `suite=channel-proof` and
`native_runner=all`. The [report](queued-data-channels-2026-10-21.json) records the
exact compiler source, eight jobs, artifact digests, native compilers and inspected
outputs. All completed logs were audited. Full production acceptance remains a
separate requirement recorded in the [handoff](../development-state.md).
