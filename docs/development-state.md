# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines completion. None of its seven
whole work areas is complete. This is the current action list; accepted evidence
belongs in [delivery history](roadmap-history.md).

## Active delivery

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) is the only open delivery:
borrowed hash fields, direct range arrays, owned vectors and removal of temporary
F64 lane storage. Branch `owned-numerics-delivery` is in the main workspace
`/Users/zardoz/projects/fun-with-pipes`. It is rebased onto accepted #151; its tree
matched the measured preparation exactly before this final documentation update.
`numerical-evidence-before-151` preserves that preparation and its measurement
commit IDs. It is evidence, not another task or delivery PR.

Production `38890080777` at `c81b0c9f` cannot be accepted: both Intel macOS jobs
hit their 90-minute deadlines. Their completed tests pass; the remaining tests
were not run. ARM macOS regular/stress, Windows ARM64/AMD64, benchmarks and docs
passed; Linux jobs are still running. The Intel GC shard completed only 60 of
its 97 targets, so rebalancing alone cannot supply enough capacity.

The proposed repair builds CI's Rust compiler and test harnesses at optimization
level 1 while explicitly preserving debug assertions and integer overflow checks.
Generated-C optimization/stress settings, test selection, job count, time limits
and local Cargo defaults remain unchanged. This is a candidate runtime-cost
reduction, not a demonstrated speedup. Require fresh production/docs for the new
head and retain the profile comparison on runners.
Next: monitor #152's final-head production and documentation gates. Require all
nine production jobs and documentation on its exact final head, fix failures,
then squash-merge with an explicit one-line subject and empty
body. Focused preparation passes below do not replace full acceptance. Verify the
merge tree, parent and exact message before canceling duplicate postmerge production.
Then transfer only the following decoder delta onto the accepted numerical squash.

#151 merged as `3dff03b644c4922845f7c4b9f3a9673dece5ef16` after production
`38872161681` and docs `38872161673` passed for `27cdc7ff`. Its tree matches that
head, its parent is #150 (`729db67f`), and its exact single-line message is
`Own WASI values and eliminate hashing intermediates`. Duplicate postmerge
production `38884089916` is confirmed canceled. The macOS assignment repair
preserved all coverage and both Intel jobs passed within unchanged limits.

Production `38884588161` at `ed936381` failed the ARM macOS regular shard:
`examples/vector-lanes.fwp` did not match the language formatter. Both formatting
assertions identify that same file; other tests in that completed shard pass.
The example is now formatted with the accepted binary under the guard (0.02 s),
and its format check passes (0.01 s). No implementation changed. CI now checks
language formatting before lengthy suites on all production targets, using the
compiler each job already builds. This supplements existing format tests and
preserves all nine gates. Publish and require fresh final-head production/docs;
the previous ARM macOS GC, benchmark and docs passes are not new-head acceptance.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver borrowed hash fields, direct arrays and scalar lane loops |
| 3 | In progress | Reduce remaining C/Rust gaps beyond the measured small kernels |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | In progress | Broaden numerical kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable repeated timing, storage and code evidence |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Current implementation and acceptance scope

Hash's explicit nonescape proof means its input is used only during the call;
borrowing alone does not imply that. Temporary structural-tuple fields borrow
from live owners, including eligible sole-use named fields. The independent
ownership verifier checks those lifetimes. Retained aliases, later consumption,
nominal records, calls, traps and resource frames retain ordinary ownership.

Immediate inline-integer `range | array.from-list` builds packed arrays without
list nodes. Bounds keep their order; descending/empty ranges stay empty. Wide
size arithmetic checks the portable array bound before narrowing to WASI's
machine size. I128/U128 retain boxed storage and cleanup.

Nine vector primitives own wrappers, arrays, boxed aliases and reduction
accumulators. Partial construction and replaced accumulators release on failure.
F128 lanes copy payload bits without retaining temporary scalar boxes. Tests
preserve wrapping lanes, checked division, views and manual-record common prefixes.
The example and generated library docs introduce notation and optional results.

F64 loops select contiguous storage once. Proved total lane pipelines avoid
intermediate lists; immediate multiply/sum avoids its product vector. Two
consecutive sole-use splats can remain scalar. Multiplication rounds before
ordered additions, empty vectors still evaluate both scalar expressions, and
retained vectors keep ordinary storage. Effects, eager stage captures and distinct
first traps retain their order. No floating reassociation or implicit conversion
is introduced.

## Completed focused gates

Final numerical runtime `b1a34ea0` passes all six native jobs `38877218687`, both
actual WASI jobs `38877223390`, four-host costs `38877226777` and paired comparison
`38881665737`. The later changes are evidence/documentation. Native O1/O2 tests
compare raw and optimized interpretation, tracing stress/verification/reuse and
checked ARC. Missing cleanup, physical-free, allocation-path and alias controls
remain in the suite. New macOS targets have explicit assignments: 221 total,
with no reassignment of #151's existing 219.

Earlier hash/range revision `ac72124c` passes six-native `38864599295`, both WASI
`38864602220`, four-host costs `38864604854` and paired runs `38866837452` and
`38867789225`. Vector ownership baseline `637b3eb2` passes six-native
`38867603162` and both WASI `38867607803`; baseline costs at `6be8f245` pass
`38869050349`. Direct-dot intermediate `3577ba37` passes six-native `38874211385`,
both WASI `38874214456` and four-host costs `38874218523`. These are supporting
preparation evidence, not extra deliveries. Superseded incomplete runs were
canceled and are not acceptance.

## Measurements and their limits

