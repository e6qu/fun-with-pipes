# Shared tape access: runtime results

All **sixteen ARM64 long-case 5% speed targets remain open**. Session 1 ranges
from 2.09% slower to 2.37% faster; session 2 from 1.96% slower to 2.48% faster.
Small-case regression and identical-copy limits pass. No qualified timing session
was repeated. These results do not settle earlier comparisons' missed targets.

**No AMD64 runtime measurements exist.** The original and replacement sessions
each received EPYC 9V74 and 9V45 hosts, while the frozen protocol requires 7763.
All four stopped before building or timing. The user subsequently approved
[all three named EPYC models](../recording-context-scopes.md#approved-hardware-amendment-6-november-2026)
for matched sessions. The two missing AMD sessions remain to be measured; the
original rejections and completed ARM timings stay unchanged.

## What was timed

- Source `319782736b0a983022f2a48879b35c9e57992949`; two Neoverse-N2 sessions.
  Candidate/reference differ only in the new numeric-call/map/fold scopes.
  Both retain earlier optimizations and record/reverse the same derivatives.
- Programs minimize Rosenbrock. Coordinates/updates/solves per process are
  3/0/32768, 3/1/512, 3/199/32, 3/1999/4, 33/199/32 and 129/199/8.
  Every solve restarts from the original input.
- Current returns final coordinates. History expresses successive values and
  selects the last; unused history can be optimized away.
- GCC 13.3, O2, `armv8-a`, no fast math/contraction/LTO. Rust peers use 1.99.1,
  opt-level 2, overflow checks, one codegen unit, generic CPU target and no LTO.
- Two warmups, then 98 balanced rounds. Each sample totals seven fresh processes:
  startup, repeated solves, output and teardown. Builds, output checks and
  instrumented profiles are outside the timer. Zero updates are not pure startup.
- Outputs match each executable's checked reference exactly and the analytic
  result within absolute/relative tolerance 1e-10. Position/predecessor balancing
  spans 49 rounds; actual round boundaries are not perfectly balanced.

## Candidate / reference elapsed time

Below 1 is faster: `0.98` means 2% less time. Long cases require at most `0.95`;
zero/one-update cases permit at most `1.02`. All absolute medians, memory results
and missed limits are in [the session summary](sessions.json).

| Coordinates / updates, form | ARM1 | ARM2 |
|---|---:|---:|
| 3 / 0 current | 0.9985 | 0.9992 |
| 3 / 0 history | 0.9990 | 1.0002 |
| 3 / 1 current | 1.0004 | 0.9992 |
| 3 / 1 history | 1.0023 | 1.0029 |
| 3 / 199 current | 1.0179 | 1.0101 |
| 3 / 199 history | 0.9984 | 1.0026 |
| 3 / 1999 current | 1.0209 | 1.0196 |
| 3 / 1999 history | 1.0110 | 1.0110 |
| 33 / 199 current | 0.9773 | 0.9777 |
| 33 / 199 history | 0.9789 | 0.9792 |
| 129 / 199 current | 0.9763 | 0.9770 |
| 129 / 199 history | 0.9766 | 0.9752 |

## C/Rust comparison and memory

C/Rust use handwritten derivatives and reuse two contiguous buffers. fwp records
and reverses derivatives automatically. Inputs, update counts and checked results
agree; derivative work, allocation and formatting strategies differ. These
complete-program ratios do **not** isolate language or ARC overhead. Swift was
not measured in this group; see the [separate comparison](../swift-allocations.md).

Example: ARM session 1, current-result 129/199, eight solves per process:

| Implementation | Median seven-process sample | Peak process RSS |
|---|---:|---:|
| fwp candidate | 119.382 ms | 1,760 KiB |
| fwp reference | 122.277 ms | 1,752 KiB |
| C, handwritten derivatives | 10.867 ms | 1,384 KiB |
| Rust, handwritten derivatives | 10.891 ms | 1,760 KiB |

fwp uses 10.99× C's time and 10.96× Rust's: about 999% and 996% extra elapsed
time for these different implementations. RSS includes runtime/library/process
costs; it is distinct from [tracked allocation and live storage](../recording-context-census-2026-11-06/README.md).
Those tracked counts/peaks and largest reported frames are unchanged.
For this example, native instruction bytes grow 42,604→42,860 and executable
bytes 143,432→143,448. All case/form code costs remain in the session summary.

## Audits and remaining delivery

- [Original run audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42230424553)
  verifies both complete ARM sessions and two rejected AMD hosts.
  [Index, hashes and decisions](run-42224669329/summary/index.json).
- [Replacement-host audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42231927387)
  verifies that both replacements stopped before building/timing.
  [Index and decisions](run-42228557375/summary/index.json).
- Each run directory retains the audit job/log/artifact identity; its summary
  contains complete producer logs, qualification records and available samples.
  Local guarded checks verify both archive digests, all six log hashes, both
  report hashes and every decision (0.25 s). Large originals stayed on runners.
  GitHub identities for the larger retained archives are recorded for the
  [original run](run-42224669329/retained-artifact.json) and
  [replacement run](run-42228557375/retained-artifact.json); those two archives
  were not downloaded or re-audited locally.

The successful audits preserve producer failures; they do not accept missed
timing limits. Complete AMD timing under the approved policy, check original measured images
and finish all nine final-head production gates plus docs before merge.
[Contract](../recording-context-scopes.md) · [Current plan](../../../PLAN.md).
