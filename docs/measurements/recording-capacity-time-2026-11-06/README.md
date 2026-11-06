# Checked capacity gate: runtime results

Long solves use **1.86–14.02% less elapsed time** than the same-source reference.
Seventeen of 32 long-case results meet the frozen 5% target; **15 remain open**.
All small-case regression limits pass (maximum 1.15% slower). One copy control
fails: AMD64 session 2's 3/1999 current-result case differs by **2.22%**, above 2%.
That timing is inconclusive. No qualified session was repeated.

[Memory/work checks](../recording-capacity-census-2026-11-06/README.md) find unchanged
allocations, live storage, reference counts and validations, with zero final
tracked storage and no increase in the largest reported frames.
All [compiler-cost limits](../recording-capacity-analysis-2026-11-06/README.md) pass.
These results do not close missed limits from earlier comparisons.

## Comparison and timing

Programs minimize the Rosenbrock function using automatically computed derivatives.
The candidate keeps the checked no-growth capacity path at its caller. The
reference recombines that gate with the unchanged growth body. Both retain
append inlining, validated lookup reuse and all earlier optimizations.

- Source `51edfc0e7884e1a75201bc9876fd13cb8ca25eee`; two independent sessions each
  on Neoverse-N2 ARM64 and EPYC 7763 AMD64. No host was rejected or replaced.
- GCC O2, explicit native target, no fast math/contraction/LTO; GCC 13.3 on ARM64,
  15.2 on AMD64. Rust 1.99.1, opt-level 2, overflow checks, one codegen unit,
  generic CPU target, no LTO. Full commands/toolchains are retained.
- Two warmups, then 98 balanced rounds. Each sample totals seven fresh processes,
  including startup, solves, output and teardown. Compilation, output checking
  and instrumented profiles are outside the timer.
- Coordinates / updates / solves per process: 3/0/32768, 3/1/512, 3/199/32,
  3/1999/4, 33/199/32, 129/199/8. Each solve restarts from the original input.
- Current returns final coordinates. History expresses successive values and
  selects the last; unused history can be optimized away.
- Outputs match their checked executable reference exactly and the analytic
  result within absolute/relative tolerance 1e-10. The schedule balances positions
  and cyclic predecessors over 49 rounds; round boundaries are not perfectly balanced.

## Candidate / reference elapsed time

Below 1 is faster: `0.92` means 8% less time. Long cases require at most `0.95`;
zero/one-update cases permit at most `1.02`. AMD2 3/1999 current is inconclusive
because its identical-copy control failed, even though its observed ratio is below 1.

| Coordinates / updates, form | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 current | 1.0011 | 1.0026 | 1.0074 | 1.0034 |
| 3 / 0 history | 1.0020 | 1.0021 | 1.0063 | 1.0002 |
| 3 / 1 current | 0.9999 | 1.0007 | 1.0045 | 1.0115 |
| 3 / 1 history | 1.0029 | 1.0059 | 0.9914 | 0.9915 |
| 3 / 199 current | 0.9624 | 0.9679 | 0.9640 | 0.9754 |
| 3 / 199 history | 0.9725 | 0.9814 | 0.9625 | 0.9565 |
| 3 / 1999 current | 0.9765 | 0.9736 | 0.9686 | 0.9675 |
| 3 / 1999 history | 0.9744 | 0.9764 | 0.9795 | 0.9390 |
| 33 / 199 current | 0.9178 | 0.9180 | 0.8732 | 0.8712 |
| 33 / 199 history | 0.9188 | 0.9186 | 0.8834 | 0.8888 |
| 129 / 199 current | 0.9114 | 0.9126 | 0.8695 | 0.8598 |
| 129 / 199 history | 0.9123 | 0.9120 | 0.8732 | 0.8825 |

All 16 results for 33 and 129 coordinates meet 5%. Of the 16 three-coordinate
long results, only AMD2 3/1999 history meets 5%. The other 15 targets remain open.
The [saved-copy review](copy-review.json), reproduced by [this script](copy-review.py),
confirms byte-identical images and balanced positions. Candidate/identical medians
are 1.02979 in the first 49 rounds and 0.99344 in the last 49: the gap reverses.
This establishes variation, not its cause. Retain the samples for source/driver
review; do not repeat the unchanged comparison for a pass.

[C/Rust comparison, process memory and code costs](peer-costs.md) explain the
remaining complete-program gap. Those peers use handwritten derivatives;
their ratios do not isolate language or ARC overhead.

## Evidence and next check

[Original run](https://github.com/e6qu/fun-with-pipes/actions/runs/42179983250),
[complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42183074888),
[session index](run-42179983250/summary/index.json) and [decisions](sessions.json).
All four producer jobs fail their recorded timing limits; the successful audit
preserves those failures and verifies every observation, executable/source hash,
output, compiler command, reference edit and complete job log.

The [patch-reader repair](../recording-capacity-audit-repair-2026-11-06/README.md)
allows different valid diff alignments while requiring the exact reference source.
Original timings were audited without rerunning them. Downloaded archive digests,
all report/log hashes and every budget decision also pass local guarded checks.

The compressed evidence is stored in two parts below GitHub's recommended
per-file limit. [Part sizes and hashes](run-42179983250/retained-parts.json) also
record the checksum of the original archive. To reconstruct it in that directory:

```sh
cat retained-comparison.tar.xz.part-00 retained-comparison.tar.xz.part-01 > retained-comparison.tar.xz
```

Concatenation was verified byte for byte by SHA-256 before removing the large
storage file. Nothing was recompressed, regenerated or retimed.

The [frozen image input plan](../recording-capacity-call-inputs.json) selects
session 1 on each architecture. [Native verification](../recording-capacity-images-2026-11-06/README.md)
reproduces all 48 original executable hashes and confirms capacity inlining.
No native program was executed and no new timing was taken by that check.
Final platform verification follows. [Contract](../recording-capacity.md).
