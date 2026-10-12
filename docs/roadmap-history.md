# Historical development notes

The active priorities and checks are in [PLAN](../PLAN.md) and
[the handoff](development-state.md). This file preserves delivery evidence;
it supplies no next actions. Repeated session instructions and large proof
payloads are retained in the [verified immutable history snapshot](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md).
The full snapshot predates the current numeric bundle and remains reachable by
its commit hash. Its root history hash was checked before this index was created.

Native macOS support was delivered in PR74. The ownership series through PR125
establishes the documented compatibility model; unmodeled graphs and shared
cycles retain tracing. Queue preparation anchors remain in [the queue](roadmap-queue.md).
Current representation measurements appear below, followed by historical
measurements and an index retaining every earlier heading anchor.

## Numeric representation preparation before production acceptance

Typed worker9fe843746e9dd9a7ebf890caaa58a5b656a46076 passes38195896907 on
Linux and ARM/Intel Macs. Packed1432b969b0ed1f780ffced363cc646e569bc4869 passes
38199430982 on all three. Retention policy and permanent controls at
21117f4971e838cf3ccfcf8aa001be804d16bc44 pass38200555737 on all three, including
actual Linux wasm32 counts. Final formatted source with zero-byte protocol and
direct-array decoder controls at6bf6b1f2a5fb661d180403c22bf5d18ffede5c39 passes
Linux finalization38201574707. None is the production six-job merge gate.

For257-element I8/U8, I16/U16 and I32/U32/F32 arrays, header+payload requests
change from2064 bytes to265,522 and1036 bytes respectively; F64 remains2064.
The8-byte header is unchanged. All widths, signed extension, alignment and
negative-zero/NaN bit bridges pass actual byte controls. ARM three-F64 workers
return in d0/d1/d2; Intel24-byte aggregates retain caller storage. Diagnostic
no-inline and ordinary optimized assembly are stored separately. These are
representation/ABI observations, without a timing or total process memory claim.

On the257-element I8 slice fixture at O1/O2, a200-element view requests289 bytes
versus3672 for the word-layout copy. A nested128-element view requests313 versus
4704. Each retains a320-byte backing slot plus a32-byte view slot, both freed at
last-owner drop without a tracing collection. A3-element small copy requests276
bytes in total, frees the320-byte backing before return and frees its16-byte
result slot at drop. Complete counters include initializer fast paths exactly
once. Backing-retain/drop and counter omissions fail the intended controls.
Reports record each runner's hardware/compiler/flags and object capacities; they
exclude GC page overhead and whole-process live memory. These are not NoTrace
acceptance results. Full proofs and source hashes are in the immutable recovery
checkpoints and the current handoff.

## Retained historical measurements

## Archived numerics timing samples

These earlier samples lack a recorded processor model, compiler/flags and
allocation/live-memory data. They are historical observations, not the baseline
for roadmap performance acceptance. New comparisons use the measurement
contract in [ownership.md](ownership.md).

**Performance** (`cargo test --release --test numerics -- --ignored
--nocapture`, a function of n inputs with 4n operations, on a shared
4-core machine):

| | native | interpreter |
|---|---|---|
| `grad`, n = 100 | 0.012 s | 0.48 s |
| `gradient` (forward), n = 100 | 0.016 s | 0.50 s |
| `grad`, n = 1000 | 0.012 s | 0.32 s |
| `gradient` (forward), n = 1000 | 0.75 s | not measured |


Refreshed normal Linux evidence runs37992999275 (reuse tokens),37992657684 (storage plus repaired root controls) and37993159029 (serving plus repaired HTTP2 omission control) all pass at25fc868/e5bbfd8/3aca5cf respectively. They include their normal lint/format, selected ownership tests, actual tracing churn and shared roadmap audit. Each source matches its recorded production preparation. These focused runs do not replace sequential exact-head platform gates.

## Archived tensor kernel timing samples

These old samples describe100 fused steps of8 operations (including sqrt, sin,
exp, ln and cos), summed with tensor.sum-on. They ran on an unspecified shared
4-core machine with reported load about12. Processor model, compiler/flags,
allocations and live memory were not recorded, and input-list construction is
included. They do not establish current macOS performance, a speedup lower
bound or equal isolated kernel speed between interpreter and native backends.

| elements | device | native | interpreter (release build) |
|---|---|---|---|
| 1 000 000 | `CpuParallel 1` | 3.37 s | |
| 1 000 000 | `CpuParallel 2` | 1.84 s | |
| 1 000 000 | `CpuParallel 4` | 1.75 s | |
| 200 000 | `CpuParallel 1` | 0.60 s | 1.18 s |
| 200 000 | `CpuParallel 4` | 0.26 s | 0.84 s |

The live numerics page now links this archive instead of duplicating the table
and its unverified performance inferences. Numeric lifetime source review is
referenced to the current published source112 b45e93a71d40; runtime/fwp_rt_kernel.c
and src/numerics.rs are byte-identical to the earlier reviewed996d5ee4ef4f.
This documentation correction adds no numeric implementation or newly executed
numeric regression. Ownership exit gates still precede representation/numerics.

## Archived representation measurement detail

Focused ARM64 layout evidence for returned-variant preparation44 confirms an
8-byte `V`, an 8-byte array header and 8-byte element slots; its three-field
variant occupies32 bytes, aligned to8, with fields at offset8. Exact original
positive/control binaries, compiler inputs, flags and disassembly are retained
and recorded in [history](roadmap-history.md). The O2 alias transfers share one
32-byte stack slot; this shape-specific evidence is not a general ABI or timing
claim. Natural-width numeric slots and broader register/FFI evidence remain phase3.

The six-I64 recursive worker in preparation65 has a 48-byte value, aligned to8,
versus56 bytes for the boxed header and fields, excluding collector metadata.
Actual ARM64 O1/O2 binaries return it through caller storage using x8; the
recursive worker uses192/208-byte frames respectively, including trap temporaries
and stack protection. O2 passes six fields in x1–x6 to the next worker and uses
vector loads/stores for the result. Its own body has no record-allocation call;
the boxed interface wrapper remains. These measurements on Apple M4 Pro,
macOS15.6.1 and Apple clang17 retain the original flags and strict semantic
controls. They establish an ABI baseline, not a timing improvement, constant
stack use or whole-program allocation freedom. Phase3 must measure caller
storage and spill costs alongside box elimination; details are in history.

