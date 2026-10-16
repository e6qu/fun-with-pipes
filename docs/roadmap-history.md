# Delivery evidence

This is an index of completed deliveries and their test records. Current work
belongs in [the plan](../PLAN.md) and [session handoff](development-state.md).
Historical development runs may include failures later fixed; they are not new
tasks. The [preparation table](roadmap-queue.md) preserves original commit IDs.

A PR is a proposed change. Its **tested head** is the exact commit checked by CI
(continuous integration on GitHub runners). A **squash merge** makes one main-branch
commit from the PR. “Same files” means the tested head and merge have identical
Git trees, even though their commit IDs differ. A focused test run checks a subset;
production acceptance requires every platform job applicable to that delivery.
Cancelled, skipped or partially passing runs are not acceptance.

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

## Less temporary memory in hashing and numerics (PR #152)

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) merged as `1fa0fec6`
at 2026-10-16 14:18 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011355)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38901011298)
passed for `48566579`. The user performed the merge. Its files match the tested
head, its parent is accepted #151, and its one-line message is
`Reduce temporary memory in hashing and numerical calculations (#152)`, with no
body or trailers. Duplicate production `38914679717` is confirmed canceled.

Selected hashing pipelines read existing fields without temporary containers.
Integer ranges can become arrays directly. Numerical multiply-and-sum operations
avoid intermediate product vectors, and repeated-number inputs can stay as scalar
values. Each multiplication and addition retains its original order. Temporary
numerical results are also released on failure. The
[paired measurements](measurements/vector-paired-2026-10-16.json) compare prior
and new fwp programs with C/Rust, retaining remaining overhead and slower samples.
They establish improvements for the measured workloads, not language-wide parity.

The first production attempt found an unformatted example; CI now checks language
formatting before lengthy suites. Later Intel jobs exceeded 90 minutes. Building
the Rust compiler and test harnesses with optimization level 1, while retaining
assertions and overflow checks, allowed the final complete gate to pass within
the unchanged limits. Coverage and generated-C settings were preserved.

## Synchronous WASI ownership and streaming hashes (PR #151)

[PR #151](https://github.com/e6qu/fun-with-pipes/pull/151) merged as `3dff03b6`
at 2026-10-16 09:58 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161681)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38872161673)
passed for `27cdc7ff`. Its tree matches that tested head, its parent is accepted
#150, and its exact message is `Own WASI values and eliminate hashing intermediates`,
with no body or trailers. Duplicate postmerge production `38884089916` is confirmed canceled after
that verification.

Synchronous WASI main/function/CLI entries can use checked ARC and physically free
counted values. Fresh wide numeric results acquire external count entries before
destruction. Startup rejects tracing/retention settings, and browser/service
re-entry remains excluded. Structural hash streams canonical bytes directly into
FNV-1a; total hash/bitwise pipeline proofs preserve eager capture, effect and trap
order. Independent interpreter, physical-free and missing-counter controls cover
the changes. Four-host C/Rust and paired reports preserve slower samples and
remaining overhead; see [benchmarks](benchmarks.md).

An earlier Intel macOS GC job timed out. Explicit measured assignments now cover
all 219 integration targets without reshuffling old work when a test is added;
unit/example/benchmark and dedicated stress checks remain. Both repaired Intel
jobs passed within the unchanged 90-minute limits. Default tracing and all seven
whole roadmap areas remain unfinished.

## Numeric zip intermediates and owned list/text results (PR #150)

[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150) merged as
`729db67f71386750aad0bbe477f546e5276b0223` after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415)
passed for `7a7b40e1878ea062f64eceded6ae029b4124f976`. The merge has the same files,
parent `58ed740c` and the required one-line message with empty body. Duplicate
production run `38860909658` was canceled after verification.

