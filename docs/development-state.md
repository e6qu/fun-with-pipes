# Current work

**Next:** trace forward objective evaluation and scalar tape recording from the
saved generated C and current sources. Reconcile operation counts before selecting
a transformation; follow the four steps in [PLAN.md](../PLAN.md). Do not rerun
unchanged timings or remove runtime checks without a lifetime and trap-order proof.

Branch: `recording-work-review`, based on verified merge `2e6e09f5`.
Worktree: `.worktrees/scalar-constant-lowering`. No active PR or outstanding CI
failure. Bundle the next implementation with these delivery records in one PR.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Phase shares and node counts reviewed; account for the generated forward worker's individual operations. |
| 2 | Pending | Prove which checks are invariant within the selected worker, preserving all failures. |
| 3 | Pending | Freeze the selected transformation, reference and measurement limits. |
| 4 | Pending | Implement the group, verify and deliver it. |

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