Preparation79's actual ARM64 frame-record control eliminates one16-byte parent
box (8-byte header plus8-byte field, excluding collector metadata). The generated
program-thread frame is1232 bytes with typed fields versus1280 in the boxed
control at both O1/O2; the launcher frame remains144 bytes. The File header is
24 bytes/aligned8 before inline-path preparation80. Original zero/one allocation
counters and partial-retain controls pass, with exact binaries/flags/disassembly
retained. These are fixture-specific representation measurements; ordinary File
and path allocations remain, and no timing or general ABI claim follows.

Preparation80's actual ARM64 inline-path File header is16 bytes/aligned8,
with refs at offset8 and path bytes at offset16. The retained legacy control is
24 bytes/aligned8, with its path pointer at8 and refs at16. For an n-byte path,
original counters verify one leaf allocation requesting16+n+1 bytes versus two
allocations requesting24+n+1, excluding allocator/collector metadata. Both
original tests retain exact interpreter behavior and closed-handle display.
Actual binaries, C, flags and both compiled layouts are in history. This is a
constructor/layout improvement; storage disposal and general performance remain
separate roadmap work.

Preparation83's actual ARM64 variant holder occupies16 bytes/aligned8, with
its payload at offset8. Original counters verify zero parent boxes versus one
16-byte box in the comparison path. The program-thread frame is1280 bytes at
O1 and1264 at O2, versus1280 boxed; both launcher frames are128 bytes. Static
body instructions are506/539 typed/boxed at O1 and572/625 at O2, including
startup and trap paths. Original inactive scalar/nullary tags and partial-retain
cleanup remain checked. These are representation measurements, not executed
instruction counts or timings; File/path allocations remain. Exact source,
flags, binaries, disassembly and compiled layout are recorded in history.

Preparation 111's actual ARM64 packed TLS-options header is 64 bytes/aligned 8;
insecure/key-length/users fields are at offsets 40/48/56. Original probes verify
one allocation of 101 bytes for empty inputs and 8311 bytes for the tested
4096-byte name plus other fields, with copied inputs and last-owner release.
The payload contains both terminated strings and a length-framed identity key;
packing removes separate allocation requests, rather than the duplicated key
bytes. These requested sizes exclude allocator metadata. Captured O1/O2 Mach-O
binaries, disassembly and a layout executable use unchanged compiler arguments.
Instrumented constructor frames are 208/144 bytes; observer code affects these
frames, so they are not production ABI or timing claims. Details are in history.

Preparation 112's actual ARM64 connection header is 272 bytes/aligned 8, versus
520 bytes/aligned 8 in the retained legacy layout. The address pointer is at
offset 24; complete copied address bytes follow the header at offset 272.
Original counters verify one request of 272+n+1 bytes for an n-byte address;
"short" requests 278 bytes instead of the legacy 520-byte header. Long-address
loopback/pool reuse and the exact truncation-control failure pass. Actual O1/O2
positive/control binaries, disassembly and compiled layouts are recorded in
history. Requested sizes exclude allocator/collector metadata; no timing,
cache-speed or general collector-free claim follows.

