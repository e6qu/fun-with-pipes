# PR #269 whole-program benchmark snapshot

These are retained results, not new timing runs. The
[benchmark overview](../../benchmarks.md#recorded-whole-program-snapshot-pr-269)
explains the inputs, unequal work and limits of the comparisons.

| Identity | Value |
|---|---|
| Tested source | `e7965762490c89d2a39f5937fe8322291ea906fc` |
| Production job | [128553982216](https://github.com/e6qu/fun-with-pipes/actions/runs/42422580747/job/128553982216) |
| Original artifact | `13594660994`, 23,783,750 bytes |
| Archive SHA-256 | `e68678b73397b902990d396fa082e2356d042af486e64bd02e1ff8a04a1f7cd1` |
| Host | Linux AMD64, EPYC 7763 |
| Compilers | GCC 15.2.0, Rust 1.99.1 |

The downloaded archive digest matches [GitHub metadata](artifact.json). Files
below are extracted unchanged; the complete archive includes generated sources
and binaries. [The production audit](../computed-numeric-delivery-2026-11-08/README.md)
records the full job/log checks.

- [Elapsed times](bench.md): one warmup and six rotated whole-process samples;
  includes startup, input construction, work, output and cleanup, excludes compilation.
- [Arithmetic controls](bench-controls.json) and [peer controls](bench-peer-controls-report.json):
  output equivalence and deliberate incorrect implementations.
- [Memory results](bench-memory-report.json): three fresh-process RSS samples per
  executable; separate fwp allocation/retain profiles and deliberate leaks.
- [Memory input identity](bench-memory-inspection.json): measured files and hashes.

There are no identical-copy controls or second independent timing session in
this production snapshot. It locates questions for further work; it does not
qualify a speedup or universal language-overhead claim. Managed storage excludes
raw runtime buffers, allocator metadata, stacks and peer allocations.
