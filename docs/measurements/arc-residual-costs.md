# Remaining ownership costs after GC removal

This is the original A2 measurement protocol and baseline. Tracing
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
Report attempted and effective operations separately. For last-owner queries,
“effective” counts true results, not every query of counted storage. Later
[array storage](unique-array-storage.md) and [sort-key](sort-key-ownership.md)
reports preserve these baselines and describe their own measured changes.

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

The original A2/A3 evidence used the `arc-costs` suite at its recorded source.
The current suite uses the [sort-key budget](sort-key-ownership.md) against the
subsequent unique-array baseline. To reproduce historical counts, select their
recorded source rather than applying an obsolete budget to current code.
The suite builds the
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
operation; the candidate observer separates their construction sites so map insertion keys
and result-list keys can be attributed independently. Every site records calls, effective events and (for releases)
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

## What the remaining owners cost

These totals include entry/argument preparation and final cleanup. They are not
per-loop counts. “Last releases” reach the last owner and allow destruction;
other effective releases remove an additional shared owner. All cases finish
with zero additional managed live bytes. The saved report records every active
site, its C line and caller, and releases grouped by the value's type.

| Case | Allocation requests | Effective retains / non-final releases | Last releases | Peak charged bytes |
|---|---:|---:|---:|---:|
| Fresh text, 1,024 messages | 1,033 | 0 | 1,026 | 608 |
| Fresh function, 1,024 messages | 2,057 | 0 | 2,050 | 624 |
| Shared text, 1,024 messages | 10 | 2,048 | 3 | 544 |
| Shared function, 1,024 messages | 1,035 | 4,096 | 1,028 | 576 |
| Closed channel, 1,024 rejected functions | 2,056 | 0 | 2,050 | 608 |
| Cached numeric map, full workload | 4 | 1 | 2 | 16,000,008 |
| Word frequency, 4,096 words / 256 spellings | 14,987 | 5,898 | 10,875 | 341,617 |
| Word frequency, 65,536 words / 4,096 spellings | 239,251 | 94,218 | 173,695 | 5,465,713 |
| Packed descent, 3 coordinates / 7 updates | 8 | 0 | 8 | 112 |
| Packed descent, 129 coordinates / 199 updates | 200 | 0 | 200 | 4,352 |
| Local buffer / callback reader, 4,096 elements | 7 | 0 | 2 | 32,872 |
| Shared buffer, 4,096 elements | 8 | 1 | 3 | 32,904 |

“Necessary sharing” below means that the current program keeps independent
owners alive, not that no different representation or algorithm could avoid it.
A “missed borrow” is an owning call or temporary whose original owner remains
alive throughout its use. Removing one still requires a compiler proof.

| Owner and operation | Classification and source path |
|---|---|
| Fresh channel text/functions; rejected sends | No effective retains. One text owner per message, plus one closure for function messages; the queue transfers or rejects those owners. Last-owner checks and count initialization are bookkeeping for allocated values. The channel and CLI argument add fixed cleanup. See `src/cgen.rs` channel emission and `runtime/fwp_rt_task.c`. |
| Shared channel text | Per message, one retain gives the queue an owner while the source remains live: necessary sharing. Another temporary keeps text for comparison: a missed borrow. Both releases are String releases. See `src/rc/borrows.rs` and generated loop/send calls. |
| Shared channel function | Per message, two function retains cover the exchange temporary and queue ownership; one is a missed borrow, one is necessary sharing. The channel call adds one missed borrow. Calling the shared function returns its captured String with one new owner: necessary sharing. Releases balance as two Function, one Channel and one String. See ordinary-call borrowing and `src/cgen.rs` callback argument preparation. |
| Cached numeric map | One additional map owner is returned from the cache for the size read: a missed borrow across the cached entry. The two million lookups already borrow. The final map and temporary `List[()]` have last-owner releases. See `src/cgen.rs` cached entry emission and `src/rc/borrows.rs`. |
| Word-frequency strings and pairs | The exact decomposition below separates independent collection owners from temporary call/field owners. List nodes, map storage, sort keys and record boxes retain count initialization and destruction checks. See `src/cgen.rs` argument/field emission and typed list/map/sort operations in `runtime/fwp_rt_prims.c`. |
| Packed descent | Each update creates an array and releases the preceding owned array; the initial constant is unmanaged. There are no effective retains. Each allocated array and the final formatted String still have last-owner bookkeeping. See the packed numeric emitter in `src/cgen.rs` and array cleanup in `runtime/fwp_rt_prims.c`. |
| Local buffer and callback reader | No effective retains. The array and CLI String each have one last release. Array count initialization and destruction checks are the A5 target; the known reader does not create an independent owner. |
| Shared buffer | One array retain is necessary for two live result fields. The array, result pair and CLI String have final releases. This is a negative control for count-free storage, not a target for deleting a required owner. |

For word frequency, let **N** be the input word count and **D** the number of
distinct normalized spellings; both inputs have more than five spellings. The
measured total is **N + 7D + 10 retains**, balanced by the same number of non-final
releases: **N + 4D String releases** and **3D + 10 pair releases**.

