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

Source `12ce47ad00f28bdc32235c31e04204a7526a0f8f` passes both Linux jobs in
[run 39728410578](https://github.com/e6qu/fun-with-pipes/actions/runs/39728410578).
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
| AMD64 | 4,096 / 64 | 1.391 | 1.832 | 2.754 | 2.649 | 2.960 | 1.90× | 1.45× |
| AMD64 | 65,536 / 1,024 | 10.671 | 15.319 | 34.825 | 32.378 | 32.403 | 3.03× | 2.11× |
| ARM64 | 4,096 / 64 | 1.088 | 1.451 | 2.265 | 2.172 | 2.172 | 2.00× | 1.50× |
| ARM64 | 65,536 / 1,024 | 9.521 | 12.319 | 26.632 | 24.831 | 24.749 | 2.61× | 2.02× |

For the larger input, new ARC takes 6.8–7.0% less time than the recompiled ARC
baseline in these sessions. It still takes **161–203% more time than C** and
**102–111% more than Rust**. The smaller AMD64 tracing case is 3.0% slower than
its tracing baseline. These observations retain that slower result and do not
promise the same timing elsewhere or isolate the cost of one language feature.

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
single-process peak resident-memory observations are 7.9–8.7 MB for new ARC,
10.4–11.4 MB before, 4.4–4.6 MB for C and 6.1–6.3 MB for Rust. Resident memory
includes the whole process and must not be equated with managed charged bytes.
ARC machine-code sections grow from 47,330 to 48,706 bytes on AMD64 and from
46,956 to 48,204 bytes on ARM64. The allocation savings therefore have a code-size
cost. Whole executable files are 102,288 and 152,760 bytes respectively; section
sizes and file sizes measure different things. No stack-usage reduction is claimed.

## Correctness and remaining validation

[Focused run 39727552658](https://github.com/e6qu/fun-with-pipes/actions/runs/39727552658)
passes at the measured source on Linux, macOS and Windows, ARM64/AMD64. Inspection
covers 192 native images and 180 interpreter/native output comparisons, including
aliases, caught errors, failure/cancellation cleanup and deliberately broken
cleanup controls at O0/O2. The paired comparison adds 48 native images and 24
WASI modules. ARC images have no tracing scan/mark/sweep symbols.

The five older reuse tests silently skipped Windows at that source. Their results
do not establish Windows reuse coverage. Source
`15ee3615d2df858f508ec459e6305fa163037917` repairs them and passes all six hosts in
[run 39730741666](https://github.com/e6qu/fun-with-pipes/actions/runs/39730741666),
with 19 test functions per host, including six actual reuse tests. It
makes native compilation failures fail the golden/reuse checks, and adds explicit
missing-compiler controls. It also fixes both age checks for large immutable
objects: those allocations have one age mark, while small allocations use a
per-slot bitmap. Reusing an older immutable object could otherwise hide references
to younger data from a minor collection. Mutable arrays retain their separate,
rescanned reuse rule.

The regression collects real small/large immutable/mutable objects, checks
shared owners and tests both normal and poison-copy reuse verification. Removing
either large-object age check fails its control. Inspection covers 228 native
images and 180 interpreter/native comparisons at the repaired revision. Its paired
benchmark run `39731820120` is still pending; the timing table above belongs to
the earlier measured revision.

The map lowering also runs for WebAssembly. A new WASI fixture exercises the
same five inputs, shared list/tail/string aliases, dynamic callbacks and caught
errors, retaining O0/O2 modules and a missing-free control. Local interpreter
output matches all five accepted native references, but WASI execution of this
new fixture is still pending. Final production and documentation checks remain
required before delivery.
