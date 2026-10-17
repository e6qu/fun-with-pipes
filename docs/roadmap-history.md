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

## HTTP server owners and fixed function storage (PR #163)

[PR #163](https://github.com/e6qu/fun-with-pipes/pull/163) merged as
`0a468c9d0ee3283bd5de6a7cbc05126379ed3ee5` on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022259)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39073022233)
passed at `c998ce68b6beff90b0ba1097e92ede7a154f00f3`. The merge and tested head
share tree `084ea09970b2a7ff7ce9068ad2d9ff8a8707f2b0`; accepted #162 is the sole
parent. The entire message is
`Own HTTP server requests and eliminate fixed function allocations`.
Duplicate postmerge production `39079288609` is confirmed cancelled.

HTTP server connections, requests, handler captures and tasks have explicit
owners and cleanup on failure/cancellation. A 24-byte request handle replaces
separate 32-byte handle and job allocations. A nonescaping 64 KiB receive buffer
uses the stack; actual Linux serve frames are 67,240 bytes on AMD64 and 67,264 on
ARM64, excluding callees. macOS/Windows socket waits use OS readiness and real
deadlines, replacing periodic 10 ms sleeps. One copy of the existing ARC ownership
check reduces Linux HTTP instruction sections about 13%, without removing checks.

The compiler stores eligible fixed function captures in program storage instead
of rebuilding heap records. [Paired measurements](measurements/fixed-functions-2026-10-18.json)
record about 899 to 722 managed allocations and 2,318 to 1,901 reference-count
increments per additional HTTP request. Linux elapsed time falls about 4–6% for
this workload versus older fwp; this is not C/Rust parity. The report retains
hardware, inputs, flags, raw samples, startup, code/data size and memory scope.
All six final memory jobs pass; final managed storage is constant, and the largest
post-warm-up resident-memory increase is 2 MiB within the 8 MiB bound. All twelve
ordinary binaries contain 331 aligned function records totaling 7,592 bytes;
Linux instructions match all 618 startup capture stores. ARC binaries exclude
tracing. Downloaded binaries were inspected, never executed locally.

The original nine-job audit examined all 960 scheduled targets and 1,240 test
summaries. gRPC failure injection matched an unrelated HTTP statement; UDP failure
injection counted scheduler storage as a returned object. Both were repaired,
including controls that restore the broken behavior. All six focused repair jobs
then passed. The final production audit again accounts for all 960 targets and
1,240 summaries: 3,518 passed tests, no failures. Six native compiler jobs, both
WASI jobs and separate Intel HTTP ownership/comparison checks also pass.

## HTTP client owners and complete connection keys (PR #162)

[PR #162](https://github.com/e6qu/fun-with-pipes/pull/162) merged as
`1b542f32f352ecd34553f17fcce2de25b6f0bbb2` on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39055466891)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39055442588)
passed at `99d70deb9c9daa8fc041964f9cbee51e48047c38`. The squash has the same tree,
`0ff25a71b1b10a177d7f3a5dccc331861efdfa3c`, and accepted #161 as its only parent.
Its entire message is `Own HTTP client memory and preserve complete connection keys`.
Duplicate postmerge production `39062147625` is confirmed cancelled.

HTTP client pools, callers, I/O tasks and partial responses have explicit owners.
Cancellation/reset releases request storage. Complete connection keys preserve
long TLS options; connection allocation must succeed before socket/TLS ownership
transfers. Checked HTTP clients pass interpreted/native cleartext/TLS comparisons.
This delivery does not establish checked HTTP server support.

