# Compiler CPU samples, November 10

**Direct caller decoding passes on both architectures; unnamed frames remain.** This is a
compiler-cost investigation, not a speedup result. The
[protocol](../compiler-checking.md#cpu-sampling-protocol) defines the
four applications, CPU event, stack/register settings and acceptance checks.

Each application has one ordinary and one sampled fresh-process emit-C build.
The compiler is release-optimized with full debug information. Neither GCC nor
the generated application runs. Exact C equality is required. Raw samples locate
CPU work; they do not measure allocation bytes, ARC overhead or elapsed speedup.

## Attempts and repairs

| Run | Source | Outcome and repair |
|---|---|---|
| [42750772791](https://github.com/e6qu/fun-with-pipes/actions/runs/42750772791) | `f26b3723a` | AMD64 package moved in Ubuntu 26.04. ARM64 software-clock sampling rejected the automatically selected SVE register. Select OS packages and general-purpose registers explicitly. |
| [42751630458](https://github.com/e6qu/fun-with-pipes/actions/runs/42751630458) | `f8cf810f5` | The optional register argument requires `--user-regs=LIST`; a separate word became the command. Fix the invocation and probe capabilities before building. |
| [42752530541](https://github.com/e6qu/fun-with-pipes/actions/runs/42752530541) | `1ae957fec` | All eight recordings preserve C. Reader rejected perf's extra, unmeasured IPC placeholder. Recognize only that exact placeholder; keep loss/period accounting strict. |
| [42753509308](https://github.com/e6qu/fun-with-pipes/actions/runs/42753509308) | `7a2cfc919` | ARM64 decoded Rust symbols, then a Python loop overwrote the application record. Fix and test the complete flow. AMD64 was cancelled before starting; it is not a pass. |
| [42754692740](https://github.com/e6qu/fun-with-pipes/actions/runs/42754692740) | `f7f4336f7` | All eight recordings and flat reports complete, but every checking parent is `[other]`. Read decoded DWARF stacks directly instead of `perf report --parent`. |

The ARM64 capability comparison retains the actual event attributes: register
mask `0x4001ffffffff` fails for the software clock; general-purpose mask
`0x1ffffffff` succeeds. Perf emits its register-subset warning even for the full
explicit general-purpose set. The warning is retained. Other recording warnings,
lost samples and unmatched report totals still fail verification.

The parent-column limitation is visible in
[perf's source](https://raw.githubusercontent.com/torvalds/linux/v6.8/tools/perf/util/machine.c):
its DWARF unwind path builds a call cursor without assigning the parent field.
Direct `perf script` decoding retains every sample period, including unknown and
unavailable stacks, and requires totals to match the original flat report.

| Later run | Decoder source | Result |
|---|---|---|
| [42757176892](https://github.com/e6qu/fun-with-pipes/actions/runs/42757176892) | `63ae40d08` | Replays saved `f7f4336f7` recordings. ARM64 passes; AMD64 has empty stacks: words 23/294, numerical 337/585, HTTP 686/1,311. |
| [42757980005](https://github.com/e6qu/fun-with-pipes/actions/runs/42757980005) | `35a12dfee` | Preserving empty-stack periods fixes accounting, but AMD64 words/numerical still lack checking callers. ARM64 was cancelled during decoding after two applications passed. |
| [42759680401](https://github.com/e6qu/fun-with-pipes/actions/runs/42759680401) | `e66521244` | Isolating each thread's decoder does not repair AMD64. ARM64 passes. The ineffective workaround was removed. |
| [42761474854](https://github.com/e6qu/fun-with-pipes/actions/runs/42761474854) | `5cab084d5` | Fresh Ubuntu 24.04 recordings: all ARM64 apps and AMD64 words/HTTP pass. AMD64 numerical/callback decoding reports addr2line read errors. |
| [42763409910](https://github.com/e6qu/fun-with-pipes/actions/runs/42763409910) | `c65ecb376` | Explicit ten-second addr2line deadline: all eight reports pass, with matching sample/period totals and no empty stacks. |

The deprecated Node Buffer warning came from the artifact download action. The
workflow now uses the installed GitHub CLI to fetch the exact named archive.

## What is retained

- `audit.json`: full source IDs, artifact IDs/digests/expiration and verification scope.
- `logs/`: every executed job's complete log, compressed; a separate job receipt
  covers the cancelled-before-start job.
- Attempt/host directories: selected raw reports, identities, command ledgers,
  failed diagnostics and capability attributes. Original failures remain unchanged.
- `files.json`: retained byte sizes and SHA-256 hashes, including decompressed hashes.

Selected ZIP members passed CRC. Archive digests come from GitHub metadata;
whole archives were not downloaded/rehashed locally. Compiler binaries, C and raw
recordings remain in the identified artifacts until their recorded expiration.

## AMD64 decoder repairs

The original AMD64 perf 7.0.14 build uses libdw. Its load-base calculation
subtracts a mapped segment's file offset from its virtual address. In the recorded
compiler binary those offsets differ by 4 KiB, producing the wrong image base.
The [LLD/libdw report](https://sourceware.org/pipermail/elfutils-devel/2023q1/005892.html)
and [libunwind repair](https://lkml.iu.edu/hypermail/linux/kernel/2205.3/05076.html)
describe this limitation. The retained mixed-thread diagnostic shows failed
unwinding; per-thread replay does not repair it.

The diagnostic workflow explicitly selects Ubuntu 24.04/perf 6.8 on both hosts.
It preserves the compiler's optimization/link settings and full debug information;
production support is unchanged. The fresh run resolves AMD64 checking callers,
but two applications fail the decoder's one-second addr2line read deadline.
Replay `42763409910` uses an explicit ten-second internal deadline and the unchanged
120-second total command deadline. Unexpected warnings still fail verification.
It reuses the `5cab084d5` binaries and recordings; it does not remeasure compilation.
Both complete job logs are audited. All eight reports pass with no empty stacks.
Compiler/source identities and the exact decoder configuration are retained.

| Application | ARM64 samples / checking share | AMD64 samples / checking share |
|---|---|---|
| Word counting | 261 / 35.6% | 307 / 40.1% |
| Numerical tutorial | 545 / 28.3% | 628 / 20.4% |
| Queued callbacks | 342 / 28.9% | 397 / 45.6% |
| HTTP API | 1,119 / 13.7% | 1,306 / 9.8% |

Checking share means periods with a decoded `check_binding` caller, divided by
all recorded user-CPU periods. These single observations are not precise timing
comparisons. Most stacks still contain at least one unnamed frame; all remain
in the report. Unknown leaf symbols account for 25–42% of sampled periods,
so named work is incomplete. The independent [exact copy counters](../compiler-type-copies-2026-11-10/README.md)
quantify the selected change without relying on missing names. No ordinary-build
speedup follows from these profiles.
