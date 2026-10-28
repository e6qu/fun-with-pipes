# Measuring one parser's tree lifetime

**Four measurement sessions pass; full platform acceptance remains open in #221.**
This measures the [parser](../parser-workspace.md) that builds a tree and evaluates
it. For example, `+ 2 * 3 4` builds five nodes and computes `2 + (3 * 4) = 14`.
Removing tree-node reference counts does not remove tokenization or every heap
allocation from this program.

## Verified storage so far

Both Linux architectures pass the focused native/WASI lifetime checks at
`ca56023e` (run `40650396700`). The four current measurement sessions linked below
independently agree on these per-invocation observations:

| Tree | Nodes | Region blocks | Requested / allocated block bytes | Peak live heap slots, previous and current fwp |
|---|---:|---:|---:|---:|
| Small balanced | 31 | 2 | 768 / 768 | 1,744 |
| Medium balanced | 511 | 6 | 12,032 / 12,032 | 28,624 |
| Large balanced | 8,191 | 44 | 167,680 / 167,680 | 458,704 |
| Left-nested | 127 | 4 | 3,840 / 3,840 | 7,120 |

Peak live slots include tokens and other temporary owners, above the retained
input. They are not process memory or just tree bytes. Every repetition restores
the same live baseline; releasing the input leaves zero live slots. This removes
node counts without reducing the measured peak for these programs.

Allocation traffic and peak live storage answer different questions. These
profiles count all heap allocations in one parse, including tokens. Allocated
bytes sum every allocation over that parse; they are not simultaneous live bytes.

| Tree | Heap allocations, previous → current | Allocated heap-slot bytes, previous → current | C/Rust node + token capacity bytes | C/Rust allocations/reallocations |
|---|---:|---:|---:|---:|
| Small balanced | 111 → 98 | 3,152 → 3,440 | 768 + 512 | 6 |
| Medium balanced | 1,795 → 1,546 | 53,072 → 56,944 | 12,288 + 8,192 | 14 |
| Large balanced | 28,679 → 24,628 | 851,792 → 888,432 | 196,608 + 131,072 | 22 |
| Left-nested | 449 → 390 | 13,136 → 14,960 | 3,072 + 2,048 | 10 |

The candidate makes fewer allocations but requests **more total slot bytes**
(4–14% here). The previous generated parser can reuse a successful integer-parse
result as a leaf node. The region instead reserves space for every node, plus headers and
unused payload. Removing counts is therefore not automatically a byte saving.
The peer columns are retained requested capacities, excluding allocator metadata/rounding and transient reallocation
peaks; they are not directly comparable to fwp's allocated-slot total.

## Time and measurement limits