A separate bounded local ARM allocator check reads actual Darwin malloc usable
bytes and GC slot metadata from the captured generated C. TLS requests101/8311
occupy112/8704 usable bytes. The short connection request278 occupies a320-byte
GC slot; the original520-byte header-size allocation occupies640 in the same
unchanged allocator. The latter measures the old size, without executing the old
constructor. These capacities exclude allocator metadata and pool reservation.
Hardware, compiler, flags, generated diagnostic C and actual binaries are in
[history](roadmap-history.md#actual-local-grpc-allocator-capacity); Intel capacity
and cache/timing effects remain unmeasured.

Prepared source112 also has actual ARM and Intel macOS layout evidence in
CI38075612557 at evidence head5a56aa1ebbc2b609ebd51c675d44e454ddedba8d.
Both original TLS-options/address probes pass without ignored tests. Both compiled
layouts give TLS64/align8 and connection272 versus legacy520/align8; allocation
requests remain101/8311 and278 for the stated fixtures. Actual C, Mach-O binaries,
arguments, symbols, assembly, hardware/compiler and layout drivers are retained.
These are prepared-source results; they do not accept later production heads.
Instrumented frames and static instruction counts describe fixtures, not general
speed, cache behavior or a production ABI. Full details are in history.


Final queue41 publication1.99CPU/19.24elapsed and all three audits44/106/72
pass at frozen5a068dc348f3b331a262543ae4ee2b1fcf88f0ab. Both original commits
and original source/probe/workflow bytes survive; oldcca935846750 retained
before exact lease. Sole PR119 opens0.16CPU/3.76elapsed with actualbase
e07b03d9d404. CI38098598991/docs38098598965 queued, not accepted gates. Actual
main118 docs38098095374 passes. Removed accepted33–40/duplicate34 rows from
the live primitive prepared table; current contracts remain in merged ownership.
Condensed representation measurement detail into a baseline table plus links,
keeping exact C/binary/layout/flags and limitations in the archive. Next queue42
has three existing commits, including both original feature/regression commits;
its eventual final rebase must retain all three.

Fresh streamlined-docs audit0.47CPU/3.94elapsed passes44 link sets,106 immutable
pairs/tags and72 live heads/bases. Deferred PR119 merge/protection/acceptance
and three-commit queue42 rebase helpers parse0.00/0.14s with current doc anchors.
Recovered PR118 exact-head gate proof confirms all seven jobs completed
successfully before the observed remote merge (0.11CPU/2.60elapsed).
Source-only representation review of actual maine07b03d9d404 confirms fwp_arr
uses uint64_t len plus V slots, with no spare32-bit header field. Natural-width
acceptance now explicitly includes owned primitives, destruction, display/
equality, JSON/binary decode, constants and callback/dynamic boundaries; it
preserves length/overflow behavior and requires compile-time hot-loop loads
plus explicit fallback/conversion contracts. No representation code changed.

Removed stale design claim that packed TLS focused remote checks remain pending: prepared source112 now has passing original allocation probes and actual ARM/Intel binary/layout evidence, while sequential production gates remain required. Deduplicated the library-cache prepared acceptance note without changing its pre-packing ten-free control or later packing evidence.

## Actual local gRPC allocator capacity

A new bounded diagnostic main is compiled from actual captured source112
8fe6765c9490987ae560113fe7d0ac0fe090ad96 address-fixture C, retaining all
original probe bytes and compiler arguments. It executes the real packed
g_tls_new and short-address g_conn_new at O1/O2 and reads Darwin malloc_size
for malloc-owned TLS storage, and the collector metadata slot for GC-owned
connections. malloc_size is never applied to a GC pointer. This does not rerun
or replace the original ownership tests or weaken their negative controls.

On Apple M4 Pro/macOS15.6.1(24G90)/Apple Clang17.0.0(1700.4.4.1), both
optimizations agree: TLS requested101 uses112 malloc-usable bytes; requested8311
uses8704. The actual short connection requests278 and occupies a320-byte GC
slot. An allocation of the original520-byte connection header size in the same
unchanged allocator occupies640 bytes. The old constructor is not executed;
this comparison measures its header-size allocation, excluding its truncation
semantics. runtime/fwp_rt_gc.c is byte-identical from prepared110 bf297ac299ea
through prepared112 b45e93a71d40. Observed addresses meet type alignment.

Guarded compile/execute/assembly capture passes0.60CPU/1.70elapsed. Actual
Mach-O headers, generated diagnostic C, source hashes, original flags, results
and disassembly are retained in /private/tmp/fwp-grpc-allocator-capacity-local
with proof.json. Compiler flags retain gnu11, ffp-contract=off, OpenSSL paths,
ssl/crypto, lm and pthread at O1/O2. Capacity excludes allocator metadata,
collector chunk reservation, resident memory and unrelated buffers; this is
local ARM evidence and does not establish Intel capacity, cache use or speed.

Source review of the prepacking constructor at prepared110 confirms six
allocation calls (one calloc header, four strdup strings and one malloc key);
this count is a source finding, not a newly executed legacy measurement. The
existing ten-to-five cache-free fixture result counts a broader workload and
must not be described as the constructor's allocation count.

## Archived primitive contract notes through queue18

These are exact prior notes, including superseded pending-merge statements.
Use the current inventory and handoff for status; measurements retain their
original workload, platform, flags and scope.

## Accepted phase2 ownership exit

Main is `3598a675b5bd9ad2e22ac17d42a27a89ea74fdeb` (PR #124). Frozen head `3aae99bfa705e26babc2cf251b0e583dfd95cf38` passes all six
jobs in CI38184549852 and roadmap_docs38184549850 before match-head squash
at 2026-10-12T00:52:11Z. Subject `Own resource and State lifetimes and preserve inferred effects` has 62 characters,
one line and no body/trailers/attribution. One parent `b4285fc177b3ae7afaf195e5ebd7115cc77b815c` and complete
tree `28ae0e5cea7fa5948683adb39a035ed40fb9b226` match the tested head. Raw signed payload:
fwp-pr124-signed-payload.txt. All11 docs were backed up before these acceptance
edits in /private/tmp/fwp-main-docs-remote-pre124. Local main remains `68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4`;
no local fast-forward or compiled check ran while free disk is below64GiB.

Queue33 and35–112 are accepted;34 is a verified duplicate. PR124 accepts resource
and network owners, compiler/cache/effect repairs, scoped AD and list/closure
lifetimes, typed State and14 fresh codec leaves, plus codec fixture-copy repair. Borrowed scoped inputs require
Dup; affine File rejection, type snapshots, actual WASI and all original nonlocal
exit/omission controls pass. Public Pipe and grad/vjp signatures remain unchanged.
Raw buffers still require mem.free; unknown reconstruction and retained contexts
keep tracing. Fake OpenCL tests do not establish GPU hardware support.

## Immutable evidence index

Every entry links to the complete immutable history. These archived headings
retain stable anchor names; old pending statuses and next actions are superseded.

### Superseded list evidence preparations, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#superseded-list-evidence-preparations-2026-10-11).

### Early deliveries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#early-deliveries).

### Done

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#done).

### Delivery history

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#delivery-history).

### Later

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#later).

### Historical session evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#historical-session-evidence).

### Session handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#session-handoff).

### Authorized workflow

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#authorized-workflow).

### Merged baseline and current work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#merged-baseline-and-current-work).

### Immediate continuation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#immediate-continuation).

### Current ownership evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#current-ownership-evidence).

### Prepared sequence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-sequence).

### Remaining acceptance work and next implementation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#remaining-acceptance-work-and-next-implementation).

### Local resource limits

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-resource-limits).

### Callback design constraints retained for review

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#callback-design-constraints-retained-for-review).

### Borrowed callback foundation preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#borrowed-callback-foundation-preparation).

### Synchronous map preparation in progress

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-map-preparation-in-progress).

### Filter preparation in progress

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#filter-preparation-in-progress).

### Fold design constraints retained for review

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fold-design-constraints-retained-for-review).

### Fold transfer preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fold-transfer-preparation).

### Zip callback work in progress

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#zip-callback-work-in-progress).

### Right-fold ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#right-fold-ownership-preparation).

### PR #75 macOS concurrent cache correction

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr-75-macos-concurrent-cache-correction).

### Prefix/suffix ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prefixsuffix-ownership-preparation).

### Ordinary list copy ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ordinary-list-copy-ownership-preparation).

### Optional list alias ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#optional-list-alias-ownership-preparation).

### Call effect inference repair preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#call-effect-inference-repair-preparation).

### Exact wide-count ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#exact-wide-count-ownership-preparation).

### List ordering ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#list-ordering-ownership-preparation).

### Sort-by callback ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#sort-by-callback-ownership-preparation).

### Scan and iterate ownership preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scan-and-iterate-ownership-preparation).

### Loop state ownership implementation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#loop-state-ownership-implementation).

