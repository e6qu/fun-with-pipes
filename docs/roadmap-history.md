# Delivery evidence

[PLAN](../PLAN.md) records delivered scope and remaining engineering gaps;
[the handoff](development-state.md) records current work. This index supplies
verification references, not executable next actions. Superseded session plans,
repeated handoffs and under-specified timing tables have been removed from the
working documentation. Original records remain in the
[immutable pre-cleanup snapshot](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md).
[Preparation anchors](roadmap-queue.md) retain their original hashes and tags.

## Accepted deliveries

| Delivery | Evidence |
|---|---|
| Native macOS | [PR #74](https://github.com/e6qu/fun-with-pipes/pull/74), ARM/Intel native and interpreter gates |
| Runtime ownership and representation | [PR #124](https://github.com/e6qu/fun-with-pipes/pull/124), [#125](https://github.com/e6qu/fun-with-pipes/pull/125), [#126](https://github.com/e6qu/fun-with-pipes/pull/126); contracts in [ownership](ownership.md) and [primitive inventory](primitive-ownership.md) |
| Numerical kernels and autodiff | [PR #127](https://github.com/e6qu/fun-with-pipes/pull/127), [measurement report](measurements/numerical-kernels-2026-10-12.json) |
| Final ownership/ARC | [PR #128](https://github.com/e6qu/fun-with-pipes/pull/128), [measurement report](measurements/ownership-and-arc-2026-10-12.json) |
| Completion documentation | [PR #129](https://github.com/e6qu/fun-with-pipes/pull/129) |
| Tacit examples and macOS test shards | [PR #130](https://github.com/e6qu/fun-with-pipes/pull/130) |
| Iterator consumers and record projections | [PR #131](https://github.com/e6qu/fun-with-pipes/pull/131), source/gates below |

PR #128 merged as `7350a5566fa991c89916ea67ab693c2a0bba9327`, tree
`fcabfba0e0ca6b7a3e0ef0f7b99792bad7da8381`. All six jobs in
[CI 38256949765](https://github.com/e6qu/fun-with-pipes/actions/runs/38256949765),
[roadmap_docs 38256949763](https://github.com/e6qu/fun-with-pipes/actions/runs/38256949763)
and [merged-source audit 38268514619](https://github.com/e6qu/fun-with-pipes/actions/runs/38268514619)
passed. This completes the six-phase roadmap, including checked ARC for its
proved subset, not general collector-free execution.

PR #129 tested `bedbf8a1fe22127567305eb17be5efa3bc4366e7` and merged as
`592a5953b8351e67fe30ca637426007f8763b5a4` with identical tree
`fa17c2b3a29effe8876f0bb9ccf92a94144a05aa`. All six jobs in
[CI 38274773884](https://github.com/e6qu/fun-with-pipes/actions/runs/38274773884)
and [roadmap_docs 38274773721](https://github.com/e6qu/fun-with-pipes/actions/runs/38274773721)
passed before merge.

PR #130 tested `13886787b5b96c195595ad57b3a1f2689c2d7889` and merged as
`db10b9fd9849446475a68caaf832f17bfe76ba9e` with identical tree
`efd9d775b616e59074a9efdb0f04fc128f5706e8`. All six jobs in
[CI 38312668875](https://github.com/e6qu/fun-with-pipes/actions/runs/38312668875)
and [roadmap_docs 38312668877](https://github.com/e6qu/fun-with-pipes/actions/runs/38312668877)
passed before merge. Completed logs verified all 170 ordinary integration
targets once per macOS architecture, split 85/85, plus separate GC stress.
PR #131 subsequently raised that coverage to 171 targets, split 86/85.

PR #131 tested `a920caf9c3e84f039ac4e6850c607cb34dcf2585` and merged as
`8ae361a43f7634bf818ec8415d8c1ea95fdb74ed` with identical tree
`baeb50b1826a6593d838ff0ea7aa7bdc823d0ffb`. All six jobs in
[CI 38322220083](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220083)
and [roadmap_docs 38322220076](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220076)
passed before merge. Main documentation audit 38327360003 passed; duplicate
main CI 38327360005 was cancelled after verified tree parity and supplies no
passing gate. The complete squash message was one line:
`Add direct iterator consumers and record projection shorthand`.

## Archived numerics timing samples

The [original samples](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-numerics-timing-samples)
lack recorded processor/compiler/flags and allocation/live-memory data. They
are not a current baseline. Use the numerical measurement report above for
scoped accepted evidence.

## Archived tensor kernel timing samples

The [original samples](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-tensor-kernel-timing-samples)
include input construction on an unspecified loaded host. They cannot establish
current macOS performance or equal isolated interpreter/native kernel speed.

## Archived representation measurement detail

The [original layout and native-code probes](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-representation-measurement-detail)
record shape-specific ABI and allocation observations. Current representations
and their limits are specified in [ownership](ownership.md#accepted-numeric-representation).
Preparation evidence alone does not establish merged support or general speed.

## Archived primitive contract notes through queue18

The [original contract probes and controls](https://github.com/e6qu/fun-with-pipes/blob/8ae361a43f7634bf818ec8415d8c1ea95fdb74ed/docs/roadmap-history.md#archived-primitive-contract-notes-through-queue18)
preserve early ownership evidence. Current coverage and exceptions are specified
in [primitive ownership](primitive-ownership.md); do not treat early inventory
counts or preparation instructions as current work.

## Recovery evidence

Durable recovery branch: `roadmap/handoff-pr123-20261011`; last verified
checkpoint `3af176bc210cd9de367bbdf98d2eb49b2626098f`, audit 38285912566,
covering 275 targets / 31,127,348 bytes. On recovery, query the branch tip and
use its current-map.json and designated publisher. Restore through the
hash-checking restore-roadmap-recovery.py procedure; never rerun completed
publishers. The immutable snapshot above retains the detailed provenance.

## Ten-task platform and ownership bundle (PR #132)

Accepted 2026-10-13 in [PR #132](https://github.com/e6qu/fun-with-pipes/pull/132),
squash `c67800ec8530e44501c54c69719af26b0585bedc`, tested head
`7036ecebdbef50a5a8f851ed084378c830af1e79`, identical tree
`0ea780f684a8da12baa549986a4f5bc4feebbc47`.
[Production CI](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034611)
passed Linux ARM64/AMD64, bench and regular/GC macOS ARM/Intel jobs;
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034667) passed.
Four separately packaged native compilers passed outside-checkout execution.
The bundle delivered consumer fusion, known callback specialization, flat loop
state, counted CSV trees and I128/U128 leaves, and scoped autodiff ARC proof.
It fixed CSV generational root corruption, wide overflowing-result cleanup,
portable signed 128-bit multiplication and U64 multiplication overflow.
[Four-platform measurements](measurements/native-ownership-2026-10-13.json)
retain focused controls. At 1,000 elements, paired map/filter/fold requests fell
from 9,511 to 4,003; lazy producers still allocate. Warm AD workloads allocate
no new native workspace buffers but still allocate managed result arrays.
No general GC-free or zero-allocation claim follows from this acceptance.

## Seven-step reconstruction and numerics bundle (PR #133)

[PR #133](https://github.com/e6qu/fun-with-pipes/pull/133) merged as
`d14ec10d24765c2686dc4cfb0798012611c02a61`, with tree
`e3d3f8aa5ddee7843fe9e00c85cf0ffb5b2304a0` identical to tested head
`70de849771aff10a3af938746c82f9b975bc989b`. All seven production jobs in
[38423073356](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073356),
all four preflight jobs in
[38423088702](https://github.com/e6qu/fun-with-pipes/actions/runs/38423088702),
[PR docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073506) and
[merged docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38435135341)
passed. Native Windows and true half/quad formats were outside that delivery.
The complete squash message is `Complete reconstruction ownership and native numeric workers`.
Temporary branches were removed. Duplicate main CI 38435135553 was cancelled
after tree parity verification; it supplies no passing gate. Final fixes remove
WASI managed/scratch allocator mismatches and preserve ternary JSON range errors
at I128 minimum. Actual WASI goldens pass on both Linux architectures.

The [measurement record](measurements/reconstruction-and-workers-2026-10-13.json)
retains hardware, compiler, flags, workloads, allocations and charged live
storage. At 08f4231, all four platforms passed the focused regression, iterator
instruction/allocation and inventory stages in
[38401069936](https://github.com/e6qu/fun-with-pipes/actions/runs/38401069936);
that run's old wide harness failed and is not a passing overall gate. Corrected
wide evidence passed all four platforms at 45ed2ce in
[38402851452](https://github.com/e6qu/fun-with-pipes/actions/runs/38402851452),
with unchanged compiler/runtime sources. The numerical/ARC/AD evidence is
[38401073468](https://github.com/e6qu/fun-with-pipes/actions/runs/38401073468).
Final ternary wire validation, stride-aware decoder controls and cold overflow
formatting are tested at 615e224 in
[38406723936](https://github.com/e6qu/fun-with-pipes/actions/runs/38406723936),
which also retains per-worker stack usage. These evidence runs do not replace
production acceptance on the final PR head.

For 1000 elements, requests fall from 6005 to 6 (fold), 7009 to 8 (State each)
and 9511 to 6 (map/filter/fold). The measurement includes CLI/printing and its
64 charged retained bytes, so it is not a checked ARC reclamation claim.
The I128 and U128 256-element workloads each fall from 513 to 2 requests and
4096 to 32 peak charged bytes, with no collections or retained charged storage.
Native instructions use register pairs and checked carry/overflow operations;
recursive workers still consume stack. Equivalent C/Rust and AD measurements
remain scoped to recorded workloads, with no universal speed claim.

The [float-format decision](float-formats.md) explicitly preserves current
F16/BF16-as-F32 and F128-as-F64 behavior until a coordinated precision and wire
migration. True formats, general cyclic/foreign ownership and Windows are
future directions, not claimed deliveries of this bundle.


## PR #134 development evidence (not final acceptance)

These focused runs establish the listed boundaries on their recorded heads.
PR #134 later merged the implemented subset; the six directions remain
unfinished. Use [the handoff](development-state.md) for current next actions. No row replaces final-head production CI.

| Head | Passed evidence | Boundary |
|---|---|---|
| `217d6da` | [Four native targets, scalar foreign ARC](https://github.com/e6qu/fun-with-pipes/actions/runs/38439707405) | ABI-classified scalar calls; managed strings, pointers and callbacks rejected |
| `fb199e7` | [Both WASI targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38440780537) | Actual freeing across 10,000 cycles and 300 aliases, omitted-free controls and full goldens; unproved graphs retained |
| `277bf4a` | [Four native targets, iterate fusion](https://github.com/e6qu/fun-with-pipes/actions/runs/38441649508) | Eager lookahead, effects/traps, early stopping and owned captures; allocation/instruction evidence |
| `106e7a2` | [Both native Windows targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38444619376) | Rust compiler/socket/DLL execution, exact core and all interpreter goldens; not full generated C support |
| `6f7b105` | [Windows allocator](https://github.com/e6qu/fun-with-pipes/actions/runs/38446144465), [four-platform portability](https://github.com/e6qu/fun-with-pipes/actions/runs/38446150831) | Actual Windows commitment/reuse, PE image roots and missing-root control; no complete Windows runtime claim |
| `4437af0` | [Both WASI targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38446752701) | File header destruction, libc free observations and omitted-free controls, full goldens |
| `367227a` | [Four-platform decimal core](https://github.com/e6qu/fun-with-pipes/actions/runs/38449726111) | Direct rounding, shortest text, scoped allocation failure and leak controls |
| `55b86f2` | [Both Windows targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38450846100), [both WASI targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38450850527) | SDK-aware compiler selection and actual WASI loader exclusion; full run superseded |
| `ebaff5a` | [Both Windows targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38453332518), [both WASI targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38453337836) | Full-width integer core and decimal-preserving literal/macro goldens |
| `412a813` | [Both WASI targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38455262012), Linux ARM64 job in [portability](https://github.com/e6qu/fun-with-pipes/actions/runs/38455264989) | Fixed-storage transcendental math, native/WASI C ABI and full WASI goldens; other portability jobs were still pending at this record |
| `02a802d` | [Both Windows targets](https://github.com/e6qu/fun-with-pipes/actions/runs/38457143007) | Explicit C++ type-traits dependency, rounding/remainder core, native C caller, allocator and all interpreter goldens |

[Iteration measurements](measurements/iterate-producer.json) retain hardware,
toolchains, flags, source hashes and memory counters. At 1,000 elements, direct
iterate fusion uses 6 allocation requests versus 8,006 unfused and 4,005 with
consumer fusion alone. The fused worker has no dynamic consumer/tail calls or
state-record construction. All variants retain the 64-byte CLI baseline;
startup-inclusive timings do not establish a speedup.

CI repairs preserve coverage: the macOS sharder accepts Cargo-managed build
scripts; WASM excludes native loader references with an explicit unsupported
foreign-call diagnostic; Rust MSVC compilation uses SDK-aware Clang separately
from LLVM-MinGW generated C. The reclaimed WASM allocator's old bump-size
fixture was replaced with actual alignment, zeroing, request-size and failure
controls under ASan/UBSan. Missing `llvm-ar` was fixed by installing LLVM.
The Windows math C caller required an explicit `<type_traits>` include.

[Full run 38450820067](https://github.com/e6qu/fun-with-pipes/actions/runs/38450820067)
passed regular ARM macOS and bench before its remaining jobs were cancelled in
favor of the newer full run and current repair checks. Superseded full runs
38449448089 and 38449666918 were also cancelled. Both full macOS GC stress
suites at `4437af0` passed before the second shards hit the repaired metadata
issue. Cancelled, skipped and partially passing runs are not full acceptance.

Local focused checks used `python3 scripts/local-guard.py`. Standalone helpers
in `/private/tmp` ran the 16 scalar-core Rust tests, six lexer tests and library
signature generation; C decimal/allocation-failure/leak controls, native allocator
image-root controls and C++ math linking/dependency/sanitizer checks also passed.
Permanent native/WASI controls live in `tests/softfloat_core.rs`,
`tests/float_math.rs`, `tests/float_literals.rs` and the ownership tests; temporary
helpers are not required repository dependencies. Formatting, focused clippy,
sharder regressions and roadmap audits passed. Full builds stayed on runners.


## PR #134 merge closeout

Merged by the user on 2026-10-13 at 21:40 UTC (2026-10-14 locally) as
`5c0287c959ad705a6ceefebe83346015cb23fff5`. Tree
`f6f70ed9e41cde021ba223241f59b7cee745b4b0` equals tested head
`29b48c31a7012c941d0bc555ee51d12c2c594b0b`. All seven
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221)
and [final-head docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467)
passed. All four [focused repair jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458280091)
passed at `5bad4a6`. The squash subject is the single line
`Expand ownership and numeric formats across native platforms (#134)`.

This accepts the implemented scalar foreign ARC, typed WASM/File reclamation,
direct iterate fusion, decimal-preserving syntax, exact-format software cores,
and Windows interpreter/allocator foundations. It does not complete full Windows
support, true half/quad language representations, remaining managed foreign and
callback ownership, broader worker specialization, or nested reverse AD and
checkpointing. These five implementation areas carry forward in PLAN.


## PR #135 development evidence

The user merged this subset on 2026-10-14 as
`ad37059e5769a54911ee05ee3b7a11faf90f3480`, tree-identical to head
`5d6e96d895b80d8d4e9c142944a7016453e84f40`. This merge preceded final platform
acceptance. [Autodiff 38550312989](https://github.com/e6qu/fun-with-pipes/actions/runs/38550312989)
at this head passed on all four Linux/macOS hosts: nested analytical and
active-zero derivatives, checkpointing, ARC release controls and existing tape
lifetimes/unload. This focused run does not establish a full production gate. Windows `38546869551@fc697328` passed native goldens
and standalone compiler build on both architectures, but failed TLS peer tests
(system Schannel curl with PEM fixtures and reset-vs-alert diagnostics).
These failures and all remaining work continue in one follow-up branch,
`roadmap-after-135`. The merge itself is not evidence of completed support.

These focused runs preceded final acceptance and do not establish a passing
merge gate. Current work and failures live only in the session handoff.

- At `dfca8e6`, [four hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/38527790040)
  passed exact-format/protocol/array and all seven foreign ABI/export checks.
  Reversed compose arguments in two new fixtures were corrected by `9aed34b`.
- At `9aed34b`, [all four hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/38528964109)
  passed retained-task/scoped foreign ownership and wide-record controls.
  The measurement assertion was corrected to the specified shortest quad text.
- At `4456bff`, [wide measurements](https://github.com/e6qu/fun-with-pipes/actions/runs/38532221118)
  passed on all four hosts. [Permanent counters](measurements/wide-records-2026-10-14.json)
  show I128/U128 sum requests 513→2, requested bytes 8206→30 and peak bytes
  4096→32; F128 requests 513→2, bytes 8209→33, peak 4096→48. Mixed records
  reduced requests 3878→48, bytes 99742→1590 and retains 4625→12, with peak
  1040 unchanged. Charged live bytes and collections finished at zero.
  macOS ARM instructions exposed recursive wide-worker calls, motivating
  explicit self-tail loops; source structs alone did not prove stack bounds.
- At `55addedb`, the [macOS ARM focused job](https://github.com/e6qu/fun-with-pipes/actions/runs/38538182945)
  passed corrected numeric tail/preemption, TLS and existing ownership checks.
  Its new executable fixture failed on lowercase cons; the fixture and its
  overly permissive reference status check were repaired.
- [Windows at 55addedb](https://github.com/e6qu/fun-with-pipes/actions/runs/38538174843)
  passed ARM and repaired AMD64 process stress, but AMD64 task verification
  still found a missed root. Sharing the application stack bound between
  marking and verification excluded collector scratch; [6fde679d](https://github.com/e6qu/fun-with-pipes/actions/runs/38542607906)
  passes generated resource/task/process stress on both architectures.
- At `3800499`, [all four hosts](https://github.com/e6qu/fun-with-pipes/actions/runs/38526720651)
  passed exact-core companion linking and concurrent cache publication/eviction.
- At `bb523a5`, [both actual WASI jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38523463736)
  passed goldens, math cores and physical reclamation; [Windows foundations](https://github.com/e6qu/fun-with-pipes/actions/runs/38523466974)
  also passed both native architectures. Later changes need fresh final gates.


## PR #136 implementation verification

[PR #136](https://github.com/e6qu/fun-with-pipes/pull/136) completes the six-step
implementation after the user merged PR #135 as `ad37059e` before acceptance.
[Production 38568712872](https://github.com/e6qu/fun-with-pipes/actions/runs/38568712872)
at `01c686d1` passes eight of nine jobs: Linux ARM64/AMD64, regular ARM/Intel
macOS, ARM macOS GC, native Windows ARM64/AMD64 and benchmarks. Intel GC passed
the full stress golden suite, then reached its 90-minute limit during wide
workers without a failed assertion. This run is diagnostic evidence, not a
passing merge gate. REST took 427 seconds; earlier Intel wide workers took
144 seconds. Moving those two targets to regular preserves complete coverage
and the existing limits. [Docs 38568712866](https://github.com/e6qu/fun-with-pipes/actions/runs/38568712866)
passes at the same head. Final acceptance requires all nine production jobs
and docs on PR #136's final head before squash merge; inspect the PR's checks
and merge state for that delivery record.

[Focused WASM 38566937737](https://github.com/e6qu/fun-with-pipes/actions/runs/38566937737)
passes both Linux architectures at `cce2a70f`, with the same compiler/runtime as
`01c686d1`: exact arithmetic, physical reclamation, CLI/browser execution and
native executable ownership. Production Linux also passes Asyncify checks.
[Focused AD 38560981174](https://github.com/e6qu/fun-with-pipes/actions/runs/38560981174)
passes all four Linux/macOS hosts at `b4d072bb`, including nested derivatives,
stable completed-task identities, partial-retain failures, omitted releases,
cancellation, unload, workspace/tape bounds and checkpoint measurements.

Repairs preserve the semantic expectations: typed executable closure pointers
fix wasm32 static initialization; cleanup protects partially retained tape
seeds and unpublished tasks; stable task identities prevent reused scheduler
slots from accepting stale AD values. Test repairs correct collector-only root
placement, permanent scheduler baselines, Windows peer-close diagnostics,
CRLF handling, synthetic cancellation stack bounds and failure injection.

Permanent artifacts record equivalent workloads and limitations:
[wide records](measurements/wide-records-2026-10-14.json) reduce wide scalar
allocations 513 → 2 and mixed record allocations 3,878 → 48;
[checkpointing](measurements/checkpoint-2026-10-14.json) at interval 32 reduces
peak tape bytes 262,248 → 2,152 while increasing managed peak 336 → 12,816,
allocations and elapsed time. These separate peaks need not coincide. All
measured storage is reclaimed without collection; neither result establishes
universal allocation-free execution or C/Rust performance parity.


## PR #136 merge acceptance

Merged as `2684241dfb474fd489ec2e3e328627b1c143bed0`, tree-identical to
`26f2c68adab671ec54c29dbf2bc02df251a679b6`.
[Production 38583750060](https://github.com/e6qu/fun-with-pipes/actions/runs/38583750060)
passes all nine jobs and [docs 38583749770](https://github.com/e6qu/fun-with-pipes/actions/runs/38583749770)
passes at that head. Intel GC finishes in 73 minutes after rebalancing REST and
wide-worker tests, with complete coverage and unchanged limits. This accepts
all six roadmap steps. The squash message has one line and no body or trailers.
Later work follows the user's subsequent request to continue.


## PR #137 focused evidence

The user requested continued development after PR #136. The bounded follow-up
trims numeric adjoint storage and reverse scanning after the last seeded output,
retains every input and amortized workspace growth, and preserves forward work.
[AD 38601394373](https://github.com/e6qu/fun-with-pipes/actions/runs/38601394373)
passes all four Linux/macOS hosts at `920f5aa9`, including nested AD, workspace,
scope/unwind/cancellation and deliberate full-storage/full-scan controls.
[WASM 38601399062](https://github.com/e6qu/fun-with-pipes/actions/runs/38601399062)
passes both Linux hosts, including physical reclamation and CLI/browser execution.

[Permanent measurements](measurements/ad-prefix-2026-10-14.json) retain four
host reports, hardware/compiler/flags, raw timings, actual allocations and
binary/disassembly hashes. The identical unused-suffix workload records 12,291
nodes but needs three adjoints. Peak tape storage falls 491,648 → 393,344 bytes,
with unchanged managed counts and zero final storage/collections. Process timings
show no consistent speedup. Native instructions on all four hosts confirm the
computed prefix controls allocation and reverse-loop bounds. This is focused
evidence; final delivery requires all nine production jobs and docs on
[PR #137](https://github.com/e6qu/fun-with-pipes/pull/137)'s final head before merge.

## PR #137 merge acceptance

PR [#137](https://github.com/e6qu/fun-with-pipes/pull/137) merged as `38da1401`,
tree-identical to tested head `37104959`. All nine production jobs in
[38604595248](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248) and
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927)
passed. Numeric backward passes retain every input adjoint and stop at the last
seeded output; validation, seed arithmetic and unwind ownership are preserved.
[Four-host measurements](measurements/ad-prefix-2026-10-14.json) show a
98,304-byte peak tape reduction in the recorded unused-suffix workload, with no
consistent process-time speedup. The squash subject is one line without trailers.

## PR #138 merge acceptance

PR [#138](https://github.com/e6qu/fun-with-pipes/pull/138) merged as `d77b3fea`,
tree-identical to tested head `f251fbd1`. All nine production jobs in
[38666526202](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202) and
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103)
passed. Operation metadata excludes inputs while tokens and adjoints retain
absolute indices; partial managed-weight retains unwind safely.
[Four-host measurements](measurements/ad-operations-2026-10-15.json) record lower
tape storage, more cold growth requests for mapped/nested workloads, and no
consistent process-time speedup. The squash subject is one line without trailers.