[All samples and prior attempts](parser-workspace-2026-10-28.json) are retained.
Current source `35250b3a5ecdaa8f3e02ddb7af9664c84068f186` was measured twice per
architecture: [AMD64 run](https://github.com/e6qu/fun-with-pipes/actions/runs/40656341807)
and [ARM64 run](https://github.com/e6qu/fun-with-pipes/actions/runs/40657569359).
Both complete logs and every artifact passed independent audit. Compiler/runtime
code is unchanged from the focused lifetime source `ca56023e`.

AMD64 session 1 used Intel Xeon Platinum 8573C and session 2 AMD EPYC 7763;
both used Ubuntu GCC 15.2. ARM64 sessions used Neoverse N2 and GCC 13.3.
All used Rust 1.99.1, native O2, checked arithmetic, no LTO and no fast-math.
Full CPU descriptions, flags, command lines, source and binary hashes are in the
data. Each range below spans the two sessions; ratios are computed within each
session, never by dividing results from different processors. Time is the median
per parse, in microseconds (one millionth of a second).

| Architecture | Tree | Previous fwp µs | Current fwp µs | Current / previous | Current / C | Current / Rust |
|---|---|---:|---:|---:|---:|---:|
| AMD64 | Small | 2.935–3.369 | 2.320–2.760 | 0.783–0.819 | 5.742–6.399 | 5.293–5.702 |
| AMD64 | Medium | 44.287–53.768 | 34.668–42.128 | 0.782–0.784 | 8.360–8.579 | 7.864–8.021 |
| AMD64 | Large | 753.985–922.370 | 581.200–716.177 | 0.771–0.776 | 8.738–9.261 | 7.860–8.557 |
| AMD64 | Left-nested | 11.696–14.354 | 9.110–11.351 | 0.778–0.793 | 6.794–7.017 | 5.934–6.412 |
| ARM64 | Small | 3.453–3.461 | 2.654–2.657 | 0.769–0.770 | 5.887–5.919 | 5.209–5.209 |
| ARM64 | Medium | 53.331–53.517 | 39.260–39.510 | 0.736–0.738 | 9.336–9.338 | 8.092–8.171 |
| ARM64 | Large | 896.779–901.090 | 650.936–653.063 | 0.725–0.726 | 9.198–9.200 | 8.338–8.375 |
| ARM64 | Left-nested | 13.391–13.490 | 10.104–10.141 | 0.752–0.754 | 7.066–7.094 | 6.297–6.327 |

The candidate takes **18–28% less time than previous fwp** on these inputs.
It still takes **5.7–9.4× the C peer's time and 5.2–8.6× Rust's**. For example,
6× means 500% extra time, not a 6% overhead. These are whole parser invocations;
the peers use borrowed tokens while fwp owns strings and a linked token list.

For the medium tree in AMD64 session 1, current fwp spends about 9.12 µs splitting
input, 24.38 µs constructing the tree, and 1.17 µs validating/walking/releasing it.
C spends about 1.26, 1.75 and 1.15 µs respectively. Construction still consumes
tokens and converts numbers, so it is not a measurement of node allocation alone.
The region removes much cleanup work; token handling and construction remain
concrete P1 targets. Raw phase samples for every peer and size are retained.

Before candidate timing, each case freezes its own allowance at twice the
largest observed identical-binary deviation, with controls rejected above 10%.
The accepted sessions had the following *largest* deviations across their four
cases; each case's exact allowance remains in the data:

| Session | Largest identical-binary deviation |
|---|---:|
| ubuntu-24.04-arm-1 | 0.463% |
| ubuntu-24.04-arm-2 | 1.460% |
| ubuntu-latest-1 | 3.343% |
| ubuntu-latest-2 | 5.945% |

Earlier whole-block attempts rejected three controls, at 10.08%, 10.44% and
10.47%; those cases have no candidate timing. Longer samples did not eliminate
the failures. The later diagnostic samples show little off-CPU time, but cannot
establish the earlier failures' cause. No limit was relaxed and no sample was
removed. These accepted results are conditional on their passing controls, not a
claim that shared hosted runners are always stable. Future unstable controls
must still fail and retain their observations.

## Binary and stack costs

The retained ELF headers confirm native AMD64/ARM64 targets. Executable-file
bytes and executable `.text` bytes are distinct:

| Target | Previous file / text bytes | Current file / text bytes | C file / text bytes | Rust file / text bytes |
|---|---:|---:|---:|---:|
| AMD64 | 97,368 / 56,786 | 58,192 / 27,650 | 16,688 / 2,158 | 4,563,672 / 255,363 |
| ARM64 | 147,840 / 48,828 | 75,944 / 30,188 | 71,120 / 2,160 | 4,694,960 / 230,844 |

Rust's file includes linked standard-library support; file size alone does not
compare parser instruction counts. GCC's stack-usage files report these frames:

| Frame | AMD64 previous → current bytes | ARM64 previous → current bytes |
|---|---:|---:|
| Parser entry | 6,304 → 368 | 5,056 → 336 |
| Recursive parser helper | 1,824 → 800 | 1,472 → 672 |
| Recursive evaluator | 304 → 32 | 288 → 32 |
| Timing harness main | 224 → 224 | 224 → 224 |

All GCC frame rows are retained. These are individual frames, not a measured
whole-program stack peak: recursive depth still matters. No Rust frame estimate
was captured. The left-nested input is not a constant-stack claim.

## Programs being compared

| Variant | Tree storage | Tokens and arithmetic |
|---|---|---|
| Previous fwp, #220 squash `56d5aac6` | Independently owned nodes | Owned String/token list; checked I64 |
| Candidate fwp | One invocation owns aligned blocks; links have no counts | Same source, tokens and arithmetic |
| [C peer](../../tests/fixtures/parser_arena_peer.c) | Growable contiguous array, child indices | Growable array of borrowed input views; checked signed 64-bit operations |
| [Rust peer](../../tests/fixtures/parser_arena_peer.rs) | Growable contiguous vector, child indices | Vector of borrowed slices; checked `i64` operations |

The fixed inputs use ASCII whitespace. All four parse the same prefix grammar (`+`, `*`, signed integers), build every
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

Every subprocess also records whole-process wall time, user/system CPU time and
voluntary/involuntary context switches. These include startup, input loading,
checks and output, unlike the inner invocation timer. They diagnose variability;
they do not replace the declared wall-time acceptance metric. Child CPU/switch
counts are differences around one serial subprocess, not cumulative totals.

Clock reads affect these small programs. The fwp root can contain inlined walks;
the harness preserves them. It fails if expected top-level phase boundaries are
missing or ambiguous. The instrumented generated C and compiler flags remain
available for review. Compare the total alongside phases; do not add release to
walk-and-release a second time.

## Storage and code observations

Separate fwp profile binaries count allocations and region blocks; these counters
are absent from the timed fwp binaries. C/Rust record vector growth calls in
their timed loop; these counters increment only when a container grows. Profiles use 1, 16 and 256 invocations.
Every call must restore the live heap baseline, and releasing the input must
leave zero live heap slots. Required observations include:

- Total fwp heap allocations and allocated slot bytes, plus maximum simultaneously
  live slot bytes above the retained input. Slot bytes include size-class rounding;
  they exclude reserved heap pages, allocator metadata, stacks and process RSS.
- Candidate block count, requested bytes, actual rounded allocation bytes and
  unused payload. Whole blocks request 256, 512, 1,024, 2,048, then 4,096 bytes,
  including a 24-byte native header. Further blocks keep 4,096 bytes; oversized
  nodes get their checked exact requested size. The auditor reconstructs postorder
  construction and packing, and requires requested block bytes to equal actual
  native size-class bytes for these inputs. Header-aware sizes avoid a second
  round-up that wasted about 25% with power-of-two payloads.
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
samples, alternating forward/reverse execution order. There are 131,072 parses per small-tree sample, 32,768 for medium/left-nested
trees, and 2,048 for the largest tree. The first whole-block run rejected one
small-tree identical-binary control at 10.08% with only 32,768 parses; the longer
sample keeps the same 10% rejection limit. It also rejected two later AMD64
controls, as recorded above; all attempts remain in the data.

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

The direct region pass took median 0.121–0.133 / 0.215–0.244 / 0.414–0.471 ms
for the 16/32/64-root synthetic programs across these hosts. It selected 8/15/30
roots and added 208/390/780 weight units against original weights 134/262/518;
all additions fit the declared limit. Sharing the same helpers makes this a
code-growth stress case, distinct from the exported-source comparison below.

For 16/32/64 distinct exported roots, 16/31/61 receive regions. At 64 roots,
complete C emission takes median 0.61–0.70 seconds versus 0.58–0.65 previously,
about 5–8% longer within sessions. Peak compiler RSS is about 78.7–79.6 MiB versus
70.6–71.3 MiB. Generated C shrinks from 5,158,763 to 3,182,737 bytes. This excludes
the subsequent C compiler; it shows extra frontend work/memory despite smaller
output. Full final-head G2 checks remain required.

## Earlier rejected evidence

- `40593725874` stopped before timing: the adapter expected a boxed public entry
  where the earlier compiler emitted an unboxed worker plus a public bridge.
  The repaired adapter checks and times the bridge explicitly.
- `40596927743` has valid runtime observations but invalid compiler-scale rows:
  the command selected empty `main` and omitted exported roots. Both writer and
  auditor now require every expected root. Its initial 4 KiB payload blocks also
  wasted space on small trees.
- `40642686229` passed all four sessions with growing payloads. Adding headers
  still caused extra allocator rounding; current whole-block sizes remove it.
  Separate runner allocations do not support a paired timing claim between
  those storage policies.
- `40650400349` rejected one small identical-binary control at 10.08%. The longer
  samples in `40652914476` rejected two controls, as detailed above. Preserve the
  failures and their absent candidate timings in the final evidence.
