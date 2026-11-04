# Private numeric inputs for derivative objectives

**Native correctness and measurements audited; three AMD64 timing limits remain
open. Final gates are pending.**
The contract was frozen at `cc425aba` before code changes, tag
`roadmap/packed-derivative-inputs-protocol-2026-11-04`.
The [source review](numeric-record-inputs-2026-11-04/README.md)
identifies the remaining boxes and list cells at `82963531`. The starting
delivery tree is PR #256's tested `81bce309`, merged as `cfb6dcc4` with the same tree.

## Example and selected cost

An objective is the function whose derivative we calculate. Rosenbrock reads
neighboring inputs: `[a, b, c]` supplies `(a, b)` and `(b, c)`. During automatic
differentiation, each input is a numeric record `(value, tape-node-number)`.
The middle record must remain available for both reads.

```text
Reference: prepare N boxes + N list cells → map neighboring pairs → fold costs
Candidate: prepare one numeric buffer    → map neighboring pairs → fold costs
```

The three stages stay separate and eager. Finish every input record before the
first pair callback; finish every pair callback before the fold seed and fold.
Keep arithmetic, callback, trap and cleanup order. Coordinate results remain
immutable lists; coordinate-list reuse is outside this group.

## One coherent implementation group

1. **Specialize known scoped calls.** Recognize the exact typed `ad.scope2`
   primitive with a known two-argument worker and a closed, known first argument
   that is itself a function. Copy the worker with that function known inside
   its body; keep the same scope primitive, arguments and worker arity. Do not
   preapply the worker, add a wrapper or move work across scope entry. Unknown
   functions and captured callbacks remain ordinary calls.
2. **Pack a private indexed producer.** After existing range consumption, select
   a typed numeric-record `RangeZip` whose result has only the proved pair-map
   uses below. Preserve argument order, range bounds and checked callback
   arithmetic. Invoke the existing field-return entry and write its numeric
   fields into one owned word buffer, without boxing records or list cells.
3. **Read overlapping windows.** Select an existing packed-record pair mapper
   reading the produced list and its exact `drop 1` suffix. Accept either pair
   order. Replace these two list views with two borrowed windows of the same
   buffer, preserving callback argument order. The pair mapper still produces
   its separate numeric buffer; the existing fold remains unchanged.
4. **Verify and measure the whole group.** Include selection controls, ordinary
   and exceptional cleanup, compiler costs, complete-program timing/memory,
   documentation and all final platform gates in one delivery PR.

The scope specialization visits original functions once, caches each worker /
known-function pair and reuses existing body/inlining limits. Do not recursively
specialize newly made workers or add a global fixed-point analysis. Check exact
types and arities; recognize primitive identities, not tutorial function names.

The [scoped source diagnostic](scoped-objective-review-2026-11-04/README.md) adds
one required step inside those workers: reassociate nested, unobservable `let`
bindings without reordering computations, so existing record scalar replacement
can expose the producer. Charge each rewrite to the existing budget; exclude
resource regions and anchored/observable owners. Verify effect/trap order,
exclusions and budget exhaustion. This proof extension precedes its implementation;
the original frozen contract remains at its immutable tag.

The storage pass follows existing packed-record, range and numeric-parameter
lowering, before ownership insertion. Numeric-parameter lowering must first
expose field-only reads inside forwarding pair callbacks; selecting before it
incorrectly misses the real gradient programs. The original frozen contract
keeps that failed ordering; the retained preflight records its correction.
Use bounded local use analysis.
Reject additional reads, escapes, unknown consumers and branch-crossing aliases.
Straight-line aliases may qualify only when every use resolves to the same two
windows and no resource frame anchors the representation.

The [three-host correctness gate](packed-input-checks-2026-11-04/README.md)
passes both interpreters, O1/O2 values, one-field records, F32/F64 bits and all
cleanup/count controls. [Earlier failures](packed-input-selection-2026-11-04/README.md)
remain retained. Compiler-cost input inspection required the pre-timing repairs
below. The [completed compiler comparison](packed-input-analysis-2026-11-04/README.md)
passes all fourteen input/architecture cases; compiler time increases by at most
4.32% and peak RSS by at most 0.82%. [Runtime audits](packed-input-time-2026-11-04/README.md)
verify storage/count savings and preserve three AMD64 timing misses. Final
platform support still needs the complete production matrix.

## Ownership and failure proof

- Select only flat records of one or two machine-sized numeric fields, with a
  proven field-return ABI. Producer captures and scalar inputs own no child
  storage. F128, nested records, resources and boxed results are excluded.
- The producer borrows its callback and scalar list. Evaluate inputs once at
  their existing positions. Limit work by both the list length and unsigned
  range distance; avoid signed overflow and check buffer-size multiplication.
- Protect the buffer before invoking any callback. A completed or partial
  numeric buffer has one owner and no child owners. Failure or cancellation
  frees it exactly once. Do not write outside its declared length.
- The pair mapper borrows the input buffer and owns/protects its output buffer.
  Both windows remain valid through the last callback. Release the input after
  pair mapping and before folding, as with the existing list owners.
