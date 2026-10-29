# Current word-frequency baseline protocol

This is a new baseline for V1/B1, declared before its runner or measurements.
It replaces neither the [historical comparison](wordfreq.md) nor any failed D2/N1
result. Its purpose is to establish current whole-program costs and measurement
variation before choosing a word-frequency optimization or its timing budget.
No speedup or timing acceptance is claimed by a successful measurement job.

## Same work, stated differences

Use the maintained `examples/wordfreq.fwp` and the existing C/Rust peers in
`tests/fixtures/wordfreq_bench.{c,rs}`. Preserve the two inputs: 4,096 words with
64 distinct words and 65,536 words with 1,024 distinct words. Generation, the
independent Python result and seven empty/separator/tie/punctuation controls
come from `scripts/measure-wordfreq.py`. Check every complete output.

All peers normalize words, count in sorted contiguous key/count pairs, rank and
print five results. C/Rust combine the three normalization operations; fwp uses
its ordinary strings, lists and maps. Inputs are ASCII. This does not compare
arbitrary Unicode or all language features. Time the complete fresh process:
startup, input reads, normalization, counting, ranking, printing and cleanup.
Exclude input generation, compilation and evidence writes from that interval.

## Hosts, settings and repetitions

Run two independent sessions on each of the existing four-processor hosts:
Neoverse-N2 ARM64 and EPYC 7763 AMD64. Qualify the CPU, processor count,
architecture and exact compiler versions before building or executing. Use the
current pinned baseline toolchains: Rust 1.99.1, GCC 13.3 on ARM64 and GCC 15.2
on AMD64, with the full identities checked by `descent-baselines.py`.
Keep rejected hosts and do not count them as measurement sessions.

Use generated C at O2 with explicit `-march=armv8-a` or `-march=x86-64`,
`-ffp-contract=off` and no LTO. Rust uses O2, overflow checks and explicit
`target-cpu=generic` or `target-cpu=x86-64`. Enable ordinary ownership, stack
storage and unique reuse explicitly for fwp. Record all commands, settings,
compiler versions and source identities. Ordinary builds need no previous fwp.

Each session has four labels: C, Rust, fwp and a byte-identical copy of fwp.
Require matching hashes for that copy before running it. For each input use two
warmup rounds followed by **16 measured rounds**, with **64 fresh processes per
label per round**: 1,024 measured processes per label. These counts are fixed
before seeing the new results; they exceed the old 24-process observations.

Use the existing balanced four-label schedule with seed **20261030**. Rotate the
16-entry cycle by one place per round and repeat it sixteen times within that
round. Preserve ordinary allowed CPU affinity and every observation, including
outliers. Processes in one round are samples, not independent runner sessions.

Sum each label's process times per round and report the median of the sixteen
round totals, its per-process equivalent, fwp/C and fwp/Rust ratios and the
fwp/copy ratio. Also retain all individual times, round totals, execution orders,
stdout, stderr and exit statuses. Partial failure output must survive a failed
or timed-out child. Do not rerun unchanged measured sessions until they pass.

## Memory, representation and subsequent budgets

Keep managed allocation requests/bytes, retains and peak/final charged bytes in
separate instrumented fwp executions; require final live charge zero. Record
fresh-process peak RSS separately for each peer. These quantities have different
scopes; they do not establish C/Rust allocation-count parity. Inspect native ELF
headers and retain binary/section sizes and GCC stack reports. No disassembly is
needed to diagnose source correctness or accept these observations.

After all four sessions are audited, publish a workload-specific budget table
from their timings and identical-copy variation, before implementing a candidate.
If variation prevents a useful comparison, record that limitation and repair the
measurement rather than accepting a noisy candidate. No universal percentage is
imported from another workload, and no D2/N1 limit changes. The final evidence
must make it clear whether it is a baseline, an inconclusive comparison or an
accepted optimization.