| Retains | Owner and source operation | Classification |
|---:|---|---|
| N | Word String passed to the frequency fold (`fwp_args36`); the callback borrows it for `map.update`, then drops it | Missed borrow from the input list |
| D | Map keys copied into the result list (`map.to-list`) | Necessary sharing between map and list |
| D | Record passed to the sort-key callback (`fwp_args8`) | Missed borrow from the sort input |
| D | Record duplicated by the key function's `both` (`w8`) | Temporary boxed-value bookkeeping |
| D | String field retained and immediately dropped by the numeric selector (`f9`) | Temporary boxed-value bookkeeping |
| D | String field returned by the text selector (`f12`) into the saved sort key | Necessary sharing between key and source record |
| D | First occurrence of each String inserted into the map (`map.update`) | Necessary sharing between map and input list |
| D | Records copied into sorted output | Necessary sharing with the source list |
| 5 | Records copied by `take 5` | Necessary sharing with the sorted list |
| 5 | Records passed to output (`fwp_args37`) | Missed borrow from the output list |

Names in parentheses identify the retained generated C, not stable compiler APIs.
The candidate observer separates function-pointer construction sites that the
baseline grouped together. This identifies the map-insertion, map-to-list and list-element
copies without guessing from aggregate totals. Its reader independently requires
that effective retains equal non-final releases.

Uniqueness queries do not add owners. Word frequency asks whether list nodes,
lowercased text and map storage can be reused; typed destruction then checks the
last owner. For 65,536 words the report records 87,382 `unique`, 65,536
`unique_mut` and 321,151 `last` calls. These are still-boxed-value bookkeeping,
not proof of count-free storage. Static values also reach no-op count helpers;
the `calls` and `effective` columns retain that difference. The next section
removes one such class rather than treating zero effective retains as zero cost.

## First selected change

Before this change, generating a 4,096-element numeric array made 4,096 extra retain
attempts and closure-release checks on the static `id` callback. None changed a
count, but each inspected ownership metadata. The compiler now also selects its
existing specialized generator for known scalar callbacks with zero captures,
preserving the array builder's failure/cancellation cleanup.

The predeclared target removes exactly one retain attempt and one closure-release
check per element in all three buffer fixtures. Effective retains, other ownership
operations, allocation requests/bytes and peak/final managed charge must remain
identical. Other fixtures must keep all counts. `compare` checks every row against
the frozen baseline and reports all mismatches. The ordinary binaries provide
the code-size and frame-cost comparison. This is A3's first selected class;
it does **not** remove the array's count metadata or complete A5.

Both native hosts pass [candidate run 40479298165](https://github.com/e6qu/fun-with-pipes/actions/runs/40479298165)
at `863a5215b39c9c04bceb14aacc96972e3b41752a`. The
[audited candidate report](arc-residual-candidate-2026-10-27.json) confirms every
predeclared count target, unchanged effective counts and allocation/live-byte
metrics, and identical cross-host totals. All 12 focused tests pass per host.
All nine production jobs, documentation and both compiler-analysis hosts passed
for the final #218 head; [delivery history](../roadmap-history.md#static-array-callbacks-and-remaining-arc-costs-pr-218)
records the verified squash.

A semantic fixture covers empty arrays,
aliases, ordered effects, handled callback errors, yielding, cancellation and
dynamic callbacks. Native O1/O2 probes require zero callback owner checks for
known generation and zero retained storage after partial failure. Deliberately
adding an owner check or omitting partial cleanup must fail those probes.

## Code and stack costs

Ordinary GCC 13.3 O2 binaries give the following before → after byte counts.
The frame is GCC's estimate for `fwp_exec_call.constprop`, into which the
specialized loop is inlined; it is not whole-program peak stack use. The new
frame is marked `dynamic` by GCC, so its reported bytes are not an upper bound.

| Buffer | AMD64 executable code | ARM64 executable code | AMD64 entry frame | ARM64 entry frame |
|---|---:|---:|---:|---:|
| Local | 60,882 → 60,786 | 57,916 → 57,836 | 416 → 1,008 | 528 → 912 |
| Shared | 62,370 → 62,258 | 59,388 → 59,212 | 416 → 1,024 | 528 → 928 |
| Callback reader | 61,314 → 61,202 | 58,364 → 58,300 | 416 → 1,008 | 528 → 912 |

The complete files shrink by 160 bytes on AMD64 and 96 bytes on ARM64 for each
buffer. Other cases have unchanged code/file sizes. The larger entry frames are
a real cost of this specialization; these measurements do not establish a lower
peak stack requirement or a speedup. Keep the saved frames and ordinary C when
comparing later representation changes.

## A5 follow-up: remove the unique array's count storage

These A3 measurements define the next target. At length 4,096, `buffer-unique`
still has one array count initialization, one last-owner release, one last-owner
query and one counted-array free call. Its unrelated CLI String also has an owner;
removing the array's count cannot remove that String's storage.

The [A5 report](unique-array-storage.md) now records the implemented local-array
path, paired measurements, metadata layout and cleanup/escape controls. It keeps
payload allocations separate from count storage and distinguishes implemented
code from completed platform acceptance. General region inference remains separate.
