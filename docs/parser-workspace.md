# One lifetime for a parser's tree

A6 optimizes a parser written in fwp. It is verified in
[#221](roadmap-history.md#scoped-parser-storage-and-analysis-work-pr-221), including
all native platforms and the declared WASI checks. It does not change fwp's source parser.
fwp arithmetic uses infix notation: `2 + 3 * 4` evaluates to `14`.

The [benchmark program](../tests/fixtures/parser_workspace.fwp) reads a different,
deliberately small text format: each operator precedes its two operands. Its
input string `"+ 2 * 3 4"` builds a five-node tree for that calculation. This is
quoted input data, not legal fwp arithmetic syntax. All tree nodes contain either
an integer or links to other nodes. Input Strings and the token list keep their
ordinary owners. See [fwp operator precedence](compiler-pipeline.md#tokens-layout-and-precedence)
for the language grammar.

Before A6, each heap node had an individual lifetime. The implementation
lets one function call own a collection of storage blocks, called a region.
Each recursive call is a separate invocation. Links
within those blocks need neither ownership counts nor individual destruction.
The invocation releases all its blocks after evaluation, including on failure.
This trades earlier individual frees for bulk cleanup; peak storage must be
measured, not assumed to improve.

## Admission proof

The admitted node type is a recursive variant whose fields are I64 (signed
64-bit integers) or links to that same variant.
Do not admit Strings, files, channels, closures or unrelated managed fields in
nodes. Their destruction could have obligations beyond freeing region storage.

A selected invocation must have no node-containing parameter or result.
Do not lift ownership to a surrounding repetition loop: each parse needs its own
cleanup boundary. Reject self-tail roots until region cleanup across their back
edges is implemented and measured. Within
it, nodes may appear in local records and pass through known recursive helpers.

Every helper that receives or returns those nodes needs a specialized internal
version. The ordinary helper remains available to the `escaping` example, which
returns a tree to its caller. Returning a tree is legal; it prevents this storage
optimization for that invocation.

Reject unknown calls involving nodes, function values whose signatures contain
nodes, captures, global storage, collection/runtime/foreign boundaries involving
nodes, and resource scopes. Cached zero-argument graph definitions also stay outside:
their storage belongs to the cache, not the selected invocation. Pure scalar and String operations keep their existing
contracts. A failure primitive may terminate a node-producing expression; it
cannot return a node. Validate its precise existing contract before admitting it.

Use a finite worklist over types and direct helper calls. Cache containment of
the candidate node type, visit each selected helper once, and count analysis
work. Recursive helpers do not require arbitrary symbolic execution. The current selection budget is eight units per original expression, local and
type edge; proof visits consume it.

Completed cloned functions and locals may add at most
twice the original expression/local weight; check their actual rewritten weight
before publishing a candidate. A candidate that exceeds a budget
keeps ordinary ownership. Measure these limits on larger programs and preserve
the existing G2 compiler-analysis checks; bounded work is not a measured compile-time result.

## Representation and cleanup

The compiler must distinguish a region link from an independently owned node in
its internal types or equivalent explicit metadata. Merely allocating a node
without a count slot would still leave count attempts and generic cleanup in the
program. It would also make mixed records easy to destroy incorrectly.

Pass the region address explicitly between specialized internal helpers. Do not
use a process/thread-global current region: nested invocations and task suspension
must preserve the correct owner. A recursive call to the public entry creates a
fresh owner; helper recursion within one parse uses that parse's existing owner.

The original public function signature remains
unchanged. The lowering uses an internal region-entry body that creates
the owner and calls a worker with an explicit extra context parameter. Specialized
node shapes carry region identity; selection must never depend on a generated
type-name prefix.

Ordinary constructors and workers stay available for escaping
callers. One cleanup registration owns the block list before the first possible
allocation; ordinary pending-argument cleanup remains responsible for token and
String owners. Helpers never destroy the region. Every exit from its owner does.

Use aligned blocks with checked size arithmetic. A failed allocation must leave
the previous block chain intact. Construction initializes a node before exposing
its address. Cleanup follows only the block chain, never the node graph. No link
may survive cleanup, and no ordinary reference-count operation may see one.

## Evidence required in the same delivery

| Check | Required observation |
|---|---|
| Values and errors | Raw interpreter/native agreement for valid input, missing operands, invalid integers, trailing input and checked arithmetic overflow |
| Boundaries | Escaping tree stays usable; unknown/captured/container uses keep ordinary ownership; no scope-local address reaches an external caller |
| Exceptional exits | Each block-allocation failure, parse failure and cancellation frees every block and preserves independently owned inputs |
| Reentry | Inner success/failure cannot free outer nodes; suspended tasks cannot use another invocation's region |
| Repetition and growth | Repeated fixed-size parses restore the same live baseline; larger inputs have explicit block/peak-storage observations |
| Actual code | Generated C and native binaries show no per-node retains, releases, uniqueness tests or count slots for admitted links |
| Cost | Count allocations, node/block bytes, retained peak bytes, code size, stack frames and compiler-analysis work |

Use these fixed input families; a full binary tree has two children at each
non-leaf node. The benchmark generator emits prefix `+` tokens and decimal leaves
numbered in traversal order, with value `index % 17 - 8`. Its independent result
is the sum of those leaves. Small semantic cases separately exercise multiplication.

| Case | Nodes / maximum depth | Purpose |
|---|---|---|
| Balanced small | 31 / 5 | Fixed block overhead and short parses |
| Balanced medium | 511 / 9 | Multiple blocks and ordinary traversal |
| Balanced large | 8,191 / 13 | Growth, retained storage and throughput |
| Left-nested | 127 / 64 | Stack/frame observation, not a constant-stack claim |
| Repeated | Each balanced case, 1/16/256 invocations | No retained growth between invocations |

The block-engine probe additionally uses 0/1/257/8,193-node chains, independently
checks values/alignment/count-slot absence, and fails every block allocation. Its
missing-free control must fail the physical-storage check. These are allocator
checks; the generated parser still needs its own ownership observations.

Whole blocks start at 256 bytes and double through 512, 1,024 and 2,048 bytes,
then stay at 4,096 bytes. These sizes include the owner header, so they fit native
allocator size classes without another round-up. Oversized nodes receive their
exact checked requested size. The initial fixed 4,096-byte payload policy wasted
3,480 payload bytes for the 31-node tree; the current policy reserves 768 total
bytes for its two blocks, including headers. Measure actual allocation and peak
storage too: removing individual counts does not imply a memory win.

The [measurement protocol](measurements/parser-workspace.md) defines the peers,
phase boundaries, storage accounting, repeated sessions and rejection controls.
For timing, compare the previous counted fwp program, the candidate and explicit
C/Rust arena implementations of the same prefix grammar. Predeclare token inputs,
node counts, checked arithmetic and output oracle.

Separate tokenization from tree
construction, traversal and cleanup. Report end-to-end cost separately if the
implementations use different token containers. C/Rust must perform the tree
work; evaluating tokens directly is a different algorithm. Freeze same-host noise
controls and timing budgets before candidate measurements, retain every sample,
and repeat on independent Linux ARM64/AMD64 runner allocations.

This establishes one bounded workspace. It does not establish general region
inference, constant memory for growing inputs, or a workspace for autodiff.
See [maintained ownership guarantees](../PLAN.md#maintained-guarantees-and-evidence) and
[the accepted memory direction](gc-removal-design.md).
