# Shared CPU reader preserves the compiler results

The service profiler reuses the compiler's stack decoder. Replaying the saved
compiler recordings on native Linux ARM64/AMD64 produces **exactly the previous
attribution rows, sample counts, periods and unresolved-frame counts** for all
four applications. No compiler was rebuilt and no timing experiment was repeated.

| Host | Words / numerical / callbacks / HTTP samples | Job | Artifact |
|---|---|---|---|
| ARM64 | 261 / 545 / 342 / 1,119 | `129684008878` | `13742824306` |
| AMD64 | 307 / 628 / 397 / 1,306 | `129684008607` | `13743955194` |

[Run 42772707168](https://github.com/e6qu/fun-with-pipes/actions/runs/42772707168)
uses reader source `fac4a47440fb02667ddbf385dba959ae8f91a310`, retained by
`roadmap/service-cpu-observation-2026-11-10`. The recordings come from
`42761474854`, source `5cab084d51b0b285a742c50b441f875bcdaa2933`.
[The previous verified replay](../compiler-cpu-samples-2026-11-10/README.md)
retains the original profiler repairs and limitations.

The compact summaries and complete job logs are retained under [file hashes](files.json).
Selected ZIP members passed CRC checks; [artifact identities](artifacts.json)
record the original archive digests. Local comparison checks every attribution
row, not only the totals in [comparison.json](comparison.json). Both complete
logs contain no unexpected diagnostic. No empty stacks occurred; many stacks
still contain an unnamed caller. That does not make their leaf operation unknown.

This verifies extraction of the shared reader. It does not establish a service
speedup or complete service attribution; see [the service protocol](../service-cpu-costs.md).
