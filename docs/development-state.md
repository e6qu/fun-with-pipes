# Current work

**Next:** finish numerical/word-frequency measurement and replay protocols, then
retire obsolete admission inventories and audit their workflow/doc callers.
After that, run consolidated compiler and production gates on runners. The current
source has not been built as a compiler. GC removal is not verified.

Worktree: `/private/tmp/fwp-delete-tracing`; branch `delete-tracing-collector`.
Base: verified #216 squash `f5621cb46828273f7ce8edf92be4062ccec0f17c`.
All eleven private checkpoints were rebased through `f441b313`, preserving the
verified queue rejections, analysis caches and bounded startup. No new PR is open;
nothing from this deletion branch has been pushed.

#216 passed nine production jobs (`40274667944`), docs (`40273010537`) and both
analysis-budget jobs (`40273030485`) on `1dd5fcaed7792b5505283b1037a9c22d788a3be5`.
The merge has the same tree and the required one-line message. See
[delivery history](roadmap-history.md). Keep the primary checkout's untracked
compiler-abort report; its handoff points here. Old publisher scripts stay stopped.

## Latest completed edits; execution pending

- Migrated 22 scalar/AD profile consumers to the five-field allocation report,
  preserving live-byte, tape, reuse and count budgets. Map producers and replay
  readers now agree on counted artifact names; all four replay validation tests
  pass. The map failure reader requires 13 binaries, two failure configurations,
  two callback runs, eight peak observations and three broken-cleanup/layout
  controls per host. HTTP readers require four client and six server/client
  images per host; WASI and scalar readers match the migrated producers.
  Ruff name checks pass for 82 changed scripts. This is report validation, not
  new generated-program or benchmark evidence.

- Renamed `tests/gc.rs` to `native_memory.rs` and the second macOS shard to
  `ownership`. Its separate full golden corpus, all 253 target assignments,
  compiler-failure controls and artifact retention remain. All nineteen runner
  unit tests pass. Fixed an outdated workflow test name and compiler-error text.
- Package smoke checks build one counted native program, still comparing raw
  interpreter output, architecture and Windows dependencies. Benchmark memory
  readers now require the current five-field profile rather than a removed
  collection count. Packaging and integrated benchmark execution remain pending.

- WASI fixtures own their path strings and use actual file/pair/task/channel
  destructors. They retain physical-free, retained-storage, wide-count and
  scalar-address controls; actual wasm32 bounds tests use a real forced-copy
  define. The host allocator-branch check passes; actual WASI integration is pending.
- Removed the task-result tracing escape branch: owned spawn already supplies
  the counted task and typed result destructor. An unowned gRPC response reader
  now traps instead of silently retaining storage. Current-runtime task/transport
  checks below cover these final runtime edits locally; integrated execution
  remains pending.

- Array construction/sort and copied-list tests now have matching counted artifact
  readers: eighteen binaries each for construction/sort and ten for list copies.
  O1/O2, actual forced copies, aliases, bit patterns and every interruption fault
  remain. Collector-symbol absence is checked on every image.
- REST retains API/authentication/forms, generated clients and raw comparisons;
  removed the second run of the same cases under the deleted tracing selector.
  C/Rust benchmark reports and memory readers now name counted ownership, with
  matching workflow arguments and an incorrect-ownership-report control. Six
  timing samples per implementation, all five corrupted-artifact controls and
  actual binary inspections remain. No new timing results have been produced.

- Resource frames/matches retain descriptor limits, raw/native comparisons,
  aliases, handled errors and forced copies. Variant failure checks observe text
  frees directly. Executable invocation checks always require live-byte balance.
  Serializer runs compile their saved C once per configuration. Extended owner
  cases retain both stack settings and every input, with duplicate tracing runs removed.
- High-fanout tests now acquire child owners explicitly, preserve parent aliases
  during updates and release the full graph. Saturating away a count fails 1;
  omitting a child retain fails 2. Stack-match controls use the allocation ledger
  and check string identity before reading payloads, instead of relying on poisoning.

