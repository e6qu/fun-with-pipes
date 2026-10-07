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

- Current origin/main: `0f1ca9449973d9d01123a8e2958f86d79cda4ae8`, squash of
  [PR #83](https://github.com/e6qu/fun-with-pipes/pull/83), merged
  2026-10-08T03:18:29Z. All six gates passed in CI `37719069685` at exact
  `0c5bec4fc344339c03e01f2e15c5904a18361119`: Linux, bench, regular ARM/Intel
  and dedicated GC stress ARM/Intel. Verified one-line, 59-character subject
  `Own synchronous map results without sharing callback inputs`, empty body,
  no trailers. Main fast-forwarded preserving current docs; backup
  `/private/tmp/fwp-main-docs-pre83`. No open PR until filter is rebased/checked.
  Next sequential branch `ownership-filter-callbacks`, checkout
  `/private/tmp/fwp-filter-worktree`, OLD `1ea7f07`, rebasing from immutable
  OLD map `41ef82d87769596f99bde2081dc5ac00a514ffbc` onto this squash. Only
  handoff conflicts; use authoritative root docs and preserve OLD `1ea7f07`
  for fold. Full six-job exact-head gate remains required for the next PR.
  Shared target is dirty connect-cleanup checkout; clean package before switching.
  Latest published preparation: ALPN wire `f6598e440a59b1a7312ff5b62178644bec458ad8`,
  OLD parent `4ab1f7d`. Pending TCP/TLS cancellation fix passes three focused
  tests on `/private/tmp/fwp-connect-cleanup-worktree`, branch
  `ownership-connect-cancellation`, OLD parent `f6598e4`; not committed yet.
  Warning-check output needs confirmation before publication (session expired).
  Separate evidence branch `ownership-evidence-tls-listeners`, exact `a11f9e1`,
  CI `37719202504`: ARM regular and stress failed, other jobs still run.
  Logs `/private/tmp/fwp-tls-current-arm-113122693830.log` and
  `/private/tmp/fwp-tls-current-arm-gc-113122693964.log` obtained via completed
  job API; gh run log waits for the whole run. Diagnose and repair these failures;
  they gate acceptance of the preparation chain, never roadmap progress.
- Previous baseline: PR #82, `181d3b3`, all four CI `37703018710` gates passed
  at exact `3fa67f3`, one-line `Add typed borrowed application for synchronous callbacks`.
- Previous stack baseline: PR #81, `a4b6533`, all four CI `37696063781` gates
  passed at exact `6eeb915`. Verified one-line, 61-character subject and empty body.
- Previous baseline: `50ab17aba07e798d39818ad4fa423edff6e4b895`, PR #80,
  exact head `7ce23dd`, all four gates passed in CI `37684140373`.
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
- Earlier origin/main: `33d4fb1a33ad4aad6b584b2f25c90d0f4dbbc18c`, squash
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

Keep goal active; phases 2–6 remain incomplete. PR #80 merged as
`50ab17aba07e798d39818ad4fa423edff6e4b895` at 2026-10-07T22:21:01Z after
all four exact-head gates passed in CI `37684140373` for
`7ce23dd0acb354859948db9043ffd91e3029a55c`. Verified subject
`Preserve concrete call argument types for ownership temporaries` is one line,
63 characters, empty body/no trailers. Local main fast-forwarded while preserving
these two docs; backup `/private/tmp/fwp-main-docs-50ab17a`.
Rebased stack arguments from OLD `0acbc06` onto this main; only plan/handoff
conflicts required reconciliation. Four focused checks and fmt/whitespace pass.
Sole open [PR #81](https://github.com/e6qu/fun-with-pipes/pull/81), exact head
`6eeb915771abcac085c6f6cf0520fd25cbbe79ee`, full CI `37696063781`, in progress; ARM macOS and benchmark gates passed, Linux/Intel macOS running.
All four gates must pass before squash with subject `Retain and release typed
children of nonescaping stack values` (one line, 61 characters), empty body and
exact head match. Then rebase borrowed callbacks from OLD `b563360`; preserve
that original anchor rather than using the rewritten stack or squash head.

Latest published preparation: `ownership-inline-caf`, checkout
`/private/tmp/fwp-inline-caf-worktree`, OLD base `68cf7bf`, exact head
`6734248e7c0d4d53d57e5acccb9af02641713e9d`; clean checkout, no additional PR.
Verified one-line subject: 62 characters, empty body/no trailers. CAF arguments
retain checked evaluation bindings during inlining. Source trap omissions were
reproduced against an unoptimized interpreter; optimized interpreter/native and
counted temporary cleanup controls now pass. Five focused checks, four selected
semantic goldens, clippy and formatting pass. CONTRIBUTING records the need for
an unoptimized reference. Full sequential CI remains required. Next audit nested
state reconstruction/metadata and whole-value boxing, then retained task/library
lifetimes. Create the next separate task from OLD `6734248`. Shared target
contains this compiler; clean the package before switching checkouts. No local
workload remains. PR #81 remains the sole open PR.

Previous published preparation: `ownership-caf-cache`, checkout
`/private/tmp/fwp-caf-ownership-worktree`, OLD base `085dc71`, exact head
`68cf7bf2f7ca0986edf7039ff2e0bfe584e45820`; clean checkout, no additional PR.
Verified subject: one line, 58 characters, empty body/no trailers. Counted CAF
caches, owned returns, typed executable root/cache teardown and CAF caller/
argument lifetime checks pass. The 17 RC units, 10 focused ownership tests,
four selected semantic goldens, C library interop and clippy/fmt pass; detailed
evidence is below. Full sequential CI remains required. Next audit nested state
reconstruction and whole-value boxing, then inline and retained task/library
lifetimes. Create the next separate task from OLD `68cf7bf`; keep #81 as the sole
open PR. Shared target contains this compiler; clean the package before changing
checkouts. No local workload remains.

Previous published preparation: `ownership-field-context`, checkout
`/private/tmp/fwp-field-context-worktree`, OLD base `3f61f51`, exact head
`085dc716d5994681b998f13cd619b139794539fc`; clean checkout, no additional PR.
Commit subject verified: one line, 62 characters, empty body/no trailers.
Checked record types survive projection inlining; two regressions and five
adjacent checks, five selected semantic goldens, clippy and fmt/whitespace pass.
Detailed evidence is below; full sequential CI remains required. Next audit
reconstructed borrowed records and remaining whole-value variant boxing before
CAF/inline and retained task teardown/cycles. Create the next task from OLD
`085dc71`. Shared target contains this compiler; clean the package before
switching checks. No local workload remains.

Previous published preparation: `ownership-match-context`, checkout
`/private/tmp/fwp-typed-expression-worktree`, OLD base `de85621`, head
`3f61f51521d95527d6754c2e6c3ca01a31f64bd7`; clean checkout, no new PR.
Typed match context passes IR/source reclamation, negative erased-type control,
five adjacent checks and three selected case/record/variant goldens. Lint/fmt
pass; full sequential CI is still required. Next handle remaining field-result
contexts, reconstructed borrowed values, whole-value boxing and retained runtime
lifetimes. Shared target contains this context compiler; clean the package before
changing checkouts. No local workload remains.


Previous published preparation: `ownership-variant-alias`, checkout
`/private/tmp/fwp-variant-alias-worktree`, OLD base `614dd3b`, head
`de8562194d5461b69e6e5f3b448df0bfc1bee687`; clean checkout, no new PR.
Nested returned aliases now transfer unboxed field owners without extra retains
or boxing. The valid IR leak regression, source differential check and eight
adjacent checks pass; lint/fmt pass. Source reachability of the nested IR shape
remains unproved and is not claimed. Next handle untyped field/scrutinee contexts,
reconstructed borrowed values, whole-value boxing and retained runtime lifetimes.
Full sequential CI remains required.

Previous published preparation: `ownership-record-conversion`, checkout
`/private/tmp/fwp-record-conversion-worktree`, OLD base `5c5875d`, head
`614dd3b19c1340dd1f3b32f299a7ccdb51b5a7ef`; clean checkout, no new PR.
Boxed records and remaining owners are protected during typed field retention;
partial completed extras release on overflow. Dedicated O1/O2 stress/poison
checks and all nine adjacent checks pass; lint/fmt pass. Next audit vlocal
alias boxing, untyped contexts and reconstructed borrowed field lifetimes.
Full sequential CI is still required; phase 2 remains incomplete.

Previous preparation: `ownership-record-update`, checkout
`/private/tmp/fwp-record-update-worktree`, OLD base `34873f4`. Typed kept-field
retains, replaced-field release and partial-copy unwind checks pass. Published
as `5c5875d30b8ef0a513dd4d23d7f691b4636e35ea`; clean checkout, no new PR.
General exceptional-copy coverage now passes too. Next protect active
boxed-record-to-worker field conversion, then revisit nested reconstruction. Detailed evidence is in the final section below.

Previous published preparation: `ownership-variant-conversion`, checkout
`/private/tmp/fwp-variant-conversion-worktree`, OLD base `b021967`, published head
`34873f41a4c4c9dad3228132787f5bbb94ecbc28`; clean checkout, no new PR.
Verified subject `Protect boxed variants and caller owners during struct conversion`:
one line, 65 characters, empty body/no trailers.
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
Next audit vlocal boxing/aliases, nested reconstruction,
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
| ownership-stack-arguments | fwp-stack-worktree | 6eeb915 | 0acbc06 |
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
| ownership-variant-conversion | fwp-variant-conversion-worktree | 34873f4 | b021967 |
| ownership-record-update | fwp-record-update-worktree | 5c5875d | 34873f4 |
| ownership-record-conversion | fwp-record-conversion-worktree | 614dd3b | 5c5875d |
| ownership-variant-alias | fwp-variant-alias-worktree | de85621 | 614dd3b |
| ownership-match-context | fwp-typed-expression-worktree | 3f61f51 | de85621 |
| ownership-field-context | fwp-field-context-worktree | 085dc71 | 3f61f51 |
| ownership-caf-cache | fwp-caf-ownership-worktree | 68cf7bf | 085dc71 |
| ownership-inline-caf | fwp-inline-caf-worktree | 6734248 | 68cf7bf |

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
OLD base `b021967`, published head `34873f41a4c4c9dad3228132787f5bbb94ecbc28`;
clean checkout, no additional PR. Focused checks pass. Consume checkpoints
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
is one line, 64 characters, with empty body/no trailers. Published as
`b21203da65d30000ada50f3e2a92b1877153062f`; checkout is clean. No additional
PR opens while #80 is pending.


## General record copy coverage

Extended `ownership-record-update` after `b21203d` in the same focused change.
The source fixture `both (with { old = "new" }) id` performs its copy before
consuming the original. Generated C is asserted to have no unique-update
branch, proving coverage of the general `ExprSetFields` path. Normal result
contains the updated record and untouched original; their exact child counts,
independent external aliases and scalar address bits are checked. Actual
first/later wide-count overflows release partial retained fields, replacement,
copied outer storage and original owners. Removing the remaining-owner scope
fails with code 9; raw-cell/partial/replacement controls fail with 8/11/7.
O1/O2, stress/verification, both poison modes and ordinary interpreter/native
stdout agree. Both update tests pass, CPU 8.32 s / elapsed 16.78 s.

The added remaining-owner control initially assumed the context declaration
and registration occupied one C line; its lookup failed before compilation.
The lookup now follows the context variable to its registration. Clippy's
iterator-style warning was repaired with `rfind`; warning-free library and
new-test lint passes (CPU 0.00 s / elapsed 0.14 s). No product failure remains.
Validation used the bounded fwp guard with `cargo test --test
record_update_ownership --test general_record_update_ownership -- --nocapture`
and `cargo clippy --lib --test general_record_update_ownership -- -D warnings`.
Full sequential CI remains required; no new PR is open.

Reconstruction audit identified the active boxed-record-to-worker field
conversion in `FnGen::expr_fields`: it retains counted fields and drops its
input without protecting originals, remaining owners or completed extras.
This is the next implementation task; prove a real source fixture and add
first/later overflow checks before claiming it fixed. Nested loop reconstruction
in `FnGen::expr` is separate: existing RC argument naming keeps the nested
state boxed, so current fixtures do not prove that flattening path. Enabling it
also needs precise ownership for reconstructed borrowed field bindings.
Keep that work open rather than treating an unexercised path as verified.

Final dedicated general-copy check after the control/lint repair passes,
CPU 4.20 s / elapsed 8.48 s; fmt/whitespace pass. No local workload remains.
Subject `Verify typed general record copy cleanup and surviving originals`
is one line, 64 characters, empty body/no trailers. The old `b21203d` remains
an immutable anchor; this is a forward coverage commit on that published branch,
not a rewrite. The scratch reconstruction checkout has the same source and an
uncommitted duplicate test; it is not a separate published task or next PR.

General-copy coverage published as `5c5875d30b8ef0a513dd4d23d7f691b4636e35ea`;
record-update checkout is clean and no additional PR is open. Preserve OLD
`b21203d` if resuming the scratch child; create the next real conversion task
from current `5c5875d`. Its eventual squash subject remains `Retain typed
record fields and release overwritten update owners` (one line, 64 chars).

## Prepared boxed record field conversion

`ownership-record-conversion`, `/private/tmp/fwp-record-conversion-worktree`,
OLD base `5c5875d`. `FnGen::expr_fields` now protects the consumed boxed input
(or typed stack children) and remaining caller values while acquiring counted
field references. The common typed partial-retain helper releases only completed
extras if a later retain fails. Scalars have no owner slot. On success the
original scope unlinks before typed destruction and field owners transfer to
the worker. Pure/no-reuse builds omit registration; no new heap allocation or
surface syntax is introduced. Unknown type contexts remain an acceptance gap.

A real source fixture prints the whole input record, then passes it to a
recursive worker reading fields. Generated C asserts exactly one boxed scalar
field read and one two-owner partial-retain scope. Its first/later actual wide
count overflows preserve independent boxed-input and remaining-String aliases,
restore exact child counts, free unique original storage and leave scalar
address bits untouched. O1/O2, GC stress/verification, both poison modes and
ordinary interpreter/native stdout agree. Removing the original scope fails
with code 3, remaining-owner scope with 7, and partial-retain scope with 4.
Dedicated check passes, CPU 4.22 s / elapsed 8.61 s, using the bounded fwp guard
with `cargo test --test record_conversion_ownership -- --nocapture`.

All nine adjacent checks pass (record conversion, variant conversion, five
compiler caller checks and two stack-child checks), CPU 28.95 s / elapsed
58.13 s. Stack variant reclamation is 0.5 MiB versus 0.0 MiB in its control;
closure reclamation is 1.7 MiB versus 1.3 MiB. These are focused fixture counters,
not a general speed claim. Full sequential platform/benchmark CI remains
required. Next audit vlocal alias boxing and untyped aggregate contexts;
nested flattened loop reconstruction still requires an actual eligible source
fixture and precise ownership of reconstructed borrowed bindings. CAF/inline,
retained task lifetimes, teardown/cycles and later phases remain incomplete.

Library and dedicated-test clippy are warning-free, CPU 2.34 s / elapsed
4.63 s; fmt/whitespace pass. Checks used serial bounded
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py cargo ...`: `test --test record_conversion_ownership
--test variant_conversion_ownership --test compiler_call_liveness --test
stack_ownership -- --nocapture`, and `clippy --lib --test
record_conversion_ownership -- -D warnings`. Guarded package clean preceded
this checkout's build. No local workload remains; shared target contains the
record-conversion compiler, so clean the package before changing checkouts.
Prepared subject `Protect boxed record inputs and partial worker field conversion`
is one line, 63 characters, with empty body/no trailers. Published as
`614dd3b19c1340dd1f3b32f299a7ccdb51b5a7ef`; clean checkout. No additional
PR opens while #80 is pending.

## Prepared returned variant aliases

`ownership-variant-alias`, `/private/tmp/fwp-variant-alias-worktree`, OLD base
`614dd3b`. `expr_variant` transfers a named returned alias by reusing its
existing unboxed representation. Previously a nested alias expression fell
through whole-value binding, duplicated its fields, boxed it, and unboxed it
again while the source's logical owner had already been consumed. The valid
monomorphic IR regression reproduced unreleased String children (exit 3).
The fix keeps field ownership intact without an extra retain or heap box.
Evaluation order, explicit RC Dups and pipe syntax remain unchanged.

The regression checks local types, compares its value with the interpreter,
and verifies unique/shared input child counts at O1/O2 with stress/verification
and both poison modes. Generated holder code has no vbox/vunbox. Restoring an
extra typed retain makes the control fail with exit 3 at both optimization levels.
A separate source fixture returns a recursive variant worker's value through
a yield and matching alias; it remains unboxed and matches interpreter stdout
at O1/O2 in both poison modes. This source fixture was already healthy before
the change: it is adjacent coverage, not proof of the nested IR leak's source
reachability. The nested valid IR case is the direct regression evidence.

Eight adjacent checks pass (IR alias, two record/variant conversion checks and
five compiler caller checks), CPU 18.67 s / elapsed 37.54 s. Both final alias
checks pass, CPU 2.33 s / elapsed 4.86 s. The fixture first used an incorrect
concat order and omitted the holder from main's reachable graph; those test
setup errors were repaired before reproducing the native ownership leak.
Checks use the bounded fwp guard with `cargo test --test variant_alias_ownership
--test variant_conversion_ownership --test record_conversion_ownership --test
compiler_call_liveness -- --nocapture`, then the dedicated alias test. Package
clean preceded this checkout's compiler build. Full sequential platform and
benchmark gates remain required; no additional PR opens while #80 is pending.

Next address untyped field/scrutinee contexts, reconstructed borrowed records,
remaining whole-value vlocal boxing, CAF/inline lifetimes and retained task
callbacks/teardown/cycles. No complete ARC, tracing-free execution or general
speed claim is made; phases 2–6 remain incomplete.

Library and dedicated alias-test clippy are warning-free, CPU 2.35 s /
elapsed 4.63 s; fmt/whitespace pass. Lint used the bounded guard with
`cargo clippy --lib --test variant_alias_ownership -- -D warnings`.
No local workload remains; shared target contains the variant-alias compiler.
Prepared subject `Transfer returned variant aliases without boxing or extra retains`
is one line, 65 characters, empty body/no trailers. Publication follows these
checks; preserve OLD `614dd3b` and the forthcoming alias head as rebase anchors.

Variant-alias code published as `2163857a303b414ee097103e5ff75a7d8ce3aed5`,
followed by the plan-only forward commit `de8562194d5461b69e6e5f3b448df0bfc1bee687`.
Both subjects are single lines under 80 characters with no body/trailers.
The future squash subject is `Transfer returned variant aliases without boxing
or extra retains` (one line, 65 characters). Create the next task from OLD
`de85621`. No source workload remains. Removed only the obsolete untracked
duplicate fixture from the scratch reconstruction checkout after its final
copy was published on record-update; scratch checkout is now clean.

Rebased stack ownership and concrete temporary checks all pass (4 tests),
CPU 12.51 s / elapsed 25.24 s; guarded package clean preceded the rebuild.
Variant/closure stack child frees are 0.5/1.7 MiB versus 0.0/1.3 MiB in controls;
temporary child frees are 0.5 MiB versus 0.0 MiB. Formatting/whitespace pass.
Use `env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py cargo test --test stack_ownership --test
temporary_ownership -- --nocapture` for this focused check. The subject
`Retain and release typed children of nonescaping stack values` is one line,
61 characters, empty body/no trailers. Preserve OLD `b563360` for the borrowed
callback child; its later rebase must not use this rewritten stack head.
No local workload remains; shared target currently contains the stack compiler.

## Prepared nominal match context

`ownership-match-context`, `/private/tmp/fwp-typed-expression-worktree`, OLD
base `de85621`. The optimizer previously removed a typed binding before matching
a bare aggregate. Discarded effectful nested constructors then had unknown
ownership locals, so their children could remain live. The regression reproduced
`?` locals after optimization and RC insertion. Known-constructor elimination
now inherits the checked binding's nominal field types when it must evaluate
a discarded field. It keeps a typed binding when elimination cannot recover
the scrutinee's type. Existing trivial-record match elimination remains enabled.
No new IR annotation node, surface syntax or runtime allocation is introduced.

Two dedicated checks cover typed IR and real source. They compare interpreter
and native values, prove the outer matched value has no heap allocation, and
check that a freshly repeated String child is destroyed while external input
aliases survive. Erasing the retained nominal field type makes the control fail
with exit 3. O1/O2, GC stress/verification and both poison modes pass. Five focused
match/alias/constructor checks pass, CPU 8.06 s / elapsed 16.35 s. Selected
case_of_case, unboxed_records and variant_returns goldens agree exactly with
the interpreter, including stdout/stderr/exit and both poison modes at O2,
CPU 3.11 s / elapsed 6.42 s. This is selected semantic evidence, not a full gate
or speed claim. Full sequential architecture/benchmark CI remains required.

Library and dedicated-test clippy pass without warnings, CPU 2.34 s / elapsed
4.64 s; fmt/whitespace pass. Checks used the serial bounded fwp guard with
`cargo test --test match_context_ownership --test variant_alias_ownership --test
constructor_type_ownership -- --nocapture`, `cargo clippy --lib --test
match_context_ownership -- -D warnings`, and
`python3 /private/tmp/fwp-match-context-goldens.py`. Package clean and rebuild
preceded checks after switching from the stack checkout. No local workload
remains; shared target contains the match-context compiler.

PR #80 is merged and sole PR #81 is now in full CI `37696063781` for exact
`6eeb915`. This context change remains separate. Prepared squash subject
`Preserve nominal match context for discarded constructor fields` is one line,
63 characters, empty body/no trailers. Next audit remaining field-result
contexts, reconstructed borrowed fields, whole-value boxing, CAF/inline owners
and retained task lifetimes/teardown/cycles. Phases 2–6 remain incomplete.

Match context published as `3f61f51521d95527d6754c2e6c3ca01a31f64bd7`;
checkout is clean, subject verified as one line, 63 characters, empty body and
no trailers. No additional PR is open; #81 remains the sole exact-head gate.
Create the next prepared task from OLD `3f61f51`. Preserve OLD `b563360` for
the immediate borrowed-callback rebase after #81 eventually merges.

## Prepared typed record projection

`ownership-field-context`, `/private/tmp/fwp-field-context-worktree`, OLD base
`3f61f51521d95527d6754c2e6c3ca01a31f64bd7`. Inlining a checked record-producing
call under a projection erased its nominal base type. The valid IR regression
reproduced three unknown RC locals, an inappropriate generic scalar retain and
a live discarded nested String child (native exit 3). The optimizer now keeps
the pre-inlining base type in a typed binding when the optimized expression no
longer exposes a type. Existing scalar replacement gives each field its checked
type without allocating the projected outer record. Field evaluation order is
preserved. No inferred nominal labels, IR annotation or surface syntax is added.

Two dedicated tests cover the failing IR shape and representative source
behavior. Interpreter/native results agree; fresh discarded String children are
dead, unique inputs release, and external input aliases survive with count 1.
Erasing only the nested field type makes the negative control leak at O1/O2.
Both optimization levels, GC stress/verification and both poison modes pass.
The source fixture supplies differential coverage; source reachability of the
specific failing IR shape is not claimed. Seven focused projection/match/alias/
constructor checks pass, CPU 9.77 s / elapsed 19.74 s. Five selected goldens
(case_of_case, unboxed_records, variant_returns, wide_records, loop_nested_state)
agree exactly on stdout/stderr/exit at O2 in both poison modes, including the
intentional trap, CPU 5.20 s / elapsed 10.65 s. Full sequential CI remains required.

Library and dedicated-test clippy pass, CPU 2.34 s / elapsed 4.64 s. Formatting
passes under the bounded guard (CPU 0.34 s / elapsed 0.60 s). Checks used
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py cargo test --test field_context_ownership --test
match_context_ownership --test constructor_type_ownership --test
variant_alias_ownership -- --nocapture`, the corresponding `cargo clippy --lib
--test field_context_ownership -- -D warnings`, and
`python3 /private/tmp/fwp-field-context-goldens.py`. Guarded package clean preceded
the worktree switch/build. No workload remains; shared target contains this
projection compiler. Bare projections with no checked base metadata,
reconstructed borrowed records, remaining whole-value boxing, CAF/inline
lifetimes and retained task lifetimes/teardown/cycles remain open. Phases 2–6
remain incomplete; no general ARC, tracing-free or speed claim is made.

PR #81 is the sole open PR, exact `6eeb915`, full CI `37696063781`; benchmark
passed and all three architecture test jobs are running. Prepare this branch
separately. Future squash subject `Preserve checked record types across inlined field projections`
is one line, 62 characters, empty body/no trailers. Publication follows checks.

Projection context published as `085dc716d5994681b998f13cd619b139794539fc`;
checkout clean and subject verified as one line, 62 characters, no body/trailers.
Latest CI snapshot for sole PR #81: benchmark passed; Linux, ARM macOS and Intel
macOS test jobs in progress at exact `6eeb915`. Failing tests remain repair tasks;
no failure is reported by this snapshot. Preserve OLD `b563360` for the immediate
borrowed-callback child and OLD `085dc71` for later preparation. Full CI gates
merging only. Continue aggregate reconstruction/boxing and then runtime lifetime
coverage while the current gate runs. Final fmt check passed, CPU 0.35 s /
elapsed 0.63 s; all checks serial and bounded, no resource refusal.

## Prepared counted CAF caches

`ownership-caf-cache`, `/private/tmp/fwp-caf-ownership-worktree`, OLD base
`085dc716d5994681b998f13cd619b139794539fc`. CAFs previously recursively shared
cached results, discarding their counts. A native count probe failed with exit 1.
Counted CAFs now hold one typed cache owner and return a retained owner per call.
Scalar CAFs avoid generic share/retain operations even for pointer-looking words.
Initialization remains lazy and memoized; failure leaves it retryable. If
initialization reenters, replacing the earlier cached result releases that cache
owner while preserving already returned references. This is valid IR/runtime
coverage, not a claim of a newly reachable source reentrancy shape.

RC now names CAF results in borrowed/consumed argument preparation, preserving
evaluation order and giving borrowed calls a temporary to release. CAF evaluation
also records caller liveness and generates a cleanup scope when unwind is enabled.
A source test initially exposed the missing temporary, and its corrected case
reclaims the cache. A separate trapping source fixture, with task support enabled,
releases unique caller inputs and preserves external aliases; removing only the
CAF caller scope makes the control fail with exit 4. Initialization-failure retry,
actual SIZE_MAX retain overflow and cleanup boundaries pass. Cache aliases and a
record containing two aliases of the same String have exact reference counts.

Executables release the counted main result after tasks finish, then clear and
release counted CAF caches by type. Both cleanup stages have failing controls:
omitting root release leaves the child alive (exit 3); omitting cache teardown
fails with exits 3/9. Missing returned retain fails with exit 11; removing replaced
cache release fails with exit 12. Teardown is idempotent. All three CAF tests pass
at O1/O2, with GC stress/verification and both poison modes; source stdout/stderr/
exit agrees with the interpreter, including initialization and trapping behavior.
Native library caches retain their loaded-program lifetime; host/unload teardown
and shared runtime graphs remain acceptance gaps. No public interface is added.

Seventeen RC unit checks pass, guarded CPU 3.28 s / elapsed 6.99 s. Ten focused
CAF/caller/projection checks pass, CPU 23.50 s / elapsed 47.09 s. Final CAF controls
pass (3 tests), CPU 4.10 s / elapsed 9.53 s. The shared-library C interop smoke
check passes, CPU 0.80 s / elapsed 2.32 s. Four selected opt_constant_order,
effects, unboxed_records and variant_returns goldens agree exactly on stdout/
stderr/exit at O2 in both poison modes, CPU 4.03 s / elapsed 8.18 s. Full sequential
Linux/ARM macOS/Intel macOS/benchmark CI remains required before merging.

All local checks used the serial bounded fwp guard with the shared target.
Commands: `cargo test --lib rc::tests -- --nocapture`, `cargo test --test
caf_ownership --test compiler_call_liveness --test field_context_ownership --
--nocapture`, `cargo test --test caf_ownership -- --nocapture`, `cargo test --test
ffi shared_library_from_c -- --nocapture`, and
`python3 /private/tmp/fwp-caf-goldens.py`. An initial invocation named nonexistent
`call_liveness`; corrected to `compiler_call_liveness` before the successful run.
The 2,000-task tasks_local interpreter workload was explicitly stopped and moved
to full CI; it is not locally verified. At inspection it used 72 MiB RSS and
38.32 s CPU after 75 s elapsed; no resource limit was raised or bypassed. The
four smaller goldens above were then run serially. Package clean preceded the
checkout switch. No local workload remains; shared target contains this CAF
compiler. Remaining work includes reconstructed nested state, untyped contexts,
whole-value variant boxing, inline lifetimes, retained task teardown/cycles and
library lifetime coverage. Phase 2 and later roadmap phases remain incomplete.

PR #81 remains the sole open PR, exact `6eeb915`, full CI `37696063781`;
benchmarks passed, all three architecture test jobs running. Failing tests remain
repair tasks; CI gates merging only. This prepared change stays separate.
Prepared squash subject `Own cached CAF results and release executable cache owners`
is one line, 58 characters, empty body/no trailers. Publication follows checks.

CAF library/dedicated-test clippy is warning-free after replacing the fixture's
post-default field assignments with a Program initializer. Guarded lint command:
`cargo clippy --lib --test caf_ownership -- -D warnings`, CPU 0.00 s / elapsed
0.14 s (cached library checking from the prior run). Final CAF tests pass after
that fixture edit, CPU 4.18 s / elapsed 10.91 s. Formatting and whitespace pass;
no unresolved focused-test failure remains. The large task fixture remains for
full CI, not a passing local check. Latest run `37696063781` still has passing
benchmarks and live architecture test jobs at exact `6eeb915`; do not restart it
for observation delays or open another PR before #81 merges.

CAF ownership published as `68cf7bf2f7ca0986edf7039ff2e0bfe584e45820`;
clean checkout and verified one-line, 58-character subject with no body/trailers.
Final formatting check passes, CPU 0.35 s / elapsed 0.75 s. No local workload
remains. Preserve OLD `68cf7bf` for subsequent separate preparation and OLD
`b563360` for the immediate borrowed-callback rebase after PR #81 passes all four
exact-head gates and squash-merges. Runtime shared graphs, library/unload
lifetimes, nested reconstruction and retained tasks remain unfinished work.

## Prepared CAF evaluation during inlining

`ownership-inline-caf`, `/private/tmp/fwp-inline-caf-worktree`, OLD base
`68cf7bf2f7ca0986edf7039ff2e0bfe584e45820`. The optimizer classified every Func
as trivial, including zero-argument CAFs whose evaluation can allocate or trap.
Inlining a callee that ignored such an argument skipped the CAF. A real source
regression printed 17 and exited 0 instead of raising division by zero with exit
101. The ordinary optimized interpreter also skipped the trap; its pipeline uses
the same optimizer, so the reference must disable that pass. This was reproduced
before the fix, not inferred only from IR shape.

Only positive-arity static function references remain trivial. CAF arguments now
keep a checked evaluation binding before entering the inlined callee. Existing RC
then releases an ignored counted result; no heap object or surface syntax is added
by the binding. Three source cases cover ignored scalar and String CAF arguments
and the order between an earlier CAF trap and the callee's later integer overflow.
Unoptimized interpreter (`FWP_NO_OPT=1`), optimized interpreter and native O1/O2
agree exactly on stdout/stderr/exit in both poison modes with GC stress/verification.
A mistaken initial negative-repeat fixture was corrected: string.repeat clamps
negative counts to zero, so it was not a trapping reference.

A successful String CAF regression proves one evaluation, count 1 before cache
teardown (only the cache owns it), and destruction after executable cleanup.
Removing only the ignored argument's typed release leaves an extra owner and
makes the control fail with exit 4 at O1/O2. The two new tests and three adjacent
CAF ownership tests pass, guarded CPU 10.47 s / elapsed 21.53 s. Four selected
opt_constant_order, case_of_case, unboxed_records and variant_returns goldens
agree exactly on stdout/stderr/exit at O2 in both poison modes, CPU 4.13 s /
elapsed 8.42 s. Library/dedicated-test clippy passes, CPU 2.42 s / elapsed 4.84 s;
formatting passes, CPU 0.36 s / elapsed 0.75 s. Full sequential CI remains required.
CONTRIBUTING now requires an unoptimized IR/interpreter reference for optimizer
changes, because agreement between optimized engines can miss a common bug.

All local checks were serial and bounded through
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py`: `cargo test --test inline_caf_ownership --test
caf_ownership -- --nocapture`, `cargo clippy --lib --test inline_caf_ownership --
-D warnings`, and `python3 /private/tmp/fwp-inline-caf-goldens.py`. Guarded package
clean preceded switching from the CAF checkout. No resource refusal or local
workload remains; shared target contains this inlining compiler. Remaining work
includes aggregate reconstruction/metadata, whole-value variant boxing, other
inline lifetime cases, retained task teardown/cycles and library/unload coverage.
Phases 2–6 remain incomplete; no general ARC, tracing-free or speed claim is made.

PR #81 remains the sole open PR, exact `6eeb915`, CI `37696063781`: Linux, ARM macOS and
benchmarks passed; Intel macOS tests running. CI gates merging only;
repair failures and continue separate preparation. Prepared squash subject
`Preserve CAF argument evaluation and ownership during inlining` is one line,
62 characters, empty body/no trailers. Publish after checks; preserve OLD
`68cf7bf` for this child and OLD `b563360` for the immediate borrowed-callback
rebase after #81 merges. No second PR opens while that current gate is pending.

CAF inlining published as `6734248e7c0d4d53d57e5acccb9af02641713e9d`;
checkout clean, subject verified as one line, 62 characters, no body/trailers.
Final formatting check passes (CPU 0.44 s / elapsed 0.86 s), whitespace clean.
PR #81 full run `37696063781` has passing Linux, ARM macOS and benchmark gates;
Intel macOS tests are live at exact `6eeb915`. Continue separate ownership
work, fixing any failure; merge only after all four gates pass. Preserve OLD
`b563360` for borrowed-callback rebasing and OLD `6734248` for subsequent work.
No local workload remains. Phases 2–6 remain incomplete.

## Prepared retained task thunks

Branch `ownership-task-thunks`, checkout `/private/tmp/fwp-retained-thunk-worktree`,
OLD base `6734248e7c0d4d53d57e5acccb9af02641713e9d`. task.spawn borrows its
callback and the runtime retains one counted closure reference. Task entry
transfers it to owned application; cancellation before entry releases it.
Typed captures release on completion and cancellation while suspended. Unknown
owned-entry metadata preserves the conservative shared fallback. The callback
still escapes, so this contract grants no stack-allocation permission.

Spawn reserves scope storage and prepares its stack before publishing a child.
Recoverable stack mapping failure previously left a partial child linked to its
parent; the repaired path leaves parent/scope/GC task lists unchanged and
releases only the extra thunk owner. Scope capacity and count overflow likewise
preserve original aliases. Actual allocator OOM remains fatal; no recoverable
allocator-OOM claim is made. Task handles and counted results still share.
Result type metadata keeps address-shaped scalar words out of generic sharing.

Two dedicated tests compare real source behavior with an unoptimized interpreter
and probe generated C at O1/O2 with GC stress/verification and both poison modes.
They cover normal completion, pre-entry and suspended cancellation, external
capture aliases, scalar address bits, unknown metadata, stack failure, scope
capacity overflow and retain-count overflow. Negative controls restoring early
child publication and removing the extra-owner scope fail with exits 2 and 4.
The pre-fix compiler failed the counted-closure probe with exit 1.

Serial guarded checks (same bounded fwp guard as above):
- `cargo test --test retained_thunk_ownership --test task_ownership -- --nocapture`:
  five pass, CPU 12.65 s / elapsed 25.50 s.
- `cargo test --test closure_ownership --test unwind_cleanup -- --nocapture`:
  five pass, CPU 13.73 s / elapsed 27.72 s; closure counts free 1.2 MiB versus 0.
- `cargo test --lib ownership::tests -- --nocapture`: one inventory check passes,
  CPU 3.23 s / elapsed 6.70 s; spawned callbacks remain marked escaping.
- Final two dedicated tests, including unknown metadata: pass, CPU 9.35 s /
  elapsed 19.49 s.

Full sequential CI remains required. Remaining tasks include task.within/scope
callback ownership, task results/handles and channel teardown/cycles, aggregate
reconstruction/metadata, whole-value variant boxing and library/unload lifetimes.
Phases 2–6 remain incomplete. PR #81 is the sole open PR, exact `6eeb915`, CI
`37696063781`: Linux, ARM macOS and benchmarks passed; Intel macOS is running.
After all four pass, squash with the recorded subject and empty body, rebase
borrowed callbacks from OLD `b563360` onto the new squash, then open the next PR.
Continue separate implementation while CI runs; repair any failure. Preserve
OLD `6734248` for this branch and its published head for its future child.

Retained-thunk library/dedicated-test clippy passes, CPU 2.31 s / elapsed 4.61 s.
Six adjacent escape-analysis checks pass, CPU 0.00 s / elapsed 0.14 s. No focused
failure remains; no resource limits were raised or bypassed. The shared target
contains this compiler; guarded package clean is required before switching.
Final formatting/whitespace pass, CPU 0.36 s / elapsed 0.73 s.

Retained task-thunk preparation published as
`7208e4a2d93e7e0402dee4d7f4783fe185565d74`, OLD base `6734248`.
Commit subject verified as one line, 63 characters, empty body/no trailers.
No second PR opened; #81 remains sole open. Next preparation: extend the counted
callback boundary to task.within, including deadline cancellation and failures.

## Prepared retained deadline callbacks

`ownership-task-within`, `/private/tmp/fwp-task-within-worktree`, OLD base
`7208e4a2d93e7e0402dee4d7f4783fe185565d74`. task.within now borrows the
callback and uses the same retained-owner preparation as task.spawn, with its
deadline preserved. Result metadata avoids sharing scalar address bits; counted
results remain shared and the Option outer remains owned. Unknown callback
metadata preserves the shared fallback. Escape analysis still treats it as
retained. task.scope, channels, result/handle teardown and cycles remain open.

A source/generated-C regression checks successful execution and immediate
deadline cancellation, original callback owners and external capture aliases.
The initial C fixture erroneously passed a scalar Duration and crashed; fixed to
construct the boxed current ABI value, it reproduced the pre-fix count failure
with exit 1. After the fix, O1/O2, both poison modes and GC stress/verification
pass; native stdout/stderr/exit match an unoptimized interpreter. Restoring the
legacy shared callback path makes the negative control fail with exit 1.
The parent spawn preparation controls were updated to target the factored helper
and still fail with their expected exits.

Serial bounded checks after guarded package clean:
- `cargo test --test within_thunk_ownership --test retained_thunk_ownership --
  --nocapture`: three pass, CPU 11.52 s / elapsed 23.51 s.
- `cargo test --test within_thunk_ownership --test task_ownership -- --nocapture`:
  four pass, including final negative control, CPU 5.47 s / elapsed 11.31 s.

Full sequential CI is required. #81 remains sole open PR, exact `6eeb915`, run
`37696063781`; Linux, ARM macOS and benchmarks passed, Intel macOS is live.
Fix any failure and continue separate preparation. After all four pass, use the
recorded subject/empty body and exact-head squash, then rebase borrowed callbacks
from OLD `b563360`. Next implementation: task.scope callback ownership and
scope result protection across joining/cancellation. Preserve OLD `7208e4a` for
this child and its published head for the next child. Phases 2–6 remain open.

PR #81 passed all four gates and merged as `a4b6533`; previous pending-CI
entries are historical. Immediate next action: publish borrowed callbacks after
rebasing from OLD `b563360` and focused validation, then open the sole next PR.
Deadline ownership remains separate prepared work, awaiting publication.

Deadline library/dedicated-test clippy passes, CPU 2.35 s / elapsed 4.71 s.
Formatting/whitespace pass, CPU 0.37 s / elapsed 0.76 s. No focused failures or
local resource-limit refusals remain. Full sequential CI and inventory execution
after the added deadline assertion remain required; don't count clippy as a test.
Shared target switched to borrowed-callback validation after guarded package clean.

Deadline callback preparation published as
`14a76de5b8bbbf4e23a06b547ebaf374b931b20e`, OLD base `7208e4a`.
Verified one-line, 67-character subject, empty body/no trailers. No additional PR.
Borrowed callbacks rebased from OLD `b563360` onto merged `a4b6533`; only handoff
conflicts were reconciled with current root docs. After guarded package clean,
`cargo test --test borrowed_callbacks --test stack_ownership -- --nocapture`
passes all three checks, CPU 10.18 s / elapsed 20.84 s. Stack child count frees
0.5 MiB vs 0 for variants and 1.7 vs 1.3 MiB for closures. Shared target now
contains the borrowed-callback compiler. Preserve OLD `029fac4` for map child
rebasing; publish with exact lease and open the sole next PR, full CI required.

Sole open [PR #82](https://github.com/e6qu/fun-with-pipes/pull/82): borrowed
callbacks, published exact `3fa67f3a8548a3e5605d15723ad74c95b6fdda00`.
Verified one-line, 56-character subject `Add typed borrowed application for
synchronous callbacks` (supplied as one line), empty body/no trailers. Rebase
checkout clean; formatting passes CPU 0.36 s / elapsed 0.74 s. Full exact-head
CI is newly requested; queued/unlisted is not passing. Merge only after Linux,
ARM macOS, Intel macOS and benchmarks all pass, with the above subject, empty
body and exact-head match. Then rebase map from OLD `029fac4` onto that squash;
preserve OLD `41ef82d` for filter. Current root main remains `a4b6533`; only root
PLAN/handoff are dirty. No local workload remains; shared target is callback
compiler. Latest prepared deadline branch is clean/published `14a76de`, OLD base
`7208e4a`; next implementation is task.scope callback/result unwind ownership.
Continue while CI runs and fix any failures. Phases 2–6 remain incomplete.
PR #82 full CI is [run 37703018710](https://github.com/e6qu/fun-with-pipes/actions/runs/37703018710),
queued at exact `3fa67f3`. Observe this run; do not restart a live job merely
for observation. No failure reported at handoff.

## Prepared scoped callback ownership

`ownership-task-scope`, `/private/tmp/fwp-task-scope-worktree`, OLD base
`14a76de5b8bbbf4e23a06b547ebaf374b931b20e`. task.scope now borrows its
synchronous callback and receives a typed owned result. Owned callback entry
metadata retains only typed captures/arguments; unknown metadata keeps the
shared fallback. Scope state and its task array have an unwind owner, including
restoration of the previous handler on an external recovered trap. A separate
typed result owner protects the value across child joins and final cancellation.
Normal return transfers it without an extra retain. Scalar address bits are
uncounted. The callback itself does not escape; captured returned values still
carry their own references. Pipe syntax, effects and evaluation order are unchanged.

The corrected pre-fix source/generated-C fixture failed capture-count checks
with exit 1. During test development, the probe incorrectly used rc_last as a
release; corrected to rc_release_last (which decrements nonlast counts). This
fixture error is not recorded as a compiler regression. The fixed probe covers
external capture aliases, returned aliases, scalar address bits and unknown
callback metadata. It cancels real worker tasks before callback entry and after
result production, with a child registered in the scope, and recovers an external
trap before callback entry. Scope task arrays are freed once, task scope pointers
are restored and captures are destroyed; the scope's stack handler cannot survive
a recovered trap. Probes use O1/O2, GC stress/verification and both poison modes.
Real source stdout/stderr/exit agree with an unoptimized interpreter.

Bounded serial checks after guarded package clean:
- Scope plus three adjacent unwind tests pass, CPU 5.19 s / elapsed 10.55 s.
- Seven scope/spawn/deadline/task ownership tests pass, CPU 18.32 s / elapsed
  36.93 s; existing deadline count evidence remains 0.5 MiB versus zero.
- Scope with the recovered-trap and handler restoration changes passes,
  CPU 9.77 s / elapsed 19.82 s.

Full sequential CI remains required. Task handles and spawned results still
share; task/channel result teardown, cycles, aggregate reconstruction/metadata
and library/unload coverage remain unfinished. Phases 2–6 remain open. Sole
PR #82 exact `3fa67f3`, run `37703018710`, currently has both macOS jobs live
and Linux/bench queued. Merge only after all four pass, with the recorded subject
and empty body. Rebase the map child from OLD `029fac4` onto that squash. Next
implementation: precise task-result/handle lifetime contracts before channel
queue ownership. Preserve OLD `14a76de` for this branch's future rebase.

The complete contract inventory passes, including the previously pending
deadline assertion and the new scoped callback contract: guarded
`cargo test --lib ownership::tests -- --nocapture`, CPU 4.02 s / elapsed 8.27 s.
The final recovered-handler omission control fails with exit 4; removing result
cleanup fails with 5 and scope-array cleanup with 6, each at O1/O2. Scope checks
pass after adding those controls, CPU 3.37 s / elapsed 6.96 s. The added real
source child-joining case passes too, CPU 3.66 s / elapsed 8.09 s. Formatting
passes, CPU 0.47 s / elapsed 0.86 s. Clippy found a needless borrow in the new
result-type lookup; corrected before rerunning lint. Full CI still required.
All local commands used the bounded fwp guard, serial and low priority; none
refused for resource limits. No limits were raised. The shared target is this
scoped callback compiler; clean the package before switching checkouts.

Final library/dedicated-test clippy passes, CPU 2.76 s / elapsed 5.48 s.
No focused failures remain. Exact guarded commands included `cargo test --test
scope_thunk_ownership --test retained_thunk_ownership --test within_thunk_ownership
--test task_ownership -- --nocapture`, `cargo test --test scope_thunk_ownership
--test unwind_cleanup -- --nocapture`, `cargo clippy --lib --test
scope_thunk_ownership -- -D warnings`, and `cargo fmt --all -- --check`.

Scoped callback preparation published as
`7da15d9c8ea330bea4f876f797038627720c4c38`, OLD base `14a76de`.
Verified one-line, 59-character subject `Own scoped callback results and unwind
scope storage safely` (supplied as one line), empty body/no trailers. Checkout
clean; final formatting check CPU 0.66 s / elapsed 1.32 s. No second PR opened.
PR #82 remains sole open, both macOS jobs live, Linux/bench queued in the same
run `37703018710` at exact `3fa67f3`; do not restart for observation. Root only
PLAN/handoff dirty; no local workload remains.

Next task-result audit found opaque runtime lifetimes need compiler integration:
rc::needs_rc currently counts records/ADTs, containers, text and functions, with
no explicit Task/Channel case; Gen::drop_body has no task destructor. A precise
task handle needs independent scheduler, external handle and scope-array owners.
Scheduler release must wait until fwp_free_zombie has returned/unmapped the stack
and unlinked GC task roots; a scope array must retain done tasks until its join
completes. Typed await must duplicate the cached result into each Option, and
last handle destruction must release the task's result. Task.within needs its
private handle released on success/failure. Unknown/shared runtime boundaries
retain a conservative fallback; cycles remain separate acceptance work. Build
focused alias/repeated-await/early-handle-drop/cancellation and scalar-bit probes
before changing those contracts. Preserve OLD `7da15d9` for the next child.

## Prepared counted task handles and results

Branch `ownership-task-handles`, checkout `/private/tmp/fwp-task-handle-worktree`,
OLD base `7da15d9c8ea330bea4f876f797038627720c4c38`. Task is now a counted
builtin type with a runtime destructor. Known owned callbacks produce counted
task storage, one scheduler owner and one external handle owner; scope task
arrays retain another owner. Scheduler release happens only after the finished
stack is returned/unmapped and GC task links are removed. Last handle release
destroys the cached typed result and private state storage. Finished child links
are cleared so they cannot keep stale borrowed parent/sibling pointers.

Await borrows the task and returns an owned Option with its own typed result
reference, independent of other awaits and the cache. Partial Option ownership
is protected while result retention can overflow. task.within protects its
private handle during waiting and releases it on success and failure. task.cancel
borrows its handle. Scalar address bits receive neither result duplication nor
generic sharing. Task storage remains mutable kind 2 for minor-collection scans;
poisoning uses mutable storage cleanup, never a record-header interpretation of
its context registers. Only one result-drop callback pointer is stored per task.
Unknown callback metadata and unmodeled runtime sharing retain the tracing
fallback. Channels, cycles and library/unload acceptance remain unfinished.

The corrected baseline count probe failed with exit 1: there was no counted task
handle. An initial function-ID prefix accidentally matched a runtime comment;
corrected to the generated signature marker before recording that reproduction.
Source/generated-C checks cover handle aliases, independent repeated awaits,
last cached-result destruction, early external-handle drops, scope retention
after task completion, pre-entry and suspended cancellation, old-task/young-result
minor collection, overflowing await result retention and private deadline-handle
cleanup. Native stdout/stderr/exit are compared with an unoptimized interpreter.
GC stress/verification and O1/O2 in both poison modes pass for completed probes.

Negative controls remove result retain (exit 2), cached result destruction (6),
scheduler release (3), scope retain (11), partial Option protection (17) and
private deadline-handle protection (20), at both optimization levels. The await
overflow preserves the original wide cache count and task handle, releasing only
the fresh Option. The private-handle failure preserves the caller's callback
and capture owner while releasing the cached extra reference.

Serial bounded local checks after package clean:
- Initial independent-handle probe passes, CPU 8.08 s / elapsed 16.32 s.
- Three task-handle/scope/deadline tests pass, CPU 14.70 s / elapsed 30.34 s.
- Eight adjacent spawn/task/unwind tests pass, CPU 16.15 s / elapsed 32.57 s.
- Dedicated failure controls pass, CPU 10.67 s / elapsed 22.25 s.
- Added minor-collection result probe passes, CPU 4.38 s / elapsed 9.59 s.
- Ownership inventory passes, CPU 3.26 s / elapsed 6.67 s; 17 RC checks pass,
  CPU 0.00 s / elapsed 0.13 s.

Full sequential CI remains required. Sole PR #82 exact `3fa67f3`, run
`37703018710`: benchmark passed; Linux and both macOS test jobs are live.
Merge only after all four current-head gates pass with the recorded one-line
subject and empty body, then rebase map from OLD `029fac4`. Next implementation:
channel queue and handle ownership, including typed send/receive/cancellation
and closed/drained queues; finish task/runtime cycles and library evidence
before phase 2 acceptance. Preserve OLD `7da15d9` for this branch's rebase.

Final dedicated task-result checks, including explicit sharing fallback, pass
(CPU 4.15 s / elapsed 9.12 s). Library and three affected test targets pass
clippy after formatting (CPU 2.32 s / elapsed 4.80 s); fmt CPU 0.34 s / elapsed
0.61 s, whitespace clean. Commands used the bounded guard: `cargo test --test
task_handle_ownership -- --nocapture`, `cargo test --test task_handle_ownership
--test scope_thunk_ownership --test within_thunk_ownership -- --nocapture`,
`cargo test --test retained_thunk_ownership --test task_ownership --test
unwind_cleanup -- --nocapture`, `cargo test --lib ownership::tests -- --nocapture`,
`cargo test --lib rc::tests -- --nocapture`, and `cargo clippy --lib --test
task_handle_ownership --test retained_thunk_ownership --test
within_thunk_ownership -- -D warnings`. No resource limits were raised/bypassed,
no focused failure remains. Shared target contains this task-handle compiler.
Full sequential CI is still required; phase 2 and phases 3–6 remain incomplete.

Task handle/result preparation published as
`bb6f9c49a0434afc9f7dd1fb9891a6fa8fb32a8a`, OLD base `7da15d9`.
Commit subject verified as one line, 67 characters, empty body/no trailers.
Final formatting check CPU 0.36 s / elapsed 0.72 s; checkout clean. No second
PR opened. Sole #82 CI `37703018710` has passing benchmarks and live Linux/ARM/Intel
macOS tests at exact `3fa67f3`; continue the same run and fix failures. No local
workload remains; shared target is the counted-task compiler.

Next channel work requires compiler counting/destruction for Channel[T], typed
queue element metadata, borrowed send/recv/close boundaries, an owner per queued
value, and transfer from dequeue to a protected owned Option. Sends blocked on
capacity must retain no queue reference until enqueue succeeds; closed sends
and cancelled waiters must release only their own references. Channel callers
keep the handle alive while parked, and wait links must be removed before last
handle destruction. Unknown C/runtime channels and sink callbacks need the
sharing fallback; scalar address bits must avoid generic count/share operations.
Add probes for queue/caller aliases, multiple receives, close/drain/destruction,
bounded-send and receive cancellation, growth and generation/root safety before
changing these contracts. Preserve OLD `bb6f9c4` for the next child branch.

## Prepared counted channels and queue elements

`ownership-channel-queues`, `/private/tmp/fwp-channel-queue-worktree`, OLD base
`bb6f9c49a0434afc9f7dd1fb9891a6fa8fb32a8a`. Channel is now a counted builtin
with typed queue duplicate/drop metadata and a runtime destructor. Send, receive,
timed receive and close borrow the handle. Enqueue retains one typed element
reference only after capacity is available; closed/blocked sends retain none.
Receive allocates its owned Option before removing the queue reference, then
transfers that reference without duplication. Last handle release destroys queued
elements and buffer storage. Parked compiled callers hold a handle owner, and
wait links clear before cancellation cleanup can destroy the last reference.
Scalar address bits receive no count/share/destruction operation. Unknown C
channels, promoted handles and sink callbacks retain the tracing fallback.

The pre-fix native probe failed with exit 1 (no counted channel handle). O1/O2
probes in both poison modes with GC stress/verification cover growth across the
initial capacity, caller/queue/receive aliases, closed sends, last handle queue
destruction, blocked send/receive cancellation and close, including early
external-handle drop while a worker waits. Queue function captures and task
cache descendants release correctly; an old channel/buffer roots young queued
elements through minor collection. Shared/C-channel and sink fallback behavior
is checked without counting scalar words. Native source stdout/stderr/exit
agree with an unoptimized interpreter. A function-valued fixture initially used
a pipe/Async scope context incorrectly; corrected to `option.map (apply ())`,
without changing syntax/type/effect semantics.

Wide retain overflow acquires no queue owner and preserves the caller. A forced
receive allocation trap leaves the element and queue owner intact, and retry
succeeds. This is an injected preparation failure, not a recoverable allocator
OOM claim. Controls removing queue retain/drop fail with 2/6; adding an extra
receive retain fails with 4; removing before allocation fails with 26. A control
initially targeted the old allocator expression after instrumentation; corrected
and all controls now assert they changed the generated runtime. An adjacent
task test likewise used the former receive helper name; its lookup is updated
to the scalar owned helper, retaining its count invariant checks.

Serial bounded checks after package clean:
- Initial queue probe passes, CPU 7.98 s / elapsed 16.37 s.
- Channel and task-handle probes pass in a group where the adjacent helper-name
  lookup failed; the failure was repaired, not skipped.
- Four final channel/task ownership tests pass, CPU 6.25 s / elapsed 12.67 s.
- Added function/task/generation/fallback probes pass, CPU 4.32 s / elapsed 8.80 s.

Full sequential CI remains required. Sole PR #82 exact `3fa67f3`, CI
`37703018710`: ARM macOS and benchmarks passed, Linux/Intel macOS tests live.
Merge only after all four pass with the recorded subject and empty body, then
rebase map from OLD `029fac4` onto that squash. Next acceptance work: runtime
cycles and library/unknown retained lifetime coverage, plus remaining aggregate
reconstruction/metadata gaps before phase 2 closes. Phases 2–6 remain incomplete.
Preserve OLD `bb6f9c4` for this branch's rebase and its published head for its child.

Final four channel/unwind tests pass, including timed receive checks, CPU
14.17 s / elapsed 28.63 s. Complete contract inventory (including all channel
borrow/result assertions) passes, CPU 3.26 s / elapsed 6.80 s. Library and both
affected test targets pass clippy, CPU 2.23 s / elapsed 4.63 s. Formatting passes,
CPU 0.34 s / elapsed 0.61 s; whitespace clean. Exact bounded commands included
`cargo test --test channel_queue_ownership --test task_ownership -- --nocapture`,
`cargo test --test channel_queue_ownership --test unwind_cleanup -- --nocapture`,
`cargo test --lib ownership::tests -- --nocapture`, and `cargo clippy --lib
--test channel_queue_ownership --test task_ownership -- -D warnings`. No resource
limits were raised/bypassed; no focused failure remains. Shared target contains
this channel compiler; package clean is required before checkout changes.

Channel ownership preparation published as
`ab44b7de0812eb1f84d5430a303cd61ddd026219`, OLD base `bb6f9c4`.
Verified one-line, 72-character subject `Own typed channel queues and transfer
receive references without sharing` (supplied as one line), empty body/no trailers.
Checkout clean; final formatting check CPU 0.35 s / elapsed 0.73 s. No second PR
opened. Sole #82 exact `3fa67f3`, CI `37703018710`: ARM macOS and benchmarks
passed; Linux and Intel macOS remain live. No local workload remains; shared
target is this channel compiler. Continue the same CI run, fixing any failure.

Next concrete action: audit actual phase-2 acceptance against docs/ownership.md,
with source-reachable runtime cycles and native library lifetime/teardown probes.
Distinguish an explicit tracing fallback from deterministic support; do not mark
phase 2 or optional tracing-free execution complete from these narrow checks.
Then repair remaining aggregate reconstruction/metadata paths using typed/source
evidence. Preserve OLD `ab44b7d` for the next prepared child. Once #82's four
gates pass, exact-head squash with subject `Add typed borrowed application for
synchronous callbacks` (one line, 56 characters), empty body; rebase map from
OLD `029fac4` onto the new squash and open the sole next PR.


## Prepared native library export result ownership (2026-10-08)

Branch `ownership-library-results`, checkout `/private/tmp/fwp-library-result-worktree`,
OLD base `ab44b7de0812eb1f84d5430a303cd61ddd026219`. Exported functions evaluate
once, protect owned results during C conversion, release copied record/Option
boxes and caller CAF references, and promote only escaping String results or
String record fields to the existing library lifetime. No new release interface.
Raw pointer payloads and scalar bits remain uncounted. NUL conversion traps
release the result through the internal recovered-trap cleanup probe.

The baseline probe failed with exit 1 (unreleased result). The first repaired
poison probe exposed a fixture mistake: record poisoning uses tag 0xdead, not
a zero field count; the assertion was corrected. Final probe passes at O1/O2,
both poison modes, with four negative controls: omitted release (1), omitted
escaping String promotion (6), omitted conversion guard (4), duplicate nullable
pointer evaluation (11). Unoptimized IR interpreter values agree. One thousand
CAF export calls retain exactly one cache owner. Counters confirm immediate
box reclamation; this is not a speed or whole-program allocation claim.

Native libraries actually use the collector allocator and its RC metadata, with
tracing unarmed for unknown host roots; they do not use the WebAssembly bump
path. The probe requests GC stress/verification and asserts collection stays
unarmed with zero collections. Executable CAF tests exercise the armed stress
path separately. No library host-root tracing or complete GC-free support claim.

Serial commands under `env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target
python3 /private/tmp/fwp-local-guard.py`, after `cargo clean -p fwp`:
- `cargo test --test library_result_ownership -- --nocapture`: baseline failure
  CPU 6.87 s / elapsed 14.29 s; final pass CPU 7.28 s / elapsed 17.07 s.
- `cargo test --test ffi --test caf_ownership -- --nocapture`: eight pass,
  CPU 6.70 s / elapsed 15.11 s.
- Additional `FWP_REUSE=0` environment with `cargo test --test ffi
  shared_library_from_c -- --nocapture`: pass, CPU 0.60 s / elapsed 1.47 s.
- `cargo fmt`: pass, CPU 0.35 s / elapsed 0.62 s.
- `cargo clippy --lib --test library_result_ownership -- -D warnings`: final
  pass, CPU 0.07 s / elapsed 0.25 s (initial CPU 2.34 s / elapsed 4.69 s).

Full sequential architecture/benchmark CI is still required. Sole PR #82 exact
`3fa67f3`, CI `37703018710`: Linux, ARM macOS and benchmarks passed; Intel
macOS remains live. Merge only after all four pass, with recorded one-line
subject/empty body and exact head. Then rebase map from OLD `029fac4`; preserve
its OLD `41ef82d` for the filter child. Next acceptance action: typed library
input conversion and its failure/alias lifetimes, then unload/finalizers and
source-reachable cycles, with remaining aggregate gaps still open. Phases 2–6
remain incomplete. Shared target now contains this library-result compiler.

Native library result ownership published as
`5b34382167da90d5677943d3ca617bf0e6a5924c`, OLD base `ab44b7d`. Verified
one-line subject `Release copied C export results and preserve host string lifetimes`,
66 characters, empty body/no trailers. Checkout clean; final `cargo fmt --
--check` passes, CPU 0.35 s / elapsed 0.61 s; whitespace clean. No second PR
opened and no local workload remains. Shared target is this library compiler.
Root plan/handoff remain the only local main edits; preserve them on fast-forward.
Preserve OLD `5b34382` for the next prepared child. Latest #82 gate check:
Linux, ARM macOS and benchmarks passed; Intel macOS still running. Continue
the same run, fix any failure, and merge only after all four current-head gates
pass. Next concrete implementation: type-directed owned C-to-fwp library input
conversion, protecting earlier prepared arguments/fields on failure and
transferring them exactly once into the exported entry. Test scalar pointer
bits, input aliases returned as C strings, multiple String/Option/record
arguments, later conversion traps, and unchanged ordinary foreign-call
borrowing. Then complete unload/finalizers/cycles evidence and aggregate gaps.


## Prepared native library input ownership (2026-10-08)

Branch `ownership-library-inputs`, checkout `/private/tmp/fwp-library-input-worktree`,
OLD base `5b34382167da90d5677943d3ca617bf0e6a5924c`. C export wrappers create
counted String copies, nullable-pointer options and record boxes. Earlier
arguments and completed record fields remain in typed cleanup scopes during
later conversion. Fields follow C declaration order while canonical indices
retain the language layout. Scalar/pointer bits stay uncounted.

The shared `rc::consumes_arg` contract transfers consumed inputs once into
expression/constructor/primitive entry; borrowed inputs remain protected
through the call and are released afterward. Export result ownership preserves
C host string aliases. Both consuming and borrowing void exports are covered.
Ordinary foreign converters/sharing remain unchanged. A Bytes export parameter
now reports the missing pointer length; foreign functions still accept Bytes
payload pointers. No new ABI or surface syntax was introduced.

Baseline probe reproduced the retained input (exit 1). Fixture failures were
repaired: the injected allocation hook needed a forward trap declaration,
record alias ABI creates a separate result box, field workers legitimately
drop duplicated fields and the original box, and division uses data-last
operand order. The unoptimized interpreter now confirms the callee trap too.
No implementation or test failure remains.

Final O1/O2, both-poison input/result probes pass: direct borrowed primitive,
consuming function, nested and direct nullable inputs, declaration/canonical
field order, string/record aliases returned to C, retained host strings,
scalar pointer words, null/invalid UTF-8 later input, prepared record allocation
trap, consumed callee trap, and borrowed/consumed void results. Four negative
controls fail as intended: absent borrowed argument release (1), uncleared
consumed owner/double drop (2), missing earlier argument completion guard (11),
missing record field completion guard (12). One diagnostic test confirms Bytes
export rejection while ordinary foreign signature classification is retained.
Previous result probe's repeated-evaluation control was adapted to named input
locals and still detects extra evaluation. Actual allocator OOM is fatal; the
record-allocation trap is explicitly injected, not evidence of recoverable OOM.

Serial bounded commands after `cargo clean -p fwp`, using
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py`:
- Baseline `cargo test --test library_input_ownership -- --nocapture`:
  actual regression exit 1, CPU 0.25 s / elapsed 0.99 s after fixing the C hook.
- Final `cargo test --test library_input_ownership --test library_result_ownership
  -- --nocapture`: three pass, CPU 2.39 s / elapsed 8.08 s.
- `cargo test --test ffi --test worker_preparation_ownership -- --nocapture`:
  six pass, CPU 5.56 s / elapsed 11.36 s.
- Additional `FWP_REUSE=0` with `cargo test --test ffi shared_library_from_c
  -- --nocapture`: pass, CPU 0.55 s / elapsed 1.58 s.
- `cargo fmt`: pass, CPU 0.36 s / elapsed 0.74 s.
- Initial `cargo clippy --lib --test library_input_ownership
  --test library_result_ownership -- -D warnings`: pass, CPU 2.33 s / elapsed
  4.68 s; final check after optional/void cases passes, CPU 0.00 s / elapsed
  0.14 s (cached compiler checking).

Library tracing stays unarmed despite stress/verification requests; count
reclamation is measured directly, not claimed as host-root GC verification.
Full exact-head sequential CI remains required. Sole PR #82 exact `3fa67f3`,
CI `37703018710`: Linux, ARM macOS and benchmarks passed; Intel macOS is live.
Continue the same run and fix any failure. After all four pass, squash with
recorded one-line subject and empty body, then rebase map from OLD `029fac4`
onto that squash (preserve OLD `41ef82d` for filter). Next concrete task:
native library unload teardown, starting with reserved heap/metadata mappings,
CAF caches, finalizers, scheduler stacks and thread-pool lifetime. Do not unmap
storage while background workers can still access generated code or values.
Source-reachable cycles and remaining aggregate metadata/reconstruction gaps
also remain before phase 2 closes; phases 2–6 are incomplete. Shared target now
contains this input compiler. Preserve OLD `5b34382` for the branch rebase.

Library inputs published as `a6ebc1da9637b4fef866697fa766208fd2d72af1`, OLD
base `5b34382`. Verified one-line, 67-character subject `Own copied C library
inputs and unwind partial argument preparation` (supplied as one line), empty
body/no trailers. Checkout clean. Final formatting check CPU 0.36 s / elapsed
0.74 s; whitespace clean. No second PR was opened. Shared target is this input
compiler; package clean before switching to rebased map validation.

PR #82 all four exact-head gates passed at `3fa67f3` in CI `37703018710`;
squash-merged 2026-10-08T00:58:09Z as `181d3b356db94a3bcff78a79c2a2d84aad15b1c8`.
Verified subject `Add typed borrowed application for synchronous callbacks`,
56 characters, one line, empty body/no trailers. Root fast-forwarded preserving
its two local plan/handoff files, backup `/private/tmp/fwp-main-docs-181d3b3`.
Map child rebase from OLD `029fac4` onto this squash has only plan/handoff
conflicts; other changes apply. Resolve with current root docs, complete rebase,
run guarded map/borrowed callback checks after package clean, then exact-lease
push and open the sole next PR. Preserve OLD `41ef82d` for the filter child and
OLD `a6ebc1d` for the next independently prepared library teardown child.

Map callback rebase completed onto `181d3b3`; no code conflicts. After guarded
package clean, `cargo test --test map_ownership --test borrowed_callbacks
-- --nocapture` passes three tests, CPU 11.56 s / elapsed 23.36 s. Both map
source references now explicitly use `FWP_NO_OPT=1` for an independent
unoptimized interpreter oracle. O1/O2, stack on/off, GC stress/verification and
both poison modes preserve aliases/captures. Selected no-tracing loop reports
2.7 MiB freed by counts for the restored shared-result boundary versus 4.6 MiB
for owned spines (same generated code otherwise, same output, O1, Apple Silicon/
Apple Clang 17, 0.1 MiB report precision). This is not a speed claim or proof
of complete tracing-free support. `cargo clippy --lib --test map_ownership
--test borrowed_callbacks -- -D warnings` passes, CPU 2.31 s / elapsed 4.65 s.
Shared target is now this rebased map compiler. Final contract inventory and
formatting before publication; then exact-lease push against OLD `41ef82d`,
open sole next PR and run all four current-head gates. Preserve OLD `41ef82d`
for the filter child. Full builds/tests remain on runners; no limits bypassed.

Rebased map's complete contract inventory passes, CPU 3.20 s / elapsed 6.77 s.
One inventory test checks all declared collection/text boundaries. All focused
checks pass; no unresolved failure. Ready for final format and publication.

Map callbacks published after rebase as
`2b0012a25da33ba777868e3755ed2127993f77e1` using exact lease against OLD
`41ef82d87769596f99bde2081dc5ac00a514ffbc`. Verified one-line, 59-character
subject `Own synchronous map results without sharing callback inputs`, empty
body/no trailers; clean checkout. Final `cargo fmt -- --check` passes, CPU
0.34 s / elapsed 0.63 s; whitespace clean. Sole new PR #83:
https://github.com/e6qu/fun-with-pipes/pull/83 . Full exact-head runner CI
`37711126548` is queued at that head. Follow the same run, fix failures and
merge only after all four gates actually pass. Explicit squash subject above,
empty body and exact match. Filter child then rebases from OLD `41ef82d` onto
that squash; preserve OLD `1ea7f07` for fold.

Next independent task while CI proceeds: native library unload lifecycle on a
new prepared child of OLD `a6ebc1da9637b4fef866697fa766208fd2d72af1`. Read
actual collector reservation/metadata, CAF, finalizer, scheduler stack and
thread-pool code. Prove no worker can access unloaded code/storage before
unmapping; preserve loaded-library host pointers. Native libraries have RC
metadata but tracing is unarmed. Check actual `dlopen`/`dlclose` and static
exit behavior on runners, with bounded focused local probes. Cycles and
aggregate gaps remain before closing phase 2; phases 2–6 are incomplete. No
local workload remains. Main's only local edits are active plan/handoff;
preserve them during the next fast-forward.

Latest verified #83 run `37711126548` is in progress at exact `2b0012a`: bench
passed; Linux, ARM macOS and Intel macOS are running. It is not a passing
merge gate yet. Continue teardown preparation while following this same run.


## Native library unload preparation (2026-10-08)

Branch `ownership-library-unload`, checkout `/private/tmp/fwp-library-unload-worktree`,
OLD parent `a6ebc1da9637b4fef866697fa766208fd2d72af1`. Ready for publication after focused validation; exact head will be recorded below.
Generated native libraries now have an idempotent unload/exit destructor. It
cancels and drains all scheduler tasks, including detached tasks, releases idle
stack mappings, restores saved host signal actions when the host has not replaced
them, closes the runtime polling descriptor, frees metrics, releases CAF owners,
runs registered finalizers with their objects still mapped, releases collector
side allocations and the complete original heap/meta mappings, and deletes the
closure cleanup pthread key. Host-owned file descriptors stay open.

The audit found no persistent numerical thread pool: each started pthread is
joined before its kernel call returns. Do not invent a pool teardown API.
A native TLS closure work-list pointer kept the dylib resident on Darwin, so an
initial destructor implementation did not execute on dlclose. A library-only,
explicitly deleted pthread key preserves per-thread release work and allows the
actual loader destructor to run. Executable TLS and WASM behavior stay unchanged.
The full raw collector reservation, before alignment, is now tracked for unmap.

`cargo test --test library_unload -- --nocapture` passes under the fwp local guard:
CPU 8.68 s / elapsed 20.21 s, one test. Actual dlopen/dlclose executes three cycles
per case, O1/O2 and reuse verification off/on. Native archives prove process-exit
ordering (`main`, `finalized`, `finished`) with the same optimization/poison cases.
The finalizer verifies both blocked task cancellations and cached-owner release
before object storage disappears; it reenters finish to verify idempotence.
Heap/meta and active/idle stack mappings are checked absent, five external heap
allocations and the pthread key are checked released once, saved full SIGINT/TERM
actions are checked restored, and a subsequent host signal override is preserved.
Six negative controls fail with the expected status when heap unmap, stack unmap,
CAF cleanup, wide-count cleanup, signal restoration or key deletion is removed.

Repaired probe failures: initial fixture lacked size_t's header; Darwin TLS
prevented unload; mincore on macOS was insufficient to prove mapping absence.
The macOS probe now uses mach_vm_region to prove the complete range absent;
Linux uses mincore/ENOMEM at both range ends. The earlier dynamic-only pass was
CPU 0.35 s / elapsed 1.84 s; the final test adds archive exit and six controls.
Formatting passes, CPU 0.34 s / elapsed 0.60 s. Eight adjacent CAF, bounded
closure-release, C input/output ownership and task-handle checks pass under the
guard: CPU 12.34 s / elapsed 31.04 s. Command: `cargo test --test
library_input_ownership --test library_result_ownership --test closure_cleanup
--test caf_ownership --test task_handle_ownership -- --nocapture`.

Native-library tracing remains unarmed (asserted zero collections); this proves
region teardown, not host-root tracing or complete GC-free ownership. Registered
finalizers do not establish general File/socket/TLS/GPU cleanup. Raw escaping
pointers retain their manual host lifetime; no new public ABI is introduced.
Static-memory provisioning is not covered by the mapping assertions; ordinary
static archives are. Hosts must finish calls before unload. Cycles and remaining
aggregate/reconstruction paths still require acceptance evidence before phase 2
closes. Full Linux/ARM/Intel/benchmark CI is required when this branch reaches the
sole-PR position. Shared target is this unload compiler; clean package on switch.
Next: finish adjacent validation and publish this preparation, then audit actual
runtime external resource lifetimes and source-reachable cycles/aggregate gaps.


Library unload final validation: clippy of library and unload/input/result tests
passes with `-D warnings`, CPU 2.35 s / elapsed 4.69 s. Shared-library C smoke
also passes with `FWP_REUSE=0`, CPU 0.63 s / elapsed 1.82 s. All commands use
`env CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target python3
/private/tmp/fwp-local-guard.py ...`; no full local gates or skipped checks.
Formatting/whitespace pass. No local workload remains. Next audit actual external
resource cleanup and source-reachable runtime cycles; keep this preparation
separate from sole PR #83 and require full exact-head CI at its sequential turn.


Native library unload publication: `5d0dc220fa1cfc3699cef88224c61d42cf8e66fc`,
branch `ownership-library-unload`, OLD parent `a6ebc1d`, clean checkout
`/private/tmp/fwp-library-unload-worktree`. Verified one-line 64-character subject
`Drain native library tasks and release runtime storage on unload`, empty body.
No additional PR opened. All focused checks above pass; full sequential CI remains
required. Sole PR #83 exact `2b0012a`, CI `37711126548` still live with benchmarks
passed and Linux/ARM/Intel tests running. Next preparation audit found persistent
OpenCL loader/context/queue ownership missing, including initialization failures;
fix those lifetimes next, then external files/sockets/TLS and cycles/aggregate gaps.


## Native OpenCL lifetime preparation (2026-10-08)

Branch `ownership-opencl-lifetime`, checkout `/private/tmp/fwp-opencl-worktree`,
OLD parent `5d0dc220fa1cfc3699cef88224c61d42cf8e66fc`. Not yet published.
The actual-loader regression first failed at O1 with exit 2: generated-library
unload left a live context. Baseline check CPU 6.54 s / elapsed 14.12 s. Runtime
now records its dlopen owner and requires queue/context release entry points.
A common finish path drains/releases the queue, releases the context, then closes
the loader reference. Failed symbol lookup, platform/device selection and
context/queue creation run this path immediately, preserving the cached failure
diagnostic and preventing a second creation attempt. Library unload and normal
native executable completion invoke finish after CAF release.

The first corrected dynamic loader probe passes five modes (success, no platform,
context failure, queue failure after context creation, missing required symbol)
at O1/O2: CPU 6.91 s / elapsed 16.68 s. A fake OpenCL library records API ownership
and actual loader destruction; this is not hardware GPU validation. Additional
archive/executable exit checks, five negative controls and adjacent unload checks
are running. Rust interpreter OpenCL uses a process-lifetime OnceLock cache; its
partial-failure cleanup also needs audit, recorded separately from native unload.
Shared target is this OpenCL compiler, following guarded package clean (128.9 MiB).
Sole PR #83 CI stays live; failures remain repairs and do not block this work.


OpenCL archive exit exposed a real ordering failure: the OpenCL image's
termination ran before the archive's ordinary destructor (stdout `main`, `bad
cleanup`). Combined unload/GPU check failed, CPU 2.47 s / elapsed 10.05 s;
unload test itself still passed. Library initialization now also registers its
idempotent finish through atexit, retaining the unload destructor as fallback.
This must be proved safe across actual repeated dynamic unload and process exit;
checks are running before any publication. Do not treat the initial dynamic-only
pass as complete archive support. Executable completion explicitly finishes its
OpenCL cache; native-library exit/unload shares its guarded finish path.


OpenCL early-exit registration now passes the combined two-test check, CPU 10.01 s /
elapsed 29.61 s: repeated dynamic unload, static archive exit and native executable
completion all release API owners before loader teardown, at O1/O2. Five dynamic
negative controls detect missing queue/context/loader release, drain and library
finish. Final added controls also check Darwin archive exit registration and native
executable finish. Full sequential CI remains required. Current sole PR #83 CI
`37711126548`: Linux, Apple Silicon and benchmarks passed; Intel macOS remains live.


OpenCL final dedicated check (including executable and Darwin archive-exit
negative controls) passes, CPU 1.24 s / elapsed 9.03 s; formatting passes,
CPU 0.35 s / elapsed 0.74 s. The archive registration negative control is
Darwin-specific; all platforms still run positive static-archive and dynamic
loader ownership assertions. The native code change preserves the cached error
message and availability behavior. Unoptimized interpreter/native no-OpenCL
semantic comparison is running before publication.


Unoptimized no-OpenCL semantic comparison passes: `FWP_NO_OPT=1 cargo test
--test numerics gpu_without_opencl -- --nocapture`, CPU 9.62 s / elapsed 19.26 s.
Interpreter/native stdout, stderr and exit status agree for absent loader and
no-platform implementations. No hardware GPU claim and no full local test gate.


OpenCL publication validation: library/unload/GPU clippy passes with `-D warnings`,
CPU 2.34 s / elapsed 4.70 s. Three adjacent C input/output checks still pass after
exit registration: `cargo test --test library_input_ownership --test
library_result_ownership -- --nocapture`, CPU 2.97 s / elapsed 8.92 s. Final format
check passes, CPU 0.35 s / elapsed 0.72 s; whitespace clean. No local workload
remains. Publish this native preparation separately, then implement interpreter
OpenCL partial-load cleanup without changing process-lifetime availability/cache
semantics. Current target is OpenCL; package clean before the next checkout.


Native OpenCL preparation published as `d8b4d88da98d91183577a71dd65d2d17a375e7d6`,
branch `ownership-opencl-lifetime`, OLD parent `5d0dc22`, clean checkout
`/private/tmp/fwp-opencl-worktree`. Verified single-line 63-character subject
`Release native OpenCL owners on load failure and program teardown`, empty body.
No additional PR opened; sole #83 still requires Intel current-head CI before
squash. Next interpreter preparation uses immutable OLD `d8b4d88` as parent.


## Interpreter OpenCL failure ownership preparation (2026-10-08)

Branch `ownership-interpreter-opencl`, checkout
`/private/tmp/fwp-interpreter-opencl-worktree`, immutable OLD parent
`d8b4d88da98d91183577a71dd65d2d17a375e7d6`. Not yet published.
The loader regression now also runs an unoptimized source program twice through
availability in separate native/interpreter processes. Its actual fake-loader
finalizer checks owner balance and destruction timing. Baseline failed at O1,
no-platform mode: interpreter retained the loader until process termination,
while native failure released it before printing the first False. CPU 7.41 s /
elapsed 15.87 s. The source audit shows a missing owner guard; the initial buffered observation
alone did not prove its release timing (see corrected controls below).

Rust now gives the dlopen result a guard before symbol lookup; Cl retains that
owner while its function pointers are usable. A partially constructed Gpu owns
completed context/queue stages before the next fallible call. Its drop drains and
releases queue, releases context, then lets Cl close the loader. A successful
OnceLock cache retains its existing process lifetime and availability behavior;
this change does not claim deterministic interpreter shutdown of that cache.
Focused checks are running for no platform, context failure, later queue failure
and missing entry point, with O1/O2 native unoptimized oracle comparison. Existing
native loader/archive/executable checks and negative controls remain in the test.
Package clean before switching removed 126.3 MiB; shared target is this compiler.
Next finish this validation/publication, then file/socket/TLS external ownership
and source-reachable cycles/aggregate gaps. Sole PR #83 still awaits Intel CI.


Interpreter probe repair: C's fully buffered puts and Rust's line-buffered println
initially made a real early dlclose appear late even after guards were implemented
(repeated failure CPU 7.60 s / elapsed 16.00 s). The fake-loader destructor now
flushes its observation explicitly. Corrected O1/O2 check passes, CPU 4.83 s /
elapsed 14.45 s. Two temporary source controls prove the regression independently:
omitting Rust dlclose fails no-platform mode with release after both False lines,
CPU 7.48 s / elapsed 15.70 s; omitting context release fails later queue-creation
mode with `bad cleanup`, CPU 8.31 s / elapsed 16.72 s. Both controls have been
restored; their intentional unused-code warnings are absent from the product.
Formatting passes, CPU 0.34 s / elapsed 0.62 s. Final restored checks are running.

Next external resource audit: File is affine (`lib/prelude.fwp`) and scoped
file.with already closes on unwind, but affine discard versus native close needs
a concrete source-reachable lifetime test before new implicit cleanup contracts.
TLS listener stop currently closes only the descriptor; its SSL_CTX and allocated
ALPN callback context remain live. Accepted SSL sessions retain their context,
so listener cleanup must release its owner while preserving callback storage
until the last OpenSSL context reference disappears. TLS listen failure after
context creation also lacks a guard. Start with explicit listener stop/failure
and actual OpenSSL owner counters; do not free callback storage prematurely or
claim all sockets/files/cycles covered by library region teardown.


Restored no-OpenCL comparison passes, CPU 8.50 s / elapsed 17.15 s: `cargo test
--test opencl_lifetime --test numerics gpu -- --nocapture` ran the one existing
numerics GPU test; its name filter excluded the new loader test. That filtered
invocation is not counted as new-loader validation. The new loader test is running
separately with `cargo test --test opencl_lifetime -- --nocapture` after restoration.


Interpreter OpenCL final restored test passes, CPU 4.47 s / elapsed 13.21 s, one
loader test with O1/O2 source comparisons plus the existing native positives and
negative controls. `cargo clippy --lib --test opencl_lifetime -- -D warnings`
passes, CPU 2.32 s / elapsed 4.60 s. Final formatting passes, CPU 0.35 s / elapsed
0.74 s; whitespace clean. All local checks used the fwp guard and limits; no local
workload remains. Publish this focused preparation; next is TLS listener owner
release and failure guarding with accepted-session lifetime evidence. Current
shared target is this interpreter OpenCL compiler; clean package before switching.


Interpreter OpenCL preparation published as
`abc128581b615530ba2f3bc43de0c8d708d340ea`, branch
`ownership-interpreter-opencl`, OLD parent `d8b4d88`, clean checkout
`/private/tmp/fwp-interpreter-opencl-worktree`. Verified single-line 67-character
subject `Guard interpreter OpenCL initialization with staged resource owners`,
empty body. No additional PR. At 02:00:32Z sole #83 CI `37711126548` still has
Linux/ARM/bench passing and Intel running. Continue same live run; do not restart.
Next implementation: TLS listener stop must release its context owner without
invalidating accepted SSL sessions; attach ALPN callback storage to SSL_CTX's
last-reference lifetime and guard listen failure after context creation. Add
actual OpenSSL reference/heap-owner probes and interpreter/native behavior checks.


TLS listener task checkout created: `/private/tmp/fwp-tls-listener-worktree`,
branch `ownership-tls-listeners`, exact/immutable OLD parent
`abc128581b615530ba2f3bc43de0c8d708d340ea`. Clean, no implementation changes yet.
Shared target still contains interpreter OpenCL; guarded package clean must
precede validation in this checkout. No local workload remains.

Concrete TLS design audit: native Listener currently stores a raw SSL_CTX; its
stop closes the fd but never releases the context/ALPN malloc owners. Rust uses
Arc<Ctx> for sessions, retaining stable ALPN storage. Prefer the same internal
owner relation natively: a small context owner with reference count, SSL_CTX and
ALPN state; Listener owns one, and each accepted connection owns another alongside
its SSL session. Stop releases the listener reference; connection close frees SSL
before releasing its context reference; the final context owner frees SSL_CTX,
ALPN wire/descriptor and itself. Client SSL sessions need no server ALPN owner.
Guard the newly created context across tcp.listen failure and cancellation.
Preserve repeated stop/close idempotence and active accepted-session behavior.

Do not register a library-local SSL_CTX ex-data free callback without a complete
unload protocol: OpenSSL's process-global index can keep that function pointer
past the generated library's unload and call into unmapped code. The explicit
owner relation avoids that new global callback lifetime. Inspect all accepted
session callers and existing server/grpc paths before changing internal layout.
Prove release counts with actual OpenSSL, accepted session survival/ALPN after
listener stop, first/later initialization failure and a source interpreter/native
comparison. Runtime resource GC/finalizer coverage, affine File discard, cycles
and aggregate contexts remain separate unfinished tasks.


## Native TLS listener ownership preparation (2026-10-08)

Branch `ownership-tls-listeners`, checkout `/private/tmp/fwp-tls-listener-worktree`,
immutable OLD parent `abc128581b615530ba2f3bc43de0c8d708d340ea`. Not yet published.
Baseline actual-OpenSSL probe failed O1/reuse verification off with exit 1:
listener stop leaked its context and ALPN owners, CPU 6.84 s / elapsed 14.13 s.

Further call-site audit found HTTP/2 transfers raw SSL pointers from sockets
(`w_take`) and gRPC uses the server-context helper directly. The implementation
therefore keeps the raw SSL/SSL_CTX interfaces: a small counted server owner in
SSL_CTX's existing app-data slot owns the ALPN state. Accepted SSL sessions retain
it, session release frees SSL before dropping its context owner, and listener
stop releases its owner and clears the pointer. No new process-global callback
index and no extra socket-layout field. gRPC/HTTP2 raw-session transfer preserves
the owner through SSL's context; client contexts have no server owner.

Server context validation precedes ALPN-owner allocation. Its incoming wire
buffer transfers only on successful return. Allocation/app-data setup failure
releases the completed context and leaves wire ownership with the caller.
TLS listen protects a completed context across actual address/bind Error paths;
gRPC server setup frees the wire on context failure and its context on bind failure.
General server cancellation/shutdown and TLS client caches remain separate gaps.
Do not claim a new cancellation point: current tcp.listen does not suspend the
scheduler; the cleanup scope guards nonlocal failure without changing effects.

Corrected first probe passes O1/O2 with reuse poisoning off/on, CPU 6.93 s /
elapsed 14.65 s. Real OpenSSL 3.6.3 (Homebrew) completes accepted-session ALPN
handshakes after listener stop for one/two/three sessions, including HTTP/2 raw
transfer; context/wire/descriptor owners release once only after the final SSL
session. Repeated stop/close is idempotent. Six later failure probes are running
(cert validation, CA validation, app-data setup, owner allocation, invalid address,
occupied bind). Shared target is TLS listener compiler after guarded package clean
removed 93.7 MiB. Full cross-platform sequential CI remains required.


TLS expanded probe passes all six failure cases and O1/O2/poison positives,
CPU 0.40 s / elapsed 1.45 s. Six generated-source negative controls then pass
(expected failure statuses), CPU 1.95 s / elapsed 6.04 s: missing listener release
(exit 1), session retain (2), session context release (5), listen guard (15),
ALPN wire free (1), and descriptor free (1). Actual BIO-pair handshakes negotiate
h2 after stop and raw HTTP/2 transfer; observed context/wire/descriptor frees are
exactly once. No poisoned/shared pointer fallback is accepted as reclamation.

`FWP_NO_OPT=1 cargo test --test tls streams -- --exact --nocapture` is running
under the same guard with OpenSSL 3.6.3. This compares actual source-level TLS
connections/ALPN/errors in interpreter and native against the existing expected
output. Native library probe tracing is unarmed; no host-root tracing claim.
Full stress/verification and architecture checks stay required on CI.


TLS source stream comparison was stopped by the local guard at sampled aggregate
RSS >1 GiB. The check did not complete and is not passing evidence. Do not raise
limits, bypass the guard or rerun this larger local workload. Move it to GitHub
runners on a separate evidence branch, retaining sole PR #83 and exact-head merge
gates. Publish the focused TLS preparation after formatting/clippy; fork an
`ownership-evidence-tls-listeners` branch with CI push trigger for that branch,
run full CI there and explicitly add the unoptimized/stress TLS stream comparison.
The evidence branch's workflow-only commit must not enter the sequential TLS PR.
Future PRs still require their own four exact-head passing gates after rebasing.

The actual context/session ownership probe and all six failure/negative controls
are complete and passing; no local workload remains. Normal optimized source and
GC stress/verification behavior still need runner evidence, not a claim inferred
from the unarmed library probe. Keep failures as repair work throughout.


TLS focused final formatting passes, CPU 0.37 s / elapsed 0.74 s; clippy of
library and dedicated listener test passes with `-D warnings`, CPU 2.37 s /
elapsed 4.73 s. Whitespace clean. Larger source comparisons must run on GitHub
because the guard refused the unoptimized stream check. No local workload remains.
Full tests, stress/verification and architecture evidence are still pending;
publish preparation and the separate runner evidence branch, then fix actual
runner failures before claiming verified support or merging anything.


TLS listener preparation published as `73f4f9828738dd99308619275ba0f259b73f5553`,
branch `ownership-tls-listeners`, OLD parent `abc1285`, clean checkout
`/private/tmp/fwp-tls-listener-worktree`. Verified one-line 66-character subject
`Own TLS listener protocol state through accepted session lifetimes`, empty body.
The runner evidence branch `ownership-evidence-tls-listeners` is exact
`4fda8214cf43706d75197a7613057b685c9fee10`, checkout
`/private/tmp/fwp-tls-evidence-worktree`, clean. Its sole additional commit modifies
CI push triggers for this evidence branch and adds an explicit unoptimized TLS
stream step with GC stress/verification and reuse verification on Linux/ARM/Intel,
as well as the ordinary full gates. Do not merge this workflow-only commit into
the sequential TLS PR. It carries the full prepared ownership chain; passing it
still does not replace the later rebased PR's exact-head four gates.

At 02:22:10Z PR #83 remains the sole PR with Linux/ARM/bench passing and Intel live;
continue CI `37711126548`, not a replacement run. Shared target is TLS listener;
no local workload remains. Next use runner failures as concrete fixes, while
continuing runtime teardown: TLS client context/name cache, listener/session
unload, gRPC server cancellation, affine resource discard and cycles. Keep old
immutable parent/head anchors for every sequential rebase (including new
`abc1285` for TLS listener, `73f4f98` for its later child).


Runner evidence CI is live: `37717526510`, exact
`4fda8214cf43706d75197a7613057b685c9fee10`. Poll the same handle and fix failures;
observation expiration is not a terminal job. Keep production TLS branch
`73f4f98` free of the evidence-only workflow commit. No new PR opened.

Next library resource teardown audit: register library-only finalizers for
owned FILE/socket wrappers in the existing collector finalizer table, releasing
external handles before region unmap. Closed wrappers must remain idempotent,
and raw HTTP/2 transfer must clear fd/SSL so socket teardown cannot double close.
Split SSL disposal (no network write) from explicit close_notify shutdown;
unload finalizers should dispose without sending so they do not introduce SIGPIPE
through host signal policy. g_conn library finalization must dispose any surviving
SSL/fd as well as buffers. Finish the cached TLS client contexts/names/array after
all finalizers, while entry points remain valid. General executable affine
resource discard, gRPC server cancellation and cycles remain later acceptance.
Do not add a separate per-session registry/heap node when existing owned wrapper
finalizers suffice. Confirm every wrapper constructor owns its incoming handle.
TLS library tests that intentionally break retains may need negative exits via
_Exit after their observation, avoiding destructor traversal of intentionally
corrupted graphs; keep positive process-exit teardown tested normally.


Runner evidence `37717526510` at `4fda821`: ARM job `113117345850` and Intel job
`113117345602` both failed the unoptimized TLS stream snapshot before reaching
ordinary full tests. Logs: `/private/tmp/fwp-tls-evidence-arm-113117345850.log`,
`/private/tmp/fwp-tls-evidence-intel-113117345602.log`. Actual output differs only
in the bad-certificate vendor alert name (`ssl/tls` versus snapshot `sslv3`);
certificate/hostname rejection and all other lines match. The logs show OpenSSL
3.6.4 on ARM and 3.6.3 on Intel, so do not attribute this solely to 3.6.4. Ordinary
PR #83 ARM streams passed with 3.6.4. Linux's explicit unoptimized stress/reuse
stream step passed; its full tests remain live. Benchmarks passed. None of these
partial/skipped/superseded checks is a current PR merge gate.

Prepared repair: streams now first requires byte-for-byte raw interpreter/native
output agreement, then canonicalizes only the exact bad-certificate alert alias
for the existing portable snapshot. Language diagnostics remain unchanged;
certificate failures/ALPN/order and all other error lines stay exact. Formatting
passes, CPU 0.35 s / elapsed 0.74 s. Clippy is running. The larger stream check
stays on runners (prior local RSS refusal); do not rerun it locally. Amend/publish
TLS preparation with this test repair, preserving OLD `73f4f98`, and rebase the
evidence-only workflow commit from OLD `73f4f98` onto the new production head.
Push exact leases for both heads to run the genuinely changed test on GitHub.
Keep PR #83's live Intel job separate; it is not a source-repair rerun.


TLS snapshot repair published with exact lease: production head now
`3f6154b4bf67330f15d5a01a5d603b75d33319d3`, same one-line 66-character subject,
OLD parent `abc1285`, clean checkout. Preserve original OLD `73f4f98` for any
child already based on it; no production child exists yet. Evidence workflow
commit rebased cleanly from OLD `73f4f98` to new production head; evidence head
now `f806be807d0a4d48a3f4be847503c63d6c066a92`, published by exact lease against
OLD `4fda821`. Clippy (library/TLS/listener tests) passes, CPU 2.44 s / elapsed
4.74 s. New push is warranted by an actual test repair, not observation timeout.
The previous evidence run `37717526510` stays live for its Linux full checks;
ARM/Intel failed snapshot steps and skipped remaining tests. New current-head
runner evidence is required and its handle must be recorded when visible.


Current changed-head evidence run is `37718591863`, exact `f806be807d0a4d48a3f4be847503c63d6c066a92`,
live. Poll it alongside sole PR #83 `37711126548`; retain prior evidence
`37717526510` for actual Linux results, not current-head acceptance. New next-task
checkout `/private/tmp/fwp-library-resource-worktree`, branch
`ownership-library-resources`, clean at immutable OLD
`3f6154b4bf67330f15d5a01a5d603b75d33319d3`. No resource implementation yet;
shared target still TLS listener compiler. Clean package before switching checks.
Start with actual loader/unload owned file/socket/TLS handle probes and partial
close/transfer cases, then library-only finalizers and no-write SSL disposal plus
cached client contexts/names release after finalization. Keep evidence-only
workflow commit out of production ancestry. No local workload remains.


PR #83 CI `37711126548` is now terminal cancelled: Intel job `113097042606`
reached its 90-minute limit at 02:35:28Z. Actual log
`/private/tmp/fwp-map-intel-113097042606.log` shows no preceding test failures:
GC stress golden suite passed but took 3452.08 s (57.5 minutes); normal golden
check/run, gRPC, HTTP, leaves, lint and LSP then passed, and cancellation interrupted
macOS-specific tests. Do not merge or count the cancelled Intel run as passing.

Concrete gate repair on existing sole PR #83: separate the one GC stress golden
test into `macos_gc` jobs for ARM and Intel, still with 90-minute limits. Regular
macOS runs all targets excluding only that named test; dedicated jobs execute it
exactly. Together each architecture still executes the full suite. Linux and
bench remain full. All six current-head jobs must pass before squash, with each
architecture's regular and stress results required; no skipped stress acceptance.
This is runner scheduling, not fewer assertions or raised local/CI resource limits.
Publish this focused gate repair on map, rerun full current-head CI and update PR
body/handoff. Propagate the same workflow repair to the separate ownership evidence
branch, preserving its explicit unoptimized TLS stream step and production ancestry.
Full local gates remain prohibited; validate workflow diff and coverage mapping.


MacOS gate repair published on sole PR #83 at exact
`0c5bec4fc344339c03e01f2e15c5904a18361119`; new CI `37719069685` is queued.
PR body updated with the full-coverage split. Verified additional commit subject
`Separate macOS GC stress gates while retaining full test coverage`, one line,
no body/trailers. Bounded Ruby YAML parse passes, CPU 0.00 s / elapsed 0.14 s;
workflow diff/whitespace clean. No full local gate run and shared target remains
TLS listener (not rebuilt map). Merge only after all six exact-head jobs pass:
Linux, bench, regular ARM/Intel and GC stress ARM/Intel. Use the unchanged explicit
single-line squash subject `Own synchronous map results without sharing callback inputs`,
empty body and exact head match. After merge, rebase filter from OLD `41ef82d`
onto the new squash, preserving OLD `1ea7f07` for fold. Main remains `181d3b3`.

The same scheduling repair is published only on the evidence branch, head now
`a11f9e15d3043fe17fb0afdabcdaf94badd9ba2a`, CI `37719202504` queued. Both
additional workflow commits remain outside production TLS ancestry (`3f6154b`).
Bounded YAML parse passes, CPU 0.00 s / elapsed 0.13 s. Prior changed-test evidence
run `37718591863` at `f806be8` completed the explicit unoptimized stress/verification/
reuse TLS stream check successfully on Linux, ARM and Intel: raw interpreter/native
stdout agrees exactly and the snapshot alias repair works. Benchmarks also passed.
Full tests still running at that older head are not current-head gates.

Superseded evidence runs `37717526510` (original failed macOS snapshot) and
`37718591863` (fixed snapshot, obsolete serial macOS workflow) are confirmed terminal cancelled
to free runners for current PR/evidence jobs. This is due to actual source/workflow
repairs and superseded heads, not observation expiration. Cancellation requests completed successfully; do not restart them. Current handles `37719069685` and `37719202504` remain required.
No local workload remains. Next fix any current-head runner failures while preparing
library-owned file/socket/TLS teardown on clean `/private/tmp/fwp-library-resource-worktree`,
branch `ownership-library-resources`, immutable OLD parent `3f6154b`. Clean the
shared package before switching checks. Phases 2–6 remain unfinished.


Library-owned external resources are now prepared on `ownership-library-resources`,
checkout `/private/tmp/fwp-library-resource-worktree`, immutable OLD parent
`3f6154b4bf67330f15d5a01a5d603b75d33319d3`. Native libraries register existing
owned File/socket wrappers with the collector finalizer table. Explicit close/stop
and HTTP/2 transfer clear owners, so unload cannot close twice. Library gRPC/HTTP2
connection finalization disposes surviving SSL sessions/descriptors. Implicit SSL
disposal performs no shutdown/network write; explicit close retains close_notify.
Client-context cache owners/names/storage are released after session finalization.
No additional per-session malloc registry or host signal changes were added.

Actual repeated dlopen/dlclose probe initially failed with owned file fd 0 open
(CPU 0.12 s / elapsed 0.73 s). The first command lacked FWP_OPENSSL_DIR and failed
compilation, not resource evidence (CPU 6.63 s / elapsed 13.68 s); corrected command
uses `/opt/homebrew/opt/openssl@3`. Final resource probe covers open/explicitly closed
files, ordinary connections, raw HTTP/2 transferred TLS session/fd, unclosed listener
and stopped listener with accepted sessions, real completed ALPN handshakes,
client cache and host-owned peers over three load cycles, O1/O2 and reuse poisoning.
Six omission controls detect file/socket/transfer/session/cache leaks and implicit
TLS shutdown. Expanded final probe passes, CPU 1.21 s / elapsed 4.01 s.

Three resource/unload/listener tests pass, CPU 5.14 s / elapsed 17.46 s (before
expanding server cases). A deliberately corrupted accepted-context negative control
would abort during newly active unload finalization after its intended observation;
its fixture now exits immediately only on failure. Positive listener tests retain
normal process finalization. Formatting passes CPU 0.44 s / elapsed 0.60 s.
All commands used the bounded local guard and shared target; package clean passed
CPU 0.00 s / elapsed 0.14 s before switching from TLS listener to resource checkout.
Full gates and large source checks stay on GitHub; this is prepared support only.
Current PR #83 CI `37719069685` and TLS evidence CI `37719202504` run; benchmarks
pass on both. Require six current-head jobs before merging #83. Phase 2 stays
incomplete. Next audit successful gRPC server cancellation and client-context
partial malloc/realloc/name failure; preserve remaining aggregate/cycle gaps.

Final expanded resource/unload/listener suite passes: 3 tests, CPU 5.18 s / elapsed
16.36 s. Warning check `cargo clippy --lib --test library_resources --test
tls_listener_ownership -- -D warnings` passes CPU 2.37 s / elapsed 4.73 s.
All tests were bounded, serial and low priority with FWP_OPENSSL_DIR specified.
Prepared resource commit subject: `Release owned files sockets and TLS resources on library unload`;
full sequential Linux/ARM/Intel stress/reuse gates remain required before merge.

Resource branch published as `07092cb06e1d1b7d11271f697bf21920ef899734` (one-line
61-character subject, no trailers); no second PR opened. Next branch is
`ownership-grpc-server-cleanup`, clean checkout `/private/tmp/fwp-grpc-server-worktree`,
immutable OLD parent `07092cb`. Shared target currently resource checkout.
Successful fwp_serve owns its bound listener and initial server TLS context across
an infinite cancellable accept loop, with no cleanup frame. Add an actual scheduler
cancellation fixture, then guard both owners through preparation and accept.
Accepted sessions retain their separate protocol owner and must survive server
cancellation. Continue current PR/evidence CI; neither is a roadmap blocker.


gRPC server cleanup is prepared on `ownership-grpc-server-cleanup`, checkout
`/private/tmp/fwp-grpc-server-worktree`, OLD parent `07092cb06e1d1b7d11271f697bf21920ef899734`.
An actual scheduler cancellation of fwp_serve reproduced an open listener (exit 1,
CPU 7.02 s / elapsed 14.34 s). A stack cleanup owner now protects the initial TLS
context before binding and the completed listener before server preparation and
accept. Cancellation unregisters/closes its descriptor and releases its initial
context owner. Accepted sessions keep their protocol owner and finish a real ALPN
handshake after server cancellation. No new surface syntax or per-server malloc.

Focused fixture covers TLS with/without accepted sessions, cancellation after
context creation and listener binding, and a plain listener. O1/O2 and reuse
poisoning pass. Three negative controls detect missing guard, fd close and context
release. The initial fd-close control matched an unrelated runtime close and
incorrectly passed; its needle now includes the unique listener owner assignment
and reliably fails exit 1. This fixture repair is recorded, not hidden acceptance.
Expanded server/resource/listener tests all pass, CPU 5.81 s / elapsed 15.96 s;
final server test including plain TCP passes CPU 2.85 s / elapsed 6.28 s. Formatting
CPU 0.44 s / elapsed 0.60 s; clippy lib/server test CPU 2.34 s / elapsed 4.62 s.
Package clean before switching was CPU 0.00 s / elapsed 0.13 s. All local checks use
the bounded guard; no full local gate and no limits raised. Shared target is now
gRPC server checkout. Source/stress large gates remain on GitHub. Next concrete
action is client TLS cache partial allocation ownership and server ALPN strdup
failure; phases 2–6 remain open. Current six-job PR/evidence CI still runs, with
benchmarks passing; do not count queued/in-progress jobs as a merge gate.


gRPC server preparation is published as `0d5d3098e7827e36045984adcbf859901bde4b74`,
subject `Release service listeners and TLS context owners on cancellation` (one
line, no trailers). TLS cache preparation is separate on `ownership-tls-cache-failures`,
checkout `/private/tmp/fwp-tls-cache-worktree`, immutable OLD parent `0d5d309`.
The actual failed-realloc fixture reproduced a process crash (CPU 6.81 s / elapsed
14.32 s). Client cache creation now checks capacity, prepares a CA name, grows
through a temporary pointer, and publishes only a complete entry. Failure releases
name/context, keeps prior entries intact and returns a stable TLS diagnostic.
Successful caching remains unchanged. Service ALPN strdup failure is reported
before creating a context instead of publishing a null protocol buffer.

Focused O1/O2/reuse checks cover empty/populated caches, strdup/realloc failure,
previous pointer/name/context identity, retry, cache reuse, idempotent teardown
and server ALPN allocation failure. Five controls detect omitted context/name
release, incomplete publication, lost cache and missing ALPN guard. Intentionally
losing the cache caused finalization to crash after detecting it; fixture _Exit
now applies only after nonzero failure observation. Positive tests still finalize.
Final dedicated test passes CPU 0.72 s / elapsed 3.66 s; first corrected production
check passed CPU 6.90 s / elapsed 14.86 s. Adjacent server/resource probes pass in
the combined check, which initially failed only that negative-control reporting
case (CPU 4.96 s / elapsed 13.26 s), so it is not a fully passing suite. Clippy
lib/cache test passes CPU 2.36 s / elapsed 4.77 s; fmt CPU 0.45 s / elapsed 0.85 s.
Guarded clean switching target passed CPU 0.00 s / elapsed 0.14 s. Shared target
is TLS cache checkout. Full gates, source TLS stress and reuse suites remain CI work.

PR #83 current CI `37719069685`: bench and both ARM regular/stress jobs pass;
Linux and Intel regular/stress remain in progress. TLS evidence `37719202504`
still runs, with Intel stress queued; do not count those statuses as passing.
Next inspect protocol wire scratch/malloc/length preparation and connect cancellation:
native tls.connect currently opens TCP before preparing ALPN/SSL and keeps no
cleanup frame across fallible/cancellable handshake. Keep one PR open, with all
six exact-head jobs required before squash. Phase 2 and later phases stay open.


TLS cache preparation is published as `4ab1f7ddd6f8f2a335f3640a229629b782e09b3b`,
subject `Preserve TLS caches and release partial allocation owners`, one line,
no trailers. ALPN wire preparation is separate on `ownership-tls-wire-preparation`,
checkout `/private/tmp/fwp-tls-wire-worktree`, immutable OLD parent `4ab1f7d`.
Failed malloc reproduced a crash (CPU 6.80 s / elapsed 14.06 s). The wire helper
now walks borrowed list nodes directly, counting only nonempty names <=255 bytes,
checks wire/API and allocation sizes, and fills one exact buffer. It creates no
collector scratch array; a probe instruments the old list-items allocation to
verify zero calls. Native bytes match the interpreter's actual alpn_wire helper.
Allocation failure reports a TLS error; listen creates no context, and connect
closes the already connected TCP descriptor before raising its error.

Focused native O1/O2/reuse checks cover allocation failure, invalid/empty names,
exact bytes/size, empty list, listener rejection and actual TCP client descriptor
closure. Three controls detect unchecked malloc, counting invalid names and omitted
client close. A reduced local wire ceiling exercises the length rejection before
allocation, without allocating gigabytes. Its first synthetic ceiling caused
unsigned subtraction to wrap for an entry larger than that ceiling; the production
predicate now checks entry <= ceiling before subtracting (normal ALPN entry max256
was already below UINT_MAX). The synthetic test now passes. No large workloads or
limits bypassed. These are unarmed native-library probes, not host-root tracing.

New primitive ALPN guards shadowed the cache fixture's old generic `if (!alpn)`
needle. That existing negative control is now anchored to its service diagnostic,
and fails as intended. The combined wire/cache/listener suite passes 3 tests,
CPU 3.23 s / elapsed 10.60 s. Formatting CPU 0.34 s / elapsed 0.61 s; package clean
CPU 0.04 s / elapsed 0.26 s. Shared target now wire checkout. Sequential full
Linux/ARM/Intel stress/reuse gates remain required. Next actual cancellation probes
for TCP connect (pending descriptor/resolver owners) and TLS handshake (connected
socket/SSL owner), followed by peer-subject temporary buffers and remaining IO.
PR #83 remains sole open; its ARM regular/stress and bench pass while Linux/Intel
run. Keep preparing/fixing work; CI gates merge, not the roadmap.

PR #83 merged after all SIX exact-head jobs passed; its macOS scheduling split
preserves complete coverage and is now the required workflow. Separate evidence
failure logs show REST, reuse, stack-allocation and WebSocket failures in ARM
regular plus golden GC stress failures; inspect exact stderr/output before fixes.
Next finish/rebase/publish filter PR, then fix prepared-chain failures while CI runs.
Connect cancellation preparation: 3 connect/cache/wire tests pass CPU 2.40 s /
elapsed 9.06 s; initial duration fixture was incorrectly scalar and corrected to
Duration record before reproducing descriptor leak (CPU 0.29 s / elapsed 1.00 s).
First fixed connect probe passes CPU 7.12 s / elapsed 14.69 s. Formatting CPU
0.36 s / elapsed 0.73 s; confirm clippy before committing. Immutable OLD parent
`f6598e4`; package clean CPU 0.00 s / elapsed 0.14 s. No workload currently runs.


Filter rebased cleanly in code onto map squash `0f1ca94`; only handoff conflicted
and was reconciled with these authoritative docs. Current unpublished head
`9a7a34799d146c44652b50d7892b539bde15284c`. Five filter/map/borrowed-callback tests
pass under bounded guard, CPU 15.72 s / elapsed 31.81 s; clippy lib/three tests
CPU 2.23 s / elapsed 4.43 s; complete ownership inventory 1 test CPU 3.04 s /
elapsed 6.43 s; fmt CPU 0.34 s / elapsed 0.62 s. Initial command named nonexistent
borrowed_apply target and ran no checks (CPU 0.00 / elapsed 0.14); corrected to
borrowed_callbacks. Shared target is filter; clean before switching. Use explicit
subject `Own synchronous filter spines and selected input references` with empty
body and all six gates, preserving OLD `1ea7f07` for fold rebase. Publication uses
lease against original filter `1ea7f07`; next PR only after #83 merged (now done).

Prepared evidence failures partly come from stale original branch ancestry:
original map `41ef82d` lacks merged root-liveness fixes in fwp_data/fwp_str_new/
fwp_list_items/flat-map/right-fold, read-only AOT cache usage and tutorial wc spacing.
All are present in actual map squash and sequentially rebased filter. Comparing
original map to validated rebased map `2b0012a` isolates these missing fixes.
Attempted evidence-only merge had broad equivalent-commit conflicts and was
aborted. Exact already-merged fixes apply cleanly as a narrow patch to evidence,
including their AOT/macOS/map regressions and tutorial command; no production
branch reset or second PR. Evidence checkout now has 7 pending files, parent
`a11f9e1`. Verify selected traits/root tests and investigate remaining wide-record
allocation regression (366.2 MiB) before re-running/publishing evidence. Production
preparation retains original parents; sequential rebases inherit merged fixes.
Current evidence run `37719202504` continues; failures are repair tasks. No tests
have been skipped or thresholds raised. Connect cleanup remains uncommitted.

Filter differential oracles now explicitly use FWP_NO_OPT=1 on the interpreter,
while native builds use optimization. Both updated tests pass CPU 4.85 s / elapsed
9.87 s; clippy lib/filter CPU 0.07 s / elapsed 0.26 s; fmt CPU 0.36 s / elapsed
0.75 s. Equivalent generated shared/owned controls still show 4.6 versus 5.0 MiB
freed by counts at reported tenth-MiB precision, with zero collections and matching
output. No elapsed-time speed claim. GitHub confirms no open PR after #83; publish
final filter oracle/head and create the sole next PR. Preserve OLD 1ea7f07 for fold.
