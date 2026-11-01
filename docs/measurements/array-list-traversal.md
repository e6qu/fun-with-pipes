# Reading numeric arrays without a temporary list

This change was delivered in [PR #236](../roadmap-history.md#local-names-and-allocation-optimizations-pr-236). Allocation and
cleanup checks pass on three native hosts. The latest four whole-solve sessions
retain one failed identical-copy timing control, so combined timing acceptance
remains open. The [handoff](../development-state.md) records current
verification; the rejected observations remain below.

An array stores elements contiguously. A list stores a head and a link to the next
cell. Converting an array to a list before immediately mapping or folding it can
therefore allocate storage that the calculation does not need:

```fwp
total : Array[F64] -> F64
total = array.to-list | map (mul 3.0) | fold add -0.0
```

This multiplies each element by three and adds the results from left to right,
starting at negative zero. Direct traversal can remove both temporary lists.
It must keep that arithmetic order. It cannot reassociate the sum, contract
multiplication with addition, or stop before an eager stage's first failure.

The compiler uses its existing typed loop and callback proof. Known numeric
map/filter stages can read the array directly; unsupported callbacks retain
their existing implementation. Retained inputs and slices keep their owners.
Effectful stages, distinct possible traps and early stopping keep the existing
fusion restrictions.

For a returned list, callbacks proved total, pure and free of owned captures may
visit elements backward and prepend results directly in source order. This avoids
copying a reversed list. Folds and possibly trapping callbacks retain forward
order. No new language syntax or runtime primitive is introduced.

## Gradient results

Reverse-mode AD records operations, traverses their dependencies backward and
returns one derivative per input. `rev._backward-float` currently obtains an F64
array, converts it to a list, then maps `float.convert` to the requested format.
Direct traversal removes the first list. The conversion remains: narrower
formats round, and NaNs must retain the supported conversion behavior.

The runtime phase observer measures tape setup, forward work with recording,
reverse setup, reverse traversal, result-array construction and tape retirement.
The final list/conversion happens **after** those phases. Whole-solve and
allocation comparisons include it; none of those six phase clocks isolates it.
Forward time also includes the objective and temporary values, not just recording.

## Counts and correctness

`numeric_array_fusion` supplies dynamic arrays of 0, 1, 129 and 4,096 elements,
ordinary/sliced inputs, retained aliases and packed/word storage. At O1/O2 it
compares one compiler with `FWP_ARRAY_FUSION=1` and `0`. A returned mapped or filtered list
must remove at least one allocation and 24 requested bytes per element. A scalar
fold must allocate no element list. Every element and input alias is checked;
live storage and cleanup records must return to their initial state.

Separate raw-interpreter/native controls cover rounding, signed zero, infinities,
NaNs, reused lists, callback output, distinct traps and early stopping. Existing
AD checks cover nested gradients, capacity, stale nodes, failure, cancellation,
workspace reuse and physical release. A count reduction does not establish speed.

## Whole-solve comparison

Run `array-list-measurements` on native Linux ARM64/AMD64, two sessions each.
Record the actual CPU and toolchain before building. Require four available CPUs;
CPU models may differ between sessions. Each candidate/reference comparison is
within one host, with the same compiler and flags. These sessions do not replace
the older matching-host [D2](descent-costs.md) or [N1/N2](kernel-baselines.md) rules.

Use GCC O2, the architecture baseline, no LTO, no fast math and no contraction.
C/Rust compute explicit derivatives, so their ratios include different algorithms.
Seven labels cover AD current/history with fusion on/off, an identical candidate
copy, C and Rust. The off setting disables all numeric array fusion, including
formatting: whole-solve differences cannot be attributed solely to gradient lists.
The direct boundary probe above establishes the narrower allocation claim.

| Coordinates | Updates | Solves per process |
|---|---:|---:|
| 3 | 0 | 32,768 |
| 3 | 1 | 512 |
| 3 | 199 | 32 |
| 3 | 1,999 | 4 |
| 33 | 199 | 32 |
| 129 | 199 | 8 |

Use two warmups and 49 measured rounds, seven processes per label/round, seed
20261101. The existing balanced 49-entry cycle supplies the complete retained
order. Time includes launch, repeated complete solves, full output and cleanup;
compilation and verification are outside it. Check every coordinate against the
analytic oracle at absolute/relative tolerance 1e-10 and require repeatable output.
Run the phase observer separately in twelve alternating pairs after two warmups;
report its effect on total time. Keep profiles and RSS separate from timing.

Require candidate/reference time at most 1.02 and identical-copy variation at
most 2%. Require at least one fewer 24-byte cell per input per gradient, no extra
retains/peak charge, identical raw tape storage and zero final storage. Preserve
the existing comparison's +1,024 instruction-byte and +128 static-frame-byte
screens. These are measurement requirements, not universal runtime guarantees.
Save all failing/noisy cases, sources, binaries, commands, profiles and samples.
Never retry unchanged cases or relax limits to obtain acceptance.

## First candidate: output reversal still copied

At `dc0a6407`, the direct fold meets zero-allocation requirements. The returned
mapped list fails the frozen savings rule: at length 129 it allocates 258 cells
versus 259 allocation requests in the reference (6,192 versus 7,232 requested
bytes). The input list is gone, but generated C calls the borrowing `reverse`
primitive, which copies the newly built result.

Length one saves only 16 bytes.
Word-array correctness/alias/cleanup and all separate AD tests pass in run
`41252379702`. The first cost assertion stopped that probe before packed arrays;
it did not establish packed-slice cleanup. Both original session-2 timing jobs
completed: timing, copy, raw-tape and cleanup checks pass, but both list forms
fail allocation/byte limits in all five cases with updates. The zero-update
control passes. Preserve these failed allocation observations.

The repair uses backward traversal only under the total-callback proof above.
Original limits remain unchanged. The probe now
collects all cost failures across both storage modes before reporting them.

At `9a2e954e`, all word-array cases meet the count limits at O1/O2. Packed-array
verification exposes a probe error at length 129: it physically frees a slice
header without releasing its backing owner. The repair calls an exported typed
`Array[F64] -> ()` destructor for both inputs.

This is a test ownership repair;
neither the cleanup assertion nor the allocation limits are relaxed. At `a33c8ba9`,
run `41254567543` passes all word/packed cost checks on Linux ARM64/AMD64 and
macOS ARM64, including offset slices, aliases and cleanup. Full platform integration
on the combined compiler passed in [PR #236](../roadmap-history.md#local-names-and-allocation-optimizations-pr-236).

Both session-2 jobs in run `41253549233` pass for `9a2e954e`: all six whole-solve
cases meet the frozen time, copy, allocation, tape, peak-memory and code/stack
limits. This establishes one observation per architecture, not the required two.
Session 1 stopped at the packed-slice probe before timing. The newer source-stage
change also needs its own measurements; old results are not relabeled as its runs.

At `9d47a5fc`, run `41256205285` completes both sessions per architecture.
Both ARM64 sessions and AMD64 session 2 meet every limit. AMD64 session 1 passes
all correctness, cleanup, allocation, raw-tape, phase and copy controls, but its
zero-update history case takes 1.023851 times the reference time (2.39% slower),
exceeding the 2% limit.

The combined timing acceptance therefore remains open.
This is a recorded rejected timing result, not a reason to repeat unchanged runs
or relax the budget. The next source change repairs pure-constructor specialization;
its own cost and timing evidence must be identified separately.

## Constructor repair: cost reduction retained, timing acceptance open

At `f7f5309c`, run `41258782085` completes four sessions after restoring known
pure-constructor specialization. Both ARM64 sessions and AMD64 session 1 pass.
Hosts are ARM Neoverse-N2 with GCC 13.3 and AMD EPYC 7763 with GCC 15.2,
both with four available CPUs and Rust 1.99.1.

These are the recorded toolchains;
old runs on different hosts or compilers are not relabeled as these sessions.
AMD64 session 2 passes every candidate/reference, allocation, correctness and
cleanup limit, but identical candidate copies differ by **2.1023%** in the
3-coordinate/1,999-update case, exceeding 2%.

Keep the cost reduction; the combined
timing result remains inconclusive. This does not erase the earlier rejected
zero-update timing or complete D2/N1/N2. All four full logs are audited.

The table describes **current-result AD**, which keeps the latest vector instead
of its history. Each value is elapsed time with fusion divided by the named
comparison's time; below 1 is faster. Ranges show the two observed sessions,
not confidence intervals. Every ratio compares programs on the same host.
C/Rust use explicit derivatives; these large gaps include recording, temporary
values and different representations, not just compiler overhead. The
[explicit-fwp baseline](descent-costs.md#initial-single-process-results) separates
some of that algorithmic difference at its own recorded revision.

| Architecture | Coordinates / updates | Fusion on / off | fwp / C | fwp / Rust |
|---|---|---:|---:|---:|
| ARM64 | 3 / 0 | 1.003–1.004 | 1.830–1.830 | 1.735–1.751 |
| ARM64 | 3 / 1 | 0.994–0.996 | 6.662–7.254 | 5.663–6.235 |
| ARM64 | 3 / 199 | 0.944–0.949 | 8.944–10.406 | 7.572–8.808 |
| ARM64 | 3 / 1,999 | 0.938–0.940 | 10.472–12.073 | 8.937–10.301 |
| ARM64 | 33 / 199 | 0.949–0.949 | 40.009–41.401 | 37.416–39.042 |
| ARM64 | 129 / 199 | 0.949–0.950 | 39.385–39.610 | 39.064–39.408 |
| AMD64 | 3 / 0 | 0.981–0.987 | 2.290–2.353 | 1.460–1.484 |
| AMD64 | 3 / 1 | 0.968–1.005 | 7.763–8.034 | 5.542–5.807 |
| AMD64 | 3 / 199 | 0.959–0.960 | 10.049–10.171 | 8.587–8.635 |
| AMD64 | 3 / 1,999 (copy control fails) | 0.961–0.978 | 11.704–11.863 | 10.149–10.369 |
| AMD64 | 33 / 199 | 0.951–0.954 | 46.057–47.292 | 43.860–44.929 |
| AMD64 | 129 / 199 | 0.953–0.955 | 48.815–50.391 | 45.871–47.863 |

For example, the 129-coordinate ARM64 case takes about 5% less time with fusion,
but still about 39.5 times the explicit C program's time. Removing this list is
one measured improvement; it does not establish close-to-C derivative performance.

### Memory for 129 coordinates and 199 updates

Each process performs eight complete solves and prints every final vector.
The managed counters below agree across both sessions and architectures. They
count generated allocation/retain requests, not live objects or malloc calls.
The fusion control changes all eligible numeric array paths; these whole-solve
differences are not attributed only to gradient-list construction.

| fwp form | Allocation requests | Requested bytes | Retains | Peak managed charge |
|---|---:|---:|---:|---:|
| Current result, fusion on | 2,275,114 | 69,118,816 | 1,434,400 | 30,336 bytes |
| Current result, fusion off | 2,483,666 | 75,741,536 | 1,434,400 | 30,336 bytes |
| Full history, fusion on | 2,278,322 | 69,208,480 | 1,437,600 | 845,344 bytes |
| Full history, fusion off | 2,486,874 | 75,831,200 | 1,437,600 | 845,344 bytes |

Fusion removes 208,552 requests and 6,622,720 requested bytes per process here;
it does not reduce retains or peak managed charge. Separate raw derivative
buffers peak at 33,904 bytes in every form. Managed and raw final storage are
both zero. Do not add their separately observed peaks or equate requested bytes
with simultaneously live memory.

Whole-process peak RSS for current-result fwp is 1,945,600–2,002,944 bytes on
ARM64 and 2,367,488–2,371,584 on AMD64. C is 1,413,120–1,417,216 and 1,581,056
respectively; Rust is 1,675,264–1,802,240 and 2,293,760–2,363,392. RSS includes
runtime/code pages and stacks and is sampled separately from the counters.
The [Swift profiles](swift-allocations.md) compare different pipeline/map programs;
they are not a Swift AD implementation of this descent.

## Independent audit and retention

`check-array-list-evidence.py` reads saved evidence without executing binaries.
It recomputes all process totals, medians, ratios, allocation limits and timing
failures, checks the six analytic outputs and reconciles raw profiles, phase
observations, RSS, stack reports and binary/source hashes. It reads ELF section
headers to verify native architecture and actual instruction bytes. A failed
acceptance rule remains in the audit output; a complete rejected experiment is
different from an incomplete or corrupted record.

Dispatch `array-list-report` with the measured run/source and explicit sessions.
For the two original runs above, select session `2`: session `1` has no completed
timings and its failed probe artifacts/logs remain in the archive. For final
acceptance, select `both` and require all four reports. The archive preserves raw
files and job identities, including failures. The
[first AMD64 report](array-list-first-2026-10-31-amd-2.json.gz) also exercises the
auditor's rejection controls: all twenty original allocation failures must remain.

The raw records are retained in the repository:

| Source / tag | Archive | Independent audit | Recorded decision |
|---|---|---|---|
| `dc0a6407`, `roadmap/array-lists-first-2026-11-01` | [Original](array-lists-dc0a6407.tar.xz) | `41257190382` | Twenty allocation/byte failures on each host |
| `9a2e954e`, `roadmap/array-lists-repaired-2026-11-01` | [Repaired](array-lists-9a2e954e.tar.xz) | `41257193865` | Both session-2 hosts meet all limits; session 1 stopped before timing |
| `9d47a5fc`, `roadmap/swift-allocations-2026-11-01` | [Four complete sessions](array-lists-9d47a5fc.tar.xz) | `41258487184` | Three pass; AMD64 session 1 retains one timing rejection |
| `f7f5309c`, `roadmap/array-lists-pure-constructors-2026-11-01` | [Constructor repair](array-lists-f7f5309c.tar.xz) | `41260368842` | Three pass; AMD64 session 2 retains one copy-control rejection |

The archives retain failed probe records, original job logs, generated C,
executables, raw process/phase samples and the independent file-hash/decision
audit. The first two SHA-256 values are respectively
`0fb471b4743980b3c5a886513fa273cd9e8042d40282e62e80715b24a493a293` and
`a83aa024e11318cb2f65af151ec70271089b0449226f8093408ae0761e22c607`.
The next two archives are
`095c3ff58d5901c31cd94f26ac3309eaa1c05c652d063460689793d866ce884c` and
`fe662ed86f19b06476c1806ba47c0843aaf4463dcc8fcea9dc59f626769e087d`.
Documentation checks stream the archives, verify their immutable source tags and
recompute each report's costs/decision. The full directory audit above also
reconciles raw files; it runs separately on GitHub rather than rerunning programs.