[Six-host evidence](measurements/http-client-owners-2026-10-17.json) retains 216
memory rows and inspection of 48 actual binaries. Final managed storage is
constant with request count; each additional high-level client call still makes
237 managed allocations and 543 retains. ARC binaries exclude tracing, but have
larger instruction sections. The [guide](benchmarks.md#http-clients-without-tracing)
explains counter scope, register/stack use and remaining code costs; no speed or
C/Rust parity claim follows.

The first six-host audit found a stale gRPC cleanup-injection target and two
Unix-only probes. The combined repair scopes the injection and uses native
Windows sockets and library loading. A second full audit completed all 72 target
executions and isolated one remaining Windows header-order error; both Windows
full reruns then passed all 24 targets. Final acceptance reran the complete
production matrix and docs. No failed or skipped run substitutes for those gates.

## Remote calls without tracing and record-field moves (PR #161)

[PR #161](https://github.com/e6qu/fun-with-pipes/pull/161) merged as `fd25a10c`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644736)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39044644846)
passed at `0e162dcd7544c9fce9aede02f9196fc061e6d258`.
The merge and tested head share tree `f10f9aa40d5889f959e6d45975381ac2cb6272a8`;
the parent is accepted #160 (`8ae595df`). The complete message is
`Compile remote calls with ARC and move unique record fields`.
Duplicate postmerge production `39051585338` is confirmed cancelled.

Checked gRPC clients/services prove iterator handler lifetimes and own decoded
replies, channel deliveries and caught errors. Unique plain-data record fields
move into compiled calls; shared values retain independent owners. Resource
lifetimes keep their existing rules. [Six-host evidence](measurements/remote-arc-field-moves-2026-10-17.json)
contains 216 repeated memory rows: greeting retains fall from three to two per
call, plus one connection retain; allocations and peak/final managed storage are
unchanged. Linux server final storage is 544 bytes; macOS/Windows zero. Actual
ARC binaries exclude tracing, but Linux text grows about 2.9–3.4%; stack and
file-layout costs are recorded separately. This is no timing or C/Rust parity claim.

The first production run (`39038709892`) exposed a stale test expecting two field
releases where moving needs one. The repair preserves partial/error cleanup and
adds controls that deliberately restore the old copies. All 710 targets scheduled
across the four failed jobs finished; only that ownership target failed. Both
Linux jobs ran 238 targets each, both regular macOS jobs 117 each. The other five
production jobs and docs passed. Final acceptance reran the complete matrix;
the original long-running RSS bounds also pass.

## Server cleanup and borrowed fold values (PR #160)

[PR #160](https://github.com/e6qu/fun-with-pipes/pull/160) merged as `8ae595df`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633846)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39030633906)
passed at `a8fa519d`. The tested and merged trees match; its parent is accepted
#159. Its complete message is
`Free server call storage and borrow values in fold callbacks`.
Duplicate postmerge production `39036532034` is confirmed cancelled.

Server task/job storage, decoded values, requests and connections have explicit
owners. Arguments and cleanup records stay on the stack; methods are called
directly. Known fold callbacks borrow captures and collection elements, acquiring
owners only when values escape. Socket shutdown wakes parked readers, and
cancellation removes stack wait records before their storage disappears.

The earlier partial implementation failed Linux ARM64 production `39025708821`:
RSS grew 17,104 -> 49,420 KiB across 32,000 calls. The combined repair preserves
the 8 MiB growth limit and passes that test in focused probe `39030258307` and
final production. The probe's five samples are all 8,136 KiB. A stale state fixture
and allocation-failure checks were also repaired without removing their controls.

[The six-host comparison](benchmarks.md#freeing-server-requests-and-borrowing-fold-captures)
records constant final managed storage: 544 bytes on Linux and zero on macOS and
Windows. Independently live owners still cost counts; callback borrowing removes
64 per-message channel retains per call. Code size and stack-frame changes remain
explicit in the report. These measurements compare fwp versions, exclude timing
and raw-buffer/OS costs, and do not establish C/Rust parity or complete GC removal.
Checked remote ARC is the next delivery, not part of this accepted change.

## Streamed input cleanup and continuation moves (PR #159)

[PR #159](https://github.com/e6qu/fun-with-pipes/pull/159) merged as `7c463441`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595534)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39016595480)
passed at `91398527`. The tested and merged trees match; its parent is accepted
#158. Its complete message is `Free streamed inputs after remote calls finish`.
Duplicate postmerge production `39022161689` is confirmed cancelled.

Client input iterators and finished senders release on completion, failure and
cancellation. Unique iterator nodes move their continuation; shared nodes preserve
it for older readers. Request resets and pre-entry cancellation agree with the
interpreter. [Six-host measurements](benchmarks.md#input-owners-and-moves-bounded-memory-with-measured-count-costs)
show bounded remaining managed storage across 1/16/256 calls. Complete-input
allocation counts are unchanged; reference-count increments remain higher than
the tracing-dependent baseline. Remote checked ARC remains unsupported.

This delivery also retains the six-host server-process baseline, identifying
remaining storage growth for the next server ownership work. It does not implement
server ownership or complete any of the seven project work areas.

## Closed connections and completed I/O tasks (PR #158)

[PR #158](https://github.com/e6qu/fun-with-pipes/pull/158) merged as `a96871c9`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071759)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39011071706)
passed at `30036a15`. The tested and merged trees match; its parent is accepted
#157. Its complete message is `Free closed connections and finished I/O tasks`.
Duplicate postmerge production `39016152665` is confirmed cancelled.

Closed client connections now release after their last storage owner, separately
from closing the socket. I/O task records have one scheduler owner and free
without task reference-count updates after their stacks and links are removed.
Library unload closes idle connections before draining tasks. Fatal allocation
errors exit without unsafe library teardown from a task stack; two stale failure
injection hooks were repaired before acceptance.

[Six-platform evidence](measurements/closed-remote-ownership-2026-10-17.json)
records constant final managed storage after 1/16/256 closed-call batches, with
collection disabled and physical freeing enabled. Linux AMD64 leaves 1,792 bytes,
ARM64 6,144; either Mac 640; Windows AMD64 1,024 and ARM64 896. Allocation
requests are unchanged; connection sharing adds three count increments per
connection. Actual Linux ARM64/AMD64 instructions confirm direct unique-task
freeing. These are bounded workload measurements, not whole-process memory or
C/Rust timing comparisons. Sender inputs and server lifetime work follow.

## Freed requests and transferred selected fields (PR #157)

[PR #157](https://github.com/e6qu/fun-with-pipes/pull/157) merged as `30668bf8`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39004098429)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39004095234)
passed at `57d2a09e`. Its tree matches that tested head and its parent is accepted
#156. Its complete message is `Free finished client requests and reduce reference counting`.
Duplicate postmerge production `39007997287` was canceled.

Finished requests and unread messages now release through explicit owners.
Selecting the only counted field from a uniquely owned heap record transfers
that field instead of retaining it again. Service TLS-settings construction also
cleans partial failures. The [combined report](measurements/remote-projection-moves-2026-10-17.json)
retains six-platform measurements and actual ARM64/AMD64 binary observations.
For 256 full reads, remaining managed storage on Linux AMD64 falls from 67,680
to 6,240 bytes and reference-count increments from 66,306 to 50,178 relative to
the original repeated-call implementation. Allocation requests are unchanged.
Connections and background I/O tasks are still alive at that sample; this is
neither a whole-process memory measurement nor a timing comparison with C/Rust.
Closed connections, pending sender inputs and server callbacks remain later work.

## Released stream caches and moved closure captures (PR #156)

[PR #156](https://github.com/e6qu/fun-with-pipes/pull/156) merged as `29302bae`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879616)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38996879603)
passed at `d19ab045`. Its tree matches that tested head; its parent is accepted
#155. Its complete message is `Release unused stream values and reduce memory bookkeeping`.
Duplicate postmerge production `39001824256` is confirmed canceled.

Native stream caches now release after their last reader, preserving retained
iterators and error/cancellation cleanup. Unique closures transfer captured owners
into partial or complete calls. In the measured one-pass client, remaining
managed storage stops growing with consumed values. Capture moves reduce retains
from the explicit cache-ownership implementation by about 40%; five allocations
per integer and about three times the original tracing-dependent retains remain.
This is a comparison between fwp revisions, without timing or C/Rust parity claims.

[The report](measurements/remote-client-capture-moves-2026-10-17.json) preserves
six-platform source `afd7d460`, raw samples and binary observations. Fixed-frame
cache cleanup uses a loop on ARM64 and AMD64. Windows failure injection and
fixture line endings were repaired before acceptance. Request, connection and
retained callback ownership remain subsequent work; this delivery does not
complete GC removal.

## Shared remote reads and bounded chain cleanup (PR #155)

[PR #155](https://github.com/e6qu/fun-with-pipes/pull/155) merged as `45410bea`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872293)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38990872208)
passed at `e71a2295`. Its files match that tested head and its parent is accepted
#154. The complete message is `Fix shared stream reads and bound cleanup stack use`.
Duplicate postmerge production run `38996775271` was canceled; Windows dependency
jobs were preserved.

Shared readers now receive the same cached value. Cancellation restores unfinished
messages for surviving readers, and error descriptions have the source's lifetime.
Stream positions shrink from 24 to 16 bytes. The queued-string workload requests
81 rather than 89 bytes per received value, with four allocations unchanged.
Ordinary linked structures wrapped in optional values and tuples release in a
loop, preserving aliases and reclaiming 16,384-link chains without stack growth.
These memory/stack comparisons do not measure speed or C/Rust parity.

The [stream report](measurements/remote-stream-compact-2026-10-17.json) and
[chain report](measurements/wrapped-chain-cleanup-2026-10-17.json) preserve their
actual component revisions, six-platform checks and binary evidence. Native
Windows fixture API, socket, OpenSSL-path and diagnostic-line-ending problems
were repaired before acceptance. Native caches still depended on tracing in
this accepted revision; explicit cache ownership is the following delivery.

## Service settings and iteration storage (PR #154)

[PR #154](https://github.com/e6qu/fun-with-pipes/pull/154) merged as `11ae0f63`
on 2026-10-17 UTC after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38977201910),
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38977126983)
and both new [Windows dependency jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38977201787)
passed at `51354d10`. Its files match that tested head and its parent is accepted
#153. Its complete message is `Reduce service memory and remove discarded iteration results`.

Service settings use stack storage; child tasks keep independent copies and shared
owners. The compiler forwards returned tuples directly and turns known state/service
callbacks into direct calls. List `each` stops building discarded empty results.
For the measured million-element count, median complete-process time falls from
56.93 to 27.30 ms on Linux AMD64 and 66.70 to 32.80 ms on ARM64. Each element avoids
one allocation and 32 requested bytes. These compare two fwp definitions, not
C/Rust parity. Input storage and state bookkeeping remain.

[The retained report](measurements/service-context-iteration-2026-10-16.json)
records limits, samples, layouts and actual instructions. Response-header capture
uses one allocation/24 requested bytes instead of two/48. Service task settings
still add 72 bytes per task. Complete operating-system thread-stack bounds fix a
live-root omission exposed on Linux ARM64. Explicit exit, failed/cancelled message
cleanup, complete Linux test selection and default-branch Windows dependency
caches also pass. Whole-service ownership and removal of tracing remain unfinished.

## Owned decoded values and network resources (PR #153)

[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) merged as `9bf203d7`
on 2026-10-16 after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38958379514)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38955543617)
passed at `f6dc9940`. The merged files match that head, its parent is accepted
#152, and its entire message is `Reduce temporary memory and clean up network resources`.
Duplicate postmerge production run `38971260589` was canceled.

Decoded byte/text results, copied service headers/bodies and UDP/TCP/TLS handles
now have explicit owners and cleanup. Socket captures keep handles alive; the
last owner closes them. Tests cover partial allocation failures, shared inputs,
size overflow, error order and deliberately omitted cleanup. The numerical
8,193-number case reduces one worker's temporary storage from 69,648 to 4,104
bytes while its result still needs 65,552 bytes. These are memory measurements
against earlier fwp, not speed or C/Rust parity. Whole services and retained
external callbacks still need ownership work before tracing can be removed.

The [service report](measurements/service-values-2026-10-16.json) retains the
focused measurements and native binary evidence. Windows TLS parsing setup and
allocation-failure probes were repaired before final acceptance. Mac test
scheduling preserves coverage; this delivery makes no measured total-CI speed claim.

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
