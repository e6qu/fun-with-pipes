# Next: complete D2 and N1 evidence in PR #227

**Next:** finish the repaired-source derivative comparison, verify all four N1
kernel baselines on matching native hosts, archive and audit every result, then
publish one final head for the nine production jobs, docs and both G2 hosts.
Keep PR #227 draft during focused work. Squash-merge only after every final gate
passes and all logs are audited, with an explicit one-line subject <=80 characters
and empty body. This PR groups D2, its compiler repair and N1; N2 is not started.

Worktree `/private/tmp/fwp-ad-captures`, branch `ad-eager-captures`.
[PLAN.md](../PLAN.md) owns acceptance, [history](roadmap-history.md) owns completed
deliveries. User-merged #226 is `cdf881067d`, tree identical to final tested
`02e4ee21`; all nine production jobs, docs and both G2 hosts are fully audited.
Duplicate post-merge run `40899114681` was cancelled after checking tree equality.

## Compiler repair and actual checks

`694e31b7` repairs a C-generator defect exposed by eager captures. An authorized
REST DELETE returning `RestReply[()]` crashed natively: a record was split into
fields before a match, then read as an unassigned boxed local because another
branch could fail. Both interpreters passed; exact production Clang O1 reproduced
the segfault. The repair emits every arm in the caller's field context. Tests
cover both authorization outcomes, mixed direct/dynamic records, aliases and
repeated exceptional cleanup. REST tests now retain server exit/stderr diagnostics.
The same commit repairs the stale collection-evidence count (seven tests, not six).

Focused run `40909968650` at `694e31b7` passes on Linux ARM64/AMD64 and ARM macOS:
333 tests/22 summaries per host, lint and raw interpreter corpus. Every full log
is audited. Documentation `40909967190` passes; its complete log was reviewed.
The broader old run `40901634818` at `56528ffb` continues for failure audit:

- Both regular macOS jobs fail only the two REST cases; every target and complete
  job log is audited. This is the defect fixed above, not a timing failure.
- Both macOS ownership jobs pass (363 tests/127 summaries each), fully audited.
- Benchmark passes. Both old G2 hosts (`40901630875`) pass, with all 13,824 durations
  and complete logs audited. These are not final-head gates after the repair.
- Linux and Windows jobs still run; inspect all their completed targets/failures.

No disassembly was used to diagnose this defect. Source, minimal reproducer,
exact downloaded compiler and logs remain under `/private/tmp/fwp-227-*`.

## Derivative measurements

[The capture report](measurements/eager-captures.md) retains the four original
passing comparisons at `4ffeb0d2`/`8703104d`, frozen protocol `8a495a72` and original
AMD rejection. They measured 13–72% less elapsed time and 65.5% fewer requests in
the largest current-result case, still 44–58 times handwritten C's time. All
outputs, 368 binaries, 320 frame reports, profiles and reference patches are
audited. These timings do not yet verify repaired `694e31b7`.

Refresh runs at `694e31b7`, with unchanged limits:
`40912310643` runs ARM sessions 1/2; its two AMD hosts were rejected before builds
(both EPYC 9V74). `40912523280` has qualified AMD session 2, but rejected session 1.
`40912773534` requests only missing AMD session 1. Preserve all rejected attempts;
never replace an accepted measurement to obtain a faster time. The independent
repaired-source auditor is `/private/tmp/fwp-audit-captures-repaired.py`.
Archive each source/run separately and retain the earlier accepted observations.

The scalar-recording experiment keeps its user-accepted allocation reduction and
failed original speed rule. D3's finite accuracy/depth matrix is verified by #226;
no general constant-memory or handwritten-derivative parity claim follows.

## Kernel baselines grouped into this PR

Preparation branch `numerical-kernel-baselines` at `8b1132ca` is now included here;
its separate worktree `/private/tmp/fwp-kernel-baselines` is no longer the active
delivery. Protocol `d0384af0`/`c17fe6e2`, runner `f053da88` and six passing Python
controls precede measurement. [The report](measurements/kernel-baselines.md)
defines exact inputs, every result bit, four labels, two timing scopes and noise
limits. It corrects the historical four-label description without changing data.

Initial run `40906486080` has two independently audited ARM sessions: 72 ELF
images, 48 frame reports, all observations/outputs/cleanup and full logs. Reports
and 5,782 artifact identities are archived. AMD hosts were rejected before builds:
Xeon 8573C and EPYC 9V74, instead of EPYC 7763. All rejection logs remain. Verify
repaired-source applicability and collect all four matching-host baselines before
selecting N2; the initial ARM data alone does not complete N1.

## Local checks and retained state

All focused local checks use `python3 scripts/local-guard.py COMMAND...`, serially
with unchanged limits. Formatting, workflow lint, eight collection-evidence
controls, six kernel controls, roadmap links and independent evidence audits pass.
No local Rust build, full suite or benchmark was run. Full workloads use GitHub.

The guard earlier refused below 64 GiB free. Thirteen obsolete worktrees were
removed while retaining branches, all evidence and both modified handoffs under
`/private/tmp/fwp-obsolete-checkout-handoffs`. Active worktrees and the primary
checkout's untracked `docs/measurements/compiler-abort.md` are preserved. The old
intermittent Intel compiler abort remains unexplained; the ARM crash artifact in
this PR belongs to an intentional unit negative control, not a recurrence.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | D1/D3 verified; deliver repaired D2 improvement |
| 6 | In progress | Complete N1 baselines, then select N2 optimization |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |
