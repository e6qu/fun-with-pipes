# Type-tree copies during compilation

**Both hosts count the same work and preserve generated C.** These counts select
an investigation into borrowing during type checking; they are not a speedup
or an allocation-byte measurement. [The contract](../compiler-type-walks.md)
explains the two traversals and freezes correctness, timing and memory limits.

Source `35a12dfee0266134237d03d1262649be69df7c41`, tag
`roadmap/compiler-unwind-diagnosis-2026-11-10`.
[Run 42758033441](https://github.com/e6qu/fun-with-pipes/actions/runs/42758033441)
passes on native Linux AMD64 (`129636888892`) and ARM64 (`129636889101`). Each
builds ordinary and counted release compilers, then compiles the four unchanged
applications to identical C. GCC and the applications do not execute here.

| Application | All cloned type nodes | During unresolved-variable search | During resolved-type substitution |
|---|---:|---:|---:|
| Word counting | 3,470,860 | 803,588 | 468,528 |
| Numerical tutorial | 3,607,944 | 806,600 | 470,863 |
| Queued callbacks | 3,520,000 | 809,884 | 471,125 |
| HTTP API | 3,766,770 | 809,097 | 471,081 |

For example, searching `a -> List[a]` only needs to return `[a]`; copying its tree
is unnecessary. Substituting `a = I64` needs the result `I64 -> List[I64]`, but
can read the original tree while creating that result. The candidate will remove
temporary copies in these walks while keeping variable order, normalized types,
row behavior, effects and diagnostics unchanged. Row flattening stays unchanged
in this first candidate, so some traversal copies will remain.

These counters cover compilation on its worker thread. Each cloned `Type` node
counts once; strings and vector buffers are not separately counted. Active-walk
categories can overlap if nested and must not be assumed disjoint. Counts include
later compiler stages too, not only library checking. Instrumented times do not
measure ordinary compiler speed. The remaining AMD64 CPU-unwind failure does not
invalidate these independent counters or establish where CPU time went.

`arm/` and `amd/` retain summaries, identities, source/build settings and observer
patches. Both full job logs are retained as gzip and contain no unexpected
diagnostics. `counts.json` preserves the exact common counts, including visit
counts; `artifacts.json` names the larger CI archives and expiration dates.
`files.json` records retained hashes. Selected ZIP members passed CRC; archive
digests are GitHub metadata. The two observer patches have identical verified
hashes and modify only the diagnostic checkout.

The observation script's console labels accidentally used the last checking-group
name for every application. Its JSON keys, input hashes, C comparisons and counts
are correct. Rename that loop variable in the next change; preserve these
original logs. No measurement rerun is needed to correct a display label.
