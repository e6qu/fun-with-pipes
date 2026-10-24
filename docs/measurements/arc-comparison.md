# Checked ARC compared with C and Rust

This comparison runs seven small programs compiled from fwp, handwritten C and
handwritten Rust. fwp uses automatic reference counting (ARC): an object is
released when its last owner releases it. It does not run the tracing collector.
This establishes a current measurement baseline, not a compiler speedup.

## Programs and timing

The [program table](../benchmarks.md#what-each-program-actually-does) defines
the exact input and calculation for each example. For instance, `loop` starts
at 100,000,000, repeatedly adds `(i*3)%7` to a sum and decrements `i` to zero.
`text-length` counts the decimal digits of `i` and `3*i`, plus a separator,
for two million inputs. It avoids constructing the text in all three languages.

Each executable has one warmup and six measured fresh-process runs. Execution
order rotates so each language occupies each position twice. Every run must
print the same result. Times include process startup, input construction,
computation, allocation, printing and shutdown. Compilation is measured once
separately. No sample is removed. These are shared GitHub runners; six samples
in one session cannot establish a stable performance budget.

[Run 40075912779](https://github.com/e6qu/fun-with-pipes/actions/runs/40075912779)
passed on native Linux AMD64 and ARM64 at source
`617bb2319760ccade91afea2bb0045c1984abbdf`, retained by
`roadmap/revision-arc-benchmark-617bb2319760`. Both complete logs are audited.
The AMD64 runner reports AMD EPYC 9V45; ARM64 reports Neoverse-N2. Both use
GCC 13.3.0 for C and generated C at O2, and Rust 1.99.1 with `-O`.
fwp explicitly selects `--gc arc` and `FWP_LTO=0`, meaning no link-time
optimization. [All samples, hardware details, hashes and reports](arc-comparison-2026-10-24.json)
remain available.

## Observed results

The median averages the middle two sorted samples. Extra time is
`(fwp / peer - 1) * 100%`: positive means fwp took longer; negative means less.
It is not a separate measurement of the language's overhead.

| Host | Program | C ms | Rust ms | fwp ms | Extra vs C | Extra vs Rust |
|---|---|---:|---:|---:|---:|---:|
| AMD64 | `fib` | 10.102 | 17.842 | 8.699 | -13.9% | -51.2% |
| AMD64 | `loop` | 54.258 | 65.664 | 73.490 | +35.4% | +11.9% |
| AMD64 | `map` | 269.431 | 231.702 | 239.911 | -11.0% | +3.5% |
| AMD64 | `pipeline` | 13.437 | 10.123 | 7.267 | -45.9% | -28.2% |
| AMD64 | `range-set` | 8.730 | 8.783 | 8.762 | +0.4% | -0.2% |
| AMD64 | `strings` | 72.418 | 86.898 | 3.931 | -94.6% | -95.5% |
| AMD64 | `text-length` | 2.450 | 4.147 | 3.748 | +53.0% | -9.6% |
| ARM64 | `fib` | 17.636 | 21.578 | 6.790 | -61.5% | -68.5% |
| ARM64 | `loop` | 90.515 | 86.569 | 130.616 | +44.3% | +50.9% |
| ARM64 | `map` | 493.731 | 449.293 | 449.415 | -9.0% | +0.0% |
| ARM64 | `pipeline` | 26.636 | 19.578 | 15.692 | -41.1% | -19.8% |
| ARM64 | `range-set` | 11.086 | 11.090 | 11.918 | +7.5% | +7.5% |
| ARM64 | `strings` | 141.342 | 147.241 | 6.179 | -95.6% | -95.8% |
| ARM64 | `text-length` | 3.037 | 5.621 | 5.954 | +96.0% | +5.9% |

The integer loop remains slower on both hosts. `text-length` remains slower than
C on both hosts and is slightly slower than Rust on ARM64. Faster `strings`
results chiefly reflect eliminated formatting work: its C/Rust peers still build
text. The pipeline implementations also do different amounts of intermediate
storage work. Maps use the same sorted-pair search structure but different sorts.

Except for `text-length`, the C and optimized Rust peers do not provide fwp's
checked signed-arithmetic guarantees. The measured inputs fit, but the optimizers
have different obligations. These ratios therefore compare the named complete
implementations; they do not isolate ARC, allocation, overflow checks or compiler
quality. No ARC-versus-tracing speedup can be inferred from earlier runs on
other revisions or hosts. The next arithmetic comparison must match those checks
and preserve trap order before choosing a compiler change.

## Binary and storage evidence

Independent inspection covers all **42 actual measured executables**, including
all fourteen fwp programs. Their ELF architecture and executable headers match
the native hosts. Source inputs match the recorded commit; six positive samples
per language/program reproduce the reported medians. Generated C selects ARC,
and all fwp symbol tables exclude tracing scan/mark/sweep functions.

The report records whole-file sizes and instruction-section sizes. Instruction
sections include alignment padding; whole files also include linking/runtime
choices and non-code data. Neither number alone measures memory in use. Four
corrupted-copy controls per host must fail: wrong memory mode, wrong machine
architecture, object file in place of executable, and a missing timing sample.
Review uses disassembly without executing downloaded programs.

This comparison does **not** measure allocation counts, peak live memory, ARC
traffic or stack frames. Those need separately scoped measurements; prior
ownership reports cannot be relabelled as measurements of these binaries.
Compilation times are one observation per program, including tool startup and
linking but excluding the build of the fwp compiler itself.

Use the [explicit reproduction command](../benchmarks.md#running-comparisons)
and retain the native artifacts. Focused verification is not the nine-job
production acceptance required for the next PR.

## Separate memory measurements

[Run 40076674217](https://github.com/e6qu/fun-with-pipes/actions/runs/40076674217)
passes both native hosts at source `b16ed5e33f29774c2d56e5500c8d7548ea52ce06`.
It repeats timing and adds separate memory measurements. AMD64 now reports EPYC
9V74, not the earlier 9V45; ARM64 reports Neoverse-N2. The compiler, runtime and
benchmark programs are unchanged. [Both complete reports and reviews](arc-memory-2026-10-24.json)
retain the new timing samples, including AMD64 pipeline's slower result than
Rust. Different host/session times do not measure a compiler change.

GNU time records peak resident set size (RSS), the physical pages resident for
the process, in three fresh runs of each actual timed executable. The table
shows ranges in KiB, where 1 KiB is 1,024 bytes. It includes runtime/startup
storage; it is not an allocation count or maximum logical live payload.

| Host | Program | C peak KiB | Rust peak KiB | fwp peak KiB |
|---|---|---:|---:|---:|
| AMD64 | `fib` | 1640–1704 | 2024 | 1972 |
| AMD64 | `loop` | 1636–1640 | 2024–2152 | 1980–2108 |
| AMD64 | `map` | 16860–16864 | 9820–9912 | 28104 |
| AMD64 | `pipeline` | 14816–14820 | 9844–9960 | 1980 |
| AMD64 | `range-set` | 9420–9428 | 9792–9808 | 10532–10648 |
| AMD64 | `strings` | 1640–1704 | 2028–2272 | 1784–1912 |
| AMD64 | `text-length` | 1640–1704 | 2024–2152 | 1780–1784 |
| ARM64 | `fib` | 1364–1380 | 1572–1696 | 1376–1392 |
| ARM64 | `loop` | 1316–1380 | 1572–1696 | 1652 |
| ARM64 | `map` | 16420–16484 | 9312–9440 | 26488 |
| ARM64 | `pipeline` | 13028 | 9472–9488 | 1652 |
| ARM64 | `range-set` | 9060–9124 | 9316–9380 | 9568–9584 |
| ARM64 | `strings` | 1368–1380 | 1568–1692 | 1396 |
| ARM64 | `text-length` | 1316–1380 | 1568–1688 | 1396 |

In this baseline, the map's fwp process uses more peak memory than both peers.
The storage change below separates sort workspace from final result storage. The pipeline uses much less because
fwp removes intermediate collections that its peers construct.

Separate instrumented fwp executables count from **after constant initialization
through language cleanup**. A managed request is a request for runtime-owned
value storage, not necessarily a system allocator call. Charged bytes are the
runtime's accounting for that storage, excluding raw runtime buffers, allocator
metadata and stacks. Both hosts report the same counts:

| Programs | Requests | Requested bytes | Retains | Peak charged bytes | Final added charged bytes |
|---|---:|---:|---:|---:|---:|
| `fib`, `loop`, `pipeline`, `strings`, `text-length` | 0 | 0 | 0 | 0 | 0 |
| `map` | 4 | 24,000,032 | 1 | 24,000,008 | 0 |
| `range-set` | 1 | 8,000,008 | 0 | 8,000,008 | 0 |

Every ordinary profile performs zero tracing collections. Each has a paired
control that deliberately leaves a 16-byte managed allocation unreleased. All
fourteen controls across both hosts record one extra request, sixteen extra
requested bytes and sixteen final charged bytes. Thus the observer notices the
introduced retention. This is not proof that every allocation path is covered.
C/Rust managed-allocation counts are not measured.

Independent review covers **42 timed images and 28 separate instrumented images**,
the exact generated-C transformations, all RSS/profile samples, fourteen leak
controls and eight corrupted-artifact controls. Instrumented binary sizes and
compiler stack reports are retained separately; they cannot describe the original
timed program's stack use. No instrumented or GNU-time run contributes to the
elapsed-time table above.

## Releasing map sort storage sooner

The typed map builder used to keep input, sort scratch and result buffers alive
together. It now compacts sorted borrowed words into the input lanes and releases
sort scratch before allocating the result. Callers keep the original owners alive
and discard the lanes after the call; numeric builders contain unboxed values.
First-key identity and last-value duplicate handling stay unchanged.

[Run 40078376733](https://github.com/e6qu/fun-with-pipes/actions/runs/40078376733)
measured source `6a6e8eea325cc3183e39cd472209cd452c497089` on EPYC 9V74 and
Neoverse-N2, with the same GCC O2, ARC and measurement scopes defined above.
The program builds 500,000 key/value pairs and performs 2,000,000 lookups.
On both hosts, the map's peak managed charge fell **24,000,008 → 16,000,008 bytes**.
It still requests four allocations totalling 24,000,032 bytes, performs one retain
and returns to zero final added charge. This change reduces overlapping storage;
it does not eliminate allocations or counting.

| Host | Earlier map peak RSS KiB | New map peak RSS KiB | New C / Rust peak RSS KiB |
|---|---:|---:|---:|
| AMD64 | 28104 | 19420 | 16860–16864 / 9784–9892 |
| ARM64 | 26488 | 18160–18168 | 16420–16484 / 9440–9504 |

RSS observations come from different processes and runner sessions; they are not
a controlled timing comparison. The [complete reports](map-scratch-2026-10-24.json)
retain all seven programs, their new elapsed samples, RSS, charged-storage counts,
source/binary hashes and stack reports. Review covers 42 timed images, 28 separate
instrumented images, fourteen detected leaks and eight corrupted-artifact controls.
No timing improvement or general C/Rust parity is claimed.

The timed map instruction section grows from 14,290 to 14,306 bytes on AMD64
and stays at 13,612 on ARM64. Whole executables remain 48,240 / 82,128 bytes.
Separate instrumented stack reports keep the main/runtime-thread frames at
128/272 bytes on AMD64 and 160/288 on ARM64; GCC marks the AMD64 runtime-thread
frame dynamic but bounded. The recursive sorting function keeps a 64-byte frame
on both hosts. These reports describe instrumented functions, not
maximum call-chain stack use or the timed executable's frames.

[Six-host map checks](https://github.com/e6qu/fun-with-pipes/actions/runs/40078374681)
pass thirteen tests per host, using GCC on Linux and Clang elsewhere. Each checks
ARC and tracing, aliases, duplicate handling, callback failures and reuse. Fault
injection covers 136 failures normally and 138 with tracing reuse verification,
including comparisons during sorting and compaction after scratch release.

A separate 4,096-key fixture puts its input lanes on the stack to isolate builder
storage. Ordinary map/set peaks are 65,544 / 32,776 charged bytes, ending at zero.
Deliberately delaying scratch release raises them to 131,080 / 65,544 and must
fail the budget with exit 241. These fixture peaks exclude the input lanes; the
whole-program profile above includes its heap input. The [repeat run](https://github.com/e6qu/fun-with-pipes/actions/runs/40079580345)
passes all six hosts at `4c294917006b2688a491d088a0cab297b07d274c`.
[Independent review](map-scratch-native-2026-10-24.json) covers 138 actual images,
96 peak observations, comparison/cleanup failures and reuse controls. Saved C
matches the recorded builder, and each negative-control source makes exactly its
intended change. ARC images exclude tracing symbols; tracing controls include them.
Full production acceptance of the eventual PR remains separate.
