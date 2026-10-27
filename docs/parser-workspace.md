# One lifetime for a parser's tree

A6 is under validation, not verified support yet. The first example is
[the prefix-expression parser](../tests/fixtures/parser_workspace.fwp):
`+ 2 * 3 4` builds the tree for `2 + (3 * 4)` and evaluates to `14`.
All nodes contain either an integer or links to other nodes. The input Strings
and token list keep their ordinary owners.

Today, each heap node has an individual lifetime. The proposed implementation
lets one invocation own a collection of storage blocks, called a region. Links
within those blocks need neither ownership counts nor individual destruction.
The invocation releases all its blocks after evaluation, including on failure.
This trades earlier individual frees for bulk cleanup; peak storage must be
measured, not assumed to improve.

## Admission proof

Start with a recursive variant whose fields are only I64 or that same variant.
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
type edge; proof visits consume it. Cloned functions and locals may add at most
twice the original expression/local weight. A candidate that exceeds a budget
keeps ordinary ownership. Measure these limits on larger programs and preserve
the existing G2 compiler-analysis checks; bounded work is not a measured compile-time result.

## Representation and cleanup

The compiler must distinguish a region link from an independently owned node in
its internal types or equivalent explicit metadata. Merely allocating a node
without a count slot would still leave count attempts and generic cleanup in the
program. It would also make mixed records easy to destroy incorrectly.

Pass the region address explicitly between specialized internal helpers. Do not
use a process/thread-global current region: nested invocations and task suspension
must preserve the correct owner. The original public function signature remains
unchanged. The lowering uses an internal region-entry body that creates
the owner and calls a worker with an explicit extra context parameter. Specialized
node shapes carry region identity; selection must never depend on a generated
type-name prefix. Ordinary constructors and workers stay available for escaping
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

The draft allocator uses 4,096-byte payload blocks plus an owner header. Report
unused payload bytes explicitly, especially for small trees: removing individual
counts can increase retained storage. Do not infer a memory win from block count.

For timing, compare the previous counted fwp program, the candidate and explicit
C/Rust arena implementations of the same prefix grammar. Predeclare token inputs,
node counts, checked arithmetic and output oracle. Separate tokenization from tree
construction, traversal and cleanup. Report end-to-end cost separately if the
implementations use different token containers. C/Rust must perform the tree
work; evaluating tokens directly is a different algorithm. Freeze same-host noise
controls and timing budgets before candidate measurements, retain every sample,
and repeat on independent Linux ARM64/AMD64 runner allocations.

This establishes one bounded workspace. It does not establish general region
inference, constant memory for growing inputs, or a workspace for autodiff.
See [A6 in the plan](../PLAN.md#2-minimize-arc-in-named-unshared-paths) and
[the accepted memory direction](gc-removal-design.md).
