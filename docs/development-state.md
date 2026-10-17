# Session handoff

Active delivery: [PR #163](https://github.com/e6qu/fun-with-pipes/pull/163), branch
`http-server-delivery` in the root checkout. PR #162 is accepted at `1b542f32`;
[history](roadmap-history.md) records its passing gates and verified squash.
The temporary `fwp-http-server-owners` and `fwp-closed-functions` worktrees are
inactive preparation. Work in the root; keep one delivery PR.

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
This is eligibility evidence only, not execution or lifetime acceptance. Keep
the CLI exclusion until repeated success/error requests, malformed input,
cancellation, teardown, interpreter agreement and actual no-tracing binaries
are verified across all six native hosts. Measure allocations and bounded memory
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

The focused `server-entries` runner suite also measures repeated MCP input with
collection disabled and a deliberately non-freeing control. Runtime/platform
acceptance is pending. REST/MCP HTTP/TLS memory and cancellation evidence is still
being implemented; do not publish a delivery PR from this partial preparation.
Local checks use the root guard and shared target. Lint passes after correcting
a temporary-directory argument, a fixed-size chunk lint and one caller in the
REST setup consolidation. Workflow lint and all seven test-runner checks pass.
The focused MCP test passed its raw-interpreter assertions and emitted tracing C,
then stopped at the fixed 1 GiB aggregate RSS limit during native compilation.
That execution moves to CI; no local limit was raised and it is not a passing test.
