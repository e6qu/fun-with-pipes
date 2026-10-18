# Preparation handoff: controlled large-map comparison

## Next action

Next: publish this measurement-only branch and dispatch `large-map` on both native
Linux architectures. Do not open a second PR. The authoritative live handoff is
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

## Local checks

Use the root `scripts/local-guard.py`, serially and with unchanged resource limits.
Only script syntax, workflow validation and documentation checks belong locally;
no full benchmark or release build. Guarded script syntax, actionlint, roadmap
and whitespace checks passed in 5.64 seconds using
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py python3 /private/tmp/fwp-large-map-preflight.py`.

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