- Numeric fusion, layout, packed arrays, display and bounds tests retain their
  O1/O2, packing, effects/traps, bit-pattern and forced-copy cases. Copy controls
  now change the compiled C. Decoder fixtures release successful results and
  supply typed failure cleanup; omitted array cleanup fails the live-byte check.
  Fusion/view/layout fixtures also require restoration of starting live bytes.

- List/fold/filter/map/zip and text checks keep their alias inputs, stack choices,
  output comparisons and release thresholds. Leak controls retain an extra owner
  at the named result boundary; no tracing promotion is used. Normal accounting
  runs must end at zero live bytes. Forced copies use the actual C control.
  Scalar generation/structure/sort probes now release all fixture storage.
  Fold artifacts have one result per counted configuration, without GC suffixes.
- Files: constructor callbacks now declare typed ownership; physical-free hooks
  replace freed-header/text reads. Storage controls target the current destructor.
  Alias, close-once, rollback, overflow, finalizer removal and slot reuse remain.
  Boundary/discard programs use real copy/retained-resource controls and a missing
  header-release fault instead of removed compiler settings.
- Transport fixtures now release task handles, strings, sockets and HTTP/2 call,
  stream and connection storage before testing byte balance. TCP/TLS cancellation
  retains all four omitted-cleanup controls; HTTP/2 retains peer-copy/option faults.
  macOS checks require allocation balance and retain native task, derivative,
  list, global-owner and platform coverage. Generated-program checks remain pending.
- Linear algebra: one counted model retains all six solvers, 256 repetitions,
  allocation-failure positions and alias controls; byte restoration is unconditional.
  Channel queues now observe physical releases with the allocation ledger instead
  of reading freed payloads. Cancellation, transfer, growth/retry and sink controls
  remain; the raw C fixture gives scheduler/task handles explicit owners.
- C libraries: shutdown reports one exact live-byte count, with matching strict
  reader and retained static/shared, O1/O2, workspace and unload configurations.
  Derivative exports use explicit scopes. A separate C-only fixture leaves valid
  scoped work unfinished for unload. Fixed tape shutdown to unlink those scopes;
  missing unlink, missing weights and missing shutdown remain deliberate faults.
  Preemption/timer cases retain every time slice; FFI retains signed-overflow controls.
- Task layout/cancellation: one counted model, byte-versus-integer flags,
  O0/O2 comparisons and missing-pointer controls. The audit requires twelve
  binaries per host plus eight Windows ABI/context variants.
- gRPC: retained response channels, connection/request ownership, receive/encode
  failures and cancellation keep their distinct cases. Forced copies use
  `FWP_NO_REUSE`, with counted owners intact. The stream fixture now releases
  its cache and transport owners; an omitted cache drop must fail with status 40.
- Reports: server completion has fourteen fields; stream storage has eleven.
  Service-context reports now have three counters and counted scope/capture
  artifacts. List-each timings use eight samples with balanced order.
  Producers/readers agree and reject obsolete collection columns. Existing
  callback/await audits require twenty O0/O2 binaries. No new benchmark result.
- File-constructor rollback, TLS listener/cache/subject/wire ownership and HTTP/2
  client/server checks retain their faults. Client byte-balance assertions now run
  unconditionally, without poison/stress switches that used to suppress them.
- Inline-file layout comparisons now release both the file/path and display
  text; Unicode file I/O retains a real forced-copy variant. NUL-path rejection,
  Windows raw/native comparisons and matrix controls keep all distinct cases.
  Field-move/projection and TLS subject balance assertions are unconditional.
- Earlier test migrations cover arrays, hashes, lists, State, cached values,
  derivatives, file/socket/library resources, callbacks and compiler call
  lifetimes. They preserve aliases, partial failures, cancellation, forced-copy
  and omitted-release controls. HTTP retains all transports and RSS bounds.
