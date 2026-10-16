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
passed an unchanged retry; its unexplained cause remains recorded in the handoff.

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
