# fwp compared with Swift, C and Rust

Four native sessions complete at `80a0504a97f7c96291e77be6e8f843d5cb8c7391`,
in [run 41214191081](https://github.com/e6qu/fun-with-pipes/actions/runs/41214191081).
The [separate audit](https://github.com/e6qu/fun-with-pipes/actions/runs/41215212017/job/124578208152)
rechecks all four artifacts without executing their binaries. Full job logs have
no unexpected compiler diagnostics. The container package manager notes an absent
C++ manual page; compilation, arithmetic and ownership controls pass.
These measurements precede the merge of PR #234. Its full production acceptance
is recorded in [delivery history](../roadmap-history.md); the focused measurement
jobs did not replace that matrix. The [summary JSON](swift-peers-2026-10-31.json) retains every
session's timings, all copy-control ratios, RSS samples and artifact identities.

## What the numbers mean

The [protocol and seven inputs](../benchmarks.md#swift-comparison) use GCC 13.3,
Rust 1.99.1 and Swift 6.4.2. Each Linux job has four available CPUs. Swift uses
language mode 6, optimized checked builds and ordinary arrays/closures. C and
fwp use O2; no peer uses LTO. The timer includes process startup, construction,
computation, output and cleanup. It excludes compilation. A C output precheck
precedes two warmup rounds and 24 measured rounds. Every language also runs a
byte-identical copy; a median difference above 2% makes the whole case/session
inconclusive. A successful CI job means records and results are valid, not that
all timing controls passed.

Automatic reference counting (ARC) tracks owners so storage can be released
when its last owner disappears. Compilers can remove unnecessary count updates.
These compare complete implementations, not isolated ARC overhead. The pipeline
peers construct arrays that fwp eliminates; fwp's string-length calculation avoids
formatting performed by the other `strings` peers. Sorting implementations differ.
The very large observed Swift pipeline cost needs attribution before an ARC or
language-wide claim; this report supplies no such attribution.

## Repeated ARM64 measurements

Both sessions use Neoverse-N2 and matching toolchains. Values are ranges of the
two session medians in **milliseconds per complete process**, not confidence
intervals. Inconclusive rows remain visible and do not qualify as speed results.

| Program | C ms | Rust ms | Swift ms | fwp ms | Copy controls |
|---|---:|---:|---:|---:|---|
| fib | 34.23–34.30 | 31.56–31.69 | 36.36–36.57 | 7.03–7.25 | Both pass |
| loop | 179.15–179.73 | 116.43–116.91 | 118.46–118.54 | 133.29–134.32 | Both pass |
| map | 499.73–504.96 | 437.12–443.57 | 729.38–741.61 | 462.16–465.00 | Both inconclusive |
| pipeline | 28.59–28.75 | 23.89–24.37 | 1482.67–1484.70 | 14.47–15.34 | Both inconclusive |
| range-set | 11.08–11.38 | 11.31–11.53 | 13.70–14.05 | 12.19–12.53 | Both pass |
| strings | 145.30–145.35 | 145.43–145.64 | 201.19–203.69 | 4.05–4.16 | Both pass |
| text-length | 3.26–3.35 | 6.95–7.04 | 7.25–7.65 | 3.94–4.06 | Both pass |

The checked loop takes 12.4–13.4% longer than Swift and 14.0–15.4% longer than
Rust. Direct character counting takes 45.6–46.9% less time than Swift, but
21.1–21.4% more than C. Ordered set/hash takes about 11% less time than Swift
and 10% more than C. These three comparisons pass both sessions' controls.
The map fails Swift's copy control at 2.12% / 2.15%; the pipeline fails fwp's at
2.07% / 6.28%. Keep those failures and do not retry unchanged observations.

## Resident memory

These are **MiB (1,048,576 bytes) of peak resident RAM**, from three separate runs per executable
in each ARM64 session. They include process startup, runtime libraries and
allocator storage. They are neither cumulative allocated bytes nor isolated ARC
metadata. None of these profiled runs supplies a timing sample.

| Program | C MiB | Rust MiB | Swift MiB | fwp MiB |
|---|---:|---:|---:|---:|
| fib | 1.28–1.35 | 1.52–1.66 | 8.03–8.04 | 1.35–1.36 |
| loop | 1.29–1.35 | 1.54 | 8.03–8.04 | 1.54–1.74 |
| map | 16.04–16.10 | 9.27–9.29 | 18.92–18.98 | 16.86–17.00 |
| pipeline | 12.73–12.79 | 9.27–9.39 | 22.63–22.64 | 1.61 |
| range-set | 8.85–8.91 | 9.15–9.16 | 15.71–15.84 | 8.93–8.99 |
| strings | 1.29–1.35 | 1.53–1.66 | 8.16 | 1.30–1.36 |
| text-length | 1.29–1.35 | 1.54–1.66 | 7.90–8.04 | 1.35–1.36 |

fwp's small scalar programs occupy roughly 1.3–1.7 MiB here, versus about 8 MiB
for Swift. The sorted map still uses about 16.9 MiB in fwp versus 9.3 MiB in Rust.
Lower resident memory alone does not prove fewer ARC operations: runtime and
representation differences are included. Swift allocation/count instrumentation
remains open; the [PR #233 fwp profiles](../benchmarks.md#pr-233-whole-program-baseline)
are separate observations from #233, not profiles of these new executables.

## AMD64 observations are not a matched pair

Session 1 uses AMD EPYC 9V45; session 2 uses Intel Xeon Platinum 8573C. Preserve
both, but do not combine them into a repeated-host result. Below, fwp/Swift is
elapsed-time ratio: 1.20× means fwp took 20% longer. “Pass” refers only to that
session's four-language copy controls; it does not establish repeatability.

| Program | EPYC 9V45, session 1 | Xeon 8573C, session 2 |
|---|---:|---:|
| fib | 0.284× (pass) | 0.260× (pass) |
| loop | 1.204× (inconclusive) | 1.250× (pass) |
| map | 0.607× (pass) | 0.604× (pass) |
| pipeline | 0.009× (pass) | 0.014× (pass) |
| range-set | 1.079× (inconclusive) | 1.047× (inconclusive) |
| strings | 0.035× (inconclusive) | 0.028× (inconclusive) |
| text-length | 0.479× (pass) | 0.470× (inconclusive) |

The JSON retains all C/Rust/Swift/fwp medians and RAM observations on both CPUs.
These rows do not replace the older matched-host CPU or numerical budgets.

## Ownership controls and remaining work

Each host also passes 33 dynamic Swift loop cases and intentionally removed
overflow checks. A separately compiled native Swift closure factory checks the
same two operations as the [returned-callable comparison](returned-callables.md),
including 0/1/16/4,096 invocations and twelve trapping cases. Its returned function
value is 16 bytes, aligned to eight bytes; that is not its total captured storage.
A separate reference-capture control observes normal release and detects an
intentionally retained closure. It does not count scalar-closure allocations.

The [closure phase comparison](callable-phases.md) now measures construction,
invocation and release against the same fwp source with its count optimization
disabled. It retains three AMD64 construction regressions and failed noise
controls. Add Swift allocation and ARC-operation observations before attributing
costs to ownership. Keep
parser, weak-subscription and numerical Swift comparisons as explicit missing
coverage. The existing D2/N1 timing failures remain open. Prioritize measured
execution time and working memory, retaining executable-size costs as context.
