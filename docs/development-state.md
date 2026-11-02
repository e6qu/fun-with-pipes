# Current work

**Next:** publish PR #246's complete diagnostic evidence and mark it ready for
one final production/documentation run. Audit every final-head job and target
before squash merge; keep the source unchanged while those gates run.

## Branch and delivery

- [PR #246](https://github.com/e6qu/fun-with-pipes/pull/246): branch
  `array-consumption-diagnostics`, worktree `/private/tmp/fwp-array-consumption`.
  It contains the diagnostic, regression controls, findings and plan updates.
  No compiler/runtime code changes. Preserve the primary checkout.
- [PR #245](roadmap-history.md#direct-numeric-array-callbacks-pr-245) passed all
  nine production jobs and documentation at `d53fb07a`; full logs/target archives
  were audited. Squash `c43f05c22ed36277b491490b7d9e222dfd0af025` preserves the
  tested tree and one-line message, with no body/trailers. Duplicate same-tree
  main runs `41471361931` / `41471361814` were cancelled.
- Final merge requires nine exact-head production jobs plus documentation,
  all log audits, an explicit subject of at most 80 characters and an empty
  squash body. Verify the message and tree. Keep one active PR.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | [Retained sample analysis](measurements/array-sample-positions.md) replays both four-session datasets without dropping failures |
| 2 | Verified | Native exact-result, ownership, omitted-release and failed-clock controls pass on both GCC architectures |
| 3 | Verified | [All four sessions](measurements/array-consumption-2026-11-02/README.md) and complete archives independently audited; seven pre-build CPU rejections retained |
| 4 | Verified | Preparation changes page-fault/copy observations; original consumption limits remain open. Next: freeze original/observer-only/zero-preparation driver comparison |
| 5 | In progress | Publish full evidence, run final gates once, audit and squash merge |

## Evidence identities

- Frozen protocol: `5a581248`, tag `roadmap/array-consumption-protocol-2026-11-02`.
- Measured source: `87d4f6b099b755a52cd091b6c07cb57bb456af77`, tag
  `roadmap/array-consumption-control-repair-2026-11-02`.
- [The initial harness failure](measurements/array-consumption-setup.md#harness-repair-before-timing)
  expected an extra instrumented release check. Both full ARM logs and all 28
  completed commands were audited; no timing started. The corrected expectation
  preserves zero-live-storage and omitted-final-release controls. Two queued
  AMD64 copies were cancelled before starting.

| Session | Run / job | Artifact | Full archive audit |
|---|---|---|---|
| ARM64 1 | `41472025679` / `125367826083` | `13154414998` | Pass, 1.93s |
| ARM64 2 | `41472025679` / `125367826052` | `13155741912` | Pass, 1.88s |
| AMD64 1 | `41472493298` / `125369442114` | `13157230350` | Pass, 1.76s |
| AMD64 2 | `41475998964` / `125381620085` | `13156803999` | Pass, 1.89s |

Every source, command, binary identity, profile, failure control and raw sample
was replayed independently. Full job logs contain no unresolved diagnostic.
No completed timing was repeated. [The report](measurements/array-consumption-2026-11-02/README.md)
explains timer boundaries, all copies/settings, memory, instruction and stack costs.
Its compact replay checks all raw outputs and the 64-role CSV; it does not replace
the full native-archive audit.

## Checks and resources

Guarded checks pass: five harness tests (0.14s), both failed-profile/command
replays (0.14s), all 48 retained C variants (0.38s), and complete compact replay in
write/check modes (2.33s each). The report writer's local variable-shadowing bug
was fixed before publication; both modes now pass. The stale derivative-fold
validation paragraph now records its completed #242 verification and open limits.
No local compiler build, full suite or benchmark.

The guard stopped at 63.9 GiB free disk. Removed only two clean temporary worktrees
whose trees matched verified merged #243/#244, preserving commits and evidence;
primary/active checkouts remain. Duplicate nested failure-archive inputs were
hash-checked against retained originals before removal; every unique file remains.
Free space recovered to about 64.7 GiB. Keep at least 64 GiB free, sampled workload
RSS below 1 GiB, target data below 2 GiB and the 180-second guard deadline.
Use `python3 scripts/local-guard.py` for focused work; full gates stay on GitHub.
