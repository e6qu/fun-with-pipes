# Current work

**Next:** publish the verified setup/analysis repair and monitor final-head CI
with timed wake-ups until every gate passes. Squash merge with one subject
of at most 80 characters and an empty body, then continue PLAN.md A2–A6.

## Delivery and evidence

- Worktree: `/private/tmp/fwp-delete-tracing`; branch `delete-tracing-collector`.
- [PR #217](https://github.com/e6qu/fun-with-pipes/pull/217) is open; published
  source `2499e7b737b0684e46d101cb2ceecac062c3a445`.
- [Production 40423913146](https://github.com/e6qu/fun-with-pipes/actions/runs/40423913146):
  both regular macOS, both ownership macOS, both Windows and benchmarks pass.
  ARM64 Linux passes too. AMD64 Linux has two failures with one setup cause:
  cross-toolchain downloads from Azure's Ubuntu mirror exceeded ten minutes;
  the skipped `wasm-opt` installation then made the required WASI task check fail.
  The service error-control repair passes; no other completed AMD64 target fails.
- [Documentation 40423913144](https://github.com/e6qu/fun-with-pipes/actions/runs/40423913144)
  passes. [Analysis 40423924014](https://github.com/e6qu/fun-with-pipes/actions/runs/40423924014)
  passes Linux but fails Intel macOS: N=64 separate/merged medians
  35.57/21.80 ms exceed the 1.5 ratio; forms analysis takes 12.02 s against 10 s.
  These limits remain unchanged. Earlier passing runs do not erase these failures.
- Setup repair selects `https://archive.ubuntu.com/ubuntu/` directly in the
  runner's AMD64 mirror list, retaining package identities and all timeout limits.
  The failing mirror kept transferring slowly, so an idle connection timeout
  could not prevent the overall step deadline. No package or test is skipped.
- Analysis repair joins captured and newly supplied facts directly for calls
  with all their arguments. It removes a temporary vector and copied origin sets
  on each visit; partial and over-applied calls retain their required storage.
  Summary ordering, scope rules and acceptance budgets are unchanged.
- [Focused verification 40433091299](https://github.com/e6qu/fun-with-pipes/actions/runs/40433091299),
  temporary source `5609b5c7fe4fbd3837781e3ba08a9e46750c09aa` on
  `ci-ownership-setup-repair`, runs both analysis hosts and the actual Linux
  dependency steps. All three jobs pass: 192 ordinary library tests per analysis
  host, both existing budget tests and every required setup tool. Proof counts
  remain unchanged; [measurements](measurements/ownership-analysis.md) record the
  results. Full production acceptance still requires the published final head.
- Standing user instruction: remain active, use timed wake-ups to monitor CI,
  repair failures and squash merge only a passing final head. One-minute
  `clock.sleep` waits keep this turn active; no detached merge watcher is used.

**GC removal remains unverified.** Require all nine production jobs, documentation
and both analysis hosts on the repaired final head before merging.

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

### Combined CI repair checks

All local commands used `python3 scripts/local-guard.py`; no full compiler build
or suite ran. The local GCC checks used Ubuntu 24.04 / GCC 13.3 under AMD64
emulation, with a half-core CPU limit, 768 MiB memory cap, 160-second deadline and
sampled container memory. This is diagnosis, not native platform acceptance.

- `actionlint .github/workflows/ci.yml`: passes after bounding package setup.
- `python3 /private/tmp/fwp-217-container-gcc.py`: repaired service fixture passes
  O1/O2 with 12 metadata and 2 subject failures and zero final charged bytes.
  Missing-field-drop controls exit 248 at O1/O2; missed injection and unrelated
  trap controls exit 247 at O2. Six checks, 73.47 seconds, sampled memory below
  224 MiB. Uses CI compiler `4e626132` and the repository fixture.
- The bounded toolchain setup initially lacked `libc6-dev`; adding the explicit
  package fixed it. No guard limits were raised. The toolchain image is temporary.
- Native diagnosis and per-attempt trace logs are retained by the linked runs.
  No runtime algorithm or expected allocation count was changed to silence this
  failure. The precise GCC transformation behind the old tally is not established.
- `env CPATH=/opt/homebrew/opt/openssl@3/include LIBRARY_PATH=/opt/homebrew/opt/openssl@3/lib python3 /private/tmp/fwp-217-check-service-repair.py /private/tmp/fwp-217-4c79-compiler/fwp-macos-arm64/fwp /usr/bin/clang`:
  the same six normal/control checks pass on Apple Clang 17 ARM64; 3.15 seconds.
  CI compilers `4c79748a` and `4e626132` emit identical C for this source.
- Guarded Rust formatting, workflow lint, documentation audit and whitespace
  checks pass: 163 link sets, 106 immutable preparation anchors, eight roadmap
  steps. Full native checks for the related HTTP/2/capture fixture edits and the
  Windows header-order repair remain final-head CI requirements.

### Error-control repair checks

- Guarded actual Rust test body, Apple Clang 17 ARM64 with CI compiler `4c79748a`:
  the unmodified `6c84631a` test reproduces exit 0 versus expected 247 (4.59 s).
  The repaired body passes (5.49 s), including raw/optimized interpreter equality,
  generated program output, normal and three negative variants at O1/O2, and
  the existing O2 symbol check. No full local compiler build or suite ran.
- Command: `python3 /private/tmp/fwp-217-check-actual-service-test.py
  /private/tmp/fwp-217-4c79-compiler/fwp-macos-arm64/fwp /usr/bin/clang
  /private/tmp/fwp-217-actual-service-after`, with explicit OpenSSL include/library
  paths under `scripts/local-guard.py`. Only temporary-directory and C-compilation
  adapters replace crate helpers; the repository test body is unchanged.
- Native GCC actual-test verification passes all four variants at O1/O2,
  interpreter comparisons and the O2 symbol check; see run `40423724806` above.
- Guarded Rust formatting, documentation audit and whitespace checks pass:
  163 link sets, 106 immutable preparation anchors and eight roadmap steps.

### Setup and analysis repair verification

- Runner `40433091299`: both analysis hosts pass all 192 ordinary unit tests and
  the separately executed scaling/startup tests. Linux forms/entries take
  5.977/3.692 s; Intel 6.804/4.181 s, each under 10 s. Largest-fixture ratios are
  1.366 and 1.263 respectively, under 1.5. No count or timing budget was raised.
- The focused dependency job runs the production setup steps. The explicit
  Ubuntu archive supplies 55.8 MB of cross packages in six seconds; cross GCC,
  qemu, musl, Clang and wasm-opt 132 are installed and report their versions.
- Local formatting and workflow checks use `scripts/local-guard.py`; no full
  build or suite is run locally. The earlier formatting check found line wrapping;
  `cargo fmt` corrected it before focused runner publication.
