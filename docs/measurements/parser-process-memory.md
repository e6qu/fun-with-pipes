# Parser memory: next measurement

**Preparation only. No process-memory result is claimed.** The current
[parser checks](ownership-peer-checks-2026-11-08/README.md#parser-storage)
observe successful allocation API transitions. They cannot see temporary old/new
storage inside the allocator's `realloc` implementation.

Keep the existing benchmark grammar and inputs: balanced trees of 31, 511 and
8,191 nodes, plus the 127-node left-nested tree. This is a prefix-expression
benchmark, not the fwp language parser. Compare current fwp, C and Rust; no old
fwp compiler is needed. C/Rust borrow token slices; fwp owns token strings.
Preserve those representations and report their differences. Each process performs
**one parse**. C/Rust keep their borrowed token arrays until the tree is released;
fwp consumes its owned token strings while building the tree. The fwp harness
keeps the generated program's ordinary runtime initialization, worker thread,
stack reservation and shutdown. It calls the current owned `calculate` entry;
no earlier compiler or custom replacement runtime is used.

## Frozen process-memory protocol

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
A reserved address range is not physical memory. A GNU-time RSS result of zero
is retained as an unresolved counter observation, never described as a process
using no memory. Phase snapshots remain separate observations, not replacements
for that counter. These snapshots also do not
establish a per-process committed-memory value; do not relabel RSS or writable
mapping size as committed bytes. In fwp's runtime, `fwp_heap.committed` means
writable heap chunks, a different scope from Linux's system-wide commit accounting.
[The terminology guide](../terminology.md#writable-memory-is-not-necessarily-resident-memory)
explains the distinction and the temporary old/new storage a resize may hide.

## Checkpoints and controls

Use the same logical checkpoints in all three diagnostic programs:

1. Runtime and input ready, before tokenization.
2. Tokens complete, before tree construction.
3. Tree complete, before traversal.
4. Traversal complete, before releasing tree/tokens.
5. Tree/tokens released, while input and runtime remain alive.

The helper sends its checkpoint identity and waits for an explicit parent reply.
Take observations while the child is stopped, then resume it. Match the exact
checkpoint sequence; missing, repeated or out-of-order checkpoints fail. Bound
waits and always terminate/reap a failed child. The helper must not allocate
parser-owned memory or retain the tree. Check the same result in every build and count actual nodes in each diagnostic
build. The ordinary fwp build has no added node counter. Wrong-result controls
must fail after completing all five diagnostic checkpoints; an unrelated crash
is not an accepted result check. Diagnostic elapsed time is not a timing result.

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

## Implementation and verification

[The collector](../../scripts/measure-parser-process-memory.py) records 36 ordinary
RSS processes, 24 five-phase parser observations, 24 deliberately wrong-result
controls, 48 fwp invalid-argument checks and eight raw/optimized interpreter checks on each host. Three native
mapping controls run before any parser observation. Reader tests cover malformed
units/maps, premature exit, wrong checkpoint order, timeout and child reaping.

[The source adapter](../../scripts/parser_memory_source.py) inserts checkpoints
only at verified current-code boundaries. Source changes fail those checks rather
than silently selecting a different function. The audit reconstructs prepared
source and inputs, checks actual ELF architectures, and independently reads every
raw mapping, result, process journal and build/RSS counter. Five actual evidence
corruptions must be rejected even after their manifest hashes are updated.

[The native workflow](../../.github/workflows/parser-process-memory.yml) also
preserves the allocation-transition, invalid-input, omitted-release and frame
checks. The first combined batch failed all fwp observations on both native
hosts: the generated entry dropped an already consumed input. [The failure and
repair](parser-entry-cleanup-2026-11-09/README.md) retain both original reports,
explain the shared ownership-contract fix, and distinguish result errors from
cleanup failures. The repaired compiler now passes on both native Linux hosts,
including all RSS/checkpoint observations and independent audit controls.

Review also found that the C peer accepted numeric prefixes such as `1junk`,
negative counts and range overflow. It now checks the complete argument and its
range before parsing. Ninety-six native C/Rust argument controls cover all three
numeric fields in ordinary and storage-observer builds. This repair changes no
valid benchmark input. Command timeouts now retain partial stdout/stderr as well
as the error, so a failed child cannot disappear from the command record.
