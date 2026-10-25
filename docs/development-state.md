# Current work

**Next:** finish the G4 mapping for remaining tracing/poisoning-only tests,
starting with unwind and scoped-file probes, then run combined G3/G4 validation. The callback
implementation and integration tests are prepared, including actual library
unload; candidate Rust/C generation and platform validation have not run.
Keep this as one PR. Do not restart the old publisher or launch a partial full
matrix before the included implementation is ready.
Worktree `/private/tmp/fwp-ownership-fault-matrix`, branch `ownership-fault-matrix`.
Committed preparation: `517de6e1`; accepted roadmap: `f850cafe`; batching policy:
`14acc686`. Checkpoint `87662ee5` adds weak channels and G4 probes; integrated
compiler/platform validation is pending.
The accepted direction is inferred moves/borrows, count-free unique storage,
ARC for sharing, explicit weak links, and rejection of unproved owning cycles.
Preserve returned functions and partial application. Current APIs may change.
G3 and G4 must be in the same PR. Keep it draft until both and all other included
changes are complete. During development run only checks justified by a changed
contract or specific issue; do not rerun passing suites or full CI per edit.
Then perform one consolidated local validation under the existing resource guard
and the full final-head CI matrix. Record any workloads moved to CI because they
cannot fit local limits. Add tests with the code; defer broad execution, not
coverage. Include G5 in the same group where practical.

The follow-on publisher PID 46922 was stopped on October 25 at the user's request
to consolidate this work. Its status is `stopped-for-combined-gc-removal` in
`/private/tmp/fwp-fault-matrix-delivery-status.json`. Do not restart the old script:
it would prematurely publish and merge the earlier preparation. The separate
#214 watcher may finish its existing validation and verified merge.

## Last delivery

PR #214 passed all nine production jobs in
[40187394961](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394961)
and [documentation 40187394939](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394939).
The watcher verified its squash merge at 13:19 UTC on October 25:
`6ee33396459986a0fa08464b182d23fd2fe6c136`, subject
`Check native ownership without retaining freed storage`, empty body, tree
`91f1a23c02328554986d703bf48fdf84a27e85c7` matching tested head
`1591ec72553a1168bc52d5745d1865059c15fede`.
Status: `/private/tmp/fwp-214-merge-status.json` (`merged-and-verified`).
Do not restart that watcher. Reparent this preparation onto the verified merge
before publication; its commit object has not yet been fetched into this local
repository. The old follow-on publisher remains stopped.

Postmerge documentation `40197117071` passed. Duplicate production run
`40197117132` has the same verified merge tree. Its completed jobs (benchmark and
both macOS ARM64 jobs) passed; no failed job was reported. Cancellation was
requested through GitHub to avoid repeating the full matrix. The last API check
reported `in_progress` at that time. A later API check confirmed
`status: completed`, `conclusion: cancelled`.
No full CI has been launched for the later G3/G4 preparation.

## Candidate weak channels and G4 repairs

`WeakChannel[a]`, `channel.downgrade` and `channel.upgrade` now have interpreter,
ownership-contract and native-runtime implementations. Metadata expires before
queued child destruction; upgrade allocates its result before retaining the target.
Weak edges are not owning edges. Acquired channels return to the existing
conservative capture/store checks. Programs using weak channels preserve original
channel-owner frames so optimization cannot change expiration. Tracing builds
reject weak channels during the transition; tracing has not been deleted.

Tests added to existing targets cover raw/optimized interpreter/native outputs,
dynamic/static storage, failure/cancellation, returned captures, strong-cycle
rejection, metadata cleanup, address reuse and allocation failure. Missing
expiration, missing metadata release and an incorrectly early retain have separate
fault controls. Weak equality now compares target identity in the interpreter,
including after expiration; wrappers must not change equality.

G4 now instruments foreign callback entry/cancellation with the live-allocation
ledger and adds the weak fixture to WASI JSPI/Asyncify checks. The WASI physical
allocation observer had a duplicate-detection bug: it stopped at an empty slot
before examining later live entries. It now scans all occupied slots, reuses the
first hole, and trims its high-water mark. A native/WASI regression test checks
duplicate registration, duplicate removal and ordinary reuse. These integrated
tests are written but have not yet run with the modified compiler.

