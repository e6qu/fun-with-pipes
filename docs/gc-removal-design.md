# GC removal and ownership direction

The accepted design combines inferred moves and borrows, reference counting for
sharing, and explicit weak links where an owning cycle would otherwise form.
Weak channels and retained C callbacks passed all production gates in #215.
A [restricted count-free array path](measurements/unique-array-storage.md) is
verified in #219. The [scoped parser path](parser-workspace.md) now implements
one bounded region proof; its complete platform validation is pending.

[PLAN.md](../PLAN.md) gives the work order and completion checks;
[ownership.md](ownership.md) describes current implementation. APIs and layouts
may change freely during pre-alpha.

## Implementation contract

- Infer moves and borrows; use direct values and count-free unique storage where
  their complete lifetime is proved. Use ARC for independent shared ownership.
- Reject unproved owning cycles. Use explicit weak links for selected
  identity-bearing objects; weak channels are implemented. Never weaken captures
  implicitly or permit unexplained retention in place of a lifetime proof.
- Preserve escaping functions, returned partial applications, immutable values,
  checked arithmetic and effect/failure order. No new pipe syntax is required.
- Use regions for suitable bounded workloads, not as a mandatory replacement
  for all storage. Region references must not escape their owner; releasing
  memory does not replace resource cleanup.
- Bound analysis through finite summaries and measure its scaling. Precise
  acceptance of every safe program is not a requirement.

Exact weak target types, API names, acquisition semantics and release timing are
specified in [weak channels](weak-channels.md) and the six examples below.
The [analysis report](measurements/ownership-analysis.md) records the measured
baseline and enforced budgets. Revisit the direction only for a concrete defect
or unsupported example. If a concrete example requires a new language restriction, explain
that tradeoff before adopting it; do not silently drop a maintained capability.

## The choice we actually have

Type inference determines what a value is. Ownership analysis determines who
keeps its storage alive and whether a use can outlast that owner. Better type
inference alone cannot reclaim an actual cycle of strong references.

A strong reference keeps its target alive. A weak reference permits access only
if the target is still alive. A region owns a group of allocations and releases
them together. References between objects within that region need not own them.

These solve different problems. Borrowing removes unnecessary counting; weak
references break selected owning edges; regions give related data one lifetime.
None requires changing pipe or application syntax.

## What the other languages establish

| Model | Useful mechanism | Limit relevant to fwp |
|---|---|---|
| Swift | ARC with explicit weak references; weak reads can report expiration | Ordinary strong cycles can leak; programmers choose the weak edges |
| Lobster | Inferred borrowing and ownership specialization, with runtime counts where needed | Its cycle report at exit does not reclaim cycles during a long-running service |
| Goose | Compiler-assigned data stacks and inferred reference roots | Lifetimes constrain programs; this is a different memory model, not a stronger ARC optimization |

