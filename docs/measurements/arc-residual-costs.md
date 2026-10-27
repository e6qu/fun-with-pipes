# Remaining ownership costs after GC removal

This is the current A2 measurement protocol and measured baseline. Tracing
removal passed [#217](../roadmap-history.md#tracing-gc-removal-pr-217); it did not
remove all reference counts or heap storage. This experiment measures the
remaining work before selecting the next compiler change. Both native Linux
hosts pass [baseline run 40474903463](https://github.com/e6qu/fun-with-pipes/actions/runs/40474903463)
at source `405bcfde48afdc07267c76251ac3c70a0d346e97`. The
[audited report](arc-residual-baseline-2026-10-27.json) retains all 13 cases,
three identical samples per input, active sites, file hashes and ordinary binary
size/frame evidence. Every operation total agrees between architectures.

An allocation request obtains storage. A retain adds an owner. A release gives
up an owner; only the last owner permits destruction. A uniqueness check asks
whether one owner remains so storage can be reused. An attempted operation can
do nothing, for example when its value is static or has no counted storage.
Report attempted and effective operations separately.

## Programs and inputs

| Program | Inputs and result | Why measure it |
|---|---|---|
| Five channel fixtures | 0, 16 and 1,024 messages; return the number after checking every send/receive | Distinguish fresh text/functions, shared payloads and rejected sends |
| `bench/map/main.fwp` | Build 500,000 scrambled numeric entries, then perform 2,000,000 lookups and print size/sum | Check the remaining owner of a cached map, separately from construction |
| `examples/wordfreq.fwp` | 4,096 words/256 distinct spellings and 65,536/4,096; print the five most common normalized words | Attribute list, text and map ownership in an application |
| Packed derivative descent | 3 coordinates/7 updates and 129/199; print the complete final vector | Separate array storage/destruction from per-coordinate ownership work |
| Local numeric buffer | Runtime lengths 0, 16 and 4,096; read the array then its length, returning twice the length | Establish A5's first unique-storage candidate |
| Shared buffer | Same lengths; return the array in both fields of a pair | Preserve two live aliases through printing and cleanup |
| Callback reader | Same lengths; pass the array to an exported callback-taking reader, returning the length | Record the cost of a call boundary; this is not proof of an unknown or escaping callback |

The [buffer fixture](../../tests/fixtures/unique_buffer_costs.fwp) creates values
`0` through `length - 1`. Its first value contributes zero, including the empty
case. `both` applies two functions to the same input and returns their results
as a pair; `uncurry add` adds that pair. The local case must therefore return
32 for length 16. The shared case must print both complete arrays, with neither
alias damaged. These are candidates and controls, not new ownership syntax.

The word input is deterministic ASCII with mixed case and punctuation. The
existing word-frequency oracle checks the expected ranking independently.
All programs also compare ordinary native output with unoptimized interpretation.

## Execution and evidence

Dispatch the `arc-costs` suite in `.github/workflows/numerics.yml`. It builds the
current Rust compiler on native Linux AMD64 and ARM64; no previous fwp compiler,
saved generated program or self-hosting is required. Generated C uses GCC O2,
GNU C11, disabled floating-point contraction, no fast math and no link-time
optimization. Exact commands, source and compiler hashes, host/tool identities,
outputs, generated C, binary sections, disassembly and static frame estimates
are retained. Frame estimates describe individual functions, not peak task-stack
use. Whole-file size includes linker layout and non-executable data.

Each program has an ordinary binary, the existing aggregate allocation profile
and a profile that attributes operations to C call sites. The latter must
reproduce the aggregate allocation/retain counts and program output exactly.
Three fresh executions must give identical site counts. Counts begin after
constant initialization and end after entry and cached-value cleanup, before
runtime teardown. Final managed live-byte growth must be zero.

`sites.json` maps site IDs to lines in the retained `profile-base.c`. Direct
calls have their own sites. The baseline groups function-pointer calls by
operation; the candidate observer separates their construction sites so map keys
and sort keys can be attributed independently. Every site records calls, effective events and (for releases)
last-owner events. A last-owner release and its later physical free are separate
observations, not two count decrements. Free calls in this report are typed
ownership frees; raw buffers and other allocator clients need their own observers.

The control program performs 301 effective retains, including a function-pointer
call and enough owners to exercise wide counts. It then removes those owners,
checks shared/unique decisions, destroys the two allocations and tests unmanaged
values. Known totals check every observed operation. Reader tests reject missing
retain sites, duplicate/unknown rows, impossible counts and nonzero final storage.

Managed charge includes allocator slot rounding but excludes allocator metadata,
raw buffers, stacks and resident-process memory. A unique-buffer claim must also
inspect the allocator's actual metadata: zero retains alone does not remove its
count slot. The native allocator currently reserves per-slot counts in chunk
metadata; the buffer does not carry an inline count field in its payload.

These are operation counts, **not timing measurements**. Profiling changes code
and storage. No C/Rust peer is timed, so this report establishes neither a speedup
nor parity with C/Rust. Separate ordinary binaries provide size/frame evidence.

## First selected change

Generating a 4,096-element numeric array currently makes 4,096 extra retain
attempts and closure-release checks on the static `id` callback. None changes a
count, but each inspects ownership metadata. The compiler specializes array
generation for captured callbacks; it does not yet select that path when there
are no captures. Extend that existing path to known scalar callbacks with zero
captures, preserving the array builder's failure/cancellation cleanup.

The predeclared target removes exactly one retain attempt and one closure-release
check per element in all three buffer fixtures. Effective retains, other ownership
operations, allocation requests/bytes and peak/final managed charge must remain
identical. Other fixtures must keep all counts. `compare` checks every row against
the frozen baseline and reports all mismatches. The ordinary binaries provide
the code-size and frame-cost comparison. This is A3's first selected class;
it does **not** remove the array's count metadata or complete A5.

Candidate verification is pending. A semantic fixture covers empty arrays,
aliases, ordered effects, handled callback errors, yielding, cancellation and
dynamic callbacks. Native O1/O2 probes require zero callback owner checks for
known generation and zero retained storage after partial failure. Deliberately
adding an owner check or omitting partial cleanup must fail those probes.

## Completion requirement

After both hosts pass, retain a checked report and explain each active site in
terms of its owner and source operation. Classify the cost as required sharing,+a missed move/borrow, or bookkeeping for a still-boxed value. State the next
removable operation and a count/storage target before implementation. A list of
totals without that attribution does not complete A2. A5 additionally requires
failure/cancellation cleanup and alias, capture, unknown-call and weak-link
controls before claiming a count-free unique representation.

Return to [PLAN.md](../../PLAN.md), [ownership](../ownership.md) or
[measurement reports](README.md).