### Structural list ownership prepared

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#structural-list-ownership-prepared).

### Generated list ownership prepared

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#generated-list-ownership-prepared).

### Typed array element ownership implemented

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#typed-array-element-ownership-implemented).

### Typed map/set element ownership implemented

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#typed-mapset-element-ownership-implemented).

### Prepared old-storage reclamation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-old-storage-reclamation).

### Prepared task/channel boundary contracts

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-taskchannel-boundary-contracts).

### Prepared coordinated runtime unwind

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-coordinated-runtime-unwind).

### Latest preparation: initial flattened loop ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#latest-preparation-initial-flattened-loop-ownership).

### Current retain-failure work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#current-retain-failure-work).

### Concrete aggregate context preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#concrete-aggregate-context-preparation).

### Boxed variant conversion preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#boxed-variant-conversion-preparation).

### Prepared record update ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-record-update-ownership).

### General record copy coverage

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#general-record-copy-coverage).

### Prepared boxed record field conversion

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-boxed-record-field-conversion).

### Prepared returned variant aliases

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-returned-variant-aliases).

### Prepared nominal match context

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-nominal-match-context).

### Prepared typed record projection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-typed-record-projection).

### Prepared counted CAF caches

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-counted-caf-caches).

### Prepared CAF evaluation during inlining

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-caf-evaluation-during-inlining).

### Prepared retained task thunks

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-retained-task-thunks).

### Prepared retained deadline callbacks

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-retained-deadline-callbacks).

### Prepared scoped callback ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-scoped-callback-ownership).

### Prepared counted task handles and results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-counted-task-handles-and-results).

### Prepared counted channels and queue elements

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-counted-channels-and-queue-elements).

### Prepared native library export result ownership (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-native-library-export-result-ownership-2026-10-08).

### Prepared native library input ownership (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-native-library-input-ownership-2026-10-08).

### Native library unload preparation (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#native-library-unload-preparation-2026-10-08).

### Native OpenCL lifetime preparation (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#native-opencl-lifetime-preparation-2026-10-08).

### Interpreter OpenCL failure ownership preparation (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#interpreter-opencl-failure-ownership-preparation-2026-10-08).

### Native TLS listener ownership preparation (2026-10-08)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#native-tls-listener-ownership-preparation-2026-10-08).

### Former ownership progress notes

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#former-ownership-progress-notes).

### Ownership and efficient native execution

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-and-efficient-native-execution).

### Stable language behavior

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#stable-language-behavior).

### Existing implementation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#existing-implementation).

### Next ownership change

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#next-ownership-change).

### Representation and numerics

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#representation-and-numerics).

### Evidence required

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#evidence-required).

### Remaining leaf and capture coverage

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#remaining-leaf-and-capture-coverage).

### Prepared leaf ownership implementation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-leaf-ownership-implementation).

### Prepared nested text result ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-nested-text-result-ownership).

### Compiled closure ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#compiled-closure-ownership).

### Bounded function capture cleanup

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#bounded-function-capture-cleanup).

### Concrete call argument temporaries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#concrete-call-argument-temporaries).

### Owned children of stack aggregates

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#owned-children-of-stack-aggregates).

### Session evidence through 2026-10-08: PR89 and resource preparations

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#session-evidence-through-2026-10-08-pr89-and-resource-preparations).

### Current actions

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#current-actions).

### Authorization and invariants

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#authorization-and-invariants).

### Merged support

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#merged-support).

### Next sequential PR

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#next-sequential-pr).

### Separate repaired preparation evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#separate-repaired-preparation-evidence).

### Latest preparation and outstanding audits

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#latest-preparation-and-outstanding-audits).

### Local operation and durable documentation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-operation-and-durable-documentation).

### Archived handoff and ownership notes through queue86

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-and-ownership-notes-through-queue86).

### Handoff snapshot

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#handoff-snapshot).

### Delivered and current PR

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#delivered-and-current-pr).

### Full evidence and actual repairs

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#full-evidence-and-actual-repairs).

### Preparation and next ownership work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#preparation-and-next-ownership-work).

### Local validation and persistence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-validation-and-persistence).

### Ownership snapshot

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-snapshot).

### Remaining ownership coverage

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#remaining-ownership-coverage).

### Counted leaf primitive families

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#counted-leaf-primitive-families).

### Fresh nested text results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fresh-nested-text-results).

### Borrowed synchronous callbacks and map results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#borrowed-synchronous-callbacks-and-map-results).

### Prepared work and acceptance limits

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-work-and-acceptance-limits).

### Original resource lifetimes

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#original-resource-lifetimes).

### Channel cycle preparation after queue87

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#channel-cycle-preparation-after-queue87).

### Focused source and cycle checks through queue88

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#focused-source-and-cycle-checks-through-queue88).

### Resource frame evidence integration

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#resource-frame-evidence-integration).

### Wide-count next-task preparation on PR91

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#wide-count-next-task-preparation-on-pr91).

### List-order following-task preparation on wide counts

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#list-order-following-task-preparation-on-wide-counts).

### Sort callback following-task preparation on list order

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#sort-callback-following-task-preparation-on-list-order).

### Archived preparation detail before compact queue14–16 table

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-preparation-detail-before-compact-queue1416-table).

### State sequence following-task preparation on sort callbacks

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#state-sequence-following-task-preparation-on-sort-callbacks).

### Loop following-task preparation on state sequences

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#loop-following-task-preparation-on-state-sequences).

### Native primitive ownership contracts

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#native-primitive-ownership-contracts).

### Complete runtime sharing

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#complete-runtime-sharing).

### Evidence and remaining work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#evidence-and-remaining-work).

### Selected String/Bytes boundaries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#selected-stringbytes-boundaries).

### Fresh copied text result trees

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fresh-copied-text-result-trees).

### Closure entries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#closure-entries).

### Borrowed dynamic callback foundation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#borrowed-dynamic-callback-foundation).

### Synchronous owned map results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-owned-map-results).

### Synchronous owned filter results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-owned-filter-results).

### Synchronous fold accumulator transfer

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-fold-accumulator-transfer).

### Synchronous zip-with ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-zip-with-ownership).

