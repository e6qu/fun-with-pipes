# Buffer correctness and parser storage checks

These are the first checks for the [ownership comparisons](../ownership-peers.md).
They add a Swift buffer peer and measure C/Rust parser allocation lifetimes and
compiler-reported frames. **They do not measure peer elapsed time or complete
milestone 4.** fwp itself is not rebuilt by this focused check.

[Both native Linux jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42522747197)
at source `4c6cda41fc2739569cdeda241da85b2a7310b89c`, retained by tag
`roadmap/ownership-peer-checks-2026-11-08`. Both use Ubuntu 24.04, GCC 13.3.0,
Rust 1.99.1 and Swift 6.4.2. Targets are ARM64 and AMD64; CPU models were not
recorded, and no CPU-speed comparison follows from these checks.

## Buffer results

The C/Rust/Swift programs construct integers from zero to `length - 1`, then
read or sum them. For length four, `unique` returns eight, `callback` returns four,
and `scan` returns six. [The scope document](../ownership-peers.md#buffers)
explains the operations and their intended future timing boundaries.

Each host passes **630 result and argument-error cases**: C/Rust at O1/O2 and
Swift at Onone/O. Inputs cover negative and empty lengths, 1/16/4,096/262,144
elements, repeated calls, oversized arrays and invalid arguments. The Swift
program uses its native `Array<Int64>`; it adds no reference wrapper.

At this revision, Swift has external input/result barriers while C/Rust have
inline barriers; these records are not matched timings. The later
[four-language checks](../four-language-buffers-2026-11-09/README.md) verify matching
barriers including fwp. They also collect no timings.

## Parser storage

This parser reads a small prefix-expression language. For example, `+ 2 * 3 4`
is a five-node tree whose value is `2 + (3 * 4) = 14`. It is not fwp syntax or
fwp's own compiler parser. Tokens borrow the input string; tree nodes use indices
in a separate growable vector.

The observer records successful allocation and reallocation requests, then
release. A reallocation replaces the previous requested size with the new one;
temporary storage inside the system allocator is not observable here.
All rows agree between C/Rust and both architectures, across three repetitions:

| Tree | Nodes | Requests per parse | Total requested bytes | Peak live requested bytes | Final live bytes |
|---|---:|---:|---:|---:|---:|
| Small balanced | 31 | 6 | 2,240 | 1,280 | 0 |
| Medium balanced | 511 | 14 | 40,640 | 20,480 | 0 |
| Large balanced | 8,191 | 22 | 655,040 | 327,680 | 0 |
| Left-nested | 127 | 10 | 9,920 | 5,120 | 0 |

For the largest tree, the peak consists of 8,192 token slots × 16 bytes plus
8,192 node slots × 24 bytes. Earlier requests are replaced during growth, so
their sum exceeds the simultaneous live peak. Input loading, allocator headers,
observer tables, reserved pages and process RAM are excluded. These numbers
cannot be compared directly with fwp's rounded heap slots or process RSS.

## Stack observations

The ordinary programs use GCC O2 or Rust optimization level 2, checked integer
arithmetic and no LTO. C also disables fast math and floating-point contraction.
Native targets are `armv8-a`/Rust `generic` and `x86-64`.

| Target | C parser frame | Rust parser frame | C evaluator frame | Rust evaluator frame |
|---|---:|---:|---:|---:|
| ARM64 | 64 bytes | 80 bytes | 48 bytes | 64 bytes |
| AMD64 | 80 bytes | 72 bytes | 48 bytes | 56 bytes |

GCC supplies stack-usage files. Rust supplies frame remarks; its reporting build
has the same `.text` bytes as its ordinary executable. Inspection preserves both
input binaries. These are individual reported frames, not total recursive-stack
bounds; runtime libraries and simultaneously active calls add other costs.

## Observer failure and repair

The [first run](https://github.com/e6qu/fun-with-pipes/actions/runs/42520124080),
source `5c40c2a9f3a227534305fbbe80ab9b08af702180`, reported green jobs. Raw records
showed a real defect: instrumented Rust invalid-input cases aborted with signal
6 instead of returning their normal error status 101. The test accepted any
nonzero exit, hiding the difference.

The aggregate observer could subtract frees for outer allocations it had never
measured. The repair tracks allocation identities and ends observation during
unwinding. The fixed collector and retained-report reader require the intended
C/Rust error statuses, not just an unsuccessful process.

The repaired jobs verify:

- All malformed, trailing-token and overflow cases return the intended errors.
- An owner allocated before measurement can be freed inside the measured scope.
- Caught unwinding stops observation. Its partial profile is not a normal sample.
- Deliberately restoring the bad accounting reproduces the abort.
- Actual omitted release is detected, and 32 damaged storage records are rejected.
- Twelve evidence tests pass, including 50 altered exits and unexpected output.

Normal storage totals remain unchanged. No performance claim uses instrumented
clock values, and no acceptance rule was relaxed.

## Evidence

The `arm64/` and `amd64/` directories retain buffer reports, parser reports,
compressed command records and complete job logs, including the first run.
[Artifact identities](artifacts.json) record GitHub's archive digests and sizes;
`accepted` means these focused checks were verified, not timing acceptance.
The full archives contain generated sources, ordinary/diagnostic native images
and frame files. They remain on GitHub; no local full-archive digest verification
is claimed. Selected records were fetched with byte ranges and ZIP CRC checks.
