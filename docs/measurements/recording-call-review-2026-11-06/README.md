# What changed in the measured recording worker?

A derivative tape stores each operation's parents and weights for the backward
pass. The selected worker computes one neighboring pair of the Rosenbrock
objective and records six operations. We compared its saved generated C for
129 coordinates and 199 updates, returning only the final coordinates.

## Exact source difference

- Reference: six calls through `f141`, a generated function that calls the runtime
  append helper with `NULL` (no reusable lookup state).
- Candidate: one local `recording = {-1, NULL}` and six direct helper calls using
  `&recording`. The first active call validates the tape; later matching IDs reuse it.
- The wrapper, arithmetic, weights, parent/capacity checks and reverse pass are
  otherwise identical between these two files.

```text
reference: worker → f141 → append(..., NULL)
candidate: worker → append(..., &recording)
```

These are C source calls. GCC can inline them (replace a call with its body), so
this diagram is not a count of machine calls. The source diff alone does not
explain the measured slowdown. [The next diagnostic](../recording-call-costs.md)
checks GCC's decisions and includes the previous release as a third control.

## Reproduce the review

[review.json](review.json) names the source/artifact and exact file hashes.
[The patch](reference-to-candidate.patch) contains every source difference.
The compressed [candidate](candidate.c.gz) and [reference](reference.c.gz) came
from the original ARM64 session-1 artifact; their source hashes match all four
qualified [timing sessions](../recording-lookup-time-2026-11-06/README.md).

```sh
python3 scripts/local-guard.py python3 docs/measurements/recording-call-review-2026-11-06/verify-source.py
```

The verifier checks file hashes, all four report identities, the unchanged wrapper
and exact seven-edit difference. It neither compiles nor executes a native program.
