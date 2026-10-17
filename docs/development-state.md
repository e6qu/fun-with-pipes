# Session handoff

Active delivery: [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163), branch
`http-server-delivery` in the root checkout. PR #162 is accepted at `1b542f32`;
[history](roadmap-history.md) records its passing gates and verified squash.
The temporary `fwp-http-server-owners` and `fwp-closed-functions` worktrees are
inactive preparation. Keep the delivery head stable in the root while its CI
finishes. Independent next-batch work is in `/private/tmp/fwp-server-entries`,
branch `server-entry-ownership`; it is not a second delivery PR.

## Next action

Next: monitor the final [PR checks](https://github.com/e6qu/fun-with-pipes/pull/163/checks)
for the combined repair, measured compiler change and evidence update. Require
all nine production jobs plus documentation on that exact head before merging.
Implementation `6c197fed` first passed focused validation on preparation branch
`http-server-validation-20261018`; this delivery adds the finished measurements,
documentation and CI maintenance without changing compiler/runtime/library code.

The original [production run](https://github.com/e6qu/fun-with-pipes/actions/runs/39066387403)
at `b5391748` is complete and fully audited. All 960 targets scheduled by the
native test runner finished; all 1,240 test summaries across the nine jobs were
checked. Only two targets failed: gRPC injection on Linux, Windows and macOS
stress, plus UDP injection in both macOS stress jobs. Both are repaired. Regular
macOS, benchmarks and documentation passed. No original failure remains unexamined.

The [combined repair checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39070605233)
pass on all six native hosts: all three gRPC, UDP and readiness targets, 11 tests
per host, plus formatting and lint. Complete logs were audited. The workflow now
includes the existing exact architecture/script Windows dependency cache to
avoid repeating TLS builds in future runs. Deprecated Node 20 action runtimes
are replaced by `setup-node@v7` and `cache/restore`/`cache/save@v6` throughout CI.
Node 24 and exact dependency cache keys remain explicit; automatic npm caching
is disabled. Workflow lint passes after the updates (1.68 s).

After publication, require all nine production jobs and documentation for the
exact final head. Squash with an explicit one-line subject of at most 80 characters
and empty body; verify tree, parent and whole message, then cancel duplicate
postmerge production. Keep all coverage and fixed resource/time limits.

## Repairs and their verification

- The gRPC test injected a writer failure by matching a statement that the new
  HTTP server also emits. Scope injection to the gRPC reader body and require one
  match there. The original ARM macOS stress and both Windows TLS logs show this
  failure; every other completed Windows TLS target passes.
- The UDP failure test counted a scheduler scratch allocation as one of three
  returned objects. Force real socket-readiness retries, warm up persistent
  scheduler storage, and inject separately into the socket header and each
  returned object. Keep all broken-cleanup controls. On non-Linux hosts, restoring
  the old global ordinal must reproduce the fourth-failure error. Save failure
  source, executable and output before assertions; production now uploads them.
- The new golden fixture needed its function-result type formatted consistently;
  the focused WASI test had one needless borrow. Both are corrected. The binary
  inspector now handles Mach-O section selection directly and invalidates unknown
  stack-derived addresses when checking Linux startup stores.

Local commands use `python3 scripts/local-guard.py COMMAND...`, serially:
`env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 cargo test --test grpc_server_connections -- --nocapture`
passed in 35.34 s. Its first attempt lacked the documented OpenSSL path and failed
to compile. `cargo test --test udp_ownership udp_construction_aliases_and_partial_receives_release_every_owner -- --exact --nocapture`
passed in 28.33 s, then 43.48 s with the integrated compiler and rebuild: all 16
cleanup cases and the restored-ordinal control. Changed harness/library lint,
Rust and fwp formatting passed. Latest workflow lint passed in 2.09 s.
The report validator `python3 scripts/compare-fixed-functions.py` checked both
Linux comparisons and all six memory artifacts in 0.20 s. An initial sandbox
attempt could not run the guard's process sampler; the same guarded command
passed with process access, without changing limits.

## What this delivery changes

HTTP connections, requests, escaped stream handles and tasks have explicit owners.
Tasks borrow the connection's live handler. A 24-byte request handle replaces
separate 32-byte handle and job allocations. Typed cleanup and fresh callback
State/AD scopes preserve failure handling and isolation. ARC rejects channels
containing stream handles because they can create a handler cycle; other aliases
remain supported. The nonescaping 64 KiB receive buffer uses the stack; actual
Linux serve frames are 67,240 bytes on AMD64 and 67,264 on ARM64, excluding callees.

macOS/Windows socket waits use OS readiness and real deadlines, replacing periodic
10 ms sleeps. Wait records unlink before cancellation; readiness storage is
allocated before registering them, so allocation failure cannot leave a dangling
link. Linux epoll is unchanged. Keeping one copy of an existing ARC ownership
check reduces Linux HTTP instruction sections about 13%, without removing checks;
the [code-cost report](measurements/entry-check-code-costs-2026-10-17.json) makes
no speedup claim for that change.

The compiler also shares function records whose captures are all fixed functions
with no captures of their own. Runtime data and effectful evaluation keep their
ordinary ownership. No language syntax changes. Compiler, runtime and library
sources match measured revision `85988056`, retained by immutable tag
`evidence/http-fixed-functions-20261018`; the fixture-format correction changes
no compiler behavior. The [design](design.md) explains eligibility and startup.

## Completed evidence

- [Original server memory](measurements/http-server-owners-2026-10-17.json): all
  six hosts pass. All 60 saved binaries were inspected. Five hosts passed the
  combined functional job; Intel exceeded its 25-minute scheduling limit.
  [The split rerun](https://github.com/e6qu/fun-with-pipes/actions/runs/39066088716)
  passes all 15 ownership targets, 40 native and 10 interpreter comparisons and
  client-memory checks, preserving every case and the limit.
- [Compiler focused checks](https://github.com/e6qu/fun-with-pipes/actions/runs/39068683031):
  all six native hosts, both Linux GCC checks and both WASI jobs pass. Full logs
  contain 34 successful target summaries, 72 executing tests and no failures.
- [Final allocation, timing and memory report](measurements/fixed-functions-2026-10-18.json):
  approximately 899 to 722 allocations and 2,318 to 1,901 count increments per
  additional HTTP request; 177 fixed-function allocations and 3,808 payload bytes
  removed. Paired Linux runs show 4–6% less elapsed time for this workload versus
  the older fwp compiler, not C/Rust parity. The report retains inputs, hardware,
  flags, raw samples, startup, code/data size and measurement boundaries.
- All six final memory jobs pass: 36 managed rows, 20 persistent-server RSS rows
  through 20,480 calls per case, and 48 ownership-check rows per host. Final managed
  storage stays flat; maximum post-warm-up RSS increase is 2 MiB within the 8 MiB
  bound. All twelve ordinary binaries contain 331 aligned static records totaling
  7,592 bytes. Linux instructions match all 618 startup capture stores; deliberately
  wrong captures are rejected on both architectures. ARC binaries omit tracing;
  tracing controls retain it. Downloaded binaries were inspected, never executed.

Raw evidence is under `/private/tmp/fwp-server-evidence`,
`/private/tmp/fwp-function-profile` and `/private/tmp/fwp-static-server-memory`.
The complete original-job audit is `/private/tmp/fwp163-production-audit.json`.
Audit logs include `/private/tmp/fwp-audit-*.log`,
`/private/tmp/fwp-fixed-functions-repaired-all.log` and the original production
failure logs `/private/tmp/fwp163-*`. These focused results do not replace final
production acceptance. All newly discovered failures remain work to fix now.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server acceptance, remaining host owners and tracing removal |
| 2 | In progress | Remove functional intermediates and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |

All seven [plan](../PLAN.md) areas remain open. Browser, asynchronous WASI,
REST/MCP entries and retained host callbacks remain ownership work. After this
delivery's acceptance, extend checked ownership to generated REST/MCP entries.
Isolated preparation is in `/private/tmp/fwp-server-entries`, branch
`server-entry-ownership`; do not publish a second delivery PR before #163 merges.
Both use ordinary fwp server code: a guarded compile-only API probe already
accepts the full REST API fixture (5.28 s) and a two-tool MCP fixture (3.23 s).
These initial probes establish eligibility only. Do not claim entry-mode
acceptance until repeated success/error requests, malformed input, cancellation,
teardown, interpreter agreement and actual no-tracing binaries are verified
across all six native hosts. Measure allocations and bounded memory
for REST HTTP/TLS and MCP standard-input/HTTP modes before claiming support.
Historical preparation entries are not new tasks.


## Isolated REST/MCP preparation

This preparation branch enables ordinary checked compilation for generated REST
and MCP entries; the existing ownership/cycle checks still apply. Browser and
asynchronous WASI boundaries remain excluded. A shared fixture returns aliases,
raises errors, delays replies and requests normal shutdown. Added checks compare
MCP replies with the raw interpreter, reject channel cycles and reuse the full
REST API/authentication/form cases. The new integration target is assigned to the
macOS GC shard and Windows TLS stage; existing targets stay in their original jobs.

The focused `server-entries` suite has four independent parts per native host,
all with the existing 25-minute limit: functional checks, standard-input memory,
REST HTTP/TLS memory and MCP HTTP memory. The standard-input check includes a
deliberately non-freeing control. HTTP checks compare raw-interpreter responses,
wait for a decoded-input handler marker before disconnecting, and shut down
normally. Memory jobs retain ordinary/instrumented C and executables, source
hashes, raw counters and process-memory samples. They compare tracing and ARC
at one revision; they make no timing or C/Rust parity claim. Six-host execution,
binary inspection and delivery acceptance remain pending.

The initial Linux probe is run `39073691495` at preparation `aa4da981`; generated
entry/ownership, complete REST API/authentication/form and MCP memory checks
pass. The complete log has four passing target summaries and eight executing
tests. MCP final managed bytes are zero in both freeing modes for 1/16/128 input
cycles; the deliberately non-freeing control grows from 57,344 to 7,075,680 bytes.
The expanded six-host HTTP/standard-input suite at `d2222bf8` passes all 24 jobs:
[run 39075061445](https://github.com/e6qu/fun-with-pipes/actions/runs/39075061445).
The complete log audit records 36 passing summaries, 66 executing tests and no
failures. The 12 ignored measurement entries in functional jobs execute in their
separate memory jobs. The audit is `/private/tmp/fwp-entry-baseline-audit.json`;
all 24 logs are `/private/tmp/fwp-entry-baseline-JOB.log`. This is baseline
evidence before the numeric repair below, not final acceptance.
The CLI help's incorrect claim that every
server accepts TLS flags is corrected: generated MCP supports plain HTTP and
standard input; REST and split services accept the documented TLS options.

Local checks use the root guard and shared target. Focused Rust lint passes
(0.27 s latest), workflow lint passes (1.29 s), and client type checking passes
(0.76 s). The new client fixture initially needed formatting; it is corrected.
A serial raw-interpreter HTTP/TLS probe passes in 7.65 s, checking success/error
statuses, the plaintext disconnect marker and normal shutdown. Full response
values are asserted by the runner tests. The earlier focused MCP test passed
its raw-interpreter assertions and emitted tracing C, then stopped at the fixed
1 GiB aggregate RSS limit during native compilation. That execution moved to
CI; no local limit was raised and the stopped test is not a passing test.

The initial artifact was downloaded to `/private/tmp/fwp-entry-initial-artifact`.
The new collector validated all nine raw rows and inspected all three Linux AMD64
executables in 0.27 s: ARC excludes tracing symbols and both tracing controls
retain them. Downloaded binaries were read as data, never executed. The initial
workload averages 233.125 allocations and 457.625 actual retains per additional
reply in both freeing modes; this includes malformed inputs and notifications
in each eight-reply cycle. It is a preliminary one-host cost, not the finished
six-host report.

### Exact JSON number repair

A guarded raw-interpreter MCP `copy` call sent `9007199254740993` in an I64
list and returned `9007199254740992.0` (2.13 s reproduction). Both incoming
arguments and outgoing results passed through `Json.Num F64`; typed F128 values
could lose precision for the same reason. The repair stores number text in
`Json.Num String` until an explicit
numeric conversion, shares one exact Rust JSON representation between typed
and untyped parsing, and updates constructors and examples. Invalid manually
built numeric text traps consistently. YAML normalization and OpenAPI bounds
also avoid F64 conversions; request IDs retain their original numeric spelling.
`json.encode-value` now traps at the existing 512-level parser limit instead of
silently returning Null. The documentation generator has refreshed the library
reference from its comments. Rerun memory measurements after this representation
change. The complete baseline audit above finished before publishing this repair.
Next for this batch: dispatch all 24 `server-entries` jobs on the repaired head,
inspect all results and saved binaries, then prepare the single next delivery
after PR #163 merges. Require fresh measurements for the new number storage and
updated workload; do not compare its counts with the lossy baseline as equivalent
work.

Focused verification: two Rust JSON tests and all nine YAML tests pass (latest
YAML check 0.20 s). YAML preserves decimal spelling without rounding and reports
non-finite values or hexadecimal/octal integers beyond U128 as explicit errors.
Quoted strings remain strings. Guarded raw interpretation validates nested signed and
unsigned 64/128-bit values, F128 values at 2^53+1 and 1+2^-100, both invalid-number
encoders, and MCP success/error payloads and large numeric IDs against independent
Python integer/Decimal checks (4.40 s). The ordinary typed-JSON golden changes
only the displayed Num payload from a float to quoted text; that exact diff was
checked before updating it (1.56 s). Eight focused JSON library tests pass.
Native ARC O1 and O2 and tracing O1/O2 with GC/reuse stress passed the first
exact-number fixture. The strengthened near-one case passes ARC O2 and tracing
O1/O2, including the existing malformed-number cases (10.12 s).
Both malformed-number native encoders passed in ARC O2 and stressed tracing O1.
The embedded-library rebuild passes (16.34 s), and the depth-limit interpreter
exits 101 with the intended message. Native ARC O2 depth execution matches
(0.26 s). The largest balanced-integer OpenAPI bounds are exact (0.62 s); the
existing API document is unchanged (0.89 s). The MCP tutorial was checked with
its actual jq command, and now shows the retained F64 spelling `212.0` (2.19 s).
Five OpenAPI checks pass, including all existing document goldens and exact
balanced-integer bounds (25.81 s including the Rust rebuild). The language-server
integration test passes (4.86 s). Changed fwp examples/fixtures pass formatting
(0.01 s), and workflow lint passes (1.64 s).
The generated library reference check passes (1.35 s), document-import errors
pass (0.38 s), and all six documented HTTP tutorial responses match raw
interpretation (1.33 s). Metadata now records measurement-helper and workflow
hashes as well as compiler, runtime, library and fixture sources.
All server/native builds that exceeded the local guard remain on CI.

Commands are guarded from the root: `cargo test --lib json::tests`,
`cargo test --lib yaml::tests`, `cargo clippy --lib --bin fwp --test server_entry_ownership --test rest --test lsp --test arc_extensions -- -D warnings`
(latest 6.20 s), `fwp test --interp lib/json.fwp`, and the independent checks
`python3 /private/tmp/fwp-json-exact-check.py` and
`python3 /private/tmp/fwp-check-json-native.py`. `fwp` in these commands is the
root `target/debug/fwp`, rebuilt from this preparation worktree. The JSON tests
initially found an outdated YAML scalar assertion; the corrected expectation is
explained above. Temporary harness-edit/type errors were fixed before rerunning.

Both invalid-number fixtures now discard the encoded result between visible
`before` and `after` outputs. Raw interpretation, ARC O2 and stressed tracing
O1/O2 print only `before` and then trap (8.87 s), proving that optimization keeps
the call and its order. The temporary harness first enabled tracing-only reuse
verification in ARC; that unsupported setting was corrected before the passing
run. No compiler workaround or resource limit change was needed.