- Protocols: channel reports require 45 samples per host; hash comparisons use
  five implementations and ten samples each; numerical comparisons use fwp/C/Rust
  with thirty samples each. Paired numerical variants use twenty samples each.
  Historical reports keep their original schemas and source revisions.

## Implemented here; integration still pending

| Area | Change |
|---|---|
| Collector | Replaced `runtime/fwp_rt_gc.c` with `fwp_rt_heap.c`; removed root discovery, mark/sweep, collector settings and collection retries. Retained allocator, finalizers, WASI count table and scheduler cancellation registry. |
| Code generation | Removed `NativeOptions.arc`, `--gc`, optional counted lowering, `Gen.reuse` and root fences. Counts and typed destruction are unconditional; `FWP_NO_REUSE` remains an independent copy control. |
| Allocation accounting | `fwp_heap.live/peak` are exact physical slot/requested-byte balances. Cumulative allocated/released bytes use floating point. `FWP_ALLOC_STATS` reports six explicit byte/RSS fields. |
| Runtime callbacks | Removed unowned task spawn/within paths. Missing owned callbacks trap; verify callers and rejection expectations against the new runtime. |
| Diagnostics | Migrated native/static allocator probes, live-byte consumers, strict report parsing, 27 report consumers and 41 allocator-hook signatures. Physical-free observers use the single release path. |
| Memory cases | Loop/HTTP/REST/gRPC retain their RSS limits. Server startup is bounded and stderr is drained without accumulating logs. One counted run replaces duplicate modes. |
| Release controls | Retired collection-age tests and poison-only variants. Kept corpus outputs, failures, independent allocation ledger and reuse comparisons. The tree test retains its >100 MiB release bound; omitted physical frees must fail. |
| Static storage | The three-million-step normal case remains. A separate copied-value case must fit a 1 MiB pool with counted release and exhaust it with status 102 when physical frees are omitted. |
| Wide counts | Retained exact counts, overflow/OOM, metadata-free faults and high-fanout outputs. Added live interior-address count-slot mapping and fresh counts on reused addresses. No freed payload is read. |
| Test selection | Reviewed and selected counted C branches in 61 files. Removed collector-status terms from combined assertions while preserving live-byte, metadata and resource checks. |
| Numeric/CLI cases | Migrated nine test files to one counted run, retaining optimization/layout choices and deliberate faults. Integer evidence gates now require six length binaries and ten product/sanitizer binaries per host; direct-output inspection requires 72 binaries across six hosts. |
| Windows contexts | Removed collector stack bounds and root snapshots. Retained register/stack/rounding, borrowed-host-fiber and ownership-size controls at O0/O1/O2; native execution is pending. |
| Client reports | Shared client-memory observer now reports requests, requested bytes, retains, peak-live growth and final-live growth. Updated all its Rust readers and Python consumers; no dummy collection field. |
| Owner tests | Migrated nine constructor/record/variant/worker preparation and unwind files to one counted run, retaining alias, failure and missing-release controls. |
| Entry checks | Removed duplicate AOT modes and deleted-switch diagnostics; kept raw/native results, rejection-before-emission, count-boundary failures, missing-free and recursive-stack controls. Workflows use the renamed test. |
| Linux contexts | Replaced collector-root probe with live register, rounding and signal-mask checks. Retained stack layout, clear/alignment/lifetime controls and updated the process measurement reader. |
| Borrowed bytes | HTTP/2 and TLS probes inspect actual owners at the copy boundary and release them afterwards. Premature-release controls exit before reading freed storage; forced collection and register-clearing machinery are gone. Native validation is pending. |
| Iterator/recursion reports | Retained matched fwp variants, inputs, optimization levels, timing scopes, allocation/live-byte counters and binary evidence. Removed the second memory mode and collection fields. |
| Root fences and loops | Removed collector fences from 47 fixtures/targets. Replaced the last fence-dependent loop control with omitted typed releases, checking both released and live bytes. Alias cases use the real copy control. |
| Closure destruction | Queue exhaustion now exits 102; traps during destruction exit 101 without recovery or shutdown callbacks revisiting partial owners. Normal release restores live bytes and clears the thread context. Missing reset exits 94. Integrated validation is pending. |
| List, State and unwind | Explicit list input owners and live-byte restoration; scalar State-slot restoration plus separate counted-State checks. Removed two legacy unwind probes covered by the owned suite, retaining their diagnostic assertions. Fixed the typed-State await-result leak and removed collection fields from its report. |
| Docs | Updated ownership, native commands, tutorials and allocator/report explanations. Historical measurements retain their original source/schema; reproduction instructions distinguish their revision from current tools. |

