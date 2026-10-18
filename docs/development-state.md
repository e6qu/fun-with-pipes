# Preparation handoff: controlled large-map comparison

## Next action

Next: publish the phase and lookup experiments, rerun `large-map` on both native
Linux architectures and diagnose the AMD64 construction slowdown before accepting
PR #166. Do not open a second PR. The authoritative live handoff is
`/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`; PR #166 remains
at `7f782388270b5d73a60eaf3c253a6f9a6e680e95` while its production gate runs.

## Why this measurement comes first

The passing PR #166 benchmark reports fwp map time 505.247 ms, C 410.488 ms and
Rust 338.542 ms: 23.1% and 49.2% more time. Its retained artifacts pass inspection:
15 actual measured ELF AMD64 executables, 15 exact source inputs, five generated
C files and matching reports. Data-only artifacts are `/private/tmp/fwp166-benchmarks`;
no downloaded executable was run. The map source visibly contains direct numeric
construction. Older measurements used different runs, so they cannot establish
whether this change caused a regression.

This branch changes no compiler/runtime code. It compares the maintained
500,000-entry map and 2,000,000 lookups with construction fusion enabled/disabled,
in both default tracing and checked ARC, on the same runner and compiler.
C and Rust run alongside the full fwp programs. Separate construction-only fwp
programs help distinguish workloads; do not subtract their medians as if that
directly measured lookup time. Every variant occupies each timing position twice
following warmup. Separate instrumented programs count allocations, retains and
counted storage; actual binaries and disassembly are retained. Full measurements
and builds run on GitHub only.

Audit all results, including any apparent slowdowns. If the new optimization
causes a reproducible regression, fix its cause before accepting PR #166. If it
does not, use the measured remaining work and actual instructions to choose the
next substantial optimization. A plain range-to-set probe was considered but no
measurement or compiler change was started; this observed map gap takes priority.

## First controlled result

Exact source `9f0632f9c1abf4f067fa659f1d95c5768cb8a965`, run `39102838322`,
passes both Linux hosts. Artifact audit verifies all 36 binaries, hashes, raw
samples, output, code markers and ARC cleanup (3.66 s guarded). Data remains in
`/private/tmp/fwp-large-map-baseline`; audit is
`/private/tmp/fwp-large-map-baseline-audit.json`.

Optimization-enabled/disabled median ratios: ARM64 complete work 0.904 tracing,
0.874 ARC; construction-only 0.327/0.369. AMD64 complete work 1.083 tracing,
0.928 ARC; construction-only 1.364/0.720. AMD64 optimized construction is bimodal:
roughly 40–59 ms versus 131–141 ms, also under ARC. Do not dismiss it as general
runner noise: C/Rust and unoptimized full-work samples are much more stable.
The existing optimization still needs a diagnosed, tested repair if reproducible.

Separate phase probes record sorting, allocation, deduplication, materialization
and cleanup durations plus allocation addresses. Their instrumented timings are
not ordinary benchmark timings. Independent lookup candidates compare lower-bound
integer search and keeping one-time producers out of the cached-read body; neither
removes ownership checks. Original and experimental search agree with 56,772
independent hit/miss/insertion checks including signed/unsigned limits. No compiler
or runtime change is accepted from these experiments alone.

## Local checks

Use the root `scripts/local-guard.py`, serially and with unchanged resource limits.
Only script syntax, workflow validation and documentation checks belong locally;
no full benchmark or release build. Guarded script syntax, actionlint, roadmap
and whitespace checks passed in 5.64 seconds using
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py python3 /private/tmp/fwp-large-map-preflight.py`.

Lookup/script/workflow checks pass in 4.98 s guarded. Phase-probe C syntax and
final workflow/documentation checks pass in 5.58 s guarded; no large benchmark
ran locally. Command: root guard with `/private/tmp/fwp-map-phase-preflight.py`.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | Controlled C/Rust gaps and actual machine code |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Representative applications and browser execution |

All seven [plan](../PLAN.md) areas remain open; JIT is excluded, not deferred.