Known numeric zip/map callbacks avoid temporary pairs and input list nodes.
Zip/unzip/repeat/chunks/scan/iterate protect partial construction; large I64 chunk
sizes no longer truncate on WASI. File reads and replacement writes have checked
ownership, exercised by maintained todo/grep functions and actual command lines.
Windows cancellation fixtures now supply the stack boundary required by scanning.

[Measurements](measurements/zip-maps-2026-10-16.json) reduce repeated derivative
requests from 23,087,625 to 18,892,809 and retains from 10,492,416 to 8,395,264;
peak stays 840,888 bytes. [Paired repeats](measurements/zip-map-cpu-2026-10-16.json)
retain mixed tiny nested timings and actual instruction evidence. These compare
fwp variants, not C/Rust parity. Tracing removal and the seven project work areas
remain unfinished. Detailed focused checks are in the
[accepted handoff](https://github.com/e6qu/fun-with-pipes/blob/7a7b40e1878ea062f64eceded6ae029b4124f976/docs/development-state.md).

## Owned processes and numeric mapped arrays (PR #149)

[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149) merged as
`58ed740cc785382b0cd818d4af970a1fa49516e6` after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126)
and [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)
passed for `5748f7496a8f1db0e93145c53e380a0703affc2f`. The merge tree, parent and
single-line subject with empty body were verified. Duplicate post-merge production
`38851195546` is confirmed canceled; documentation finished normally.

Process calls own argument scratch, captured output, handles and partial results.
POSIX child signal behavior agrees with interpretation while preserving the
parent's signal policy; terminal echo is restored on traps, and Windows uses
real console queries. Maintained shell composition exercises repeated results.
Synchronous waiting still does not establish cancellation/deadline responsiveness.

Mapped inline numeric results construct arrays without temporary list nodes and
keep known callbacks as direct calls. Callback order, aliases and failed
allocations have six-host focused and full acceptance. The repeated derivative
workload removes 2,097,152 allocation requests; retains and peak memory stay the
same. [Measurements](benchmarks.md#building-numeric-arrays-without-temporary-list-nodes)
retain four-host comparisons, an independent repeat and the CPU/collector
investigation. Tiny nested timings remain mixed. Tape layout stays unchanged
because its alternative did not show a portable improvement. This delivery does
not finish removal of tracing GC or establish C/Rust parity.

## Record moves and application utilities (PR #148)

[PR #148](https://github.com/e6qu/fun-with-pipes/pull/148) merged as
`853d6669dbf7dea78483376865190c218c9fece6`, with the same files as tested head
`93b1741abcf5ab2a61460746c0077564e0328c0e`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passed before merging. The squash subject and empty body were verified. Duplicate
post-merge production run `38835480889` was canceled after the tree comparison.

Flattened and uniquely owned boxed records can transfer fields without temporary
child owners. Alias, sibling, wide-value, scalar-bit, resource and failure controls
remain. Working-directory results, clock records, empty maps/sets and Boolean
combinations have checked ownership. Missing working directories report a typed
error in both engines; structured logs emit one newline. Maintained directory
reports run repeatedly, and Windows probes use native executable/handle rules.

[Focused six-host checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38823885563)
passed before the full gate. [Benchmarks](benchmarks.md) retain record-move
allocation/count evidence and mixed C/Rust timing gaps. The matrix-output helper
experiment was not adopted: smaller code did not establish a portable speedup.
No whole roadmap work area was marked complete.

## Numerical precision and filesystem ownership (PR #147)

[PR #147](https://github.com/e6qu/fun-with-pipes/pull/147) merged as `c9127d2d`
at 2026-10-15 23:42 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38814786923)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38814787519)
passed for `71c612d0`. The squash has identical files and the verified subject
`Own numerical and filesystem results and preserve gradient precision`, with
no body or trailers. Duplicate post-merge production run `38825167262` was
canceled after verifying the identical tree.

Six F64 solvers now own scratch/results and handle partial failures; QR validates
output bounds. Array loops borrow invariant data pointers. Reverse differentiation
preserves F128 seeds, weights and adjoints without narrowing through F64. Console
input, arguments, environment/directory snapshots, file metadata, byte reads and
ordinary file actions have explicit ownership and error cleanup. OS paths and
environment names reject embedded zero bytes before accessing a truncated prefix.
Regression tests also preserve timestamps, write errors and host directory
messages. See [ownership](ownership.md) and [benchmarks](benchmarks.md) for scoped
contracts and measured limits. Default tracing and broader roadmap work remain.

## Checked boundaries and numerical kernels (PR #146)

[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146) merged as `be890914`
at 2026-10-15 22:03 UTC, after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349640)
passed for `19b14d0b`. The merge has identical files and a single-line message
with no body or trailers. Duplicate post-merge production run `38814471520` was
canceled after that verification; its documentation audit passed separately.