Swift's [ARC guide](https://raw.githubusercontent.com/swiftlang/swift-book/main/TSPL.docc/LanguageGuide/AutomaticReferenceCounting.md)
describes the programmer's cycle-breaking responsibility. Its
[runtime reference-count implementation](https://raw.githubusercontent.com/swiftlang/swift/main/stdlib/public/SwiftShims/swift/shims/RefCount.h)
separates object lifetime from weak-reference metadata lifetime. For fwp, weak
access must synchronize with final release and must never acquire a replacement
object merely because its address was reused. Swift also has
[noncopyable values](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0390-noncopyable-structs-and-enums.md);
ARC is not its only ownership tool.

Lobster's [memory guide](https://aardappel.github.io/lobster/memory_management.html)
combines ordinary ownership with inferred borrows and specializes functions by
ownership. It reports removing about 95% of count operations in the author's
testing; that is not a guarantee or an fwp measurement. Its proposed strict
single-owner mode is marked unimplemented in that guide. The
[language specification](https://aardappel.github.io/lobster/language_spec.html)
also matters: function values carry no captured state; free-variable access
requires the enclosing activation to remain active. This does not establish
support for fwp's escaping closures under the same analysis.

Goose's [overview](https://aardappel.github.io/goose/) describes large virtual
address reservations used as data stacks, not allocation-free execution on the
native call stack. Its [draft specification](https://aardappel.github.io/goose/docs/goose_spec.html)
specializes functions by reference roots and restricts growable locals across
recursive calls. The overview excludes escaping closures and function pointers.
Reusable pools can reuse a slot while an old reference still names it. For fwp,
a handle that promises object identity should instead detect deletion/reuse.
Packing everything is also not our goal: alignment and numerical throughput must
be measured alongside byte savings.

These are studies of published designs, not independent soundness audits or
reproduced performance results. Some documents include unfinished work; do not
turn their aspirations into fwp acceptance claims.

## Engineering effort

Relative estimates below are engineering judgments, not schedules. Keeping APIs
is not a constraint. Keeping an explicit, testable lifetime contract is.

| Route | Main implementation work | Cost and uncertainty |
|---|---|---|
| Weak references plus existing ARC | Decide eligible target identities; implement weak metadata, acquire/expire/release, synchronization and interpreter behavior; integrate captures, queues and foreign ownership | A bounded feature, but final-release races, reuse and observable lifetime are substantial work. It does not itself reduce ARC or prove absence of leaks |
| Stronger static ownership with restricted cycles | Define accepted ownership graphs; infer borrowed/consumed/returned ownership, capture and escape relationships; handle recursive summaries and diagnostics | More compiler work. Predictable only with deliberately limited facts and conservative rejection; arbitrary exact cycle/lifetime inference is not a finite engineering objective |
| Replace general ownership with regions/data stacks | Redesign containers, return storage, recursive construction, escaping functions, tasks, resources and external interfaces; implement region checks and layouts | Broadest language/runtime change. Potentially removes per-object bookkeeping, but creates new lifetime and retention tradeoffs |
| Selected combination | Inferred moves/borrows and unique storage; ARC for genuine independent sharing; explicit weak edges; regions for suitable bounded workloads | Separate correctness from optimization. Do not make every value weak-capable or require general region inference before deleting tracing |

Weak support changes optimization rules too: an apparently unused strong owner
may still have observable expiration or resource cleanup. Count-free unique
storage must not silently become shared through a weak acquisition. Define these
interactions before choosing layouts; existing layouts are replaceable.

## A concrete cycle example

The arrows below describe ownership, not proposed fwp syntax:

```text
queue owns callback; callback owns queue
```

Removing the last outside reference leaves both objects alive under ARC.
Replacing the callback's edge with a weak reference allows the queue to die.
Invoking the callback then either acquires a temporary live owner or observes
expiration. However, storing that acquired owner back into a callback owned by
the queue recreates the strong cycle. Merely limiting the acquire operation to
a callback does not prevent this store.

The selected contract rejects unproved owning cycles, including stores of
acquired owners that can recreate them. The diagnostic must identify the edge
and show a usable alternative: an explicit weak edge, an independent owner, or
a region/graph handle. A proof may conservatively reject a program that would
not actually cycle. Improving that precision is separate from memory safety.
Swift-style programmer-managed strong-cycle leaks are not the selected policy.
Logical cycles inside a region are allowed only when its internal links do not
own the region. Unsafe/foreign contracts still need their stated obligations;
this is not a promise to prove arbitrary external code safe.

## Six implementation examples

These boundary contracts and regression cases were verified in #215. A6 adds
[count-free parser storage](parser-workspace.md) inside the compiler without a
new public API; its full platform acceptance is pending.

| Case | Accepted shape to implement or preserve | Required rejection or cleanup check |
|---|---|---|
| Callback queued on its own channel | Callback holds an explicit weak link; a live acquisition permits the operation | Reject storing an acquired owner where it recreates the cycle; expired access reports absence; reused addresses cannot revive it |
| Persistent subscription | Independent owner controls callback registration and active calls | Stop/unregister prevents new calls and waits for active calls to finish or unwind; test reentry, failure and cancellation |
| Graph deletion and slot reuse | Graph owns nodes; non-owning handles identify nodes | Deleted handles report absence even after slot reuse; internal edges do not retain the graph |
| C-retained callback | Explicit registration owns context until release and completion of active calls | Specify thread/reentry rules and managed-result release; C violating a scoped contract remains outside the compiler proof |
| Returned partial application | Captures move into or share the returned function's storage | Function survives its creating call; captures release once on every exit; a proved local callback remains borrowable |
| Recursive parser/autodiff workspace | One bounded scope owns workspace; results own their storage or retain a proved live owner | Reject expired internal references; failure/nesting/cancellation release workspace; growing outputs still require growing memory |

The first weak queue contract is specified in [weak channels](weak-channels.md).
A separate [graph fixture](../tests/fixtures/graph_generations.fwp) specifies
node identity without weak pointers. A key contains a slot number and generation,
and is interpreted against an explicit graph snapshot. The generation is a
counter that changes each time the slot is deleted. Each slot stores its
generation and an optional node. Deletion replaces the node with `None` and
increments the generation using checked arithmetic; reuse keeps that new
generation. An exhausted generation traps rather than wrapping. The fixture
reuses one bounded slot 64 times, checks stale keys and keeps an old snapshot
alive as a control. Its expected output is checked independently. Tombstone
metadata remains in the slot, but deleted payloads and edges do not. An older
immutable graph snapshot intentionally still owns its older node.

The subscription contract remains [lesson 24](tutorials/24-subscriptions/README.md):
finish drains; stop cancels and awaits; both wait for active work. The existing
failure, reentry and cancellation tests remain required. Returned partial
applications likewise keep their captures; weak observation must not shorten
that lifetime. The parser/AD row preserves scoped guarantees; the
[parser workspace](parser-workspace.md) verifies the bounded count-free region
added after GC removal. General region inference remains outside that proof.

**Retained C callbacks use an explicit registration protocol.**
[Selected C exports](retained-callbacks.md) can register copied leading arguments
and invoke the final argument later. One host owner controls registration;
active calls borrow its captures. Close prevents entry; release consumes that
owner; destruction waits for active calls to return or unwind. Neither blocks
inside reentry. Host delivery must stop before release, and all calls/results/
registrations must finish before unload. Calls use the OS thread of first entry.
The compiler cannot infer arbitrary C retention or raw-pointee lifetimes.

Managed results retain their existing independent release functions. The native
fixture covers repeated calls, nested release, language failure, cancellation,
partial construction and results surviving registration release; #215 passed
the full production matrix. Arbitrary
runtime-created functions still cannot cross C as values; function fields in
`repr(C)` records remain rejected. Ordinary scoped callbacks retain their scope.

The [admission matrix](ownership-admission.md) maps these contracts to execution
and rejection tests. Preserve those verified contracts as representations change.
A6 changes parser node storage within one proved invocation lifetime; it does not
introduce general region inference or alter the completed collector removal.

## Keep compiler cost bounded and visible

Today [arc_scope.rs](../src/arc_scope.rs) repeatedly visits all known function
contexts until its facts stop changing. It merges channel contents by type and
some aggregate contents without field distinctions. This can reject independent
owners with the same type. [arc.rs](../src/arc.rs) also rejects potential channel
cycles structurally. These are current tradeoffs, not requirements to retain.

Use finite function summaries: which inputs a result/capture may retain, which
inputs are borrowed or consumed, and which scopes they depend on. Process only
summaries affected by a changed dependency. Process mutually recursive functions
together; cache type properties. Add allocation-site or field distinctions only
where a named example needs them. Avoid enumerating arbitrary execution paths
or specializing on every concrete call chain.

Measure the ownership pass separately from specialization, C generation and the
C compiler. Record time, peak memory, analyzed IR size, summary updates and
specialized function count for N, 2N and 4N versions of independent queues,
nested captures, recursive calls and pipelines. Compare the same source before
and after a change. Termination of a finite analysis is not proof of linear cost.
Select numeric compile-time budgets from that baseline before widening analysis.
The [first analysis baseline](measurements/ownership-analysis.md) measures the
creation-site repair against the earlier merging rule and sets count/time
ceilings. It covers one combined fixture; its process-memory peak does not isolate
the proof heap, and three sizes do not establish an asymptotic bound.

## Finite route to deleting tracing

G3/G4 delivered the six contracts, weak channels, C registrations and replacement
ownership diagnostics. G5 completed the following groups in
[#217](roadmap-history.md#tracing-gc-removal-pr-217). This records the removal
requirements; it is not a second backlog:

1. **Unify admission and move ordinary memory tests to ARC.** Apply queue and
   State/autodiff lifetime rules before interpreter entry effects, including
   REPL/notebook and compile-time execution. Keep supported-program output tests
   separate from deliberate rejection/runtime-defense fixtures. Compare reuse
   against copying with reference counts enabled in both variants; retain the
   existing allocation and process-memory limits.
2. **Remove the collector.** Follow the [deletion table](ownership-diagnostics.md#collector-specific-tests-and-retained-assertions):
   remove tracing selection, root discovery, marking/sweeping and collector-only
   tests. Preserve allocation, resource cleanup and their observations. Update
   reports and workflow settings together. There is no compatibility collector.
3. **Verify the integrated result.** Check deliberate cleanup faults and repeated
   work, then inspect actual binaries for collector removal. Use focused checks
   during implementation and the complete nine-job matrix plus documentation
   after the batch is ready. Full builds and suites run on GitHub. Audit every
   failure before publishing a repair.

ARC minimization remains separate from the completed collector deletion.
PLAN A5 verified a [restricted local-array path](measurements/unique-array-storage.md)
with one proved owner, no count slot and direct cleanup on normal and exceptional
exits. All final production, documentation and analysis gates passed in #219.
The next batch combines [redundant sort owners](measurements/sort-key-ownership.md)
and [contiguous key storage](measurements/inline-sort-keys.md). Their reports
distinguish count savings from actual storage,
code size, stack use and execution speed.

## Performance comparisons to run

Goose's [benchmark design](https://aardappel.github.io/goose/bench/design.html)
separates idiomatic from optimized representations and includes teardown.
Its [results](https://aardappel.github.io/goose/bench/results.html) also show
backend-dependent outcomes. Neither supplies an fwp overhead measurement.
The [reference](https://aardappel.github.io/goose/docs/reference.html) specifies
release-build signed wrapping versus debug overflow checks, unlike fwp's checked
arithmetic contract. Compare equivalent arithmetic, not just equal happy-path
checksums.

For fwp, pair four workloads with C and Rust: a unique numeric buffer, a returned
closure, a subscription with weak back-links, and a graph/autodiff arena. Use
equivalent ownership/lifetime behavior and report any required representation
changes. Include construction, steady-state work and destruction separately and
together. Record heap requests, retain/release/weak acquisitions, peak live bytes,
committed and reserved memory, elapsed time, compiler/flags/host and compile time.
Measure small, cache-sized and larger working sets. Report
`(fwp_time / baseline_time - 1) * 100` as extra time, with repeated-run variation;
do not import Lobster's count percentage or Goose's aggregate speed ratios as
targets or promises.