### Owned spans and right-fold transfer

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#owned-spans-and-right-fold-transfer).

### Prepared File and effect boundaries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-file-and-effect-boundaries).

### Optional list aliases and synchronous find

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#optional-list-aliases-and-synchronous-find).

### Exact reference counts above the byte range

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#exact-reference-counts-above-the-byte-range).

### Sorted and unique copied spines

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#sorted-and-unique-copied-spines).

### Synchronous sort-by key ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-sort-by-key-ownership).

### Owned scan and iterate state sequences

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#owned-scan-and-iterate-state-sequences).

### Owned normal and fused loop state

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#owned-normal-and-fused-loop-state).

### Original queue19 contract and evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#original-queue19-contract-and-evidence).

### Nested structural list copies

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#nested-structural-list-copies).

### Structural-list following-task preparation on loop ownership

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#structural-list-following-task-preparation-on-loop-ownership).

### Resource evidence HTTP ownership repair, 2026-10-08

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#resource-evidence-http-ownership-repair-2026-10-08).

### Raw generation oracle preparation, 2026-10-08

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#raw-generation-oracle-preparation-2026-10-08).

### Archived handoff through whole-match ownership repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-through-whole-match-ownership-repair).

### Execution contract

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#execution-contract).

### Delivered and sole open PR

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#delivered-and-sole-open-pr).

### Next sequential preparations

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#next-sequential-preparations).

### Separate full evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#separate-full-evidence).

### Ownership preparations and active work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-preparations-and-active-work).

### Local checks and durable state

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-checks-and-durable-state).

### Raw typed array oracle preparation, 2026-10-08

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#raw-typed-array-oracle-preparation-2026-10-08).

### Raw map/set oracle preparation, 2026-10-08

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#raw-mapset-oracle-preparation-2026-10-08).

### Old-value reclamation preparation, 2026-10-08

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#old-value-reclamation-preparation-2026-10-08).

### Wide counts delivered and resource repair verified, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#wide-counts-delivered-and-resource-repair-verified-2026-10-09).

### List order final PR rebase, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#list-order-final-pr-rebase-2026-10-09).

### Task-boundary preparation recovery, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#task-boundary-preparation-recovery-2026-10-09).

### Ordered copies delivered, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ordered-copies-delivered-2026-10-09).

### Sort callback final PR rebase, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#sort-callback-final-pr-rebase-2026-10-09).

### Runtime unwind raw-oracle preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#runtime-unwind-raw-oracle-preparation-2026-10-09).

### Compiler reuse-token raw-oracle preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#compiler-reuse-token-raw-oracle-preparation-2026-10-09).

### Archived preparation details through runtime-call cleanup

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-preparation-details-through-runtime-call-cleanup).

### Scan and iterate delivery, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scan-and-iterate-delivery-2026-10-09).

### TLS cache preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#tls-cache-preparation-refresh-2026-10-09).

### ALPN wire preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#alpn-wire-preparation-refresh-2026-10-09).

### Connection cancellation preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#connection-cancellation-preparation-refresh-2026-10-09).

### Unboxed worker preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#unboxed-worker-preparation-refresh-2026-10-09).

### TLS peer-subject preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#tls-peer-subject-preparation-refresh-2026-10-09).

### Borrowed ALPN root preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#borrowed-alpn-root-preparation-refresh-2026-10-09).

### Ownership probe and timer preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-probe-and-timer-preparation-refresh-2026-10-09).

### Nested loop boxing preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#nested-loop-boxing-preparation-refresh-2026-10-09).

### File construction preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#file-construction-preparation-refresh-2026-10-09).

### File write visibility preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#file-write-visibility-preparation-refresh-2026-10-09).

### File IO and binary-kind preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#file-io-and-binary-kind-preparation-refresh-2026-10-09).

### Original resource-frame preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#original-resource-frame-preparation-refresh-2026-10-09).

### File logical owner preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#file-logical-owner-preparation-refresh-2026-10-09).

### Mandatory original-frame release preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#mandatory-original-frame-release-preparation-refresh-2026-10-09).

### Loop delivery and queue streamlining, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#loop-delivery-and-queue-streamlining-2026-10-09).

### Archived queue instructions before PR96 delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-queue-instructions-before-pr96-delivery).

### Prepared roadmap queue

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-roadmap-queue).

### Mandatory frame release focused checks, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#mandatory-frame-release-focused-checks-2026-10-09).

### Structural list final delivery rebase, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#structural-list-final-delivery-rebase-2026-10-09).

### Scoped File runtime boundary preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scoped-file-runtime-boundary-preparation-refresh-2026-10-09).

### WASM logical count preparation refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#wasm-logical-count-preparation-refresh-2026-10-09).

### Disabled-free WASM disposal refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#disabled-free-wasm-disposal-refresh-2026-10-09).

### Original record field-holder refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#original-record-field-holder-refresh-2026-10-09).

### Inline File path layout refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#inline-file-path-layout-refresh-2026-10-09).

### Last-owner File storage refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#last-owner-file-storage-refresh-2026-10-09).

### Failed File constructor storage refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#failed-file-constructor-storage-refresh-2026-10-09).

### Tag-aware variant frame holder refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#tag-aware-variant-frame-holder-refresh-2026-10-09).

### Per-path variant frame binding refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#per-path-variant-frame-binding-refresh-2026-10-09).

### Archived preparation handoff through row83

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-preparation-handoff-through-row83).

### Whole-match nominal and stack ownership refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#whole-match-nominal-and-stack-ownership-refresh-2026-10-09).

### Per-path record frame binding refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#per-path-record-frame-binding-refresh-2026-10-09).

### Nested nominal source resource refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#nested-nominal-source-resource-refresh-2026-10-09).

### Explicit channel cycle evidence refresh, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#explicit-channel-cycle-evidence-refresh-2026-10-09).

### Borrowed HTTP/2 body owner audit, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#borrowed-http2-body-owner-audit-2026-10-09).

### HTTP/2 body negative-bound engine agreement, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#http2-body-negative-bound-engine-agreement-2026-10-09).

