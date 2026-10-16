# Session handoff

Updated 2026-10-16. Independent preparation in `/private/tmp/fwp-wasi-arc`,
branch `checked-wasi-ownership`, anchored at `e5e05748`. Transfer only changes
**after** that anchor once #150 is accepted. Its parents predate #150's Windows
fixture repairs; never replay them or replace those repairs during transfer.

[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149) is accepted as `58ed740c`.
The only open delivery is [#150](https://github.com/e6qu/fun-with-pipes/pull/150),
head `7a7b40e1878ea062f64eceded6ae029b4124f976`. Production
[38851567232](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232) is
running; [docs 38851565415](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415)
passed. The root worktree owns that final gate. This preparation has no PR.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs plus documentation pass for the exact final head. Subjects are
one line, at most 80 characters, with empty body and no trailers/attribution.
JIT is excluded. Local checks use `python3 scripts/local-guard.py COMMAND...`;
full builds, suites and measurements run on GitHub. Do not raise resource limits.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Deliver synchronous WASI ownership; host re-entry remains unproved |
| 2 | In progress | Diagnose remaining allocations in measured hash pipelines |
| 3 | In progress | Retain actual code and address measured C/Rust gaps |
| 4 | In progress | Preserve nested derivative cleanup; broader tape costs remain |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Keep equivalent comparisons and physical storage evidence |
| 7 | In progress | Extend maintained programs across deployment boundaries |

Next: monitor #150, fix any failures and merge only after its exact-head full
gates pass. In parallel, investigate why the measured hash/map/bitwise-fold
pipeline keeps intermediate lists. `src/fuse.rs` currently treats `hash` and
`bit.xor` as unknown behavior. Any expanded proof must preserve effects, termination,
trap order, input aliases and resource lifetimes; do not infer a safe optimization
solely from fewer allocations. Transfer this preparation after #150, refresh PLAN
and history, then require a new full gate for the combined delivery.

## Changes and acceptance

WASI supplies standard streams and files to WebAssembly programs. Checked ARC
now applies existing compiler ownership checks to synchronous WASI main, function
and CLI entries. The runtime separates removal of count metadata during a real
last-owner free from permanent sharing, rejects counted owners escaping into
permanent retention, and rejects tracing/stress/reuse-retention options.

Counts still use the existing external hash table with wide counters. This is
not zero-cost ownership. Browser re-entry, services and asynchronous host fibers
remain rejected until their retained lifetimes have evidence. Native-library
flags combined with WebAssembly targets now fail rather than ignoring the target.
No new syntax, backend or implicit memory fallback is introduced.

Native `hash` streams the same typed canonical bytes directly through FNV-1a,
a wrapping 64-bit fingerprint. The interpreter retains its buffered encoder as
an independent reference. Hash borrows its input and returns an immediate U64.
No temporary byte buffer is needed. Types, byte order, floating bits, container
order and aliases must remain unchanged.

Acceptance covers raw/optimized interpretation, native O1/O2 tracing/ARC on all
six hosts and actual WASI on both Linux architectures. Physical malloc/free
ledgers supplement reference counts. Tests exercise 300 aliases, 64-bit count
overflow, rejected sharing, caught errors, nested derivatives, repeated list/text
work, CLI/function entries and module symbols. Deliberately omitted frees,
share guards and autodiff shutdown must fail. Hash checks cover narrow/wide
numbers, F128, NaNs, Unicode/NUL, packed views, nested containers and 64 retained
aliases. The old buffered hash must fail the zero-allocation control.

## Focused results

| Check | Actual result |
|---|---|
| WASI ownership and shutdown | [38851711201](https://github.com/e6qu/fun-with-pipes/actions/runs/38851711201), both hosts pass at `4a28443a` |
| WASI with hash and retained modules | [38853064238](https://github.com/e6qu/fun-with-pipes/actions/runs/38853064238), both hosts pass at `bea55914` |
| Native hash semantics/counts | [38853061610](https://github.com/e6qu/fun-with-pipes/actions/runs/38853061610), four Unix hosts and Windows AMD64 pass |
| Windows artifact repair | [38853748654](https://github.com/e6qu/fun-with-pipes/actions/runs/38853748654), both hosts pass at `07ddf192` |
| Equivalent C/Rust hash comparison | [38854304399](https://github.com/e6qu/fun-with-pipes/actions/runs/38854304399), all four hosts pass at `34600beb` |

The original WASI observer ran before normal autodiff `atexit` cleanup and reported
four allocations / 2,248 bytes with zero counts. The corrected observer registers
before program work and measures after real runtime shutdown; it does not force
cleanup. Both omitted-object-free and omitted-tape-shutdown controls fail with
244. Initial Windows probes placed headers before the generated API preamble;
that fixture is corrected. Windows ARM disassembly now explicitly uses
`llvm-objdump`, since Git's GNU objdump could not read its ARM64 PE file. Earlier
failed runs are not acceptance. Their details remain in the
[immutable preparation record](https://github.com/e6qu/fun-with-pipes/blob/34600beb147fb54914ff3635084f23df7464faac/docs/development-state.md).

[Hash measurements](measurements/structural-hash-2026-10-16.json) compare identical
canonical tuple hashes in ordinary fwp pipes, C and Rust. Ten rotating samples
retain CPU/elapsed time, hardware, flags, build cost, binary size, process memory
and allocation scope. Streaming removes hash buffer allocations and reduces CPU
time relative to buffered fwp on all hosts. Checked ARC still costs 24–82% extra
CPU against C/Rust for small inputs and about 1–4% for large inputs. Full fwp
programs retain 12,309 / 7,173 managed requests and 12,288 / 3,072 retains, whereas
C/Rust allocate one application array. This is not zero-overhead evidence.
[Benchmarks](benchmarks.md#hashing-values-without-constructing-their-encoded-bytes)
explains the workloads and comparison limits.

[Machine-code evidence](measurements/structural-hash-code-2026-10-16.json) retains
six native artifact manifests, two WASI manifests and the Linux ARM64 hash body.
That body uses a 96-byte stack frame, register XOR/multiply and recursive visitor
calls, with no encoder/allocator call. This is not a dynamic instruction or spill
count. Downloaded sources, binaries and assembly match their benchmark hashes.
Artifacts remain under `/private/tmp/fwp-hash-artifacts` and
`/private/tmp/fwp-hash-costs`; CI retains the complete files.

## Local checks and transfer notes

The accepted #148 Mac compiler is
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp` (revision `93b1741a`). Tiny edited-C
probes are supplemental, not proof of the changed compiler. Guarded O1/O2 count
and shutdown probes pass (2.60 / 5.00 s); hash canonical-byte/no-allocation controls
pass (3.42 s); tiny C/Rust/fwp fixture agrees (2.06 s). Formatting passes (0.98 s),
docs pass (2.43 s), and inventory passes (0.99 s): 262 contracts, six scalar
signatures, 19 templates, 81 remaining review symbols. Source-comment library
docs were regenerated through the existing standalone generator (0.38 s).
Benchmark artifact hash verification passes (0.13 s). No full build ran locally.

On transfer, preserve #150's final Windows cancellation stack-boundary fixes,
zip/fold coverage, mapped-array CPU report, zip reports and selector choices.
Merge new hash/hash-windows and WASI selectors into the accepted workflow.
Rewrite the delivery section of PLAN and this handoff around the actual combined
head; do not carry preparation-era next actions into the delivery.

## Next measured change: prove total hash and bitwise stages

The four-host baseline identifies 12,309 / 7,173 managed requests in hash/map/fold
programs even after hash itself allocates nothing. Inspection confirms the fusion
analysis rejects both `hash` and `bit.xor` as unknown. Hash's structural constraint
excludes functions and resources; its immutable finite values have no callbacks
or language traps. Integer AND/OR/XOR/NOT also have no traps; shifts remain
excluded because an oversized shift traps. Recognize these existing contracts
in the existing analysis, without new syntax, flags or a second optimizer.

Acceptance must show the hash pipeline becomes one loop, fewer managed requests,
unchanged retained inputs, and raw/native agreement at O1/O2 in both memory modes.
Effectful callbacks, distinct traps and shifts must keep their original order;
wide bitwise values need explicit coverage. Repeat the same C/Rust measurement
on runners and retain the original baseline rather than assuming a timing gain.

The existing analysis now recognizes structural hash and integer AND/OR/XOR/NOT.
New focused tests require a fused loop, raw/native O1/O2 agreement, effects and
distinct-trap order, oversized-shift rejection, wide integer results, retained
strings and at most 100 managed requests for 65 hashes over 16 numbers (the
unfused formula gives 216). Actual WASI also runs the positive fixture. Guarded
accepted raw interpretation passes all four cases (0.61 s), the isolated harness
compiles (0.50 s), formatting passes (0.97 s) and docs pass (2.55 s). These do not
verify the changed compiler; focused native/WASI gates and repeated comparisons
must pass on runners before adoption.

Run `38855570657` at `1f8a5dc1` confirms the primitive proof alone is insufficient:
Linux checks preserve all semantic cases, but the allocation test correctly
fails because the measured callback captures a freshly built array and stays
indirect. WASI `38855575805` and costs `38855581613` are superseded by the complete
capture repair. They are not acceptance of that repair.

The existing callback specialization now binds eager captures once, in original
left-to-right order, before the producer. Fusion preserves those outer bindings
and crosses only consumer arguments proved free of effects/traps. No new switch
or wrapper runtime is added. Tests cover capture effects before input, a capture
trap even for an empty input, and an effectful fold seed that must run first.
Resource-bearing captures remain on their existing frame path.

A small isolated build of only optimizer modules against the existing library
passes typed IR and all seven positive reductions (0.74 s); capture trap order
passes (1.84 s). An effectful string capture originally retained a conservative
path because constructor IR lacks its own type; the repair takes the already
checked partial-application parameter type. Its changed-compiler checks are
runner work. A later guarded diagnostic compilation stopped with an OS signal
permission error; no optimizer/compiler process remains, no limits were raised,
and further compilation/validation moved to CI. Earlier successful probes are
supplemental, never full compiler acceptance.

Completed logs from superseded WASI `38855575805` expose a separate required fix:
`hash-fusion` prints correct results but leaves ten 16-byte physical allocations
above its constant baseline, with zero live count entries. Native checks on
Linux/Mac/Windows otherwise fail only the known unfused benchmark assertion.
The complete capture repair is queued in `38856280599` / `38856283417`; costs are
`38856285939`. Do not assume it resolves the physical leak. The WASI observer now
records allocation source line and output phase, and retains every ordinary
program's instrumented C and module before checking its result. This preserves
the failing physical-storage assertion rather than weakening it. All three
superseded runs are confirmed canceled.

Source inspection explains the ten leaked boxes: `tree_owner_id` returns early
when `fwp_rc_slot` is absent. Native fresh allocations already have a zero slot;
WASI allocations acquire their external slot only on first claim. Native
libraries still use the native allocator, although they cannot scan host roots. Every generic wide bitwise result therefore stayed unowned. The repair
keeps the native absent-slot exclusion only under `FWP_GC`, rejects immediate
values first, and claims fresh non-GC storage before traversing children.
New actual-WASI cases cover checked I128/U128 result trees and F128 results;
restoring the old absent-slot return must reproduce the physical leak (244).
The assertion remains unchanged. Diagnostic run `38856960546` is superseded by
the repair before acceptance; the full runner gate must still validate it.
