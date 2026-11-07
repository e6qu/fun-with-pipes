# Current work

**Next:** audit every completed job in the tape-layout measurement runs below.
Retain all qualified timing results, including misses; repair failed setup or
correctness checks before proceeding. Do not rerun unchanged qualified timings.

## Branch and measured source

[PR #268](https://github.com/e6qu/fun-with-pipes/pull/268), branch
`tape-record-measurements`, worktree `.worktrees/recording-capacity-gate`.
PR #267 is merged at `621653b6394f49dc229a2956b6b61476c82c9aac`.
Its tree `87157da8628c9bd8755133830b9e93a8fd4f2a6b` equals tested head
`6ca44feb58ce155c42eae792beb480d59894ad7f`; the squash message is one line,
65 characters, without trailers. The follow-up groups measurements, original
executable verification, documentation and any needed repairs.

The [contract](measurements/tape-operation-records.md) was committed at
`036662872` before implementation `b4b291e31`. Reference data is the #266 tape
section, not a dependency on a previous compiler. Both measured versions use
the merged compiler and differ only in that section. No new speedup is claimed.
AMD EPYC 7763/9V74/9V45 approval persists; no decision is pending.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | Verified | Runtime layout merged; all nine production jobs and docs pass. |
| 2 | Verified | Three focused native jobs and complete artifact audit pass. |
| 3 | In progress | Four runtime sessions running; both compiler-cost jobs pass, archive audit queued. |
| 4 | In progress | Full production-log audit passes; measured images and follow-up final gates remain. |

## Active runs

Measurement and merge runs use source `621653b6394f49dc229a2956b6b61476c82c9aac`.
The compiler auditor runs from preparation `d48e6ca0b`:

| Run | Work | Last observed status |
|---|---|---|
| [42369288345](https://github.com/e6qu/fun-with-pipes/actions/runs/42369288345) | `tape-record-time`: two sessions per Linux architecture | Running |
| [42369286155](https://github.com/e6qu/fun-with-pipes/actions/runs/42369286155) | `tape-record-analysis`: seven compiler workloads per architecture | Pass; full archive audit pending |
| [42369871217](https://github.com/e6qu/fun-with-pipes/actions/runs/42369871217) | Complete compiler-cost archive audit | Queued |
| [42369305486](https://github.com/e6qu/fun-with-pipes/actions/runs/42369305486) | Full #267 production-log audit | Pass |
| [42369180224](https://github.com/e6qu/fun-with-pipes/actions/runs/42369180224) | Merge-source production CI | Running |
| [42369180108](https://github.com/e6qu/fun-with-pipes/actions/runs/42369180108) | Merge-source documentation | Pass |

Measurement prerequisite: focused run `42290415866`, source
`b4b291e3184cae5046d7a1eba27e777c67b1884a`. Native sources remain identical.
The production auditor reads run `42319670701`, source `6ca44feb58ce155c42eae792beb480d59894ad7f`,
attempt 1, documentation job `128240880945`, host `all`.

After each measurement producer finishes, dispatch `numerics.yml` with suite
`tape-records-compiler-report` or `tape-records-report`, its `evidence_run`, and
`source_revision=621653b6394f49dc229a2956b6b61476c82c9aac`. Audit complete
archives, all failures and rejected hosts. Keep original samples and compiler,
CPU, allocation, live-memory, elapsed-time, stack and executable-size records.

After retaining runtime reports, commit the explicit image-verification input
plan and dispatch `recording-call-analysis` with `call_plan` pointing to it.
The verifier now accepts `tape-records`; both candidate and reference must retain
scalar append inlining. Rebuild saved C with the original GCC and flags, require
identical image hashes, and take no new timings.

## Completed verification

- PR #268 preparation `d48e6ca0b` documentation `42369752632` passes.
  Its draft production job is skipped, not a passing final gate.
- #267 final-head production `42319670701`: all nine jobs pass. Documentation
  `42319670586` passes. Merge tree and one-line message checked locally.
- [Focused correctness](measurements/tape-record-checks-2026-11-06/README.md):
  Linux ARM64/AMD64 and macOS ARM64 each pass 305 compiler tests and all ten
  native targets. ARM64 also passes actual wasm32 capacity bounds. Four named
  unit measurements are excluded explicitly; no unexpected diagnostics.
- Complete focused audit `42319675956`, job `128240909367`, passes: 900 native
  image headers and 1,215 probe statuses. Artifact `13551664083` and each full
  report/job-log hash are verified locally; compact reports and receipts retained.
- [Complete production audit](measurements/tape-record-delivery-2026-11-07/README.md)
  `42369305486`, job `128393918868`, passes. Retained artifact `13573122126`;
  ten full job logs and 1,456 target/probe-log hashes verified locally (0.13 s).
- Prior documentation schema and reusable-workflow permission failures are
  repaired and their replacement gates pass. Superseded runs were cancelled.
- Image-verifier controls: `python3 scripts/local-guard.py python3
  scripts/test-recording-calls.py` passes all seven tests (0.13 s), including
  rejection of weakened inlining requirements in either tape-layout version.
  Archive/hash verification passes under the guard (0.13 s). Changed-document
  links, plan/status alignment, workflow sizes and merge subject pass (0.13 s).

## Constraints and carried evidence

The earlier [production audit](measurements/recording-context-delivery-2026-11-06/README.md)
and [48 original images](measurements/recording-context-images-2026-11-06/README.md)
are verified. Earlier [runtime misses](measurements/recording-context-time-2026-11-06/README.md)
remain open; this comparison cannot erase them. Do not repeat completed work.

Use the local guard serially; free disk fell from 69 to 60 GiB, below the
64 GiB minimum. The guard refused a small compiler-log summary; local checks
are stopped. Removed this task's two disposable downloaded archives (~82 MiB)
after retaining their verified records; that does not restore the limit.
No local native builds, full suites or benchmarks. The first sandboxed guard invocation
could not read `ps`; it ran normally with approved process access and all limits
intact. Large archives and audits stay on runners. Hosted slots can be busy;
wait without inferring billing restrictions or restarting queued work.

Keep one active PR. Final-head nine production jobs, docs, complete audits and
original measured images must pass before squash merge. Use one commit line
at most 80 characters, no body, trailers or attribution; verify tree/message.
Continue [PLAN.md](../PLAN.md) after delivery.