### HTTP/2 peer metadata unwind audit, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#http2-peer-metadata-unwind-audit-2026-10-09).

### Structure delivery and HTTP/2 peer cleanup preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#structure-delivery-and-http2-peer-cleanup-preparation-2026-10-09).

### Archived published preparation handoff through row91

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-published-preparation-handoff-through-row91).

### Served gRPC peer ownership audit, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#served-grpc-peer-ownership-audit-2026-10-09).

### Served gRPC final status ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#served-grpc-final-status-ownership-preparation-2026-10-09).

### Dequeued unary request ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#dequeued-unary-request-ownership-preparation-2026-10-09).

### Archived detailed peer/status preparation handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-detailed-peerstatus-preparation-handoff).

### Previous-main Linux CLI harness failure repair, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#previous-main-linux-cli-harness-failure-repair-2026-10-09).

### Streaming cell force ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#streaming-cell-force-ownership-preparation-2026-10-09).

### Streamed-error rendering scratch ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#streamed-error-rendering-scratch-ownership-preparation-2026-10-09).

### Encoded-message buffer ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#encoded-message-buffer-ownership-preparation-2026-10-09).

### Archived published receive/render preparation handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-published-receiverender-preparation-handoff).

### Detached sender request scratch ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#detached-sender-request-scratch-ownership-preparation-2026-10-09).

### Canonical encoder scratch ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#canonical-encoder-scratch-ownership-preparation-2026-10-09).

### Array preparation refresh after CLI failure repair, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#array-preparation-refresh-after-cli-failure-repair-2026-10-09).

### Served response encoding ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#served-response-encoding-ownership-preparation-2026-10-09).

### Synchronous client request ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#synchronous-client-request-ownership-preparation-2026-10-09).

### Client failure text ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#client-failure-text-ownership-preparation-2026-10-09).

### PR98 Linux collector workload repair, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr98-linux-collector-workload-repair-2026-10-09).

### Archived detailed preparation handoff through row102, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-detailed-preparation-handoff-through-row102-2026-10-09).

### Array preparation refresh after collector workload repair, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#array-preparation-refresh-after-collector-workload-repair-2026-10-09).

### Client receive cleanup preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#client-receive-cleanup-preparation-2026-10-09).

### Pending gRPC connection cleanup preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pending-grpc-connection-cleanup-preparation-2026-10-09).

### gRPC background startup ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#grpc-background-startup-ownership-preparation-2026-10-09).

### Dynamic gRPC context restoration preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#dynamic-grpc-context-restoration-preparation-2026-10-09).

### Scoped TLS context resource ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scoped-tls-context-resource-ownership-preparation-2026-10-09).

### PR98 merged after both harness repairs, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr98-merged-after-both-harness-repairs-2026-10-09).

### Archived PR98 pre-merge handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-pr98-pre-merge-handoff).

### Final array delivery rebase after PR98 squash, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#final-array-delivery-rebase-after-pr98-squash-2026-10-09).

### Final array delivery preparation after PR98

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#final-array-delivery-preparation-after-pr98).

### Response metadata capture ownership preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#response-metadata-capture-ownership-preparation-2026-10-09).

### Complete TLS pool identity preparation, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#complete-tls-pool-identity-preparation-2026-10-09).

### Map/set pre-delivery refresh and local resource refusal

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#mapset-pre-delivery-refresh-and-local-resource-refusal).

### Environment TLS cache teardown preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#environment-tls-cache-teardown-preparation).

### Archived preparation narrative before handoff consolidation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-preparation-narrative-before-handoff-consolidation).

### Packed immutable TLS option preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#packed-immutable-tls-option-preparation).

### Complete connection address storage preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#complete-connection-address-storage-preparation).

### 2026-10-09 PR99 merged and map evidence repaired

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#2026-10-09-pr99-merged-and-map-evidence-repaired).

### 2026-10-09 row23 pre-delivery refresh

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#2026-10-09-row23-pre-delivery-refresh).

### Archived preparation and combined evidence notes, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-preparation-and-combined-evidence-notes-2026-10-09).

### Repaired resource evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#repaired-resource-evidence).

### 2026-10-09 immutable tag identity audit repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#2026-10-09-immutable-tag-identity-audit-repair).

### Archived delivery evidence chronology, 2026-10-09

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-delivery-evidence-chronology-2026-10-09).

### 2026-10-09 map and selection scratch observer repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#2026-10-09-map-and-selection-scratch-observer-repair).

### PR100 map/set ownership delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr100-mapset-ownership-delivery).

### Fold preparation refresh after PR100

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fold-preparation-refresh-after-pr100).

### Loop and argument cleanup refreshes

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#loop-and-argument-cleanup-refreshes).

### Constructor preparation refresh

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#constructor-preparation-refresh).

### Worker result boxing refresh

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#worker-result-boxing-refresh).

### PR101 old counted storage delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr101-old-counted-storage-delivery).

### Local guard sampling repair preparation (2026-10-09)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-guard-sampling-repair-preparation-2026-10-09).

### Linux evidence fixture failures and focused repairs (2026-10-09)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#linux-evidence-fixture-failures-and-focused-repairs-2026-10-09).

### PR103 accepted and next guard delivery (2026-10-10 local time)

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr103-accepted-and-next-guard-delivery-2026-10-10-local-time).

### Row26 preparation after PR103

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#row26-preparation-after-pr103).

### Archived merged preparation evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-merged-preparation-evidence).

### Earlier runtime argument-preparation protection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#earlier-runtime-argument-preparation-protection).

### PR104 merged guard sampling repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr104-merged-guard-sampling-repair).

### Archived handoff detail after selection preparation refresh

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-detail-after-selection-preparation-refresh).

### Archived handoff before reuse-token merge

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-before-reuse-token-merge).

### Main and next delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#main-and-next-delivery).

### Archived focused preparation checks before call-liveness delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-focused-preparation-checks-before-call-liveness-delivery).

### Current guard repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#current-guard-repair).

### Active evidence repairs

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#active-evidence-repairs).

### Pre-runtime-delivery local validation record

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pre-runtime-delivery-local-validation-record).