The delivery admits checked C-library calls with copied inputs and pointer-free
results, checks every export independently, and admits channels whose data cannot
capture channel/task handles or callbacks. List transposition owns fresh immutable
nodes and cleans partial columns. The allocator correctly charges its first small
allocation. Fixed-size compiler copies expose matrix vectorization, and runtime
scheduler ticks disappear only in proved taskless programs. Windows probes now
use binary output and initialize synthetic task stack roots correctly.

[Retained comparisons](measurements/numerical-memory-modes-2026-10-15.json) cover
both tracing and checked ARC against equivalent C/Rust kernels on four hosts.
The [benchmark guide](benchmarks.md) states costs, instruction evidence and limits.
This delivery does not remove tracing from the default runtime or finish the
project's ownership/performance objectives. The earlier Intel compiler abort
passed an unchanged retry; its cause remains unexplained in this historical record.

## Infix arithmetic and numeric loop cleanup (PR #145)

[PR #145](https://github.com/e6qu/fun-with-pipes/pull/145) merged as `e51b8570`
after all nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284746)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284697)
passed for `1ee7d581`. It adds fixed-precedence arithmetic while preserving
single-argument curried calls and pipes, removes cleanup for proved bounded
internal array-index increments, omits conservative GC fences in checked ARC,
and improves benchmark sample ordering and comparisons. The final gate includes
a repaired tutorial source/README consistency check.

[Four-host focused performance checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38771808755)
passed at `f42d6226`. Fused reductions at 0/1/7/129/257 elements have zero
allocations, retains and per-element cleanup registrations at O1/O2. ARM macOS
native instructions confirm scalar register arithmetic without those cleanup
calls. ARC binaries exclude tracing symbols. [Recorded evidence](measurements/ownership-performance-2026-10-15.json)
retains hardware, compilers and profiles. Changed timing methods prevent an
isolated before/after speed claim. Derivative timings remain mixed; broader
memory and performance goals remain open in the plan.

## Documentation rewrite (PR #142)

[PR #142](https://github.com/e6qu/fun-with-pipes/pull/142) merged as `bbdbf8dc`
before CI finished. Its files match final PR head `4ea1b687`. It revised all
50 Markdown guides, all 21 tutorials, example explanations and library
introductions; clarified C/Rust benchmark comparisons; and fixed a C-buffer leak
and incorrect bill-remainder distribution in tutorials. Focused guarded checks
passed for links, generated docs, tutorial source/output copies, formatting,
benchmark compilation and the changed examples in interpreter/native execution.

[Merge-commit production checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38752839908)
and [documentation checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38752840023)
are the authoritative records. Regular ARM macOS reported `openapi_golden`
failing because the expected bookstore description still said “interpreted.”
Merge alone does not establish acceptance. [PR #143](https://github.com/e6qu/fun-with-pipes/pull/143)
contains the fixture repair; its final production checks determine acceptance.
Duplicate pre-merge runs were cancelled after verifying identical files.

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

[The immutable historical snapshot](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md)
retains earlier development runs, recovery details and superseded instructions.
The [measurement index](benchmarks.md#measurement-report-index) links the raw
reports that still support current claims. Consult the live plan for new work.
