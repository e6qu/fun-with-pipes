# Why the first service replay failed

All original service outputs are correct. This report concerns decoding saved
CPU call stacks, not executing or timing the programs again.

[Replay run 42776958064](https://github.com/e6qu/fun-with-pipes/actions/runs/42776958064)
used decoder `47f185f7d33743933c1b0f63d1d647c095822efc`, retained by
`roadmap/service-cpu-llvm-decoding-2026-11-10`. Both hosts reject all sixteen
profiles with `addr2line configuration failed`. LLVM 18 treats the probe comma as
a symbol; perf 6.8 expects either GNU's unknown-address response or a comma echo.
Selecting LLVM therefore does not repair this recording workflow.

| Host | Job | Artifact |
|---|---|---|
| ARM64 | `129697609998` | `13744013914` |
| AMD64 | `129697610230` | `13743574866` |

## The original GNU defect

The verbose GNU control reproduces the original failure on both hosts. ARM64
retains 52 short-function marker records and 149 sentinel errors; AMD64 retains
49 and 96. For example, after a source-location line, the reader receives `f100`
as the next inline function name. It mistakenly considers the trailing zeroes an
end marker, then interprets the following location as a new response.

The [perf 6.8 source](https://github.com/torvalds/linux/blob/e8f897f4afef0031fe618a8e94127a0934896aba/tools/perf/util/srcline.c)
uses an OR condition where the marker requires all three checks: at least two
characters, followed by the prefix `0x`. Requiring that actual prefix preserves
function names such as `f100`. No fwp function renaming or ignored diagnostics is
needed. The [LLVM source](https://github.com/llvm/llvm-project/blob/llvmorg-18.1.8/llvm/tools/llvm-symbolizer/llvm-symbolizer.cpp)
explains the separate comma-probe incompatibility.

The next replay builds that pinned perf source with only the marker condition
changed. It retains the patch, build options and executable hash; requires libdw
stack unwinding; and replays every original profile with GNU addr2line. The
unpatched packaged reader must still reproduce the original defect as a control.
The repair is not verified until that native replay passes.

## Retained evidence

[ARM archive](arm-replay.zip) and [AMD archive](amd-replay.zip) contain every
failed decoding report, actual output verification, source hashes and the verbose
GNU exchange. Both complete archives were checked against GitHub's size/SHA-256
metadata and every ZIP CRC. [Metadata](artifacts.json), [file hashes](files.json)
and complete [ARM](arm-job.log.gz)/[AMD](amd-job.log.gz) logs are retained.
The only packaging warning concerns an absent optional g++ manual page.

[Original recordings](../service-cpu-first-2026-11-10/README.md) remain unchanged.
[The protocol](../service-cpu-costs.md) defines acceptance and prevents treating
these failed profiles as runtime performance evidence.

## Native build setup repair

The first GNU-reader replay (`42780083932`, source `795302954b686ad6f2342a0f2ff092ae2e433ac1`,
`roadmap/service-cpu-gnu-marker-2026-11-10`) stops before decoding on both hosts:
the Swift image has compilers but no `make`. Both jobs (`129707755121` AMD,
`129707755410` ARM) fail with status 127. The patch preparation itself succeeds.
The workflow now explicitly installs `make`. The complete
[AMD](gnu-build-amd.log.gz)/[ARM](gnu-build-arm.log.gz) logs retain both failures;
optional bison/g++ manual-page notices are the only other package warnings.
