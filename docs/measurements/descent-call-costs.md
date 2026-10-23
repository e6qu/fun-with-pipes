# Scalar helper calls: inlining did not meet the speed target

Adding an inline hint or forcing one numerical helper into its callers did not
meet the predeclared 5% speed target. We are not adding a compiler inlining rule
from this experiment. Correctness and storage checks pass on both Linux hosts;
all 120 executable images have been independently inspected.

The [protocol](descent-call-protocol.md) was published before measurement.
[Run 39798044726](https://github.com/e6qu/fun-with-pipes/actions/runs/39798044726)
uses source `55de3ce53f0924c9cd688a0d680058b3f47d076d`.
The [raw record](descent-call-costs-2026-10-22.json) preserves samples, commands,
outputs, storage profiles, frame estimates, binary hashes and independent
instruction inspection. This is a generated-C experiment, not a compiler change.

## What was compared

The program repeatedly updates a vector using an explicit derivative formula.
For example, 129×199 means 129 coordinates and 199 updates. The unchanged fwp
executable is rebuilt from saved C alongside two variants: an ordinary `inline`
hint and `always_inline` on helper `w36` (`next-contribution` in the fwp source).
The helper reads a neighbouring coordinate and checks its index. No checks,
arithmetic operations or failure paths were removed. The accepted C and Rust
programs implement the same explicit derivative with reusable buffers; fwp
creates a new immutable array per update. Formatting also differs.

Each of the seven entries has two warmups and 56 timed process executions,
including startup, computation, complete output and teardown. Compiling and
instrumented storage checks are outside timing. Two entries are byte-identical
copies under different names: their differences estimate noise in this procedure.
The protocol specifies balanced order within fourteen-round blocks.

AMD64 ran on Intel Xeon 6973P-C; ARM64 ran on Neoverse N2. Both used GCC 13.3.0
at O2 with baseline architecture flags, floating contraction disabled and no
fast-math. Rust 1.99.1 used O2, generic CPU, checked overflow and no LTO. The
AMD64 CPU differs from the preceding borrowed-capture report, so these times do
not establish a speed change across those runs. Every comparison below uses
executables rebuilt and timed together on the same host.

## Every input, including noisy or slower cases

Candidate ratios divide its median by unchanged fwp's median: below one is
faster. Control ratios divide an executable's median by its identical copy's
median: a difference from one is not an optimization. These ratios compare fwp
variants, not parity with C or Rust.

| Host | Coordinates-updates | Hint / unchanged | Forced / unchanged | Unchanged / copy | Forced / copy |
|---|---|---:|---:|---:|---:|
| x86_64 | 3-0 | 1.0597 | 1.0490 | 0.9366 | 1.0293 |
| x86_64 | 3-1 | 1.0018 | 0.9663 | 0.9897 | 0.9792 |
| x86_64 | 3-199 | 1.0182 | 0.9787 | 0.9693 | 0.9417 |
| x86_64 | 3-1999 | 1.0291 | 0.9111 | 1.0472 | 0.9998 |
| x86_64 | 33-199 | 0.9284 | 0.9496 | 1.0812 | 0.9573 |
| x86_64 | 129-199 | 0.9805 | 0.9958 | 1.0045 | 0.9832 |
| aarch64 | 3-0 | 1.0031 | 1.0152 | 0.9902 | 1.0245 |
| aarch64 | 3-1 | 1.0097 | 1.0125 | 1.0175 | 1.0089 |
| aarch64 | 3-199 | 1.0198 | 1.0131 | 0.9866 | 1.0203 |
| aarch64 | 3-1999 | 0.9922 | 0.9860 | 1.0051 | 1.0074 |
| aarch64 | 33-199 | 0.9957 | 1.0077 | 0.9922 | 1.0169 |
| aarch64 | 129-199 | 0.9808 | 0.9855 | 1.0100 | 0.9989 |

For the 129×199 decision case, both controls stay within 2% on each host, but
neither variant reaches 0.95 of unchanged fwp's time. The observed reductions
are only 0.4–1.9%. Smaller cases include slowdowns and controls outside 2%; a
promising isolated ratio does not establish an improvement. A second run is
required before selecting a candidate that passes the first screen. Since
neither passes, no repeated run was used to seek a favourable outcome.

All three fwp variants reproduce each accepted output and memory profile. The
largest case still has 459 allocation requests, 216,925 requested bytes, zero
retains and a 7,200-byte managed peak. Managed and raw storage end at zero, with
no tracing collections. The raw data records instruction sizes, actual machine
code and static/dynamic frame estimates; fewer call sites alone would not prove
faster execution.

The subsequent [direct-call change](direct-call-entries.md) removes unused
generic adapters, and [local captures](callback-locals.md) reduce code and stack
storage further. Both shipped in [PR #198](../roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198).
Those results do not change this failed inlining experiment or establish a timing
gain. The [plan](../../PLAN.md) keeps ownership and numerical performance gaps open.