The nine mode migrations are `array_loop_borrows`, `cli_ownership`,
`clock_ownership`, `terminal_ownership`, `float_formats`, `integer_output`,
`scalar_math`, `scalar_traps` and `static_constants`.

## Remaining migration, in order

1. **Test mode removal is implemented, not integrated.** A fresh audit finds
   no active tracing settings in Rust tests. Remaining occurrences are explicit
   absence/unknown-option assertions or unrelated gRPC context ownership. Review
   measurement consumers and workflow callers before integration. Review their
   actual assertions and paired C fixtures, not just environment names. The list/State/closure fixtures in
   `list_applicative_ownership` are migrated; integrated execution is pending.
   `unwind_cleanup` and typed-State reports are also migrated. Continue from a fresh source audit; do not reapply the stale candidates.
   Remove variable `--gc` arguments, duplicate
   ARC/tracing loops, obsolete environment settings and CLI-selector tests.
   Keep every distinct semantic input, optimization/layout choice and ownership
   fault. Retain errors for unsupported current options; no compatibility aliases.
2. **Finish C fixtures.** Remove remaining collector fields/calls, root-fence
   anchors and escaped `FWP_ARC_ONLY` blocks. Preserve independent lifetime,
   alias, failure/cancellation and resource assertions. Windows ABI/register/rounding and host-fiber ownership checks have been migrated;
   the Linux context fixture now checks live values and machine state without collector roots.
   No `FWP_KEEP_ALIVE` remains in runtime, compiler or tests; the HTTP/2 unit
   fixture now releases its actual call/stream/connection owners.
3. **Finish report schemas and consumers together.** The shared client-memory report is migrated; other server/numerical
   reports still carry collection fields. Remove them rather than printing dummy
   zeros. Update strict parsers, TSV/JSON producers, artifact audits and docs.
   Do not rewrite historical measurement JSON.
   Service values/scopes now use one ownership model and retain partial-copy
   failures and aliases. Generated REST/MCP tests keep every protocol/transport,
   raw-interpreter comparison, disconnection and memory bound. Their reader now
   expects six stdio rows, 27 HTTP rows, 15 RSS samples and four binaries per host;
   the omitted-physical-free control replaces the removed compiler switch.
   Collection measurement and audit scripts now match migrated builders and
   compact/range sets: five counter fields, 28 inspected binaries per host,
   no tracing mode or dummy collection field. Integrated execution is pending.
   Task/callback label matrices and their consumers are migrated. Remaining
   measurement scripts still need a fresh audit for old modes, collection fields
   and artifact names.
4. **Verify workflow coverage.** The renamed ownership shard keeps the complete
   counted corpus and fault controls. Nine production jobs and explicit target
   assignments remain. The nineteen runner unit tests pass; final-head native
   execution and remaining measurement-job audits are still required.
5. **Verify integration.** #216's final admission/cache repairs and bounded
   server helpers are incorporated.
   Compile/lint all targets on runners; fix all failures together. Then run one
   complete final-head matrix, docs, primitive inventory and actual-binary
   collector-absence checks. Focused Clang probes do not establish GCC, Windows,
   WASI, generated-program or integrated Rust support.

