# Stack use when releasing wrapped chains

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

**Comparison:** recursive wrapper cleanup in `70e36523` versus loop cleanup in
`aea7d6df`. Each record owns a five-byte string and an optional next record; a
second shape adds a tuple/string wrapper. Test 64/1,024/16,384 links with aliases
to the root, middle record or wrapper, then release every owner. Tracing is off.

The [six-host report](wrapped-chain-cleanup-2026-10-17.json) samples
a stack address at each cleanup entry. The span between highest/lowest addresses
measures growth, not total stack storage; instrumentation can change frame sizes.
O2 results:

| Native target | Previous span, 64 links | Previous span, 1,024 links | Largest new span, through 16,384 links |
|---|---:|---:|---:|
| Linux AMD64 | 2,048 | 32,768 | 16 |
| Linux ARM64 | 3,072 | 49,152 | 32 |
| macOS ARM64 | 4,096 | 65,536 | 0 |
| macOS AMD64 | 3,072 | 49,152 | 0 |
| Windows AMD64 | 4,096 | 65,536 | 0 |
| Windows ARM64 | 3,072 | 49,152 | 0 |

All measured allocations free. Restoring recursive cleanup must exceed the stack
bound. Ordinary Linux binaries show cleanup loops with fixed 24-byte AMD64 and
64-byte ARM64 frames, excluding callees and the AMD64 incoming return address.
Zero sampled span means the address stayed fixed, not zero stack use. The report
also retains O1 results, hashes and candidate toolchains; baseline environment
metadata is only in CI logs. No elapsed time or C/Rust comparison was collected.
Use `suite=chain-cleanup` and `scripts/collect-chain-measurements.py`.
