# Where the derivative solve spends time

This review reads the [four saved scalar-constant sessions](../scalar-constant-time-2026-11-05/README.md).
It runs no compiler or benchmark. [The calculation](phase-review.py) and
[results](phases.json) retain each input report's hash and measurement source.

Scope: 129 coordinates, 199 updates, eight solves per process; final-result and
history forms, two sessions on each architecture. Each row summarizes 12 measured
diagnostic processes, excluding warmups. These are instrumented phase observations,
separate from the uninstrumented complete-program timing samples.

| Stage | Median share of derivative-phase time, across the eight rows |
|---|---:|
| Objective evaluation plus recording | 71.8–72.4% |
| Reverse traversal | 23.0–24.1% |
| Result-array construction | 0.9–1.0% |

Forward evaluation/recording is 45.5–47.6% of instrumented process elapsed time.
The script calculates each process's percentage first, then takes its median.
It does not divide independently aggregated medians. Instrumentation adds work;
these percentages neither isolate a runtime check nor predict its removal's gain.

Every observed process records 1,592 updates, 205,368 inputs and 1,630,208 nodes:
1,024 nodes per update. This observation led to the
[recording-call review](../recording-call-review-2026-11-06/README.md), separating
arithmetic, validation, capacity checks and writes. The resulting optimizations
retain those checks unless a lifetime proof also preserves failure order.

Reproduce from the repository root, with these retained reports present:

```sh
python3 scripts/local-guard.py python3 docs/measurements/recording-work-review-2026-11-05/phase-review.py \
  --case 129-199 \
  --report docs/measurements/scalar-constant-time-2026-11-05/42078637088/aarch64-1.json.gz \
  --report docs/measurements/scalar-constant-time-2026-11-05/42078637088/aarch64-2.json.gz \
  --report docs/measurements/scalar-constant-time-2026-11-05/42078637088/x86_64-1.json.gz \
  --report docs/measurements/scalar-constant-time-2026-11-05/42078654369/x86_64-2.json.gz
```

The guarded calculation passed. This is the original diagnostic, not a speed
claim. Later [computed-input measurements](../computed-numeric-time-2026-11-07/README.md)
have different source and cost boundaries; do not apply these percentages to them.
