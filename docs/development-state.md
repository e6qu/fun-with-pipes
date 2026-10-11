# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff. The
[queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
contains detailed checks and superseded instructions. Root docs are authoritative;
prepared branch docs are historical snapshots.

## Execution contract

Finish the plan automatically, one focused production PR at a time. Publication,
repairs and squash merges are authorized across sessions. Fix failing checks;
CI gates merging while independent preparation continues. Preserve the language
semantics and phase order in PLAN. Require all six exact-head jobs and roadmap_docs:
`test`, `bench`, `macos (macos-15)`, `macos (macos-15-intel)`,
`macos_gc (macos-15)`, `macos_gc (macos-15-intel)`. Skipped, queued, cancelled,
superseded or earlier-head runs do not pass a gate. Regular macOS excludes only
the golden GC stress suite; dedicated GC jobs execute it.

Every entire commit message is one line, at most80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Squash with an explicit
subject, empty body and exact-head match. Verify the raw resulting message,
one parent and complete-tree parity before updating main.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `e07b03d9d4040ad458072c4aaf401a26c79f4fb9` (PR #118). Accepted frozen head
`d5959b7981d9553bbf8d1fdeb15a45b9b6cbf37f` passes all six jobs in CI38087199063 and
roadmap_docs38087199031. Observed squash at 2026-10-11T00:20:28Z has the
exact 74-character subject `Preserve nested constructor types for exceptional ownership cleanup (#118)`, one line,
empty body and no trailers or attribution. Raw commit has one parent
`571422b54647b5c95eb1bfe2d13bb3edf0176e0d` and complete tree `cb50c8e69950a2936c0f2e682b3da0edce5780a3`,
identical to the tested head. All11 live docs were hashed in
/private/tmp/fwp-main-docs-pre118 and restored byte-for-byte after fast-forward.
Queues35–40 are accepted in PRs113–118. Ownership temporaries now inherit
known monomorphic constructor/field/result context when expression types are
missing, so later-field failure releases nested children. Expression-inferred
types remain authoritative. Exact outer-only cleanup exit4 for record/variant,
aliases/scalar bits and raw interpreter/native agreement remain checked.
Phase2 remains incomplete; phases3–6 are pending.

Next production delivery is queue41 variant conversion FROM actual prepared40
5ebcb2d6b0e25b8d0ae49d8d6b634d42c90a984f onto this actual PR118 squash. Final
rebase0.10CPU/1.05elapsed preserves both original commits and every source/probe/
production-workflow byte at native78de90c921e33508119ebf09f5ab4197cdfa5f1e.
Three original native regressions17.81/35.79s, all18 RC units3.46/7.10s,
lint2.48/5.02s and format0.50/0.83s pass under the unchanged guard. Exact
original-box exit3 and remaining-caller exit7, alias/scalar controls, GC/reuse
modes and raw interpreter agreement remain intact. Copy all11 current docs,
audit, retain the old remote revision and publish with an exact lease, then
open the sole next production PR. After acceptance, deliver queue42 record
update FROM actual prepared41 cca935846750 onto queue41's actual squash.
Every final head needs all seven passing gates.

## Evidence and preservation requirements

Queue41 binary evidence0063d4f5f5c71ab7057b6693d8c59576271ca171 passes both
ARM/Intel jobs in CI38087378359 on original sourcecca935846750. Each unchanged
test executes once, zero ignored; exact omission exits3/7 and O1/O2 GC/reuse,
alias/scalar and raw interpreter controls remain mandatory. Six real Mach-O
binaries per platform show V8/align8, variant32/align8, payload8, cleanup24 and
two active8-byte owner contexts. C, layouts, flags, symbols and disassembly are
retained in GitHub and /private/tmp/fwp-conversion-layout-0063d4f-artifacts.
Proof: /private/tmp/fwp-conversion-layout-passing-proof.json. This accepts the
prepared source evidence, not a future production head. All completed rebase,
publication and collection journals must not rerun.

Full prepared source112 integration0f8c53199b2c / CI38048222203 passes all seven
gates, including actual mandatory WASI disposal/count controls with no skip.
It is not sequential acceptance or collector-free support. Other binary evidence
and diagnostic details are in ownership/history. Preserve inherited worker,
HTTP2/x86 root and static-handler fixture repairs, exact omission/allocation
controls, raw interpreter comparisons and every original multi-commit repair.
Rows77–78 require actual WASI on Linux in both free modes; native checks do not
replace them. OpenCL57–58 fake APIs are not hardware coverage.

## Remaining ownership deliveries

Use actual bases below, never immutable OLD parents. Preserve all11 root docs
when resolving conflicts. Remove a live row only after verified acceptance or
a verified duplicate, retaining its queue anchor and history. All listed
preparations need final squash rebases and all seven exact-head production gates.

| Row / branch | Current head | Actual current base | Focused tests (CPU / elapsed) |
|---|---|---|---|
| 41 ownership-variant-conversion | 78de90c921e3 | e07b03d9d404 | Final actual-squash source preserves both original commits; three original variant-conversion/constructor-type/worker-boxing regressions17.81CPU/35.79elapsed, all18 RC units3.46/7.10s, lint2.48/5.02s and format0.50/0.83s pass; original source/probes unchanged including exact original-box/caller omission exits3/7, aliases/scalar bits and raw interpreter/native agreement; ARM/Intel actual binary evidence passes; exact-head full gates required |
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

## Finish phase2, then continue the plan

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

Last Rust checkout is /private/tmp/fwp-variant-conversion-worktree, native
78de90c921e33508119ebf09f5ab4197cdfa5f1e on actual PR118 squash. All three native regressions17.81CPU/35.79elapsed, all18 RC units3.46/7.10s,
lint2.48/5.02s and format0.50/0.83s pass. Before switching Rust checkouts, use the absolute root guard
with cargo clean -p fwp in that last checkout, then rebuild requested targets.
Do not infer source identity from shared outputs. Refusals and prior metrics
remain in history; each new guard invocation samples current resources.

Protect all11 docs with a fresh hashed snapshot before each main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. Preserve other tracked
user changes too. Latest snapshot: /private/tmp/fwp-main-docs-pre118, restored
byte-for-byte. Actual bases, immutable preparation tags and retained revision
tags are the recovery record if temporary helpers disappear. The shared audit
checks all tracked links, whole commit messages, immutable ancestry and live
head/base consistency. Audit again after links, refs or subjects change.
