# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff. The
[queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
contains detailed checks and superseded instructions. Root docs are authoritative;
prepared branch docs are historical snapshots.

## Execution contract

Finish the plan automatically, one coherent bundle production PR at a time. The
user requested larger related bundles to reduce testing cycle time. Preserve
all included regression/negative controls; run the full matrix once per final
bundle head. Keep one production PR open at a time. Publication,
repairs and squash merges are authorized across sessions. Fix failing checks;
CI gates merging while independent preparation continues. Preserve the language
semantics and phase order in PLAN. Require all six exact-head jobs and roadmap_docs:
`test`, `bench`, `macos (macos-15)`, `macos (macos-15-intel)`,
`macos_gc (macos-15)`, `macos_gc (macos-15-intel)`. Skipped, queued, cancelled,
superseded or earlier-head runs do not pass a gate. Regular macOS excludes only
the golden GC stress suite; dedicated GC jobs execute it.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Squash with an explicit
subject, empty body and exact-head match. Verify the raw resulting message,
one parent and complete-tree parity before updating main.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4` (PR #122). Accepted frozen head
`31d038c4ea78cbea81e1001f1662ef7bb771bbfa` passes all six jobs in CI38123585926 and
roadmap_docs38123585877 before match-head squash at 2026-10-11T09:15:55Z.
Subject `Own typed compiler values and task and channel lifetimes` has 56 characters, one line,
empty body and no trailers or attribution. One parent `0f32e7560398c048478c4186c63d90c32e7c1727`
and complete tree `ccb67ec38e9ee3adfa222dcd1979374da688a9d7` match the tested head. All11 live docs
were hashed in /private/tmp/fwp-main-docs-pre122 and restored byte-for-byte.
Protected main update0.05CPU/0.26elapsed and acceptance record0.00CPU/0.14elapsed
pass; docs audit44/106/59 passes0.73CPU/5.16elapsed. Actual-main docs38127751825
is queued. Duplicate production38127751789 has the identical tested tree and
was cancelled after strict gate/tree proof checks,0.15CPU/3.18elapsed.
Queue33 and35–53 are accepted; queue34 is a verified duplicate. Bundle44–53
adds direct typed variant alias transfer, nominal match/field cleanup context,
CAF cache/evaluation ownership, retained task captures, deadlines/scopes,
counted task handles and typed channel queues. Original regression and negative
controls remain unchanged, including GC/reuse and raw interpreter agreement.
Channel close preserves queued values; automatic unreachable-cycle reclamation
remains unproved. Phase2 is incomplete; phases3–6 are pending.

[PR123](https://github.com/e6qu/fun-with-pipes/pull/123) is the sole open
production PR, bundling library/OpenCL/TLS/file/resource items54–73 plus the
pointer and raw-memory string-copy repairs. Published head
b0ae00d5512df825271970cafcf569f52dbfc0cd, nativefd930e541db6, is on this actual
PR122 squash. All42 original commits and probes plus both new repairs remain;
accepted diagnostics inherit exactly. Eight focused tests and65 library units,
lint and format pass at identical native source hashes. Publication2.41CPU/
22.57elapsed and PR creation0.18CPU/4.35elapsed pass. Full CI38128387224 and
docs38128387231 remain pending. Intel macOS GC stress has started; the other
jobs are queued. Require all seven passing gates before squash. Latest remote
status: /private/tmp/fwp-roadmap-active-ci-status.json; refresh with the remote
administration helper /private/tmp/fwp-monitor-roadmap-ci.py.
Next concrete action: monitor/fix those gates, then squash with the recorded
one-line subject and empty body. Prepare74–112 on a GitHub runner while CI runs;
open its production PR after123 merges. Independent evidence does not replace
production gates. Phases2–6 remain incomplete.

Prepared acceptance helpers (not executed): /private/tmp/fwp-merge-pr123.py
requires every exact-head gate; /private/tmp/fwp-protect-main-after123.py checks
the raw squash message, parent/tree parity and protects all11 docs before FF;
/private/tmp/fwp-record-pr123-acceptance.py removes20 accepted live rows and
updates the next bundle. The acceptance update is a draft, not a passed check.
Run local updates and audits through the guard when resource limits permit;
move final bundle rebasing to GitHub if the reserve remains below64GiB.

## Evidence and preservation requirements

Completed independent evidence is archived in
[history](roadmap-history.md#archived-completed-evidence-before-pr122-acceptance).
Original tests ran once per architecture, with zero ignored; controls,
C/binaries/flags/disassembly and proof JSON remain retained. These runs do not
replace the final production gates or establish speed/collector-free support.

| Evidence | Passing CI | Frozen evidence head | Proof in /private/tmp |
|---|---|---|---|
| Queue44 variant alias | 38104532520 | ded20c6239f6 | fwp-variant-alias-layout-passing-proof.json |
| Queue45 nominal match | 38105588952 | 8d138284bdd2 | fwp-match-context-layout-passing-proof.json |
| Queue46 field projection | 38106022932 | 1494a3300d23 | fwp-field-context-layout-passing-proof.json |
| Queue47 CAF caches | 38106592858 | 1a873414e446 | fwp-caf-layout-passing-proof.json |
| Queue48 inlined CAF arguments | 38124620463 | 15c2f44d32ec | fwp-inline-caf-layout-passing-proof.json |
| Queue43 record conversion, accepted #121 | 38101505851 | 342d7d47a729 | fwp-record-conversion-layout-passing-proof.json |
| Prepared112 primitive inventory | 38099556010 | 669c19e7cb67 | fwp-primitive-inventory-passing-proof.json |
| Full prepared112 integration, seven gates | 38048222203 | 0f8c53199b2c | fwp-full-0f8c531-passing-proof.json |

Preserve inherited worker, HTTP2/x86 root and static-handler fixture repairs,
exact omission/allocation controls, raw interpreter comparisons and original
multi-commit repairs. Rows77–78 require actual mandatory WASI on Linux in both
free modes. OpenCL57–58 fake APIs do not establish hardware coverage. Recheck
the finite primitive inventory against actual merged source at phase2 exit.

PR123 branch: `ownership-library-resource-bundle`; worktree:
/private/tmp/fwp-library-resource-bundle-worktree. The final rebase preserves
every tested native byte. Publication journal:
/private/tmp/fwp-library-resource-bundle-publication.json.

## Remaining ownership deliveries

Use actual bases below, never immutable OLD parents. Preserve all11 root docs
when resolving conflicts. Remove a live row only after verified acceptance or
a verified duplicate, retaining its queue anchor and history. All listed
preparations need final squash rebases and all seven exact-head production gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
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

## Finish phase2, then continue the plan

A separate FFI boundary preparation, branch `ownership-ffi-pointer-arithmetic`,
head227f15356da8f9a5c7675eea9fda074a6be8857a on actual main120 passes all
three platform jobs in CI38123787995. Two original tests per platform execute,
zero ignored. Twelve retained sanitizer binaries have exact success0/overflow1
statuses; old signed-expression controls report signed integer overflow.
Collector0.29CPU/9.19elapsed verifies C/binary hashes and hardware/compiler
reports. Proof: /private/tmp/fwp-pointer-boundary-passing-proof.json; artifacts:
/private/tmp/fwp-pointer-boundary-227f153-artifacts. Earlier38109876885 failed
ARM exit assertion and Intel toolchain DNS provisioning. Explicit sanitizer
exit policy, distinct binaries and diagnostics preserve the strict control.
Include the repair in bundle54–73 with final actual-squash rebase and full
production gates. No separate pointer-only PR. ptr.at wraps unsigned native
pointer-width multiplication/addition; ordinary checked arithmetic is unchanged.
The tests cover84 independently specified address boundaries and12
ordinary numeric pointer types, raw/native O1/O2 agreement with GC/reuse, and an
old signed-expression UBSan control. No boundary address is dereferenced.
F16/128-bit, WebAssembly widths and raw-buffer lifetime acceptance remain separate.

One guarded baseline run reproduces the old raw-interpreter panic101 after
I8/U8 succeed; emitted C contains signed I16 arithmetic. Shared compiler SHA
4a04b1c4c0000627b845469d817672612a936db3c669bc5e9affb823398ebdb9
is recorded without inferring its source head. Evidence:
/private/tmp/fwp-pointer-boundary-baseline/report.json. Corrected fixture check
0.75CPU/1.44elapsed passes; preparation0.55/5.94s, format0.45/0.84s,
format check0.33/0.61s and publication repairs0.13/3.08s +0.31/6.57s pass.
Superseded preparation runs38109666010/38109740663 were cancelled, not passed.
Independent boundary support is verified on three64-bit native platforms;
merged acceptance and wider raw-memory coverage remain pending.
Publication journal: /private/tmp/fwp-pointer-arithmetic-publication.json.

After queue112 is delivered, recheck the finite [ownership exit gates](ownership.md#phase-2-exit-gates)
and [primitive contracts](primitive-ownership.md) against merged source. The
prepared112 audit resolves373 declarations into363 runtime symbols after40
aliases:134 explicit contracts,19 ordinary IR combinators,12 flat scalar
signatures and208 review declarations representing198 symbols. Missing metadata
alone is not a sharing bug. Preserve conservative fallbacks until concrete
typed ownership and teardown are proved.

Review borrowed metadata roots, reconstruction/partial failure, retained
callbacks/contexts and resource disposal. Channel close preserves queued values;
explicit drain breaks its counted cycle, while automatic unreachable-cycle
reclamation remains unproved. Scalar AD tape handles do not prove external
buffer lifetimes. Numeric lifetime findings and future regressions are in
[numerics](numerics.md). Complete phase2 before representation, numerics/AD,
performance and tracing-free work. Phases3–6 still require implementation and
measured acceptance; the prepared ownership queue is not the whole plan.

## Local resource incident and next preparation

The attempted future bundle preparation was refused before execution when free
disk fell below64GiB; observed available62.17GiB and project target101MiB.
No refused compiler/check/preparation ran outside the guard, and limits were
unchanged. Remote GitHub merge and Git metadata verification continued. Disk
subsequently returned above64GiB without project cleanup, enabling guarded
main update and final54–73 rebase. Disk again fell below reserve after PR123
creation; stop local workloads. At 09:49 UTC, available space is approximately
52.9 GiB. No local build, test or bundle preparation is authorized while the
guard refuses the workload. Read-only source review and remote administration
continue.
The current remote preparation drivercfcb70d16044915206c2e681a72618021ba0ea97,
branch ownership-roadmap-preparation, runs CI38130008122 (queued). It targets
original112 b45e93a71d40
FROM73 3dba256655a3 onto published123 candidateb0ae00d5512d. It prepares
all39 remaining rows74–112 as one resource/network bundle, preserving85
original commits and exact tested raw-memory changes. It publishes
ownership-resource-network-bundle as a preparation only, with both accepted
golden diagnostics and mandatory WASI retained. Runner full validation and final
actual123-squash rebase remain required. Driver workflow is outside production
ancestry; no extra production PR is open. The earlier20-item preparation
CI38129146591, head96f6b3d2c073, was verified cancelled before publishing its
replacement; cancellation is not a passing check. The cancellation request
initially remained queued, so publication waited for confirmed cancellation.
Expansion journal: /private/tmp/fwp-resource-network-expanded-runner-publication.json.
Its source112 already includes mandatory WASI test environment;
preserve that alongside inherited golden artifact diagnostics when rebasing.
Do not use the unchanged exact-inherited-ci assertion for that later bundle:
verify only the intentional WASI requirement in addition to accepted base CI.

## Local checks and durable recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local work
is serial, low priority and guarded: sampled aggregate RSS below1GiB, target
below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits and move
work to CI; never raise or bypass limits. The fun-refactor guard applies only to
that other repository.

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Last Rust checkout is /private/tmp/fwp-library-resource-bundle-worktree,
Current source ed442426ff6e0ce4e646913720c95c098596da02 passes focused
raw-memory/pointer/resource-frame tests,65 library units, lint and format.
Smaller candidate9664d0607d16 checks are scoped to that previous source;
clean removed68files131.2MiB,0.00CPU/0.14elapsed before the expanded rebuild.
The previous compiler/task package clean removed62 files/99.1MiB,
0.00CPU/0.13elapsed. Source/check hashes:
/private/tmp/fwp-library-raw-memory-focused-checks.json. Combined first run
passes both pointer tests but fails raw-memory fixture RC insertion; corrected
fixtures pass. History records subsequent fixture corrections and guard refusal.
Before switching Rust checkouts, use the absolute root guard
with cargo clean -p fwp in that last checkout, then rebuild requested targets.
Do not infer source identity from shared outputs. Refusals and prior metrics
remain in history; each new guard invocation samples current resources.

Protect all11 docs with a fresh hashed snapshot before each main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. Preserve other tracked
user changes too. Latest snapshot: /private/tmp/fwp-main-docs-pre122, restored
byte-for-byte. Actual bases, immutable preparation tags and retained revision
tags are the recovery record if temporary helpers disappear. The shared audit
checks all tracked links, whole commit messages, immutable ancestry and live
head/base consistency. Audit again after links, refs or subjects change.
