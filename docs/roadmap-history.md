# Delivery evidence

This is an index of completed deliveries and their test records. Current work
belongs in [the plan](../PLAN.md) and [session handoff](development-state.md).
Each entry states the change and any important limitation. Detailed samples live
in the linked reports; old fixes are not new tasks. The [preparation table](roadmap-queue.md) preserves original commit IDs.

A PR is a proposed change. Its **tested head** is the exact commit checked by CI
(continuous integration on GitHub runners). A **squash merge** makes one main-branch
commit from the PR. “Same files” means the tested head and merge have identical
Git trees, even though their commit IDs differ. A focused test run checks a subset;
production acceptance requires every platform job applicable to that delivery.
Cancelled, skipped or partially passing runs are not acceptance.

## String map ownership and native reuse checks (PR #194)

Known string-map callbacks now move unique input strings, and ASCII case changes
reuse private young storage. Shared aliases retain their original values. Large
allocation age checks are repaired; Windows reuse tests execute instead of
silently skipping when native compilation fails. WASI tests verify physical
cleanup as well as output.

For 65,536 words, allocation requests fall from 248,807 to 226,961 and retains
from 138,250 to 72,714. Larger ARC cases take 6.2–7.7% less time than previous
fwp, but still 2.57–3.05× C time and 1.98–2.12× Rust time. Smaller AMD64 ARC is
3.6% slower, and generated code grows. The [report](measurements/string-map-ownership.md)
retains complete samples, inspected binaries and deliberately broken controls.

[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39737931809)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39737931776)
at `489d8414e68678e30829df525982ce8790a4aadc`. All complete logs were audited.
Squash merge `f74c9d2998d595b4a3c15ee4a225a49963c1a6ea` has identical files,
the expected parent and one subject under 80 characters with no body or trailers.

## Manual C pointers and foreign storage cleanup (PR #193)

Checked ARC accepts manually managed C pointers in scoped calls, synchronous
callbacks and exported libraries. Pointers do not own their pointees; callers
must keep addresses valid and release raw storage. Managed C-string callback
results still require a separate lifetime contract.

Interpreter temporary C strings now release after results are copied, including
reentrant calls and errors. Raw allocation bounds are checked before 32-bit
narrowing; ISize/USize use the target pointer width and I128/U128 access preserves
all bits. The [report](measurements/manual-pointers.md) retains six-host native
and actual 32-bit interpreter/WASI evidence, including inspected binaries and
cleanup controls.

[PR #193](https://github.com/e6qu/fun-with-pipes/pull/193) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39725180238)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39725180233)
at `91502f538d2265f3f7afd8606760dfcc4a088005`. Complete logs were audited.
Squash merge `13680b82e6bd96371d0978bc6a23d5069f5adb93` has identical files, one subject
under 80 characters and no body, trailers or attribution.

## String ownership and repeated file cleanup (PR #192)

Unchanged text transformations now transfer their existing string owner. Count,
index and byte-size guards reject or clamp large inputs before 32-bit narrowing.
The [word-frequency comparison](measurements/unchanged-text.md) records fewer
allocation requests and lower medians, while retaining the remaining C/Rust gaps
and differences in normalization work. It does not establish C/Rust parity.

[Repeated file programs](measurements/file-applications.md) check managed storage,
handles and scratch buffers after each completed round, with failure controls and
separate process-memory samples on all six native hosts. Windows permission checks
and UTF-8 report decoding are repaired. The [autodiff application](measurements/ad-application.md)
compares the same 199 updates with and without retaining intermediate vectors.

[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39714665578)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39714665552)
at `36998a99f689b254edfc127bbbc8e8aac054c509`. Complete logs were audited.
Squash merge `3003e2cdebf6e98f45b06b4f523d8dd21d8150c5` has identical files and the
verified single-line subject “Reduce string copies and verify repeated file cleanup”,
with no body or trailers.

## Task results and explicit CPU execution (PR #191)

Immediate task-result fields avoid a temporary `Some` box. The measured fixture
uses 34 fewer allocation requests and 544 fewer requested bytes, with unchanged
retains and peak storage; [the report](measurements/task-await-fields.md) records
the native/WebAssembly controls and limits. State callback scopes, Jacobian tape
cleanup and C-interop buffer releases are also repaired.

CPU kernels use explicit worker limits and no longer compile OpenCL source at
runtime. The GPU API is removed. Interpreter foreign-call bridges are prepared
before program effects, so calling foreign code does not start a compiler.