## Candidate retained C callbacks

`--c-callback NAME` explicitly selects a C export when building a native checked
ARC library. Registration copies leading arguments once; invocation supplies the
last argument. One host owner and an active-call count govern the context.
Close prevents entry; release consumes the host owner; active calls defer capture
and context destruction until return or unwind. All library calls and releases
use the first caller's OS thread. Owned results use existing result-release
functions and can survive registration release. Arbitrary closure-valued C APIs
and scoped callbacks retain their existing restrictions. See the
[contract and example](retained-callbacks.md).

`tests/retained_callbacks.rs` and its three fixtures cover a separately compiled
host/header, static and shared libraries at O1/O2, repeated real unload, 8/1,024
rounds, nested release, language error, task cancellation, partial construction,
allocation failure, invalid result pointers, wrong-thread entry and outstanding
registrations at unload. Independent omitted capture/context/active-call/root
cleanup controls are included. The target is assigned to macOS regular and the
Windows native list; integrated execution is pending.

The focused integration probe exposed library scheduler-root storage that was
only reclaimed with the complete heap reservation. `fwp_library_tasks_finish`
now releases empty State scratch and the root explicitly before clearing its
pointers. Source review also found idle Linux descriptor-wait metadata relying
on heap teardown when the external host keeps its descriptor open. Both native
and library shutdown now release that metadata after all waiters finish; the
new Linux fault control removes a waiter release and requires status 205. The
final allocation ledger can verify these owners before bulk allocator teardown. This applies to ordinary libraries too.

Focused checks under `scripts/local-guard.py`:

- Verified #213 compiler: `check tests/fixtures/retained_callbacks.fwp` and
  `build --gc arc --staticlib --emit-c` passed. This checks source typing and
  existing ARC admission, not the candidate registration flag/generator.
- `/private/tmp/check-fwp-retained-runtime.py`: candidate context runtime in
  saved #213 C, Clang O2, 1,024 nested-call rounds. Normal 0; premature teardown
  242; omitted capture/context release 241; omitted active completion 243.
- `/private/tmp/check-fwp-retained-integration.py` adapts saved #213 export bodies
  to the new protocol and uses the candidate runtime/probe. It does not compile
  candidate Rust or establish GCC/platform support. Its first run found the root
  teardown mismatch (205); after explicit root cleanup the 1,024-round Clang O2
  rerun passed, including errors, cancellation and injected allocation failures.
- `/private/tmp/check-fwp-callback-preparation.py` passed Rust formatting,
  whitespace and native scheduling audit: all 254 integration targets assigned,
  including the new target on macOS and Windows. No suites were run.
- `python3 scripts/check-roadmap.py` passed after staging the new guide:
  161 doc link sets, 106 preparation pairs/tags and eight roadmap steps.
- After waiter cleanup changed, the focused Clang O2 integration probe passed
  again. Linux-specific waiter execution is pending the native Linux runners.

## Direct C-library diagnostics

After callback checkpoint `d276d112`, `library_input_ownership` and
`library_result_ownership` now retain their tracing/poisoning runs and add ARC
runs using allocation identity. Their checks no longer infer physical release
from a zero count in ARC. The result test checks liveness before reading a
potentially prematurely freed result. Failed assertions exit immediately so
library teardown cannot replace their specific fault status with a later leak
status. The ARC duplicate-release control requires the ledger's status 203.
Both test executables now have explicit `.exe` names for Windows.

Their independent signature-error tests no longer reset the process-global
native settings: those errors occur before generation, and concurrent resets
could change the positive test's selected ownership mode. Formatting passed;
the new executions remain part of the pending combined validation.

The user's API clarification is now explicit in AGENTS.md and PLAN.md: every API
may break, and builds must not depend on a previous fwp version or self-hosting.
The saved #213 executable used for optional bounded development probes is not a
repository build dependency. Production builds compile the current Rust sources.

## Prepared group

