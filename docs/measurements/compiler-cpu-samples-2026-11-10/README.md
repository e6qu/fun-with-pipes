# Compiler CPU samples, November 10

**Recordings work; caller attribution is still being verified.** This is a
compiler-cost investigation, not a speedup result. The
[protocol](../compiler-checking.md#next-cpu-samples-inside-checking) defines the
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
[Linux perf's source](https://raw.githubusercontent.com/torvalds/linux/v6.8/tools/perf/util/machine.c):
its DWARF unwind path builds a call cursor without assigning the parent field.
Replay `42757176892`, decoder source `63ae40d08`, reads `perf script` frames from
the saved `f7f4336f7` binaries/recordings. It requires sample and period totals
to match the original flat report, retains unknown/unmatched callers, and requires
resolved `check_binding` frames. No compiler rebuild or new sampling is needed.
All four ARM64 applications pass; AMD64 callbacks pass. AMD64 has 23 empty
stacks out of 294 samples for words, 337/585 for numerical and 686/1,311 for HTTP.
Retaining these periods prevents biased totals, but does not recover callers:
words and numerical still have no decoded body-checking caller. They remain
failed attribution probes. The candidate replay retains verbose mixed-thread diagnostics alongside a
separate decoding process for each sampled thread. It verifies every thread's
period sequence and the original combined totals. Perf 7.0.14's
[source](https://raw.githubusercontent.com/gregkh/linux/v7.0.14/tools/perf/util/unwind-libdw.c)
contains the cached-thread lookup defect described in the
[upstream repair](https://lists.openwall.net/linux-kernel/2026/07/24/1598).
That is a candidate explanation for these recordings; native verification must
show both the original failure and recovered callers before accepting it.
The artifact download action also emitted a deprecated Node Buffer warning;
use the installed GitHub CLI to download the exact named artifact instead.

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