[PR #191](https://github.com/e6qu/fun-with-pipes/pull/191) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39688998592),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39688998567)
and the [focused GCC check](https://github.com/e6qu/fun-with-pipes/actions/runs/39688997806)
at `12be5afcee7c81f1b98ffed2081d698e1124b000`. All complete logs were audited.
Squash merge `19f3afbcbed22802a96f092d9d0ee3d7913335e3` has the identical tree
and a verified one-line message without body or trailers.

## Queued task owners and callback transfers (PR #190)

Queued callbacks and messages can retain proved task handles without tracing.
The compiler rejects unproved result cycles and unknown task producers. Task
creation transfers callback ownership directly: the five-task comparison uses
10 → 5 retains with unchanged allocations. [Task-message checks](measurements/task-channels.md)
and [callback measurements](measurements/queued-task-handles.md) record the limits,
all eight focused jobs, and independent native/WebAssembly binary inspection.

[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39673092514)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39673088884)
at `4cdf8afa8647cfdaecbc338429bf8a1c1a158210`. Every complete log was audited. Squash merge `a2b9130fa1811c32e8807ba8cf61a8647fbcba60`
has the identical tree and verified one-line message without body or trailers.

## Compact task records and repaired native validation (PR #189)

ARC task records are 32 bytes smaller on each measured native host. Allocation
and retain counts stay unchanged; allocator size classes make peak savings vary.
[The report](measurements/task-records.md) preserves those limits, tracing-mode
results and actual binary inspection. Windows output assertions and dependency
fetching are repaired without dropping checks.

[PR #189](https://github.com/e6qu/fun-with-pipes/pull/189) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39641372026)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39641321443)
at `4dfc2be31c62c9e54271692ac8638fbb66ca786b`. Every complete log was audited.
Squash merge `030fa3374e36459d9a774379e2116ac42ed5db1d` has the identical tree,
expected parent and verified single-line message without body or trailers.

## Cancellation buffers and Windows ARC fibers (PR #188)

[PR #188](https://github.com/e6qu/fun-with-pipes/pull/188) was merged by the user
before full validation finished. Merge `ffcf04763990356fb3cb3913d6414082e00aa178`
has the same tree as head `fc1386501955109b1f1271429a57b6ea42022aec`.
The [cancellation-only comparison](measurements/task-cancellation.md) has earlier
six-host evidence. The added Windows fiber probe passed its first execution but
its assertion expected LF instead of the C runtime's CRLF output on both Windows
architectures. That stopped the remaining variants and left incomplete artifacts.
The completed [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/39635039734)
has six passing jobs, these two Windows failures, and a macOS ARM64 GC-stress
failure resolving crates.io before compilation. Every full log was audited;
documentation passed. This merge is not full platform acceptance.
[PR #189](https://github.com/e6qu/fun-with-pipes/pull/189) repairs the assertion
and dependency fetching, and reruns every variant with the
[compact-record measurements](measurements/task-records.md). PR #189 has full production
acceptance as recorded above; this earlier merge alone does not.

## Smaller Linux task heap records (PR #187)

Saved CPU state moves from heap task records into existing child stacks and root
static storage. The [comparison](measurements/task-contexts.md) counts those bytes
separately and retains mixed timings, larger files and remaining ARC operations.
This is a storage improvement for the measured programs, not GC removal or
proof of C/Rust performance parity.

[PR #187](https://github.com/e6qu/fun-with-pipes/pull/187) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39613713414)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39613713402)
at `81bb3efa8e3f2cc5f3dd9f0ae9952709088c2905`. Every complete log was audited.
Squash merge `eb9ba7e828a5ab8ef0f7579b7f6fe1263e752c8c` has the identical tree, the expected sole parent,
and a verified one-line message without a body or trailers.

## Queued service responses and bounded server startup (PR #186)

Queued callbacks can retain a response channel supplied by an actual gRPC service
entry. Unknown producers retain their existing restrictions. Repeated delivery,
failure and cancellation checks release request owners; the
[report](measurements/queued-grpc-responses.md) separates the still-live listener.
REST startup now kills and reaps a silent child, and tests reuse compiled fixtures
while starting fresh server processes.

[PR #186](https://github.com/e6qu/fun-with-pipes/pull/186) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39597478599)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39597478465)
at `fa2d5098573220833bda06e30af9f534181edc0d`. Complete logs were audited.
Squash merge `d516a0919a3f24a7c28817a32782908df77dd95d` has the identical tree
and a verified one-line message without body or trailers. This extends checked
ARC eligibility; allocation and shared-owner counting costs remain.

## Queued callbacks retaining data queues (PR #185)

Callbacks stored in channels can retain locally created data-only queues,
including through aliases and nested queues. The compiler tracks actual creators
and all values sent into nested queues; unknown producers cannot acquire a known
origin merely by sharing a type. The [report](measurements/queued-data-channels.md)
records native and WebAssembly cleanup and deliberate missing-release controls.
This extends checked ARC support without changing runtime layouts or syntax.

[PR #185](https://github.com/e6qu/fun-with-pipes/pull/185) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39584128319)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39584128240)
at `73850bd3b6ac460a7e077cea8cd1128f9913aea0`. Every complete log was audited.
Squash merge `f9bd49d9f9416b471326090f1a423282d476b1a9` has the identical tree
`a51eac8ca22b93ab45dfb053285d3654eca03e68`. Its message is exactly
`Allow queued callbacks to retain locally created data queues`, one line with no body or trailers.

## Queued socket callbacks and handler inference (PR #184)

Queued functions can retain UDP sockets, TCP listeners and connections under
checked ARC. Existing owners keep each socket alive and close it on final release.
Error/state handler inference also preserves handled effects through callbacks
and returned records, while keeping unrelated effects required. The
[focused report](measurements/queued-callbacks.md) records native cleanup,
actual-binary inspection and WASI handler checks; these are correctness results,
not timing or C/Rust parity claims.

[PR #184](https://github.com/e6qu/fun-with-pipes/pull/184) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39570320517)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39570319685)
at `0509937311ffd94171da9e2213c387d23e81739a`. Every complete log was audited.
Squash merge `b3401149955ff6e0aaa1d70044b527aec20f2e5f` has the identical tree
`fe039ae7fafb9252b8a3d1177d89f0d632dec9d8`. Its message is exactly
`Support queued socket callbacks and correct handler inference`, one line with no body or trailers.

## Checked-product bounds (PR #183)

Signed I64/ISize multiplication keeps its overflow check, then exposes the safe
product expression to C optimization. The [report](measurements/checked-products.md)
records lower O2 counting-loop CPU time on EPYC 7763/N2, smaller instruction
sections and removal of AMD64's normal entry frame. Matched C remains faster;
AMD64 comparisons with Rust vary by CPU. O0/O1 emit an extra product. These
limits remain part of the result, and tracing is still present.

[PR #183](https://github.com/e6qu/fun-with-pipes/pull/183) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39543123372)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39543123369)
at `3606d072d0f708b600f44050ab9cafe1390bceee`; every complete log was audited.
Squash merge `447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c` has the identical tree
`40b47a0670c38bc0b05c6dbd1afefd3ad5f7d7c5`. Its verified message is exactly
`Preserve numeric bounds after checked multiplication`, one line with no body,
trailers or attribution. Runtime-input, interpreter/native and sanitizer controls
preserve successful results, overflow traps and effect order.

## Grouped integer counting and U32 overflow (PR #182)

Integer display lengths now count decimal digits in groups. Ordinary inline
hints remove counting-helper calls in the measured loop. The [report](measurements/integer-counting.md)
records roughly 48% less child CPU time on Xeon 8573C/N2, remaining matched
C/Rust gaps, a larger instruction section and AMD64's fixed 40-byte entry frame.
Managed counting-workload allocations remain zero; tracing remains in the binary.

The same delivery fixes U32 multiplication: every U32 product fits an unsigned
64-bit intermediate, while some overflowed the former signed intermediate before
fwp could trap. Runtime-input and sanitizer controls preserve results, effect
order and overflow behavior, including a deliberately faulty signed control.

[PR #182](https://github.com/e6qu/fun-with-pipes/pull/182) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39533108586)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39532459370)
at `817805a18bd97e90090b36e7baf589d011048fd6`; every complete log was audited.
Squash merge `36fbb04097e8ab3d09a02b0eebf9060002e4fe91` has the identical tree
`18912402dff52e3c5a535de2dc560f1d447193cd`. Its verified message is
`Count integer digits in groups and fix U32 multiplication overflow`: one line,
64 characters, with no body or trailers. Duplicate post-merge production
`39542814814` and documentation `39542814748` were cancelled.

## Temporary channel borrows and failure cleanup (PR #181)

Temporary channel names can borrow an owner still needed after the operation,
including calculations inside record fields. The measured shared-text loop
reduces retains from three to two per message; closed sends reduce one to zero.
Allocations and peak accounted storage stay unchanged. Changed error and task-scope
fields also remain valid after C `longjmp`, preserving failure/cancellation cleanup.
[The report](measurements/channel-local-borrows.md) records counts, actual stack
frames and code sizes, plus C/Rust timing gaps that remain unexplained.

[PR #181](https://github.com/e6qu/fun-with-pipes/pull/181) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39488574062)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39488538767)
at `2038c926246cfcf8f741df7fdf0324fefc568b58`; every complete log was audited.
Squash merge `c98da7a5b3d859fee69120cf3452dcdecc904979` has the identical tree
`2fc33e8e7b238402acfc30efe3aee753ac4a018c`. Its verified message is exactly
`Borrow temporary channel names and preserve failure cleanup`: one line,
59 characters, without a body or trailers. Duplicate post-merge production
`39503544541` was cancelled; post-merge documentation `39503544342` had passed.

## Function-channel borrows and integer text (PR #180)

Direct calls can borrow a channel carrying functions while its original owner
keeps the queue and callback data alive. In the measured fresh-function program,
this removes one retain/release pair per message, with unchanged allocation and
peak storage. Capture, cycle and resource-scope checks remain.

`show | string.length` and eligible concatenations count integer characters
without creating text. The equivalent-work C/Rust comparison still shows time
and whole-process memory gaps. The [integer-text report](measurements/integer-text.md)
retains timings, managed-allocation controls, RSS and actual machine code;
[channel measurements](measurements/function-channel-borrows.md) record count,
frame and binary changes. These are specific improvements, not removal of GC.

[PR #180](https://github.com/e6qu/fun-with-pipes/pull/180) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39457866569)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39457866666)
at `64cfa0081dab2f6b19b6157e844c49481749a605`; complete logs were audited.
Squash merge `fe491a97466d9b6d972059553c95886ad850aacb` has the identical tree
and a verified one-line message without trailers. Duplicate post-merge
production `39470377254` and documentation `39470376880` were cancelled.

## Matched payload moves and direct-call borrows (PR #179)

Matching a single-payload variant can transfer its owner into the arm. A direct
call can borrow input storage when every caller still needs that same storage
afterward. Last uses consume their inputs; generic entries retain their ordinary
ownership rules. Failure, cancellation and original resource scopes stay covered.

[The channel comparison](measurements/channel-direct-borrows.md) removes the
remaining fresh-text retain, without changing allocations or peak accounted
storage. The report records smaller frames and actual binary changes; it makes
no timing claim. Compile-time evaluation also rejects runtime handles instead
of silently generating an invalid native constant. File contents can still
be read at compile time and embedded as data.

[PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39438167856)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39438167895)
on `63a129f25cfb9a3b940baf7786036265bfdf831d`; complete logs were audited.
Squash merge `2f2e3fa1baa3b8b298781d109bb4d6eb11a822d7` has the same tree
and a one-line message without trailers. Duplicate post-merge production
`39456604708` was cancelled; post-merge documentation had already passed.

## Direct matches and callbacks (PR #178)

A match on a temporary tuple can test the relevant field directly, after
evaluating every field once in order. This exposes known callback calls and
receives whose tag and payload can stay in locals. Ignored constants still
evaluate and trap; whole-tuple uses and original resource scopes stay protected.

[The five-program comparison](measurements/channel-match-results.md) measures
three fewer allocations per fresh-function message and two fewer per
shared-function message, with one fewer retain each. The other cases are
unchanged. Exchange frames shrink on both architectures; the report keeps
ARM64 layout growth. These counts do not establish a timing or C/Rust improvement.

[PR #178](https://github.com/e6qu/fun-with-pipes/pull/178) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39397311012)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39397297724)
on `732984c3fb6b8646f6f3ee4932c123eadb7f3555`; all complete logs were audited.
The user's merge `2ee0159b941d7887d70f5d86342cfad08e4e35c2` has the same tree
and a one-line message without trailers. Only duplicate post-merge production
`39417022563` was cancelled; post-merge documentation had already passed.

## Receive results without temporary wrappers (PR #177)

Immediately matched receives can keep the `Option` tag and message in local
fields, transferring the queued owner without allocating a `Some` wrapper.
Whole-value uses remain boxed. Both use the same receive loop and preserve
timeout, cancellation and cleanup. Boxed receives allocate before dequeue;
this also repairs retry after allocation failure in uncounted tracing mode.

[Counts and binary inspection](measurements/channel-receive-results.md) show
fresh-text allocations falling from two to one per additional message, and shared
text from one to zero, on both Linux architectures. Function-message costs and
retains are unchanged. The selected struct return reduces ARC code size further;
the report retains helper-stack growth and one larger ARM64 tracing code section.
No timing or C/Rust parity claim is made.

[PR #177](https://github.com/e6qu/fun-with-pipes/pull/177) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39374128066)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39374119890)
on `a5828518f92da3112fde13157a0dcc964d6c3cb9`; complete logs were audited.
The user merged it as `44f9eb6eeb787df378b159b33f113bffd69b216e` with the same
tree and a one-line message without trailers. Duplicate post-merge production
was cancelled; post-merge documentation had already completed.

## Loop state and known function calls (PR #176)

Loops can now keep state fields in locals even when an action or branch precedes
`Again`. For example, printing a string before updating `(count, text)` no longer
forces a new state tuple on each iteration. Known capture-free function aliases
also expose direct calls; constants that can evaluate or trap stay in order.
[Examples and measurements](measurements/channel-loop-state.md) explain the
five channel programs, counts, generated C and actual machine-code comparisons.
Each saves one allocation per additional message from loop-state lowering.
The alias change saves no further allocations or retains; it removes generic
dispatch and reduces the fresh-text exchange frame by 48 bytes on both hosts.
These are fwp count/representation comparisons, not timing or C/Rust parity claims.

Focused ownership `39366497033` passes 62 integrations plus all compiler units
on each of six native hosts and 18 checks on each WASI host. Counts `39366501786`
pass both Linux architectures. Resource-field runs `39365324259`/`39365327202`
pass 37 tests each with GCC. GC-reporting run `39368181540` passes on both Linux
and macOS architectures: Linux-only resident-memory checks now explicitly report
their restriction on macOS, and missing/failing compilers fail GC checks.

The user merged [PR #176](https://github.com/e6qu/fun-with-pipes/pull/176) as
`90f0ab9f6b30da75682f598ef5afd8f9fef7bfed` before production CI completed.
Its tree equals head `ddff413a940b2c37e6ea3349b443fe59a232d953`, and its verified
message is one line without trailers. [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39371117507)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39371117707)
now pass on that exact head; all nine production jobs and complete logs were
audited. Only duplicate post-merge runs `39372193646` and `39372193575` were
cancelled after tree verification.

## Function queues and cheaper sends (PR #175)

Checked ARC accepts queued functions whose immutable captures are proved safe.
For example, sending `add 3`, receiving it and applying it to `5` produces `8`.
Calls still need the correct state/derivative scope. Unknown functions and
resource-bearing captures remain rejected; no ownership syntax is added.
Sends move an existing owner into the queue, preserving aliases and cleanup on
failure/cancellation. A `tap` optimization also removes a temporary argument tuple.
ARC preprocessing excludes tracing routines even with GCC at O0.

[Measurements](measurements/channel-transfer-protocol.md) compare five fwp
programs at 0/16/1024 messages on Linux ARM64/AMD64. Fresh sends save one retain;
successful exchanges save one allocation request after `tap` simplification.
Shared cases retain their required owners. All ARC samples end with zero charged
storage. The report preserves code-size and stack tradeoffs; it makes no timing
or C/Rust parity claim. Loop-state tuples still allocate in this delivery.

Focused checks pass on all six native platforms and both WASI hosts, covering
aliases, closed queues, failures, cancellation and actual binaries. Full acceptance
also verifies repairs to autodiff proofs, recursive type comparisons, callback
effect inference, GCC collector exclusion and Windows output checks. Default
native mode still includes tracing; [the memory roadmap](../PLAN.md) remains open.

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) merged as
`b9cfbbe656baacf30864c8a84b0184ca683ff5b6`, with identical files to tested head
`6511a50fb99167b60f0b03a96c8a36cfa0c55e46`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39363423392)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39363423384)
passed before the squash merge; its tree and one-line message were verified.
Only redundant post-merge production `39370566486` and documentation `39370566329`
were cancelled after verification.

## Numeric hashing and integer output (PR #174)

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) merged as
`3ec71969089a7ab95ff065f7b611c74534fbe326`, with identical files to tested head
`67f233467bc68fe9a690373af219253d45f4e3f8`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39342938663)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39342938600)
passed before squash merge. The verified message is one line, 73 characters,
with no body or trailers. Only redundant post-merge production `39351187907`
was cancelled after checking the identical tree.

Eligible numeric hashes avoid repeated per-element type dispatch. Integer
printing avoids a temporary String. A GCC optimization failure exposed invalid
aliasing assumptions in five runtime object views; those views now explicitly
permit aliasing, without changing their layouts or disabling strict aliasing
globally. The original failed-head measurements remain labeled as historical.

Focused validation passed 456 tests across six native hosts and 24 tests on each
WASI runner. Separate aliasing checks covered both Linux architectures with GCC
and Clang at O1/O2/O3. Reports retain 96 hash correctness binaries, 48 allocation
measurement binaries and 144 output binaries, including actual disassembly.
The [hash/output measurements](benchmarks.md#numeric-hash-specialization) distinguish
saved dispatch/count work from elapsed time: only the repeated Linux ARM64 large
array/set cases establish separated timing ranges; other comparisons overlap.

The [final C/Rust comparison](measurements/numeric-output-peers-2026-10-20.md)
still shows gaps: its checked fwp loop costs 38.3% more median whole-process time
than C and 3.9% more than Rust, and its string workload costs 15.7%/16.5% more.
These six-sample comparisons identify work to investigate; they do not prove
universal parity, a regression from the previous delivery or complete GC removal.

## Direct integer range sets (PR #173)

[PR #173](https://github.com/e6qu/fun-with-pipes/pull/173) merged as
`eb03eb58fb642500234b9bbe647adbcf59765415`, with identical files to tested head
`3e4d0a372a79461d5482503b4d1b454ed7b7e347`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39312560218)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39312560173)
passed before squash merge. The one-line message and identical tree were checked;
only redundant post-merge production run `39328932163` was cancelled.

`range lo hi | set.from-list` writes eligible integer ranges directly into their
final buffer. For 4,096 keys, construction falls from 4,099 requests / 196,624 bytes
to one request / 32,776 bytes. Empty/descending ranges allocate nothing. Bounds
keep their order; size checks include actual 32-bit WASI execution. Boxed integers
and shared input lists keep their ordinary construction paths.

Focused checks passed 264 tests across six native hosts and 24 WASI tests per
Linux architecture. The [binary audit](https://github.com/e6qu/fun-with-pipes/actions/runs/39311772543)
checked 228 actual binaries. [Measurements](benchmarks.md#direct-integer-range-sets)
retain slower small-case medians and overlapping Windows samples. A separate
[million-key comparison](measurements/range-set-peers-2026-10-19.md) measured
tracing fwp at 6.1%/6.9% more whole-process median time than C/Rust on its Linux
AMD64 runner. This removes construction intermediates, not all collection costs.

## Compact set storage (PR #172)

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172) merged as
`c3f7f75591a0a073f443fed45855a1b084963729`, with identical files to tested head
`a6dd760904c5d72c09a5fcf720d8f255a19de1f1`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39297062257)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39297062240)
passed before the squash merge.

Sets store one word per key instead of a key plus an unused value word. Maps
keep both words. A freshly built 4,096-key integer set requests 32,776 container
bytes rather than the former layout's 65,544; empty sets skip temporary allocation.
Constants, updates, nested keys, decoders, hashing and cleanup use the new layout.
Temporary construction storage and separately allocated keys are additional.

All 41 focused tests passed on each of six native hosts, with none ignored.
The [binary audit](https://github.com/e6qu/fun-with-pipes/actions/runs/39301336981)
checked 144 executables. [Measured storage](benchmarks.md#compact-set-storage-measured-allocation-size)
records exact counts and inspected key spacing. Production also exercised WASI.
This establishes compact storage and cleanup, not a timing improvement or removal
of all collection allocations. Redundant post-merge production run `39311332528`
was cancelled only after verifying that the merged tree matched the tested tree.

## Mixed tail recursion (PR #171)

[PR #171](https://github.com/e6qu/fun-with-pipes/pull/171) merged as
`f3f3bd811c6d3935cd84fca2f7e6e877dc13c3d0`, with identical files to tested head
`13210b757db74379c4f1d9893fd0049d2e774916`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39276733207)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39276733233)
passed.

A function can now reuse its frame for eligible self-tail calls even if another
branch makes ordinary recursive calls. Tests cover a 200,000-step countdown,
shared strings, argument and trap order, cancellation, REPL linking and debugger
frames in the interpreter, native execution and WASI. Generated C and machine
code accompany the checks. Calls with work left afterward retain their frames;
resource-owning frames and mutual recursion still need separate proofs.
This establishes bounded tail transfers, not zero allocation or C/Rust speed parity.

## Acyclic nested channel ownership (PR #170)

[PR #170](https://github.com/e6qu/fun-with-pipes/pull/170) merged as
`903482e856e33f4206a04f1cd1ddf73123fc6c29`, with the same files as tested head
`142117d22e140049032dba4e2c61676210649373`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39259766176)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39259766267)
passed before the squash merge.

Checked ARC now accepts a queue containing another channel when payload types
prove that ownership cannot loop back. Native and WebAssembly tests cover aliases,
undrained queues, failure and cancellation. Both Windows checks were repaired to
use the compiler's explicit `.exe` filename for execution and symbol inspection.
The preceding run's only failures were that filename mismatch on Windows.
This removes a compile-time rejection, not allocation or reference-count work;
unknown captures and arbitrary owning cycles remain excluded. Lesson 23 explains
the accepted routing pattern.

## Static constants and complete shutdown checks (PR #169)

[PR #169](https://github.com/e6qu/fun-with-pipes/pull/169) merged as
`bbb3d530e497549316d563671f1c74c51b772934`, with the same files as tested head
`2429292d6f82d0cde46519fe7cb23c7527887e8d`.
All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39233047574),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39232286485),
[language/tools](https://github.com/e6qu/fun-with-pipes/actions/runs/39232335383)
and [Linux/ARM Mac/Intel Mac shutdown checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39232331253)
passed before the merge.

Compile-time records, arrays, maps, wide numbers and captures now use static
storage instead of retained startup heap objects. Tests check zero startup
allocation requests, immutable updates and final ARC cleanup. O0 float linking
and cleanup probes were repaired. The native runner times out stalled tests
without killing a long suite that continues completing cases. This closes the
failures left by #168; it does not remove the default tracing collector or
establish a timing improvement over C/Rust.

## Self-tail recursion and shutdown repairs (PR #168)

[PR #168](https://github.com/e6qu/fun-with-pipes/pull/168) was merged by the user
as `5258c6efd0418f19add23f5e2a763563178af823`, with the same tree as
`59845d042277a0ea04f990cb4751c6ba87aa0c1e`, before complete acceptance.
It adds eligible self-tail frame reuse in both engines, cycle-proof diagnostics,
lesson 23, scheduler disposal and network connection closure before task draining.

[Language/tools](https://github.com/e6qu/fun-with-pipes/actions/runs/39211377606)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39211352992)
passed. [Shutdown checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39211372965)
finished on Linux AMD64 and macOS ARM64: network stalls were resolved, but stricter
allocation ledgers exposed startup constants retained on the heap. Three generated-C
instrumentation anchors also matched unrelated runtime calls. PR #169 repaired
these failures and established full acceptance for the resulting code; the
original #168 merge alone was **not full platform acceptance**.
Duplicate full runs `39215835611` and `39215850976` were cancelled on this known
failing tree.

The countdown measurements compare two fwp implementations. O0 executes both
loops; O2 eliminates the recursive countdown but retains the explicit loop, so
its timings do not measure equivalent executed work. See the
[measurement method](benchmarks.md#self-tail-recursion-compared-with-an-explicit-loop).

## Accepted deliveries

Earlier deliveries established native macOS ([PR #74](https://github.com/e6qu/fun-with-pipes/pull/74)),
ownership and representation ([#124](https://github.com/e6qu/fun-with-pipes/pull/124),
[#125](https://github.com/e6qu/fun-with-pipes/pull/125),
[#126](https://github.com/e6qu/fun-with-pipes/pull/126)), numerical kernels
([#127](https://github.com/e6qu/fun-with-pipes/pull/127)), checked reference counting
([#128](https://github.com/e6qu/fun-with-pipes/pull/128)), documentation and tacit
examples ([#129](https://github.com/e6qu/fun-with-pipes/pull/129),
[#130](https://github.com/e6qu/fun-with-pipes/pull/130)), and direct iterator
consumers ([#131](https://github.com/e6qu/fun-with-pipes/pull/131)). Their original
source IDs and gate links remain in the
[immutable record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#accepted-deliveries).

The following accepted merges have the same files as their tested heads. Before
PR #136 the production matrix had fewer jobs and did not establish complete
native Windows support. From #136 onward it requires all nine production jobs
plus documentation.

| PR | What changed | Merge / tested head | Passing production / docs |
|---|---|---|---|
| [#132](https://github.com/e6qu/fun-with-pipes/pull/132) | Linux ARM64, fewer iterator temporaries and more counted values | `c67800ec` / `7036eceb` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034611), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034667) |
| [#133](https://github.com/e6qu/fun-with-pipes/pull/133) | Owned decoding results and direct wide-number functions | `d14ec10d` / `70de8497` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073356), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073506) |
| [#134](https://github.com/e6qu/fun-with-pipes/pull/134) | More C/WASM ownership, numeric foundations and Windows groundwork | `5c0287c9` / `29b48c31` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467) |
| [#136](https://github.com/e6qu/fun-with-pipes/pull/136) | Complete Windows native support, float formats, nested derivatives and checkpointing | `2684241d` / `26f2c68a` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38583750060), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38583749770) |
| [#137](https://github.com/e6qu/fun-with-pipes/pull/137) | Store/scan only the derivative prefix needed by requested outputs | `38da1401` / `37104959` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927) |
| [#138](https://github.com/e6qu/fun-with-pipes/pull/138) | Stop storing operation metadata for original derivative inputs | `d77b3fea` / `f251fbd1` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103) |
| [#139](https://github.com/e6qu/fun-with-pipes/pull/139) | Grow the active-tape table in chunks and preserve reusable buffers | `5d05cdd6` / `917d28a3` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38690176314), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38690140952) |
| [#140](https://github.com/e6qu/fun-with-pipes/pull/140) | Skip tape-table slots already known to be unavailable | `09f1a029` / `cdb76905` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38710624989), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38710579729) |
| [#141](https://github.com/e6qu/fun-with-pipes/pull/141) | Pair derivative metadata arrays to reduce allocation requests | `41f30475` / `f31f7b66` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38728631817), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38728600304) |

PR #135 was merged before complete platform acceptance. PR #136 fixed the
remaining failures and supplied the full passing gate; #135's merge alone is
not support evidence. These deliveries completed the previous implementation
batch. The remaining memory and performance objectives are in [PLAN.md](../PLAN.md).

## Interactive tools and cached-map borrows (PR #167)

Cached numeric-map reads avoid repeated retains: 2,000,001 become one in the
500,000-entry/two-million-query workload. The matching Xeon 8573C comparison
reproduces PR #166's layout penalty and measures the combined change 2.67% faster
than the old separate-layout program. These are fwp-versus-fwp results, not C/Rust
parity; [the benchmark report](benchmarks.md#rechecking-the-original-xeon-slowdown)
retains slower cases, repeated samples and binary evidence.

The delivery also adds comparisons/scalar math, a persistent REPL, local notebook,
interpreter debugger/Python SDK and generated-C/machine-code inspection. Toolchain,
timeout, target, notebook directory/port and REPL mode settings are explicit.
Guides explain parsing, compiler stages, examples and benchmark scope. Weak
references and guaranteed tail recursion were proposals at this revision;
default tracing removal remains unfinished.

- Same files: merge `e8e22f1901e5396e1bf3555073ebeb9d5c65da41`, tested `7cb899faa86d3cafb1192529d7fd357e7067ca4b`.
- Passing [nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39141587973)
  and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39141587926).
- Passing [four-host terminal probes](https://github.com/e6qu/fun-with-pipes/actions/runs/39141595653)
  and [language, Python, disassembly and browser checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39141618594).
  Cross-target object inspection is not evidence of native execution.

## Numeric map and set construction (PR #166)

Numeric map/set construction skips temporary lists and eligible tuples, calls
known callbacks directly, and joins related buffers. At 65,536 inputs with at
most 257 keys, map requests fall 196,614 → 5 and set requests 131,077 → 4.
An unnecessary second compiler build caused the Intel macOS timeout and was
removed without reducing coverage. **At this revision, Xeon 8573C full-map tracing
was 4.4–4.6% slower**; allocation savings do not resolve that result. Cached-map
borrowing candidate `774d838c` is not part of this merge. PR #167 above supplies
the subsequent implementation and matching-host repair evidence.

[PR #166](https://github.com/e6qu/fun-with-pipes/pull/166): merge `de678a7d42af803948835cfbc43b4862b63164da`, tested `91c8923fa68a754c29b85eb963f7f3b965b158d8`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626103) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626314) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Owned C results and failure cleanup (PR #165)

C callers can own returned strings/records and release them with
`fwp_release_NAME`. Returning two aliases needs one extra owner; eligible record
fields return directly without a temporary box. Read-only inputs still copy.
Failed map/set callbacks and allocations now release partial output: 32 caught
failures leave zero bytes instead of 2,048. Windows DLL exports, toolchains,
newlines, executable paths and cancellation fixtures were repaired before the
final gate; six original production failures and eight focused failures were
not counted as passes.

[PR #165](https://github.com/e6qu/fun-with-pipes/pull/165): merge `695907781c5efff02e0f202f8b7fa99283df5ef4`, tested `836f39b30079ec52f56b41d81baf468e8384a71b`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39094927776) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39094927727) pass; merged files match.

Evidence: [library-results-2026-10-18](measurements/library-results-2026-10-18.json), [map-failures-2026-10-18](measurements/map-failures-2026-10-18.json).

## Server entries, exact JSON and WebAssembly task owners (PR #164)

Generated REST and MCP entries can use checked ARC. JSON keeps number text until
conversion: large integers and F128 values no longer lose precision through F64.
WebAssembly task cleanup frees the last state snapshot and pooled stacks;
browser-loader callback exceptions propagate once. Loader tests run in Node,
so actual browser-engine coverage remains open. Native cache keys now include
compiler/header identity. CSV goldens, Intel scheduling and a failed artifact
upload were repaired/retried before acceptance. The scheduling report is a
simulation, not a measured speedup.

[PR #164](https://github.com/e6qu/fun-with-pipes/pull/164): merge `25f95f9c6cb157b7f4e2d74760f6f1e27be83f47`, tested `a845e0c5e9a37dad185c99566ddc6ce413b4293b`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39087594221) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39087594154) pass; merged files match.

Evidence: [server-entries-2026-10-18](measurements/server-entries-2026-10-18.json), [wasm-host-owners-2026-10-18](measurements/wasm-host-owners-2026-10-18.json), [ci-scheduling-2026-10-18](measurements/ci-scheduling-2026-10-18.json).

## HTTP server owners and fixed function storage (PR #163)

HTTP request/connection/task owners now clean up on failure and cancellation.
A 24-byte combined handle replaces separate handle/job allocations; a 64 KiB
receive buffer moves to the stack. Socket waits use readiness and deadlines.
Keeping one copy of the existing ARC check reduces code size without removing
checks. Fixed function captures use static records: approximately 899 → 722
allocations and 2,318 → 1,901 retains per HTTP request. Paired Linux request
measurements are 4–6% faster than older fwp, not a C/Rust comparison. Failure
injection and UDP counter fixtures were repaired before acceptance.

[PR #163](https://github.com/e6qu/fun-with-pipes/pull/163): merge `0a468c9d0ee3283bd5de6a7cbc05126379ed3ee5`, tested `c998ce68b6beff90b0ba1097e92ede7a154f00f3`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022259) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022233) pass; merged files match.

Evidence: [fixed-functions-2026-10-18](measurements/fixed-functions-2026-10-18.json).

## HTTP client owners and complete connection keys (PR #162)

HTTP clients own pooled connections, requests and copied responses through
errors/cancellation. Full connection keys distinguish long TLS options.
Repeated-call memory is bounded in the measured interval, but each extra call
still costs 237 allocations and 543 retains. ARC code is larger in this revision;
later shared-check placement addresses that. Windows socket/loading/header-order
fixtures and a stale cleanup injection were fixed before the full passing gate.
HTTP server acceptance follows in #163.

[PR #162](https://github.com/e6qu/fun-with-pipes/pull/162): merge `1b542f32f352ecd34553f17fcce2de25b6f0bbb2`, tested `99d70deb9c9daa8fc041964f9cbee51e48047c38`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39055466891) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39055442588) pass; merged files match.

Evidence: [http-client-owners-2026-10-17](measurements/http-client-owners-2026-10-17.json).

## Remote calls without tracing and record-field moves (PR #161)

Checked ARC now covers supported gRPC clients and services, including replies,
channel deliveries, errors and iterator handler lifetimes. Unique record fields
move into compiled calls; shared records retain independent owners. A greeting
needs two retains instead of three, plus one per connection. Memory counts stay
bounded, but code size grows; no elapsed-time or C/Rust parity claim follows.

[PR #161](https://github.com/e6qu/fun-with-pipes/pull/161): merge `fd25a10c`, tested `0e162dcd7544c9fce9aede02f9196fc061e6d258`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644736) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644846) pass; merged files match.

Evidence: [remote-arc-field-moves-2026-10-17](measurements/remote-arc-field-moves-2026-10-17.json).

## Server cleanup and borrowed fold values (PR #160)

Server tasks, jobs, method values, channels, requests and connections gain
explicit cleanup. For example, 256 greetings no longer leave per-call storage;
final charge is 544 bytes on Linux and zero on the other measured platforms.
Known fold callbacks borrow captures, removing 64 retain/release pairs per
64-message channel call. A separate 32,000-call ARM64 test exposed process-memory
growth missed by narrower counters; the complete repair passes its unchanged
8 MiB growth bound.

[PR #160](https://github.com/e6qu/fun-with-pipes/pull/160): merge `8ae595df`, tested `a8fa519d`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633846) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633906) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Streamed input cleanup and continuation moves (PR #159)

Remote clients release sent iterators, background senders and completed tasks.
Unique iterator nodes move their continuation (the function producing the next
node); shared nodes preserve it. Repeated-call storage becomes bounded, but
complete-input modes still perform 5.7–36.8% more retains than the old
tracing-dependent implementation. Those percentages measure count operations,
not elapsed time. Early completion records actual input work because scheduling
can change how much is sent.

[PR #159](https://github.com/e6qu/fun-with-pipes/pull/159): merge `7c463441`, tested `91398527`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595534) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595480) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Closed connections and completed I/O tasks (PR #158)

Closing a socket now also leads to release of connection/task records after
their last users finish. Previously 256 closed Linux AMD64 connections left
about 1 MiB charged; afterward only the live root-task remainder stays.
Shared connections add three retains per connection; uniquely owned internal
tasks free without task count updates. Failure/cancellation and recoverable TLS
startup errors remain covered.

[PR #158](https://github.com/e6qu/fun-with-pipes/pull/158): merge `a96871c9`, tested `30036a15`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071759) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071706) pass; merged files match.

Evidence: [closed-remote-ownership-2026-10-17](measurements/closed-remote-ownership-2026-10-17.json).

## Freed requests and transferred selected fields (PR #157)

Completed requests and unread messages free when their owners finish, without
turning reader release into remote cancellation. A unique record can transfer
its selected owned field; shared records retain it. At 256 full reads, the
combined path uses 50,178 retains rather than 66,562 after request cleanup alone.
Allocation counts are unchanged. TLS-settings partial-construction cleanup is
also checked.

[PR #157](https://github.com/e6qu/fun-with-pipes/pull/157): merge `30668bf8`, tested `57d2a09e`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/39004098429) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39004095234) pass; merged files match.

Evidence: [remote-projection-moves-2026-10-17](measurements/remote-projection-moves-2026-10-17.json).

## Released stream caches and moved closure captures (PR #156)

Remote stream positions now own and release their saved values after the last
reader. Retaining an old iterator deliberately keeps its history. Unique closures
move captures into calls instead of retaining them again; shared closures keep
separate owners. At 16,384 received integers, retain counts fall from 81,921 to
49,154 versus cache ownership alone. Counts remain higher than the earlier
tracing-dependent path; connection/queue ownership follows in later deliveries.

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156): merge `29302bae`, tested `d19ab045`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879616) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879603) pass; merged files match.

Evidence: [remote-client-capture-moves-2026-10-17](measurements/remote-client-capture-moves-2026-10-17.json).

## Shared remote reads and bounded chain cleanup (PR #155)

Repeated reads of a remote position preserve the same value. Combining its
unread source and completed result saves eight bytes per position (24 → 16).
Record/optional/tuple chains release through loops rather than one recursive
cleanup call per link, with aliases preserved. This bounds the measured cleanup
stack growth; it does not guarantee constant stack for arbitrary source recursion.

[PR #155](https://github.com/e6qu/fun-with-pipes/pull/155): merge `45410bea`, tested `e71a2295`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872293) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872208) pass; merged files match.

Evidence: [remote-stream-compact-2026-10-17](measurements/remote-stream-compact-2026-10-17.json), [wrapped-chain-cleanup-2026-10-17](measurements/wrapped-chain-cleanup-2026-10-17.json).

## Service settings and iteration storage (PR #154)

Service settings and outgoing headers get scoped owners; eligible captures and
argument storage avoid heap records. `each` walks with a fold instead of building
and discarding a mapped result list. A million-element counting example uses
about half the elapsed time and one fewer result-node allocation per element
than the repaired old-definition control. The first attempt was slower; known
callback specialization resolved that measured regression.

[PR #154](https://github.com/e6qu/fun-with-pipes/pull/154): merge `11ae0f63`, tested `51354d10`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38977201910) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38977126983) pass; merged files match.

Evidence: [service-context-iteration-2026-10-16](measurements/service-context-iteration-2026-10-16.json).

## Owned decoded values and network resources (PR #153)

Decoded values, DNS/socket results and temporary network buffers gain explicit
owners and partial-failure cleanup. CPU tensor execution writes directly to its
result array: 8,193 F64 outputs no longer need a separate 65,544-byte temporary
and full copy. Input/workspace storage remains; this was a memory comparison,
not a timing comparison with C/Rust.

[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153): merge `9bf203d7`, tested `f6dc9940`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38958379514) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38955543617) pass; merged files match.

Evidence: [service-values-2026-10-16](measurements/service-values-2026-10-16.json).

## Less temporary memory in hashing and numerics (PR #152)

Hash pipelines avoid temporary tuples/range lists and borrow array fields.
For the measured small/large hash programs, surrounding managed requests become
two and retains zero. Fixed numeric lanes eliminate eligible list/product/splat
storage; actual loops use registers/vector instructions. Paired C/Rust reports
retain remaining overhead and slower samples. These specific programs do not
establish free abstractions for arbitrary vectors or callbacks.

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152): merge `1fa0fec6`, tested `48566579`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011355) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011298) pass; merged files match.

Evidence: [vector-paired-2026-10-16](measurements/vector-paired-2026-10-16.json).

## Synchronous WASI ownership and streaming hashes (PR #151)

Synchronous WASI main/function/CLI entries can use checked ARC and release
module-owned values at shutdown. Native structural hashing feeds bytes directly
into FNV-1a instead of allocating an encoded buffer; output still agrees with
the interpreter. Hash-buffer allocation disappears, while surrounding pipeline
costs remain at this revision.

[PR #151](https://github.com/e6qu/fun-with-pipes/pull/151): merge `3dff03b6`, tested `27cdc7ff`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161681) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161673) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Numeric zip intermediates and owned list/text results (PR #150)

Known numeric `zip | map` pipelines avoid temporary pairs and zip list nodes.
Returned lists still need storage. List/text constructors gain owned-result and
failure cleanup; WASI size checks preserve 32-bit request limits. Derivative
allocation/count savings are measured separately from timing; small cases can
still be slower.

[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150): merge `729db67f71386750aad0bbe477f546e5276b0223`, tested `7a7b40e1878ea062f64eceded6ae029b4124f976`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415) pass; merged files match.

Evidence: [zip-maps-2026-10-16](measurements/zip-maps-2026-10-16.json), [zip-map-cpu-2026-10-16](measurements/zip-map-cpu-2026-10-16.json).

## Owned processes and numeric mapped arrays (PR #149)

Process/pipe results and interrupted operations gain cleanup with correct signal
behavior. Numeric `map | array.from-list` skips temporary mapped list nodes while
preserving callbacks and traps. Direct numeric work improves substantially;
repeated derivative and tiny nested cases have their own mixed timings. Windows
process probes use native executable and handle rules.

[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149): merge `58ed740cc785382b0cd818d4af970a1fa49516e6`, tested `5748f7496a8f1db0e93145c53e380a0703affc2f`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Record moves and application utilities (PR #148)

Unique flattened/boxed records transfer fields; shared aliases keep owners.
Working-directory, clock, empty-map/set and Boolean results get checked ownership.
Missing directories report errors in both engines and logs emit one newline.
The matrix output-pointer experiment was not adopted: smaller code did not give
a dependable speed improvement.

[PR #148](https://github.com/e6qu/fun-with-pipes/pull/148): merge `853d6669dbf7dea78483376865190c218c9fece6`, tested `93b1741abcf5ab2a61460746c0077564e0328c0e`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Numerical precision and filesystem ownership (PR #147)

Six F64 solvers own scratch/results, and array loops borrow invariant data
addresses. Reverse differentiation preserves F128 seeds, weights and accumulated
derivatives without narrowing through F64. Console/environment/filesystem results
clean up on failure; paths reject embedded zero bytes before OS access. This
preserves precision and ownership, not universal numerical speed parity.

[PR #147](https://github.com/e6qu/fun-with-pipes/pull/147): merge `c9127d2d`, tested `71c612d0`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38814786923) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38814787519) pass; merged files match.

[Benchmark guide](benchmarks.md) explains the relevant measurements and limits.

## Checked boundaries and numerical kernels (PR #146)

Checked C-library calls initially accept copied inputs and pointer-free results;
later #165 adds owned strings/records. Channel payload restrictions reject values
that could capture the channel. List transpose cleans partial columns; allocator
charging includes its first small allocation. Fixed-size copies expose matrix
vectorization and proved taskless programs omit scheduler ticks. An Intel
compiler abort passed an unchanged retry; its historical cause remains unknown.

[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146): merge `be890914`, tested `19b14d0b`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349640) pass; merged files match.

Evidence: [numerical-memory-modes-2026-10-15](measurements/numerical-memory-modes-2026-10-15.json).

## Infix arithmetic and numeric loop cleanup (PR #145)

`2 + 3 * 4` now uses standard mathematical precedence while functions remain
curried and single-argument. Proven bounded internal array increments avoid
per-element cleanup; ARC omits tracing liveness barriers. Benchmark order is
rotated, and tutorial source/output copies agree again. The sampled fused
reductions allocate no intermediate storage; changed timing methods prevent an
isolated before/after speed claim.

[PR #145](https://github.com/e6qu/fun-with-pipes/pull/145): merge `e51b8570`, tested `1ee7d581`.
[Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284746) and
[docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284697) pass; merged files match.

Evidence: [ownership-performance-2026-10-15](measurements/ownership-performance-2026-10-15.json).

## Documentation rewrite (PR #142)

The guides/tutorials gained introductory explanations and explicit C/Rust
benchmark baselines. Tutorial fixes also repaired a C-buffer leak and incorrect
bill-remainder distribution. Merge `bbdbf8dc` matches PR head `4ea1b687`, but
was made **before CI finished**. The [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/38752839908)
found a stale OpenAPI description expectation; [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38752840023)
also has its own record. PR #143 supplied the fixture repair; later accepted
#145 includes the corrected documentation/tutorial checks. The early merge
itself is not passing platform evidence.

## Accepted paired metadata allocations (PR #141)

[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141) merged as
`41f30475c5e59951e784fe686aa6c69c7f2738e3`. Its tested head was
`f31f7b66b8ea625c86161cf2978732bcd9be310d`, with identical files.
[Four-platform derivative tests](https://github.com/e6qu/fun-with-pipes/actions/runs/38726490082)
and [both WebAssembly checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38726508454)
passed at runtime revision `24620eadbcc8c03fa1aefc2190bf1af483720840`.
The final production/docs gates are in the table above.

[Recorded measurements](measurements/ad-metadata-2026-10-15.json) compare two fwp
storage layouts. Pairing buffers reduces allocation requests, but growth copies
more bytes in some cases. Timings are mixed, including regressions; the
[benchmark guide](benchmarks.md#paired-autodiff-metadata-allocations) states the
comparison and limits. This is not a measurement against another language.

## Earlier records

[The pre-cleanup record](https://github.com/e6qu/fun-with-pipes/blob/de678a7d42af803948835cfbc43b4862b63164da/docs/roadmap-history.md)
retains detailed gate audits, test counts and resolved development failures for
these deliveries. Commit identities and measurement files are preserved here;
obsolete next-action instructions are not carried forward.


[The immutable historical snapshot](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md)
retains earlier development runs, recovery details and superseded instructions.
The [measurement index](benchmarks.md#measurement-report-index) links the raw
reports that still support current claims. Consult the live plan for new work.
