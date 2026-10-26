# Current work

**Next:** read the focused GCC diagnosis `40390897932`, fix the Linux service
fixture's actual failure, then publish it with the Windows header-order and CI
setup-timeout repairs. Do not restart the full matrix for diagnosis alone.

## Delivery and evidence

- Worktree: `/private/tmp/fwp-delete-tracing`; branch `delete-tracing-collector`.
- [PR #217](https://github.com/e6qu/fun-with-pipes/pull/217) is open.
- Published repair: `4e6261326a9baea367afa7d5a6cdb277b4535a52`.
- [Production 40356438626](https://github.com/e6qu/fun-with-pipes/actions/runs/40356438626):
  Linux ARM64, Intel regular macOS and both ownership macOS jobs pass. Linux AMD64
  fails only `service_value_ownership` (exit 247 at O1); both Windows jobs fail only
  `http2_body_roots` (system headers precede the Windows API contract).
- Bench job `121690063677` never reached benchmarks: `apt-get update` stopped
  making progress on `azure.archive.ubuntu.com` at 16:38 UTC and remained there
  until cancellation at 19:38 UTC. Normal cancellation finished; a subsequent
  force-cancel request returned 409 because the run was already complete.
  Completed job results and artifacts remain available. Regular macOS ARM64 was
  already cancelled with no assigned runner, step list or downloadable log; it
  still requires a fresh passing job.
- [Analysis 40356471366](https://github.com/e6qu/fun-with-pipes/actions/runs/40356471366)
  passes both hosts, 192 ordinary library tests and both budget tests. Limits and
  proof counts are unchanged; [measurements](measurements/ownership-analysis.md)
  record the timings. This does not replace production acceptance.
- Focused [GCC diagnosis 40390897932](https://github.com/e6qu/fun-with-pipes/actions/runs/40390897932)
  is queued on temporary branch `ci-service-value-diagnosis`, source
  `094bab810aa20828ee040d96e07df78cd74c0cbd`. It uses the failing head's published
  Linux compiler and compares original, labeled-exit and printed-counter fixtures,
  without a Rust rebuild or
  another PR. Diagnostic scripts are temporary, not production dependencies.
- Verified base: #216 squash `f5621cb46828273f7ce8edf92be4062ccec0f17c`, identical
  tree to tested `1dd5fcaed7792b5505283b1037a9c22d788a3be5`. Nine production jobs
  `40274667944`, docs `40273010537` and analysis jobs `40273030485` passed.

### Current repair and failure coverage

| Failure | Repair/status |
|---|---|
| Windows body-copy fixture includes a system header before the runtime | Insert declarations after the runtime's `V` declaration; preserve the Windows API contract and use an explicit `.exe` path. Local edit; native verification pending. |
| Linux AMD64 service-value fixture returns ambiguous status 247 | Focused production-GCC diagnosis pending; preserve every cleanup and alias assertion. |
| Benchmark setup waits three hours on Ubuntu mirror | Ten-minute package-step deadlines, explicit network/lock limits and noninteractive installation; benchmark job bounded at 90 minutes. Same package limits apply to production Linux setup. No skipped dependency checks or alternate toolchain. |

**GC removal remains unverified.** Integrated Rust/compiler, generated-library,
GCC, Windows and WASI checks must pass on the repaired source. C fixture checks
below establish only their stated paths on Clang ARM64.

## What changed

| Area | Current implementation; integration pending |
|---|---|
| Runtime | Deleted tracing roots, marks, sweeps, collection retries and switches. Retained allocator, exact counts, typed destruction, finalizers, WASI count table and scheduler cancellation. |
| Compiler/API | Counted lowering is unconditional. Removed `--gc`, `NativeOptions.arc`, optional release/reuse and root fences. Python disassembler uses the same fixed ownership model. `FWP_NO_REUSE` is an explicit generated-C copy control. |
| Lifetimes | Weak channels and rejection of unproved owning cycles remain. Shared interpreter/native entry admission from #216 is retained. Tasks and callbacks require their owned contracts. |
| Failure paths | Constructor/unwind/cancel controls observe real owners, physical frees, raw buffers and OS handles. Closure destruction traps exit without revisiting partially destroyed owners. Task result and library report-reader repairs are included. |
| Coverage | All 253 integration targets remain assigned. `native_memory` and the macOS `ownership` shard replace collector names while keeping the complete program corpus. Nine production jobs remain required. |
| Measurements | Producers/readers use one counted model and five allocation-profile fields. Retained alias, forced-copy, missing-owner, cleanup, byte/count and timing controls remain. Historical JSON is unchanged. |
| Benchmarks | C/Rust comparisons keep equivalent inputs and explicit toolchains. Word frequency has explicit `record` and `compare` operations; recording needs no prior report. Comparisons preserve allocation-reduction budgets and retain slower timing samples. |
| Docs | Current syntax/runtime/tooling guides describe one ownership model. Historical reports retain their source-specific claims. PLAN.md separates collector deletion from ARC minimization. |

## Remaining acceptance

1. Audit compiler/lint results and **all** failed jobs and test targets
   before pushing repairs. Keep completed head results while other gates run.
2. Require nine production jobs plus documentation on the same
   commit. Preserve Linux/macOS/Windows ARM64/AMD64 native coverage and both macOS
   corpus shards. Require ownership-analysis budgets on that final source too.
3. Check actual emitted binaries for absent collector symbols and inspect retained
   missing-owner/free/reuse controls. Verify the Python SDK, WASI execution,
   packaging and benchmark readers through their integrated jobs. Do not treat
   a skipped job or a focused host C harness as this evidence.
4. Record exact results in [ownership diagnostics](ownership-diagnostics.md) and
   [delivery history](roadmap-history.md). Squash merge only passing final gates,
   with one subject of at most 80 characters and an explicitly empty body.
5. Continue PLAN.md A2–A6: residual-count accounting, count-free unique buffers and
   scoped workspaces. Removing tracing does not eliminate ARC or heap allocation.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G5 tracing deletion and final validation |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |

## Local check policy and recovery

Use `python3 scripts/local-guard.py COMMAND...` serially. Keep its CPU/RSS/disk
limits; full builds, suites and benchmarks belong on runners. No helper or
background publisher is running. The primary checkout only points to this worktree;
keep its untracked compiler-abort report.

All preview/migration helpers in `/private/tmp` are one-shot or obsolete. Never
reapply them to current source. Use a fresh source audit. The last broad audit,
`/private/tmp/fwp-remaining-tracing-audit.txt`, predates the SDK/browser fixes;
remaining obsolete option spellings should be absence/unknown-option controls
or the diagnostic inventory, not active compilation settings.

The intermittent Intel compiler abort remains unexplained. Preserve
[its evidence](measurements/compiler-abort.md); diagnose recurrence from source
and input, not speculative disassembly-led allocator experiments.

## Checks actually run

All local checks used `python3 scripts/local-guard.py`; no full build/suite ran.
Scripts below live in `/private/tmp` unless a repository path is given.

| Guarded command | Result and limit |
|---|---|
| `python3 fwp-check-counted-allocator.py` | Actual allocator slice, Clang 17 ARM64 O1/O2: zero/small/large first allocation, page reuse, wide metadata and unload pass; omitted free fails with 27. |
| `python3 fwp-check-static-allocator.py` | Same compiler/settings, explicit 1 MiB static pool: slot/page reuse passes; exhaustion exits 102. |
| `python3 fwp-check-allocation-report.py` | Strict parser accepts valid LF/CRLF and rejects missing/duplicate fields, invalid numbers and wrong units. |
| `python3 fwp-check-report-runtime.py` | O1/O2 actual allocator: 100,032 allocated; 32 released/100,000 live, then 100,032 released/zero live; peak 100,032 and extent 196,608. |
| `python3 fwp-check-memory-startup.py` | Migrated harness compiles at Rust O1 with warnings denied; three helper tests pass. Does not run generated memory servers. |
| `python3 fwp-check-closure-failure.py` | Actual allocator, cleanup queue and trap code, Clang ARM64 O1/O2: normal release passes; capture trap 101, spill OOM 102 and omitted context reset 94. A recovery callback would fail with 93. Does not establish generated-program or other-target support. |
| `python3 fwp-check-stream-owners.py` | Current runtime, Clang ARM64 O1/O2: eighteen normal size/read-mode cases end with zero charge and all messages freed; omitted cache drop exits 40 at both levels. This uses a minimal C library harness, not generated Rust/library integration or network calls. |
| `python3 fwp-check-task-result-owner.py` | Current runtime, Clang ARM64 O1/O2: four runs verify fresh task results, independent await owners and early handle release. Final bytes return to zero; omitted result destruction fails 217. Minimal typed callback, not generated integration. |
| `python3 fwp-check-wasi-owner-path.py` | Actual WASI allocator branch compiled on Clang ARM64 O1/O2: twelve file/pair/task/channel cases pass, including retained storage, overflow and omitted file/header/pair/runtime release controls. This uses a minimal typed pair destructor and does not establish generated or actual wasm32 execution. |
| `python3 fwp-check-counted-descendants.py` | Current runtime, Clang ARM64 O1/O2: six runs verify 256 parent owners, independent child updates, interior count-slot mapping, 70 nested branches and final byte/metadata balance. Saturated counts and omitted child retain fail 1/2. C fixture, not generated integration. |
| `python3 fwp-check-string-ledger.py` | Actual Rust ledger helper and current runtime, Clang ARM64 O1/O2: four runs preserve live strings and reject omitted ownership with 207 before string access. Minimal C harness, not the generated stack-match test. The harness initially named a nonexistent free helper; corrected to `fwp_rc_free_obj`. |
| `python3 fwp-check-numeric-decoder.py` | Current runtime, Clang ARM64 O1/O2, packed/word arrays: twelve decoder runs pass. Normal and malformed input restore live bytes; omitted array cleanup fails 169, wire/count controls fail 154/155. Minimal C harness, not generated-program or other-target validation. |
| `python3 fwp-check-scalar-list-owners.py` | Current runtime, Clang ARM64 O1/O2: scalar repeat/range, zip/unzip/chunks and sort preserve address-shaped scalar bits and restore live bytes. Six runs; direct runtime calls, not generated-wrapper integration. |
| `python3 fwp-check-file-owner-migration.py` | Current runtime, Clang ARM64 O1/O2: forty constructor/I/O/storage runs pass, including 8/1,024-round release and all omitted close/finalizer/header/text/alias/scope faults. C harness only; generated and other-platform checks pending. Initially caught a deleted `armed` field and missing typed callback metadata; both fixtures repaired. |
| `python3 fwp-check-connect-owners.py` | Current runtime/OpenSSL, Clang ARM64 O1/O2: normal cancellation restores live bytes; omitted TCP/TLS owner, resolver and SSL cleanup fail as required. Ten runs; generated-library and other-platform checks pending. |
| `python3 fwp-check-http2-peer-owners.py` | Current runtime/OpenSSL, Clang ARM64 O1/O2: peer-copy/option failure and explicit transport release restore live bytes; omitted peer release exits 1. Four runs; minimal C descriptors, not generated descriptor/platform verification. |
| `python3 fwp-check-linalg-owners.py` | Current runtime, Clang ARM64 O1/O2: six solvers and partial-allocation failures pass; omitted scratch release exits 222 and omitted result release exits 224. Six runs; generated library/platform validation remains pending. |
| `python3 fwp-check-library-tape-unload.py` | Current runtime, Clang ARM64 O1/O2, workspace cache off/on: repeated shutdown/restart restores scope links and live bytes. Omitted weights fail 187; omitted unlink fails 186. Twelve runs; this C harness does not verify generated libraries or dynamic unload. |
| `python3 fwp-check-transpose-owners.py` | Current runtime, Clang ARM64 O1/O2: normal aliases and all fourteen partial-construction failures restore storage; omitted alias retain exits 201 and omitted scratch release exits 202. Six runs pass; generated-program and other-target checks remain pending. |
| `python3 fwp-check-ad-identity.py` | Current runtime, Clang ARM64 O1/O2: root startup succeeds, cross-task and retired-task use trap 101; repeated IDs or removed checks make controls succeed. No generated Rust-program or other-target claim. |
| `python3 fwp-check-ad-workspace.py` | Current runtime, Clang ARM64 O1/O2, explicit cache off/on, direct and callback-scoped calls: all eight runs pass, with matching six gradient hashes and cleanup after errors/cancellation. |
| `python3 fwp-check-channel-schema.py` | Actual reader accepts 45 synthetic channel samples and rejects missing/duplicate samples, obsolete memory-mode fields and live-byte leaks. Not a benchmark run. |
| `python3 scripts/test-hash-evidence.py` | All four evidence-audit tests pass, including incomplete logs, run-state rejection and saved-file tampering. New generated hash benchmarks remain unexecuted. |
| `python3 fwp-check-server-schema.py` | Actual report reader accepts complete synthetic stdio/HTTP evidence and rejects missing/duplicate rows, an ineffective omitted-free control and excess RSS. This does not execute servers or inspect their binaries. |
| `python3 fwp-check-deletion-edits.py` | Rust formatting, changed Python parsing, whitespace, 253-target native schedule and integer artifact gate checks pass. |
| `python3 fwp-check-migration-python.py` | Ruff reports no unresolved names in all changed Python files. This is a static check, not execution of measurement protocols. |
| `python3 fwp-check-library-report-reader.py` | Actual dynamic loader fixture, Clang ARM64 O1/O2: ten runs accept three consecutive zero-live records and reject nonzero/obsolete/malformed/missing reports. Minimal library stub, not generated-library validation. |
| `env PYTHONPATH=sdk/python:sdk/python/tests FWP_TEST_BIN=must-not-run python3 -m unittest test_tools.Tools.test_disassembly_rejects_invalid_levels_before_creating_output` | SDK rejects invalid levels before reading source, creating output or invoking a compiler. Native SDK checks remain pending. |
| `cargo fmt --all -- --check` | Entire Rust tree passes, without building. |
| `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-g5-primitive-inventory.json` | Frozen contracts pass: 394 declarations, 384 symbols, 40 aliases; 373 contracts, 19 templates, two flat scalar signatures. |
| `python3 scripts/test-collection-evidence.py` | Eight tests pass, including exact target counts and rejection of incomplete/incorrect memory observations. |
| `python3 scripts/test-integer-output-evidence.py` | Three reader tests pass: collector symbols, incomplete/failed/ignored/duplicate logs are rejected. Synthetic evidence only. |
| `python3 scripts/test-map-replay.py` | Four tests pass: complete counted evidence accepted; wrong source/architecture, changed files, missing variants and external paths rejected without binary execution. |
| `python3 scripts/test-native-test-runner.py` | Twenty tests pass, including a real Cargo build/artifact/failure-propagation check. Other cases cover coverage, timeouts and independent target progress; this is not the language suite. |
| `python3 scripts/check-roadmap.py` | Pass after this rewrite: 163 link sets, 106 immutable preparation pairs/tags, eight roadmap rows and commit messages. |

## CI repair checks

All commands below used `python3 scripts/local-guard.py`; none built the Rust
compiler or ran a full suite locally.

| Command | Result |
|---|---|
| `python3 scripts/test-native-test-runner.py` | 20 pass; real Cargo smoke check verifies supported options, artifacts and continued execution after a failing target. |
| `python3 /private/tmp/fwp-217-check-controls.py` | Six Clang ARM64 O1/O2 runs from CI's saved 3-point/7-update generated C: normal cleanup returns zero live bytes; retained allocation exits 225; removing observation allows completion and final cleanup. GCC and full numerical matrix remain CI gates. |
| `python3 /private/tmp/fwp-217-check-map-phases.py` | Four Clang ARM64 O1/O2 runs: joined and historical separate storage preserve sorted keys/values, emit all six phase records and restore live bytes. Uses a direct runtime probe appended to CI-generated C, not a whole-application timing comparison. |
| `cargo fmt --all -- --check` | Entire Rust tree passes formatting; no compiler build. |
| `python3 scripts/check-roadmap.py` | 163 doc link sets, 106 preparation anchors and eight roadmap rows pass. |
| `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-217-repair-inventory.json` | Frozen primitive contracts pass. |

### Follow-up checks on the local repair

All used the local guard. The downloaded macOS ARM64 compiler is the CI binary
from `3e1c1482`, not a locally rebuilt compiler. Where used below, current runtime
changes are supplied explicitly; complete regenerated integration remains a CI gate.

| Command | Result and scope |
|---|---|
| `python3 /private/tmp/fwp-217-check-channel.py` | Actual channel test and ownership ledger pass at Clang O1/O2, including all seven deliberately broken ownership/order cases. CI compiler emits the program; a small standalone Rust harness supplies only C compilation. |
| `python3 /private/tmp/fwp-217-check-release-controls.py` | Actual allocator and array-iterator test bodies pass at O1/O2, including marker assertions and omitted-free failures 27/193. Current allocator source; iterator generation uses the CI compiler. |
| `python3 /private/tmp/fwp-check-stream-owners.py` | Current runtime stream fixture passes eighteen normal runs and both omitted-cache-drop controls at O1/O2, including repeated empty-call cleanup. Minimal C library, no network. |
| `python3 /private/tmp/fwp-217-check-shared-stream.py` | Six network comparisons pass: O1/O2 native clients against interpreter, O1 and O2 native servers. Uses CI-emitted C with the current call-cleanup function substituted; each returns `(Some 524800, Some 524800)`. |
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_client_requests grpc_client_receive` | Both fixture bodies and omitted-owner/buffer/reset controls pass at O1/O2 after correcting mock ownership. Uses current runtime with minimal library entry metadata, not generated-library integration. The receive check was rerun alone after correcting a void-return macro expression in the repair. |
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_send_cleanup grpc_context_restore grpc_connect_startup` | Three related fixture bodies pass at O1/O2, including cancellation, nested failure and startup cleanup controls. Same minimal-library limitation as above. |
| `python3 /private/tmp/fwp-217-final-static-checks.py` | Rust formatting, Python parsing, all 20 runner tests and native shard coverage, frozen primitive contracts, 163 documentation link sets, 106 preparation anchors, eight roadmap rows and whitespace pass. |

### Published failure repair checks

All used `python3 scripts/local-guard.py`. The standalone fixture harness assembles
current runtime source and minimal library metadata, then executes repository test
bodies; it does not regenerate their real library descriptors or build the compiler.

| Command | Result and scope |
|---|---|
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_force_cleanup:forced_cells_release_received_storage_and_decoder_failure_text grpc_peer_completion` | Both fixture bodies pass at O1/O2, including missing receive/text cleanup and early/missing serving-peer/task cleanup controls. |
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_receive_cleanup:fatal_runtime_allocations_report_errors_from_task_stacks grpc_request_encoding grpc_response_encoding:native_output_channels_borrow_values_and_release_context` | Fatal allocation cases 0–18, sender input ownership and output channel controls pass at O1/O2. The first standalone extraction failed because it omitted the runtime helper; corrected before the passing run. |
| `python3 /private/tmp/fwp-217-check-await-control.py` | Actual await comparison passes at O0/O2: identical output, 34 restored temporary boxes, unchanged required retains and zero final live bytes. Uses CI compiler `3e1c1482` and its emitted C/exact-arithmetic sources. Initial harness links omitted those arithmetic dependencies; the complete link passes. |
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_force_cleanup:forced_cells_release_received_storage_and_decoder_failure_text` | Rechecked at O1/O2 after preserving both cleared-reader and empty-waiter observations before source destruction; passes. |
| `cargo fmt --all -- --check`, frozen primitive inventory, `python3 scripts/check-roadmap.py`, `git diff --check` | Pass: unchanged 394 declarations/384 symbols/40 aliases and 373 contracts; 163 link sets, 106 preparation anchors and eight roadmap rows. No compiler build. |

### Follow-up after `4c79748a`

All checks used `python3 scripts/local-guard.py`; no local compiler build or full
suite ran.

| Command | Result and scope |
|---|---|
| `python3 /private/tmp/fwp-217-check-grpc-fixtures.py grpc_force_cleanup:cache_owners_release_aliases_and_long_chains_without_collection` | O1/O2 pass: 50 normal runs across 64/1,024/16,384 entries, aliases and terminal failure/shared-owner modes; recursive cleanup fails 175 and omitted source release fails 171. Rechecked after adding complete transport live-storage balance. Uses current runtime and repository test body with minimal library metadata. |
| `python3 /private/tmp/fwp-217-check-wasi-sources.py` | CI compiler `4c79748a` emits WASI C for all three corrected capacity sources. This verifies admission/generation, not actual wasm32 allocation or execution. |
| `cargo fmt --all -- --check`, `python3 scripts/check-roadmap.py`, `git diff --check` | Pass: formatting, 163 doc link sets, 106 preparation anchors, eight roadmap rows and whitespace. New Rust call-type regression and analysis budgets remain runner checks. |

### Pending GCC repair checks

- `python3 scripts/local-guard.py actionlint .github/workflows/ci.yml`: passes.
- Guarded Rust formatting, documentation audit and whitespace checks pass.
- The first diagnostic harness links and runs at local Clang ARM64 O1/O2 with
  CI compiler `4c79748a`. This verifies the harness, not the GCC failure.
- Superseded diagnostic `40388745759` was cancelled while queued; no test results
  were discarded. Replacement `40390897932` retains an unchanged fixture first.
