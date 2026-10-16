# Session handoff

Updated 2026-10-16. Combined preparation in `/private/tmp/fwp-wasi-delivery`,
branch `wasi-hash-delivery`, based on #150's exact head `7a7b40e1` while its final
gates run. It transfers only `e5e05748..edb5d2ba` from
`/private/tmp/fwp-wasi-arc` / `checked-wasi-ownership`. Two workflow conflicts
were resolved by retaining every #150 Windows test and selector and adding the
new hash/WASI suites. Source/runtime/tests otherwise transfer unchanged.

After #150 merges, rebase only commits after `7a7b40e1` onto its verified squash
commit. Require equal base trees. Refresh this handoff and PLAN before publishing
one delivery PR. Never replay the preparation's old parent chain.

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
gates pass. The complete capture repair `d1ae668f3f04d6fa113d137c73250efe26056295`
has [native 38856280599](https://github.com/e6qu/fun-with-pipes/actions/runs/38856280599),
[repaired WASI 38857203804](https://github.com/e6qu/fun-with-pipes/actions/runs/38857203804) and
[costs 38856285939](https://github.com/e6qu/fun-with-pipes/actions/runs/38856285939)
queued. WASI uses `96c3b637` with the fresh-owner repair below; the later comment
correction is `edb5d2ba`. Fix failures in the original preparation, then transfer only its follow-up
diff here. Keep benchmark sources and binaries tied to their measured revisions.
The new combined delivery still needs its own full production gate.

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

## Measured pipeline follow-up

The baseline leaves 12,309 / 7,173 managed requests after hash itself allocates
nothing. The existing fusion analysis now recognizes structural hash and integer
AND/OR/XOR/NOT as total; shifts remain excluded because oversized shifts trap.
The first runner attempt at `1f8a5dc1` preserves semantic cases but correctly fails
the allocation test: a freshly built array capture still hid the callback behind
indirect calls. Superseded runs `38855570657`, `38855575805` and `38855581613` were
confirmed canceled. The queued initial complete-repair WASI run `38856283417`
and diagnostic-only `38856960546` were also requested canceled in favor of the
fresh-owner repair; confirm their terminal states.

The complete repair binds eager captures once in their original left-to-right
order before the producer, then uses existing callback specialization. Fusion
keeps those bindings outside its loop and crosses only consumer arguments proved
free of effects/traps. Checked parameter types preserve constructor/nominal types.
Resource-bearing captures retain their existing frames. No new syntax, switch or
runtime wrapper is added.

Tests require raw/native O1/O2 agreement, retained inputs, wide bitwise values,
capture effects before input, a capture trap even for empty input, and an effectful
fold seed evaluated first. The 65-hash/16-element fixture must use at most 100
managed requests; the unfused formula gives 216. Actual WASI runs the positive
fixture too. Repeat the exact C/Rust measurement before claiming a timing gain.

Small isolated optimizer modules linked against the existing library preserve
typed IR and all seven positive reductions (0.74 s); capture-trap order passes
(1.84 s). A later guarded diagnostic compilation stopped with an OS signal
permission error. No compiler/probe process remains, no limits were raised, and
further compiler validation moved to CI. Formatting alone subsequently passes
(1.09 s). These local probes are supplemental, not full compiler acceptance.

## Required WASI leak repair

The completed superseded WASI run exposed ten 16-byte allocations left after the
wide-bitwise fixture, despite zero live counts. Source inspection identified
`tree_owner_id`: it skipped values with no existing count slot. Native allocator
objects already have slots; WASI objects acquire external entries when first
claimed. The repair keeps native slot exclusions, rejects immediate tags before
traversal, and claims fresh WASI boxes. Native libraries still use the native
allocator even though they cannot scan host roots.

Actual-WASI regressions now include checked I128/U128 trees and F128 results.
Restoring the old absent-slot return must fail the physical storage assertion
with 244. The ledger records source lines/output phases and retains ordinary
program C/modules before assertions. `38857203804` tests this repair; it is not
accepted until the run passes. Native semantic and C/Rust measurement runs still
use `d1ae668f`, before this WASI-specific change. Final combined native/WASI gates
remain mandatory. No full local build or suite was run.