### Pre-streamlining PR107 and repair handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pre-streamlining-pr107-and-repair-handoff).

### Pre-streamlining shared target validation record

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pre-streamlining-shared-target-validation-record).

### Accepted runtime application delivery PR107

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#accepted-runtime-application-delivery-pr107).

### Previous shared target before map delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#previous-shared-target-before-map-delivery).

### Refreshed typed holders after matched-result and frame-box repairs

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#refreshed-typed-holders-after-matched-result-and-frame-box-repairs).

### Earlier scoped evidence handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#earlier-scoped-evidence-handoff).

### Matched-result repair propagation through serving and client contexts

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#matched-result-repair-propagation-through-serving-and-client-contexts).

### Completed repair propagation and fresh gRPC evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#completed-repair-propagation-and-fresh-grpc-evidence).

### File and actual-WASI evidence after matched-result repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#file-and-actual-wasi-evidence-after-matched-result-repair).

### Prepared primitive metadata inventory

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-primitive-metadata-inventory).

### Archived delivery narrative from the plan

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-delivery-narrative-from-the-plan).

### Full repaired ownership platform evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#full-repaired-ownership-platform-evidence).

### Autodiff review findings for the later numeric phase

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#autodiff-review-findings-for-the-later-numeric-phase).

### Accepted map callback unwind delivery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#accepted-map-callback-unwind-delivery).

### Superseded PR107/108 live handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#superseded-pr107108-live-handoff).

### Final selection-unwind preparation after map acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#final-selection-unwind-preparation-after-map-acceptance).

### Independent zip preparation while PR109 tests

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#independent-zip-preparation-while-pr109-tests).

### Independent fold preparation and full-queue worker failure

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#independent-fold-preparation-and-full-queue-worker-failure).

### Worker-argument boxing regression and narrow repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#worker-argument-boxing-regression-and-narrow-repair).

### PR #109 selection unwind acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr-109-selection-unwind-acceptance).

### Zip unwind final squash preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#zip-unwind-final-squash-preparation).

### Intel HTTP2 strict omission fixture candidate

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#intel-http2-strict-omission-fixture-candidate).

### Superseded staged repair handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#superseded-staged-repair-handoff).

### Staged repairs and next independent work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#staged-repairs-and-next-independent-work).

### Actual recursive worker binary and ABI inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-recursive-worker-binary-and-abi-inspection).

### Actual typed frame-record binary and layout inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-typed-frame-record-binary-and-layout-inspection).

### Actual inline File path binary and layout inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-inline-file-path-binary-and-layout-inspection).

### Actual tag-aware variant frame binary and layout inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-tag-aware-variant-frame-binary-and-layout-inspection).

### Actual packed TLS-options binary and layout inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-packed-tls-options-binary-and-layout-inspection).

### Actual full connection-address binary and layout inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-full-connection-address-binary-and-layout-inspection).

### Archived handoff details after PR #114

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-details-after-pr-114).

### Fixture repair status

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#fixture-repair-status).

### Separate evidence and remaining audits

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#separate-evidence-and-remaining-audits).

### Effective primitive declaration review

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#effective-primitive-declaration-review).

### Conservative numeric parsing and remote cache review

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#conservative-numeric-parsing-and-remote-cache-review).

### Actual loop argument preparation binary inspection

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-loop-argument-preparation-binary-inspection).

### Effective primitive alias correction

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#effective-primitive-alias-correction).

### Cross-architecture gRPC binary evidence publication

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#cross-architecture-grpc-binary-evidence-publication).

### Passing ARM and Intel gRPC machine-code evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#passing-arm-and-intel-grpc-machine-code-evidence).

### Loop preparation runner evidence publication

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#loop-preparation-runner-evidence-publication).

### Archived handoff after PR #115

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-115).

### Passing loop preparation machine-code evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#passing-loop-preparation-machine-code-evidence).

### Retain overflow machine-code evidence preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#retain-overflow-machine-code-evidence-preparation).

### Actual retain overflow local binary validation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#actual-retain-overflow-local-binary-validation).

### Passing retain overflow machine-code evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#passing-retain-overflow-machine-code-evidence).

### Local disk-limit refusal during allocator evidence bookkeeping

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-disk-limit-refusal-during-allocator-evidence-bookkeeping).

### Archived handoff after PR #116

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-116).

### Constructor cleanup binary evidence preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#constructor-cleanup-binary-evidence-preparation).

### Documentation audit moved to constructor evidence runners

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#documentation-audit-moved-to-constructor-evidence-runners).

### Passing constructor cleanup machine-code and docs evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#passing-constructor-cleanup-machine-code-and-docs-evidence).

### Constructor evidence collection and fresh local audit after recovery

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#constructor-evidence-collection-and-fresh-local-audit-after-recovery).

### Archived handoff after PR #117

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-117).

### Boxed conversion machine-code evidence preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#boxed-conversion-machine-code-evidence-preparation).

### Obsolete accepted and duplicate preparation rows removed

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#obsolete-accepted-and-duplicate-preparation-rows-removed).

### Passing boxed conversion machine-code evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#passing-boxed-conversion-machine-code-evidence).

### Archived handoff after PR #118

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-118).

### Archived verbose handoff at PR118

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-verbose-handoff-at-pr118).

### Active repair and independent work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#active-repair-and-independent-work).

### Earlier argument-preparation repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#earlier-argument-preparation-repair).

### Remaining exit reviews

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#remaining-exit-reviews).

### Accepted guard and fixture controls

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#accepted-guard-and-fixture-controls).

### Local limits and durable docs

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-limits-and-durable-docs).

### Delivered primitive contracts removed from the prepared table

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#delivered-primitive-contracts-removed-from-the-prepared-table).

### Prepared refinements

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-refinements).

### Portable finite ownership inventory, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#portable-finite-ownership-inventory-2026-10-11).

### Record update binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#record-update-binary-evidence-preparation-2026-10-11).

### Record-update layout selector correction

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#record-update-layout-selector-correction).

### Autodiff token bounds source review, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#autodiff-token-bounds-source-review-2026-10-11).