[Hash field evidence](measurements/hash-borrowed-fields-2026-10-16.json) records
two managed requests, zero retains and zero final charged storage for both
workloads on all four hosts; small/large peak charged bytes are 144/32,776.
The actual ARM64 loop has a stack tuple and register-held state without count or
allocation calls. [Two paired runs](measurements/hash-borrowed-cpu-2026-10-16.json)
retain slower samples: first-run macOS regressions did not repeat. No universal
speedup or C/Rust parity claim follows.

[Baseline vector costs](measurements/vector-lanes-2026-10-16.json) cover four
lanes × 32,768 iterations and 64 lanes × 8,192. Each iteration fills lanes with
its index, multiplies by 0.5 and sums in order. Baseline requests were
262,147/65,539; the [direct-dot intermediate](measurements/vector-direct-intermediate-2026-10-16.json)
reduced them to 131,074/32,770 but still built two splats per iteration.

[Final scalar-splat evidence](measurements/vector-scalar-splats-2026-10-16.json)
records two requests total, 40 requested bytes, 48 peak charged bytes and zero
retains/final storage for both workloads on every host/mode. The two allocations
belong to final conversion/output. Both retained ARM64 calculation loops keep
state in registers, with no calls, loads or stores inside those loops. Setup and
output still cost work; static instructions do not measure dynamic cache misses
or register spills.

The [paired report](measurements/vector-paired-2026-10-16.json) verifies original
artifact identities, twelve balanced samples and matching profiles. ARC CPU ratios
against baseline are 0.161/0.313 on Linux AMD64, 0.116/0.241 on Linux ARM64,
0.327/0.416 on ARM macOS and 0.270/0.504 on Intel macOS for four/64 lanes.
[Benchmarks](benchmarks.md) explain remaining C/Rust overhead, exact inputs,
whole-process timing and differing managed/system allocation scopes. Compilation,
RSS, binary size, hardware and flags remain in the raw reports. These selected
programs do not establish whole-language zero-cost abstractions.

## Following owned-value preparation

The following combined delivery is integrated in `/private/tmp/fwp-owned-values-delivery`,
branch `owned-values-delivery`, at `b7537a6a`, based on `c81b0c9f`. Its current
handoff is authoritative for owned decoders, metrics, CPU kernels, DNS and socket
scratch fixes. DNS/decoder checks pass six-native `38897597329` and both WASI
`38897600949` at preparation `cba3e810`; socket checks `38898918147` are running
at `7224b3de`, with Linux2, ARM macOS and Windows AMD64 passing.
The original combined preparation is `/private/tmp/fwp-owned-kernels`, branch
`owned-cpu-kernels`. Only its delta after
`3577ba3780c19051845a5beba3f064f608cedf1e` belongs to the next delivery. It includes
ternary, URL/form/HTTP, compressed-byte, metric and syntax results, plus CPU tensor
output/scratch ownership. Inventory is 300 contracted declarations and 43 distinct
remaining review symbols; counts alone do not establish runtime support.

Decoder/Windows repairs at `30399066` pass all six jobs `38886033175`. Both actual
WASI jobs `38884843627` pass at the preceding `72321a55`; its subsequent HTTP/2
repair is native-only. The repairs cover native dependency setup, portable
fixtures, Windows console shutdown, WebSocket clock selection and socket
would-block handling. Native-only compressed-byte helpers remain unavailable on
WASI. The worktree handoff retains intermediate evidence and repaired failures.

Metrics/syntax and CPU kernels were added afterward. Actual WASI `38891578037`
passes both hosts at `c8f4646c`, including registry shutdown, full 32-bit count
checks and final-block index overflow controls. Native `38893386853` at `457f00d3`
passes ARM Linux/macOS and AMD64 Linux; Intel macOS is running. Windows kernel,
decoder and metric checks pass but its newly added library-unload peer needs a
fixture export repair. Focused six-native `38894911944` at `234da577` validates
that repair; runtime/WASI sources remain unchanged. See the preparation worktree's
handoff for precise failure history and current results.

Kernel evidence compares the old and new executor on identical inputs and retains
C/binaries/disassembly; no timing claim is made. Single-worker native scratch falls
from 69,648 to 4,104 bytes for 8193 F64 values, while the result array remains.
Finish the unload repair and evidence, then rebase only the complete preparation
delta onto accepted #152 before opening its sole next delivery PR. Do not replay
numerical preparation ancestry. A later full run will also log individual GC
stress example durations; no concurrency or coverage was reduced.

## Local checks and delivery constraints

All local checks use `python3 scripts/local-guard.py COMMAND...` with unchanged
limits. No changed compiler was built locally. The earlier diagnostic compilation
stopped with an OS signal error; no process remained and limits were not raised.
Do not retry that refused workload. Full builds, suites and benchmarks run on CI.

Final vector source/binary/assembly/profile retention passed (0.20 s), actual loop
excerpt validation passed (0.15 s), and paired identity/sample checks passed
(0.19 s). Eight scalar-lane semantic cases passed the accepted interpreter
(1.36 s). Formatting, source-generated library docs, ownership inventory and
explicit target checks passed during preparation. Final target assignment checks passed (0.32 s) and the documentation audit
passed (2.67 s).

Standing authorization covers fixes, publication and squash merge after every
exact-head gate passes. Every commit is exactly one line, at most 80 characters,
with no body, trailers or attribution. Keep one delivery PR open at a time.
Browser/service re-entry, retained host callbacks, remaining numerical/network
contracts, cycles, derivative scaling and broader applications remain open.
JIT is excluded; OpenCL's existing runtime compilation is a gap to resolve.
Default tracing remains; this batch completes none of the seven whole work areas.
