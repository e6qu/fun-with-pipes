# Moving strings through a list map

`words` splits text at whitespace. `map` applies a function to each list element;
that function is called its callback. For example:

```fwp
normalize = lower | replace "," "" | replace "." ""
main = "ONE, two. TWO" | words | map normalize | echo
```

This prints `["one", "two", "two"]`: each word is lowercased, then commas and
periods are removed. The previous map keeps the whole input list alive and gives
each callback another counted reference to its string. That extra owner can
prevent an otherwise private string from being changed in place.

The compiler selects `map` calls with both arguments supplied and a known
`String -> String` callback that stores no captured runtime values. Before reference-count insertion, it gives
that call an internal contract that consumes the input list. A unique node moves
its string and tail to their next owners. At the first shared node, map keeps the
remaining list alive and gives callbacks separate string references. Existing
list, tail and element aliases therefore keep their values. Output nodes remain
fresh: a callback can collect, so changing older immutable nodes would require a
separate collector proof. Changed ASCII case conversions can reuse unique young
string storage; shared, static and older storage is copied.

Other element types, captured callbacks and unknown callbacks keep their current
contract. No syntax or public primitive is added. Resource-bearing inputs need
separate lifetime reasoning; this change does not establish it.

## Application measurements

Source `15ee3615d2df858f508ec459e6305fa163037917` passes both Linux jobs in
[run 39731820120](https://github.com/e6qu/fun-with-pipes/actions/runs/39731820120).
The [complete report](string-map-2026-10-22.json) retains samples, toolchains,
inputs, build times, memory observations and independently inspected binaries.
The baseline is `54b01db94079e692cddf8ec3fc56ee064c7bbbf1` from run `39699466703`;
its saved C is recompiled beside the candidate in each runner session.

The maintained [word-frequency program](../../examples/wordfreq.fwp) reads text,
normalizes each word, counts occurrences and prints five results. All peers use
sorted contiguous pairs for counting. C/Rust combine normalization into one pass;
fwp still performs three string operations and uses its string/list/map layouts.
These ASCII inputs do not measure general Unicode processing. See the
[comparison protocol](../application-acceptance.md#word-frequency-comparison).

Times are medians of 24 balanced-order fresh-process samples after two warmups.
They include startup, reading, normalization, counting, ranking, output and
cleanup; input generation, compilation and separate profiling are excluded.
Hosts are AMD EPYC 7763 and ARM Neoverse-N2; both use GCC 13.3 O2 and Rust 1.99.1
opt-level 2 with overflow checks. Link-time optimization and stress checks are off.

| Host | Words / distinct words | C ms | Rust ms | Before ARC ms | New ARC ms | New tracing ms | ARC / C | ARC / Rust |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| AMD64 | 4,096 / 64 | 1.334 | 1.828 | 2.887 | 2.991 | 2.616 | 2.24× | 1.64× |
| AMD64 | 65,536 / 1,024 | 10.644 | 15.330 | 34.651 | 32.488 | 32.328 | 3.05× | 2.12× |
| ARM64 | 4,096 / 64 | 1.262 | 1.683 | 2.555 | 2.457 | 2.422 | 1.95× | 1.46× |
| ARM64 | 65,536 / 1,024 | 9.917 | 12.888 | 27.567 | 25.457 | 25.459 | 2.57× | 1.98× |

For the larger input, new ARC takes 6.2–7.7% less time than the recompiled ARC
baseline in these sessions. It still takes **157–205% more time than C** and
**98–112% more than Rust**. The smaller AMD64 ARC case is **3.6% slower** than
its baseline, within the previously chosen 5% screen. Its observed samples span
2.52–3.65 ms, versus 2.59–3.54 ms before; that overlap does not identify a cause.
These measurements do not establish an improvement for every input.

The earlier paired run at `12ce47ad00f2` is retained in the complete report. It
also reduces larger-case ARC time and gives identical managed counts, but its
smaller AMD64 tracing case is 3.0% slower. Keep both sessions and their slower
results; do not average different revisions into a claimed compiler speedup.

## Storage

Both hosts and both fwp memory modes give these counts for 65,536 words:

| Whole-program observation | Before | New string map |
|---|---:|---:|
| Managed allocation requests | 248,807 | 226,961 |
| Requested bytes | 7,852,294 | 7,428,480 |
| Counted retains | 138,250 | 72,714 |
| Peak charged storage | 7,794,440 | 5,465,713 |
| Final charged storage / collections | 0 / 0 | 0 / 0 |

These meet the previously set limits of 230,000 requests, 80,000 retains and
7,794,440 peak charged bytes. Both ARC time ratios also meet the 1.05× baseline
screen. Counts exclude raw buffers, stacks and allocator metadata. Separate
single-process peak resident-memory observations are 7.7–8.9 MB for new ARC,
10.3–11.3 MB before, 4.4–4.6 MB for C and 6.1–6.3 MB for Rust. Resident memory
includes the whole process and must not be equated with managed charged bytes.
ARC machine-code sections grow from 47,330 to 48,722 bytes on AMD64 and from
46,956 to 48,204 bytes on ARM64. The allocation savings therefore have a code-size
cost. Whole executable files are 102,288 and 152,760 bytes respectively; section
sizes and file sizes measure different things. No stack-usage reduction is claimed.

## Correctness and delivery

The [six-host native run](https://github.com/e6qu/fun-with-pipes/actions/runs/39730741666)
passes at the measured source on Linux, macOS and Windows, ARM64/AMD64. There are
19 test functions per host across seven targets; Linux AMD64 also passes 176
compiler unit tests. Inspection covers 228 native images and 180 interpreter/native
comparisons at O0/O2, including aliases, caught errors, failure/cancellation and
deliberately broken cleanup controls. The paired comparison adds 48 native images
and 24 WASI modules. ARC images omit tracing scan/mark/sweep symbols.

Five older reuse tests had silently skipped Windows, and the reuse corpus ignored
native compilation failures. Both are repaired: the six current reuse tests
execute on Windows, intentional front-end errors match their diagnostics, and
unexpected native build failures fail the test. Missing-compiler controls prove
that the golden and reuse checks cannot report success without a C compiler.

The same batch repairs both age checks for large immutable objects. Large
allocations have one age mark; small objects use a per-slot bitmap. Reading the
wrong representation could allow reuse after collection and hide new child
references from a minor collection. The regression collects actual small/large,
immutable/mutable objects and checks aliases and poison-copy reuse verification.
Removing either large-object check makes its control fail. Mutable arrays keep
their separate rule because minor collection rescans them.

The [WASI run](https://github.com/e6qu/fun-with-pipes/actions/runs/39733027038)
passes on both Linux hosts at `66f4a2f6dc9a02baba7154ec5c81923df8d0db29`.
Only tests and documentation differ from the measured native source. It exercises
the same five map inputs, shared list/tail/string aliases, dynamic callbacks and
caught errors. Eight independently inspected O0/O2 modules cover correct physical
cleanup and a deliberately omitted free, with exact interpreter output checks.
[PR #194](../roadmap-history.md#string-map-ownership-and-native-reuse-checks-pr-194) records passing final production and documentation gates.
The focused evidence above retains its original revision.
