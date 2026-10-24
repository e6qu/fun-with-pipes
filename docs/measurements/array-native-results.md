# Array allocation, layout and startup costs

The focused checks pass on Linux, macOS and Windows, each on ARM64 and AMD64.
This is evidence for the named programs.
[PR #206](../roadmap-history.md#array-output-storage-and-startup-stack-pr-206)
passed final production acceptance on all six native hosts. [Examples and restrictions](array-text.md) explain the transformations.
[Timing comparisons](array-output-results.md) answer a different question: how
long complete fwp programs take compared with C and Rust.

## Allocations and cleanup

Each fixture processes 129 numbers (0 through 128) and repeats 64 times.
An allocation request asks fwp for a managed object, not necessarily the OS for
memory. Turning array transformations off provides a control in the same compiler;
String reuse and other loop optimizations remain enabled in both versions.

| Program | Requests per iteration, transformations off → on |
|---|---:|
| Literal array displayed as a list | 260 → 1 |
| Literal array written as list-shaped JSON | 260 → 1 |
| Generated array displayed as a list | 131 → 2 |
| Literal array mapped and reduced | 132 → 1 |
| Literal array consumed through an iterator | 131 → 1 |

Every optimized case records zero reference-count increments and returns to its
original managed-storage balance. Temporary text buffers retain zero bytes.
Deliberately omitting managed cleanup or text-buffer cleanup fails the probe.
Compact and full-word arrays agree at O1/O2. These counters exclude static program
data and C library allocations; they do not prove zero allocation for arbitrary
programs or unchanged execution time.

## Storage and machine code

The 129-element F64 literal occupies 1,040 bytes: an eight-byte length and 1,032
bytes of elements, aligned to eight bytes. The executable reserves this object;
startup fills its payload. Fourteen mixed numeric arrays occupy 336 bytes with
compact elements and 408 with full-word elements, including headers and object
padding. These totals exclude gaps inserted between objects by the linker.
All inspected objects are aligned and disjoint. Windows zero-initialized data
is checked against actual PE section bounds, including its loader-zeroed tail.

The table compares the same O2 programs with array transformations off → on and
compact elements enabled. Code bytes are the native `.text`/`__text` section
sizes, including compiler padding; `instructionBytes` is the raw report's field
name for this measurement. Executable bytes also include headers, other data,
metadata and file padding. The display rows use allocation instrumentation; the mixed-value rows come from
the semantic fixture. Neither is a numerical timing program.

| Host | Program | Code-section bytes, off → on | Executable bytes, off → on |
|---|---|---:|---:|
| Linux AMD64 | 129-number display | 30,706 → 20,850 | 64,784 → 57,448 |
| Linux AMD64 | Mixed numeric values | 44,962 → 47,666 | 97,016 → 101,712 |
| Linux ARM64 | 129-number display | 28,636 → 20,140 | 82,568 → 83,408 |
| Linux ARM64 | Mixed numeric values | 50,636 → 53,740 | 152,456 → 152,936 |
| macOS ARM64 | 129-number display | 36,860 → 10,324 | 86,552 → 52,968 |
| macOS ARM64 | Mixed numeric values | 56,284 → 47,700 | 105,656 → 106,024 |
| macOS AMD64 | 129-number display | 42,353 → 11,586 | 65,288 → 31,952 |
| macOS AMD64 | Mixed numeric values | 64,352 → 52,736 | 92,488 → 80,576 |
| Windows AMD64 | 129-number display | 71,206 → 15,766 | 147,968 → 89,088 |
| Windows AMD64 | Mixed numeric values | 68,198 → 54,998 | 157,184 → 142,336 |
| Windows ARM64 | 129-number display | 66,228 → 13,620 | 139,264 → 86,528 |
| Windows ARM64 | Mixed numeric values | 59,676 → 49,848 | 144,384 → 134,656 |

Specializing the mixed-value program increases code size on some hosts. Static
storage and fewer runtime requests are therefore not free in every dimension.
The raw report retains every paired case, including both element-layout settings.
Neither shorter instruction sequences nor smaller files establish a speed gain.

## Startup stack

Constant initialization previously emitted one temporary type descriptor per
element. Reusing one descriptor per array reduces the saved Apple Clang 17 O1
entry frame from 15,040 to 720 bytes; O2 remains 704 bytes. Stores read the
descriptor synchronously and do not retain it.

Native compiler reports for the repaired 129-element fixture give these entry
frames. On Windows the entry is the OS thread function, which can contain the
inlined language entry. The test checks every surviving startup function, not
just that entry, against a 4 KiB individual-frame limit at both levels.

| Host | O1 entry bytes | O2 entry bytes |
|---|---:|---:|
| Linux AMD64 | 304 | 304 |
| Linux ARM64 | 288 | 320 |
| macOS ARM64 | 720 | 704 |
| macOS AMD64 | 648 | 632 |
| Windows AMD64 | 728 | 712 |
| Windows ARM64 | 672 | 672 |

GCC also retains a separate constant initializer: 160 bytes on AMD64 and 176 on
ARM64 at both levels. Other startup frames and object/assembly hashes are in the
raw report. These are compiler-reported individual frames, not a bound on the
whole call stack or every library call. Dynamic or absent entry-frame reports
are rejected; parser controls cover valid inlining and deliberate invalid data.

## Reproduction and evidence

Source `64c487652a2861ccff5dcb64f56604f43bc7ee47`, tag
`roadmap/revision-array-frame-check-64c487652a28`, passes all fifteen targets of
[the six-host focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/40052749788).
Its compiler/runtime/library/build files match measured source `19addb905e76`.
The `array-text` suite in the numerical workflow builds with each native
production toolchain; `tests/array_text.rs` records its explicit options and
saves C, outputs, executable files and O1/O2 stack-usage objects.

[Raw results](array-native-2026-10-24.json) retain 1,008 executable outcomes,
twelve stack objects and 144 layout reviews (the latter reuse selected executable
outcomes). Artifact IDs, archive hashes, per-image hashes, statuses, counters,
physical layouts and code sizes tie this summary to the saved files. Complete
job logs were audited. All six jobs and independent artifact reviews passed.
The [delivery record](array-delivery-2026-10-24.json) records the passing final
production jobs and independent binary reviews.
