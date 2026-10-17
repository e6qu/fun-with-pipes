# Session handoff

## Next action

Next: publish the consolidated CSV repair, regression coverage and completed
memory evidence, run all six functional jobs with `server_entry_part=checks`,
and open the next substantial PR from `server-entry-delivery` in the root checkout. No delivery PR is open.
Keep one current head; fix every discovered failure and audit every completed
job before a repair push. Require all nine final-head production jobs and docs
before squash merge.

## Accepted foundation

[PR #163](https://github.com/e6qu/fun-with-pipes/pull/163) is accepted at
`0a468c9d0ee3283bd5de6a7cbc05126379ed3ee5`. All nine production jobs and docs
passed on `c998ce68`; every completed target and test summary was audited.
The entire squash message, sole parent and identical tested/merged tree were
verified. Duplicate production `39079288609` is confirmed cancelled.
[History](roadmap-history.md#http-server-owners-and-fixed-function-storage-pr-163)
records its changes, measurements and exact acceptance evidence.

## Current delivery

Work in the root checkout on `server-entry-delivery`. Its three transferred
preparation commits are `5f83174b`, `6f522b00` and `ae79bc6b`, based on the accepted
#163 squash. Before the pending documentation/CSV expectation changes, its tree
was verified identical to measured preparation `8dfc014d843903e7e517e4b117cb1856732d07e9`,
retained by published tag `evidence/server-entries-20261018`.
The `/private/tmp/fwp-server-entries` worktree and older HTTP worktrees are now
inactive; the root contains the current handoff and pending repair.

Generated REST APIs and MCP tools now use ordinary checked ARC compilation.
ARC means automatic reference counting; these builds omit tracing collection
while retaining the ownership and cycle checks. Browser and asynchronous WASI
boundaries remain excluded. No new language syntax or compatibility adapter is
introduced. CLI help now correctly distinguishes REST TLS options from MCP's
plain HTTP and standard-input transports.

Validation found a precision bug: an MCP call sent I64 `9007199254740993` and
received `9007199254740992.0`. Untyped JSON converted every number to F64.
`Json.Num` now stores number text until an explicit numeric conversion. Incoming
arguments, results, caught-error payloads, numeric request IDs and OpenAPI integer
bounds preserve their precision. Rust typed and untyped parsing share one exact
representation. Native parsing gives each stored number string an ordinary owner.

Invalid manually constructed number text traps. `json.encode-value` also reports
the existing 512-level parser limit instead of silently returning Null. YAML
normalizes decimal spelling without rounding, and rejects non-finite numbers or
hexadecimal/octal integers beyond U128 with explicit errors. Source comments,
generated library docs, examples and tutorial outputs are updated together.

### Runner validation and measurements

[Run 39078070919](https://github.com/e6qu/fun-with-pipes/actions/runs/39078070919)
finished on exact source `8dfc014d`. All 24 logs were audited before the next
repair push: 54 test summaries, 132 passed tests and six failures. All 18 memory
jobs pass. Every functional job fails only on the same stale CSV expectation;
all its other ownership, numeric and schema checks pass. The two ignored memory
entries in each functional job execute in the separate memory jobs. No failure
is unexamined. Audit: `/private/tmp/fwp-entry-repaired-audit.json`; auditor:
`/private/tmp/fwp-audit-entry-repaired.py`.
There are four jobs per native host, each retaining the existing 25-minute limit:

- Functional results, aliases, caught errors, malformed inputs, ownership
  rejection, exact numeric payloads, disconnects and normal shutdown.
- Repeated MCP standard-input requests, including a deliberately non-freeing
  control that must grow while both freeing modes remain bounded.
- REST HTTP/TLS memory and response checks.
- MCP HTTP memory and response checks.

HTTP measurements compare ordinary and counted native responses with a raw
interpreter. They use 1/16/128 cycles with three fresh samples, then persistent
servers through 15,360 requests per case. After warm-up, sampled resident memory
must stay less than 8 MiB higher. Counts include server startup and background
work; transport/TLS/allocator storage and client memory are excluded from managed
counters. These are same-revision tracing-versus-ARC measurements, with no timing
or C/Rust parity claim.

The earlier [24-job baseline](https://github.com/e6qu/fun-with-pipes/actions/runs/39075061445)
at `d2222bf8` passed. All logs were audited before the repair push: 36 successful
test summaries, 66 executing tests, no failures. The 12 ignored entries in
functional jobs execute in the separate memory jobs. Audit:
`/private/tmp/fwp-entry-baseline-audit.json`; logs:
`/private/tmp/fwp-entry-baseline-JOB.log`. This older lossy representation is not
acceptance for the repair. Its counts are not an equivalent-work comparison
with the updated numeric workload.

The [completed report](measurements/server-entries-2026-10-18.json) validates
9 standard-input rows, 54 HTTP rows, 30 resident-memory samples and 7 executable
files per host. All 18 ARC files exclude tracing; all 24 tracing controls retain
it. Each file has its artifact path, architecture, section sizes and fingerprint.
Downloaded executables were read as data, never run locally. Standard-input
freeing modes end at zero counted bytes; HTTP final storage stays flat and the
largest settled RSS increase is 2 MiB. The [guide](benchmarks.md#generated-rest-and-mcp-server-memory)
explains inputs, measurement scope and remaining allocation/count costs.

Artifacts: `/private/tmp/fwp-server-entry-evidence/39078070919` (1.54 GiB).
Guarded download passed in 91.25 s; guarded collection/binary inspection passed
in 2.92 s. LLVM tools are in
`/Users/zardoz/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/aarch64-apple-darwin/bin`.
Use `scripts/summarize-server-entries.py --artifacts DIR --llvm-bin DIR --output FILE`.
Compiler/runtime/library and existing measurement behavior still match `8dfc014d`.
Only the test file's added codec regression, workflow part selector and collector's
explicit artifact-path labels differ among the recorded source files. Preserve
the original measured source instead of relabeling this evidence as a new run.

### Completed local verification

All local checks use the root `scripts/local-guard.py`, serially. The current
`target/debug/fwp` was rebuilt from the root delivery branch.

- Focused Rust lint passes (6.20 s); Rust/fwp formatting, workflow lint and
  the roadmap/link audit pass. The generated library reference is current. The tutorial source-consistency
  check also passes (1.52 s).
- Two JSON unit tests and all nine YAML tests pass. Five OpenAPI checks pass,
  including existing goldens and exact integer bounds (25.81 s including rebuild).
  Document-import errors and the language-server integration test also pass.
- Raw interpretation independently verifies signed/unsigned 64/128-bit values,
  F128 at 2^53+1 and 1+2^-100, numeric IDs and MCP success/error payloads against
  Python integer/Decimal expectations (4.40 s). Eight JSON library tests pass.
- Native ARC O1/O2 and stressed tracing O1/O2 pass the exact-number checks;
  the strengthened near-one case passes ARC O2 and tracing O1/O2 (10.12 s).
  Both invalid encoders preserve traps and output order even when their results
  are discarded: raw interpretation, ARC O2 and tracing O1/O2 pass (8.87 s).
  The depth-limit trap also agrees between interpreter and native ARC O2.
- All six documented HTTP tutorial responses match raw interpretation (1.33 s).
  The MCP tutorial was checked with its actual jq command and now shows `212.0`.

The first large native MCP build hit the guard's 1 GiB aggregate RSS limit and
moved to CI; it was not counted as a pass and no limit was raised. An outdated
YAML expectation was corrected to the explicit numeric rules above. A temporary
trap-order harness initially enabled tracing-only reuse verification in ARC;
its setting was corrected before the passing rerun. No unresolved local failure
is being deferred. Large native server builds and full suites remain on runners.

Temporary independent probes are `/private/tmp/fwp-json-exact-check.py`,
`/private/tmp/fwp-check-json-native.py`, `/private/tmp/fwp-json-trap-order.py`
and `/private/tmp/fwp-json-tutorial-check.py`. Run them through the root guard.
The exact typed-JSON golden was changed only for the new quoted Num payload.

### CSV expectation repair

The repaired JSON representation retains F64 spelling in REST CSV responses.
All six native hosts returned `12.0` where the test still expected
`12`. Both affected assertions, including the later curl assertion, are corrected.
The complete interpreted forms/content-negotiation suite passes (4.79 s), and a
new CSV fixture verifies I64 `9007199254740993`, F64 `12.0` and F128 near one in
raw interpretation and native ARC/stressed tracing O2 (11.06 s). Its first draft
had an unindented continuation pipe; it was corrected before verification.
Formatting then passes. The persistent regression test now runs all five JSON/CSV
precision and trap fixtures in raw interpretation and native ARC O2/tracing O1/O2:
all 20 executions pass under the guard (40.73 s including rebuild).
The docs explain the retained spelling. Full native
server verification stays on runners. With the complete audit finished, explicitly select
`server_entry_part=checks` to rerun all six affected functional jobs. Compiler,
runtime, library and existing memory-test behavior are unchanged by this repair;
retain passing memory evidence at its original source, rather than regenerating
it as a new measurement. Final production acceptance remains required. Logs are
`/private/tmp/fwp-entry-repaired-JOB.log`.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server-entry acceptance, remaining host owners and tracing removal |
| 2 | In progress | Remove functional intermediates and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |

All seven [plan](../PLAN.md) areas remain open. Browser, asynchronous WASI,
retained host callbacks and other unproved boundaries remain ownership work.
JIT is excluded, not deferred. Historical preparation entries are evidence,
not additional tasks. Follow [AGENTS.md](../AGENTS.md) for delivery and resource
limits, and update this single handoff after meaningful progress.

Latest guarded lint of the changed Rust tests passes (6.29 s); workflow lint
passes (1.48 s). Documentation checks pass after removing obsolete pending-work
claims and recording #163 acceptance. All commit messages remain one line, no
more than 80 characters, without bodies, trailers or attribution.
