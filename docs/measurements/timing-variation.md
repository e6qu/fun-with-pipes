# Investigating numerical timing variation

The repaired compiler passes its focused correctness checks. Two measurements
still fail their frozen acceptance rules; neither is permission to drop samples,
increase a limit or repeat the same experiment until it passes.

- Derivative recheck `40912773534`, job `123584890626`, source `694e31b7`:
  the zero-update history case takes 1.022815765 times its reference's time,
  exceeding 1.02. The current-result identical-code control passes. It does not
  control the history program's variation. All emitted candidate/reference C
  files equal their earlier measured versions; this repair did not change them.
  [All four recheck sessions](eager-captures-recheck-artifacts-2026-10-29.json)
  retain the failed overall decision and the three passing sessions.
- Kernel recheck `40916288542`, job `123597280887`, source `bf46f776`:
  byte-identical small-matrix programs differ by 3.27% in computation time and
  3.49% including allocation, above 2%. Individual fwp processes vary roughly
  from 5.4 to 10.4 ms, while C/Rust peers are much steadier. The larger matrix and
  arrays pass their noise controls. [The recheck archive](kernel-recheck-artifacts-2026-10-29.json)
  retains every sample and both failures. This is incomplete N1 evidence.

These facts do not establish the cause. Possible effects of process scheduling
and memory placement need direct observations; instruction listings alone cannot
identify them. Inspect the source and validate all outputs throughout diagnosis.

## Diagnostic experiment, declared before implementation

Use a qualified four-processor Linux EPYC 7763 host with GCC 15.2.0, matching
the failed sessions. Reuse their retained executables and verify each byte hash
against its report. This is a diagnostic of those exact programs; ordinary fwp
builds must still require no previous compiler installation.

Compare two explicit execution policies: the runner's recorded allowed CPU set,
and affinity restricted to CPU 0. Check that CPU 0 is allowed; fail if affinity
cannot be set. Alternate policies each round so a long-running host change does
not affect only one policy. Keep address randomization enabled.

For the small matrix use C, Rust, fwp and its byte-identical copy. For zero-update
history use the candidate, reference and a byte-identical copy of each. Run 16
rounds per policy, four processes per label per round, with the existing balanced
four-label schedule and seed 20261029. Keep five internal kernel samples and the
original eight calculations per sample; keep all 32,768 derivative solves per
process. Check every output/hash and live-storage result. Preserve every process
duration and order, including outliers. Do not treat these diagnostic timings as
new accepted baselines or change any frozen limit.

Separately instrument the small-matrix C harness to record the executing CPU
before/after each call and input/output data offsets modulo 64 KiB. Save input
addresses before transferring their owners; never inspect freed input objects.
Print diagnostics outside the inner kernel timer. Run 32 processes per policy and retain
the instrumented source, build command, binary and all observations. Such logging
may perturb performance, so do not substitute its timings for ordinary results.

This experiment should distinguish CPU migration from variation that persists
within a fixed CPU. Offset correlations may guide a source-level allocator or
layout investigation, but they are not proof by themselves. Choose a measurement
repair only from the resulting evidence, document its limitations and publish it
before rerunning the acceptance experiment. N1 and the selected D2 budget remain
open until their unchanged acceptance requirements are met.

## Running the diagnostic

The `timing-diagnostics` selection in `.github/workflows/numerics.yml` requires
`evidence_run=40916288542` and `baseline_run=40912773534`. It qualifies the host
before downloading or running the failed programs; a rejection remains an
artifact. `scripts/diagnose-timing-variation.py` checks executable identities,
retains every stdout/stderr stream and duration, and restores the original CPU
affinity even after failure. `scripts/test-timing-diagnostic.py` checks observation
placement, changed instrumentation boundaries and rejected corrupt outputs.
Run `40949475361`, job `123713471516`, completed on EPYC 7763 at `535031b3`.
The [archive](timing-diagnostic-artifacts-2026-10-29.json) retains all 1,089 process
records, 1,088 observations, complete logs, instrumented source and artifact
identities. Independent audit checked every raw stream/hash, schedule, output,
live-storage result and CPU/layout observation. The prior run `40949274713`
rejected EPYC 9V45 before downloading or executing; its qualification/log remain.

