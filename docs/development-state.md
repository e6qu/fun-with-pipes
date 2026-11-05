# Current work

**Next:** verify the bounded tape-lookup implementation and its deliberate-failure
controls on the three focused production hosts, then complete the frozen comparison.
Do not run the final matrix until this group and its measurement tools are ready.

Branch: `recording-work-review`, based on verified merge `2e6e09f5`.
Worktree: `.worktrees/scalar-constant-lowering`. The implementation and measurement
tools are being grouped into one draft PR.
The [contract](measurements/recording-lookups.md) was committed at `bfddc31e`
before implementation. It preserves parent/capacity checks and excludes any
worker that can change tape lifetime or suspend through task/service entry ticks.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Complete | Generated source reconciles eight nodes per pair/update with the saved profiles. |
| 2 | Complete | Closed numeric worker proof; registry changes, recovery and suspension excluded. |
| 3 | Complete | Same-source comparison and limits frozen at `bfddc31e`. |
| 4 | In progress | Implemented bounded selection and explicit local lookup state; native controls, focused CI and measurement integration still require verification. |

Local `python3 scripts/local-guard.py cargo fmt --all` passed (1.00 CPU seconds,
1.81 elapsed). No local build or native suite has run. New controls exercise both
lookup paths, invalid/expired/mixed IDs, capacity growth, retirement/reuse,
weight bits, gradients, unwind and deliberately broken validation observers.
These are implemented tests, not passing evidence yet.

Focused run `42121618183` at `330612d9` remained queued without starting a job.
The next push adds real-program selection/counter checks and two proof-boundary
unit tests; replace that queued run with one run of the complete focused batch.
Then dispatch `storage-measurement-controls` and keep monitoring every job.

The new `recording-lookup-{census,analysis,time}` suites use the existing production
measurement jobs. Census must precede timing: it checks exact parent/capacity/node
counts, eight-to-three lookup reduction per pair, parent allocation reconciliation,
raw storage, cleanup and stack. Use the same passing focused run as `evidence_run`.
The corresponding `*-report` suites audit retained data. Runtime sessions must be
qualified before building and must not be repeated for a passing result.

Local focused tools: reference/observer controls passed 5 tests; timing budgets
23, fresh allocation budgets 9, whole-solve census controls 10, compiler-analysis
controls 10. The last four ran serially under the guard (combined with the archive
control: 2.51 CPU seconds, 5.04 elapsed). The archive control has four missing-file
errors because sparse checkout omits historical `array-lists-*.tar.xz` files;
run its full archive checks on CI, whose checkout includes them. No test was
removed or weakened. Actionlint passed for both changed evidence workflows.
Rust formatting passed again (0.88 CPU seconds, 1.69 elapsed).

## Completed group

[PR #261](https://github.com/e6qu/fun-with-pipes/pull/261) merged as
`2e6e09f539bcdab965d062f0184b585b340b29d8`. [The delivery receipt](measurements/scalar-constant-delivery-2026-11-05/README.md)
retains the audited logs and confirms an identical tested/merged tree and a
50-character squash message with no body or trailers.

| Check | Passing run / audit |
|---|---|
| Nine final production jobs | `42080858908` at `80e4ee7b483d4881801eed3ff3b12c312b4ec868` |
| Final docs | `42080855434`, job `127433175116`, same source |
| Every final job and test-target log | `42096023194`, job `127486171834`; no unresolved issues |
| Three-host focused native checks | `42048215807` / `42070540044` |
| Allocation, cleanup, work and stack | `42072583890` / `42074145465` |
| Compiler costs | `42074639596` / `42076024832` |
| Four qualified runtime sessions | `42074728167` + `42075136884` / `42078637088` + `42078654369` |

Measurements use `76690b385514c58ad94c5591da3553fa48218535`; later changes repair
evidence tools/docs only. All four sessions measured once. Their 27 missed 5%
speed targets stay open under the agreed policy; all other measured limits pass.
The wrong-CPU AMD host was rejected before builds/timing. No claimed C/Rust parity.
Postmerge duplicates `42096524750` and `42096524644` are confirmed cancelled.

## Next investigation inputs

Read `lib/autodiff.fwp`, `runtime/fwp_rt_kernel.c`, saved generated objective
workers, and the [runtime reports](measurements/scalar-constant-time-2026-11-05/README.md).
Forward recording accounts for about 72% of observed derivative-phase time in
129/199; these observations do not identify a particular check as the cause.
Keep the original arithmetic order, eager callback stages and all failure controls.

The [saved phase review](measurements/recording-work-review-2026-11-05/README.md)
identifies all four input-report hashes. Local checks used
`python3 scripts/local-guard.py`: the phase review took 0.17 CPU seconds/0.56 elapsed;
audit ZIP digest/job identity and merged-tree/message checks each passed under
0.2 seconds. The saved calculation reproduces byte-for-byte (0.24 seconds).
The staged-doc link check (`../gradient-work/check-delivery-docs.py`) verifies
362 local links in ten Markdown files; plan/handoff and workflow-size checks pass.
No native tests or benchmarks were rerun locally.

About 83 GiB remains free. Keep the fixed resource guard; full builds, suites and
large evidence work run on GitHub. The previous cleanup receipt remains at
`../gradient-work/removed-verified-downloads-2026-11-05-user-cleanup.json`.