[The diagnostic guide](ownership-diagnostics.md#borrow-child-and-reuse-fault-matrix)
maps capture, typed-argument, reuse-token, variant-payload and stack-child faults
to their observers. ARC probes check live allocation identities as well as physical
bytes. Stack children now have 8/1,024-round dynamic/static checks; a missing release
must fail. Duplicate closure destruction must stop before accessing dead metadata.
Existing tracing/poisoning cases remain. Windows now includes `stack_ownership`;
native probe paths explicitly end in `.exe`. An added file-owner probe checks
actual OS closure, shutdown deregistration and byte reclamation separately over
8/1,024 rounds. It has independent missing-close/registration/free controls.

The source review also found null empty-argument slices used in pointer arithmetic
and a zero-byte `memcpy`. The C runtime now forms pointers only for nonempty cleanup
spans and copies only nonempty arguments. The callback fixture explicitly enables
error-handler cleanup. Restoring either old pointer calculation must fail a Unix
Clang sanitizer check; restoring the unconditional copy must fail a portable copy
observer. This is a source-level repair, not an explanation of the old Intel abort.

The follow-up also repairs runtime-handle class admission. The verified #213
interpreter accepted `Channel[I64] -> String` via `json.write` and printed `null`.
Candidate type rules now reject Encode, Decode and canonical Hash for Task,
Channel, WeakChannel, Listener, Conn, UdpSocket, H2Stream and GrpcCell. Protocol
tests cover direct, list and record forms. Weak identity comparison/display/dup
remain valid even when the channel payload is a function. The repair's integrated
tests are pending; the reproduced control is
`/private/tmp/fwp-channel-encoding-control.fwp`.

## Focused checks

All commands use `python3 scripts/local-guard.py`, serially. No full local build,
corpus or benchmark was run. The verified #213 compiler remains at
`/private/tmp/fwp-compiler-213/fwp-macos-arm64/fwp`, SHA-256
`faf994ee0067f5249da86877a7f450efe7cedcfdd433084ebee046319fff47fa`.

- Extracted stack tests: three passed, including dynamic/static O1/O2 faults and
  the original tracing controls. Evidence: `/private/tmp/fwp-stack-matrix-evidence`.
- Extracted callback test: passed O1/O2 ARC/tracing controls and both restored-null
  pointer faults. The temporary harness applies exactly the three candidate runtime
  edits to C emitted by #213; it does not rebuild the candidate compiler. Evidence:
  `/private/tmp/fwp-callback-matrix-evidence`; extraction script:
  `/private/tmp/extract-callback-tests.py`.
- Extracted reuse-token test: success, failure, omitted cleanup and omitted release
  passed O1/O2. Evidence: `/private/tmp/fwp-token-matrix-evidence`.
- Twelve saved variant C probes from #213's macOS ARM64 artifact `12594186700`
  pass after applying the new test instrumentation. Their native settings are
  O1/O2 for aliases and O0/O2 for payload moves. This does not compile the changed
  Rust generator target. Evidence: `/private/tmp/fwp-variant-matrix-evidence`;
  checker: `/private/tmp/check-variant-ledger.rs`.

The new ARC file-owner test also passed locally at O1/O2 for both repeat counts
and all three deliberately broken controls. Evidence:
`/private/tmp/fwp-file-matrix-evidence`. Incidental file-test fixes move an inline
Rust import to the top and give native executables explicit `.exe` paths.

The earlier preparation passed formatting, whitespace, Windows workflow lint
and documentation audit.
The audit checked 158 link sets, 106 immutable preparation pairs/tags and eight
roadmap steps.

The accepted-direction revision updates the plan, ownership/design/feasibility
guides, admission and diagnostic instructions, benchmark protocol, README and
recursion tutorial together. It removes the pending broad cycle-policy decision.
The first weak-channel contract is now specified; other G2 boundaries and the
analysis baseline remain unfinished. Guarded
`python3 scripts/local-guard.py python3 scripts/check-roadmap.py` passed: 159 doc
link sets, 106 immutable preparation pairs/tags, eight roadmap steps and commit
messages. `git diff --cached --check` passed; AGENTS.md has 99 lines. No compiler
build or comparative benchmark was run for this documentation revision.

The weak-channel C fragment was checked inside C emitted by the verified #213
compiler, using the current `tests/support/ownership_ledger.rs` and lifetime probe.
At Clang O2, 1,024 release/reuse rounds passed; omitted expiration failed with 221,
omitted metadata release with 222, and retain-before-failed-allocation with 231.
Both failed weak allocations leave owners unchanged. Driver:
`/private/tmp/check-weak-allocation-failures.py`; extracted generator:
`/private/tmp/fwp-weak-runtime-probe.rs`. This does not compile the candidate Rust
compiler or establish GCC/platform coverage.

The WASI physical-ledger regression's native Clang O1/O2 cases passed: normal
reuse 0, duplicate registration 245 and duplicate removal 243. Driver:
`/private/tmp/check-wasi-ledger-regression.py`. Actual WASI execution is pending.
The new `graph_generations.fwp` fixture ran in #213's interpreter and matched its
independently specified output; it now joins `arc_extensions` for integrated
ownership checks. The follow-up keeps generation metadata on deletion, performs 64 consecutive
reuses, rejects stale keys and preserves an older immutable graph snapshot.
Its revised interpreter output matches the expected nine lines.

Standard-library docs were regenerated by compiling and running the checked-in
`tests/stdlib_doc.rs` standalone under the guard (no compiler build). The primitive
inventory passed against its frozen baseline after adding the two weak operations:
394 declarations, 384 distinct, 40 aliases, 373 contracts, 19 templates and no
review entries. Evidence: `/private/tmp/fwp-weak-channel-inventory.json`.
Weak fixture syntax/types were checked before adding weak identity/class cases;
those newer cases require the candidate solver and remain unverified.

Socket scratch cancellation/allocation failure, TCP construction failure,
library resource closure and loader unload now run their existing fault controls
in both ARC and tracing modes. Their new ARC executions have not run yet. Keep
these tests alongside the old tracing checks until final verification; adding a
mode is not evidence that its controls pass.

The candidate documentation audit passed 160 link sets, 106 immutable preparation
pairs/tags and eight roadmap steps. Changed Rust files were formatted and staged
whitespace checks passed. This is a local checkpoint, not a published PR.

Full compiler/test-target compilation, GCC, Windows, WASI and integrated platform
coverage remain for the preparation's own final-head CI. Do not cite #214's gates
as validation of these later changes. Required gates and merge rules are in
[AGENTS.md](../AGENTS.md) and [CONTRIBUTING.md](../CONTRIBUTING.md).

## Implementation direction and preserved work

The ownership direction is accepted, not pending another policy question. G2 must finish its six concrete boundary contracts and establish
analysis-scaling budgets; the first channel contract is specified. G3 implements weak access and ownership rules; G4 closes diagnostics;
G5 deletes tracing. Finish the combined GC-removal batch before chasing every
remaining ARC operation. Afterward, baseline and implement the count-free buffer
(A5); use measurements to order other count/box work and the parser workspace
(A6). General region inference is not a prerequisite for GC removal.
Do not automatically weaken captures or present another language's performance
claims as verified fwp behavior. Ask only about concrete new semantic tradeoffs
if an example cannot meet the accepted contract.
G4 still needs the finite WASI/external-resource mapping, including cancellation
and external callback entry; it must not displace the GC-removal design work.
Neither this matrix nor a zero byte balance proves arbitrary raw borrows safe.

Preserve [the unexplained Intel macOS compiler-abort evidence](measurements/compiler-abort.md).
Investigate recurrence from source lifetimes and inputs, without allocator-cookie
or disassembly-led experiments. The primary checkout remains detached at #209;
its operational handoff and untracked abort report must be preserved. Prior worktrees
and immutable preparation records are evidence, not a backlog to repeat.

## Roadmap status

Concrete unfinished tasks and acceptance criteria live in [PLAN.md](../PLAN.md).

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Direction accepted; G2 finishes boundary contracts/baselines; G3 weak channels are unverified; G4 closes diagnostics; G5 deletes tracing |
| 2 | In progress | A2–A6: baseline residual costs, count-free unique buffer, measured count/box removal and scoped parser workspace |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: checked comparisons and per-workload CPU budgets |
| 5 | In progress | D1–D3: AD recording/workspace costs and precision/nesting checks |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: execute the finite application acceptance matrix |
