# Next: verify the grouped derivative PR on every native platform

**Next:** verify the complete repair head of [PR #226](https://github.com/e6qu/fun-with-pipes/pull/226/checks)
on all nine native jobs, documentation and both G2 hosts. Fix any failure before
squash-merging. Worktree `/private/tmp/fwp-ad-recording`, branch
`ad-recording-costs`. Earlier results below do not replace final-head acceptance.
D2's speed goal remains open. [PLAN.md](../PLAN.md#5-differentiation) names the
next source investigation; `/private/tmp/fwp-next-d2-notes.md` keeps its detailed
hypotheses, not accepted improvements.

## Grouped CI repairs

Original native run `40849857724` at `04efac8a` finds one shared failure: the
foreign-callback test expects an anonymous State record. The inference repair
correctly retains `CallbackWords {first = "first", second = "second"}`. The
expectation now preserves that name and prints actual output on mismatch.
Its ownership/unwind checks are unchanged.

Every original target log is audited, including passing targets and diagnostics:

| Jobs | Summaries per job | Passed / failed tests | Result |
|---|---:|---:|---|
| Linux ARM64 / AMD64 | 257 | 986 / 1 | Callback expectation only |
| Regular macOS ARM64 / AMD64 | 132 | 621 / 1 | Callback expectation only |
| Windows ARM64 / AMD64 | 202 | 804 / 1 | Callback expectation only |
| macOS ownership ARM64 / AMD64 | 127 | 362 / 0 | Pass |
| Benchmarks | 2 | 2 / 0 | Pass |

All final SDK, packaging and evidence steps pass. Full completed-job logs are
`/private/tmp/fwp-226-*-04ef.log`; target ZIPs are
`/private/tmp/fwp-226-*-tests-04ef.zip` and `*-tls-04ef.zip`. No unexpected compiler
diagnostic remains. Optional golden-failure uploads now allow absent files when
an unrelated test fails; mandatory test logs and ownership evidence stay checked.

Guarded reproduction uses the exact macOS ARM64 CI compiler, SHA256
`f2a5d60eac96e6d8566a6ebc869544b60820125ad63aa9a04c84ea3567a850b9`, under
`/private/tmp/fwp-226-compiler-04ef/fwp-macos-arm64/fwp`. The complete extracted
fixture in `/private/tmp/fwp-foreign-nominal-check` agrees between raw execution
and native Clang O1/O2 (8.44 CPU seconds, 17.08 elapsed). This does not replace
final CI's ownership ledger and deliberately broken cleanup controls.

G2's failed short-sample run `40849863932` at `04efac8a` is fully retained:
Intel N=32 ratio 1.578 versus 1.5, with sixfold sample variation; Linux passes.
The test-only repair at `516a10a5` uses 12 rounds of 64 fresh proofs per label,
an identical Separate copy and all six orders twice, with unchanged budgets.
Both hosts pass run `40852937323`: Linux job 123376682693 and Intel 123376682309.
Each passes 223 tests/3 summaries, Clippy and all limits. Independent audit checks
all 13,824 timings; identical variation is at most 0.11%/2.47%. The
[protocol and records](measurements/ownership-analysis.md#current-measurement-repair-longer-samples-and-an-identical-control)
retain both failures and passing observations without claiming an analyzer speedup.
Production analysis code is unchanged. Docs `40849828831` at 04efac8a and
`40852906453` at 516a10a5 pass with full-log audits.

## Completed comparison and delivery decision

Run `40837836845` at `98b252a8` completed all four qualified sessions:
ARM jobs 123326735077/123326735019 and AMD jobs 123326735071/123326735037.
All logs, 368 images, 320 stack reports, outputs, timing rounds, storage ledgers
and broken controls are audited. The combined performance decision is rejected:
every one-update form misses the 5% reduction, as do some AMD history cases.
One AMD one-update result is 1.42% slower; all allocation/code/stack/cleanup
limits pass, and identical-copy variation stays within 1.63%.

**The user explicitly chose to keep the proven allocation reduction and leave
D2's speed goal open.** Do not change the frozen limits or relabel this experiment
as accepted. The [result table](measurements/descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open)
and [archive](measurements/descent-recording-artifacts-2026-10-29.json) preserve
all four reports/logs, reference patches, failures and 5,352 file identities.
The archive checker recomputes the failures and tests reject erased failures,
changed references or a false acceptance label.

## Verified focused work, not final platform acceptance

Scalar recording is implemented at `8e299f9f`. The runtime copies four scalars
before buffer growth and returns an immediate node ID; no record pointer escapes.
Existing escape/borrow analysis can keep the argument on the stack. Typed
`ad.push-owned` is excluded. The native fixture records 256 identity operations:
all O1/O2 and workspace-on/off combinations report 256 heap argument records with
stack storage off, zero with it on, and derivative 1. Cleanup checks pass.

Both Linux architectures pass all seven ownership/scope tests, 240 focused Rust
tests, native nominal selection, the frozen primitive inventory and 17 measurement
controls at 8e299f9f. Full logs/artifacts are in
`/private/tmp/fwp-recording-8e29-{arm1,amd1-checks}.log` and
`/private/tmp/fwp-recording-8e29-{arm,amd}-checks.zip`. Four ignored library tests
are excluded from the counts. The overwritten-caller-record probe retains
failure/cancellation/mixed/stale/wrapping controls.

The inference repair at `a31f24c4` preserves named records through shared field
selectors while making field/effect constraints available immediately. Three
production type-table tests cover aliases, independent selectors and infinite
phantom types. Focused run `40829434472` passes both Linux architectures.
G2 run `40829442112` passes Linux and Intel macOS, including all-target Clippy:
64-worker separate/merged ratios stay below 1.5, forms/entry analysis below 10 s,
and both modes use nine waves. Final grouped acceptance still remains.

## D1 baseline and D3 depth costs

D1's four repeated-solve sessions at `a31f24c4` pass run `40829884152` and their
complete evidence is audited: 4,628 file identities, every output/sample, 80
images and 68 stack reports per session, both storage ledgers and broken controls.
Original ARM jobs are 123301407687/123301407660; AMD jobs are 123301407679 and
replacement 123315775454. The rejected first AMD assignment used EPYC 9V74 and
never measured. Largest identical-copy median variation is 1.66%, within 2%.
[The report](measurements/descent-costs.md#repeated-solve-results) owns the data,
original execution identities, C/Rust differences and earlier noisy baselines.

D3's post-candidate run `40837334009` at `8e299f9f` passes ARM job 123325109478 and
AMD job 123325109603. All 18 cases, 74 images, 76 stack reports, analytical outputs,
release checkpoints and both leak controls per host are audited. All ledgers end
at zero. [The depth report](measurements/ad-depth.md) retains before/after costs:
F64 allocations fall, peak storage and F128 counts do not. Short process timings
are diagnostic. The earlier baseline at `89bbec5b`, run `40834762049`, remains
archived separately. CI verifies both archives and rejection controls.

## Repairs and retained failures

- Depth measurement set `FWP_REUSE=1`, an environment variable the runtime does
  not read. Actual reuse was enabled: all 144 archived ordinary C sources and
  their flags omit the disabling `FWP_NO_REUSE` macro. New runs explicitly use
  `-UFWP_NO_REUSE` and reject generated sources defining it. The archived settings
  remain unaltered and the depth report explains the unused historical field.
- Scalar comparison progress now prints after each case's evidence is saved,
  outside the timed processes; long jobs no longer remain silent until all cases
  finish. This changes no measurement or runtime behavior.

- Docs run `40840306812` at c8ddbc7d passes and its complete log is audited.
  Earlier docs run `40839703501` at 5ba37b25 found a code-fence closing line joined
  to prose, hiding the acceptance heading. The fence/prose separation is repaired
  and the full local link/anchor check rerun. Timing jobs use unchanged code.

- Run `40836575689` at 8e299f9f passed focused tests, then both ARM measurements
  failed after 98 zero-update rounds: report generation still expected the old
  `fwp-explicit` label. `98b252a8` derives rows/columns from actual variants.
  Partial logs/ZIPs: `/private/tmp/fwp-recording-8e29-arm{1,2}.{log,zip}`.
- The same run's AMD hosts were EPYC 9V45 and rejected before building. In
  replacement `40836866148`, AMD session 2 rejected EPYC 9V74. Session 1 passed
  focused checks and saved artifacts; its superseded reference build was
  cancelled before the known-broken measurement. No timing result was discarded.
- Depth preparation at b349, run `40833238845`, missed the typed backward-release
  observation. The repair records real release after typed values and raw parents
  are freed, one checkpoint per derivative level; it inserts no cleanup.
- Earlier inference attempts at `9d843129`/`61689688` failed in io/websocket/rest
  and were removed. `226a2b40` fixed those but needed the intended named `Acc`
  output snapshot. `a31f24c4` passes all focused regressions. Original logs remain.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | Final grouped native gates; D2 whole-program speed goal remains open |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |

## Delivery and local checks

PR #225 merged as `6735c4e3` after all nine jobs and docs passed and every log
was audited. Squash and test head fbed share tree `f70bc35d25a9e8fb566ed085f8afab65fb2a9f48`;
one-line message verified, duplicate push CI cancelled. [History](roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225)
owns the outcome. This branch merged main without changing a31f's measured tree.

Primary checkout remains detached at #209 with a recovery pointer. Preserve its
untracked compiler-abort report; the original Intel abort is still unexplained.
Other worktrees retain evidence; do not restart delivery there. No agents.

Local checks use `scripts/local-guard.py`, serially: 64 GiB free, target <2 GiB,
RSS <1 GiB, 180 seconds. About 66 GiB free, no local build tree. Guarded ownership
units, frozen inventory, formatting, workflow lint, archive audits and rejection
controls pass. Full builds/suites run on GitHub. Preserve artifacts as ZIPs locally.

Latest guarded checks: full four-session recording ZIP/log audit passes;
`test-descent-groups.py` passes 9 tests, `test-ad-depth.py` passes 5, and
`test-descent-baselines.py` passes 6. Reports keep
1334 files per recording session and all four reference artifacts. No native
code changed after 8e299f9f; final platform gates are still required.

The final local documentation audit passes all 177 link sets, 106 immutable
preparation pairs and 8 roadmap steps (0.35 CPU seconds, 2.88 elapsed). The changed
workflow passes actionlint; callback test formatting and `git diff --check` pass.
