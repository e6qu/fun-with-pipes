# Shared tape access: runtime results

**Thirty of 32 long-case 5% speed targets remain open.** All sixteen ARM targets
miss; AMD session 1 meets the two larger history targets, while session 2 meets
none. AMD also has two small-case regressions and one inconclusive copy control.
No qualified timing session was repeated. These results do not settle earlier
comparisons' missed targets.

The original and replacement AMD sessions received EPYC 9V74 and 9V45 hosts
under the original 7763-only rule. All four stopped before building or timing.
The user then approved
[all three named EPYC models](../recording-context-scopes.md#approved-hardware-amendment-6-november-2026)
for matched sessions. The two new AMD sessions completed on **9V45 and 7763**.
The original rejections and completed ARM timings stay unchanged.

## What was timed

- ARM source `319782736b0a983022f2a48879b35c9e57992949`, two Neoverse-N2 sessions;
  AMD source `1720c3b8cd06d7756295186233181cd64544bf44`, 9V45 then 7763.
  Production compiler/runtime/library/test trees are identical between sources;
  the later source adds the approved measurement policy and documentation.
  Candidate/reference differ only in the new numeric-call/map/fold scopes.
  Both retain earlier optimizations and record/reverse the same derivatives.
- Programs minimize Rosenbrock. Coordinates/updates/solves per process are
  3/0/32768, 3/1/512, 3/199/32, 3/1999/4, 33/199/32 and 129/199/8.
  Every solve restarts from the original input.
- Current returns final coordinates. History expresses successive values and
  selects the last; unused history can be optimized away.
- GCC 13.3 / `armv8-a` on ARM; GCC 15.2 / `x86-64` on AMD. Both use O2,
  no fast math/contraction/LTO. Rust peers use 1.99.1,
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

| Coordinates / updates, form | ARM1 | ARM2 | AMD1 (9V45) | AMD2 (7763) |
|---|---:|---:|---:|---:|
| 3 / 0 current | 0.9985 | 0.9992 | 0.9759 | 1.0083 |
| 3 / 0 history | 0.9990 | 1.0002 | 1.0267 | 0.9961 |
| 3 / 1 current | 1.0004 | 0.9992 | 1.0146 | 0.9955 |
| 3 / 1 history | 1.0023 | 1.0029 | 1.0038 | 1.0329 |
| 3 / 199 current | 1.0179 | 1.0101 | 1.0028 | 1.0073 |
| 3 / 199 history | 0.9984 | 1.0026 | 1.0388 | 1.0187 |
| 3 / 1999 current | 1.0209 | 1.0196 | 1.0127 | 1.0174* |
| 3 / 1999 history | 1.0110 | 1.0110 | 1.0199 | 1.0130 |
| 33 / 199 current | 0.9773 | 0.9777 | 0.9789 | 0.9974 |
| 33 / 199 history | 0.9789 | 0.9792 | 0.9413 | 0.9961 |
| 129 / 199 current | 0.9763 | 0.9770 | 0.9700 | 0.9913 |
| 129 / 199 history | 0.9766 | 0.9752 | 0.9491 | 0.9987 |

*AMD2 3/1999 current is inconclusive: identical copies differ by **2.0091%**,
above 2%. Other copy controls pass. AMD1 zero-update history slows **2.6728%**;
AMD2 one-update history slows **3.2922%**, both above the small-case 2% limit.
All ARM small-case limits pass. Different AMD CPUs are separate matched sessions,
not repetitions on identical hardware; their absolute times are not pooled.

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

The same 129/199 current case on AMD (eight solves per process):

| Implementation | 9V45 median / peak RSS | 7763 median / peak RSS |
|---|---:|---:|
| fwp candidate | 78.805 ms / 2,112 KiB | 146.020 ms / 2,108 KiB |
| fwp reference | 81.246 ms / 2,304 KiB | 147.295 ms / 2,176 KiB |
| C, handwritten derivatives | 6.453 ms / 1,544 KiB | 10.009 ms / 1,544 KiB |
| Rust, handwritten derivatives | 7.717 ms / 2,144 KiB | 10.728 ms / 2,160 KiB |

fwp takes 12.21× C and 10.21× Rust on 9V45; 14.59× C and 13.61× Rust on 7763.
That is roughly 1,121%/921% and 1,359%/1,261% extra elapsed time for the different
derivative implementations. These RSS samples do not establish an allocation
reduction: tracked storage/counts remain unchanged. AMD instruction bytes grow
44,498→45,106 and executable bytes 88,648→88,672 in both sessions.

## Audits and remaining delivery

- [Original run audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42230424553)
  verifies both complete ARM sessions and two rejected AMD hosts.
  [Index, hashes and decisions](run-42224669329/summary/index.json).
- [Replacement-host audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42231927387)
  verifies that both replacements stopped before building/timing.
  [Index and decisions](run-42228557375/summary/index.json).
- [Approved-host AMD audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42255876958)
  verifies both complete AMD sessions and all seventeen missed limits.
  [Index, hashes and decisions](run-42251223529/summary/index.json).
  The compact archive digest, both producer/report hashes and full audit log pass
  local guarded verification (0.24 s). The 29,984,310-byte
  [original archive](run-42251223529/retained-artifact.json) stayed on the runner.
- Each run directory retains the audit job/log/artifact identity; its summary
  contains complete producer logs, qualification records and available samples.
  Local guarded checks verify both archive digests, all six log hashes, both
  report hashes and every decision (0.25 s). Large originals stayed on runners.
  GitHub identities for the larger retained archives are recorded for the
  [original run](run-42224669329/retained-artifact.json) and
  [replacement run](run-42228557375/retained-artifact.json); those two archives
  were not downloaded or re-audited locally.

The successful audits preserve producer failures; they do not accept missed
timing limits. Check original measured images
and finish all nine final-head production gates plus docs before merge.
[Contract](../recording-context-scopes.md) · [Current plan](../../../PLAN.md).
