# Reuse consumed numeric arrays and coordinate lists

**[Native verification](owned-numeric-checks-2026-11-05/README.md) and the
[whole-solve allocation census](owned-numeric-census-2026-11-05/README.md) pass.
[Compiler-cost limits also pass](owned-numeric-analysis-2026-11-05/README.md).
[Runtime results are audited](owned-numeric-time-2026-11-05/README.md), with four
AMD64 speed targets open. [Production delivery is verified](../roadmap-history.md#consumed-numeric-storage-pr-258).**
Contract frozen before implementation at `1c5e6a66`, immutable tag
`roadmap/owned-numeric-updates-protocol-2026-11-04`.
Starting source: `519fc96670b0db90ebe0f68e1263ccf85d2cf4f1`.
The [current storage review](remaining-gradient-storage.md) identifies coordinate
cells as remaining allocation traffic. The [packed-input measurements](packed-input-time-2026-11-04/README.md)
retain the starting counts and all three open timing limits.

## What changes

A gradient update scales each derivative, then subtracts it from a coordinate:

```text
coordinates [10, 20, 30], gradient [2, 4, 6], step size 0.5
finish scaling:    [1, 2, 3]
finish subtraction: [9, 18, 27]
```

The reference loop allocates a second gradient array and a fresh coordinate
list, then releases both old inputs. This group gives the compiler two private
operations that consume an input owner. Consuming means the caller transfers its
reference; it does not mean no other owner exists.

| Operation | Reuse when safe | Sharing case |
|---|---|---|
| Same-type numeric array map | Overwrite an ordinary array with one owner, in callback order. | Allocate independent output for a shared array or view. |
| Array/list numeric zip | Reuse the exclusively owned prefix of the coordinate list after all callbacks finish. | Copy the shared suffix; preserve every alias. |

Source values stay immutable. The public borrowing contracts of `array.map` and
`zip-with` do not change. The operations remain separate eager stages: complete
the gradient, complete scaling, complete subtraction, then publish coordinates.
No arithmetic reassociation, syntax, tracing, compatibility adapter or JIT.

## Selection and bounded compiler work

- Run after numeric representation lowering and before borrow inference/ARC
  insertion. Represent consumption explicitly in private operation metadata;
  do not hide mutation inside a borrowing entry.
- For array mapping, require a known closed unary callback and identical input
  and output scalar types. Accept machine-sized integers, F32 and F64 only.
- For coordinate zip, start from `ScalarBufferZip` with its existing known
  scalar callback and either array argument position. Require its result type
  to equal the list element type. The array remains borrowed; consume the list.
- Select a direct local input at a proved last use, or a returned array owner
  under the extension below. Track later uses in bounded
  expression traversal, including other arguments, enclosing continuations and
  branches. Exclude resource regions, anchored owners and unproved paths.
  Do not rescan the whole remaining function for each candidate.
- Recompute borrow inference, argument preparation and exceptional liveness
  after selection. A borrowed function parameter must not silently become an
  owned input. A source alias may still require a retain; runtime uniqueness
  checks decide whether that particular object can be reused.
- Exclude wide/boxed/resource elements, captured or unknown map callbacks,
  type-changing maps and unsupported representation boundaries. Cache private
  entries by their complete callback/type/argument-position key. Visit original
  bodies once; do not specialize newly generated entries recursively.

## Ownership and failure proof

### Selection extension before timing

Frozen by `roadmap/owned-numeric-selection-proof-2026-11-04` before code changes.

[Complete-program inspection](owned-numeric-selection-2026-11-04/README.md)
found that the first pass excludes both operations in the current-only loop and
the array operation in the history form. These narrow additions were frozen
before implementation; all count and timing limits remain unchanged:

- A fully applied direct call returning the exact array type produces an owned
  result. Allow that result as the map input without introducing a new evaluation
  step. It may alias another value; runtime uniqueness still decides reuse.
- A record or variant constructor owns its fields. Allow selection inside those
  fields when the constructor itself is in an eligible context. Track later
  fields as later uses. Earlier fields already require their own owners; rerun
  ARC insertion to prepare them before a later consuming operation.
- Continue excluding ordinary call/apply arguments, borrowed record arguments,
  field projections, record updates and resource anchors. Do not move effects
  across arguments or add general expression normalization.
- Require unit ownership checks for temporary call results, both alias orders
  in owned fields, constructor branches, nested ordinary-call exclusion and
  bounded traversal. Add native value/cleanup coverage for these boundaries.
- Require live consuming map and zip calls in both complete gradient forms,
  followed by the whole-solve allocation-count check before any timing.

This keeps selection and rewriting bounded by the original body and signature
sizes; no repeated suffix scan or recursive specialization is introduced.

### Array map

Protect the transferred input before any allocation or callback. Use
`fwp_rc_unique_mut`, which respects disabled reuse; never use the destruction-only
last-owner check as permission to mutate. Views and shared arrays keep their
backing owner alive and receive separate output. Plain scalar slots own no child
values. Partial overwrites on a private array cannot be observed after a trap;
the protected input is freed exactly once. Independent output has its own cleanup
owner, and both owners are released on allocation failure or cancellation.

### Coordinate list

1. Protect the consumed list before allocating scratch. Read original scalar
   values and run callbacks in the existing order, limited by the shorter input.
2. Complete every callback before changing any list link or scalar field. Keep
   the array borrowed and live throughout this stage.
3. Reuse only the contiguous exclusive prefix, checking each node with
   `fwp_rc_unique_mut`. At the first shared node, stop testing descendants for
   reuse: another owner can reach them even if their own counts equal one.
4. Copy the remaining output suffix. Keep the partial result and remaining old
   input separately protected. Transfer each link exactly once; never leave two
   cleanup owners for the same reference. A shorter array must release the unused
   old tail without exposing it in the result.
5. Release scratch and the unused/shared old input on success. On failure,
   cancellation or allocation failure, release input, scratch and partial output
   exactly once, with no leaked reference or physical allocation.

The implementation must state its cleanup invariant at every detach/attach step.
Retained histories and callback-accessible aliases must see their original values.
Allocation counts may change; callback order, checked arithmetic, observable
effects, ordinary traps and resource cleanup order must not.

## Verification before measurements

| Area | Required controls |
|---|---|
| Selection | Last use versus later use; earlier/later arguments; aliases; branches; resource regions; both zip orders; type-changing map exclusion; bounded repeated calls. |
| Values | Empty, singleton and longer inputs; shorter array/list; signed integer bounds; F32/F64 signed-zero and NaN bits; ordinary arrays and sliced/shared views. |
| Sharing | Root alias; exclusive prefix/shared tail; shared ancestor with count-one descendant; retained input and history; callback observes an alias. |
| Cleanup | Traps at each callback position; checked overflow; cancellation; allocation failures in scratch/output construction; final zero managed/raw storage and empty cleanup stack. |
| Reuse | Enabled and disabled reuse; actual allocation/count profiles and physical frees; intentionally corrupt a reused value and omit a release to prove observers reject them. |
| Backends | Raw and optimized interpreters; native O1/O2 on GCC ARM64/AMD64 and Clang ARM64. Retain generated C, binaries, inputs, outputs and every failed log. |

Use existing ownership/array/zip targets where possible. Check the primitive
inventory and native shard coverage. Group both implementations and focused
checks before the full final production matrix; do not run full local suites.

## Comparison and acceptance

The reference is the same source with only these two private consuming selections
disabled. Keep packed derivative inputs, existing lifetime fixes and all earlier
optimizations on both sides. Verify the exact reference edits and deliberately
missing/duplicate/altered edits before timing. Retain both compiler identities.

- **Allocation prediction, not a result:** for a fresh F64 gradient array of N
  elements, reuse removes one request and `8N+8` requested bytes per map on the
  current 64-bit layout. A reused coordinate cell removes one request and 24
  bytes. Verify layouts and exact counters before accepting either formula.
- For an initially shared N-coordinate input followed by U updates producing
  exclusive coordinates, predict `N * max(U-1, 0)` reused cells. For N=129,
  U=199, both operations together predict 25,741 fewer requests and 819,968 fewer
  requested bytes per solve. These predictions require proving actual live
  selection and uniqueness; revise a disproved prediction openly before timing.
- Require no additional whole-solve retains or peak managed storage, unchanged
  raw tape storage, and zero final managed/raw storage. Report array, coordinate
  and scratch costs separately. Report process RSS even when it does not fall.
- Before timed comparisons, the allocation-count check (`owned-numeric-census`)
  builds the same-source
  compiler pair and checks all six repeated solves, both result forms and both
  workspace settings. It retains generated C, native images, exact commands and
  raw counts. An unexplained increase **or additional saving** stops acceptance
  of the prediction; inspect it before timing. This run collects no timing samples.
- Keep the six coordinate/update pairs, current/history forms, two qualified
  sessions per architecture, two warmups and 98 balanced rounds of seven processes
  per sample from the [existing runtime protocol](packed-derivative-inputs.md#frozen-comparison-and-acceptance).
  Require copy variation at most 2%, no case over 2% slower, and at least 5% less
  elapsed time for every case with 199 or more updates. Preserve every miss.
- Keep the seven existing compiler inputs and 48 scheduled compilations each.
  Run four untimed objective-scope checks plus two consuming-selection checks
  (candidate/reference) before any timing. The latter require live calls from
  all seven exports and reject consumption of an input read again afterward. Compiler elapsed time and peak RSS may grow at most 5%; frame growth
  at most 128 bytes. Report code size; it is not the main performance objective.
- C/Rust manual derivatives do different work; their ratios do not isolate
  language or ARC overhead. This experiment includes no equivalent Swift derivative peer.

The accepted policy may retain verified reductions with timing goals explicitly
open. A new reference cannot settle the old packed-input or other timing misses.
Never rerun unchanged measurements for a passing result. Publish one grouped PR;
merge only after all nine exact-head production jobs and docs
pass and every completed target/log is audited.