## Candidate edits and recovery

The 84 previews in `/private/tmp/fwp-single-mode-candidates` have all been
reviewed or superseded by direct edits. They no longer match current source and
must not be reapplied. Continue from a fresh audit of actual files, including
boolean mode parameters and generated-C/report fixtures outside that preview.

Automatic approval review rejected an earlier broad rewrite because substantial
work was uncommitted. No part of that command ran. We saved `bd299fe0`, generated
separate candidates, reviewed every C-branch diff, and applied them with a clean
checkpoint/source check. That safer action was approved. No permission is pending.

The latest measurement audit is `/private/tmp/fwp-remaining-script-modes-v2.txt`.
It includes real stale modes/collection fields and valid absence assertions;
classify each against its producer. Do not blindly replace historical evidence.

Temporary helpers in `/private/tmp` are one-shot edits, not publishers:
`fwp-preview-counted-test-probes.py`, `fwp-apply-reviewed-test-probes.py`,
`fwp-preview-mode-removal.py`, `fwp-refine-mode-candidates.py`,
`fwp-check-mode-candidates.py`, `fwp-apply-reviewed-mode-tests.py`.
Earlier deletion/migration helpers must not be rerun blindly either.
`unifdef -t` handles raw C blocks in Rust; ordinary C parsing rejects Rust
lifetimes. Mixed conditions and escaped C strings need explicit review.

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
| `python3 scripts/test-map-replay.py` | Four tests pass: complete counted evidence accepted; wrong source/architecture, changed files, missing variants and external paths rejected without binary execution. |
| `python3 scripts/test-native-test-runner.py` | Nineteen tests pass after the corpus/shard rename, including explicit coverage, failed target propagation, timeout handling and independent-target progress. Uses synthetic subprocesses, not the language suite. |
| `python3 scripts/check-roadmap.py` | Pass after this rewrite: 163 link sets, 106 immutable preparation pairs/tags, eight roadmap rows and commit messages. |

Local harness repairs: fixed a moved expected value in the parser check and an
unused shutdown helper in startup-only consumers. A slow edit helper was stopped,
then rewritten and run within the guard; never raise its limits. A candidate-only rustfmt call initially tried to follow missing preview modules;
rerunning with `skip_children=true` parsed all 84 previews. No helper remains
running. Diff review also caught and repaired symbol-result shadowing and an
overwide workflow edit; all preparation, correctness and RSS steps are retained. Integrated runtime tests and the new wide/static/tree controls are pending.
Scope cleanup briefly removed an unrelated multiline loop brace in
`text_file_tools`; rustfmt caught it, the original loop was restored, and the
static checks passed. Do not reuse that broad scope-removal helper unchanged.

## Verified starting point and later goals

PR #215 merged as `4e7b74be8e11634fac9309e67cb4efccfb34d360`, with the same tree as
tested `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`. Nine production jobs
`40221722197` and docs `40221722121` passed. G3/G4 are delivered.
[History](roadmap-history.md) and [ownership diagnostics](ownership-diagnostics.md)
record that evidence and the collector-check deletion map.

After G5, continue A2–A6 for ARC minimization; deleting tracing does not eliminate
counts or heap allocations. The [Intel compiler abort](measurements/compiler-abort.md)
remains unexplained; investigate recurrence from source/input. Squash merge only
passing exact-head gates, with an explicit one-line subject of at most 80
characters and an empty body. Verify the message/tree and continue PLAN.md.

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

Rebase note: an overbroad conflict-marker edit was detected immediately. The
rebase was aborted to its saved checkpoint and repeated with bounded matches.
The final diff retains every test body and the verified upstream fixes.

The direct workspace probe now registers its own explicit tape scope. Cancellation
clears it before the harness restores a fresh scope; the first check caught and
fixed an incorrect expected cleanup-chain pointer. Both workspace paths then
passed. The production runtime scope requirement was not weakened.
