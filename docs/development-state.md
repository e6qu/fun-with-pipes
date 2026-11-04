# Current work

**Next:** publish the grouped final-iteration PR, then audit all nine production
jobs and documentation at its exact final head. Fix all encountered failures
before one repair push; squash only after every gate passes. Measurements are
complete and must not be repeated for a pass.

## Final iteration values

Branch/worktree: `iteration-final-value`, based on verified main `379bc9d5`.
No delivery PR yet. Compiler, runtime, library, tests and build inputs match
measured `bb5433b688c26c60f0b2561a59420deb0f0e95ed` byte for byte after rebase.
The immutable tag `roadmap/final-iteration-measurement-2026-11-04` retains that
source; `roadmap/final-iteration-pre-delivery-2026-11-04` retains the development
history. Do not move either tag.

[Contract](measurements/final-iteration-storage.md) frozen at `2a257a3e`, tag
`roadmap/final-iteration-storage-protocol-2026-11-03`.
Implemented together: direct `last`; exact single-use numeric `iterate` → `last`
owner transfer; interpreter/native count-bound agreement; optional-wrapper cleanup
when retaining a child fails. Shared histories and resource-bearing iteration
states remain excluded. The Windows probe repair from #254 is in the base.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve the frozen selection, count and ownership rules |
| 2 | Verified | Preserve three-host values, effects and physical cleanup checks |
| 3 | Verified | Keep complete measurements and all timing misses explicit |
| 4 | In progress | Publish, audit all final-head gates, squash and verify the tree |

## Previous delivery

[#254](https://github.com/e6qu/fun-with-pipes/pull/254) merged November 4 as
`379bc9d553b15dfbadaa9cca1edc58c17897774e`. Its tree equals tested `8bf9c65b`.
Nine production jobs (run `41713252299`, attempt 2) plus documentation
(`41713252267`, job `126186525051`) pass. Every full and target log is audited;
[gate records](measurements/scalar-array-identities-2026-11-03/platforms/final-gates.json)
retain source, artifact hashes and logs. The Intel upload retry passes 126 targets;
its original DNS failure and both Windows stream repairs remain documented.
The collector now selects the artifact ID printed by the exact job, because
GitHub kept both attempts' identically named target archives.

The squash message is exactly `Preserve float bits and remove redundant F64 array copies`,
one line with no body or trailers. Duplicate main runs `41796239060` and
`41796238994` were cancelled while queued after checking their identical source
and absence of failed steps. Full final-log audit: 5.68 guarded seconds;
retention and squash/tree verification: 0.13 seconds.

### Verification

[Focused run 41726742943](https://github.com/e6qu/fun-with-pipes/actions/runs/41726742943)
passes on GCC ARM64/AMD64 and Clang ARM64. Each host passes 268 units (4 ignored),
46 integrations across nine targets, twelve selection checks, primitive inventory,
docs and tutorial. Full logs, 418 native execution/image observations and eleven
interpreter/inventory statuses are audited. All 240 scalar count rows agree across
hosts. [Results and retained evidence](measurements/final-iteration-storage-2026-11-03/README.md).

For positive scalar count k, old/direct/selected totals are **2k+2, k+2, 1**.
The selected loop removes 2k list nodes and one temporary pointer buffer. This
count reduction does not establish runtime speed or whole-process peak memory.

Earlier failures are repaired and retained: private test import (`41715801311`),
missing test list layouts (`41720302662`), omitted scratch-buffer count
(`41723211349`). Their reports are linked from the verified-results page.
Compiler/runtime/library code has not changed since `f599dfba`; later fixes correct
fixtures and measurement tooling. Original source IDs remain reachable by the tag.

### Complete measurements; delivery remains

- Compiler run `41729365239`: all 480 commands, inputs, native compiler images and
  raw records are audited. Nine timing cases pass; AMD64 field-transfer copy
  variation is 2.043% against 2%, so it remains inconclusive. All observed memory
  ratios pass. [Results](measurements/final-iteration-analysis-2026-11-04/README.md).
- Runtime runs `41729376533` (ARM64) and `41730462251` (AMD64): all four sessions
  complete. Raw audits `41732080777` / `41733338891` pass; all 5,336 file records,
  full logs, reference sources, commands and native images reconcile.
- [Complete results](measurements/final-iteration-time-2026-11-04/README.md): largest
  history-form peak managed storage 838,688 → 19,360 bytes (97.7% less); 5.1–5.9%
  faster. Each 199-update solve saves 400 requests, 11,192 requested bytes and
  399 retains. Current-form counts and raw storage are unchanged; final storage
  is zero. All 48 count comparisons agree across hosts and workspace modes.
- Keep six runtime timing misses open: ARM64 3/199 and 33/199 history in both
  sessions; AMD64 session 1's 33/199 history; AMD64 session 2's 3/1 history is
  2.79% slower against 2%. All identical-copy controls pass. No timing was rerun.
  Two initial wrong-CPU AMD64 hosts stopped before building/measuring and are retained.
- No reported frame growth; native text changes −528 to +1,120 bytes. C/Rust use
  manual gradients and different storage; their ratios do not isolate language overhead.
- Both reference compilers retain count/cleanup repairs. Frozen source/tag remain
  `bb5433b6`; docs-only commits do not change those measured programs.
- Reconciliation onto #254 is complete; measured code and tests are unchanged.
  Require nine final-head production jobs plus docs. No final matrix is dispatched.
- Follow-up after this group's delivery: complete the
  [matched-option ownership proof](measurements/remaining-gradient-storage.md#follow-up-an-immediately-matched-optional-result).
  Saved C confirms an optional wrapper and payload retain before immediate match;
  this is a bounded source finding, not a timing diagnosis. No implementation yet.

### Local checks and resume tools

- After rebase: measured compiler/runtime/library/test/build inputs are identical;
  documentation audit passes 256 link sets, 106 immutable tags and four roadmap
  steps (2.57 guarded seconds). Only delivery records and explanations changed.
- Guarded focused checks: formatting 1.70s; docs (253 link sets) 2.55s; workflow
  lint 6.85s; inventory 395 declarations/374 contracts, baseline unchanged;
  shard coverage 255 targets. Final focused evidence audit 1.85s, retention 3.82s.
  Updated documentation checks pass (255 link sets, 3.15s). Runtime collections
  5.93s/6.04s; complete retention 0.48s; 48-count audit 0.26s; report 0.25s.
  Compiler audits 45.24s/4.85s. All under the guard.
- Scratch collectors/auditors live in `../gradient-work`: `collect-final-platforms.py`,
  `collect-final-iteration-checks.py`, `audit-final-iteration-success.py`,
  `audit-final-iteration-analysis.py`, `collect-final-iteration-runtime.py` and
  `audit-final-iteration-rejected-hosts.py`. Collection alone is not acceptance.
- Run focused checks serially with `python3 scripts/local-guard.py`. No local full
  builds/suites/benchmarks; never bypass disk, RSS, generated-data or deadline limits.
- Preserve dirty primary and old worktrees. Keep one active delivery PR.
