# Inspecting the three AMD64 timing misses

This reads existing samples from run `41853137417`; it runs no new benchmarks
and changes no acceptance rule. The complete 98-sample medians remain the result.
Splitting samples below is descriptive, not a replacement acceptance test.

## One-update regression

Session 2's three-coordinate, one-update current form takes **2.3095% more time**,
above the 2% allowance. Medians are 72.2265 ms candidate and 70.5961 ms reference
per sample, each summing seven fresh processes. Each process performs 512 solves.

The candidate still saves 3,584 requests, 73,728 requested bytes and 1,536 retains
per process. Peak managed storage falls from 16,752 to 16,688 bytes. Both versions
finish with zero managed storage. These counts do not explain the elapsed-time
regression or establish that all other operation costs decreased.

## Progression through the saved samples

Divide the original sample order into ranges `[0,24)`, `[24,49)`, `[49,73)` and
`[73,98)`. For each range, divide the candidate median by the stated comparison
median. No samples are discarded. A ratio below 1 means less elapsed time.

| Session / case | Comparison | First group | Second | Third | Fourth |
|---|---|---:|---:|---:|---:|
| 2 / 3-1 | Reference | 1.0310 | 1.0291 | 1.0042 | 1.0235 |
| 2 / 3-1 | Identical candidate copy | 1.0090 | 1.0106 | 1.0071 | 1.0343 |
| 1 / 3-199 | Identical candidate copy | 0.9535 | 1.0019 | 0.9830 | 0.9804 |
| 1 / 3-1999 | Identical candidate copy | 0.9920 | 0.9712 | 0.9706 | 0.9828 |

Session 1's complete identical-copy differences are **2.3628%** for 3/199 and
**2.7833%** for 3/1999, above 2%. Their timing comparisons remain inconclusive
despite candidate/reference ratios below 1. The differences are not confined to
the same part of both runs, so these observations do not justify dropping early
samples or changing warmups.

The separate phase-instrumented executables also change elapsed time: their
observed ratios to ordinary executables range from about 0.95 to 1.30 in these
cases. They cannot isolate the cause of a 2.31% whole-program difference.
No ownership failure, hardware cause or compiler repair follows from these data.

[Session 1 calculations](amd64-session1-samples.json) and
[session 2 calculations](amd64-session2-samples.json) retain exact medians,
counts, source and original artifact identities. The full raw-data audit is
separate. Any follow-up must declare its source/setup diagnostic before new
measurements; do not repeat unchanged timings for a pass.
