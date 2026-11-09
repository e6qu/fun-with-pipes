# Parser memory: next measurement

**Preparation only. No process-memory result is claimed.** The current
[parser checks](ownership-peer-checks-2026-11-08/README.md#parser-storage)
observe successful allocation API transitions. They cannot see temporary old/new
storage inside the allocator's `realloc` implementation.

Keep the existing benchmark grammar and inputs: balanced trees of 31, 511 and
8,191 nodes, plus the 127-node left-nested tree. This is a prefix-expression
benchmark, not the fwp language parser. Compare current fwp, C and Rust; no old
fwp compiler is needed. C/Rust borrow token slices; fwp owns token strings.
Preserve those representations and report their differences.

## Measurements to add

| Measurement | Method | Boundary |
|---|---|---|
| Ordinary process peak RSS | Three separate GNU-time processes per input and implementation, per native host | Includes startup, input, parser, runtime and libraries; excludes no component by subtraction |
| Virtual mappings and resident pages | Stop a diagnostic child at named phase boundaries; parent reads its complete `/proc/PID/smaps` | A snapshot, not an allocation ledger or an observed peak between stops |
| Requested storage during vector growth | Retain the existing allocation event ledger and classify actual reallocations | Successful API transitions; do not rename the maximum as the allocator-internal peak |
| Temporary storage inside ordinary reallocation | Requires a separately verified observer inside the actual allocator | Still unresolved; sampled RSS and post-return events do not satisfy this requirement |

For stopped-process snapshots, record mapping size, resident pages, private
clean/dirty pages, anonymous pages and swap separately. Preserve raw maps and
all numeric fields used in summaries. Kernel documentation distinguishes
[mapping size from resident pages](https://www.kernel.org/doc/html/latest/filesystems/proc.html).
A reserved address range is not physical memory. These snapshots also do not
establish a per-process committed-memory value; do not relabel RSS or writable
mapping size as committed bytes.

## Checkpoints and controls

Implement the same logical checkpoints in all three diagnostic programs:

1. Runtime and input ready, before tokenization.
2. Tokens complete, before tree construction.
3. Tree complete, before traversal.
4. Traversal complete, before releasing tree/tokens.
5. Tree/tokens released, while input and runtime remain alive.

The helper sends its checkpoint identity and waits for an explicit parent reply.
Take observations while the child is stopped, then resume it. Match the exact
checkpoint sequence; missing, repeated or out-of-order checkpoints fail. Bound
waits and always terminate/reap a failed child. The helper must not allocate
parser-owned memory or retain the tree. Check the same result and node count as
the ordinary executable. Diagnostic elapsed time is not a timing result.

Before observing a parser, verify the reader with a separate native control:
reserve a named address range, make its pages writable, touch every page, then
unmap it. Observe reservation, residency after touching and disappearance after
unmapping. The protocol must inspect the actual mapping, not infer changes from
whole-process RSS noise. Deliberately omit touching and unmapping in separate
controls; the reader must reject the missing transition. Keep malformed/trailing/
overflow parser inputs and actual omitted-release checks.

## Execution and acceptance

- Use native Linux ARM64/AMD64, explicit compiler/architecture flags and source
  IDs. Ordinary C/generated C and Rust use their production optimization settings.
- Freeze the complete source under an immutable tag before collecting results.
  Record three ordinary RSS processes per input/implementation, plus two complete
  diagnostic checkpoint sequences. Keep every failure; do not retry unchanged
  samples to seek lower memory figures.
- Retain original/prepared source, commands, raw snapshots, results, native images,
  toolchain identities, build time/RSS and existing frame reports. Independently
  reconstruct tables from raw records on the runners.
- Passing RSS/checkpoint observations completes only those memory boundaries.
  Allocator-internal transient peaks and committed memory remain unresolved until
  an observer demonstrates that it measures them. Do not mark the entire parser
  comparison complete on the strength of endpoint capacities or a sampled peak.

This preparation narrows the implementation steps in the
[ownership comparison](ownership-peers.md#parser-workspace); it does not replace
that milestone's unfinished requirements.
