# Current work

**Next:** verify the formatting-only repair on all three hosts, then run the
untimed whole-solve allocation comparison before compiler/runtime timing.
[Run 41917699225](https://github.com/e6qu/fun-with-pipes/actions/runs/41917699225)
at `8fa9f890eea2f0efbfa6f45d2e5fd76bda430e5f` passes all native checks but fails
one old fixture's formatting. GCC ARM64 `126881638472`, GCC AMD64 `126881638843`,
Clang ARM64 `126881638830`: all 285 units, 103 integrations, twelve complete-program
selections, 660 images and 671 statuses per host are audited. The repair uses the
exact saved formatter bytes and passes local production-formatter checks.
The immutable tag `roadmap/owned-numeric-premerge-checks-2026-11-04` preserves this
source and its earlier failed runs. A source tag is not a passing result.

Worktree `.worktrees/owned-numeric-updates`, branch `owned-numeric-updates`.
[Draft PR #258](https://github.com/e6qu/fun-with-pipes/pull/258) is the only open
delivery PR. Its head `3b5adde4` is based on #257's verified squash. Rebase checks
confirm the complete tree stayed unchanged and all compiler/runtime/library/test
inputs match the running `8fa9f890` verification. Original identities remain tagged.
Keep full builds, native suites, benchmarks and large regeneration on GitHub.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve frozen ownership, selection and measurement contracts |
| 2 | In progress | Native behavior passes on all three hosts; verify the formatting-only repair and audit all final results |
| 3 | Pending | Exact whole-solve allocation census, compiler costs, two timing sessions per architecture and independent audit |
| 4 | Pending | Grouped PR, nine exact-head production jobs plus docs, verified squash/tree |

## Implemented and checked

Both private operations consume an input owner. Same-type scalar array maps reuse
only ordinary exclusive arrays. Array/list zip finishes callbacks before reusing
an exclusive list prefix; shared suffixes are copied. Views and aliases remain
unchanged. Cleanup protects transferred inputs, partial outputs and scratch storage.

The contract was frozen at `1c5e6a66`, tag
`roadmap/owned-numeric-updates-protocol-2026-11-04`. Initial source `b8404dbb`
passes 282 units (four ignored) and 103 integrations on GCC ARM64/AMD64 and
Clang ARM64. [Retained safety evidence and the selection diagnosis](measurements/owned-numeric-selection-2026-11-04/README.md)
show why this was insufficient: current-only solves selected neither operation;
history selected only zip. Emitted-C temporaries are introduced after selection.

Extension proof `c99451ec`, tag `roadmap/owned-numeric-selection-proof-2026-11-04`,
precedes compiler repair `9f8ec909`. The repair admits returned array owners and
eligible constructor fields; ordinary-call arguments and resource anchors remain
excluded. Earlier fields get their own owners before later consumption.

[Run 41914912241](https://github.com/e6qu/fun-with-pipes/actions/runs/41914912241)
checks that repair on all three hosts: 285 units, twelve complete-program checks,
seven consuming exports, one retained-input exclusion and 102 integrations pass.
The new temporary-result/earlier-field probes cover outside aliases, allocation
counts, failure and cancellation. All eighteen target logs, full logs, 656 images,
667 statuses and diagnostics were audited. No compiler warnings were found.

All three jobs fail one older zip test: it requires a borrowing helper comment,
but the fixture's eligible calls now consume their inputs. Repair `8fa9f890` adds
an explicit later input read/returned alias, requires both consuming positions,
checks exclusions against both representations and saves code/results before
assertions. It preserves raw/optimized interpreter comparison, native O1/O2,
stack settings, eager output order and final cleanup. Compiler/runtime trees are
unchanged. The failed runs and repair are retained together; no failure is hidden.

That repair now passes native verification. The expanded fixture-format check
also found an existing three-line `subtract` definition that the formatter puts
on one line. This is the only new failure on all three hosts; both saved fixtures
match the repair. [Evidence and exact before/after](measurements/owned-numeric-selection-2026-11-04/README.md#native-checks-pass-an-older-fixture-needs-formatting)
retain every outcome. No compiler/runtime or test assertion changes are needed.

## Measurement gate

No whole-solve saving or speedup is claimed yet. The [contract](measurements/owned-numeric-updates.md)
predicts 25,741 fewer requests / 819,968 fewer requested bytes per 129-coordinate,
199-update solve. `owned-numeric-census` checks all six cases, both result forms
and workspace reuse on/off against a same-source reference disabling only these
two transformations. Any unexplained difference requires diagnosis before timing.

After successful native verification, freeze the measurement source, run the census,
then `owned-numeric-analysis`, `owned-numeric-time` (both sessions) and
`owned-numeric-report`. Supply the verified safety run as `evidence_run`; workflow
guards compare compiler/runtime/library/tests/build trees. Preserve original
failed limits; never rerun unchanged timings to obtain a pass.

## Verified previous delivery

#257 merged as `30c2bad9b89d8086a8822f992eaa0e9331bd9bd1`, tree
`df3c0d3e430636edd390ac33d4254fec7095381b`, identical to tested `519fc966`.
All nine production jobs and documentation pass, with every full/target log audited.
[Final gate identities, logs and capacity cancellations](measurements/packed-input-checks-2026-11-04/platforms/final-gates.json)
are retained. The squash message is exactly one line, under 80 characters, with
no body or trailers. Duplicate same-tree main runs `41918420647` / `41918420613`
were cancelled. [History](roadmap-history.md#packed-derivative-inputs-pr-257)
records measurements and three still-open AMD64 timing limits.

## Local checks and resource use

All focused checks/collection use `python3 scripts/local-guard.py` serially.
Limits remain 64 GiB free disk, targets below 2 GiB, sampled RSS below 1 GiB and
180 seconds. No local full build, native suite or timing was run.

- Selection repair: formatting, workflow lint, three observer, ten compiler-driver,
  five consuming-reference, five packed-reference, six gradient-reference and five
  census controls plus roadmap audit pass in 15.01s.
- Test repair: formatting, workflow lint and roadmap audit pass in 12.01s.
  Full three-host failure audit/retention: 1.56s.
- Formatting-only repair: both fixtures pass the verified #257 macOS ARM64
  formatter, 0.51s. Formatter/parser sources are unchanged. Saved package and
  identity/check report: `../gradient-work/verified-257-compiler` and
  `owned-numeric-format-check.json`. Use this only for unchanged formatter checks;
  it does not verify the new compiler transformations or create a build dependency.
- #257 final collection: 9.03s; squash verification: 0.14s; retention: 0.13s.
- Removed the clean `matched-option-fields` checkout only after its tree matched
  #256's verified squash. About 721 MiB of duplicate checkout data removed; branch
  and CI evidence retained. Identity/size check: 0.14s; removal: 0.37s.
  Earlier verified removal of duplicate #256 downloads freed 778,568,743 bytes.
  Removed another 791,742,404 bytes of duplicate #257 Windows downloads only after
  checking artifact digests and all 157 retained logs per host (0.73s).

Scratch evidence/helpers: `../gradient-work/owned-numeric-checks-2` (original
passing safety), `owned-numeric-checks-3` (selection repair and old assertion),
`owned-numeric-checks-4` (all native checks pass; old fixture formatting),
`platforms-257`, `collect-owned-numeric-checks.py`,
`collect-matched-option-platforms.py`, `retain-packed-input-delivery.py` and
`owned-numeric-pr.md`. Use a new output directory for each new run. Keep failed
outcomes. Leave unrelated dirty primary/older worktrees alone.
