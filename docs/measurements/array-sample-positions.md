# Where array consumption slows down

This describes the existing baseline and scalar-capture measurements. It does not
run a new benchmark, discard samples or change the original acceptance limits.

Each session has 18 measured rounds, 72 fresh processes per role and five samples
per process. Each sample constructs and consumes eight arrays. The table shows
median consumption microseconds per array at each sample position for 262,145
elements on AMD64; divide the recorded sample timer by eight.

| Session | Program | First | Second | Third | Fourth | Fifth |
|---|---|---:|---:|---:|---:|---:|
| 1 | Direct callback | 275.55 | 254.46 | 247.64 | 246.82 | 246.01 |
| 1 | Its identical copy | 274.45 | 253.48 | 247.56 | 246.20 | 246.00 |
| 1 | Generic reference | 247.93 | 245.92 | 245.87 | 245.86 | 245.66 |
| 1 | Its identical copy | 247.23 | 245.61 | 245.85 | 245.73 | 246.08 |
| 2 | Direct callback | 269.49 | 261.59 | 248.71 | 247.08 | 246.96 |
| 2 | Its identical copy | 283.33 | 265.00 | 248.30 | 247.10 | 246.41 |
| 2 | Generic reference | 248.27 | 246.80 | 247.06 | 246.95 | 246.73 |
| 2 | Its identical copy | 248.26 | 247.14 | 247.02 | 246.73 | 246.77 |

The direct constructor is faster, but its following consumption starts slower
and later approaches the reference. The earlier C-driver construction baseline
also has higher early consumption times. Neither observation identifies why.
Small-array behavior is less consistent, including a mismatch between identical
copies; all roles, both sizes, architectures and sessions remain in the
[complete summary](array-sample-positions-2026-11-02.json).

These position medians are descriptive statistics, not the original median of
complete-round totals. They cannot replace its failed limits. The summary also
subtracts the last sample from the first within each process before summarizing
those differences; subtracting two separate medians would answer another question.

`scripts/summarize-array-samples.py` checks report hashes against audited file
manifests and retains every original failure. Its explicit inputs are the
`array-construction-phases-2026-11-02` and `scalar-array-captures-2026-11-02`
directories and both array cases. Documentation CI reproduces the saved output.

The [completed preparation diagnostic](array-consumption-2026-11-02/README.md)
tests equal untimed preparation before the same numerical work. Its subsequent
[driver comparison](array-observations-2026-11-02/README.md) separates added
observations from preparation-driver changes. Both retain the original failed
limits; neither justifies a runtime ownership change.
