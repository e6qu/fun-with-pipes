# File applications: repeated edits and failed work

Directory reports, word counts, line filtering, CSV selection and task-file edits
pass the expanded cleanup checks on Linux, macOS and Windows, each on ARM64 and
AMD64. These are **correctness and memory checks, not speed benchmarks**. There
is no timed C/Rust implementation and no claim about relative language overhead.

[Run 40058977728](https://github.com/e6qu/fun-with-pipes/actions/runs/40058977728) tests
`8e097fca79ecb82efbced4080352f0af02f5e6b2`. All six complete logs pass audit. Independent review
checks 240 native binaries, 480 execution records and 120 memory series.
The [raw record](file-applications-2026-10-24.json) retains source/toolchain
identities, architecture and code-size checks, hashes and every memory sample.
[PR #207](../roadmap-history.md#file-cleanup-and-http-example-checks-pr-207) records the subsequent passing production and documentation gates.
The focused measurements above retain their own source identity.

## Programs and inputs

The [application protocol](../application-acceptance.md#repeated-directory-and-file-work)
defines the inputs and independent output checks. Directory trees contain 64 or
1,024 files. Counting/filtering inputs contain 128 or 4,096 lines per file; CSV
has 128 or 4,096 data records. Task files contain 128 or 4,096 UTF-8 items.

For the task application, a seeded file starts with unchecked items named
“task héllo 0”, “task héllo 1”, and so on. Each successful round marks the first
item done, rejects item zero, clears completed items, adds “new 世界” and lists
the result.

The seed is restored before each round, so retained input size is
bounded. A failed-write round appends to the first store before attempting a
missing second directory; that first append must persist. A failed-read round
reads one valid store before invalid UTF-8 in the second. The tests check both
the complete printed result and final file contents.

Each healthy process runs three phases of 64 rounds: success, then two errors
after partial work. Other applications exercise missing files, invalid UTF-8,
missing CSV columns or denied directory traversal. Permission tests first check
that the operating system actually refuses access. Every program runs at native
O1 and O2 (two C compiler optimization levels), from fwp O1 with link-time optimization disabled.

## What returned to baseline

At all 23,040 round checkpoints, managed storage returns to its post-initialization
baseline, opened directory/read/write handles have been closed, and the C scratch
buffer used by file.read has been freed. Final checks also require no retained
managed storage and no tracing collections. A checkpoint is a recorded sample
after one round, not a statement about peak memory during the round.

The 360 deliberately broken process runs omit a managed release, handle close or
read-buffer free. Task-file controls separately omit write closes while flushing
the bytes, so they fail the handle check without changing subsequent read results.
All omissions are detected before shutdown. Both healthy and broken runs save
stdout, stderr and exit status before result assertions; a failed run preserves
its partial observations.

Managed charge excludes allocator pages, bookkeeping, stacks and other C/library
storage. Zero retained managed bytes does not mean the whole process uses zero
memory. Resident set size (RSS), memory currently in RAM, is sampled separately
three times in each phase: 1,080 samples across 120 healthy process runs.

| Native runner | Largest sampled RSS, KiB | Largest first-to-last increase within one case, KiB |
|---|---:|---:|
| Linux AMD64 | 6,888 | +2,520 (filter: 4,096 lines, O1) |
| Linux ARM64 | 4,132 | +868 (CSV: 4,096 records, O1) |
| macOS ARM64 | 4,480 | +1,152 (CSV: 4,096 records, O1) |
| macOS AMD64 | 4,840 | +2,328 (CSV: 4,096 records, O2) |
| Windows AMD64 | 8,724 | +472 (tasks: 4,096 items, O2) |
| Windows ARM64 | 9,464 | +588 (tasks: 4,096 items, O1) |

Each row summarizes twenty separate processes, not one continuous measurement
or a comparison between operating systems. Growth remains visible in the raw
samples; no invented zero-growth RSS threshold is applied. Binary review checks
actual architecture headers, generated C, disassembly and absence of tracing
symbols in these checked-ARC programs. Text-section sizes include padding.

These finite runs do not prove an asymptotic bound, cover every C buffer or
force every allocation failure. They make no WebAssembly file-support claim.
The [earlier four-program sample](file-applications-2026-10-22.json) retains its
original thirty binaries and sixteen series per host.

## Which execution examples pass ARC's checks

The [2026-10-24 compiler inventory](arc-admission-2026-10-24.json), recorded before
GC removal, checked C emission for 85 top-level execution examples on Linux AMD64.
It used fwp O1, dynamic storage and stack optimization enabled. “Admission” here means the
compiler accepts the ownership proof, not that this inventory executes the program.

- 81 emit C in both tracing and checked ARC modes, including the manual-pointer
  example under its explicit caller obligations.
- Three intentionally invalid compile-time/type examples fail in both modes.
- The inter-task derivative example deliberately uses an expired derivative
  value. ARC rejects it; tracing/interpreter tests require its runtime safety trap.

Tracing was subsequently removed; these are historical results, not selectable
current execution modes. This inventory does not prove native execution, physical
reclamation or support for every service/library boundary. The [ownership contracts](../ownership.md)
still apply. The [older inventory](arc-admission-2026-10-22.json) predates
[manual-pointer support](manual-pointers.md); its old rejection is superseded.