### Sequential delivery recovery preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#sequential-delivery-recovery-preparation-2026-10-11).

### Archived handoff after PR #119

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-119).

### PR119 final acceptance and record-update rebase, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr119-final-acceptance-and-record-update-rebase-2026-10-11).

### Archived pre-publication instructions for queue42

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-pre-publication-instructions-for-queue42).

### Corrected record-update positive layouts accepted, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#corrected-record-update-positive-layouts-accepted-2026-10-11).

### Record conversion binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#record-conversion-binary-evidence-preparation-2026-10-11).

### Numeric fusion acceptance review, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#numeric-fusion-acceptance-review-2026-10-11).

### Record-conversion binary evidence accepted, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#record-conversion-binary-evidence-accepted-2026-10-11).

### Returned variant alias binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#returned-variant-alias-binary-evidence-preparation-2026-10-11).

### Returned variant alias binary evidence acceptance, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#returned-variant-alias-binary-evidence-acceptance-2026-10-11).

### Archived handoff after PR #120

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-120).

### Nominal match context binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#nominal-match-context-binary-evidence-preparation-2026-10-11).

### Archived accepted-evidence handoff detail after PR120

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-accepted-evidence-handoff-detail-after-pr120).

### Nominal match context binary evidence acceptance, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#nominal-match-context-binary-evidence-acceptance-2026-10-11).

### Field projection context binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#field-projection-context-binary-evidence-preparation-2026-10-11).

### Field projection context binary evidence acceptance, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#field-projection-context-binary-evidence-acceptance-2026-10-11).

### Cached value ownership binary evidence preparation, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#cached-value-ownership-binary-evidence-preparation-2026-10-11).

### External raw-memory finite review, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#external-raw-memory-finite-review-2026-10-11).

### Cached value ownership binary evidence acceptance, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#cached-value-ownership-binary-evidence-acceptance-2026-10-11).

### PR121 Intel devices failure and strict binary diagnostics, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr121-intel-devices-failure-and-strict-binary-diagnostics-2026-10-11).

### PR121 strict failure-evidence repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr121-strict-failure-evidence-repair).

### PR121 revised publication and macOS diagnostic results

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr121-revised-publication-and-macos-diagnostic-results).

### Queue48 unchanged-source binary evidence preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#queue48-unchanged-source-binary-evidence-preparation).

### FFI pointer-offset overflow reproduction and phase2 preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ffi-pointer-offset-overflow-reproduction-and-phase2-preparation).

### Archived handoff after PR #121

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-121).

### Larger ownership bundles authorized, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#larger-ownership-bundles-authorized-2026-10-11).

### Archived completed evidence before PR122 acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-completed-evidence-before-pr122-acceptance).

### Raw-memory contracts and pointer boundary evidence, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#raw-memory-contracts-and-pointer-boundary-evidence-2026-10-11).

### Expanded library/file/resource bundle54–73, 2026-10-11

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#expanded-libraryfileresource-bundle5473-2026-10-11).

### Corrected unused-CAF-argument layout evidence accepted

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#corrected-unused-caf-argument-layout-evidence-accepted).

### Archived handoff after PR #122

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-122).

### Disk reserve refusal and PR122 acceptance continuation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#disk-reserve-refusal-and-pr122-acceptance-continuation).

### Prepared ownership checks retained during handoff streamlining

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-ownership-checks-retained-during-handoff-streamlining).

### Superseded recovery audit handoff before cache lifetime repair

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#superseded-recovery-audit-handoff-before-cache-lifetime-repair).

### PR123 documentation repair before final acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr123-documentation-repair-before-final-acceptance).

### Runner preparation export replaces unsupported workflow publication

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#runner-preparation-export-replaces-unsupported-workflow-publication).

### Completed evidence removed from the live PR123 handoff

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#completed-evidence-removed-from-the-live-pr123-handoff).

### Archived handoff after PR #123

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-123).

### Resource bundle preparation before finalization

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#resource-bundle-preparation-before-finalization).

### Autodiff tape bug fixes prepared for the next bundle

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#autodiff-tape-bug-fixes-prepared-for-the-next-bundle).

### Scoped gradient ownership candidate

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scoped-gradient-ownership-candidate).

### List ownership and State root cleanup candidate

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#list-ownership-and-state-root-cleanup-candidate).

### Local resource incident and next preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#local-resource-incident-and-next-preparation).

### PR124 combined repair preflight chronology

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr124-combined-repair-preflight-chronology).

### Current verified bundle evidence

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#current-verified-bundle-evidence).

### Typed State work for the current bundle

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#typed-state-work-for-the-current-bundle).

### Historical list and State source observations

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#historical-list-and-state-source-observations).

### PR124 allocation and callback repairs before final integration

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr124-allocation-and-callback-repairs-before-final-integration).

### Scoped autodiff review before the final PR124 candidate

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#scoped-autodiff-review-before-the-final-pr124-candidate).

### Kernel and recovery preparation before device bounds

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#kernel-and-recovery-preparation-before-device-bounds).

### Archived handoff after PR #124

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#archived-handoff-after-pr-124).

### Remaining ownership deliveries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#remaining-ownership-deliveries).

### Finish phase2, then continue the plan

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#finish-phase2-then-continue-the-plan).

### PR124 ownership implementation notes before acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#pr124-ownership-implementation-notes-before-acceptance).

### Prepared ownership implementation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-ownership-implementation).

### Ownership preparation coverage before PR124 acceptance

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-preparation-coverage-before-pr124-acceptance).

### Prepared ownership work

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#prepared-ownership-work).

### Ownership classification notes before accepted PR124 streamlining

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#ownership-classification-notes-before-accepted-pr124-streamlining).

### Conservative reconstruction and external boundaries

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#conservative-reconstruction-and-external-boundaries).

### Recovery snapshot and complete-map repairs

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#recovery-snapshot-and-complete-map-repairs).

### Verified PR125 preparation

[Archived evidence](https://github.com/e6qu/fun-with-pipes/blob/b61cde67f467fc67d672b1d0efd3c0cf59a3acad/docs/roadmap-history.md#verified-pr125-preparation).

