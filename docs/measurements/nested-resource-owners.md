# Reuse an enclosing resource owner inside nested calls

**Selected from [verified service CPU samples](service-cpu-attribution-2026-11-10/README.md);
first native-lowering implementation passes focused correctness checks.** Reference compiler/runtime: `65719f7fc2277a5b97c5a790df941fea6c5eb4d7`,
retained by `roadmap/service-cpu-software-clock-2026-11-10`. Its ordinary code is
unchanged from the recorded service source. Freeze this contract before changing
production code. Keep earlier missed timing goals separate.

## The repeated work

A resource frame keeps a value alive until its original source call ends. This
preserves when a file closes or a weak channel reference expires, even after
inlining changes call structure. It is separate from an ordinary local's last use.

An inner call can currently retain the same value again:

```text
outer frame owns channel
  inner frame retains channel → work → releases extra owner
outer frame releases channel
```

If the outer owner necessarily survives the entire inner call, the inner frame
can rely on it. The program still closes the channel at the same point:

```text
outer frame owns channel
  inner call borrows that lifetime protection → work
outer frame releases channel
```

This is a compiler proof, not a new source borrow annotation or runtime guess.
The service profiles identify count work plus cleanup registration as substantial
costs. They do not predict the speedup from removing any particular subset.

## Bounded proof and implementation

Start with **nested parameter anchors** inside one generated function:

1. Track active original-frame owners and exact local aliases through lexical
   scopes. A plain alias or immutable record/variant projection may establish
   that an enclosing owner protects the inner parameter.
2. A binding becomes a protecting owner only after its initializer or matched
   pattern has completed and its original frame has registered it. An empty
   future slot does not protect anything.
3. The protecting frame must outlive every path through the inner region,
   including handled errors, cancellation and nonlocal unwind. Branch-local
   ownership cannot justify a sibling branch.
4. Preserve ordinary consuming calls, returns, retains, result owners and resource
   bindings. Remove only the proved duplicate parameter anchor and its now-empty
   cleanup frame. Unknown aliases, factories, mutable channel contents and
   cross-function/dynamic calls keep their current protection.
5. Preserve interpreter/debugger scope metadata and clearing of original locals.
   Prefer a native-lowering proof that does not change source evaluation or the
   interpreter's scope rules. Debug frames and entry/cancellation checks stay.
6. Traverse each body with scoped state and explicit rollback. Do not add repeated
   whole-program searches, recursive type expansion or speculative runtime checks.
   Verify that generated loop/tail-call rebinding cannot reuse an obsolete proof.

If aggregate projections cannot satisfy these conditions, first restrict selection
to exact aliases. Do not weaken safety or change disposal timing to meet a target.
Scope extensions need their own evidence, not automatic inclusion in this proof.

## Correctness and mechanism checks

- Compare raw interpretation, optimized interpretation and native O1/O2 on the
  eight existing service cases: 64/4,096 messages × delivery, cancellation,
  expiration and handled error. Preserve every receiver checksum and result field.
- Exercise nested aliases and projections, shared owners, branches, dead weak
  targets, escaped results, early failure, cancellation and storage reuse.
  Keep a negative case for each unproved lifetime boundary above.
- Count actual native retain/release and cleanup registration calls in diagnostic
  builds. Ordinary timing builds contain no counters. Require fewer parameter
  anchors and at least 20% fewer cleanup registrations in the large service cases;
  explain any different effect on reference counts.
- Retain complete generated C and binaries, selected/rejected proof examples and
  unwind/fault controls. An omitted necessary owner must fail the lifetime test.
- Run the existing resource-lifetime, weak-channel/service ledger, alias/unwind,
  callback, scheduler cancellation and HTTP cleanup groups. Require zero live
  service allocations after each completed/failed/cancelled call.
- Inspect the maintained HTTP endpoint for this same selected mechanism. Verify
  complete responses, disconnect/error cleanup and sustained-load behavior before
  claiming the improvement applies there. Do not infer an HTTP speedup from service
  samples or generated-code counts.

## Time, memory and compiler acceptance

Use native Linux ARM64/AMD64, two independently retained sessions per architecture,
explicit GCC O2 with no LTO and the existing architecture settings. Build ordinary
reference/candidate programs and identical copies. Keep the established independent
output oracle, balanced order, sixteen measured rounds, 50 ms pilot target and
5 ms minimum measured work. Every copy median must agree within the frozen 2% limit.
Retain all observations; do not rerun unchanged cases until they qualify.

| Quantity | Required evidence |
|---|---|
| Complete service time | At least 10% less time for each 4,096-message case in both sessions on both architectures; no 64-message case more than 2% slower. Construction, dispatch, validation and release stay inside the timer. |
| Peer comparison | C/Rust/Swift execute the same cases with their documented layouts. Report candidate/peer time and extra cost; keep differences in synchronization and representations explicit. |
| Managed storage | No increase in allocation requests or peak charged bytes for the service; physical release remains complete. Count savings alone are not memory savings. |
| Process memory | Ordinary peak RSS grows by no more than 5%; report raw KiB and runtime/library scope separately from managed storage. |
| Stack and code | Record generated frame sizes, cleanup-node storage and executable/code bytes. Explain stack increases; code size is secondary to time and working memory. |
| Compiler work | On the four complete applications and existing generic/nesting/width growth inputs, ordinary emit-C time grows by no more than 2% and peak RSS by no more than 5%, with the existing copy controls. Count proof visits and selected anchors separately from timing. |

No profiler or count report substitutes for ordinary timing. A failed noise control
is inconclusive; a qualified regression is a failed target. Keep both explicit.
After focused correctness, mechanism and measurement checks, run the nine final
production jobs, documentation and complete-log audit on one final PR head. Bundle
the selected compiler change, profiler repairs, reports and focused documentation.

## First implementation under verification

`src/cgen/resource_borrows.rs` scans each exact emission tree twice: it rejects
reassigned local IDs, then tracks enclosing ownership with scoped rollback.
Initialized frame bindings, exact aliases and immutable record/variant projections
can cover an inner parameter. Calls and newly constructed/updated values do not.
Loop-step and self-tail-rebinding bodies are excluded. Ordinary argument owners,
resource bindings, cancellation ticks and interpreter metadata remain unchanged.

Seven proof controls cover aliases/projections, uninitialized slots, completed
scopes, factory results, pattern branches, sibling scopes, reassignment and count
operations. The actual service ledger test requires the optimized program to
exercise this selection before checking native outputs and physical release.
[Native O1/O2 checks](nested-resource-first-checks-2026-11-10/README.md) pass on
both Linux architectures. The first workflow failed its setup for formatting and
Clippy; the repair installs both components. Ordinary performance acceptance and
final delivery remain pending.

The count comparison builds the same source twice, disabling only
`NESTED_RESOURCE_BORROWS` in the reference checkout. It retains that exact patch,
compiler hashes, generated C and native binaries. Separate diagnostic builds count
actual cleanup push/pop/unwind calls, retain/release calls, successful count
increments/decrements and allocation requests. Peak charged storage includes slot
padding; it is not process RSS. Each service call must restore its original live
bytes and cleanup stack. Native controls add one real push/pop pair or omit the
real result release. These measurements do not time instrumented code or infer
elapsed-time gains from count reductions.