## What the diagnostic establishes

Fixed-CPU execution does not repair the matrix control. The fwp/identical ratio
is 1.0389 with normal scheduling and 0.9633 when pinned (reciprocal 1.0381).
Every one of 2,560 recorded matrix calls has input/output offsets `(8, 8, 8)`
modulo 64 KiB. Only two unbound calls change CPU; none pinned do. Pinned fwp
processes still range from 5.38 to 10.25 ms for their five calculation samples.
These observations reject CPU affinity and these low address bits as sufficient
explanations. They do not identify a runtime defect or prove other placement or
host-load effects absent. The matrix source preserves shape bounds, live inputs,
a fresh output and alias-safe byte copies; no unsafe access was identified.

Zero-update history remains near the limit: candidate/reference 1.0204 unbound
and 1.0200 pinned. The candidate/copy differs by about 2.95% in the smaller pinned
sample, so this diagnostic cannot accept or reject the production timing rule.
Retained profiles have equal allocations/retains, and the inspected zero-update
entry and loop body have the same C operations (the string cleanup identifier
changes, its implementation does not). No added source-level work has been found;
this is not proof of equal machine cost. The original 1.0228 failure stays open.

## Small-matrix sampling repair, declared before implementation

The original comparison has only 64 fresh processes per label. In the diagnostic,
the standard deviation divided by the mean is 24.2% unbound and 25.4% pinned for
fwp and its copy, pooled within each policy. The five samples within a process
share its placement and execution conditions; they are not five independent
placements. The present sample size cannot reliably resolve the 2% control.

For **both architectures**, increase the small matrix from four to **256 fresh
processes per label per round**. Keep 16 measured rounds and two warmup rounds:
4,096 measured processes per label. Repeat the existing 16-entry balanced cycle
64 times within each round; keep the same seed and rotations. This retains
position and within-round predecessor balance. Keep ordinary scheduling, five
samples per process, eight calculations per sample, both timing boundaries,
the median of complete round totals, all observations and the **1.02** limit.
Keep the other three cases at four processes per label per round.

As a planning estimate only, independent sample means at the observed variation
would have about 1.4% two-sided 99% difference uncertainty at 4,096 processes,
versus about 11% at 64. The actual statistic uses round medians and host conditions
may be correlated; this estimate does not replace the unchanged control or
promise a pass. Run two independent qualified sessions per architecture after
implementing this declared count. A further failure stays inconclusive: do not
increase counts again after seeing those outcomes or discard old results.
This repair changes measurement precision, not the programs or D2's limits.

## Expanded result and next source investigation

The declared four-session run `40951090783` at `37da7441` is fully audited.
Small-matrix controls pass in all four sessions. AMD session 2 instead fails
the 65,537-element array's allocation-inclusive control at 1.030786192. Its
computation-only control is 1.002754; all other cases pass. The complete
[expanded archive](kernel-expanded-artifacts-2026-10-29.json.gz) remains
not accepted. Neither another unchanged run nor a further count increase is
authorized by this experiment.

The computation-only AMD array gap is consistent at about 3.3 times C, with
passing controls in both sizes and sessions. Source inspection shows an F64
accumulator carried through a generic 64-bit loop-state array. That observation
is a hypothesis about extra register transfers, not a demonstrated cause.

Before selecting an optimization, compile the retained C and fwp timing sources
for all four cases on the matching GCC ARM64/AMD64 hosts, at their original O2
settings. Add only GCC's vectorization report and optimized-tree dump options.
Require the rebuilt executable's hash to match its recorded ordinary binary
and verify every output hash/live-storage result. Preserve the source, commands,
compiler reports, binaries and outputs. This is compiler inspection, not another
timing acceptance run; do not select or discard elapsed-time observations.
It can explain generated code choices while the separate allocation-inclusive
noise failure and D2's zero-update requirement remain unresolved.
