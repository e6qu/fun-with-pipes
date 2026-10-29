# Measure work skipped by an already ordered sort

**Historical experiment; neither candidate was adopted.**

The map benchmark builds 500,000 key/value pairs, sorts them, and performs two
million lookups. [Peer measurements from that revision](checked-peers.md) compare this complete
program with C and Rust. This experiment compares two proposed fwp changes with
unchanged fwp in the same runner session. Neither candidate is adopted.

The runtime's stable merge sort sorts each half, then merges them. **Stable**
means equal keys retain their original order. Maps depend on that order: repeated
keys keep the first key object and the last associated value.

Two candidates skip work using the existing total-order comparator:

- After both halves are sorted, skip merging when the largest left key is no
  greater than the smallest right key. Their concatenation is already sorted.
- Also check whether the input range is already sorted before recursing.
  This can avoid recursive calls on ordered runs, but adds comparisons elsewhere.

The actual AMD64 map binary already has a specialized integer comparison; an
extra comparator wrapper is unnecessary. Reusing the input buffer as the final
map would instead require changing its separate key/value layout, adding the
map header and handling excess capacity after duplicate removal. That is a
separate storage decision, not part of this experiment.

## Checks and acceptance screen

Both native Linux architectures compile saved generated C at GCC O2 with
`-std=gnu11 -ffp-contract=off`, checked ARC and no link-time optimization.
The runtime and compiler sources are unchanged. Each candidate differs only by
the stated early return conditions. An exact executable copy of the baseline
provides a noise control.

Before timing, four derived images check signed integer sorting on lengths
0, 1, 2, 3, 17 and 257: ordered, descending, repeated, alternating and permuted
keys. Each case checks both separate key/value lanes and the shared lane used
by sets. Original indices verify stability among equal keys. An independent
Python sort supplies expected results. Deliberately omitting the merge must
produce wrong results. These correctness probes are not timing samples.

Every allowed CPU is tested separately, with two warmups and 32 fresh-process
samples per variant for each of the seven maintained programs. Order rotates
and reverses. Record elapsed and child CPU time; both include startup, output
and shutdown. Compilation is excluded. CPU placement does not fix frequency or
hypervisor contention.

The predeclared screen requires, on every tested CPU and both time measures:

- Baseline versus its identical copy differs by at most 3%.
- The map candidate improves by at least 5%.
- No other program slows by more than 3%.

Keep every sample and failed or inconclusive screen. Inspect actual binaries,
code-section sizes and compiler stack reports. A passing screen still requires
broader type/callback/alias/failure tests and full production acceptance before
adopting a runtime change. It is not a universal sorting or C/Rust parity claim.

## Historical reproduction

This experiment is closed; its runner command is removed from the current
workflow. The old reader required the retired `memory: arc` report schema.
Use the [original source and workflow](https://github.com/e6qu/fun-with-pipes/tree/cbacdff5e8cb33772dec72bfba7f2c7b027b4229)
when reviewing how the recorded experiment ran. Its
[collector](https://github.com/e6qu/fun-with-pipes/blob/cbacdff5e8cb33772dec72bfba7f2c7b027b4229/scripts/measure-map-order.py)
and [image reader](https://github.com/e6qu/fun-with-pipes/blob/cbacdff5e8cb33772dec72bfba7f2c7b027b4229/scripts/inspect-map-order.py)
remain available at that revision; they are not maintained current commands.
[Results](map-order-results.md) retain both candidates' failed screens on both
native Linux hosts. No sorting shortcut was adopted.
