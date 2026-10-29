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
No diagnostic result has been collected yet.
