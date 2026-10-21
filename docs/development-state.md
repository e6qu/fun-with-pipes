# Session handoff

## Next action

Next: finish auditing preflight `39666813009` at
`82905d6b1a46d6bbb16ecdbcb034b0871da0ff10`, then publish the accumulated repairs
and scope fixes together. Worktree `/private/tmp/fwp-task-await-fields`, branch
`task-await-fields`, is based on PR #190 source `bf78c7ab`. No second PR exists. A discovered auxiliary workflow command placed four Cargo
test selections after the harness separator; these now precede `-- --nocapture`,
so all intended targets actually run. The same repair is included in PR #190.
Audit with `/private/tmp/fwp-audit-task-await-preflight.py`; keep its failed-source
receipt. Full final-head acceptance is still required after the corrected tests.

The complete Linux job passed. Both WebAssembly hosts failed only the new
fixture's eight missing-State controls each: it allocates no State, so deleting State cleanup
cannot leak. The repaired control deletes cached task-result destruction instead.
All three full job logs are now audited; there are no other failures. Publication receipt:
`/private/tmp/fwp-task-await-publication.json`.

The same group now repairs two existing ARC example failures:

- `iteration_consumers`: all 22 expressions work separately; a plain fold and a
  stateful fold failed together because partial captures shared one summary. The
  proof now distinguishes creation scopes, while checking calls in their actual
  invocation scope. A regression also rejects an escaped stateful partial.
- `autodiff_reverse`: `rev.jacobian` counted outputs without a tape scope. That
  pass now has scoped cleanup. Repeated Jacobians with deliberately unused tapes
  check release before each printed result, not only at global shutdown.

The previously accepted Linux corpus executed 75 of 86 programs, rejected eight
and verified three compile errors. Its old test permitted arbitrary new ARC
rejections outside a small named subset. The candidate requires every program to
execute unless it matches one of six explicit remaining rejection reasons. GPU,
foreign-pointer and deliberately invalid cross-task AD cases remain visible gaps;
this is not evidence of support. Source-specific corpus evidence is saved under
`/private/tmp/fwp-189-arc-corpus`; minimized programs/IR are under
`/private/tmp/fwp-arc-corpus-isolation`. Unix focused CI now runs this stricter test.

`python3 scripts/local-guard.py python3 /private/tmp/fwp-check-scope-repairs.py`
passes rustfmt, fwp formatting, all 27 derivative outputs under the prior compiler's
raw interpreter, standalone generated-library-doc refresh and diff checks. The
initial fwp formatting failure was fixed. The changed Rust proof, new library
implementation and pre-shutdown probes are not yet CI verified.

[The allocation comparison](measurements/task-await-fields.md) explains the
program, restored-box control, expected counts and limits. No saving is measured yet.

## Candidate and checks

Immediate task-await matches receive Option tag/payload fields directly. Escaping
options retain their ordinary representation. Task results keep their independent
owner; shared payloads still need a typed retain before the borrowed handle can
be released. The existing channel result struct is shared with this representation.
No source syntax, task layout or cycle policy changes.

Tests add repeated text awaits, cancellation, integer and F128 results, an option
stored in a list, pointer-like integer bits, physical aliases and retain overflow.
The matched C control restores 34 temporary boxes while preserving result retains.
Native artifacts expand from 22 to 30 binaries; WebAssembly runs the new fixture
under WASI/browser, JSPI/Asyncify and O1/O2 with cleanup controls.

Guarded commands from the primary workspace:

- `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-await-fields.py`:
  rustfmt, fwp formatting/type check, raw interpretation and diff check pass.
  The verified #188 compiler supplies metadata; this does not check the changed
  Rust code generator. Initial fixture syntax mistakes were corrected first.
- `python3 scripts/local-guard.py python3 /private/tmp/fwp-probe-await-fields.py`:
  macOS ARM64 O0 runtime probe passes with GC stress/verification and reuse
  verification off/on; missing-result-retain control exits 26 as required.
  The helper transplants the matching task runtime into prior compiler metadata.
  Its first injection assertion was too broad; the target is now the complete
  direct-result return sequence. The initial mixed old/new spawn runtime was
  corrected before the passing run. No new compiler build ran locally.

Static validation also passed via `/private/tmp/fwp-validate-await-preparation.py`:
rustfmt, fixture/raw interpretation, 394-declaration frozen ownership inventory,
11 native-runner unit checks, workflow syntax and 82 documentation link sets.
The later workflow edit publishes ownership logs before REST tests; actionlint
and documentation checks pass via `/private/tmp/fwp-check-task-channel-docs.py`. No full compiler build ran locally.

Remaining before acceptance: confirm the
matched control and WebAssembly cleanup controls under the changed compiler on
CI, inspect actual generated C and binaries, and record actual counts. Do not
interpret the expected 34-box difference as a result before those tests pass.
Full builds, benchmarks and full gates stay on runners. Use the primary guard;
keep 64 GiB free disk, target below 2 GiB, sampled RSS below 1 GiB and 180 seconds.
Latest disk check: 66 GiB free. Do not raise limits.

## Preceding ownership delivery

[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190) is the single draft
ownership delivery, worktree `/private/tmp/fwp-task-channel-owners`, corrected
source `bf78c7ab8fcc052b5931165f28393450b9106d21`. Focused run `39666299981` checks
six native hosts and both WebAssembly hosts. Audit with
`/private/tmp/fwp-audit-task-channel-corrected.py`; keep its separate receipt.

The predecessor `5542803e` audit is complete. Both WebAssembly jobs passed; Linux
had exactly one wrong diagnostic expectation in the new negative test. Its task
result contains a callback, so the function-bearing channel check rejects it
first. The correction requires that specific diagnostic/type for that case.
All other ownership tests, four gRPC checks, 22-binary inspection and 28 REST tests
passed. No compiler rejection was relaxed. The correction also publishes batch
logs early and matches production's checked Rust O1 profile. This preparation
inherits those repairs after rebasing; preserve the separate measured source.

The earlier callback source `521a160091040207067601ca3e57d7cc444e33f0` has all six
native and both WebAssembly jobs passed in `39656585197`; every full log is audited. Audit `/private/tmp/fwp-audit-task-owners-corrected.py`.
All 132 native binaries and 64 task-capture WebAssembly modules have independent
inspection, with the source-specific report saved in docs/measurements. That source does not
establish acceptance for the later direct Task-message proof or this candidate.
Preserve the separate source IDs and receipts.

PR #189 passed all nine production jobs and docs at `4dfc2be3`, then squash-merged
as `030fa3374e36459d9a774379e2116ac42ed5db1d`, with identical tree and verified
single-line subject. The redundant same-tree production run was cancelled before
any steps; post-merge documentation also passed and was fully audited.
Receipt: `/private/tmp/fwp-189-final-acceptance.json`.

All seven areas in [PLAN.md](../PLAN.md) remain open. Keep one delivery PR at a
time, fix all encountered issues, require final-head nine production jobs and
docs, then squash with a one-line subject of at most 80 characters and empty body.
No trailers or attribution. Continue through the plan after each verified merge.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
