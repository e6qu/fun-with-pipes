# Current work

**Next:** dispatch `record-zip-codegen` for completed run `41330973213`, source
`215db5dea22ebbf1e2052b69660c068959e4a2c7`, then inspect GCC 15.2's reports for the
four reproduced zero-update programs. Source review has not found an ownership
defect. Resolve the timing acceptance decision before final gates.

[PR #239](https://github.com/e6qu/fun-with-pipes/pull/239) is draft on branch
`derivative-forward-costs`, worktree `/private/tmp/fwp-returned-callables`.
Base `c124d0c8` is verified PR #238. Preserve the unrelated primary-checkout edits.
[PLAN.md](../PLAN.md) and the [measurement report](measurements/derivative-forward-costs.md)
own scope, all six cases, acceptance rules and retained evidence.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Protocol `02d4aa26`; candidate limits frozen at `73cec3e5` before compiler edits |
| 2 | Verified | Known-work, omission, wrong-phase and unfinished-sequence controls pass |
| 3 | Verified | Baseline `afc0f78f`, run `41319946864`: both native hosts, all 96 observations audited |
| 4 | In progress | Candidate correctness, ownership, counts and artifact audits pass; timing limits fail; nine production gates remain |

Compiler change `b094fdd8` extends existing zip/map fusion to flat numeric records,
including `Rev[F64]`. Both lists stay alive; order and shorter-list behavior stay
unchanged. Nested/managed fields and boxed wide numbers remain excluded.
Measured compiler/runtime files have not changed since that candidate.

Candidate run `41324329567` passes on AMD64 job `124900983795` and ARM64 job
`124900983956`: per host, 19 affected integration cases, three fusion unit tests,
GCC O1/O2 observer controls and 48 solve observations. Logs and saved probes are
audited. Largest current-only solve saves 51,143 allocation requests and 76,416
retains; peak managed charge falls from 25,952 to 21,888 bytes. Final managed/raw
storage is zero, raw storage is unchanged and largest static frames do not grow.
These results do not establish timing acceptance.

## Four timing sessions: all audited, requirements unmet

| Session | Measured run / job | Result |
|---|---|---|
| ARM64 1 | `41325932590` / `124905745488` | Both one-update forms miss 5% improvement |
| ARM64 2 | `41325932590` / `124905745590` | Both one-update forms miss 5% improvement |
| AMD64 1 | `41325932590` / `124905745526` | Same one-update misses; current zero-update is 2.54% slower |
| AMD64 2 | `41330973213` / `124920809825` | Same one-update misses; current zero-update is 2.72% slower |

Zero-update permits at most 2% regression. Other reported limits pass, including
identical-copy variation, counts, memory, code and stack. Larger cases show
5.4–15.6% less elapsed time. Diagnostic forward-work shares of 4.41–4.93% suggest
that this selected change's 5% whole-process one-update target was too aggressive;
the clocks perturb execution, so this is not an exact bound or a waiver.

Original-run audit `41329444021` / `124916252154` passes. AMD64-2 audit
`41336025525` / `124935921013` also passes on auditor `0a45a10e`. Every saved
observation, output, profile, image/stack size and source/reference hash agrees;
all ten failed timing limits are retained. No correctness or storage failure is
known. Three earlier AMD64 assignments were rejected before building; their
successful audits and identities are linked in the report. Do not rerun unchanged
completed timings to seek acceptance or silently weaken frozen limits.

The acceptance question remains unanswered: retain verified reductions with
these timing requirements explicitly unmet, or continue optimization until all
limits pass. Both AMD64 regressions must remain part of that decision.

## Source investigation and retained evidence

AMD64-2 measured source is `215db5dea22ebbf1e2052b69660c068959e4a2c7`.
Its zero-update C and executable hashes match AMD64-1 exactly. Guarded extraction
verifies the full archive digest and both C hashes before saving:
`/private/tmp/fwp-239-zero-fwp-ad.c` and
`/private/tmp/fwp-239-zero-fwp-ad-reference.c`.
The callback retains the input, immediately exits the loop at counter zero,
prints and releases its owners. The loop-step C body is identical in both
versions. Other emitted functions/names differ; no timing cause is established.
Use source/compiler evidence, not speculative disassembly-led allocator changes.

Retained reports and complete logs live under
`docs/measurements/derivative-record-zip-2026-11-01/`.
AMD64-2 summary artifact `13095277190`, full archive `13094323983`;
original summary `13094271343`, full archive `13094620286`.
The guarded reader verifies each downloaded summary's API digest and all
report/log hashes. Full audits ran on GitHub, without executing saved images.
Local full logs: `/private/tmp/fwp-239-timing-amd-2.log`,
`/private/tmp/fwp-239-timing-audit-amd-2.log` and
`/private/tmp/fwp-239-timing-audit-original.log`.

Immutable tags `roadmap/derivative-record-zip-sources-2026-11-01` (`844ff77f`)
and `roadmap/derivative-record-zip-audits-2026-11-01` (`215db5de`) preserve the
measured sources, frozen requirements and audit code through squash merge.

## Checks and local limits

Documentation `41335118219` / `124933194898` passes on published `0a45a10e`.
Complete log `/private/tmp/fwp-239-docs-0a45a10e.log`: 197 link sets, 106 preparation
pairs/tags, four plan steps and commit messages pass, along with all observer,
reference, archive and retention controls. Runner errors/timeouts and the
`intentional runner control` panic are deliberate tests with passing enclosing
results. This is documentation coverage, not the nine production gates.

Earlier focused guarded checks and native probe audits are recorded in the
measurement report. Latest guarded checks: small summary retention passes
(0.12 seconds); exact-source extraction passes (1.19 CPU / 2.42 elapsed seconds).
Commands use `python3 scripts/local-guard.py`; temporary readers are
`/private/tmp/fwp-239-read-retained.py` and `/private/tmp/fwp-239-read-zero-source.py`.
Streamlining initially changed the handoff's required heading/status labels;
both were restored to the checker's contract.
The new compiler-report script passes guarded Python syntax checking; workflow
actionlint and the roadmap check also pass. Native compilation/hash reproduction
must run in `record-zip-codegen` on GitHub; no local full build ran.

Disk previously stopped checks below 64 GiB. Cleanup removed only redundant old
downloads after confirming original GitHub artifacts remain unexpired and their
identities match retained logs/reports. Latest removal: six buffer/generated-check
ZIPs at sources `6eca1176`, `89fda951`, `048c92c5`, about 639 MiB. Metadata is in
`/private/tmp/fwp-239-cleanup-*-artifacts.json`; logs, source worktrees and current
PR evidence remain. Guarded checks now run, but free space fluctuates: never bypass
the 64 GiB floor, 2 GiB target limit, 1 GiB RSS limit or 180-second deadline.

Keep one active PR. Publish the next evidence/source batch together; start the
nine-job final matrix when the candidate and acceptance are settled. Merge only
after exact-head gates pass, using one explicit subject of at most 80 characters,
an empty body and no trailers or attribution. Verify the resulting merge.
