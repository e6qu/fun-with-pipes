# Current work

**Next:** publish the native-probe borrow repair and completed measurement setup;
run the focused scalar-constant checks and measurement controls on GitHub.
Keep monitoring PR #260 and merge it only after its final production audit passes.

## Roadmap status

| Step | Status | Evidence still needed |
|---|---|---|
| 1: bounded constant proof | Implemented; 296 compiler units pass on three hosts | Full production coverage. |
| 2: exact scalar replacement | Complete-program selection passes on three hosts | Native bit/effect/cache ownership probes. |
| 3: correctness | Test-build repair prepared | Focused native targets and artifact audit. |
| 4: measurements | Workflow, exact counts and parent reconciliation wired | Census/stack, compiler costs, two runtime sessions per architecture, all audits. |
| 5: delivery | Pending | Nine final-head jobs, docs and full audit; squash merge. |

Branch/worktree: `scalar-constant-lowering`. The [contract](measurements/scalar-constant-lowering.md)
was frozen at `4bad4992` before implementation, tag
`roadmap/scalar-constant-lowering-protocol-2026-11-05`.
No new performance measurements or second PR before #260's verified merge.

## Parent delivery

- PR #260 source: `ba3f0d8793dc3bbd3c21f94d06a1bca2896b6d45`.
- Production `42024634729`: eight jobs pass; Linux AMD64 still runs.
- Documentation `42024602934`, job `127235545731`, passes.
- After all nine pass, dispatch `production-log-audit` from `packed-pair-storage`
  with that source/run, attempt `1`, host `all` and documentation job above.
- Audit before merging. Keep the parent head unchanged; rebase this group onto
  its verified squash commit afterward. Parent details: `.worktrees/packed-pair-storage`.

## Focused verification and repairs

- [First build](measurements/scalar-constant-checks-2026-11-05/first-build/README.md):
  run `42034673196` at `d99dbacd`; all hosts failed private-field access.
  Fixed by `b35c1c99`, exposing the shared immutable program reference.
- [Second build](measurements/scalar-constant-checks-2026-11-05/second-build/README.md):
  run `42035958930` at `b35c1c99`; three hosts pass compiler build, 296 units,
  inventory, reference/observer controls and three complete-program selections.
  All-target lint and native compilation fail E0509 in `caf_ownership`: the new
  probe moved a field out of a value with a destructor. Borrow it with `ref`.
  Every complete log and all six artifacts audited; no native test ran.
- Guarded local checks pass: Rust formatting; scalar-reference (4), descent-budget
  (23), census/reconciliation (10), phase-budget (9), compiler-measurement (10)
  and roadmap-size (5) controls. Commands use `python3 scripts/local-guard.py`.
  The initial sandbox denied `ps`; the same guard passed with process-list access.
- Initial local budget/census runs lacked tracked fixtures in this sparse checkout;
  materializing those small files fixed them. The historical artifact audit also
  lacks its larger archives locally: run it in the remote measurement-control job.

## Measurement setup

The same-source reference disables only scalar replacement. Selection checks
require candidate literals and reference caches, with prior pair reuse preserved.
All allocation/node counts must stay unchanged. Reconcile fresh and repeated
reference observations with the parent's saved pair-cleanup evidence before timing.
The scalar census/analysis/time and corresponding report choices are wired;
workflow execution and complete artifact audits remain unverified.
Preserve every earlier timing miss in PLAN.md. Do not rerun unchanged timings.

## Resources and workflow maintenance

Free space recovered to about 85 GiB. At the user's request, removed 1,098,786,631
bytes of old downloads after confirming GitHub originals; logs, source and audit
reports remain. Receipt: `../gradient-work/removed-verified-downloads-2026-11-05-user-cleanup.json`.
Local work stays serial and guarded. Full native builds and measurements stay on CI.

The initial format request `42030505657` exceeded GitHub's 512,000-byte workflow
limit; [the receipt](measurements/scalar-constant-checks-2026-11-05/format-startup.json)
records it. Five maintenance jobs moved to a reusable workflow. Format requests
`42031076546` and `42032825443` pass; their verified patches were applied.
The documentation audit now rejects oversized workflows. Current numerics.yml is
508,914 bytes; check its size before publication.
