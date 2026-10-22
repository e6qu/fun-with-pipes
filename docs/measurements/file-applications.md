# Repeated file work without accumulating owned storage

Directory reports, word counts, line filtering and CSV column selection pass
repeated success/error cleanup checks on Linux, macOS and Windows, each on ARM64
and AMD64. They use automatic reference counting (ARC) without a tracing
collector. These are **memory/correctness checks, not speed benchmarks**. There
is no timed C/Rust peer and no claim about overhead compared with either language.

[Run 39711302083](https://github.com/e6qu/fun-with-pipes/actions/runs/39711302083) checks source
`c8e8199294a89bd96d67c86c892861c60e6971af`. All six full logs are audited. A UTF-8 report-decoding repair at
`bc302ea343a2da1571d475c215fda1aeeebdd810` regenerates these reports from the retained
binaries in [run 39713618145](https://github.com/e6qu/fun-with-pipes/actions/runs/39713618145);
it preserves execution metadata and verifies unchanged C/binary hashes. The
[recorded observations and binary inspection](file-applications-2026-10-22.json)
retain compiler versions, native architectures, flags, hashes and all memory
samples. This focused acceptance is separate from the PR's full production gates.

## What runs

[The application protocol](../application-acceptance.md#repeated-directory-and-file-work)
defines every input and oracle. Directory trees contain 64 or 1,024 files;
word-count/filter inputs contain 128 or 4,096 lines per file; CSV contains 128 or
4,096 data records. Hidden paths, Unicode, quoted fields and complete sorted or
selected output are checked against independent Rust calculations and raw fwp
interpretation.

Each checked-ARC process performs three phases of 64 rounds. Success is followed
by failures after partial work: a missing second file, invalid UTF-8, a missing
CSV column, or failed directory traversal. Permission tests first verify that
the operating system actually denies access. Compilation uses fwp optimization level O1 and C optimization levels O1/O2,
with link-time optimization (LTO) disabled. Existing small tracing/stress tests remain.

## What the counters establish

Across 96 process runs, all 18,432 round checkpoints show baseline fwp-managed
storage, zero open directory/file-read handles and zero `file.read` C scratch
bytes. Final checks also require baseline
managed storage and zero collections. Controls deliberately omit releases,
closes or buffer frees; each is detected before shutdown.

Managed storage counts memory charged to fwp's allocator, excluding its reusable
pages, bookkeeping, stacks and other C/library allocations. A zero difference
therefore does **not** mean the whole process uses no memory. The parent separately
samples the resident set size (RSS), memory currently in RAM, at rounds 0, 32 and 63 of each phase, while the
child waits. That gives 864 samples, including growth retained in the table below.
One KiB is 1,024 bytes.

| Native runner | Largest observed RSS, KiB | Largest first-to-last increase within one case, KiB |
|---|---:|---:|
| Linux AMD64 (`ubuntu-latest`) | 6,828 | +2,520 (`grep-4096-O2`) |
| Linux ARM64 (`ubuntu-24.04-arm`) | 4,156 | +852 (`csv-4096-O1`) |
| macOS ARM64 (`macos-15`) | 4,480 | +1,120 (`csv-4096-O1`) |
| macOS AMD64 (`macos-15-intel`) | 4,868 | +2,316 (`csv-4096-O2`) |
| Windows AMD64 (`windows-2025`) | 8,736 | +440 (`csv-4096-O2`) |
| Windows ARM64 (`windows-11-arm`) | 9,492 | +440 (`csv-4096-O1`) |

Each row summarizes sixteen separate process runs; it is not one continuous
measurement or a comparison between operating systems. RSS is read from Linux
`/proc`, macOS `ps`, or Windows `K32GetProcessMemoryInfo`. The full report preserves
all nine samples per case. Resident allocator pages can remain after owned
objects are freed; these finite observations do not prove an asymptotic bound or
cover every C buffer and forced allocation failure.

Independent inspection covers 180 actual native binaries, including deliberately
broken controls: machine headers, code sections, disassembly and generated-C
hashes. Nothing here establishes WebAssembly file support.

## Which maintained examples pass ARC's checks

The [compiler admission inventory](arc-admission-2026-10-22.json) compares C emission
for 85 top-level execution examples at explicit O1, dynamic storage and enabled
stack optimization. The imported macro module is not a separate execution case.

- 80 emit C in both tracing and checked ARC modes.
- Three intentionally invalid compile-time expressions/types fail in both modes.
- `ffi.fwp` is rejected by ARC because raw C pointers have no admitted lifetime contract.
- `ad_task_reuse.fwp` deliberately passes an expired derivative value between tasks.
  ARC rejects it before execution; tracing/interpreter tests require the runtime
  safety trap. This invalid lifetime must remain rejected, rather than being
  enabled to make the inventory green.

C emission alone does not establish native execution, physical reclamation or
support for every library/service entry. The raw-pointer boundary is concrete
remaining ownership work; the existing runtime tests remain necessary.
