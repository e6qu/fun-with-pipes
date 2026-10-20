# Session handoff

## Next action

Next: finish [PR #178](https://github.com/e6qu/fun-with-pipes/pull/178) on
`simplify-local-match-inputs`. Final head is `732984c3fb6b8646f6f3ee4932c123eadb7f3555`.
Production `39397311012` has all nine jobs: benchmark passes and eight platform
jobs are active. Documentation `39397297724` passes. The two completed logs were
audited in `/private/tmp/fwp-178-acceptance.json` (5.91s). Audit every job and fix every failure. Merge only after exact-head
acceptance, with an explicit one-line subject of at most 80 characters and empty
body. Keep this head stable while healthy gates run.

Independent preparation is in `/private/tmp/fwp-variant-moves`, branch
`move-matched-variant-owners`, source `7136727a1788720c7bab873ba79d5c3c6e084e9a`.
It removes an adjacent retain/drop pair for a sole payload already held in local
variant fields, excluding protected resource slots. Tests cover scalar, record
and variant results, unique/shared owners, O0/O2 and a deliberately leaked owner.
Guarded formatting passes (1.45s); documentation audit passes (2.59s).
Focused run `39398766302` fails on both hosts only because two test functions
were unreachable from the fixture entry point and were correctly omitted from C.
Both complete logs were audited (2.62s); all other tests and count checks pass.
The fixture now references all three result forms from its entry point; the
three-move assertion is unchanged. Formatting passes (1.58s). Repeat the focused
run for this repair. Six-platform ownership/cancellation run `39398786993` still
uses the original fixture; audit all of its results before a combined rerun.
Neither failed nor pending runs establish acceptance.
No second PR exists. Finish #178 before publishing the prepared next delivery.
Keep this local status update for that delivery instead of restarting healthy CI.

## Accepted baseline

The user merged PR #177 as `44f9eb6eeb787df378b159b33f113bffd69b216e`.
Its tree equals tested head `a5828518f92da3112fde13157a0dcc964d6c3cb9`; the
merge message is one line without trailers. All nine production jobs `39374128066`
and documentation `39374119890` pass. PR #176's retained production `39371117507`
and documentation `39371117707` also pass. All 20 complete logs were audited
(37.42s), with hashes in `/private/tmp/fwp-176-177-acceptance.json`.
Only duplicate post-merge #177 production `39393021237` was cancelled;
post-merge documentation `39393021033` passed before cancellation was attempted.
[History](roadmap-history.md) records both completed deliveries.

## Current delivery

Local tuple matches now evaluate nontrivial fields once, in order, before
matching the relevant field directly. This exposes existing direct-call and
receive-wrapper removal. Original resource scopes and checked field types remain
protected; whole-tuple uses and multiple tested fields keep their existing lowering.
Ignored constants still evaluate and trap. Tests cover effects, both Option
branches, direct callbacks and all four O0/O2 ARC/tracing combinations.
The tacit example also runs in the existing native/GC/WASI golden program.

[The measurement report](measurements/channel-match-results.md) compares the
same five programs against PR #177's measured source `a44d52a1`. Both Linux hosts
pass run `39396074107` at `7a0c93ef4704b9443533f81e1c9c4a76e4179770`, preserved
by `roadmap/revision-channel-match-7a0c93ef`. Each complete log passes 17 checks,
none ignored or filtered. All 180 samples and 20 ordinary binaries are audited.
The final documentation commit changes no compiler, runtime, test or workload.

Fresh-function allocations fall 5 → 2 per additional message and shared-function
allocations 3 → 1; each saves one retain. Other cases are unchanged. ARC profiles
end with zero charged storage and no collections. Actual frames shrink on both
architectures. Retain the ARM64 link-stub/padding cost in the report; no timing or
C/Rust parity claim. Source/runtime changes require fresh measurement/proof; status
updates alone should not restart a healthy production head.

## Checks and resolved failures

First focused run `39394019143` failed only because the new test enabled tracing
stress for ARC. Repair run `39395145939` then exposed the omitted reuse-verification
setting, which ARC also rejects because it retains freed storage. Both full log
pairs were audited. The complete runtime option check and existing queue tests
were reviewed: all three verification flags now use 1 for tracing and 0 for ARC.
The test collects all four combinations before reporting failures. Run `39396074107`
passes the repaired tests; earlier failed workflows are not acceptance.

Guarded formatting passes (1.46s); doc audit passes (2.97s); saved raw-interpreter
example checks pass (5.40s), and golden formatting passes (0.14s). The older saved
compiler only verified example syntax/output. Current runner logs are audited
(2.64s), all samples/code hashes (1.71s), and ELF/frame comparison (0.14s).
Artifacts: `/private/tmp/fwp-match-final-costs`; count report:
`/private/tmp/fwp-match-final-counts.json`; log audit:
`/private/tmp/fwp-match-final-log-audit.json`. Baseline artifacts remain at
`/private/tmp/fwp-channel-receive-struct-costs`.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks.
No local build was run. Full builds, native compilation and large suites belong
on runners. Preserve 64 GiB free disk, target data below 2 GiB and sampled aggregate
RSS below 1 GiB. Stop on guard limits; never raise them.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need proofs. Captured channels cannot be admitted from element
types alone: native callback channels retain hidden context, so provenance must
also be proved. Default native execution retains tracing. JIT is excluded.
Follow [AGENTS.md](../AGENTS.md).
