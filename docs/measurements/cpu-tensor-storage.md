# CPU tensor output storage

Historical results; reproduce with the recorded revisions, not current main.
[Measurement terms](../benchmarks.md) explain the costs;
[PLAN.md](../../PLAN.md) tracks current work.

**Comparison:** previous versus direct-output fwp executors, with only that runtime
section replaced in the control. **Work:** multiply 8,193 F64 values (their indices)
by 0.5; check every result and the ordered sum. Input construction is outside the
counter interval. The [six-host report](owned-values-and-kernels-2026-10-16.json)
measures allocation/cleanup, not time or overhead against C/Rust.

| Elementwise output cost | Previous executor | Prepared executor |
|---|---:|---:|
| Temporary native allocation requests | 3 | 2 |
| Peak temporary native bytes | 69,648 | 4,104 |
| Managed result-array requests | 1 | 1 |
| Native storage remaining after the call | 0 | 0 |

Writing directly into the result removes a 65,544-byte temporary and its full
copy. Input-pointer tables, workspace and the result remain. Separate peaks for
four workers cannot be added into a simultaneous peak. Native counters exclude
managed results, allocator metadata, thread stacks and process resident memory.
Actual ARC binaries use packed double multiplication but still load/store
workspace and copy completed chunks. [PR #153](../roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records acceptance.