- No field may escape as a pointer into the buffer. Whole-value uses exclude
  selection. Final results use existing independent owners.
- Preserve the AD scope's tape cleanup and existing cancellation checks. Raw
  tape storage and workspace policy are not changed by this representation.

## Required checks

| Area | Controls |
|---|---|
| Scope | Known/unknown objectives; repeated identical specializations; distinct workers; recursion; wrong primitive/type/arity; effectful partial application; entry and failure order. |
| Inputs | Empty, singleton and longer lists; both pair orders; scalar captures; negative/extreme/empty bounds; short list/range; signed zero and NaN bits. |
| Uses | Aliases, additional reads, returned/stored inputs, branches and resource frames. Unsupported cases keep their correct ordinary representation. |
| Owners | Caller aliases unchanged; failure during producer and pair callbacks; cancellation; partial output; scope failure; final zero managed/raw storage and empty cleanup stack. |
| Observer | Deliberately omit each buffer release and corrupt a selected field; require leak/value checks to reject the controls. |
| Backends | Raw/optimized interpreter agreement and generated O1/O2 on GCC ARM64/AMD64 and Clang ARM64. Retain C, actual binaries and count profiles. |

Extend existing targets where practical; verify native shard coverage for any
new target. The primitive inventory must still pass its frozen baseline.
Focused checks follow the complete implementation group. Full suites run only
on GitHub for the final PR head, with nine production jobs plus documentation.

## Frozen comparison and acceptance

The reference uses the same source with only the new scoped specialization and
packed-input selection disabled. Both sides keep all existing ownership repairs,
optional fields, history removal, range consumption and packed pair folding.
Check that only the declared selection edits differ, including negative controls
for missing/duplicate/changed edits. Retain both source and compiler identities.

- **Counts:** a selected two-field producer of N results replaces N record boxes,
  N list cells and one scratch allocation with one buffer: predict 2N fewer
  requests. When range length equals input length, predict 40N fewer requested
  bytes on the existing 64-bit layout. Check the formula against actual counters,
  including N=0 (one scratch request becomes one empty-buffer request).
- **Complete work:** for 129 coordinates and 199 updates, predict 51,342 fewer
  requests and 1,026,840 fewer requested bytes per solve. Verify both source
  forms. Require no added ARC, no increased peak managed storage, unchanged raw
  tape profiles and zero final managed/raw storage. Report process RSS separately.
- **Timing:** retain the existing six coordinate/update pairs, both source
  forms, two qualified sessions per architecture, two warmups and 98 balanced
  rounds of seven processes per sample. Use the [previous explicit settings](matched-option-time-2026-11-04/README.md).
  Require identical-copy variation ≤2%, no case more than 2% slower, and at least
  5% faster for every case with 199 or more updates. No Swift derivative peer
  exists; C/Rust manual derivatives measure a different implementation, not ARC
  alone. Preserve that distinction and all outputs/workload checks.
- **Compiler/stack:** at most 5% additional compiler elapsed time or sampled
  RSS; report native text size and limit frame growth to 128 bytes. Exercise
  repeated calls and large rejected bodies to check bounded specialization.

Before any measurements, the driver declares seven compiler inputs per host:
field-owner transfer, the autodiff tutorial, 3/0, 33/199 and 129/199 gradient
programs, 64 calls sharing one known scoped worker, and a worker calling a large
dynamic body. Each gets 48 balanced compilation commands (two
warmup rounds and ten measured rounds across four compiler copies). These time
startup through C emission and report whole-command peak RSS. They do not run
the generated programs. Untimed compilation checks both inputs with candidate
and reference before the first timed command. It verifies 64 live scope calls,
one shared specialization and one copy of the large dynamic body.
These four untimed checks are excluded from the elapsed/RSS ratios; the 336
scheduled compiler commands per host remain unchanged.

Inspection caught two ineffective fixtures before timing: executable builds
ignored unused exports, and constant scope inputs lacked the expression type
needed by this specialization. The entry now reaches all 64 calls explicitly
and reads its numeric input from the number of input lines. No timed program
is executed; the read keeps the value unknown during compilation.

The large-case description also needed correction: the compiler moves its
5,120 callback calls into one helper. The small wrapper may specialize, but
that helper stays shared. This measures compile cost around a large callee;
it does not test rejection of the wrapper.
The separate `large_workers_keep_the_existing_body_limit` unit test directly
checks the specialization limit. The seven-case schedule and acceptance limits
are unchanged; fixture and observation repairs precede all timed runs.

Explicit suites: `packed-input-checks` runs GCC ARM64/AMD64 and Clang ARM64;
`packed-input-analysis` and `packed-input-time` require that completed,
source-matching gate. `packed-input-report` independently audits the saved raw
runtime records. Keep those jobs distinct from the final production PR matrix.

Preserve every failed/noisy result. Never rerun a completed timing for a pass.
The accepted policy permits retaining verified reductions while timing goals
remain explicitly open; it does not turn a missed limit into a pass or close
older comparisons with different references.
