# Scalar append inlining: runtime results

Long solves use **2.26–8.12% less elapsed time** than the same-source reference.
Thirteen of 32 long-case results meet the frozen 5% target; **19 remain open**.
Small-case regression and identical-copy limits pass: their largest observed
ratios are 1.01533 and 1.01427 (limit 1.02). No qualified session was repeated.

All three complete runtime audits pass. [Memory/work checks](../recording-inline-census-2026-11-06/README.md)
find unchanged allocation, live storage, retains and validation/node counts, with
zero final tracked storage. The [compiler-cost comparison](../recording-inline-analysis-2026-11-06/README.md)
retains its separate inconclusive AMD64 copy control. Verified improvements do
not close an earlier comparison or turn missed limits into passes.

## What was measured

Programs minimize the Rosenbrock function using automatically computed derivatives.
The candidate forces the checked scalar append body inline; the reference changes
only that declaration back to `static`. Both retain lookup reuse and every earlier
optimization. See the [frozen contract](../recording-inline.md).

- Two sessions each on Neoverse-N2 ARM64 and EPYC 7763 AMD64.
- GCC O2, explicit native target, no fast math/contraction/LTO; GCC 13.3 on ARM64
  and 15.2 on AMD64. Rust 1.99.1, opt-level 2, overflow checks, one codegen unit,
  generic target CPU, no LTO. Full toolchain versions/commands are retained.
- Two warmups, then 98 balanced rounds. Each sample totals **seven fresh processes**,
  including startup, solves, output and teardown. Compilation, driver output
  checking/file writes and instrumented profiles are outside the timer.
- Coordinates / updates / solves per process: 3/0/32768, 3/1/512, 3/199/32,
  3/1999/4, 33/199/32, 129/199/8. Every solve restarts from the original input.
- Current returns final coordinates. History expresses successive values and
  selects the last; unused history can be optimized away. Workloads are identical.
- Each output matches its checked executable reference exactly and the analytic
  result within absolute/relative tolerance 1e-10. Schedules balance positions and
  cyclic predecessors over 49 rounds; round boundaries are not perfectly balanced.
- ARM source `7dba6db7010af483f9d694b78e10cf71df2653a3`; AMD source
  `1c6ee1efb7d45d952829d9e5e326aceb11bd32cb`. Only evidence/docs changed between them;
  production trees, benchmark sources and recorded source hashes match.

## Candidate / reference elapsed time

Below 1 is faster: `0.92` means 8% less time. Long cases require at most `0.95`;
zero/one-update cases permit at most `1.02`.

| Coordinates / updates, form | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 current | 1.0146 | 1.0153 | 1.0120 | 1.0091 |
| 3 / 0 history | 0.9917 | 0.9914 | 1.0087 | 1.0125 |
| 3 / 1 current | 0.9956 | 1.0008 | 0.9866 | 0.9758 |
| 3 / 1 history | 1.0001 | 1.0014 | 0.9961 | 0.9903 |
| 3 / 199 current | 0.9693 | 0.9658 | 0.9656 | 0.9556 |
| 3 / 199 history | 0.9631 | 0.9640 | 0.9774 | 0.9748 |
| 3 / 1999 current | 0.9772 | 0.9757 | 0.9535 | 0.9552 |
| 3 / 1999 history | 0.9597 | 0.9644 | 0.9743 | 0.9739 |
| 33 / 199 current | 0.9263 | 0.9261 | 0.9199 | 0.9242 |
| 33 / 199 history | 0.9251 | 0.9246 | 0.9621 | 0.9500 |
| 129 / 199 current | 0.9232 | 0.9228 | 0.9233 | 0.9188 |
| 129 / 199 history | 0.9217 | 0.9228 | 0.9534 | 0.9543 |

Both architectures miss all 16 three-coordinate long-case targets. AMD64 history
also misses 33/199 in session 1 and 129/199 in both sessions. All other long cases
meet 5%. The rounded `0.9500` for AMD2 33/199 history is below 0.95 in the retained
full-precision result. [C/Rust comparison and memory/code costs](peer-costs.md)
explain the remaining complete-program gap and the peers' different algorithms.

## Evidence and repair

| Sessions | Original run | Complete audit | Records |
|---|---|---|---|
| ARM1/2; two rejected AMD hosts | [42162092035](https://github.com/e6qu/fun-with-pipes/actions/runs/42162092035) | [42164603033](https://github.com/e6qu/fun-with-pipes/actions/runs/42164603033) | [index](run-42162092035/summary/index.json) |
| AMD2; one rejected AMD host | [42162639619](https://github.com/e6qu/fun-with-pipes/actions/runs/42162639619) | [42164773822](https://github.com/e6qu/fun-with-pipes/actions/runs/42164773822) | [index](run-42162639619/summary/index.json) |
| AMD1 | [42162975545](https://github.com/e6qu/fun-with-pipes/actions/runs/42162975545) | [42164952097](https://github.com/e6qu/fun-with-pipes/actions/runs/42164952097) | [index](run-42162975545/summary/index.json) |

Three unsuitable hosts were rejected before building or timing. Their full records
remain in [sessions.json](sessions.json). Each run directory retains reports,
complete logs, source/artifact hashes and the compressed native evidence. CI
checks every original artifact; local guarded checks verify downloaded digests,
all four report identities and every original budget result.

The [first ARM audit](../recording-inline-audit-repair-2026-11-06/README.md) used an
obsolete reference-file path and failed. The repair checks the correct runtime
file through the complete reference validator, including extra/wrong-file controls.
Only saved evidence was re-audited. Original timings and every missed limit remain.

## Native verification

The [48-image diagnostic](../recording-inline-images-2026-11-06/README.md) passes:
saved candidate/reference C reproduces every original executable byte for byte,
and GCC reports the required candidate append inlining. No native program was
executed and no timing repeated. Final platform verification remains required.
