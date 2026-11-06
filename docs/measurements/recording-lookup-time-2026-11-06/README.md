# Recording lookups: runtime results

**Fewer lookups do not establish a speed improvement.** All 32 long-case results
miss the frozen 5% speedup target. ARM64 ranges from 0.14% slower to 2.33% faster;
AMD64 current-result cases are 1.13–3.90% slower. AMD64 history ranges from 0.40%
slower to 1.80% faster. Keep the verified lookup reduction under the agreed policy,
with these timing goals open. No limit changed and no completed session reran.

All four complete evidence audits pass. Small-case regression, identical-copy,
allocation, cleanup and reported stack limits pass. The separate
[compiler-cost report](../recording-lookup-analysis-2026-11-06/README.md) retains
one inconclusive copy-control result; it does not claim that time bound passed.

## What was measured

Programs minimize the Rosenbrock function using automatically computed derivatives.
The candidate and reference come from `31c04650527d7a3c9efdd63bd5b4eae8a15d5732`.
Only bounded tape lookup reuse is disabled in the reference; both keep every
previous optimization. The [frozen contract](../recording-lookups.md) describes
the proof and exact comparison.

- Two independent sessions each on Neoverse-N2 ARM64 and EPYC 7763 AMD64.
- GCC O2, explicit native target, no fast math/contraction/LTO. GCC 13.3 on ARM64,
  15.2 on AMD64; Rust 1.99.1, opt-level 2, overflow checks, one codegen unit,
  generic target CPU and LTO off. Full commands remain in each report.
- Two warmups and 98 balanced rounds. Each sample totals **seven fresh processes**,
  including startup, all solves, output and teardown. Compilation, output checking,
  file writes by the driver and instrumented profiles are outside the timer.
- Coordinates / updates / solves per process: 3/0/32768, 3/1/512, 3/199/32,
  3/1999/4, 33/199/32, 129/199/8. Each solve restarts from the original inputs.
  Zero-update cases include construction and output; they are not pure startup tests.
- Current returns final coordinates. History expresses successive values and selects
  the last; unused history can be optimized away. Neither form changes the objective.
- Every output matches its own checked executable reference exactly and the common
  analytic result within absolute/relative tolerance 1e-10. The schedule balances
  positions and cyclic predecessors over 49 rounds; round boundaries are not perfectly
  balanced. All original orders and samples are retained.

## Candidate / reference elapsed time

Below 1 is faster: `0.9800` means 2% less elapsed time. Long cases require at most
`0.95`; zero/one-update cases permit at most `1.02`.

| Coordinates / updates, form | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 current | 1.0013 | 1.0016 | 0.9939 | 0.9955 |
| 3 / 0 history | 1.0002 | 1.0012 | 0.9977 | 0.9853 |
| 3 / 1 current | 0.9981 | 1.0005 | 1.0083 | 1.0173 |
| 3 / 1 history | 0.9972 | 0.9996 | 1.0081 | 1.0158 |
| 3 / 199 current | 0.9875 | 0.9900 | 1.0113 | 1.0269 |
| 3 / 199 history | 1.0011 | 0.9977 | 1.0026 | 0.9923 |
| 3 / 1999 current | 0.9996 | 0.9870 | 1.0275 | 1.0308 |
| 3 / 1999 history | 1.0014 | 0.9970 | 1.0040 | 0.9826 |
| 33 / 199 current | 0.9807 | 0.9797 | 1.0198 | 1.0240 |
| 33 / 199 history | 0.9773 | 0.9778 | 0.9850 | 0.9820 |
| 129 / 199 current | 0.9817 | 0.9819 | 1.0210 | 1.0390 |
| 129 / 199 history | 0.9767 | 0.9767 | 0.9918 | 0.9929 |

Every session misses eight long-case targets. The largest small-case slowdown is
1.73%; identical executable copies differ by at most 1.48% (both limits: 2%).
The [memory/work census](../recording-lookup-census-2026-11-06/README.md) confirms
8→3 lookups per pair/update, unchanged parent/capacity checks and nodes, unchanged
allocation/live-storage costs, zero final storage and no larger reported frames.
[The C/Rust comparison](peer-costs.md) includes process memory and code size.

## Evidence

| Sessions | Original run | Complete audit | Records |
|---|---|---|---|
| ARM1/2; two rejected AMD hosts | [42136888829](https://github.com/e6qu/fun-with-pipes/actions/runs/42136888829) | [42139232314](https://github.com/e6qu/fun-with-pipes/actions/runs/42139232314) | [index](run-42136888829/summary/index.json) |
| Two rejected AMD hosts | [42137525746](https://github.com/e6qu/fun-with-pipes/actions/runs/42137525746) | [42138966228](https://github.com/e6qu/fun-with-pipes/actions/runs/42138966228) | [index](run-42137525746/summary/index.json) |
| AMD1; one rejected AMD host | [42137772065](https://github.com/e6qu/fun-with-pipes/actions/runs/42137772065) | [42140277966](https://github.com/e6qu/fun-with-pipes/actions/runs/42140277966) | [index](run-42137772065/summary/index.json) |
| AMD2 | [42138616667](https://github.com/e6qu/fun-with-pipes/actions/runs/42138616667) | [42141026225](https://github.com/e6qu/fun-with-pipes/actions/runs/42141026225) | [index](run-42138616667/summary/index.json) |

The five rejected hosts failed qualification before building or timing. Their
records remain in the [four-session index](sessions.json). Qualified sessions ran
once. Every run directory retains the original reports, complete logs, hashes,
artifact identities and compressed native evidence. Complete artifacts were audited
on GitHub; downloaded archive digests and combined report identities were checked
locally. Audit success verifies the evidence, not the missed performance targets.

## Next diagnostic

Compare the saved candidate/reference source paths for the added per-worker state,
ID comparison and pointer selection, including ordinary NULL-state calls. Account
for their executed work before proposing another transformation. The count audit
alone does not establish which operation causes AMD64's slowdown. Preserve these
samples; do not infer a repair from instruction layout or rerun for passing numbers.
