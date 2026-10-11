# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the live handoff;
[queue](roadmap-queue.md) preserves immutable anchors and
[history](roadmap-history.md) preserves detailed checks and superseded status.
Prepared branch docs are historical snapshots; current root docs are authoritative.

## Execution contract

Complete the roadmap automatically, one focused PR at a time. Publication,
PR creation, repairs and squash merges are authorized across sessions. Failing
checks are repair tasks; CI gates merging while independent work continues.
Keep tacit, curried, data-last pipes, immutable values, tracked effects, checked
arithmetic, affine resources and evaluation/trap order. Use FWP_NO_OPT=1
explicitly for raw interpreter oracles. Prepared work is not merged support.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Require all six passing
jobs at the current exact PR head: test, bench, macos (macos-15), macos
(macos-15-intel), macos_gc (macos-15), macos_gc (macos-15-intel). Regular macOS
excludes only golden_programs_under_gc_stress; dedicated GC jobs execute it.
Queued/skipped/cancelled/superseded/old runs are never passing gates. Squash:

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `571422b54647b5c95eb1bfe2d13bb3edf0176e0d` (PR #117). Accepted frozen head
`3aeb9655d492253a9d4b01a604f1821a4edd9702` passes all six jobs in CI38081959849 and
roadmap_docs38081959890. Match-head squash at 2026-10-10T21:14:54Z has the
exact 59-character subject `Release partial retains and caller owners on count overflow`, one line,
empty body and no trailers or attribution. Raw commit has one parent
`85198cc78ee7d0cb8af5d6ec30b1c42771c91748` and complete tree `5fa63ec44f134c96443adad74c6cbd1ff7c11656`,
identical to the tested head. All11 live docs were hashed in
/private/tmp/fwp-main-docs-pre117 and restored byte-for-byte after fast-forward.
Merge0.22CPU/6.85elapsed, fetch0.05/1.22s, protection0.05/0.13s and
acceptance audit0.56/4.03s pass (44 link sets,106 immutable pairs/tags,75 live
heads/bases). Duplicate main CI38086882594 was cancelled only after complete-tree
proof (0.04CPU/1.24elapsed); actual main docs38086882597 passes at the squash.
Queues35–39 are accepted in PRs113–117. Multi-field typed retains now release
completed extras on count overflow, with existing caller owners protected and
unfinished extras excluded from the liveness checkpoint. Exact omission exits3/7,
alias/scalar controls and raw interpreter/native agreement remain checked.
Phase2 remains incomplete; phases3–6 are pending.

Next production delivery is queue40 constructor type context. Final rebase
passes0.05CPU/1.10elapsed FROM actual prepared39 d98205af88df onto this actual
PR117 squash; native snapshota51b9cf7ca699ea97524c38cc6631c6add9d21eb preserves
both original commits and every source/probe/production-workflow byte. The
original docs-only commit became empty during conflict resolution and was
preserved explicitly after parity proof. Bounded clean in the previous queue39
checkout removed89.0MiB (0.05CPU/0.36elapsed). Fresh four constructor-type,
constructor-unwind, retain-overflow and worker-preparation regressions pass
20.27CPU/40.70elapsed; all17 RC units3.60/7.51s, lint2.51/5.10s and format
0.44/0.83s pass under the unchanged guard. Exact outer-only cleanup exit4 for
record/variant, aliases/scalar bits, GC/reuse modes and raw interpreter/native
O1/O2 agreement remain intact. Copy all11 authoritative docs, audit, retain the
old remote revision, publish with an exact lease and open the sole next PR.
After acceptance, deliver queue41 variant conversion FROM actual prepared40
5ebcb2d6b0e2 onto queue40's eventual actual squash. Every final head requires
all seven passing gates; independent binary evidence stays outside production.

Independent constructor binary capture is published at
`38a013a224acfcf105c6aa77f941b0043c831e26` on unchanged source40
5ebcb2d6b0e25b8d0ae49d8d6b634d42c90a984f. CI38082971623 passes both ARM/Intel jobs at the exact evidence head;
capture/inspection/workflow files and the11-doc handoff snapshot differ. A
remote-only metadata commit adds full-history checkout and the shared docs audit
to both runner jobs after a local disk-limit refusal. Original e83b2a0b09cd
remains reachable; its superseded queued run38082494104 is cancelled. It preserves the original
later-field error test, record/variant negative exit4, alias/scalar controls,
GC/reuse checks and raw interpreter/native O1/O2 agreement. New tooling regex
and C newline validation passes0.00CPU/0.14elapsed after an escaping correction;
publication0.08/2.51s passes. Both platforms execute the original test once with zero failed/ignored tests,
inspect four actual O1/O2 positive/control binaries and pass the uploaded snapshot
audit (44 link sets,106 immutable pairs/tags,76 live heads/bases). Compiled sizes
agree: V8/align8, object header8/payload offset8, cleanup24 and each of the nine
recorded typed Inner-owner contexts8/align8. These definitions do not sum to a
frame size. Original exit4 controls for both record/variant paths remain intact.
C, flags, hardware/compiler metadata, symbols and disassembly are retained in
GitHub artifacts and /private/tmp/fwp-constructor-layout-38a013a-artifacts.
Passing-proof verification/download passes0.22CPU/7.26elapsed, with original
source/probe/production-workflow parity and four Mach-O binaries per platform.
The isolated evidence checkout is fast-forwarded to38a013a224ac (0.00/0.13s). No final
constructor production support is claimed; actual-squash/full gates remain. The
refused snapshot audit passes on CI without bypassing the guard. After disk
recovery to80.47GiB available, a fresh audit of the subsequently updated live
docs passes0.49CPU/3.65elapsed (44/106/76). Limits remain unchanged.

Independent loop binary evidence passes both jobs in CI38076425571 at
`d9d1a02b5c8e7c52e15d0c8077a3b3b8071b71b8` on unchanged source38
4289528c436b. Only capture/inspection/workflow files differ. Both architectures
execute the original test without skips and capture four actual O1/O2 positive/control binaries.
Tooling validation passes1.66CPU/3.46elapsed; publication0.13/3.18s.
Compiled local sizes: V8/align8, state32, owner8/16, cleanup24 bytes.
Passing-proof/artifact download passes0.19CPU/6.72elapsed. Instrumented
positive loop frames are496 bytes ARM and456 Intel (saved registers included;
Intel return address excluded); these are not production stack/speed guarantees.
This evidence does not accept the final production head.

Queue34 is skipped as a verified docs-only duplicate of preparation code/probes
delivered in #107. Its immutable anchor, ancestry and later coverage are preserved.
Keep one production PR open; prepare/fix later tasks while CI runs.

## Active repair and independent work

Effects diagnostic7bfc46903ce8ed35c3cd7049c633423a8b100113 passes all three
platforms in CI38048799853: Linux and ARM/Intel macOS. Strict original program
stdout/stderr/exit and normal/fresh compilation trials pass; separate sanitizer
logs preserve the known ARM no-return stack-instrumentation limitation. Actual
injected heap-use-after-free is rejected independently on each platform even
when program output/exit still match. Compiler/runtime/production tests unchanged.
This does not establish complete ASan stack coverage or fix the old signal.

Preparations40–112 are refreshed and published on their actual predecessors.
Original source/probes, multi-commit repairs and immutable anchors are preserved;
focused controls, lint, format and all audits pass. Exact heads, bases and metrics
are in the table; detailed checks and retained revisions are in history. Completed
publication journals must not rerun. Final squash rebases/full gates still remain.

Actual ARM64 binary/layout evidence for44,65,79,80,83,111 and112 records the current8-byte
slot baseline and tested aggregate/File layouts. The six-I64 worker value is48 bytes/aligned8 and returns through
caller storage with192/208-byte frames; no speed or constant-stack claim.
ALPN67 passes actual major tracing and exact omitted-fence exit1. TLS59 streams
executes without skip and agrees exactly with the interpreter. OpenCL57–58 uses
fake APIs, not hardware evidence. Closing channels preserves queued values;
automatic unreachable-cycle reclamation remains unproved. Frame-record79 avoids
one16-byte parent box; inline File80 reduces the header24→16 and allocations2→1.
Exact binary/layout details and limits are in ownership/history.

Preparation 112 is published at b45e93a71d400ae3872142c70b29aa8128793e07 on actual
111 5a01572cb2c6. Both original feature/format commits and all source/probes survive.
Four original address/packed/identity/connection tests (11.32 CPU / 25.93 elapsed s),
actual ARM64 binary/layout inspection (0.22 / 0.99 s), lint (2.64 / 5.34 s), format
(0.44 / 0.85 s), three audits and retained publication (1.79 / 18.61 s) pass.
Actual new/legacy headers are 272/520 bytes, aligned 8, with short request 278;
long loopback/pool reuse and truncation exit 1 remain checked. Final sequential
gates still remain. All completed publication/rebase journals must not rerun.
Independent ARM/Intel binary evidence is published at
`5a56aa1ebbc2b609ebd51c675d44e454ddedba8d` on source112 b45e93a71d40,
branch ownership-evidence-grpc-layout. CI38075612557 passes both ARM/Intel jobs at the exact evidence head.
Both original tests execute once per platform with zero failed/ignored tests. Original packed-options/address tests,
compiler and runtime bytes are unchanged. Only a delegating capture wrapper,
compiled-layout/disassembly inspector and evidence-only workflow were added.
Compiled layouts agree on both architectures: TLS64/align8, connection272
versus legacy520/align8; requests101/8311 and278 are unchanged.
Real Mach-O C/binaries/symbols/disassembly and hardware/flags are retained;
fault/observer frames are not production stack or performance guarantees.
Local tooling validation passes1.83CPU/4.05elapsed; publication0.13/3.34s
and passing-proof/artifact download0.35/9.06s. This evidence does not
accept rewritten production heads or create another production PR. A bounded
actual local allocator check passes0.60CPU/1.70elapsed: TLS101/8311 requested
bytes occupy112/8704 malloc-usable bytes; short connection278 occupies320 GC
slot bytes, versus640 for the old520-byte header-size allocation in the same
allocator. This is ARM local capacity evidence, excluding metadata, reservation
and cache/speed claims; full details and limits are in history.

The finite phase2 review records prepared source112 policies after PR115 acceptance. The corrected effective audit resolves40 explicit foreign aliases:373 declarations
map to363 distinct runtime symbols, with category counts134/19/12/208 unchanged
(the208 review declarations represent198 symbols).
Missing metadata alone is not a sharing gap.
Numeric parsing borrows input but returns shared Option payloads; remote force
memoizes results, and scoped TLS C owners do not count fwp callback graphs.
These are source reviews, not new runtime checks or reclamation acceptance.
Preserve conservative boundaries, cycle policy, original resource semantics and
phase order. Recheck the finite exit inventory against merged source after the
ownership queue is delivered. PR117 is accepted; current delivery is queue40 on its actual squash.
Queue39 retain overflow is accepted in PR117; native5c663ef544f0 and original source d98205af88df remain reachable. 
Independent ARM/Intel machine-code evidence passes both jobs in CI38077436743 at
b0260c9d3aa72401dae338860e34c93600ec8dd1 on unchanged source39. Only
capture/inspection/workflow files differ. The inspector tracks active cleanup
scopes, excluding popped entry-tick scopes. Earlier6b1713dd5310 is retained
remotely; superseded diagnostic CI38077259408 was cancelled, not accepted.
The unchanged original test now passes locally with all six real positive/control
binaries captured (10.63CPU/21.45elapsed). Corrected active-scope inspection and
compiled layout driver pass0.35/0.93s: V8/align8, variant32/payload8, pair16,
partial owner16, cleanup24, wide entry24/count offset8. Exact negative exits3/7
and raw interpreter/native agreement remain intact. Artifact download and passing-proof
verification pass0.18CPU/7.08elapsed; each platform executes the original test
once with no skips and captures six actual O1/O2 positive/control binaries.
Both runner layouts match the local sizes above; hardware, compiler, flags, C,
symbols and disassembly are retained. Final actual-squash focused checks and all seven production gates pass for PR117.
This adds no compiler/runtime change and does not accept a production head.


Full prepared ownership evidence `0f8c53199b2cb2ab1ebf54e4323a9b2efe064656` / CI38048222203 passes
all six production jobs plus docs on exact source112 `0da68ea8cdb18b3d7a5ba4a2cb923cb16fe643d5`.
Compiler/runtime/tests/scripts/production workflows match that source byte-for-byte;
only the evidence workflow and three docs differ. Linux job114201941833 executes
the mandatory actual WASI count/File-child disposal and disabled-free controls,
with FWP_REQUIRE_WASM_RESOURCE_COUNTS=1; all pass without a skip. Both regular
macOS architectures and both GC stress jobs pass the repaired worker/HTTP2 probes.
Saved exact-head gate proof and Linux log are recorded in history. This validates
the prepared source, not merged support, phase2 completion or collector-free
execution. Every sequential PR still requires its own final rebase and full gates.
Original failed38016929326/3a97905ca980 remains retained and archived.

Inherited worker and HTTP/2 repairs remain unchanged in refreshed preparations.
Complete compatible counted record-worker calls transfer locally; partial/dynamic
calls still box. The strict HTTP/2 body-root fixture passed GCC/Clang Linux and
ARM/Intel macOS, including omitted-fence exit 1. Original negative controls,
immutable anchors and multi-commit repairs must survive every final rebase.
Detailed candidates, failed runs and completed propagations are in history;
completed journals must not rerun.

## Next sequential preparations

Current bases differ from immutable OLD parents; never replace OLD anchors.
All listed source oracles explicitly use FWP_NO_OPT=1. Published preparations
still need their final squash rebases and six exact-head full gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 33 ownership-loop-unwind | ac24ea45cbe0 | 837096b9a5dc | Final actual-squash rebase preserves both native implementations and all source/probes/workflows; two original tests11.39CPU/22.82elapsed, lint2.57/5.19s and format0.44/0.83s pass; exact-head full PR gates required |
| 34 ownership-argument-preparation | 49705971b287 | 0ec280e18416 | Exact source/tests/scripts/workflow parity with current33; docs only; skip implementation PR after33 acceptance; original anchors and later coverage preserved |
| 40 ownership-constructor-types | a51b9cf7ca69 | 571422b54647 | Final actual-squash source preserves both original commits; four original constructor-type/constructor-unwind/retain/worker regressions20.27CPU/40.70elapsed, all17 RC units3.60/7.51s, lint2.51/5.10s and format0.44/0.83s pass; original source/probes unchanged including exact outer-only exit4 for record/variant, aliases/scalar bits and raw interpreter/native agreement; actual ARM/Intel binary evidence passes; exact-head full gates required |
| 41 ownership-variant-conversion | cca935846750 | 5ebcb2d6b0e2 | Three original native tests17.38CPU/34.92elapsed and exact conversion unit3.48/7.20s, lint2.48/4.96s and format0.44/0.82s pass; original source/probes unchanged; final actual-squash/full gates required |
| 42 ownership-record-update | cd2c8fa4251a | cca935846750 | Both original commits preserved; two native tests16.05CPU/32.33elapsed and exact update unit3.62/7.57s, lint2.80/5.59s and format0.44/0.86s pass; original source/probes unchanged; final actual-squash/full gates required |
| 43 ownership-record-conversion | 6b809877a1ac | cd2c8fa4251a | Both original conversion/checkpoint repair commits preserved; seven native tests34.28CPU/68.76elapsed and all20 ownership units3.61/7.63s, lint2.53/5.21s and format0.44/0.84s pass; original source/probes unchanged; final actual-squash/full gates required |
| 44 ownership-variant-alias | b094ffbe7e46 | 6b809877a1ac | Two original tests9.66CPU/19.51elapsed, lint2.55/5.17s and format0.35/0.62s pass; exact positive/control binaries and ARM64 layout/disassembly retained; original source/probes unchanged; final actual-squash/full gates required |
| 45 ownership-match-context | 2b7dc81c7d1f | b094ffbe7e46 | Two original tests9.14CPU/18.85elapsed, lint2.49/5.03s and format0.44/0.82s pass; original source/probes unchanged; final actual-squash/full gates required |
| 46 ownership-field-context | 6255a8f54f54 | 2b7dc81c7d1f | Two original tests9.56CPU/19.54elapsed, lint2.59/5.13s and format0.44/0.82s pass; all original source/probes unchanged; final actual-squash/full gates required |
| 47 ownership-caf-cache | 7e1c164a0e81 | 6255a8f54f54 | Three original native tests11.60CPU/25.24elapsed and all21 ownership units3.48/7.37s, lint2.50/4.92s and format0.38/0.71s pass; all original source/probes unchanged; final actual-squash/full gates required |
| 48 ownership-inline-caf | 36fb4e1de52e | 7e1c164a0e81 | Two original unused-argument evaluation/release tests12.99CPU/26.95elapsed, lint2.57/5.15s and format0.38/0.71s pass; all original source/probes unchanged; final actual-squash/full gates required |
| 49 ownership-task-thunks | 215e0edec0f1 | 36fb4e1de52e | Both original retained-capture and failed-spawn controls11.38CPU/23.18elapsed, lint2.63/5.26s and format0.43/0.81s pass; all original source/probes unchanged; final actual-squash/full gates required |
| 50 ownership-task-within | 5cfbbf10087a | 215e0edec0f1 | Three original deadline/retained-thunk controls5.34CPU/10.77elapsed, exact contract inventory3.62/7.53s, lint2.44/4.88s and format0.44/0.83s pass; original source/probes unchanged; final actual-squash/full gates required |
| 51 ownership-task-scope | f36bacf80bfc | 5cfbbf10087a | Four original scope/deadline/retained-thunk controls15.75CPU/31.78elapsed, exact contract inventory3.45/7.06s lint2.48/4.97s and format0.44/0.82s pass; original source/probes unchanged; final actual-squash/full gates required |
| 52 ownership-task-handles | df26a860c99f | f36bacf80bfc | Five original task-handle/scope/deadline/retained-thunk controls20.97CPU/42.72elapsed, all21 RC units3.49/7.14s, exact contract inventory0.00/0.13s, lint2.45/5.02s and format0.45/0.84s pass; original source/probes unchanged; final actual-squash/full gates required |
| 53 ownership-channel-queues | b304e91f628c | df26a860c99f | Five original channel/task-alias/task-handle controls19.72CPU/39.59elapsed, all21 RC units3.59/7.54s, exact contract inventory0.00/0.13s, lint2.49/4.99s and format0.44/0.83s pass; original source/probes unchanged; final actual-squash/full gates required |
| 54 ownership-library-results | 46afd27c986c | b304e91f628c | Original C library result control7.96CPU/17.73elapsed, lint2.47/4.88s and format0.43/0.82s pass; original source/probes unchanged, including all four reclamation/string/guard/evaluation controls; final actual-squash/full gates required |
| 55 ownership-library-inputs | 96ee4fd963e3 | 46afd27c986c | Three original C library input/result controls9.78CPU/22.08elapsed, lint2.46/4.98s and format0.44/0.82s pass; original source/probes unchanged, including input rollback/transfer omissions and missing Bytes-length diagnostic; final actual-squash/full gates required |
| 56 ownership-library-unload | 6c367aa9a921 | 96ee4fd963e3 | Four original unload/input/result controls12.41CPU/31.49elapsed, lint2.50/5.12s and format0.44/0.82s pass; original source/probes unchanged, including actual loader/static-exit behavior and all six teardown omissions; final actual-squash/full gates required |
| 57 ownership-opencl-lifetime | 3dd39a69a430 | 6c367aa9a921 | Both original fake-OpenCL/library-unload controls10.35CPU/30.64elapsed, lint2.50/5.00s and format0.44/0.82s pass; original source/probes unchanged; fake API does not verify GPU hardware; final actual-squash/full gates required |
| 58 ownership-interpreter-opencl | 4119be1cdaf9 | 3dd39a69a430 | Both original fake-OpenCL/library-unload controls14.15CPU/35.43elapsed, lint2.41/4.87s and format0.45/0.84s pass; interpreter/native failure outputs agree; original source/probes unchanged; no GPU hardware claim; final actual-squash/full gates required |
| 59 ownership-tls-listeners | f5e2a298537d | 4119be1cdaf9 | Original listener control8.98CPU/20.75elapsed and actual TLS streams engine agreement7.58/18.01s pass without skip; lint2.63/5.31s and format0.45/0.84s pass; original source/probes unchanged, including all six omissions; final actual-squash/full gates required |
| 60 ownership-library-resources | 3eb64f54869f | f5e2a298537d | Three original resource/listener/unload controls12.71CPU/32.58elapsed, lint2.54/5.13s and format0.45/0.84s pass; original source/probes unchanged, including six resource/shutdown omissions and host handle survival; final actual-squash/full gates required |
| 61 ownership-grpc-server-cleanup | ca75ca461682 | 3eb64f54869f | Three original gRPC/listener/resource controls13.67CPU/30.41elapsed, lint2.61/5.23s and format0.46/0.86s pass; original source/probes unchanged, including scheduler cancellation and guard/fd/context omissions; final actual-squash/full gates required |
| 62 ownership-tls-cache-failures | 0b51abc49371 | ca75ca461682 | Three original TLS-cache/resource/gRPC controls11.72CPU/27.33elapsed, lint2.44/4.93s and format0.45/0.86s pass; original source/probes unchanged, including all five partial-owner/cache-publication controls; final actual-squash/full gates required |
| 63 ownership-tls-wire-preparation | 2c2c562401ab | 0b51abc49371 | Three original wire/cache/listener controls10.61CPU/25.68elapsed, lint2.53/5.13s and format0.45/0.85s pass; original source/probes unchanged; measured 13-byte ALPN buffer without GC scratch and all original failure/length controls preserved; final actual-squash/full gates required |
| 64 ownership-connect-cancellation | d7641a1ab055 | 2c2c562401ab | Three original connect/wire/cache controls10.02CPU/23.52elapsed, lint2.57/5.19s and format0.44/0.82s pass; original source/probes unchanged, including all four resolver/descriptor/handshake omissions; final actual-squash/full gates required |
| 65 ownership-unboxed-worker-locals | e217ad8ce0d9 | d7641a1ab055 | Both original worker/repair commits preserved; 12 original native controls40.51CPU/81.23elapsed, all21 RC units3.62/7.48s, lint2.50/5.14s and format0.44/0.82s pass; original source/probes unchanged; exact ARM64 worker binaries/layout/disassembly retained; final actual-squash/full gates required |
| 66 ownership-tls-peer-subject | 7250692d5758 | e217ad8ce0d9 | Three original subject/cache/listener controls10.61CPU/26.65elapsed, lint2.45/5.01s and format0.43/0.82s pass; original source/probes unchanged, including certificate/BIO/buffer/allocation omissions; final actual-squash/full gates required |
| 67 ownership-tls-alpn-roots | 6d80e63524c2 | 7250692d5758 | Three original ALPN-root/subject/listener controls9.86CPU/23.27elapsed, lint2.49/4.99s and format0.44/0.82s pass; original source/probes unchanged, including actual major collection and exact omitted-fence exit1; final actual-squash/full gates required |
| 68 ownership-ci-probe-repairs | c0cdb26eb99b | 6d80e63524c2 | Original timer regression10.62CPU/22.32elapsed, lint2.66/5.30s and format0.44/0.83s pass; original source/probes unchanged; raw interpreter agrees across O1/O2, three preemption slices, both reuse modes and delayed overtaking; final actual-squash/full gates required |
| 69 ownership-nested-loop-boxing | 7a68a54d2660 | c0cdb26eb99b | All10 original nested-loop/loop-unwind/worker/caller tests22.68CPU/46.10elapsed, all21 RC units3.54/7.24s, lint2.45/4.83s and format0.45/0.86s pass; original source/probes unchanged, including all three exact omitted-scope exit2 controls; final actual-squash/full gates required |
| 70 ownership-file-construction | ab3a93780dc3 | 7a68a54d2660 | All four original construction/unwind tests10.29CPU/21.66elapsed, lint2.43/4.82s and format0.44/0.85s pass; original source/probes unchanged, including exact omitted-scope exit2 and stale-finalizer exit3; raw interpreter/native File behavior agrees; final actual-squash/full gates required |
| 71 ownership-file-write-visibility | 702cd9b0a69a | ab3a93780dc3 | All six original write/construction/unwind tests12.54CPU/25.17elapsed, lint2.44/4.91s and format0.45/0.85s pass; original source/probes unchanged, including exact omitted-flush exit3; raw interpreter/native immediate write bytes agree; final actual-squash/full gates required |
| 72 ownership-file-io-errors | eee4807a3954 | 702cd9b0a69a | All nine original File I/O/byte-text/write/construction/unwind tests21.27CPU/42.63elapsed, lint2.44/4.90s and format0.44/0.84s pass; source/probes unchanged, including exact buffer/stream omission exit5 and omitted write-error exit8; raw interpreter/native stdout/stderr/exit agree; final actual-squash/full gates required |
| 73 ownership-resource-frames | 3dba256655a3 | eee4807a3954 | Both original implementation/fusion repair commits preserved; all11 frame/File/unwind/loop tests30.28CPU/60.68elapsed, three resource units3.79/7.76s, all21 RC units0.02/0.32s, lint2.51/5.11s and format0.44/0.84s pass; original source/probes unchanged; final actual-squash/full gates required |
| 74 ownership-file-runtime-owners | 8d5cb3c4e3e4 | 3dba256655a3 | All nine File-owner/I/O/frame/unwind tests24.61CPU/49.55elapsed, lint2.62/5.40s and format0.44/0.82s pass; original source/probes unchanged, including exact owner/alias/text omission exits6/7/10 with GC on/off and no-free comparison; storage retains compatibility lifetime; final actual-squash/full gates required |
| 75 ownership-file-discard | 423a7ddcc760 | 8d5cb3c4e3e4 | All10 discard/frame/runtime/caller tests37.88CPU/75.92elapsed, all23 RC units3.94/8.12s, three resource units0.00/0.13s, exact inventory0.00/0.13s, lint2.49/5.12s and format0.45/0.83s pass; original source/probes unchanged, including low-descriptor GC/reuse/free-off runs and exact omitted frame exit1; final actual-squash/full gates required |
| 76 ownership-file-runtime-boundaries | 603bb0b914db | 423a7ddcc760 | All10 scoped-result/discard/runtime/frame/task-handle/unwind tests45.48CPU/92.82elapsed, exact inventory4.45/9.15s, lint2.60/5.33s and format0.45/0.86s pass; original source/probes unchanged, including exact omitted result-owner exit101 and wrong-free exit29; raw interpreter/native File results agree; final actual-squash/full gates required |
| 77 ownership-wasm-resource-counts | f4a26004d5a8 | 603bb0b914db | Original native bump control8.26CPU/17.53elapsed, lint2.64/5.25s and format0.44/0.83s pass; original source/probes/mandatory WASI workflow unchanged, including exact count-disabled exit4; native checks are not actual WASI proof; final actual-squash/full and mandatory actual WASI gates required |
| 78 ownership-wasm-count-disposal | 13c77dbb7b82 | f4a26004d5a8 | Native disposal8.79CPU/18.00elapsed, original bump1.01/2.19s, two scoped File/task tests17.02/34.70s, lint3.00/6.03s and format0.45/0.87s pass; original source/probes/workflows unchanged, including exact omitted aggregate/runtime disposal exits5/9; physical bump storage remains allocated; final actual-squash/full and mandatory actual WASI gates required |
| 79 ownership-resource-frame-fields | 2f842d5d266f | 13c77dbb7b82 | Original frame-field binary capture11.03CPU/22.98elapsed, eight frame/caller tests24.39/48.85s, all23 RC units3.95/8.30s, lint2.73/5.52s and format0.44/0.84s pass; source/probes unchanged, including zero/one parent boxes and exact omitted cleanup exit2; actual ARM64 binaries/layout/disassembly retained; final actual-squash/full gates required |
| 80 ownership-file-inline-path | 010e622f064e | 2f842d5d266f | Both original binary-capture tests10.16CPU/20.43elapsed, eight File constructor/I/O/runtime/unwind tests26.13/53.21s, lint2.95/5.96s and format0.55/1.09s pass; original source/probes unchanged; actual ARM64 headers/layouts/disassembly and one-vs-two allocation counters preserved; final actual-squash/full gates required |
| 81 ownership-file-storage-disposal | 6e5063786651 | 010e622f064e | All nine storage/inline-path/runtime/construction/scoped/unwind tests30.46CPU/63.43elapsed, lint2.61/5.44s and format0.42/0.77s pass; original source/probes unchanged, including exact missing finalizer-removal/storage exits4/7, tracing-off reuse and unrelated live Files; shared/no-free lifetimes preserved; final actual-squash/full gates required |
| 82 ownership-file-construction-disposal | ecfd9a28c39e | 6e5063786651 | All nine constructor/storage/library-resource/scoped/unwind tests29.08CPU/63.78elapsed, lint2.70/5.69s and format0.50/0.96s pass; original source/probes unchanged, including hard-exit102 and exact premature growth/omitted disposal exits3/5; unrelated registry entries and rollback preserved; final actual-squash/full gates required |
| 83 ownership-resource-frame-variants | 7b7e45b20230 | ecfd9a28c39e | Original variant control10.41CPU/22.82elapsed, nine frame/caller tests24.67/49.60s, all23 RC units3.77/7.98s, lint2.43/4.99s, format0.45/0.84s and binary inspection0.22/1.11s pass; both original feature/repair commits and source/probes unchanged, including zero/one parent boxes and exact omitted cleanup exit2; actual ARM64 layout/disassembly recorded; final actual-squash/full gates required |
| 84 ownership-resource-frame-binding-kinds | e2a2baa977fa | 7b7e45b20230 | Ten original variant/frame/caller tests35.20CPU/70.70elapsed, all23 RC units3.67/7.54s, lint2.40/4.89s and format0.44/0.84s pass; original source/probes unchanged, including both binding paths, close exactly once, zero/one parent boxes and exact omitted cleanup exit2; final actual-squash/full gates required |
| 85 ownership-match-scrutinee-types | ebe69e13a935 | e2a2baa977fa | All13 original nominal/stack/variant/frame/caller tests39.97CPU/80.61elapsed, all23 RC units3.80/7.81s, lint2.45/5.02s and format0.51/0.83s pass; both original feature/stack-child repair commits and source/probes unchanged, including child-retain omission and strict File/box controls; final actual-squash/full gates required |
| 86 ownership-resource-record-binding-kinds | a0de231a4c0c | ebe69e13a935 | All13 original record/variant/nominal/stack/frame/caller tests41.43CPU/83.19elapsed, all23 RC units3.90/8.04s, lint2.89/5.90s and format0.45/0.86s pass; original source/probes unchanged, including both record paths, close exactly once and strict original box/cleanup controls; final actual-squash/full gates required |
| 87 ownership-nominal-source-context | 5a4ef15301c8 | a0de231a4c0c | Original source nominal-match test13.04CPU/26.20elapsed, lint2.43/4.94s and format0.43/0.83s pass; source/probes and compiler/runtime unchanged, including 64 File discards under descriptor limit32 and raw interpreter agreement for optimized/unoptimized O1/O2 GC/reuse/free/poison modes; final actual-squash/full gates required |
| 88 ownership-channel-cycle-lifetimes | 3db25573057b | 5a4ef15301c8 | Both original cycle/queue tests12.82CPU/25.69elapsed, lint2.40/4.89s and format0.49/0.96s pass; source/probes and compiler/runtime unchanged; close preserves queued values and explicit drain releases counted cycles across O1/O2 GC/poison modes, without claiming automatic cycle reclamation; final actual-squash/full gates required |
| 89 ownership-http2-body-roots | 5bc4f862bd5a | 3db25573057b | Original HTTP2 actual-major/root/payload/finalizer test7.08CPU/15.04elapsed, lint2.50/4.96s and format0.45/0.86s pass; all three original root/GCC/x86-Clang repair commits and source/probes unchanged, including exact omitted-fence exit1; accepted four-way fixture evidence retained, final actual-squash/full gates required |
| 90 fix-http2-body-bounds | fabe0ac7b24a | 5bc4f862bd5a | Corrected exact grpc::web bounds/error-order comparison executes one test and passes0.45CPU/1.94elapsed; strict HTTP2 root test7.17/15.39s, lint2.41/4.77s and format0.45/0.87s pass; original source/probes unchanged including exact omitted-fence exit1; earlier zero-test filter explicitly unverified/resolved; final actual-squash/full gates required |
| 91 ownership-http2-peer-cleanup | 5029a447bcec | fabe0ac7b24a | All three original peer/TLS/body-root tests8.42CPU/19.26elapsed, lint2.33/4.70s and format0.45/0.85s pass without skips; original source/probes unchanged including actual OpenSSL subject handshakes, strict omitted cleanup exit1 and TLS fault controls; final actual-squash/full gates required |
| 92 ownership-grpc-peer-completion | 26545f1b279b | 5029a447bcec | All four original completion/server/task-handle/peer tests17.42CPU/36.92elapsed, lint2.37/4.94s and format0.44/0.85s pass; original source/probes unchanged, preserving joined children, detached senders, cancellation and omitted-finalizer controls; selected cleanup verified without claiming tracing-free support; final actual-squash/full gates required |
| 93 ownership-grpc-status-cleanup | 9ad102d5a16f | 26545f1b279b | All four original status/completion/server/task tests20.89CPU/42.76elapsed, lint2.43/4.94s and format0.45/0.85s pass; original source/probes unchanged including both omitted-release exit2 controls, status-copy hard exit102/exact stderr and GC on/off/poison modes; final actual-squash/full gates required |
| 94 ownership-grpc-receive-cleanup | ec0fd11c6b26 | 9ad102d5a16f | All four original receive/status/completion/body-root tests15.65CPU/32.13elapsed, lint2.43/4.90s and format0.44/0.84s pass; source/probes unchanged including all three omitted-release exit1 controls, exact message bytes/status text and cancelled-wait cleanup across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 95 ownership-grpc-force-cleanup | 91ab62452636 | ec0fd11c6b26 | All four original force/receive/status/completion tests16.95CPU/34.13elapsed, lint2.40/4.89s and format0.44/0.85s pass; source/probes unchanged including three omitted-release exit1 controls, decoder/copy traps, typed error/text transfers and O1/O2 GC/poison modes; final actual-squash/full gates required |
| 96 ownership-grpc-render-cleanup | b4087dc07beb | 91ab62452636 | All four original rendering/force/receive/status tests15.08CPU/31.06elapsed, lint2.45/5.06s and format0.42/0.83s pass; source/probes unchanged including exact omitted cleanup exit1, original render/final service-error trap strings and O1/O2 GC/poison modes; final actual-squash/full gates required |
| 97 ownership-grpc-send-cleanup | 0203804096d8 | b4087dc07beb | All four original send/force/receive/status tests15.07CPU/30.73elapsed, lint2.47/5.14s and format0.46/0.84s pass; source/probes unchanged including exact omitted cleanup exit1, plain/gzip frame bytes, partial/zero-window cancellation and resumed flow control across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 98 ownership-grpc-request-encoding | 9c2c91fa8e21 | 0203804096d8 | All four original request/send/force/peer tests14.14CPU/29.05elapsed, lint2.48/4.95s and format0.51/0.95s pass; source/probes unchanged including exact omitted cleanup exit1, request/wire release counts, encode trap/reset text and suspended-send cancellation across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 99 ownership-grpc-canonical-encoding | 58bf72dbf3df | 9c2c91fa8e21 | All four original canonical/request/send/force tests4.14CPU/10.05elapsed lint2.53/5.21s and format0.40/0.74s pass; source/probes unchanged including exact omitted cleanup exit1, canonical bytes/tag offsets and trap text across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 100 ownership-grpc-response-encoding | 3b13964722ba | 58bf72dbf3df | All four original response/canonical/request/send tests12.11CPU/25.13elapsed, lint2.43/4.95s and format0.43/0.83s pass; source/probes unchanged including both exact omitted cleanup exit1 controls, unary/stream/error bytes and trap/cancellation release counts across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 101 ownership-grpc-client-requests | a584b59ec896 | 3b13964722ba | All four original client-request/response/request/send tests12.36CPU/25.32elapsed, lint2.45/4.94s and format0.45/0.85s pass; source/probes unchanged including exact omitted cleanup exit1, request/wire release counts, exact client encode/missing response text and suspended cancellation across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 102 ownership-grpc-client-failure-text | 4e6dbbddf888 | a584b59ec896 | All four original failure-text/client-request/force/receive tests13.37CPU/28.29elapsed, lint2.34/4.93s and format0.45/0.86s pass; both original feature/longjmp repair commits and all source/probes unchanged including exact omitted cleanup exit1, raw trap/GrpcError text and once-only release across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 103 ownership-grpc-client-receive | 09b5e3e70117 | 4e6dbbddf888 | All four original client-receive/failure-text/client-request/force tests14.38CPU/28.87elapsed, lint2.42/4.95s and format0.45/0.87s pass; source/probes unchanged including all three exact omitted cleanup exit1 controls, retry/error/decode/channel cancellation and exact trap text across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 104 ownership-grpc-connect-cleanup | 518e5cfaca02 | 09b5e3e70117 | All four original connection/client-receive/client-request/TLS listener tests15.12CPU/33.91elapsed, lint2.46/4.93s and format0.44/0.84s pass without skip; source/probes unchanged including omitted descriptor exit1 and SSL exit3, actual lookup/socket/handshake cancellation and ownership transfer across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 105 ownership-grpc-connect-startup | 4802e1dfb8a5 | 518e5cfaca02 | All four original startup/connection/peer-completion/task-handle tests20.62CPU/42.55elapsed, lint2.40/4.93s and format0.45/0.85s pass; source/probes unchanged including both omitted reference/startup exit1 controls, static marker exit8 and failed task-spawn teardown across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 106 ownership-grpc-context-restore | 2308b7c1db43 | 4802e1dfb8a5 | All four original context/startup/peer/task-handle tests20.84CPU/41.74elapsed, lint2.53/5.15s and format0.45/0.87s pass; source/probes unchanged including exact omitted restoration exit1 and nested return/typed-error/trap/cancellation restoration across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 107 ownership-grpc-context-resources | a2b3b132f094 | 2308b7c1db43 | All four original context-resource/restoration/startup/task-handle tests19.18CPU/40.38elapsed, lint2.48/5.17s and format0.44/0.84s pass; source/probes unchanged including all omitted TLS/task/scope owner exit1 controls, escaped tasks, spawn rollback and plain task-only generation across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 108 ownership-grpc-capture-resources | ef437370ca74 | a2b3b132f094 | All four original capture/context-resource/restoration/task-handle tests15.96CPU/34.26elapsed, lint2.42/4.88s and format0.44/0.86s pass; source/probes unchanged including all three omitted owner exit1 controls, atomic overflow rollback, inherited captures and plain task-only generation across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 109 fix-grpc-tls-pool-identity | c9d841ee5a9d | ef437370ca74 | All four original native identity/capture/context-resource/connection tests13.37CPU/30.03elapsed, exact interpreter pool-key unit5.33/11.12s (one executed), lint2.35/4.76s and format0.45/0.85s pass; source/probes unchanged including old collision exit1, all fields/long/separator options, copied keys and pool reuse across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 110 ownership-grpc-environment-cache | bf297ac299ea | c9d841ee5a9d | All four original environment-cache/identity/capture/context-resource tests13.41CPU/29.53elapsed, lint2.56/5.22s and format0.44/0.82s pass; source/probes unchanged including omitted cache cleanup exit1, read-once inputs, blocked-task/finalizer order and repeated teardown across O1/O2 GC/poison modes; final actual-squash/full gates required |
| 111 ownership-grpc-packed-options | 5a01572cb2c6 | bf297ac299ea | All four original packed/cache/identity/capture tests12.58CPU/26.76elapsed, actual ARM64 binary/layout inspection0.20/0.82s, lint2.59/5.25s and format0.44/0.83s pass; both original feature/format commits and source/probes unchanged including one allocation101/8311 bytes, alignment8/header64, copy/last-owner/failure controls and cache releases10-to-5; final actual-squash/full gates required |
| 112 ownership-grpc-connection-addresses | b45e93a71d40 | 5a01572cb2c6 | All four original address/packed/identity/connection tests11.32CPU/25.93elapsed, actual ARM64 binary/layout inspection0.22/0.99s, lint2.64/5.34s and format0.44/0.85s pass; both original feature/format commits and source/probes unchanged including truncation exit1, long loopback/pool reuse, copied addresses and actual272/520-byte headers aligned8 with short request278; final actual-squash/full gates required |

Prepared focused evidence, detailed commands and earlier source-parity proofs
remain in history. The Main and next delivery section supplies the sole live
next action. Every production PR requires six exact-head full gates and the
documentation audit.

Use actual bases above for final rebases, never OLD anchors or rewritten
predecessor heads. Preserve all 11 root docs for conflict resolution and
inherited CLI/GC harness fixes. The table records actual bases; historical
evidence bases never override them.
Rows77–78 require real WASI on Linux in both free modes; native bump checks
supply no WASI acceptance. Row 20 boxed128-bit payloads remain shared. Network
context wrappers retain tracing compatibility; no complete ARC claim. Channel
close preserves queued values; explicit drain breaks its counted cycle, while
automatic unreachable-cycle reclamation remains unproved. Frame-record79 avoids
one16-byte parent box; inline File80 reduces the header24→16 and allocations2→1.
Exact binary/layout details and limits are in ownership/history.

## Earlier argument-preparation repair

Row 28 now includes row 34's capture-preparation correction: supplied arguments
stay owned until capture duplication succeeds, and partial duplicated captures
have registered cleanup. The unchanged negative control catches its omission.
The live preparation table gives current heads and checks;
previous revisions and propagation results are in history.
Row 28 passed full acceptance in PR #107. Skip the duplicate implementation PR at
row 34 while preserving its immutable anchor and regression coverage. Current
row 34 differs from row 33 only in docs. No general exceptional-ownership claim.

## Remaining exit reviews

The complete prepared ownership run and strict diagnostic controls above preserve
current evidence. Older scoped runs and fixture repairs are in
[history](roadmap-history.md#archived-handoff-details-after-pr-114). They do not
accept rewritten production heads. Keep evidence workflows outside production
ancestry, preserve original omission/allocation assertions, and retain both
row 85 whole-value/stack-binder repair commits during sequential delivery.

The numerics page now keeps incomplete tensor timings in history instead of
duplicating them or inferring kernel speed; its source review is referenced to
current prepared112 with verified unchanged numeric source bytes.
Later numeric-phase review findings are in numerics.md: native backward mixed-tape
cleanup, grad failure/cancellation before backward and 32767-generation wrap
need concrete regressions. These are source-review findings; no new numeric
implementation or full-lifetime guarantee is claimed. Keep phase order unchanged.

Canonical C decode scratch already frees on normal success/error paths;
reconstructed decoded aggregates remain shared. Audit typed reconstruction,
partial construction, retained runtime contexts and automatic unreachable-cycle
reclamation against the finite phase 2 exit criteria in ownership.md. Channel
close preserves queued values; explicit drain alone proves its counted cycle
can be broken. Preserve raw interpreter comparisons and original pipe semantics.

## Accepted guard and fixture controls

The guard sampling repair is merged in PR #104, with all exact-head platform gates.
It suspends workloads during target-size sampling and preserves every resource
limit. Three deterministic integration checks cover suspension/resumption,
sampler errors and the original target-size limit. The stronger handoff audit
merged in PR #105 verifies recorded live heads and actual source-base ancestry.
Commands and current limits are below; old diagnostics are archived in history.

Preserve HTTP2 fixture acceptance8f6846a/38046812141 on Linux GCC/Clang and
macOS ARM/Intel Clang. The x86 fixture isolates construction, reserves the actual
frame pointer, selects its already-completed copy path and clears stale saved
registers/stack at the copy boundary. It never clobbers RBP/SP. ARM keeps its
original fixture. Actual collection, exact omitted-owner exit1, copied payload
and finalizer checks remain mandatory. The tested source89 fixture excludes its
optional diagnostic export; rejected revisions and original GCC-only evidence
are historical, not current instructions.

Preserve client controls using static handler/TypeInfo fixture objects. Exact
descriptor identity, code14 and transport-failure text remain checked. Accepted
evidencee4a5c1cab0b01d5b6dd9f7bc7a1859185a7f69e0 passesCI37989574765 with ARM
focused checks. Runtime behavior and original assertions are unchanged. Both
fixture corrections propagate through 90–112; subsequent argument/loop repairs
require refreshed evidence and final exact-head full gates.

## Local limits and durable docs

Full builds/tests, benchmarks and large regeneration run on GitHub. Focused
local work is serial and low priority: sampled aggregate RSS below 1 GiB,
target below 2 GiB, free disk at least 64 GiB, deadline 180 seconds. Stop at
limits and move work to CI; never raise or bypass them. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard applies to the other repository. The shared target was
last checked in /private/tmp/fwp-constructor-types-worktree (queue40):
actual-squash native snapshota51b9cf7ca69 passes four regressions20.27CPU/
40.70elapsed, all17 RC units3.60/7.51s, lint2.51/5.10s and format0.44/0.83s.
Bounded package clean in previous queue39 removed89.0MiB (0.05CPU/0.36elapsed).
An optional allocator-artifact metadata enrichment was not executed because the
guard reported less than64GiB free. No limits were changed and no check was
bypassed. After subsequent disk recovery, fresh guarded evidence collection and
live-docs auditing pass as recorded above. Latest read-only sample is84240648KiB
available (80.34GiB) and target91356KiB; future guard sampling still governs. Do not retry the refused
optional enrichment; its hardware/compiler metadata is already retained in the
original binary evidence. Required focused checks still use the guard; move any
refused workload to CI.
Every guard samples current limits. Before switching Rust
checkouts, use the root absolute guard with bounded cargo clean -p fwp there,
then rebuild the requested target. Never infer source identity from a shared
target directory. Full gates run on GitHub. Temporary helpers may disappear;
actual bases and retained remote tags are the durable recovery record.

The preparation table gives current focused results; earlier package checks,
refusals and superseded revisions are archived in history. Every workload
samples current limits; historical observations never authorize bypassing the
guard. Full-size raw tail evidence stays on GitHub because it exceeds local
RSS. No local full gate was run.

The stronger shared audit is merged in PR #105: live heads must match the queue,
and their recorded actual bases must be ancestors of those heads. It also
checks all tracked Markdown link sets, immutable tags and whole commit messages.
Isolated stale-head and stale-base controls fail as expected; corrected controls
pass. Run the shared checker through the root guard:

```sh
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Fetch full history, immutable tags and retained PR heads on a fresh clone.
The roadmap_docs workflow checks the actual PR head. Audit again after changes
to links, refs or commit subjects. Merged preparation rows are archived and removed from
the live preparation table; their queue anchors and accepted heads stay fixed.

Preserve all 11 authoritative docs before fast-forward/rebase conflict resolution:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. The numerics page
keeps phase 2 exit gates ahead of representation work and links historical
incomplete timings to the archive. Preserve any other modified tracked files too.
Latest 11-doc snapshot is /private/tmp/fwp-main-docs-pre117 with sha256.json;
all were restored byte-for-byte after updating main. Refresh before the next
main update. Keep live status concise; archive chronology and superseded handoffs in
history. Windows, new deployment interfaces and a new backend remain deferred.

