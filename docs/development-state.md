# Current work

**Next:** publish the audited repair batch to [PR #215](https://github.com/e6qu/fun-with-pipes/pull/215)
and check its complete production/documentation gates. Also audit the remaining
Linux AMD64 results from older run `40212350477` when available. Fix any additional
failure. Squash-merge only when all nine production jobs and documentation pass
the repaired commit. Then continue to G5 tracing deletion.

Worktree: `/private/tmp/fwp-ownership-fault-matrix`; branch: `ownership-fault-matrix`.
The primary checkout is detached at #209; preserve its operational handoff and
untracked compiler-abort report. Read [PLAN.md](../PLAN.md) for remaining tasks.
G3/G4 stay together in this PR. Tracing has **not** been deleted.

## Delivery and source IDs

Production `40212350477` and documentation `40212350054` test remote head
`aab769dd1b3fefe290d6cd285ceb83c8f05d70c1`. Documentation failed on a stale evidence
count, repaired locally. The benchmark passed. All four macOS jobs and both
Windows jobs finished with failures covered below. Linux ARM64 tests finished
with the same repaired failures; its later build/evidence checks passed. Linux
AMD64 is still testing. Its target logs remain to be audited.
The previous verified run took about 107–133 minutes on Linux and 95–119 minutes
on Windows; elapsed time alone is not evidence of a stalled suite.

Repair checkpoints in the publication batch:

| Commit | Repair |
|---|---|
| `b481a269` | Evidence count, explicit ARC/tracing probe settings, Windows failure continuation, unwind/wide-count artifacts |
| `f05d5cd0` | Direct library free assertions and the real HTTP/2 primitive declaration |
| `f42ad617` | Precise fault injection, task-root accounting, valid weak-cycle fixture, remaining HTTP/2 test declarations |
| `4d642b47` | Release an unfinished weak-upgrade result when retaining its target traps |

Checkpoint `7b1368a1` also preserves weak-regression C, executables, output and
status with the existing helper, under `record-ownership/weak_channels`.
Every completed failed job and available target log has been audited. Publish
the repairs now while the last old Linux job finishes: this workflow has no
push-cancellation policy, so its remaining evidence can still be collected. The
earlier wait was a batching choice, not a required gate on publication.

PR #214 passed all nine production jobs (`40187394961`) and docs (`40187394939`).
Verified squash merge: `6ee33396459986a0fa08464b182d23fd2fe6c136`, subject
`Check native ownership without retaining freed storage`, empty body. Its tree
matches tested head `1591ec72553a1168bc52d5745d1865059c15fede`; this branch was
reparented onto that merge without changing its implementation tree.

Keep the old automation stopped. `/private/tmp/fwp-214-merge-status.json` records
`merged-and-verified`; `/private/tmp/fwp-fault-matrix-delivery-status.json` records
`stopped-for-combined-gc-removal`. Restarting the old publisher would overwrite
newer work. No replacement publisher or merge watcher is running.

## Full-run audit

Artifacts are retained under `/private/tmp/fwp-215-ci/`. Every target log in each
listed artifact was checked, including passing targets. Remaining suites still
need their own audit; do not infer their results from another architecture.

| Artifact | Audited result |
|---|---|
| `12607301746`, `macos-regular-tests-macos-15` | 132 logs; failures only in library input/result ownership, resource unload and library unload |
| `12607841519`, `macos-gc-tests-macos-15` | 124 logs; failures only in `grpc_response_encoding` and two `queued_functions` tests |
| `12607120914`, `windows-native-windows-11-arm` | Early native groups: only library unload failed; five callback/unwind targets passed |
| `12606727507`, `windows-native-windows-2025` | Same early failure; all other completed targets passed |
| `12608117743`, `windows-tls_tests-windows-11-arm` | 98 target logs; failures only in output-channel control and library input/result/resource probes |
| `12607579499`, `windows-tls_tests-windows-2025` | Same four failures across 98 target logs |
| `12608525765`, `macos-regular-tests-macos-15-intel` | Same four library failures across 132 logs |
| `12609426520`, `macos-gc-tests-macos-15-intel` | Same output-channel and queued-function failures across 124 logs |
| `12609572806`, `native-test-logs-ubuntu-24.04-arm` | 256 logs; same seven failing tests in six targets, no additional failure cause |

Completed Windows job logs were also checked beyond the target artifacts: their
only extra failure was list-copy inspection after an earlier failure skipped its
producer, covered by the workflow repair. Later command, remote-stream, autodiff,
golden and reuse steps passed. Full job logs are `job-121226098232.log` and
`job-121226098427.log` in the artifact directory.

Retained callbacks passed on Linux ARM64, macOS and Windows ARM64, including real shared-library
loading. All four unwind tests passed on both. All four wide-count tests and all
19 `wasm_arc` tests passed on macOS ARM64. Weak metadata checks passed there;
the negative cycle fixture failed to parse before reaching its expected rejection.
These are partial results for the remote head, not acceptance of the local repairs.

Mac regular crash artifact `12607154104` identifies the intentional abort in the
passing `cleanup_panic_aborts_before_borrowed_tasks_escape` test. The GC crash
artifact `12607482264` contains a compiler binary but no crash report. Neither
establishes recurrence of the [unexplained Intel abort](measurements/compiler-abort.md).
Intel artifacts `12608956775` and `12608643822` likewise contain only that deliberate
cleanup-test abort (regular shard) and no crash report (GC shard), respectively.

## Repairs and focused evidence

All local workloads use `python3 scripts/local-guard.py`, serially. No full local
build, suite or benchmark ran. Current CI-built compiler: artifact `12607845652`,
`/private/tmp/fwp-215-compiler/fwp-macos-arm64/fwp`, SHA-256
`376eff66114e396e045b455113e58b6511b3544e397f1c00701cf659ce3fa361`.

| Problem and repair | Verification so far |
|---|---|
| Evidence report expected nine protocol tests after two were added; counts are now 11/52 | All eight collection-evidence controls passed |
| ARC library/socket probes inherited tracing or poison settings; select settings explicitly for each mode | Extracted socket scratch/constructor tests passed O1/O2 in both modes with hostile inherited settings; uses saved #213 C |
| ARC direct library probes referenced absent `fwp_reuse_verify`; require physical frees unconditionally in ARC | Source/format review; repaired Rust targets need final CI |
| Resource fixtures requested nonexistent `http2.connect`; use `http2.pooled : String -> Bool` throughout | Candidate-generated TLS/HTTP library plus unchanged resource C probe passed ARC/tracing O1/O2 and all six omitted-cleanup controls; `check-fwp-library-resources.py`, 23.92 seconds |
| Output-channel control also matched retained-callback cleanup; match the channel owner reset and release together, including the related queue probe | Extracted output-channel test passed O1/O2, all normal/fault cases; `check-fwp-output-channel.py`, 17.71 seconds |
| Task-owner probe expected two root-release sites; WASI, native and library shutdown now have three | Affected task-handle fixture passed ARC/tracing O0/O2 with candidate compiler; `check-fwp-queued-task-root.py`, 4.99 seconds |
| Negative weak-cycle fixture used reserved `make`; renamed to `new-queue` | Candidate rejects the captured channel before/after optimization; `check-fwp-weak-cycle.py`, 0.38 seconds |
| Weak upgrade allocated its result before a potentially trapping retain without protecting that cell | Actual wide-count overflow preserves the borrowed target and releases the unfinished result; missing cleanup fails with 235. O1/O2 normal plus four broken variants passed; `check-fwp-weak-upgrade-cleanup.py`, 24.39 seconds |
| Early Windows failure skipped independent producers and caused missing list-copy artifacts | Workflow accumulates early group failures and continues independent suites after compiler success; 19 runner controls and targeted actionlint passed |
| New unwind/wide-count/weak probes needed retained failure evidence | Existing evidence helper now saves C, executable, output and status before assertions |

Drivers above are in `/private/tmp/`. The weak-upgrade check substitutes the repaired
runtime function into candidate-generated C. The resource/output-channel checks
use generated source equivalents of the direct IR fixtures. These checks do not
verify the repaired Rust generator integration, GCC, Windows or WASI. The first
temporary resource source needed its Network effect and checked library declaration
corrected; no compiler admission rule was weakened.

Earlier bounded preparation checks passed stack-child, callback-slice, reuse-token,
variant-alias, file-owner, weak metadata, retained-callback, ARC unwind, wide-count
and WASI-ledger controls. Their saved-compiler fragments are supporting evidence;
current integrated runs take precedence. The optional #213 executable is not a
build dependency. Builds must never require an older fwp version or self-hosting.

Primitive inventory passed its frozen baseline: 394 declarations, 384 distinct,
40 aliases, 373 contracts, 19 templates, no review entries
(`/private/tmp/fwp-weak-channel-inventory.json`). Native schedule audit assigns all
254 targets. Formatting/whitespace checks passed. Documentation audit passed 161
link sets, 106 immutable preparation pairs/tags, eight roadmap rows and commit
messages. Repeat only checks justified by subsequent changes or unresolved failures.

## Included G3/G4 work

- [Weak channels](weak-channels.md): explicit downgrade/upgrade, expiration before
  queued-child destruction, identity and address reuse, preserved function-frame
  lifetimes, conservative checks on stores/captures of acquired owners.
- [Retained C callbacks](retained-callbacks.md): explicit export registration,
  copied leading arguments, active-call cleanup, reentrant close/release,
  independent result ownership and one calling OS thread.
- [Boundary examples](gc-removal-design.md#six-implementation-examples): weak
  callbacks, task-owned subscriptions, graph IDs with checked generations,
  retained C registrations, returned captures and bounded State/AD lifetimes.
- [Replacement diagnostics](ownership-diagnostics.md): live-address and physical
  storage checks, exact wide counts, unwind/cancellation, actual OS handles,
  library unload, WASI allocation tables and independent missing-cleanup controls.
  The deletion table identifies which collector assertions retire in G5.

Included runtime repairs also remove null pointer arithmetic/copies for empty
callback arguments, release library scheduler-root/State storage and idle Linux
wait metadata, and fix WASI duplicate-address detection after an empty table slot.
Runtime identities no longer satisfy serialization or canonical hashing.

## Remaining work and delivery rules

G2's N/2N/4N ownership-analysis baseline and numeric regression budgets remain
unmeasured. Do not widen proof precision or claim linear analysis cost without them.
G3/G4 need complete final-head acceptance. G5 deletes tracing selection, roots,
marking/sweeping and collector-only assertions; preserves the listed allocation,
RSS and resource checks; applies the lifetime policy to interpreter entries; and
checks actual binaries. ARC minimization A2–A6 and later milestones remain separate.

Follow [AGENTS.md](../AGENTS.md): one active PR, fix every encountered issue,
no compatibility adapters, no JIT, guarded focused local work, broad gates on
GitHub. Standing publication/merge authorization applies. Squash only after nine
production jobs and docs pass the exact head; use an explicit one-line subject
of at most 80 characters and empty body, with no trailers or attribution. Verify
that merge result. A completed PR does not finish the roadmap.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2 analysis baseline; G3/G4 integrated gate; G5 tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
