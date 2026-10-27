# Measuring one parser's tree lifetime

**Protocol under validation in #221; results are pending.** This measures the
[A6 parser](../parser-workspace.md), which builds a tree and then evaluates it.
For example, `+ 2 * 3 4` builds five nodes and computes `2 + (3 * 4) = 14`.
Removing tree-node reference counts does not remove tokenization or every heap
allocation from this program.

## Programs being compared

| Variant | Tree storage | Tokens and arithmetic |
|---|---|---|
| Previous fwp, #220 squash `56d5aac6` | Independently owned nodes | Owned String/token list; checked I64 |
| Candidate fwp | One invocation owns aligned blocks; links have no counts | Same source, tokens and arithmetic |
| [C peer](../../tests/fixtures/parser_arena_peer.c) | Growable contiguous array, child indices | Growable array of borrowed input views; checked signed 64-bit operations |
| [Rust peer](../../tests/fixtures/parser_arena_peer.rs) | Growable contiguous vector, child indices | Vector of borrowed slices; checked `i64` operations |

All four parse the same prefix grammar (`+`, `*`, signed integers), build every
node, reject trailing input, and recursively walk the tree. Neither peer
computes the answer directly from tokens. The C/Rust arrays start with capacity
eight and double when full. Their 24-byte nodes store an operation tag, a value
or left-child index, and a right-child index. fwp stores a header and one or two
8-byte fields: 16 bytes for a leaf, 24 for an operator, before block overhead.

C/Rust borrow tokens; fwp creates owned token strings and a linked list. Bounds
checks, error handling, allocation strategy and generated inlining also differ.
A candidate/C ratio of 2 means **this fwp program took twice this C program's
time**, or 100% extra time. It is not a universal language-overhead figure, nor
a measurement of reference counting alone. Candidate/previous-fwp isolates the
compiler change much more closely. Each compiler is built from Rust; the older
compiler is a measurement reference, never a dependency of the current build.

## Inputs and timing boundaries

The generator emits balanced trees of 31, 511 and 8,191 nodes, and a left-nested
tree of 127 nodes. Depths are 5, 9, 13 and 64 respectively. Leaves in traversal
order are `index % 17 - 8`; the independent output oracle sums them. Small
correctness controls separately cover multiplication, negatives, malformed input
and overflow. Source, input hashes and generated C are retained.

Input-file reading, initial input-string allocation, process startup, printing
and result/cleanup checks are outside the total timer. Each timed invocation
includes tokenization, tree construction, validation, traversal and cleanup.
fwp also retains one input alias per invocation so the input survives repetition;
that retain is included. All programs create fresh tree/token containers each
invocation. There is no preallocated tree hidden outside the timer.

Phase clocks surround only top-level boundaries, not recursive node visits:

- **Tokenization:** input splitting and creation of each implementation's token
  container. fwp also installs its token ownership metadata.
- **Construction:** the parser call, including number conversion, tree allocation
  and token consumption. fwp may free consumed tokens during this phase.
- **Walk and release:** the remaining invocation time, including trailing-input
  validation, recursive evaluation, wrapper bookkeeping and all remaining cleanup.
  This is a residual interval, not a claim to isolate pure arithmetic.
- **Release:** candidate block-list cleanup, or C/Rust container destruction.
  This is a subset of “walk and release.” Previous fwp frees nodes while walking;
  its separate release time is recorded as `null`, never as zero.

Clock reads affect these small programs. The fwp root can contain inlined walks;
the harness preserves them. It fails if expected top-level phase boundaries are
missing or ambiguous. The instrumented generated C and compiler flags remain
available for review. Compare the total alongside phases; do not add release to
walk-and-release a second time.

## Storage and code observations

Separate profile binaries count allocations and region blocks; these counters
are absent from the timed fwp binaries. Profiles use 1, 16 and 256 invocations.
Every call must restore the live heap baseline, and releasing the input must
leave zero live heap slots. Required observations include:

- Total fwp heap allocations and allocated slot bytes, plus maximum simultaneously
  live slot bytes above the retained input. Slot bytes include size-class rounding;
  they exclude reserved heap pages, allocator metadata, stacks and process RSS.
- Candidate block count, requested bytes, actual rounded allocation bytes and
  unused payload. Each block requests a 24-byte header plus 4,096 payload bytes.
  The auditor independently reconstructs used node bytes from the fixed tree.
- C/Rust node/token capacities and allocation/reallocation calls. These report
  requested retained payload, not allocator rounding or a reallocation's transient
  peak. They cannot be equated with fwp's physical-slot observations.
- Binary hashes, architecture headers, byte sizes and GCC stack-usage files.
  File size is not executable-text size, and a frame size is not total recursive
  stack use. The left-nested case deliberately exposes a deeper call chain.

Larger retained blocks can increase peak storage even when they remove count
operations. Preserve those rows; no memory win follows merely from fewer objects.
The separate lifetime suite checks actual count operations, alignment, allocation
failure, cancellation and nested owners, including deliberately broken cleanup.

## Sampling and acceptance

The `parser-measurements` workflow uses GCC O2 and Rust O2 with checked overflow,
no LTO and no fast-math. fwp uses explicit dynamic memory and enabled stack
selection (`FWP_STACK=1`); the harness clears inherited fwp settings. Compiler builds use the same Rust O1 settings. It runs
twice on separately allocated native Linux AMD64 and ARM64 runners. Each sample
is a new process pinned to CPU 1. Each variant gets two warmups and six measured
samples, alternating forward/reverse execution order. There are 32,768 parses
per sample, or 2,048 for the largest tree.

Before timing the candidate, compare the baseline executable against an identical
copy. Let `noise` be the largest absolute deviation of paired copy/baseline ratios
from one. Reject controls beyond 10%. Otherwise write the acceptance budget
`1 + 2 * noise` before candidate sampling. The median paired candidate/baseline
ratio must not exceed it. C/Rust ratios are reported even when fwp is slower;
this task promises no C/Rust parity threshold. Every sample and rejected result
stays in the artifacts; unstable controls do not establish a speed result.

The [auditor](../../scripts/inspect-parser-workspace.py) recomputes ratios, storage
identities, sample completeness and the frozen budget, and checks actual binary
hashes and architecture. Its [negative controls](../../scripts/test-parser-workspace-evidence.py)
reject missing peers, fabricated phase sums, changed budgets, leaks, retained
growth, incorrect block accounting and hidden regressions.

## Compiler cost

Measure the region pass separately on synthetic programs with 16, 32 and 64
candidate roots sharing known helpers: six samples of 128 lowering calls, with
input construction outside the timer. Record selected entries, original
expression/local weight and actual added weight. Completed clones must add at
most twice the original weight. The pass also has its finite proof budget; these
are work/code-growth limits, not an elapsed-time guarantee. Programs without an eligible
node type or owning entry no longer copy the whole program just to return it unchanged.

Separately, generate source programs with 16/32/64 distinct exported parser roots.
For both compilers record three complete C-emission samples, process peak RSS,
emitted C bytes and selected entries. These samples include parsing, typing,
optimization and C generation; label them as whole compilation, not region-pass
time. Report limits that prevent selection rather than suggesting every root
received a region. G2's existing analysis gates remain required.
