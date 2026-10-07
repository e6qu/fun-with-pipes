# Session handoff

Updated: 2026-10-08. Read [PLAN.md](../PLAN.md), [ownership.md](ownership.md)
and [design.md](design.md). Prepared branches are not merged behavior.

## Authorized workflow

Complete the active roadmap automatically, one focused PR at a time. Failing
tests are work to fix, never a roadmap blocker. Queued CI gates merging only;
continue diagnosis, fixes and separate next-task preparation. Full builds,
full tests, benchmarks and large evidence generation run on GitHub runners.
Squash only after all current-head gates pass, with an explicit one-line
subject of at most 80 characters and an empty body. No trailers, AI attribution,
Co-authored-by or Authored-by lines. This authorization persists across sessions.
Keep simple data-last pipes, strong typing/inference, explicit generic signatures,
immutable value semantics, effects and evaluation/trap order stable.

## Merged baseline and current work

- Earlier container baseline: `5998302`, squash merge of [PR #75](https://github.com/e6qu/fun-with-pipes/pull/75).
  Current head `f53493c` passed all four jobs in
  [run 37612412156](https://github.com/e6qu/fun-with-pipes/actions/runs/37612412156):
  Linux, ARM/Intel macOS and benchmarks. Intel completed 2026-10-07T12:38:44Z.
  Verified squash subject: `Unify container ownership contracts and borrow comparison keys`,
  one line, 62 characters, no body or trailers. Concurrent native executable
  cache access is read-only; ARM's tutorial/pipeline regression is fixed.
- Earlier native macOS baseline [PR #74](https://github.com/e6qu/fun-with-pipes/pull/74)
  merged as `af15d26`, passing all four jobs in run `37591744197`.
- Earlier leaf baseline: `22994ba794a37320aca6e5122ed1ef909a0f4148`, squash merge of
  [PR #76](https://github.com/e6qu/fun-with-pipes/pull/76). Exact head
  `2d2af62630acf9e2c25d93e6ba2209d9e126a745` passed all four jobs in
  [CI 37623311024](https://github.com/e6qu/fun-with-pipes/actions/runs/37623311024).
  Verified squash subject: `Count owned String and Bytes results with explicit alias contracts`,
  one line, 66 characters, empty body, no trailers. Local main fast-forwarded
  while preserving its current plan/handoff edits.
- Earlier closure baseline: `079e7b58cfc2fa3a3053a1ef674a561af560fa1c`, squash
  merge of [PR #78](https://github.com/e6qu/fun-with-pipes/pull/78). Exact head
  `a8e0079a87e5e4026327f431282cc37f0aebd637` passed all four gates in
  [CI 37656822169](https://github.com/e6qu/fun-with-pipes/actions/runs/37656822169):
  Linux, Apple Silicon/Intel macOS and benchmarks. Merged 2026-10-07T18:18:02Z.
  Verified subject `Own compiled dynamic closures and release typed captures`,
  one line, empty body, no trailers. Local main fast-forwarded while preserving
  its two handoff docs; backup `/private/tmp/fwp-main-docs-079e7b5`.
- Previous text baseline: PR #77 merged as `6cdb0d1`, all four exact-head gates
  passed in CI `37636161587` attempt 2. Attempt 1 Linux had no runner; the retry
  executed actual tests successfully.
- Current origin/main: `33d4fb1a33ad4aad6b584b2f25c90d0f4dbbc18c`, squash
  merge of [PR #79](https://github.com/e6qu/fun-with-pipes/pull/79), merged
  2026-10-07T20:40:20Z. All four exact-head gates passed in CI `37666199241`
  for `e3fb2f6d84be7c24f0009121f1183ec8ba1e5fc3`. Verified one-line subject
  `Bound closure capture cleanup with an explicit release work list`, empty body,
  no trailers. Local main fast-forwarded; docs backup
  `/private/tmp/fwp-main-docs-33d4fb1` preserved the active plan/handoff.
  Next PR: concrete ownership temporary types. Rebase from OLD `7cf5c78`
  onto this baseline, preserving OLD `0acbc06` for the stack-arguments child.
  Rebase completed; only plan/handoff conflicts were reconciled with current docs.
  The rebased temporary types (2) and closure cleanup (1) pass under the guard:
  CPU 10.31 s / elapsed 20.83 s; typed children free 0.5 MiB versus 0.0 MiB
  in the control. Package clean preceded validation. Formatting/whitespace pass.
  Published with exact lease as `7ce23dd0acb354859948db9043ffd91e3029a55c`;
  clean checkout. Sole open [PR #80](https://github.com/e6qu/fun-with-pipes/pull/80),
  full CI `37684140373`, initially queued, exact head above. All four gates are
  required before squash with subject `Preserve concrete call argument types for
  ownership temporaries` (63 characters, supplied as one line), empty body and
  exact head match. The stack-argument child later rebases from OLD `0acbc06`.
- Published runtime unwind change: `ownership-unwind-runtime`, checkout
  `/private/tmp/fwp-unwind-runtime-worktree`, OLD base `02beec3`. Runtime cleanup
  chains are task-local, error handlers and recovered traps retain a boundary,
  and cancellation releases registered owners before longjmp. file.with now
  closes on cancellation/traps, including a failure before handle allocation.
  Three focused checks pass; published as
  `3e314222ff7c0f379204a539858d73bfe1bda095`. No additional PR is open.
  Prepared compiler reuse/call scopes and runtime/map/selection/zip scopes
  are listed below. Continue with fold/loop accumulators and retained task lifetimes.
  Preserve listed OLD rebase anchors through the sequential squash workflow.

- Latest published preparation: `ownership-reuse-tokens`, checkout
  `/private/tmp/fwp-unwind-liveness-worktree`, OLD base `3e31422`.
  Compiler-held emptied cells now release on unused branches and when old cells
  cannot be reused; dead fields are cleared before collection. Unwind registers
  the temporary owner; constructor transfer clears its slot; tail calls unlink
  owners before entering the callee. Initial token (2), old-reclamation (3) and
  runtime-unwind (3) checks pass, serial guarded CPU 20.01 s / elapsed 40.17 s.
  All three token checks pass, including bump-allocator compatibility,
  guarded CPU 15.31 s / elapsed 30.88 s. Eight IR checks, fmt and whitespace pass.
  Published head `33cf86466e2f106dcce2b3bc88cd3f10df9fa620`; no additional PR.
  Committed checkout `/private/tmp/fwp-call-liveness-worktree`, branch
  `ownership-call-liveness`, OLD base `33cf864`, head
  `7392f2d67151ad69fa18aed33dc30271067d81db`.
  Published successfully after three GitHub internal-server rejections; the
  HTTP/1.1 retry succeeded. No additional PR was opened.
  It derives call ownership from the RC checker, names pending computed arguments,
  and registers live callers, incoming tick parameters and original boxed wrapper
  arguments. Struct variants stay unboxed through ownership moves. Caller alias,
  pending-argument, wrapper and cancellation checks pass; variant error cleanup
  also passes. All five compiler checks and both existing stack checks pass,
  guarded CPU 21.11 s / elapsed 42.31 s. The stack-closure regression exposed
  by argument naming was fixed by hoisting capture evaluation before storage
  selection; child reclamation remains measured. Caller scopes also protect
  stack-argument children that normal returns release in the owning frame.
  Eleven IR checks and seven array/list checks pass; fmt/whitespace pass.
  Library clippy passes without warnings after the final repairs, guarded
  CPU 2.23 s / elapsed 4.38 s. All five compiler and two stack tests pass again,
  guarded CPU 21.11 s / elapsed 42.31 s. Full CI remains for the future PR.
  Full gates remain
  required when its sequential PR opens. Phase 2 remains incomplete.
- Current runtime implementation: `/private/tmp/fwp-runtime-call-worktree`,
  `ownership-runtime-call-cleanup`, OLD base `7392f2d`, published as
  `bee3f1659ae5e09be04052126f0e0b637fa9049d`. No additional PR is open.
  Protects consumed functions during dynamic application, typed pending arguments
  along the complete arrow spine, and primitive/FFI borrowed arguments normally
  dropped after return. Dynamic stack applications also protect their original
  captures; a generated-code trap probe found and repaired that missing owner.
  Pure programs compile out runtime registration via FWP_UNWIND.
  Four dedicated probes passed at O1/O2 with stress/verification and both poison
  modes: captured functions/aliases, overapplication/scalar bits, primitive traps,
  and cancellation before entry. Ten adjacent compiler/token/stack tests pass,
  guarded CPU 23.75 s / elapsed 47.88 s. Added a bounded 10,000-failure counter
  comparison: tracing off, zero collections, 0.3 MiB freed versus 0.0 MiB with
  only consumed-function unwind release removed. Its initial 0.4 MiB threshold
  exceeded actual measured storage; corrected to exceed counter precision.
  All five dedicated tests pass, guarded CPU 7.81 s / elapsed 15.72 s. Eleven IR
  checks pass (CPU 3.26 s / elapsed 6.77 s); library clippy is warning-free
  (CPU 2.30 s / elapsed 4.59 s). Fmt/whitespace pass. Full CI remains for the
  sequential future PR. Native wide-count metadata compatibility passes
  (CPU 0.59 s / elapsed 2.30 s).
  Next cover callback accumulators, retained tasks, allocation/boxing failures,
  CAF ownership and inline rewrites. Phase 2 and collector-free support remain
  incomplete.
- Current map cleanup: `/private/tmp/fwp-map-unwind-worktree`, branch
  `ownership-map-unwind`, OLD base `bee3f16`, published as
  `62add7e4a85f7648e8877b33eb67f9a70a6b3a09`; checkout clean.
  Typed scopes own only the completed result prefix; scratch suffix words borrow
  source elements. List construction transfers each prefix element into a typed
  partial spine. Errors, recovered traps and cancellation release prefix, built
  nodes and scratch exactly once. Dynamic, direct and captured callback paths use
  the same scope; pure programs omit registration.
  Normal map alias/counter tests pass (CPU 10.64 s / elapsed 21.67 s). The initial
  callback/trap/cancellation probe passes at O1/O2 with stress/verification and
  both poison modes (CPU 3.34 s / elapsed 6.92 s). Its cancellation hook first
  referenced task declarations before their runtime include; moved the test hook
  definition after that include and reran successfully. Final two dedicated
  checks pass (CPU 4.66 s / elapsed 9.57 s), including scalar address bits.
  Library clippy passes without warnings (CPU 2.24 s / elapsed 4.50 s);
  formatting and whitespace pass. Five adjacent runtime call checks pass
  (CPU 7.93 s / elapsed 16.13 s). Full gates remain
  for the future sequential PR. Next: typed filter/take-while/zip prefixes and
  scratch, fold/loop accumulators, retained tasks and the remaining allocator/
  boxing, CAF and inline-rewrite ownership gaps. Phase 2 remains incomplete.
- Current selection cleanup: `/private/tmp/fwp-selection-unwind-worktree`,
  branch `ownership-selection-unwind`, OLD base `62add7e`, published as
  `b8f4c2469215dbff241478a89fb5596ac0facec6`; checkout clean.
  Filter/take-while scopes own the selected element aliases independently of
  source elements, then transfer them into typed partial result spines.
  Dynamic, direct and captured predicates protect selected prefixes and scratch
  on errors, construction traps and cancellation. Scalar words stay uncounted.
  Four normal filter/prefix regressions pass (CPU 15.20 s / elapsed 30.72 s).
  Two dedicated generated-code probes pass at O1/O2 with stress/verification
  and both poison modes (CPU 4.85 s / elapsed 9.86 s): all six predicate paths,
  retained input aliases, partial construction, cancellation and scalar bits.
  Initial harness failures were fixed: selection updates a prefix count rather
  than map's increment, so the cancellation injection needed that real update;
  a scalar fixture also needed its generated typed duplication symbol.
  Library clippy is warning-free (CPU 2.20 s / elapsed 4.35 s). The final
  format check required formatting the repaired test hook; applied the fix.
  Final fmt and whitespace pass. Both adjacent map unwind checks pass
  (CPU 4.52 s / elapsed 9.28 s). Full gates remain for the future sequential PR. Next: zip-with's two scratch
  buffers and result prefix, fold/right-fold/loop accumulators, retained tasks,
  allocator/boxing failures, CAF owners and inline-rewrite coverage.
- Current zip-with cleanup: `/private/tmp/fwp-zip-unwind-worktree`, branch
  `ownership-zip-unwind`, OLD base `b8f4c24`, published as
  `c2a364544d927c6abc649ec2d11c925f7b9401f5`; checkout clean.
  Protect the first scratch/result-prefix owner before allocating the second
  buffer. Protect the second buffer across callbacks, then release it before
  result-spine construction. Dynamic/direct/captured callbacks protect completed
  results and typed partial spines on errors, traps and cancellation; scalar
  result bits remain uncounted. This change covers zip-with, not every zip/unzip
  or other runtime allocation failure.
  Both normal zip alias/counter tests pass (CPU 10.88 s / elapsed 22.12 s).
  Two dedicated probes pass (CPU 5.57 s / elapsed 11.26 s) at O1/O2 with
  stress/verification and both poison modes, including second-scratch allocation
  failure, completed results, partial nodes, cancellation and scalar address bits.
  Library clippy is warning-free (CPU 2.26 s / elapsed 4.51 s); final fmt and
  whitespace pass. Four adjacent map/selection unwind checks pass
  (CPU 9.58 s / elapsed 19.23 s).
  Full gates remain for the future sequential PR. Next: fold/right-fold/loop
  accumulators and scratch, retained tasks and allocator/boxing/CAF/inline owners.
- Shared local Cargo target caveat: switching worktrees can reuse a CLI built
  from newer-mtime sources in another checkout. Before compiling after a switch,
  serial guarded `cargo clean -p fwp` forces the correct package rebuild without
  clearing dependencies. This happened during closure/runtime alternation and
  was corrected before dedicated runtime probes and the ten adjacent checks.
  Never accept stale emitted C as evidence. A mistyped test target
  `stack_closure_ownership` was rejected without running tests; the corrected
  `stack_ownership` target passed.

## Immediate continuation

Keep goal active; phases 2–6 remain incomplete. PR #79 merged as `33d4fb1`
with all four exact-head gates passing. [PR #80](https://github.com/e6qu/fun-with-pipes/pull/80)
is the sole open PR, exact head `7ce23dd0acb354859948db9043ffd91e3029a55c`,
full CI `37684140373`: benchmark and ARM macOS passed; Linux and Intel macOS are running. Queues gate merging
only. When all four gates pass, squash with subject `Preserve concrete call
argument types for ownership temporaries` (one line, 63 chars) and empty body,
verify its message, and fast-forward main preserving these two docs. Rebase
stack arguments from OLD `0acbc06` onto that new main, reconcile latest docs,
run guarded focused checks, publish with exact lease and open the sole next PR.
Do not use a rewritten or squash parent as a child's OLD rebase anchor.

Current checked preparation: `ownership-variant-conversion`, checkout
`/private/tmp/fwp-variant-conversion-worktree`, OLD base `b021967`, pending publication.
Conversion now protects the consumed boxed value (or owned stack children) during
field retention and separately protects all remaining caller owners. The RC
checker records consumed-value checkpoints before/after transfer; the caller
scope excludes the consumed reference owned by the new conversion scope.
A real source path uses a whole-value show/echo operation before matching; its
emitted boxed-to-struct conversion is asserted. Actual first/later count overflow
checks cover independent boxed and remaining-String aliases, scalar address bits
and exact counts. Removing the original scope returns code 3; removing remaining
caller scope returns code 7. O1/O2, GC stress/verification, both poison modes and
normal interpreter/native behavior pass. The C probe initially crashed because
it did not initialize the runtime print stream; it then incorrectly assumed a
wide side entry remained after cleanup downgraded 255 to 254. Those probe issues
are fixed. Nine integration tests pass (CPU 23.78 s / elapsed 47.71 s), sixteen
RC units pass (CPU 3.35 s / elapsed 7.02 s), library lint passes (CPU 2.32 s /
elapsed 4.58 s); fmt/whitespace pass. No local workload remains. Shared target
contains this compiler; guarded package clean before switching checkouts.
Next publish separately, then audit vlocal boxing/aliases, nested reconstruction,
SetFields fallback, untyped field/scrutinee contexts, CAF/inline owners and
retained tasks/cycles. Full sequential CI still gates each merge; phases 2–6
remain active.

Latest published code: `ownership-constructor-types`, checkout
`/private/tmp/fwp-constructor-types-worktree`, OLD base `1bb11be`, head
`b0219671dca3fee5c44a8725f29d18310d2622bb`; clean checkout. Verified subject
`Keep typed constructor temporaries owned through field preparation`: one line,
66 characters, empty body/no trailers. It propagates
monomorphic function results, bindings, branches, aggregate fields, dynamic
parameters and update fields into ownership temporaries. A new liveness unit
found a later computed scalar still evaluated after an earlier counted argument
was marked consumed. Computed consumed arguments are now named before the final
operation, keeping prior owners visible while scalar preparation can unwind.
Fifteen RC units pass (CPU 3.25 s / elapsed 6.81 s). Seven constructor/boxing/
temporary/retain/loop preparation checks pass after that fix (CPU 25.35 s /
elapsed 50.78 s). The actual later-field error probe has independent record and
variant controls; outer-only cleanup leaks a String child (code 4). O1/O2,
GC stress/verification, both poison modes, aliases and scalar bits pass. Both
successful and handled-error native outputs match the interpreter. Those checks used the constructor-types compiler; current target is recorded above. Five call-liveness checks pass: CPU 11.17 s / elapsed 22.50 s. The loop trap/order
golden passes: CPU 4.13 s / elapsed 8.54 s. Library clippy passes: CPU 2.45 s /
elapsed 4.91 s; fmt/whitespace pass. No local workload remains. This separate preparation is published; all prepared PRs still need full
sequential CI. Next audit boxed-to-unboxed conversion ownership at retention
failures, including the consumed boxed value and all remaining caller owners. Then audit boxed-to-unboxed conversion,
vlocal boxing, nested field reconstruction, SetFields fallback, CAF/inline and
retained task lifetime/cycles. Full sequential CI remains required.

The preparation notes below are historical evidence at their recorded heads.
Their old PR statuses, target contents and next actions are not the active queue;
use this section, the merged baseline and the immutable-anchor table.

Fold/right-fold cleanup is published on `ownership-fold-unwind`, checkout
`/private/tmp/fwp-fold-unwind-worktree`, OLD base `c2a3645`, head
`968dac7ed9cfa98ce964d889a6b54e907d9e148b`; checkout clean.
Normal fold/right-fold tests pass (CPU 14.48 s / elapsed 29.37 s). An initial Rust
borrow error was corrected by cloning the callback-ID list before adding typed
drop helpers. Captured callback probes were corrected to use the optimizer’s
actual `fold-right-fn` specialization and a dynamic capture. The right-fold
error/allocation/cancellation/preparation probe passes (CPU 4.21 s / elapsed
8.49 s). Borrowed-function duplication protection now starts before retaining
the borrowed function and keeps consumed overapplication suffixes owned during
an earlier entry. Each successful borrowed duplicate is now protected while
later duplicates are prepared. Final two dedicated probes pass (CPU 5.27 s /
elapsed 10.64 s), covering direct/dynamic/captured right-fold errors, scratch
allocation traps, cancellation, consumed and partial borrowed preparation, retained
function/input aliases and scalar address bits. The scalar/duplicate fixture’s
injection first targeted the unused prefix loop; corrected to the actual suffix
loop. Library lint is warning-free (CPU 2.23 s / elapsed 4.39 s). Final nine
normal fold/right-fold/runtime checks pass (CPU 15.50 s / elapsed 31.22 s).
A borrowed-span overapplication probe was added to verify the pending suffix
and surviving function alias across prefix failure and successful return.
The added overapplication probe passes (CPU 2.51 s / elapsed 5.10 s).
Final fmt and whitespace pass. The fold branch is published; full
sequential CI remains required.

Loop cancellation cleanup is published on `ownership-loop-unwind`, checkout
`/private/tmp/fwp-loop-unwind-worktree`, OLD base `968dac7`, head
`988f2a3be97f482d78cbfc5f871e58b0f118a284`; clean, no new PR.
Dynamic, known and captured loops protect the current consumed state at each
outer tick and transfer it before owned callback entry. Specialized outer loops
save only counted typed slots, clear them before fs entry and refresh from the
next state before the next tick. Step payload extraction protects the owned Step
while preparing its typed payload duplicate. Stop results never enter a state
scope of a different type.

All five existing loop checks pass (CPU 21.60 s / elapsed 43.61 s), covering
reclamation, aliases, scalar address bits, fused consumers and trap/evaluation
order. Two dedicated checks pass (CPU 3.93 s / elapsed 8.00 s): cancellation at
first and second ticks on direct/generic/dynamic/captured/nested paths and Step
payload-preparation traps for Again/Stop with surviving aliases. They compile
actual generated C at O1/O2 with GC stress/verification and both poison modes;
normal native output matches the interpreter. Test-source typing and optimized-
away wrapper assumptions were corrected before accepting this evidence. The
nested fixture holds a typed boxed nested record; it does not prove flattened
nested-slot cancellation coverage. Adjacent call-liveness/fold checks (7) pass, CPU 15.84 s / elapsed 31.89 s.

Library clippy is warning-free (CPU 2.28 s / elapsed 4.52 s); fmt and whitespace
pass. Verified subject `Protect current loop state and Step payloads across cancellation`
is one line, 64 characters, empty body/no trailers. No local workload remains.
Argument/capture preparation is published on `ownership-argument-preparation`,
checkout `/private/tmp/fwp-argument-preparation-worktree`, OLD base `988f2a3`,
head `49739182ecb6ef8fdf98b526fdb427bb672d7f97`; clean, no new PR.
Generated multi-counted argument helpers protect successful duplicates until the
whole span transfers. Capture duplication reuses that typed helper when unwind
is possible. Full owned application transfers its pending prefix only after
capture preparation; uncounted stack functions still protect owned arguments.
Partial application protects a freshly counted outer cell while copied children
remain borrowed, releasing only that cell if capture preparation fails.

The dedicated O1/O2 stress/verification/poison probe passes (CPU 2.62 s / elapsed
5.43 s), extended final CPU 2.94 s / elapsed 6.08 s:
whole-span/offset-span failures after an earlier duplicate, heap/stack
function capture failures, pending typed record arguments containing scalar
address bits, partial closure-cell reclamation, partial allocation failure before a cell exists
and exact surviving aliases.
Removing only the generated helper scope makes the same probe fail with the
expected leaked-reference code. Normal output matches the interpreter. The
fixture was corrected to existing curry3 syntax and exact typed allocation
markers. Its initial failure exposed the uncounted temporary closure cell,
which is now fixed. Earlier runtime/fold checks (7) pass, CPU 19.15 s / elapsed
38.47 s. Final nine runtime/fold/loop checks pass, CPU 23.55 s / elapsed 47.29 s;
Final helper context uses a compact argument pointer, typed release callback and
span indices, without a temporary function-info table. The dedicated probe plus
five runtime checks pass after that change, CPU 17.28 s / elapsed 34.73 s.
Library clippy is warning-free (CPU 2.25 s / elapsed 4.51 s); final fmt and
whitespace pass. No local workload remains. Verified subject
`Release partial argument and capture preparation on unwind` is one line,
58 characters, empty body/no trailers. Published separately; full sequential
CI remains required. Final focused command:
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3 /private/tmp/fwp-local-guard.py cargo test --test argument_preparation_ownership --test runtime_call_ownership -- --nocapture`.
Lint and fmt used the same bounded guard with `cargo clippy --lib -- -D warnings`
and `cargo fmt --all -- --check`. The guard accepted all checks within limits.
Next start a
separate constructor/boxing checkout from this published head: FnGen::alloc,
Body::Ctor, Gen::worker pre-call field duplication and result boxing need typed
owners before allocations/preparation. Initial loop state flattening also needs
partial-duplicate cleanup before dropping the input record. Check these actual
emitted paths with allocation/preparation failure, surviving aliases and scalar
bits, then CAF/inline-rewrite owners and retained task lifetimes.
Phase 2 remains incomplete; phases 3–6 follow its acceptance. Failing checks are
repair tasks, never a reason to stop. At argument-preparation validation, the shared target contained that compiler; guarded `cargo clean -p fwp` is required before another
worktree's package build. Root main has only PLAN/handoff edits; all published
prepared checkouts are clean. PR #79 exact-head CI: Both macOS gates/bench passed; Linux running.

Constructor allocation cleanup is published on `ownership-constructor-unwind`,
checkout `/private/tmp/fwp-constructor-unwind-worktree`, OLD base `4973918`, head
`608ae7bb2d2420f78a113a11299669a9f4821f37`; clean, no new PR. The ownership checker records non-nullary constructors too. Before
allocating a record/variant, generated code protects remaining caller owners and
consumed typed field values separately. Constructor functions protect their
owned arguments. Successful allocations transfer those fields; young reuse
stays on its existing allocation-free path. Scalars, constants and static
functions have no pending field scope entry.

Twelve ownership-checker checks pass, including transferred fields versus other
caller owners (CPU 9.87 s / elapsed 20.24 s). The initial combined command filtered
out the integration probe; that zero-test result was not accepted as evidence.
The unfiltered probe plus five call-liveness checks pass, CPU 14.50 s / elapsed
29.13 s. Actual generated C at O1/O2 under GC stress/verification and both poison
modes covers constructor functions, recursive variants, wide records, a still-
live caller alias, fresh field results, retained aliases and address-shaped
scalar bits. Removing only the constructor-function scope makes the same probe
fail with the expected field-leak code. Normal output matches the interpreter.
Test-source declaration syntax and the injected C forward declaration were
corrected before validation. All three reuse-token checks pass (CPU 9.29 s / elapsed 18.63 s), including
ownership switches and bump-allocator compilation. Library clippy is warning-free
(CPU 2.52 s / elapsed 5.03 s); fmt and whitespace pass. No local workload remains.
Final probe/call command: `env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3 /private/tmp/fwp-local-guard.py cargo test --test constructor_unwind_ownership --test compiler_call_liveness -- --nocapture`.
Reuse-token tests, `cargo clippy --lib -- -D warnings` and fmt used the same guard.
Verified subject `Protect consumed constructor fields before allocating their storage`
is one line, 67 characters, empty body/no trailers. Next protect worker field
preparation and record/variant result boxing, followed by initial loop flattening,
CAF/inline-rewrite lifetimes and retained runtime tasks. Concrete constructor
argument temporaries with unknown field types still need typed context coverage;
do not treat a fallback outer count as full child reclamation. The shared target contained the constructor compiler during those checks. The main root retains only its plan/
handoff edits; published prepared checkouts are clean. Full sequential CI remains
required for every prepared branch, and phases 2–6 remain incomplete.

Worker result boxing is published on `ownership-worker-boxing`, checkout
`/private/tmp/fwp-worker-boxing-worktree`, OLD base `608ae7b`, head
`dc4f9461571be7294f6ea0babc99c92847fbc5be`; clean, no new PR.
Record result wrappers now own returned typed fields across box allocation.
Variant boxing protects only the active constructor's counted payloads; scalar
and nullary variants have no payload owner. Direct worker calls re-register
remaining caller owners during result boxing, independently of returned fields.
Variant release declarations now precede cleanup context definitions so those
contexts and boxing helpers can refer to each other without undeclared C types.

The initial dedicated O1/O2 stress/verification/poison probe passes (CPU 10.35 s /
elapsed 20.88 s), covering record and variant wrappers, another live caller
reference across direct recursive worker-result boxing, surviving aliases,
scalar payload bits and nullary variants. Normal native output matches the
interpreter. The fixture's missing rec declaration was corrected, and the first
C compilation exposed the definition-order bug, now fixed. An expanded probe
restores only the missing record result scope and must detect leaked returned
fields. The final seven-test boxing/call/constructor batch passes, CPU 18.90 s /
elapsed 37.93 s. Library clippy is warning-free (CPU 2.58 s / elapsed 5.10 s);
fmt and whitespace pass. No local workload remains.
Final test command used the guard with
`cargo test --test worker_boxing_ownership --test compiler_call_liveness --test constructor_unwind_ownership -- --nocapture`; lint/fmt used the same bounded guard.
Verified subject `Protect owned worker results until record and variant boxing succeeds`
is one line, 69 characters, empty body/no trailers. Next move wrapper incoming-owner registration
before field duplication and protect completed field duplicates until worker
entry. Initial loop flattening, vlocal variant duplication/boxing, unknown
typed constructor temporaries, CAF/inline lifetime and retained tasks remain.
The shared target contained the boxing compiler during those checks. Full sequential CI still
gates each prepared branch; no additional PR is open.

Worker argument preparation is published on `ownership-worker-preparation`,
checkout `/private/tmp/fwp-worker-preparation-worktree`, OLD base `dc4f946`, head
`c97dd03f8d89d685be885f77cc611bb16cb0fb72`; clean, no new PR. Wrappers with boxed parameters now protect all consumed incoming
arguments before field duplication. Each completed counted-field duplicate has
its own typed, initially zero slot. These prepared field references transfer
at worker entry; non-boxed arguments leave the original-owner scope then, while
boxed originals remain owned until normal wrapper return or unwind. Scalar
fields have no duplicate/cleanup slot. Programs without unwind retain grouped
operations; wrappers without boxed parameters gain no input-preparation scope.

All five existing call-liveness checks pass (CPU 18.55 s / elapsed 37.34 s).
The dedicated probe passes at O1/O2 with stress/verification and both poison
modes (CPU 2.62 s / elapsed 5.42 s): first/later duplication failure, worker-entry
cancellation and normal return, with independent box/leaf aliases and scalar
address bits. The expanded control removes only the partial preparation scope
and detects the expected earlier-duplicate leak. It and result boxing pass
(CPU 7.10 s / elapsed 14.23 s); normal native output matches the interpreter.
Library clippy is warning-free (CPU 2.78 s / elapsed 5.57 s); fmt and whitespace
pass. No local workload remains. Those checks used the worker-preparation compiler. Current shared target contains
the loop-preparation compiler; guarded `cargo clean -p fwp` is required before
another checkout's package build. Verified subject `Protect boxed arguments and partial fields before worker entry`
is one line, 62 characters, empty body/no trailers. Next protect initial
loop state flattening and partial field extraction before worker entry, followed
by vlocal variant duplication/boxing, typed constructor temporaries, CAF/inline
lifetimes and retained tasks. Full sequential CI remains required.

## Current ownership evidence

One inventory invariant, eight IR ownership checks and three container
regressions passed before rebase. Tests cover interpreter/native agreement,
retained aliases and callbacks with GC stress/verification and reuse poisoning.
The comparison-key loop allocates 0.0 MiB versus 0.8 MiB with only the old sharing
boundary restored (Apple Silicon, Apple Clang 17, O1, 0.1 MiB counter precision).
This is allocation evidence, not a speed or register-placement claim. The runtime
regression exercises count saturation, interior references and 70-branch traversal
spill; restoring the previous saturation transition corrupts a visible alias.
Post-rebase checks passed: inventory (1), IR ownership (8), container tests (3),
formatting and whitespace. The container run used CPU 9.63 s / elapsed 19.46 s
under the guard. Full current-head CI remains required.

## Prepared sequence

All tabled branches are published and have focused local evidence. The
first is the sole open PR; later branches have no PR yet. Open each only after its parent PR merges. Fetch main, rebase from the
listed OLD base onto main, reconcile docs with the latest handoff, validate,
push with lease and run full CI. Do not replay the parent's pre-squash commits.

| Branch | Checkout under /private/tmp | Head | Old base to remove |
|---|---|---|---|
| ownership-temporary-types | fwp-temporary-worktree | 7ce23dd | 7cf5c78 |
| ownership-stack-arguments | fwp-stack-worktree | b563360 | 0acbc06 |
| ownership-borrowed-callbacks | fwp-callback-worktree | 029fac4 | b563360 |
| ownership-map-callbacks | fwp-map-worktree | 41ef82d | 029fac4 |
| ownership-filter-callbacks | fwp-filter-worktree | 1ea7f07 | 41ef82d |
| ownership-fold-transfers | fwp-fold-worktree | a180c3f | 1ea7f07 |
| ownership-zip-callbacks | fwp-zip-worktree | bdb750f | a180c3f |
| ownership-right-fold | fwp-right-fold-worktree | adc7947 | bdb750f |
| ownership-list-prefix | fwp-prefix-worktree | 376e77a | adc7947 |
| ownership-list-copies | fwp-list-copy-worktree | bb00baa | 376e77a |
| ownership-list-options | fwp-list-option-worktree | 34023f3 | bb00baa |
| inference-call-effects | fwp-inference-worktree | 89b7bde | 34023f3 |
| ownership-wide-counts | fwp-wide-worktree | 3a791dc | 89b7bde |
| ownership-list-order | fwp-order-worktree | c835578 | 3a791dc |
| ownership-sort-callbacks | fwp-sort-callback-worktree | 66bc713 | c835578 |
| ownership-state-sequences | fwp-state-sequence-worktree | 0a90b05 | 66bc713 |
| ownership-loop-state | fwp-loop-worktree | 787763d | 0a90b05 |
| ownership-list-structure | fwp-structure-worktree | c05a5d9 | 787763d |
| ownership-list-generation | fwp-generation-worktree | fad9b1a | c05a5d9 |
| ownership-array-elements | fwp-array-element-worktree | 636414f | fad9b1a |
| ownership-map-set-elements | fwp-map-set-worktree | a8a7d11 | 636414f |
| ownership-old-reclamation | fwp-old-reclamation-worktree | 6774aa5 | a8a7d11 |
| ownership-task-boundaries | fwp-task-boundary-worktree | 02beec3 | 6774aa5 |
| ownership-unwind-runtime | fwp-unwind-runtime-worktree | 3e31422 | 02beec3 |
| ownership-reuse-tokens | fwp-unwind-liveness-worktree | 33cf864 | 3e31422 |
| ownership-call-liveness | fwp-call-liveness-worktree | 7392f2d | 33cf864 |
| ownership-runtime-call-cleanup | fwp-runtime-call-worktree | bee3f16 | 7392f2d |
| ownership-map-unwind | fwp-map-unwind-worktree | 62add7e | bee3f16 |
| ownership-selection-unwind | fwp-selection-unwind-worktree | b8f4c24 | 62add7e |
| ownership-zip-unwind | fwp-zip-unwind-worktree | c2a3645 | b8f4c24 |
| ownership-fold-unwind | fwp-fold-unwind-worktree | 968dac7 | c2a3645 |
| ownership-loop-unwind | fwp-loop-unwind-worktree | 988f2a3 | 968dac7 |
| ownership-argument-preparation | fwp-argument-preparation-worktree | 4973918 | 988f2a3 |
| ownership-constructor-unwind | fwp-constructor-unwind-worktree | 608ae7b | 4973918 |
| ownership-worker-boxing | fwp-worker-boxing-worktree | dc4f946 | 608ae7b |
| ownership-worker-preparation | fwp-worker-preparation-worktree | c97dd03 | dc4f946 |
| ownership-loop-preparation | fwp-loop-preparation-worktree | b879eca | c97dd03 |
| ownership-variant-preparation | fwp-variant-preparation-worktree | 1bb11be | b879eca |
| ownership-constructor-types | fwp-constructor-types-worktree | b021967 | 1bb11be |

Example after the text PR merges: from fwp-closure-worktree,
`git rebase --onto origin/main bab67ea ownership-closures` after fetching main.
Review runtime changes against the latest macOS fixes and resolve documentation
conflicts by carrying forward verified state, not by preserving stale statuses.
Temporary worktrees are conveniences; published branches preserve the work.

- Leaves: String/Bytes counted ownership, fresh/copy/alias contracts, leaf-only
  destruction/poisoning and address fences for borrowed allocating calls. Two
  alias/copy regressions pass at O1/O2 with GC stress/verification and both poison
  modes; no-tracing copy loop frees 0.9 MiB versus 0.0 with freeing disabled.
- Text: copied Option/List trees use FreshTree only when no input aliases exist.
  Conversion buffers use separately releasable memory. Three focused tests pass;
  no-tracing word loop frees 2.1 MiB, and buffer cleanup reduces the equivalent
  probe's committed heap from 9.2 to 1.7 MiB. All 31 string and seven byte
  declarations are inventoried on that branch.
- Closures: typed heap captures, consuming dynamic application and metadata
  for owned entry/capture cleanup. Runtime callbacks still share. Aliases,
  partial application, returned inputs and stack on/off pass O1/O2 GC/poison
  checks. No-tracing selected loop frees 1.2 MiB versus 0.0 with freeing disabled.
- Deep closure cleanup: work list with 64 local slots and freed spill storage.
  Linear/branching 8,000-node graphs reclaim with zero collections on a 256 KiB
  native worker stack at O0; restoring recursive release exhausts that stack.
- Temporary types: concrete call parameter types preserve typed constructor
  child cleanup. No-tracing function-list loop frees 0.5 MiB versus 0.0 when only
  outer-only release is restored. Eight IR and twelve ownership checks pass.
- Stack arguments: eligible stack locals/aliases and consumed calls own typed
  child references, with nested cleanup scopes and address fences. Borrowed
  calls keep owners until IR Drop. Six escape and fifteen ownership checks pass.
  Restoring old child lifetimes gives variant/closure frees 0.0/1.3 MiB versus
  0.5/1.7 MiB after cleanup. Existing stack closure allocation test, five FFI
  checks and local fat baseline pass. Full platform gates remain required.

All counter probes use identical outputs, tracing disabled and zero collections;
results are rounded to tenths of a MiB. None establishes general no-GC support.

## Remaining acceptance work and next implementation

The immutable-anchor table records the published ownership chain through typed
partial retains. Container/list structural aliases, old-object reclamation and
callback unwind changes are prepared; their full sequential CI has not yet run.
The baseline still shares at saturation; the prepared wide-count branch removes
that transition. Phase 2 remains incomplete pending full gates and audits of
constructor context, conversions/reconstruction, SetFields fallback, CAF/inline
owners, retained tasks, teardown and cycles. WASI remains a bump allocator.
After ownership acceptance, continue typed numeric storage/ABI, fused numerical
kernels/autodiff lifetimes, measured regression evidence and optional tracing-free
execution in PLAN.md order. Keep runtime boundaries shared until their retained
lifetime and exceptional cleanup are checked.

Darwin cross targets/universal binaries, Clang PGO and Darwin static-memory
validation remain deferred. Native static linking is explicitly unsupported.
OpenCL framework discovery works; hardware execution is unverified. Linux-only
strace/process RSS suites still need platform alternatives. Windows, new
interfaces and new backends are outside the active roadmap. Historical Linux
benchmark numbers are not current macOS performance evidence.

## Local resource limits

Checks are serial and low priority: 1 GiB sampled aggregate RSS, target below
2 GiB, at least 64 GiB free disk, 180-second deadline, CPU toward half one core.
Use `/private/tmp/fwp-local-guard.py`, adapted only to this repository root,
with `CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target` in temporary
worktrees. It needs process-sampling/priority permissions. Recreate the temporary
guard with the same limits if missing. Do not bypass a refusal or increase limits;
move the workload to CI. No full local gates were run.

The remaining acceptance section above controls priority. Design/preparation
notes below record evidence and earlier decisions; their old next-task remarks
are historical and must not replace the current queue.

## Callback design constraints retained for review

Start with synchronous map callbacks, not retained task/channel/FFI callbacks.
Add a typed borrowed application path: duplicate supplied pointer arguments
according to function metadata, consume those copies in the owned entry, and
retain the original function owner. Partial and overapplication must duplicate
arguments in chunks according to each actual function's parameter types, never
by guessing whether scalar bits resemble an address. Callback results then have
one owned reference, including aliases of inputs/captures and returned functions.

Map needs owned fresh list spines with already-owned elements; FreshTree is not
valid for aliased callback results. Do not reset child counts or recursively
promote borrowed inputs to sharing. Release the temporary result buffer after
transferring its references into new nodes. Add aliases/captures/function-result,
GC/reuse and zero-tracing reclamation tests; validate hardware/benchmark gates.

Preserve specialized direct callbacks and captured HOF loops. Function locals
are now counted, so a borrowed callback temporary can hide its known partial
application behind a local. Recover its function/captures for specialization,
and allow stack callbacks only when the contract proves synchronous invocation
without retaining the function itself. A Borrow argument may still have aliased
results; borrowing alone is not a no-escape proof. Stack caller cleanup must
run only for consumed arguments; borrowed ones are released by their IR Drop.
The stack change already consults rc::consumes_arg for that distinction.

Byte counts still saturate into tracing-managed sharing at 255. An exact overflow
path, other constructor/result contexts, exceptional cleanup, old-generation
reclamation, retained runtime graphs/cycles and WASI reclamation remain required
before general no-tracing execution. Do not claim phase 2 or phase 6 complete.

## Borrowed callback foundation preparation

`ownership-borrowed-callbacks`, `/private/tmp/fwp-callback-worktree`, base
`b563360`, published at `029fac4`, has typed argument-slice duplication metadata and a borrowed dynamic
application entry. Exact/partial/overapplication, captured/input aliases,
compiler-generated mixed scalar/pointer metadata and stack callbacks pass at
O1/O2, GC stress/verification and both reuse-poison modes. The focused probe
used CPU 1.03 s / elapsed 2.59 s under the guard. Sixteen focused ownership regressions passed (CPU 29.75 s / elapsed 59.69 s).
Five FFI checks and the local fat baseline passed (CPU 5.27 s / elapsed 10.60 s).
This foundation leaves existing map/retained callbacks unchanged. Next: owned map spines, scratch-buffer release,
synchronous callback contracts and preserved specialized HOF loops. Full CI is
required after all parent merges. Prepared work never completes phase 2 alone.

## Synchronous map preparation in progress

`ownership-map-callbacks`, `/private/tmp/fwp-map-worktree`, base `029fac4`,
is published at `41ef82d`, with no PR yet. FreshSpine owns new list nodes
without resetting already-owned callback elements. Generic callbacks use typed
borrowed application; direct/captured HOF loops keep specialization and typed
per-call ownership. Only map's synchronous function slot gets a no-escape proof;
Borrow alone is insufficient. Scratch arrays are explicitly released.

Alias checks cover new allocated captures, retained inputs and returned functions,
O1/O2, stack on/off, GC stress/verification and poison modes. The selected
no-tracing differential restores only the shared-result boundary: identical
outputs and zero collections; counts free 2.7 MiB versus 4.6 MiB with owned map
results. This is counter evidence, not a speed claim. The existing stack closure allocation regression passed (CPU 7.20 s / elapsed
14.70 s including rebuild); six escape checks and the contract inventory passed.
Final post-review ownership set passed: eighteen tests, CPU 33.90 s / elapsed
68.10 s under the guard. Full current-head CI remains required after parent merges. A review added original callback/list address fences
around specialized calls and clears stale local callback-origin information.

Five FFI checks and the local fat baseline also passed for map ownership
(CPU 5.66 s / elapsed 11.28 s). Formatting and whitespace passed after applying
the reported formatting changes. No local full gate or benchmarks were run.

After stack ownership merges, rebase borrowed callbacks from b563360; after
that merges, rebase map callbacks from 029fac4. Each gets its own full CI PR.
For filter, duplicate a selected element by its concrete callback parameter
type before transferring that reference into the result spine. Retain input
list and callback roots; preserve direct/captured specialized loops and exact
callback/trap order. A predicate consumes typed argument copies and returns Bool;
its call alone does not acquire the reference needed by a selected output node.

## Filter preparation in progress

`ownership-filter-callbacks`, `/private/tmp/fwp-filter-worktree`, base `41ef82d`,
is published at `1ea7f07`, with no PR yet. Synchronous filter borrows predicate/list, gives selected
elements their own typed references, returns an owned fresh spine and frees
scratch storage. Direct/captured loops retain specialization and root fences.

Two focused probes pass: O1/O2, stack on/off, GC stress/verification and poison
modes cover selected String/function aliases and newly allocated captures.
The no-tracing differential restores only the shared-result boundary: identical
output and zero collections; counts free 4.6 versus 5.0 MiB. The initial fixture
needed a separate pure function-list signature; it now passes. A prematurely
started formatting check was refused by the guard's workload lock, so no checks
overlapped. Formatting ran only after the test completed, with unchanged limits.
Twenty focused ownership regressions passed (CPU 38.40 s / elapsed 76.96 s).
Five FFI checks and the local fat baseline passed (CPU 5.61 s / elapsed
11.21 s). The contract inventory covers both map/filter declarations.
Formatting and whitespace passed; full current-head CI remains required.
Next: other synchronous callbacks (fold/zip-with), typed container elements,
remaining contexts, exact overflow counts, exceptional/retained runtime cleanup,
old-generation and WASI reclamation, plus cycle policy. Phase 2 is incomplete.

## Fold design constraints retained for review

Start with synchronous fold. Its function/list borrow; the accumulator transfers
one owned reference into every callback, and the returned value replaces it.
Empty input returns the incoming accumulator reference. Introduce a typed
borrowed-application helper with an owned-prefix length: skip duplication of
transferred prefix arguments, duplicate the remaining slice by actual function
metadata, and carry the remaining prefix length across overapplication chunks.
Ordinary borrowed callbacks use prefix zero. Fold uses prefix one; avoid an
extra retain/release of the accumulator every iteration.

Preserve direct/captured fold specialization: duplicate captured pointer values
and the input element by concrete types, transfer the accumulator, invoke the
owned entry and keep original function/capture/list roots through allocations.
Use separate owned two-argument callback wrappers if needed; map/filter's wrappers
borrow all supplied arguments. Define an OwnedValue result contract, not
FreshTree/FreshSpine: the accumulator may alias a supplied element or capture.
Add empty/alias/function-accumulator and partial/overapplication checks plus a
no-tracing differential, then run the focused ownership and full CI gates.
Fold-right/zip-with and retained callbacks remain separate follow-up scopes.

After map merges, rebase filter from 41ef82d onto main and validate in its own PR.

## Fold transfer preparation

`ownership-fold-transfers`, `/private/tmp/fwp-fold-worktree`, base `1ea7f07`,
is published at `a180c3f`, with no PR yet. Runtime borrowed application
accepts an owned-prefix length; fold transfers its accumulator, borrows element/
callback copies, and returns an OwnedAccumulator result. Empty input preserves
the incoming owned reference. Generic/direct/captured paths preserve specialization
and original roots. Contract checks, aliases and exact/partial/overapplication
probes passed. Fixture argument-order errors and a wrapper `_own`/`_owned` naming
mismatch were fixed. Zero-argument application avoids arithmetic on a null pointer.

The final no-tracing differential restores result sharing in generic and
specialized fold paths: identical output/zero collections, counts free 1.3 versus
1.8 MiB. Changing only the unused generic path initially showed no difference;
the final probe covers the executed specialized path. The focused aggregate regression set passed: twenty-two ownership tests
(CPU 42.25 s / elapsed 84.77 s under the guard).
Five FFI checks and the local fat baseline passed (CPU 5.35 s / elapsed
10.69 s). Formatting and whitespace passed. Full current-head CI remains required
after parents merge. Next: fold-right and zip-with, remaining contexts/container elements,
exceptional/retained runtime cleanup, exact count overflow, old-generation/WASI
reclamation and cycle policy. No general ARC/no-GC claim is established.

After filter merges, rebase fold from 1ea7f07 onto main and run its own full PR gate.

## Zip callback work in progress

`ownership-zip-callbacks`, `/private/tmp/fwp-zip-worktree`, base `a180c3f`,
is published at `bdb750f`, with no PR yet. zip-with borrows its callback/two input lists, transfers owned
callback results into fresh spines and releases both scratch buffers. Direct/
captured specialization remains; direct borrowed wrappers support arity two.
Mixed String/I64 inputs, input/capture aliases, empty/unequal lengths and dynamic
callbacks pass O1/O2, stack on/off, GC stress/verification and poison checks.
No-tracing differential: identical output/zero collections, counts free
2.2 versus 3.6 MiB. Returned-function coverage and the aggregate focused suite passed:
twenty-four ownership tests, CPU 46.53 s / elapsed 93.26 s under the guard. Five FFI checks and the local fat baseline passed (CPU 5.20 s / elapsed
10.51 s). Formatting/whitespace passed. Full CI remains required after parent
merges. Next: fold-right
needs an owned argument span (accumulator is argument 1), not just an owned prefix.

For fold-right, extend the borrowed transfer helper to an owned span within the
supplied arguments: duplicate typed slices before/after that span and adjust its
position across actual function-arity chunks. Ordinary borrow has an empty span;
left fold transfers argument 0; right fold transfers argument 1. Keep existing
prefix wrappers/tests. The right fold must retain and explicitly release its
reversible input scratch buffer, preserve right-to-left callback/trap order, and
support empty/aliased/function accumulators. Preserve direct/captured HOF paths.

After fold merges, rebase zip from a180c3f onto main and run its own full PR gate.

## Right-fold ownership preparation

`ownership-right-fold`, `/private/tmp/fwp-right-fold-worktree`, base `bdb750f`,
is published at `adc7947`, with no PR yet. Owned argument spans support transfer of
argument 1 while borrowing argument 0, including across overapplication chunks.
Prefix and ordinary borrowed wrappers remain. fold-right consumes its accumulator,
borrows callback/list, preserves direct/captured specialization and releases the
rooted input scratch buffer. The inventory and three span/right-fold probes passed
(CPU 11.20 s / elapsed 22.55 s). No-tracing differential: identical output/zero
collections, counts free 1.3 versus 1.8 MiB. Twenty-six focused ownership regressions passed (CPU 52.75 s / elapsed
105.91 s).
Five FFI checks and the local fat baseline passed (CPU 5.55 s / elapsed
11.19 s). Formatting/whitespace passed. Full current-head CI is still required
after all parents merge.

The entire roadmap goal remains active. Next: remaining synchronous list
boundaries, typed container elements and other constructor/result contexts;
exact overflow counts, exceptions/retained callbacks, old-generation/WASI
reclamation and cycle policy still precede general no-tracing execution.

After zip merges, rebase right fold from bdb750f onto main and run its own full PR gate.

## PR #75 macOS concurrent cache correction

ARM CI tutorial 7 produced no output for two native `scale` stages using the
same cached executable. The exact focused tutorial reproduced locally, and a
new interpreter/native regression failed on warm run 1 before the fix. Cache
hits opened executables for append just to touch their timestamp; opening them
read-only preserves timestamp updates and permits concurrent execution. The
regression's cold run and eight warm runs pass after that change (CPU 14.20 s /
elapsed 28.43 s including incremental Rust compilation). Tutorial 7 also passes
(CPU 3.89 s / elapsed 7.70 s). Both use the bounded local guard. An accidentally
unfiltered tutorial check was stopped immediately before these focused checks;
no limits were raised. Publish the correction and run all current-head gates.
The earlier Linux/benchmark successes do not gate the new head. Full CI may
find further failures; fix them and continue the roadmap.

Cache correction published as f53493c. Both native pipe tests pass (CPU 9.30 s /
elapsed 18.88 s); formatting and whitespace pass. New full gate 37612412156
must pass before merging #75. The previous run is complete: only ARM failed; Intel, Linux and benchmarks
passed. Those successes do not verify the corrected head.

## Prefix/suffix ownership preparation

`ownership-list-prefix`, checkout `/private/tmp/fwp-prefix-worktree`, base
`adc7947`, is published at `376e77a` with no PR yet. Synchronous take/drop-while borrow predicates/source,
stop at the first rejected element, retain direct/captured specialization and
protect source/capture addresses. Fresh prefix nodes own duplicated selected
elements; returned suffixes acquire one tail reference before source cleanup.
Two tests pass with aliases/function elements, empty/all/no-match cases,
post-source-cleanup use and a predicate that traps if called after rejection,
at O1/O2 with stack on/off, collection verification and reuse poisoning.
The no-tracing differential restores result sharing in all specialization paths:
identical output/zero collections, 5.0 versus 8.2 MiB freed by counts. Twenty-eight focused ownership regressions and the contract inventory passed
(CPU 49.90 s / elapsed 100.17 s for the regressions). Native fat baseline passed
(CPU 9.16 s / elapsed 18.61 s including incremental compilation). Five FFI
checks passed (CPU 2.76 s / elapsed 5.46 s), formatting and whitespace passed. Full platform CI is required
after all parents merge. Remaining list operations, typed container elements,
exact counts and retained/exceptional lifetimes still belong to phase 2.

Prefix/suffix work is committed and published as 376e77a; verified subject is
one line, 56 characters with no body/trailers. The branch and current PR worktree
are clean. Root remains main with intentional local status documentation.
No local workloads remain. Latest #75 gate 37612412156 is still queued; fix any
failures, and squash only after all four jobs pass. Next concrete work: refine
non-callback list drop/copy boundaries, preserving typed element aliases and
releasing scratch buffers; do not rewrite head/tail/last, already language code.
After #75 merges, rebase leaves from OLD base 798d2ed onto the squash commit and
open the next sole PR. Continue the table in order, fixing tests at every step.

## Ordinary list copy ownership preparation

`ownership-list-copies`, checkout `/private/tmp/fwp-list-copy-worktree`, base
`376e77a`, is published at `bb00baa` with no PR yet. Reverse/take/append/flatten borrow inputs and own only
new list nodes with typed element references. Append stops ownership at its
borrowed suffix and acquires one tail reference; drop likewise duplicates its
returned tail, never resets aliased node counts. Scanned temporary buffers are
released; original input addresses remain roots. Two focused tests pass with
strings/functions/scalars, nested flattening, retained aliases, post-input-drop
use and negative/zero/oversized/empty cases at O1/O2, stack on/off, GC verification
and both poison settings. No-tracing loop: identical outputs/zero collections,
7.3 versus 13.6 MiB freed by counts. Initial check CPU 11.21 s / elapsed 22.84 s
including incremental Rust compilation. Thirty related ownership regressions passed (CPU 60.63 s / elapsed 121.63 s),
and the declaration/alias contract invariant passed. Five FFI checks and the native fat baseline passed (CPU 5.34 s / elapsed
10.65 s). Formatting and whitespace passed; branch published. full platform CI is still required after all parents merge.
Next: nth/find result aliases and the remaining synchronous callbacks, exact
counts, typed container elements and exceptional/retained lifetime cleanup.

Ordinary list copy work published as bb00baa; next prepare optional nth/find
alias results and read-only index-of. It has no PR; full CI must follow its
parents. Current #75 gate 37612412156 has ARM testing, with other jobs queued.

## Optional list alias ownership preparation

`ownership-list-options`, checkout `/private/tmp/fwp-list-option-worktree`, base
`bb00baa`, is published at `34023f3` with no PR yet. FreshOuter owns one new structural allocation and
borrows/duplicates fields by monomorphic constructor type. Nth/find retain
selected elements; index-of borrows comparison keys and owns its optional
scalar. Find invokes typed borrowed predicates, preserves direct/captured
specialization, and stops at the first match. Two focused tests pass at O1/O2,
stack on/off, GC verification and both poison modes; they include dynamic/
captured predicates, function aliases after input cleanup, missing/negative/
empty cases and a predicate that traps after a match. No-tracing differential:
identical outputs/zero collections, 9.6 versus 10.4 MiB freed by counts. Focused
run CPU 4.54 s / elapsed 9.35 s. Thirty-two related ownership regressions passed (CPU 58.04 s / elapsed
116.52 s), as did the contract invariant, five FFI checks and native fat
baseline (CPU 5.25 s / elapsed 10.46 s), formatting and whitespace. Published;
full platform gates remain required after all parents merge.

Effect inference follow-up: an inline pure function-valued list pipeline in an
IO main fails in the existing interpreter frontend:
`"a b c" | words | map concat | find has-text | option.map (apply "!") | echo`
with `has-text : (String -> String) -> Bool`, defined as
`apply "!" | string.length | gt 1`. It expects IO on the option-map stage but
finds a pure stage. The lifetime fixture uses an explicitly typed pure helper
`selected-found : List[String -> String] -> Option[String]` for that suffix,
which succeeds. This is not caused by native ownership code; preserve a focused
reproduction and resolve effect-row inference as part of language design work.
Do not weaken tracked effects to hide the failure.

Optional list ownership published as 34023f3; no new PR. Next concrete task is
the reproduced effect-row inference failure, then remaining synchronous callbacks
and exact overflow counts. Current #75 gate: benchmarks passed; Linux and both
macOS architectures are testing. All current-head gates must pass before merge.

## Call effect inference repair preparation

`inference-call-effects`, checkout `/private/tmp/fwp-inference-worktree`, base
`34023f3`, is published at `89b7bde` with no PR yet. A focused frontend regression failed before the fix:
known pure callbacks closed a callee's effect row during argument unification,
then call unification either copied the IO context into callback requirements or
closed the whole caller context to purity. Infer::open_call now retains abstract
size opening and reopens only a closed row on this call, after resolving it.
It never changes function-valued argument rows or removes required effect labels.
Pipe application/composition and ordinary application use the same helper.

Four focused tests pass (CPU 4.97 s / elapsed 9.92 s): inline pure callbacks in
IO pipes and ordinary applications; three missing-IO signature rejections;
existing effect/handler snapshots unchanged; interpreter/native output at O1/O2
with GC stress/verification. The formerly failing source needs no helper
annotation on this branch. Thirty-two related ownership regressions passed (CPU 60.07 s / elapsed
120.49 s). The expanded four-test set also checks 20 existing effect/handler,
abstract-size, comptime and resource-capture snapshots without changing their
outputs (CPU 10.75 s / elapsed 21.48 s). Five FFI checks and the native fat baseline passed (CPU 5.54 s / elapsed
11.08 s). Formatting and whitespace passed; repair published. Full type snapshots/platform CI are still required after all parents
merge. Current #75 head f53493c has benchmark success and all test jobs running.

Call-effect repair published as 89b7bde. Worktrees for copies, options and
inference are clean; root remains main with intentional local documentation.
No local workloads remain. Next implementation: exact count overflow on a new
branch based on 89b7bde. Keep the one-byte common case; use rare side metadata
keyed by the canonical count slot, so metadata cannot conservatively root a
value. Centralize decrements for generated typed drops, raw drops and closure
cleanup; each currently decrements the byte directly. Ordinary fwp_rc_last is
a predicate, not a consuming decrement, so preserve its callers' semantics.

Overflow metadata must disappear on count reduction, explicit graph sharing,
freeing/reuse and GC sweeping (including whole empty-chunk reclamation).
Handle allocator failure and size_t overflow explicitly. Cover leaf/record/
function fanout above 255, aliases/interior addresses, callback graph-sharing,
GC slot reuse and no-tracing reclamation. Reuse and scalar-bit safeguards must
remain. Review runtime/fwp_rt_gc.c count resets at allocation, mem_free and sweep,
and src/cgen.rs typed drop heads before editing. Full CI follows parent merges.
Current #75 gate 37612412156: benchmark success; both macOS jobs and Linux
remain running. Fix failures and merge only when all current-head gates pass.

## Exact wide-count ownership preparation

`ownership-wide-counts`, checkout `/private/tmp/fwp-wide-worktree`, base
`89b7bde`, has no PR yet. Native byte counts 1..254 remain inline; 255 points to
an exact size_t side entry keyed by canonical metadata address (no language
value root). Metadata table is 2 KiB plus 24 bytes per entry before allocator
overhead on 64-bit native platforms. Generated typed drops, raw decrements and
closure cleanup share a release/decrement helper. Last-reference predicates
retain their old semantics. Count reduction, explicit sharing, free/reuse and
partial/empty-chunk/big-object sweeps remove side entries. Overflow traps;
injected allocation failure reports OOM (102). WASI keeps the shared stub.

Existing sharing regression still rejects the unsafe parent-only saturation
baseline; the new counted branch explicitly shares at retained callback entry.
Three new probes pass: 601-reference leaf/record/function aliases, interior
metadata keys, capture destruction, free/reuse and deterministic sweep fixtures,
size_t overflow/OOM; real high-fanout function/string collection tests at O1/O2,
stack on/off, stress 17/verification and both poison modes; and no-tracing
reclamation. No-tracing loop gives identical output/zero collections, 73.9
versus 74.8 MiB freed by counts when automatic sharing is restored/removed.
Initial two-probe run CPU 4.22 s / elapsed 9.14 s; collection check CPU 3.04 s /
elapsed 6.23 s. All 35 related ownership regressions pass (CPU 68.22 s /
elapsed 136.57 s), and the ownership contract inventory passes (CPU 3.47 s /
elapsed 7.47 s). Five FFI checks and the local fat baseline pass (CPU 12.35 s /
elapsed 24.64 s); formatting passes. Published as `3a791dc`, with no new PR.
All checks use the bounded guard. Full platform gates are still required after
parent merges. Current #75 gate: ARM macOS, Linux and benchmarks pass; Intel macOS
remains testing. This repair does not prove general no-tracing execution.

## List ordering ownership preparation

Current isolated task: `ownership-list-order`, checkout `/private/tmp/fwp-order-worktree`,
base `3a791dc`. Give sort/unique copied spines typed element ownership and
release their source/merge scratch buffers. Preserve stable sort order and first
unique occurrence, and compare aliases and scalar/nested elements with the
interpreter under collection stress. Sort-by remains a separate callback task.

Sort/unique now use CopiedSpine contracts and release source/merge buffers.
Two new checks pass: interpreter agreement at O1/O2, stack on/off, stress 1,
verification and both poison modes for strings/nested lists/scalars/empty inputs;
no-tracing counts 4.7 -> 6.5 MiB freed after restoring/removing only result
sharing, identical output and zero collections. CPU 11.76 s / elapsed 23.62 s
under the guard, including compilation. All five adjacent copied-list/wide-count checks pass unchanged (CPU 12.93 s /
elapsed 26.35 s). Contract inventory passes (CPU 3.99 s / elapsed 8.07 s),
formatting and whitespace pass. Published as `c835578`, without another PR; full gates follow
parent merges. No local workload remains. No second PR has been opened; #75 still awaits its
Intel gate. Next: sort-by synchronous callback/key ownership.

Sort-by follow-up design: borrow the synchronous callback and source, invoke
through fwp_apply_borrowed to obtain owned keys, keep key/value/merge buffers
scanned, release each key with its monomorphic generated drop helper after
sorting, then adopt a CopiedSpine result. Keys may alias inputs or captures;
never freshen/reset key counts or infer pointer ownership from scalar bits.
Test callback order/once-per-element, stable ties, allocated/string keys,
captured/partially applied callbacks and collection during key evaluation.
Exceptional cleanup remains an explicit phase-2 gap; do not claim it solved by
normal-path scratch release. Reconcile these notes against final macOS fixes
when rebasing each prepared branch after its parent squash merge.

## Sort-by callback ownership preparation

`ownership-sort-callbacks`, checkout `/private/tmp/fwp-sort-callback-worktree`,
base `c835578`, has no PR yet. CopiedSpine source/result ownership combines with
Borrowed callback metadata, owned callback keys and generated typed key release.
Scalar keys use NULL; FWP_FREE=0 uses raw drops, FWP_REUSE=0 retains sharing.
Scanned source/key/merge buffers are released normally; source/callback roots
remain live through result construction. Three checks pass after a test-only
Rust mutable-command borrow was corrected: callback order and stable ties,
identity/allocated/aggregate keys, function-valued elements, O1/O2 stack on/off,
stress/verify/poison, both conservative switches; scalar address-bit probe via
actual emitted wrapper; no-tracing result/key reclamation. Counters 4.0 MiB
(result sharing restored), 4.7 (typed key cleanup removed), 5.1 (both owned),
identical stdout and zero collections. CPU 7.47 s / elapsed 15.02 s. First
normal-path pair passed CPU 12.60 s / elapsed 25.39 s including compiler rebuild.
Eight adjacent borrowed-callback/list-ordering/FFI checks pass (CPU 9.27 s /
elapsed 18.68 s). The contract inventory was extended to sort/unique/sort-by;
the extended inventory passes (CPU 3.60 s / elapsed 7.57 s). Formatting and
whitespace pass. Published as `66bc713`, without another PR; no local workload remains. Linux full CI now passes #75 as well as
ARM and benchmarks; Intel is still testing. Next after this branch: scan/iterate
owned output sequences, followed by zip/unzip/chunks structural aliases and
retained container element lifetimes. All checks stay bounded; phase 2 remains
incomplete, especially old-object reclamation and exceptional cleanup.

Scan/iterate design to implement next: borrow callback/source/initial value.
The first output needs a typed additional reference to the borrowed initial
value; every later callback result already owns its output reference. Borrow the
previous output when invoking the next callback so its stored reference survives
argument consumption; never transfer the only output reference as fold does.
Use actual callback argument metadata for the initial-value duplication (including
captured/partial callbacks), scanned/released scratch and fwp_map_finish for
owned output heads. Iterate with zero count must neither duplicate its initial
value nor invoke the callback. Verify aliased intermediate states, functions as
states, effect order, empty scan and non-positive iterate counts. Stored container
elements, exceptional lifetimes and old marked objects remain separate work.

## Scan and iterate ownership preparation

`ownership-state-sequences`, checkout `/private/tmp/fwp-state-sequence-worktree`,
base `66bc713`, has no PR yet. Three arguments borrow; scan callback index 0,
iterate callback index 1. FreshSpine output owns each state. Actual callback
argument metadata duplicates the initial state, each callback application borrows
the previous output, and later callback results transfer directly into output
nodes. Shared callback metadata stays conservative. Scanned scratch is released;
initial-state, callback and list roots have address fences. Non-positive iterate
returns without callback/refcount activity; allocation-size arithmetic is checked.

First attempt found a fixture mistake (`concat | trace-step` tried to compose
before the second curried argument; use `const trace-step` for the effectful
callback fixture) and a real separate ownership gap: the optimized map/sum
consumer feeds its list to a fused loop that still shares the complete state.
Generated fwp_loop49/fwp_loop51 call sites showed fwp_rc_share on records holding
list states. Counts were 4.1/4.1 MiB in both variants. The consumer is now direct
head/option processing to isolate sequence lifetime; 4.1 -> 7.9 MiB are freed
when only scan/iterate result sharing is restored/removed, identical output and
zero collections. Both semantic/counter checks then pass (CPU 5.08 s / elapsed
10.33 s). Expanded conservative-switch and allocated-empty-state checks plus all five
adjacent filter/prefix/callback regressions pass: seven tests, CPU 24.56 s /
elapsed 49.40 s. Extended contract inventory passes (CPU 3.86 s /
elapsed 8.12 s), formatting/whitespace pass. Published as `0a90b05`, without
another PR; no local workloads remain.

Next required ownership work: general and fused loop state/result transfer and
cleanup, preserving Step semantics, ticks, cancellation and evaluation order.
The map/sum consumer must gain reclamation evidence after that repair. Then
zip/unzip/chunks structural aliases, typed stored container elements, retained
callbacks and exceptional teardown. Fused-loop sharing is not fixed by this
sequence branch. Phase 2 remains incomplete; full CI follows parent merges.

Loop repair checkout prepared: `ownership-loop-state` in
`/private/tmp/fwp-loop-worktree`, base `0a90b05`, no edits or publication yet.
Inspect four paths: runtime fwp_p_loop (ticks, owned Step extraction), direct
fwp_k_loop, captured fwp_hof loop bodies, and Gen::loop_def unboxed locals.
FnGen::known_hof currently unconditionally shares the initial state before
fwp_loopN. Typed Step extraction must preserve aliased/shared callback results;
when consuming an owned boxed Step, duplicate its selected typed payload before
dropping the box, or prove unique transfer. For unboxed loop state, take typed
field references then release the incoming outer state; each iteration consumes
previous fields and transfers owned next/result fields. Preserve collector roots
and scalar-bit handling. Tests must cover all paths with callback order/ticks,
GC/reuse verification, input/result aliases, captures and no-tracing counts,
including the map/sum sequence consumer that currently loses reclamation.

## Loop state ownership implementation

`ownership-loop-state`, checkout `/private/tmp/fwp-loop-worktree`, base
`0a90b05`, is in progress and not published. Loop contracts borrow the callback
and consume state. Generic/captured/direct callback paths consume the state,
retain the selected Step payload by its known type and drop the Step. Captures
borrow between iterations and get per-call copies. Generated scalar/record
loops keep the existing unboxed form; record loads duplicate typed flattened
fields and release the incoming box. State/next arrays are zeroed with address
fences across allocating step execution. Tick/evaluation order stays unchanged.

New tests exposed native SIGBUS in the flattened nested-record case; nine other
isolated expressions passed. Rebuilding a nested record from loop slots needed
typed child references and to consume the field-read's initial Dup with its fresh
outer owner. That repair passes two new regressions at O1/O2, stack on/off,
stress/verify/poison, conservative switches, nested/captured/dynamic callbacks,
Step payload aliases and function states. A baseline matcher initially mistook
fwp_loop_payload for an optimized loop; it now matches only numbered loop calls.
Fused map/sum sequence consumer frees 8.5 MiB versus 4.1 MiB when only generated
loop initial-state sharing is restored, same output/zero collections (Apple
Silicon, Apple Clang 17, O1, 0.1 MiB precision). CPU 13.64 s / elapsed 27.52 s.
Earlier adjacent sequence tests passed CPU 11.99 s / elapsed 24.11 s.

Inspection also found boxed-to-worker ABI calls duplicated field references but
only raw-dropped the original outer argument, leaving its original child/storage
references. Post-call cleanup now uses the typed argument destructor. The first boxed counter was optimized to the unboxed loop and showed 1.1/1.1
MiB; it did not exercise that boundary. A revised constructor-choice step proves
use of fwp_k_loop_owned and shows 1.2 -> 2.7 MiB after restoring/removing only
raw outer release. Its focused check passes CPU 1.63 s / elapsed 3.49 s. This
ABI change needs adjacent closure/stack/FFI and IR verification before publication.
Current PR #76 passes benchmarks; Linux and ARM macOS passed; Intel macOS is running.
Keep all checks bounded, fix failures, and run full gates after parent merges.

All four new loop regressions and twelve adjacent closure/stack/temporary/FFI/fat
checks pass (16 total, CPU 41.37 s / elapsed 82.96 s). The scalar payload probe
uses the actual emitted loop wrapper with numeric words equal to a live String
address and preserves that allocation's count. Root fences were then narrowed
to possible heap-pointer slots; inline numeric/Bool slots need none, while boxed
numerics still do even without RC destruction. All five loop regressions pass after
that refinement, including two existing nested/trap goldens at O1/O2 with
collection stress/verify/poison (CPU 19.26 s / elapsed 38.72 s). Eight IR ownership checks pass (CPU 3.53 s / elapsed 7.43 s).
Contract inventory passes (CPU 0.00 s / elapsed 0.14 s), formatting/whitespace
checks precede publication. No local workload remains. No full local gate is run; #76 remains
the sole PR and all its non-benchmark jobs are still running.

Loop state repair published as `787763d` after five loop checks (including focused
existing goldens), twelve adjacent ABI/closure/stack/temporary/FFI/fat checks,
eight IR checks, contract inventory, formatting and whitespace. Every local
check used the bounded guard, with no limit increase or full local gate. The
commit subject is one line, 66 characters, without body/trailers; main's #75
squash was likewise verified. #76 head remains `2d2af62` and is the sole open PR.
Published descendants retain their OLD rebase anchors; do not prematurely rebase
or replay the whole pre-squash chain. Next concrete code: zip/unzip/chunks fresh
structural nodes must own borrowed element aliases by known types; scratch
storage must be released, with empty/truncated/invalid-size cases and nested/
function-valued aliases compared to interpreter under stress. Then retained
container elements, old marked-object reclamation and exceptional lifetimes.
No local workload remains. Full roadmap goal stays active and phase 2 incomplete.

## Structural list ownership prepared

`ownership-list-structure`, checkout `/private/tmp/fwp-structure-worktree`,
base `787763d`: zip/unzip/chunks build counted structural nodes with explicitly
typed borrowed element references and release scanned scratch buffers. Scalar
fields get NULL duplication operations, preserving address-shaped numeric bits.
The original truncation, data-last pair order and chunk failures remain intact.

Focused bounded checks: alias matrix and no-tracing counts passed, then expanded
invalid-size and reuse/free-disabled fallback coverage passed (3 tests, CPU
8.42 s, elapsed 17.17 s). Counts comparison restores sharing only at emitted
result boundaries: identical output, zero collections, 8.2 versus 12.6 MiB
freed by counts. A Boolean fixture typo was corrected before the passing run.
The actual scalar wrapper probe passed at O1/O2 after fixing overlapping
probe placeholders (CPU 0.84 s, elapsed 1.99 s). Inventory (1) and IR ownership
checks (8) passed, CPU 3.12 s / elapsed 6.42 s and CPU 0.00 s / elapsed 0.13 s.
Formatting and whitespace pass. No local workload remains.
No full local gate was run; all-platform gates follow parent squash/rebase.
Next: repeat/range remaining list ownership, then typed container elements,
old-object reclamation and retained callback/exception teardown.

Structural list change published as `c05a5d9c7d866286a4b778bd53b6d2c85cdbcf7f`,
base `787763d`; checkout clean, no extra PR. Commit subject verified as one line
with an empty body and no trailers. PR #76 remains the only open PR: full gate
37623311024 passes Linux, ARM macOS and benchmarks, Intel still running. When
all pass, verify head `2d2af62`, squash with explicit subject and empty body,
fetch/verify main, then rebase text from OLD anchor `2ce7a05` and open the next
sole PR. Continue repeat/range ownership while CI runs; failures require fixes.

## Generated list ownership prepared

`ownership-list-generation`, `/private/tmp/fwp-generation-worktree`, base
`c05a5d9`: repeat borrows its count/value, owns each new list node and duplicates
reference-bearing repeated elements by their monomorphic type. Non-positive
counts return empty lists without duplicating the input. Range borrows both
bounds and owns freshly generated list nodes; ordering, integer limits and
boxed numeric representations are unchanged. Boxed 128-bit numeric payloads
still use the conservative numeric allocation path and need phase 3 work.

Focused checks pass: retained String/Bytes/nested-list/601 closure aliases,
negative/zero repeat sizes, empty/backward ranges and signed/unsigned 8-, 64-
and 128-bit limits, O1/O2, stack on/off, GC/reuse verification and reuse/free-
disabled fallbacks (2 tests; CPU 5.75 s, elapsed 11.87 s). Initial fixtures used
an ambiguous function pipe and an absent int.to-string helper; corrected to
map over a function list and the existing show primitive. The actual scalar
repeat/range wrapper probe passes at O1/O2 with address-shaped numeric words
(CPU 0.69 s, elapsed 2.08 s). Identical output, zero collections: restoring only
result sharing changes count reclamation from 4.4 MiB to 1.7 MiB. This proves
list-node ownership in this workload, not general no-GC execution or speed.
Inventory (1) and IR ownership (8) checks passed (CPU 3.09 s / elapsed
6.38 s; CPU 0.00 s / elapsed 0.14 s). Investigating a potential TInt range
width issue confirmed TInt is excluded from Integer by the type checker, so
that unreachable path was not changed. The speculative width change/test was
removed; the final supported matrix passed all 3 tests (CPU 12.65 s, elapsed
25.37 s). Formatting and whitespace pass; no full local gate was run.
Next implementation: typed stored container ownership and destruction.

Generated list ownership published as `fad9b1a`, base `c05a5d9`; checkout clean,
no additional PR. Commit message verified as one line with no body/trailers.
Next task is typed array element ownership across creation, copies, alias
results, mutations and callbacks; map/set elements follow separately. Keep
current PR #76 gate 37623311024 and sequential old anchors as recorded above.

Typed array investigation: current `Gen::drop_body` frees container storage
without releasing elements; array creation/copies share their inputs, and
set/push owning wrappers drop only outer array references. Complete these
paths together before claiming typed element ownership. Copying a nonunique
array needs one typed reference per copied element; replacement drops the
old selected element; invalid set consumes the array without retaining the
new value. Poison-copy (`fwp_rc_unique_mut == 2`) must transfer or duplicate
children and clear/drop the old container consistently. Generate/map callbacks
borrow their arguments and return owned elements; fold consumes its accumulator.
Array get/to-list/slice/append/sort must establish typed result aliases and
keep input roots alive. Leave scalar words untouched. Preserve GC/reuse stress,
callback order and fallback flags, and add no-tracing allocation evidence.
No array code edits or local workloads remain; continue in the prepared checkout.

## Typed array element ownership implemented

`ownership-array-elements`, `/private/tmp/fwp-array-element-worktree`, base
`fad9b1a`: all 13 array primitive contracts now model typed ownership (length
remains scalar). Creation/copies own element references; last-reference array
destruction releases elements by type. Get/to-list create owned alias results;
slice/append/sort retain copied elements. Set/push borrow inserted values and
consume arrays; invalid set consumes without retaining its unused value.
Unique growth/poison-copy transfers children, nonunique copies duplicate them,
and replacement drops the old selected element. Callback generate/map borrow
inputs and own outputs; fold consumes/transfers its accumulator. Scratch sorting
buffers are released; capacity and slice calculations avoid overflow.

Inventory (1) passed CPU 3.13 s / elapsed 6.54 s, existing container alias and
callback regression (1) passed CPU 7.63 s / elapsed 15.54 s. Initial compile used
a nonexistent Gen field instead of the free_enabled() helper; fixed. Initial
new fixture used abstract ! io instead of concrete ! {IO}; fixed. Expanded
matrix/counts tests (2) pass CPU 12.34 s / elapsed 24.74 s, covering every array
operation, retained copies, nested arrays, String/Bytes/function elements,
601-element sharing/growth, callbacks, O1/O2, stack on/off, GC/reuse verification,
and reuse/free-disabled fallbacks. Function accumulator/captured fold callbacks
added and pass CPU 4.90 s / elapsed 9.96 s. Actual scalar wrappers and destruction
preserve address-shaped numeric words at O1/O2 (CPU 1.08 s / elapsed 2.30 s).
Identical output and zero collections: restoring only result sharing changes
count reclamation from 11.3 to 5.3 MiB. No general no-GC or speed claim.
Adjacent FFI (5), fat ABI (1) and stack (2) checks pass (CPU 8.91 s, elapsed
18.24 s). IR ownership checks (8) pass (CPU 3.10 s, elapsed 6.51 s).
Formatting/whitespace pass. No local workload remains. Full all-platform
CI follows the parent squash/rebase sequence; no additional PR is open.
Next: typed map/set element ownership, old-object reclamation and runtime
retained callbacks/exception teardown; numeric payloads still need phase 3.

Typed array change published as `636414fabf1802c1f3e15de3080763e997e0e135`,
base `fad9b1a`; checkout clean, no additional PR. Its 60-character commit
subject is one line with an empty body and no trailers. Next implementation:
typed map/set elements (including overwritten/duplicate keys, aliases, shared
copies and callback updates). Base the new isolated work on `636414f`.
PR #76 remains the only open PR; current-head run 37623311024 passes Linux,
ARM macOS and benchmarks, Intel still live. After all four pass, verify head
2d2af62, squash with explicit subject/empty body, verify main and rebase text
from OLD anchor 2ce7a05. Continue implementation and fix failures meanwhile.

PR #76 gate 37623311024 completed successfully on all four jobs at exact head
2d2af62630acf9e2c25d93e6ba2209d9e126a745. Authorized squash merged as
22994ba794a37320aca6e5122ed1ef909a0f4148; subject length 66, one line, body empty,
no trailers. Main fast-forwarded while restoring the existing local plan/handoff.
Text rebase is in progress from its OLD 2ce7a05 anchor; only handoff conflict,
resolved with current root evidence. Next focused tests, publication and sole PR.

Text rebase completed onto 22994ba; semantic/runtime changes merge cleanly.
The handoff conflict was reconciled with current root evidence. Post-rebase
text (3) and leaf (2) checks pass CPU 13.37 s / elapsed 27.10 s. Identical
outputs: text counts 0 -> 2.1 MiB and scratch heap 9.2 -> 1.7 MiB. Inventory
(1) passed CPU 2.99 s / elapsed 6.19 s; IR checks (8) CPU 0.00 s / elapsed
0.14 s; fmt/whitespace pass. Publish next sole PR/full CI at the current head.
Closure child still rebases from its OLD bab67ea anchor, never the newly
rebased text head. Keep remaining published chain anchors unchanged.

Rebased text change published as 0221f91c9edcf0096247b69676a156d331716984,
base 22994ba; sole PR #77 created, full exact-head gate 37636161587 queued for
all four jobs. Its subject/body format verified; checkout clean. Next separate
implementation is typed map/set element ownership, based on published array
head 636414f. Continue implementation while CI runs and fix any failures.

Next isolated checkout created: ownership-map-set-elements at
/private/tmp/fwp-map-set-worktree, base 636414f, clean with no code edits yet.
Preserve duplicate-key replacement semantics, typed key/value aliases and
callback/insert/remove ownership when implementing. No local workload remains.

## Typed map/set element ownership implemented

Current checkout ownership-map-set-elements, /private/tmp/fwp-map-set-worktree,
base 636414f: creation, insertion/replacement/removal, alias lists/Options,
map-values/update callbacks and set union/intersect/diff have typed key/value
owners. Unique growth/poison-copy transfers children; nonunique copies retain
references. Replacement preserves the first stored equal key and drops the
prior value. From-list retains the first key and last value after stable sort;
discarded borrowed inputs are not retained. Scratch sorting/merge buffers are
released. Empty collections remain static. Optimized map.get matches keep a
temporary owned selected-value reference through their arm without building Some.

Shared inventory (1) passes CPU 3.19 s / elapsed 6.78 s. Existing container
regressions (3) pass CPU 8.97 s / elapsed 18.27 s; insertion assertion now checks
typed retention rather than permanent sharing. New alias matrix passes, and
expanded optimized lookup/growth coverage passes CPU 5.12 s / elapsed 10.59 s:
O1/O2, stack on/off, collection/reuse verification and reuse/free-disabled paths,
all map/set operations, duplicate keys, retained copies, functions/nested arrays
and callbacks. A tuple fixture projection error was corrected. Count baseline
initially included two runtime forwarding calls; restricted to the actual
monomorphic wrappers. Identical output, zero collections: count reclamation
16.0 -> 26.2 MiB (CPU 1.98 s / elapsed 4.35 s). Actual generated scalar wrappers
and destruction preserve address-shaped words; a native pointer-identity probe
proves first-key/last-value retention and balanced replacement/destruction
(O1/O2; CPU 0.98 s / elapsed 2.07 s).
Adjacent arrays (3), FFI (5), fat ABI (1), stack (2) checks pass (CPU 15.80 s,
elapsed 31.99 s). IR ownership (8) passes CPU 3.18 s / elapsed 6.77 s.
Formatting and whitespace pass. No local workload remains.
No full local gate was run; full platform CI follows sequential parent rebases.
Next: old marked-object reclamation, complete retained runtime ownership and
exception/handler/cancellation teardown, cycles and WebAssembly allocation.

Typed map/set change published as a8a7d119712bd3cb77d03bde1daaedcf290b22d2,
base 636414f, checkout clean and no additional PR. Verified commit subject:
66 characters, one line, empty body, no trailers. Sole PR #77 head 0221f91
full gate 37636161587 remains live/queued for all four jobs. Next implementation:
old marked-object reclamation, auditing collector metadata and runtime boundary
sharing before releasing marked storage. Then retained ownership/exception
teardown/cycles/WASI remain; phases 3-6 are still uncompleted.

Next checkout created: ownership-old-reclamation in
/private/tmp/fwp-old-reclamation-worktree, base a8a7d11, clean with no edits.
Audit fwp_mem_free small/big mark/count bookkeeping, fwp_rc_unmarked gating,
and task/runtime sharing; add forced-survival/reuse/alias tests before changing
old-allocation reclamation. No local workload remains.

## Prepared old-storage reclamation

`ownership-old-reclamation` starts from OLD `a8a7d11`. Native final typed
releases now require an exact last owned reference and reclaim small or large
storage after it survives collections. Returning cells clears old-generation
marks and exact-count metadata; verifier mode clears stale child words before
linking freed small slots. Immutable reuse and updates remain young-only,
because minor tracing does not rescan immutable old fields. Shared runtime
and off-heap values do not enter the counted free path. Poison mode quarantines
released cells and preserves the existing reuse diagnostics.

Three new focused tests pass: actual major/minor survival and typed leaf,
record, closure, array and map destruction with retained aliases/shared graphs;
250 forced major collections free 4.8 MiB by counts versus 0.0 MiB with only the
previous age restriction restored; task/channel/deadline/cancellation/scope
and UDP golden behavior agrees at O1/O2, with collection stress, verification
and both poison modes. The survivor measurement includes real tracing; it is
not evidence of general collector-free execution. Latest three-test guard used
CPU 3.10 s / elapsed 6.57 s. Adjacent array/map/wide-count checks (9) and closure/
container checks (6) also pass; format passes. Full architecture gates remain
required after sequential rebase and publication as the sole PR.

The Linux long-loop regression now checks bounded memory/output for normal
ownership and separately builds with FWP_REUSE=0 to require >10 actual collections,
>800 MiB allocation and <64 MiB RSS for shared fallback. Collector-disabled
normal output/no-collection checks remain. This large workload runs only on CI;
its revised harness is compiled locally, not reported as runtime-validated.

Old-storage branch published as `6774aa5bb426c4dc1e49d9eca1ff1737763498a5`.
Verified commit subject: `Reclaim old owned storage and preserve young reuse invariants`
(61 characters), one line with no body/trailers. Revised Linux GC harness compiles;
fmt and whitespace pass. No local workload remains. Sole PR #77 exact-head CI
still tests on both macOS architectures; Linux queued, benchmarks passed. Next separate
implementation investigates task/channel retained ownership and teardown;
failing tests remain repair work, never a reason to stop the roadmap.

## Prepared task/channel boundary contracts

`ownership-task-boundaries` follows OLD `6774aa5`. The inventory now covers every
foreign declaration in lib/task.fwp. Spawn/scope/within callbacks remain explicitly
shared; send payloads and native handles remain shared. Await/within/recv/recv-for
own newly allocated Option nodes with type-directed aliases. Scalar payloads
are skipped; shared payloads stay shared. Duration arguments borrow through
blocking calls. Deadline passthrough no longer promotes its input graph to
sharing: a new generic alias result duplicates only RC types, never scalar bits.

Three focused tests pass: interpreter/native aliases for String, records,
functions, repeated task awaits and channels at O1/O2 under GC stress/verification
and poison modes; actual generated scalar/String deadline and I64 receive wrappers
using address-shaped numeric bits; and an identical generated 10,000-iteration
loop with only the previous deadline sharing boundary restored. With tracing
off, zero collections and FWP_STACK=0, counters free 0.0 -> 0.5 MiB (Apple Silicon,
Apple Clang 17, O1, one-decimal counter precision). This is reclamation evidence,
not full ARC or a speed claim. Latest guard CPU 3.31 s / elapsed 6.74 s. Existing
old-reclamation tests (3), including task cancellation golden stress, also pass.
Inventory (1), IR (8), formatting and whitespace pass. Adjacent leaf (2) and
old-reclamation (3) tests pass; guard CPU 11.90 s / elapsed 24.50 s. Full CI
follows the sequential squash/rebase workflow.

CI diagnosis for sole PR #77 exact head 0221f91: Linux job 112842831422 finished
with no runner and no steps. GitHub annotation: "The job was not started because
it repeatedly failed to be acquired (5 attempts)." Benchmarks passed; both macOS
jobs remain live. Individual-job retry returned HTTP 500 with an empty body,
not accepted success. Keep the live run; retry failed gates after it becomes
terminal. Do not treat the missing Linux runtime validation as passed or stop
implementation for infrastructure failures.

Task boundary branch published as `02beec353ec7745f6f69c1c99bb3c561725a6744`;
subject `Own task result wrappers and preserve typed deadline aliases` is one
line, 60 characters, empty body/no trailers. No local workload remains.
Next independent work must coordinate typed cleanup on failure/cancellation
before owned task callbacks can safely survive nonlocal unwind. Keep suspended
stack roots and task/scope parent lifetimes intact. Do not reinterpret the
explicit shared contracts as completed retained ownership.

## Prepared coordinated runtime unwind

`ownership-unwind-runtime` follows OLD `02beec3`. Stack cleanup nodes register a
release callback and context without heap allocation. Normal return unlinks them;
error/trap/cancellation invokes releases in LIFO order before longjmp invalidates
frames. Error handlers save their cleanup boundary. All runtime handler creation
sites and generated language-test handlers initialize it. Every gRPC recovery
site saves/restores a per-task trap cleanup boundary. Task switches save/restore
the cleanup chain alongside handlers; cancellation drains only the current task.
Finished tasks clear stale links before their stack can be reused. Release
callbacks must not suspend, throw or register another node.

file.with is an actual consumer: it registers its FILE before handle allocation,
closes/invalidate the handle on normal return, and closes through cleanup for
errors, recovered traps and cancellation. The interpreter already closes after
Ctl::Cancelled; no resource Dup rule or language syntax is changed.
Three tests pass at O1/O2 under collection stress/verification and both poison
modes: nested failure/rethrow and recovered trap cleanup; cancellation of two
suspended tasks without releasing their parent's owner; OS descriptor EBADF and
handle invalidation on each scoped file exit, including pre-handle cleanup; and
normal/error file.with programs matching the interpreter. Guard CPU 2.94 s /
elapsed 6.02 s. Earlier adjacent old-storage/task tests (6) pass; the seven-test
runtime batch used CPU 13.20 s / elapsed 26.74 s. A focused real gRPC every-kind-of-call test passes for native/interpreted
clients and servers, including errors/traps/deadlines; guard CPU 5.96 s /
elapsed 13.07 s. The first run lacked OpenSSL headers; the installed
/opt/homebrew/opt/openssl@3 works with FWP_OPENSSL_DIR set. Full gates stay on CI.

This supplies runtime unwind boundaries and fixes scoped-file resource cleanup.
It does not yet automatically register compiled local owners. Next must track
live ownership (including Dup/Drop, moves, stack children, scalar/variant worker
ABIs, callback accumulators and tail calls) before enabling retained owned task
callbacks/results. Async preemption can unwind pure callees too: register
incoming owned arguments before a tick, and preserve zero-cost scalar paths.
Do not replace this work with wholesale sharing or claim complete ARC.

Runtime unwind branch published as `3e314222ff7c0f379204a539858d73bfe1bda095`.
Subject `Release registered owners and scoped files before nonlocal unwind` is
one line, 65 characters, with no body/trailers. Formatting and whitespace pass.
No local workload remains. Latest sole PR #77 CI: ARM macOS and benchmarks
passed; Intel remains live; Linux failed runner acquisition with no test steps.
Keep this run; retry failed gates once it is terminal. Next checkout should
start from OLD `3e31422` for compiler live-owner tracking. Runtime nodes already
have one actual production consumer (file.with), but all-local unwind ownership
and retained task ARC remain required work.

## Latest preparation: initial flattened loop ownership

`ownership-loop-preparation`, `/private/tmp/fwp-loop-preparation-worktree`,
OLD base `c97dd03`, published head `b879eca20812651998a178fba2dae72cc46f4aed`;
clean checkout, no additional PR. Verified subject `Restore flattened loop states
and protect initial field preparation`: one line, 67 characters, empty body/no trailers. RC argument naming had
hidden rebuilt records behind a temporary and caused field-only counted states
to remain boxed. C generation now moves an immediately consumed terminal Again
through the record's preparation spine, preserving field and release order.
Both shape analysis and emitted loop bodies use that same normalized expression;
RC call-liveness verification accepts the changed ownership tree. Initial input
state and each completed counted-slot duplicate have separate typed scopes.
Completed slots transfer only after all are prepared, then the boxed input drops.
Scalars have no preparation slots. Whole-state uses remain boxed.

The initial source-shape assertion failed because the fixture actually stayed
boxed; diagnosis led to the narrow naming repair, rather than weakening the
assertion. The generated four-slot loop now passes interpreter/native comparison.
The fault probe injects before first/later field retention, with independent
box/leaf aliases, shared sibling leaves and scalar pointer bits (16 cases).
It passes O1/O2, GC stress/verification and both poison modes. Removing only
partial cleanup fails with the expected leaked-field code 5. Three preparation/
loop-unwind checks pass: CPU 7.15 s / elapsed 14.51 s. Existing cancellation
probes now read the actual flat String/pair owner slots. Five loop tests pass:
CPU 11.81 s / elapsed 23.83 s, including goldens for trap/evaluation order,
GC-disabled reclamation, aliasing and ownership switches. Library clippy passes:
CPU 2.31 s / elapsed 4.58 s. Formatting and whitespace pass.

All checks used `env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target
python3 /private/tmp/fwp-local-guard.py` followed by `cargo test --test
loop_preparation_ownership --test loop_unwind_ownership -- --nocapture`, `cargo
test --test loop_ownership -- --nocapture`, `cargo clippy --lib -- -D warnings`,
and `cargo fmt`. No local workload remains. The shared target contains this
compiler; guarded `cargo clean -p fwp` before changing checkouts. These are focused
checks, not full architecture support or a speed measurement. Sequential full
CI is still required. Further nested-slot flattening and field reconstruction,
vlocal variant duplication, typed constructor temporaries, CAF/inline lifetimes,
retained tasks and cycles remain to audit. Continue the sole PR #80 merge gate
and rebase this published preparation in its recorded order; phases 2–6 remain active.

## Current retain-failure work

Published `ownership-variant-preparation`, checkout
`/private/tmp/fwp-variant-preparation-worktree`, OLD base `b879eca`, head
`1bb11bece9ae7b960dd246f7008c98d386b9cc7d`; clean checkout, no additional PR.
Verified subject `Protect partial retains and caller owners across count overflow`,
one line, 63 characters, empty body/no trailers.
RC liveness now records the owners before a Dup, excluding its unfinished new
reference. Count generation protects those owners during retention. Typed
variant, flat-field and stack-child multi-retains protect only completed extra
references. Existing 12 RC unit checks pass (CPU 3.26 s / elapsed 6.88 s).
The dedicated generated-C probe passes O1/O2, stress/verification and both poison
modes (CPU 9.67 s / elapsed 19.44 s). It uses actual wide reference-count overflow,
not an injected retain trap: first/later field overflow preserves original
borrowed variant fields, and a compiled function's overflowing input Dup releases
its consumed caller reference. Removing only the variant partial scope fails
with code 3. Normal output matches the interpreter. Final liveness, focused adjacent regressions, formatting and lint results
are recorded below; all pass.
No local workload is active. Those checks used the retain-failure compiler; current target state is recorded
in Immediate continuation. Guard package clean before changing checkouts.
PR #80 publication is complete. Rebase these preparations in recorded order; retain OLD `b879eca`. Boxed-to-unboxed conversion, vlocal boxing,
nested field reconstruction and SetFields fallback preparation still need
separate checks. Phase 2 and all later phases remain incomplete.

Retain-failure final validation: all eight integration checks pass (five compiler
call-liveness, loop preparation, worker preparation, actual retain overflow),
CPU 27.40 s / elapsed 54.98 s. Both independent controls at O1/O2 demonstrate
missing cleanup: removing the variant partial scope returns code 3; removing
only the compiled worker's Dup owner scope returns code 7. Thirteen RC units
including the new unfinished-reference liveness case pass: CPU 3.27 s / elapsed
6.81 s. Library clippy passes: CPU 2.34 s / elapsed 4.61 s; fmt/whitespace pass.
All used the same local guard, with a package clean after the temporary-types
checkout. No local workload remains; the shared target contains retain-failure
code. Check commands: `cargo test --test retain_unwind_ownership --test
compiler_call_liveness --test loop_preparation_ownership --test
worker_preparation_ownership -- --nocapture`, `cargo test --lib rc::tests --
--nocapture`, `cargo clippy --lib -- -D warnings`, `cargo fmt`, each prefixed by
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py`. This exercises recoverable count overflow;
allocation exhaustion currently terminates via fwp_gc_oom. No complete ARC or
performance claim is made. Full sequential CI remains required. This preparation is published. Next propagate concrete constructor field contexts
and check boxed-to-unboxed/vlocal conversion ownership while PR #80 CI runs.

## Concrete aggregate context preparation

`ownership-constructor-types`, `/private/tmp/fwp-constructor-types-worktree`,
OLD base `1bb11be`, published head `b0219671dca3fee5c44a8725f29d18310d2622bb`;
clean checkout, no additional PR. Ownership propagation
uses monomorphic function result, local binding, branch, aggregate field,
dynamic-call parameter and update-field types when expression inference returns
unknown. Known inferred types take precedence. The new result-context unit first
failed because a later computed scalar was still evaluated inside the final
constructor after its earlier counted field had transferred logically. Naming
all computed consumed arguments before the operation fixes that lifetime window
and preserves evaluation order; scalar locals have no RC slot or allocation.

Fifteen RC units pass, including nested result contexts, dynamic arguments,
update fields and owners visible during later scalar preparation. Seven focused
constructor/boxing/temporary/retain/loop checks pass after the correction,
CPU 25.35 s / elapsed 50.78 s. The expanded actual error test separately restores
outer-only cleanup for a record and a variant; both controls detect the leaked
String child (code 4). O1/O2, GC stress/verification and both poison modes pass
with retained aliases and scalar pointer bits. Successful and handled-error
native output matches the interpreter. Five caller tests and the loop
trap/evaluation-order golden pass; resource outcomes are in Immediate continuation.
Library lint, formatting and whitespace pass. All used the serial guard with
`CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target`; the exact commands
were `cargo test --lib rc::tests -- --nocapture`, `cargo test --test
constructor_type_ownership --test constructor_unwind_ownership --test
worker_boxing_ownership --test temporary_ownership --test retain_unwind_ownership
--test loop_preparation_ownership -- --nocapture`, `cargo test --test
compiler_call_liveness -- --nocapture`, `cargo test --test loop_ownership
loop_goldens_keep_trap_and_evaluation_order -- --nocapture`, `cargo fmt`, and
`cargo clippy --lib -- -D warnings`, prefixed by the same fwp local guard.

No workload remains; current target contains this compiler. Constructor types
are checked internal context, not new surface syntax. Untyped aggregate field
bases and match scrutinees still need coverage, as do boxed-to-unboxed/vlocal
conversion, nested-field reconstruction, SetFields fallback, CAF/inline owners,
retained task lifetimes and cycles. Full architecture/benchmark gates are still
required; phase 2 and later phases remain incomplete. PR #80 remains the only
open PR. Next start conversion cleanup while PR #80 current-head CI runs.

## Boxed variant conversion preparation

`ownership-variant-conversion`, `/private/tmp/fwp-variant-conversion-worktree`,
OLD base `b021967`; focused checks pass, pending publication. Consume checkpoints
add compiler ownership facts, not a surface language construct. The original
boxed value and the caller's remaining owners have separate scopes while typed
field duplicates are prepared. Stack originals use their owned children instead
of a nonexistent outer heap count. Normal conversion unlinks the original scope
before typed destruction and finishes the remaining-owner scope afterward.
Already prepared field extras are handled by the published partial-retain helper.

The actual source fixture uses `tap (show | echo)` before matching a freshly
constructed variant, retaining a whole-value operation and its print order.
Its emitted conversion is asserted before fault testing. A hook at conversion
prepares valid wide counts and triggers the runtime's actual overflow on the
first/later retain; this is not an injected trap in the retain function. Eight
alias/failure combinations preserve surviving boxed/remaining-String aliases,
release the original box when unique, restore completed field counts exactly,
and leave scalar pointer bits intact. Independent O1/O2 controls remove only the
original conversion scope (code 3) or remaining-owner scope (code 7). Both poison
modes and GC stress/verification pass; normal native stdout equals the interpreter,
including the preceding print. The print stream and inline-count downgrade
handling in the probe were corrected before the final pass.

Sixteen RC units pass, including a consumed-value checkpoint that excludes its
transferred reference and retains the other caller owner. Nine focused integration
checks pass: conversion, five caller checks, typed constructors, partial retains
and worker preparation. Library clippy/fmt/whitespace pass. Actual resource
outcomes are above. Exact guarded commands were `cargo test --lib rc::tests --
--nocapture`, `cargo test --test variant_conversion_ownership --test
compiler_call_liveness --test worker_preparation_ownership --test
constructor_type_ownership --test retain_unwind_ownership -- --nocapture`,
`cargo fmt`, and `cargo clippy --lib -- -D warnings`, prefixed by
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py`. No local workload remains. Full architecture/
benchmark gates still have to run sequentially; vlocal boxing, reconstruction,
SetFields fallback, untyped context and retained runtime lifetime remain audits.

## Prepared record update ownership

`ownership-record-update`, `/private/tmp/fwp-record-update-worktree`, OLD base
`34873f4`. Record copies now retain only typed kept fields: scalar words and
replaced fields acquire no reference. Unique updates release overwritten typed
fields before assignment. Poison-copy verification uses ordinary typed
original destruction, including its children. Both generated copy paths use
one helper; the checker records update liveness with a borrowed base and
consumed replacements. The helper protects remaining owners and replacements,
then its raw copied outer cell and partial completed field retains separately.
Allocation still precedes retained-field acquisition; field evaluation order
is unchanged. No speed or complete ARC claim is made.

Seventeen ownership units pass (CPU 3.24 s / elapsed 6.71 s). Eight focused
integration checks (record update, boxed conversion, constructor context and
five compiler caller checks) pass, CPU 28.28 s / elapsed 56.77 s. Dedicated
update probes cover unique/shared normal results and actual first/later wide
count overflow, aliases, exact counts and scalar address bits at O1/O2,
GC stress/verification and both poison modes. The C probe supplies a counted
replacement through the fixture's captured constant slot; ordinary source
behavior also agrees with the interpreter. Independent controls removing the
unique overwritten-field drop, raw-cell scope, partial-retain scope or
replacement scope fail with codes 3, 8, 11 and 7 respectively. A mistyped
`call_unwind_ownership` target was rejected without running checks; the
corrected compiler-call target passed in the batch above.

Full sequential CI remains required. Remaining work includes direct exceptional
coverage of the general copy path, reconstruction from flattened records,
vlocal boxing, untyped field/scrutinee contexts, CAF/inline ownership and
retained task lifetimes/cycles. Do not mistake this focused evidence for all
update/reconstruction ownership coverage.

The existing in-place record regression also passes, CPU 7.84 s / elapsed
15.88 s. Library and dedicated-test clippy are warning-free, CPU 2.34 s /
elapsed 4.68 s; fmt/whitespace pass. Checks used serial bounded
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py cargo ...` invocations: `test --lib rc::tests`,
`test --test record_update_ownership --test variant_conversion_ownership
--test constructor_type_ownership --test compiler_call_liveness`,
`test --test reuse unique_records_are_updated_in_place`, and
`clippy --lib --test record_update_ownership -- -D warnings`. Package clean
preceded the checkout's build; no workload remains. Shared target now contains
the record-update compiler; clean the package before changing checkouts.
Prepared subject `Retain typed record fields and release overwritten update owners`
is one line, 64 characters, with empty body/no trailers. Publication follows
these checks; no additional PR opens while #80 is pending.
