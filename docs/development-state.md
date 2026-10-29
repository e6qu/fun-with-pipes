# Next: implement N1's four kernel baseline cases

**Next:** implement the [frozen kernel protocol](measurements/kernel-baselines.md)
without changing compiler/runtime optimizations. Inspect all callers of the old
numerical runner before replacing its implicit small-only configuration. Add
complete-result and cleanup controls; use GitHub for native compilation and
measurements. No second PR while #227 is active.

Worktree `/private/tmp/fwp-kernel-baselines`, branch `numerical-kernel-baselines`,
based on #227 final head `56528ffb`. The active delivery is still #227 in
`/private/tmp/fwp-ad-captures`; monitor native `40901634818`, docs `40901634737`
and G2 `40901630875`. Merge only after all gates pass and full logs are audited.
Its handoff owns final D2 delivery. Merge main here after that verified merge.

N1 protocol adds 262,145 array elements and 257×259 by 259×255 matrices to the
existing small cases. It keeps eight calculation rounds, ordered arithmetic and
separate kernel/allocation-inclusive/process timers. Four labels include a
byte-identical fwp control. Two independent sessions per matching native host,
all outputs, memory and code/stack evidence are required before choosing N2.

The old runner is called by the solvers, library, performance and iteration
workflow jobs. Source-rewriting experiments consume its emitted C and reports;
update affected callers together rather than adding compatibility paths.
Historical numerical prose now names all four old labels: C, Rust, tracing fwp
and ARC fwp. Source a3d8f16e verifies eight four-label batches, forty samples per
label. The current three-label runner has six batches. No observation changed.

`scripts/numerical-baselines.py` implements the exact integer result oracle and
balanced process schedule. Four small-input control tests pass through the local
guard. An initially overstrict test assumed cross-round predecessor counts were
balanced; only the declared within-round pairs have that guarantee. The corrected
test checks fifteen occurrences of each within-round pair and the protocol keeps
the boundary limitation explicit. No measurements or acceptance limits changed.

No compiler change, native build or new measurement has run for N1. Guard limits
stay unchanged. Current #227 evidence is already audited as documented there.
No subagents. Local work remains serial; full builds/suites/benchmarks on CI.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | #227 final D2 delivery; D1/D3 verified |
| 6 | In progress | N1 baselines before N2 optimization |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |
