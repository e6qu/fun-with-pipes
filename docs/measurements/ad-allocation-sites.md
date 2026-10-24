# Where derivative allocations occur

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

An allocation-site profile records the native instruction that requested each
piece of managed storage. This explains what creates temporary objects; it does
not measure how long that instruction takes. This baseline predates direct
numeric mapped-array construction; its counts identify the costs that motivated
that later optimization. The
[four-host report](ad-allocation-sites-2026-10-16.json) compares
ordinary aggregate profiling against a diagnostic build with two allocation
functions deliberately kept out of line. Requests, requested bytes, retains and
peak/final memory agree exactly between both builds on every host. Raw
interpretation supplies expected outputs. Initial constants are excluded.

The workload computes 512 reverse derivatives of a function that doubles each
of 4,096 inputs. All four hosts record 25,184,777 managed requests, 805,720,218
requested bytes and 10,492,416 retains. Peak charged storage is 840,888 bytes;
final charged storage and collections are zero. Native symbols and debug
locations attribute the main requests as follows:

| Construction | Requests | Share of all requests |
|---|---:|---:|
| List nodes holding mapped results | 10,490,368 | 41.65% |
| Index/value pairs and list nodes for zip | 4,194,304 | 16.65% |
| Reverse-number multiplication records | 4,194,304 | 16.65% |
| Integer range list nodes | 2,101,760 | 8.35% |
| Array-to-list result nodes | 2,097,152 | 8.33% |
| Initial reverse-number records | 2,097,152 | 8.33% |

These are allocated objects, not necessarily distinct system malloc calls. The
report retains individual native sites, language signatures where available,
source/binary hashes, compiler commands and host details. Both variants are fwp;
this establishes no C/Rust parity or timing improvement. It points to list
intermediates as an optimization target before further tape-layout work.
