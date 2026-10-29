# Next: finish the scalar derivative comparison

**Next:** monitor all four `descent-recording` jobs in run `40837836845` at
`98b252a8`, audit every case and apply the unchanged limits. Then archive the
results, run final production/docs and G2 gates, and squash-merge PR #226 only
if all acceptance checks pass. Continue with N1–N2 afterward.
Worktree `/private/tmp/fwp-ad-recording`, branch `ad-recording-costs`; PR #226 is draft.

## Active comparison

All hosts qualified before measuring: Neoverse-N2 ARM64 and EPYC 7763 AMD64.

| Session | Job |
|---|---:|
| ARM 1 | 123326735077 |
| ARM 2 | 123326735019 |
| AMD 1 | 123326735071 |
| AMD 2 | 123326735037 |

Two compilers use the same source; the reference disables only the scalar
`ad.push` no-escape fact. Its exact patch and binary hash are retained. The
[fixed limits](measurements/descent-costs.md#fixed-scalar-recording-acceptance-rules)
were published at `fde368c8` before implementation: 5% less time with updates,
at most 2% zero-update regression, a 2% identical-copy control, per-node allocation
savings, unchanged raw storage and bounded code/stack growth. Do not adjust limits
after seeing results. Keep all samples, slower cases and failed controls.

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
| 5 | In progress | D2 paired acceptance and final grouped native gates |
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
