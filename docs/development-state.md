# Session handoff

## Next action

Next: finish auditing every job in production run `39080534474`, validate the
Asyncify name-preservation repair in `39084443415`, and publish one combined
repair of [PR #164](https://github.com/e6qu/fun-with-pipes/pull/164). Keep all known
fixes together. Do not cancel healthy remaining jobs or merge a failing head.

The root checkout, branch `server-entry-delivery`, remains published at
`6b504c2e333f9c89725db714aed1440b79eab178`. It has uncommitted handoff updates and
two repaired client goldens. Prepare the combined change in
`/private/tmp/fwp-wasm-host-ownership`, branch `wasm-host-ownership`, based on that
head and published through `2e47a412732700f15b422a8dc88d5fddf5f918e8`. Preserve the
root edits when transferring the preparation. Its matching golden changes are
already committed. Other server/HTTP preparation worktrees are inactive.

The shared root `target/debug/fwp` now comes from the preparation worktree.
Rebuild before treating it as evidence for another source. All local checks use
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`.
Full builds, suites, native server compiles and large regeneration stay on CI.

Before merging, require nine production jobs and documentation on the new final
commit, plus affected functional and actual-Wasm evidence. The old helper
`/private/tmp/fwp-merge-164.py` is tied to failing `6b504c2e`; rewrite its expected
head/run checks after publication. Use one squash subject of at most 80
characters and an empty body. Verify the entire message, sole parent and tested
versus merged tree, then cancel duplicate production. Standing authorization
covers publication, fixes and merge after acceptance; no repeated permission.

## Current CI and repairs

| Run / source | Result and required action |
|---|---|
| Production `39080534474` / `6b504c2e` | Benchmarks and macOS ARM GC pass. Regular macOS ARM completes all 119 targets, with only two failed client goldens. Six other jobs remain running; audit all before the combined repair push. |
| Documentation `39080534747` / `6b504c2e` | Passes for the original head only. |
| Original focused `39080530770` / `6b504c2e` | Five hosts pass. Intel reaches 25 minutes in the last API test; all logs audited: 125 passed, zero failed, 12 ignored memory entries exercised separately. |
| Split Intel `39082660292` / workflow `1682ff88`, checked-out source `6b504c2e` | All 21 tests pass. Artifact upload fails with GitHub DNS `ENOTFOUND`; attempt 2 reruns the failed checks job. API passes. Do not accept the failed attempt or relabel its source. |
| Repaired clients `39083100171` / `9b0ca314` | All six native hosts pass ARC API, OpenAPI client and Swagger client checks. All logs audited: 18 passed, no failures or skips; both interpreter and native client halves execute. |
| Original Wasm execution `39082338822` / `0a3b9fdf` | Both Linux hosts pass six Rust tests and the loader exception check. Allocation/output evidence passes; Asyncify strips internal names, so its name search does not independently establish absence of tracing. |
| Wasm name repair `39084443415` / `2e47a412` | Queued on ARM job `117547970774` and AMD job `117547970989`. Audit both; download and inspect replacement modules before publishing the draft report. |

The production failures are `forms_client_round_trip` and `swagger_documents`:
`tests/rest/formsroundtrip.out` and `swaggerroundtrip.out` still expected
`12,used`; corrected exact-number JSON preserves the F64 spelling `12.0,used`.
Both goldens are repaired. Repository-wide search found no other stale copy.
The first local client run passed its interpreted golden but lacked OpenSSL
headers. Setting the installed `/opt/homebrew/opt/openssl@3` fixed setup, then
the native compilation reached the guard's 1 GiB RSS limit. That was not a pass;
full client verification moved to the six native hosts above.

The focused workflow now separates entry checks and API tests, retaining the
25-minute job limit. A source-pinned recheck records both its workflow revision
and actual checked-out source. Attempt-one Intel upload failure remains recorded;
its retry is job `117547135883`, with logs to audit separately.

Audit tools and results in `/private/tmp`:

- `fwp-audit-final-164.py` → `fwp164-final-audit.json` and all production job logs.
- `fwp-audit-focused-164.py` → `fwp164-focused-audit.json` for the original six hosts.
- `fwp-audit-clients-164.py` → `fwp164-clients-audit.json` for the repaired clients.
- `fwp-audit-recheck-164.py` and `fwp164-recheck-audit.json` preserve attempt one;
  adapt the auditor for attempt two without overwriting the first audit.
- `fwp-wasm-repaired-audit.json` and `fwp-wasm-repaired-JOB.log` preserve the
  original passing execution run. Audit the new binary-name run separately.

## Combined implementation

Generated REST APIs and MCP tools now use ordinary checked ARC compilation.
ARC means automatic reference counting; ownership checks reject unproved cycles
and lifetimes instead of silently using tracing. Tests cover results, aliases,
caught errors, malformed input, disconnects and normal shutdown, including
standard-input MCP and HTTP/TLS services.

Validation exposed a precision bug: an MCP I64 value of `9007199254740993`
returned as `9007199254740992.0`. `Json.Num` now retains number text until explicit
conversion to the declared type. Requests, results, error payloads, numeric IDs,
OpenAPI integer bounds and F128 values preserve their precision. Invalid manually
constructed numbers trap; encoding beyond the parser's 512-level limit reports
an error instead of silently becoming Null. YAML normalizes decimal spelling
without rounding and explicitly rejects non-finite values and oversized hex/octal
integers. Source comments, generated reference, tutorials and tests change together.

The Wasm extension admits checked tasks and browser-loader invocations. Completed
fibers save their latest State storage pointer before another task replaces the
runtime globals. Command cleanup releases scheduler records and pooled stacks.
Each loader invocation owns an instance and passes copied strings to callbacks.
Host callback exceptions, including RangeError and non-error values, propagate
unchanged without retrying a failed output callback. Actual engine stack overflow
still reports the language trap.

Two further audit repairs are included:

- Integer-only executable cache keys omitted compiler version/target and header
  search environment. Changing `C_INCLUDE_PATH` returned the old answer `41`
  instead of `42`. Every executable now includes its C compiler identity;
  exact-float programs additionally include C++ identity. The regression verifies
  that integer programs need no C++ compiler and that a third identical run
  reuses the second cache entry. Windows production now explicitly runs it;
  Linux and macOS include the whole AOT test target.
- Asyncify stripped internal function names. Seeing the exported `_start` did
  not make an empty internal tracing-name search meaningful. The collector now
  rejects nameless modules; the old artifact fails that stricter check. Asyncify
  preserves names, and runtime tests require internal `fwp_` names before the
  collector search. Rerun artifacts record actual toolchain versions. Browser
  tutorial guidance and the playground's unsupported “a fifth larger and slower”
  claim are corrected; measurements must identify their program and host.

## Measurements and focused verification

Native server evidence is retained at `8dfc014d843903e7e517e4b117cb1856732d07e9`,
tag `evidence/server-entries-20261018`, run `39078070919`. All 24 jobs were audited:
18 memory jobs pass; the six functional jobs exposed two stale inline CSV
assertions subsequently fixed. Later full production found the two separate
client goldens repaired above. No failed target was hidden by accepting only an
earlier successful check.

The [server report](measurements/server-entries-2026-10-18.json) records all six
native hosts: 18 ARC binaries exclude tracing, 24 tracing controls retain it.
Standard-input freeing modes end with zero counted bytes. HTTP storage remains
flat through 15,360 requests per case; maximum settled resident-memory growth is
2 MiB. Remaining per-request costs are substantial: approximately 237 allocations
and 458 count increments for standard-input MCP, 874/2,426 for REST and 797/1,970
for HTTP MCP. These compare same-revision fwp memory modes, not C/Rust speed.
[The benchmark guide](benchmarks.md#generated-rest-and-mcp-server-memory) explains
inputs, scopes and exclusions. Later Wasm runtime and cache changes do not make
the combined source identical to the measured source; do not relabel old evidence.

Artifacts: `/private/tmp/fwp-server-entry-evidence/39078070919` (1.54 GiB).
Guarded download/collection passed in 91.25/2.92 seconds. Collector:
`scripts/summarize-server-entries.py --artifacts DIR --llvm-bin DIR --output FILE`.
Downloaded executables and modules are inspected as data, never executed locally.

Original Wasm source `0a3b9fdf4aaffdf7d51f42aba8752720d9ae819f` is tagged
`evidence/wasm-host-owners-20261018`. Both actual-Wasm jobs pass 16 repeated rounds
of captured strings, repeated awaits, results, scoped errors, queued values,
cancelled senders/receivers, State and task maps. Ordinary and measured O1/O2
modules run through WASI and the browser loader, each with JSPI and Asyncify.
JSPI lets the host suspend the module's stack; Asyncify rewrites code to save it.
Outputs match raw interpretation. Sequential, concurrent, reentrant and throwing
callbacks are checked separately, including output from a suspended child.
These are Node-hosted checks, not evidence from actual browser engines.

Missing State cleanup reproduces a leak of 16 buffers / 2,048 bytes. Omitting
scheduler cleanup leaves 64 pooled 1 MiB task stacks plus its root record:
67,109,088 extra requested bytes. Both controls fail as intended. Ordinary
modules start with about 32 MiB linear memory; Asyncify adds a 16 MiB plus one
page workspace. Returning allocations permits reuse, but does not shrink memory
capacity. Counts exclude the JavaScript engine's own storage and resident RAM.

The uncommitted Wasm report currently describes the original 72 modules. Replace
it after `39084443415` passes; the stricter collector intentionally rejects the
old stripped modules. Original artifacts are
`/private/tmp/fwp-wasm-host-evidence/39082338822`. Use
`scripts/summarize-wasm-hosts.py --artifacts DIR --audit AUDIT --output FILE`.
Record the new exact source and a new immutable tag; preserve the old source ID.

Recent guarded local checks:

- Exact-number JSON/CSV fixtures agree in raw interpretation and native ARC O2
  and stressed tracing O1/O2: all 20 executions pass (40.73 s including rebuild).
  JSON/YAML unit tests, OpenAPI limits, tutorial output checks and generated
  standard-library documentation also pass.
- Native task ownership controls pass (18.29 s). Browser/WASI entry acceptance
  and cycle rejection pass (19.60 s). The child-output fixture matches its golden.
- Tiny locally built Wasm modules reproduce the old output-callback retry and
  verify the loader repair and actual stack-overflow reporting (0.14/0.15 s).
- `cargo test --test aot integer_cache_tracks_header_search_paths -- --exact`
  reproduces stale output (2.49 s), then passes after repair (19.28 s).
- `cargo test --test aot programs_are_interpreted_without_a_c_compiler -- --exact`
  passes (1.46 s). Existing missing-compiler behavior remains intact.
- `cargo clippy --lib --bin fwp --test aot --test wasm_arc -- -D warnings`
  passes after the final code changes (6.05 s). Rust formatting passes (1.27 s).
  Numerics workflow lint passes (1.38 s); Windows workflow lint passes (0.15 s).
  Tutorial/source consistency passes (16.47 s including rebuild); the roadmap,
  links and commit-message audit passes (2.54 s).

A previous guard refusal below 64 GiB was resolved by removing only the redundant
HTTP-client artifact download after verifying its six unexpired GitHub artifacts
and committed report. Current server evidence remains. No limits were raised.

## Accepted foundation

[PR #163](https://github.com/e6qu/fun-with-pipes/pull/163) is accepted at
`0a468c9d0ee3283bd5de6a7cbc05126379ed3ee5`. All nine production jobs and docs passed
on `c998ce68`; every target was audited. Squash message, sole parent and tested
versus merged tree were verified. Duplicate production `39079288609` was cancelled.
[History](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records accepted HTTP owners and fixed function storage.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Combined server/Wasm acceptance, remaining host owners and tracing removal |
| 2 | In progress | Remove functional intermediates and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |

All seven [plan](../PLAN.md) areas remain open. Actual browser engines, retained
foreign callbacks and other unproved boundaries still need ownership work.
JIT is excluded, not deferred. Historical preparation anchors are evidence,
not additional tasks. Follow [AGENTS.md](../AGENTS.md) and update this handoff
with actual checks, unresolved failures and one next concrete action.
