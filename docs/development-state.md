# Session handoff

Updated 2026-10-14. The user merged [PR #134](https://github.com/e6qu/fun-with-pipes/pull/134).
Continue the remaining directions in [PLAN](../PLAN.md) from that merged baseline
on `roadmap-after-134`, [PR #135](https://github.com/e6qu/fun-with-pipes/pull/135).
The user authorized all remaining work together in this one draft PR. Publication, fixes and squash
merge after passing final-head CI remain authorized. Every commit has one line,
at most 80 characters, with no body, trailers or attribution. Failing tests are
work to fix; queued CI gates merging, not implementation.

## Baseline and scope

PR #134 merged as `5c0287c959ad705a6ceefebe83346015cb23fff5`; tree
`f6f70ed9e41cde021ba223241f59b7cee745b4b0` equals tested head
`29b48c31a7012c941d0bc555ee51d12c2c594b0b`. All seven Linux/macOS production
jobs and documentation passed. [History](roadmap-history.md#pr-134-merge-closeout)
records exact runs. The merge delivers the implemented subset, not completion
of the original six-item scope. Linux/macOS ARM64/AMD64 packages remain supported;
full Windows and true half/quad language formats remain unfinished.

## Active bundle

| Step | Status | Implemented and still required |
|---|---|---|
| 1 | Implemented | One live handoff, accepted baseline and historical evidence; remove stale next actions |
| 2 | In progress | Retained-task/scoped foreign proofs pass four hosts; CLI/protocol owners and checked executable ARC implemented, runner proofs pending |
| 3 | In progress | Wide numeric records measured on four hosts; tail loops and direct array producer fusion implemented, final verification remains |
| 4 | Pending | Measured kernel/layout improvements, nested reverse differentiation and checkpointing |
| 5 | In progress | Exact scalar values, inline arrays, closed quad workers and protocol v2 implemented; C ABI, numeric record workers and complete ownership/platform acceptance remain under validation |
| 6 | In progress | Native Windows allocator/fiber/socket probes pass both architectures; complete generated resources/runtime, TLS and PE acceptance remain |

The [float contract](float-formats.md) is authoritative. The accepted PR #134
baseline aliases F16/BF16 to F32 and F128 to F64. PR #135 is changing scalar
values, parsing, math, text/JSON and protocol encoding to real formats; these
changes are under development and not yet accepted by runner validation. Migrate both engines, arrays/workers, ownership,
foreign ABI, text and versioned wire encoding together; do not publish partial
format support or silently narrow quad values. Nested reverse mode and
checkpointing are not implemented.

## Current implementation

The merged baseline admits scalar foreign-C ARC via the ABI classifier; the
active bundle extends scoped strings and callbacks as described below. WASM typed last-owner destruction
removes count metadata before libc free, including closed File headers.
Unproved shared/cyclic graphs remain retained. Direct `iter.iterate` fusion
preserves eager lookahead, effect/trap order, early stopping and owned captures.
[History](roadmap-history.md#pr-134-development-evidence-not-final-acceptance)
links the four-platform proofs and scoped allocation/instruction measurements.

Windows Rust uses native socket handles/WSAPoll and owned DLL lifetimes.
Generated C allocation uses VirtualAlloc/VirtualFree, actual commitment/reuse,
monotonic timing, working-set accounting and PE writable-section roots with a
missing-root negative control. LLVM-MinGW UCRT assets are hash-pinned; Rust's
MSVC target separately uses SDK-aware Clang. Generated C tasks now use Windows fibers with explicit suspended register/stack
roots, demand-committed stacks, native console shutdown and overflow handling.
Native probes pass both architectures for each root range independently,
floating-point state, reclamation, host-owned fibers and full-width sockets.
Windows UTF-16 filesystem/environment/arguments, binary standard streams, native
threads/clocks and CreateProcessW capture are now implemented. Generated-program
execution passes ARM64; AMD64 has the task GC verification failure below.
Windows OpenSSL dependency setup, COFF linking and PE package inspection are now
implemented, pending native execution. Static-memory reservations remain unfinished.

SoftFloat 3e, scoped gdtoa and TLFloat 1.15.0 are vendored with licenses,
provenance and recorded patches. The shared core has exact half/bfloat/quad
arithmetic, direct decimal rounding/shortest text, full-width integer conversion,
comparison, ties-away integral rounding and truncating remainder. Transcendentals
have an explicit 1-ULP contract and fixed integer storage. Arithmetic NaNs are
canonical; bit transport preserves payloads. Decimal calls use 4 KiB stack
scratch and release overflow storage on success/failure. Math object checks
reject allocator/C++ runtime dependencies; UBSan has an omitted-guard control.

Tokens/AST preserve decimal text until monomorphization. `SFloat` now carries
an unsuffixed decimal String, with matching validation/rendering in both engines.
The public macro API change is documented. `float_literals` checks formatting,
macro expansion and raw/native O1/O2 behavior at a known F32 rounding boundary.

## Validation

- All seven final-head production jobs passed in
  [38460359221](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221):
  Linux ARM64/AMD64, regular and GC-stress macOS ARM/Intel, and bench.
  [Final-head docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467)
  also passed. The merged tree is identical to this tested tree.
- All four focused repair jobs passed at `5bad4a6` in
  [38458280091](https://github.com/e6qu/fun-with-pipes/actions/runs/38458280091),
  including the corrected raw/native child-signal status assertions.
- Both native Windows diagnostic jobs passed at `02a802d` in
  [38457143007](https://github.com/e6qu/fun-with-pipes/actions/runs/38457143007).
  These cover Rust/compiler/socket/DLL, exact math C ABI, allocator and interpreter
  goldens; they do not establish the unfinished Windows C runtime or packages.
- Both focused WASI jobs passed at `412a813` in
  [38455262012](https://github.com/e6qu/fun-with-pipes/actions/runs/38455262012),
  including math C ABI, resource controls and full goldens. Final production CI
  also passed its required WebAssembly checks.

Merge-closeout local check passed: `python3 scripts/local-guard.py python3
scripts/check-roadmap.py` (48 doc link sets, 106 immutable anchors, six plan
steps and commit-message checks).

The known Windows header, sharder, WASI loader and CLI assertion failures are
fixed. Older failures/cancellations remain historical evidence, not current next
actions. Full builds/suites/benchmarks stay on runners. Local checks must use
`python3 scripts/local-guard.py` and retain the 64 GiB free-disk, 2 GiB target,
1 GiB RSS and 180-second limits. Do not use the stale local compiler as an oracle.

## Active implementation

PR #135 includes exact scalar values/arithmetic, direct decimal rounding,
text/JSON, 2/2/16-byte protocol v2 payloads and versioned fingerprints. F128
arrays store inline bits, with independent owned boxes at escaping boundaries;
half/bfloat worker fields use u16 bits. Closed quad numeric workers use direct
bit-struct arithmetic without intermediate boxes. Generic quad values still box. Closed flat numeric record workers now carry
F128/I128/U128 fields directly in C structs; boxed entry/exit copies bits, drops
incoming owners and protects partial returned records. Raw/native/trap-order and physical lifetime checks pass four hosts.
Four-host measurements now pass, with permanent evidence below. Nested or
non-numeric record fields continue through ordinary typed lowering.

The C ABI uses explicit u16 half/bfloat bits and a two-word quad struct, including
shim records/callbacks and pointer widths. ARC uses the same recursive pointer-free
C value classifier. Raw foreign pointers and callbacks returning managed C addresses still need
lifetime proofs. Scoped text/byte borrows, copied string results and synchronous
callbacks carrying C value bits are now implemented with task-local contexts and
unwind cleanup; physical-reclamation, reentry, suspension and cancellation
controls pass the four-host focused run below; final-head acceptance remains.
C/C++ core archives are keyed by source/toolchain/target/options; emitted C has
companion core sources. Cache pinning protects already-open archives from concurrent
eviction. Cache concurrency, manual linking and library exports pass focused four-host
checks; final-head acceptance remains.

Array builders protect initialized elements, temporary escaping elements and fold
accumulators through failure. Consumed updates, view headers and sort scratch also
have cleanup owners. The new nonreturning `fail` ownership contract corrects an
ARC rejection for boxed result types; it does not manufacture a normal result.

Retained-task ARC controls now pass focused four-host execution. Child callbacks start with fresh
State/AD contexts in the closure-flow proof. Typed handles/captures/results are
acyclic when channels and raw pointer mutation remain excluded. New controls cover
aliases, older captured handles, independent State, cancellation before/after entry,
scope failure and physical reclamation without collection. No general cyclic or
external-callback admission is claimed.

## Active checks

- Both native Windows jobs passed at `4456bff` in
  [38532228460](https://github.com/e6qu/fun-with-pipes/actions/runs/38532228460),
  including actual fiber register/stack omission controls, host-fiber preservation,
  full-width socket/error/transfer probes and the prior interpreter/math/allocator
  checks. This corrects the earlier hidden SDK declaration. The next batch adds
  complete generated numerics/tasks, Unicode files/arguments and simultaneous
  stdin/stdout/stderr capture at O1/O2 with GC stress and reuse verification.
- Four-host wide scalar/record measurements passed at `4456bff` in
  [38532221118](https://github.com/e6qu/fun-with-pipes/actions/runs/38532221118).
  [Permanent reports](measurements/wide-records-2026-10-14.json) retain hardware,
  exact build commands, hashes, all counters and timings. The 256-step scalar
  workloads reduce managed allocation requests from 513 to 2; mixed records from
  3,878 to 48 and retains from 4,625 to 12. All finish with zero charged live
  bytes and zero collections. Record peak live bytes remain 1,040 in both variants.
  ARM macOS disassembly still has recursive 144-byte worker frames; Linux AMD64
  makes a loop using registers and stack slots. This is not zero stack usage or
  a universal speed claim. Broader fusion remains. Explicit worker tail lowering is now implemented;
  its bounded-stack/preemption controls and fresh measurements await runners.
- That run passed both full focused Linux jobs and all ownership/socket controls
  on macOS, but macOS TLS fixtures failed certificate verification. The bundle
  workflow lacked the OpenSSL 3 CLI path that the passing portability workflow
  already supplies. The corrected path passes the later macOS ARM focused job;
  final-head gates on both macOS architectures remain required.
- Native socket code carries one full-width handle type through tasks, HTTP/2 and
  gRPC. TLS uses OpenSSL's documented Windows `SSL_set_fd` cast at its ABI
  boundary, matching the interpreter; the unnecessary custom BIO is removed.
  Both engines now check attachment failures and release the session.
  TLS accept initialization failure closes its connection.
  Complete Windows TLS acceptance still needs dependencies and native execution.
- Native Windows ARM64 passed complete generated numeric/task/filesystem and
  Unicode process capture checks at O1/O2 with stress/reuse controls at `a6f4875`
  in [38536578700](https://github.com/e6qu/fun-with-pipes/actions/runs/38536578700).
  AMD64 passed ordinary execution but failed GC stress: the process argument
  list became cyclic before quoting, and tasks reported missed live roots.
  Windows frame pointers can sit below higher locals in large frames. The
  collector now uses the OS stack upper bound even before task initialization;
  a native omitted-bound control independently checks a higher live stack slot.
  This fix still needs native execution. The earlier harness wrongly required
  success from the numeric golden's deliberate exit 101; corrected comparisons
  cover status and both streams. Native stderr now uses binary mode too.
- Direct numeric self-tail calls evaluate every argument into temporaries before
  updating parameters and jumping to the worker entry, with a tick per iteration.
  [38535804207](https://github.com/e6qu/fun-with-pipes/actions/runs/38535804207)
  at `0fe4e2f` exposed the raw interpreter's recursive stack limit in the new deep
  test. The reference now uses 33 swaps; native execution must produce the same
  odd-swap result for 32769 iterations on a 1 MiB task stack. Deliberately restored
  recursion and omitted ticks remain required negative controls. The inspected
  macOS ARM job passed the corrected TLS checks and new allocation measurements;
  the corrected tail test still needs execution on all four hosts.
- Executable calls now borrow typed inputs through immutable static closures,
  preserve owned results while joining tasks, and release the complete result
  after projecting/printing nested Outcome/Result/Option/list payloads. Raised
  error values and binary encoding scratch also have unwind cleanup. A new
  raw/native test checks repeated borrowed input aliases, physical allocation
  balance without collection, GC stress and an omitted-result-drop control.
  Guarded focused lint and runtime syntax pass; runner proof is pending.
  CLI parsing and executable commands now also own arguments, overwritten flags,
  defaults, diagnostics, streamed values, frame buffers and partial results.
  Command scope cleanup closes transport sockets and releases SHM mappings,
  including a fixed invalid-header mapping leak. Checked ARC admits native main
  and function executables and analyzes every exported entry without assumed
  State/AD context. Tests compare raw CLI behavior, malformed input, repeated
  streams and early help/error returns, with physical reclamation and omitted
  release controls. Focused lint and runtime syntax pass; execution is pending.
  Remote, service, library and WASM boundaries remain outside this admission.
- [38538174843](https://github.com/e6qu/fun-with-pipes/actions/runs/38538174843)
  at `55addedb` passes the new Windows active-stack-bound probe on AMD64 and
  fixes its process argument stress failure. AMD64 tasks still report a missed
  root under GC verification; investigate the marking/root snapshot before
  acceptance. ARM execution passed. The four-host run
  [38538182945](https://github.com/e6qu/fun-with-pipes/actions/runs/38538182945)
  was still running when checked. Its macOS ARM tail/preemption, existing
  ownership and TLS tests passed; the new invocation fixture used `cons`
  instead of `Cons`. That fixture and its loose reference status assertion are
  corrected. Neither run is a passing final-head gate.
- GC marking and minor verification now use the same application stack range.
  Previously the second trace included deeper collector frames and their
  transient heap addresses. A native probe deliberately puts an unreachable
  address in collector scratch, checks that real caller roots survive, and
  restores the old range as a negative control. This candidate fix needs native
  execution, including the Windows AMD64 task stress failure. Guarded allocator
  lint, formatting and combined runtime C syntax passed.
- CLI/protocol local checks passed under `python3 scripts/local-guard.py`:
  `cargo clippy --lib --bin fwp --test cli_ownership --test exec_protocol_ownership
  --test exec_invocation_ownership --test arc_execution -- -D warnings`,
  `cargo fmt --all`, combined TLS/service runtime C syntax, and
  `python3 scripts/check-roadmap.py` (48 link sets, 106 anchors, six steps).
- Runs [38541513652](https://github.com/e6qu/fun-with-pipes/actions/runs/38541513652)
  and [38541517041](https://github.com/e6qu/fun-with-pipes/actions/runs/38541517041)
  at `75274a5` found four stale unit-test callers after executable ARC added
  explicit entry lists. They are fixed, with an independent-entry scope test;
  guarded `cargo clippy --lib --tests -- -D warnings` now passes. Those failed
  compiler checks did not execute the collector repair or ownership proofs.
- Windows full preflight now pins vcpkg/OpenSSL sources, requires TLS fixtures,
  verifies dependency PE architectures and links COFF import libraries without
  rpath. It adds complete native goldens and out-of-checkout package execution
  for tracing/ARC plus exact half/quad arithmetic. PE inspection rejects
  non-system DLL dependencies in standalone compiler/generated smoke binaries;
  release Rust uses a static C runtime. These checks are implemented, unverified.
  Guarded TLS/compiler lint, Python syntax and formatting passed.
- Direct `array.to-list | iter.from-list` chains now retain the source array
  and advance an index, removing list materialization and tail dispatch.
  Array construction still precedes consumer work. Controls cover empty arrays,
  retained aliases, quad views, callback failure, State order and early stopping;
  checked ARC must reclaim arrays/children without collection, and omitted
  physical freeing must fail. Measurements compare producer/consumer switches
  and inspect generated loops plus native instructions. Implementation pending
  runner execution; guarded focused compiler/test lint passed.
- Linux transport ownership now has a native descriptor/mapping probe: real
  socketpair/SCM_RIGHTS transfers, repeated ring teardown, rejected headers and
  changed peer capacity. Invalid descriptor messages now close every received
  descriptor, including a second descriptor fitting in control-message padding
  and truncated multi-descriptor offers. Restoring omitted unmap/socket/extra-fd
  cleanup must fail.
  This is a pending proof, alongside full executable pipeline regressions.
- CLI environment flags now share the Windows UTF-16 conversion used by ordinary
  environment reads; an explicit Unicode fixture checks raw/native agreement.
  All parsed text remains counted and releases on success and failure. Pending
  Windows execution; combined runtime C syntax passes locally under the guard.
- Current runner batches at `6fde679d` are
  [38542604291](https://github.com/e6qu/fun-with-pipes/actions/runs/38542604291)
  (four-host ownership) and
  [38542607906](https://github.com/e6qu/fun-with-pipes/actions/runs/38542607906)
  (native Windows TLS/resources/packages). Both were running when checked.
  The later array-producer, transport-omission and Unicode-flag changes still
  need their own head execution. Guarded `cargo clippy --lib --tests -- -D warnings`
  and formatting pass after those changes; full execution stays on runners.
- At `dfca8e6`, all four Linux/macOS hosts passed exact-format/protocol/array
  tests and all seven foreign ABI/export tests in
  [38527790040](https://github.com/e6qu/fun-with-pipes/actions/runs/38527790040).
  The only failures were reversed `compose` arguments in the new task and
  foreign lifetime fixtures. `9aed34b` corrects their left-to-right order.
- [38528964109](https://github.com/e6qu/fun-with-pipes/actions/runs/38528964109)
  at `9aed34b` passed all combined task/foreign lifetime and numeric record
  worker regressions on all four hosts. Its measurement step expected fixed
  decimal text instead of the specified shortest quad text (`3.2896e4`). That
  assertion is corrected and the later measurement run above passes.
- All four hosts passed manual exact-core linking and concurrent core-cache
  publication/reuse/eviction at `3800499` in
  [38526720651](https://github.com/e6qu/fun-with-pipes/actions/runs/38526720651).
  Later scalar/ABI changes still need final-head production verification.
- At `bb523a5`, both actual WASI jobs passed in
  [38523463736](https://github.com/e6qu/fun-with-pipes/actions/runs/38523463736),
  including goldens, core math and physical reclamation. Both native Windows
  foundation jobs passed in
  [38523466974](https://github.com/e6qu/fun-with-pipes/actions/runs/38523466974).
  These Windows checks do not establish the generated runtime or packages.
- Guarded focused lint passed for the compiler and the `wide_workers`,
  `arc_tasks`, `foreign_callback_ownership`, `arc_execution`, `ffi`,
  `float_linking`, `array_unwind_ownership` and `windows_context` targets.
  `python3 scripts/local-guard.py cargo fmt --all -- --check` and guarded
  concatenated runtime C syntax checking passed after the fiber integration.
  Guarded `cargo clippy --lib --bin fwp --test windows_runtime -- -D warnings`
  and combined TLS/service runtime C syntax also pass for the resource port.
  The Windows-only probes are excluded on macOS; only native Windows execution
  can verify it. Guarded Python syntax checking passed for `measure-wide.py`.

## Next action

Next: fix the remaining native Windows AMD64 task GC verification failure.
Run full CLI/protocol ownership and corrected numeric tail/preemption controls
on all four Unix hosts, including physical reclamation and omitted-release
controls; prove Linux transport descriptor/mapping teardown separately. Finish
final-head ABI/cache acceptance. Keep raw/native agreement and exact rounding.
Then complete Windows static memory/TLS/PE packages, broader ownership/worker
proofs, and nested reverse differentiation/checkpointing with measured layout
improvements. Documentation closeout is complete; five implementation areas
remain. Do not replay the merged core/fusion/reclamation work.

Use focused dispatched checks during implementation. Require all Linux/macOS
production jobs, added Windows acceptance jobs and docs on the final follow-up
head before squash. Skipped, cancelled or superseded runs do not establish that
gate. No universal GC-free, allocation-free or C/Rust speed claim is justified.
