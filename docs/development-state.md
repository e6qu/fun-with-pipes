# D1 measurements while PR #225 completes CI

**Next:** audit output diagnostics `40818110583`/`40818973752` and finish D1's repeated-host/control requirements before selecting D2.
Keep PR #225's repair moving in `/private/tmp/fwp-cpu-phases`; do not open another PR.

Worktree `/private/tmp/fwp-ad-refresh`, branch `ad-cost-refresh`, published source
`21a1de329c8e4cec1b9ba7cd284c9be876facf5c`, based on 18ae46cd. D1 run `40816041693`
passed all four jobs: ARM1 `123257213984`, ARM2 `123257214031`, AMD1 `123257213972`,
AMD2 `123257213962`. Full logs and artifacts are audited with guarded
`/private/tmp/fwp-audit-descent-refresh.py`: each session has six cases, 80 actual
images, 68 stack reports, independently checked analytic outputs, all 56 rounds,
managed/raw profiles, workspace on/off, phase observations and broken controls.
No downloaded images were executed. All four logs have no unexpected diagnostics;
the logged checksum-rejection shell condition is not a reported checksum failure.
Artifacts: `/private/tmp/fwp-descent-refresh-{arm,amd}-{1,2}`; logs
`/private/tmp/fwp-descent-{arm,amd}-{1,2}.log`. CPU/compiler IDs are retained.

Both ARM sessions use Neoverse-N2. AMD1 uses EPYC 7763, AMD2 Xeon 6973P-C: retain
both, do not pool them as repeated same-host evidence. Short-case identical-code
ratios are noisy (Xeon 3:199 about 1.098). No timing budgets or optimization
acceptance established. Largest AD-current case makes 1,103,785 managed requests
and 868,237 retains; raw parent/weight buffers are reused across updates and raw
storage is zero after shutdown. Forward-with-recording dominates the observed
six phases but includes objective/list work, not just tape appends.

Read [the D1 protocol](measurements/descent-costs.md) and [PLAN.md](../PLAN.md).
Output-cost refresh `40818110583` runs at 21a1, two native hosts using the existing
longer full-output/shared-checksum protocol. Do not repeat the full production
matrix for this diagnostic. The exact reports/logs and 2,228 artifact identities are archived; the archive
verifier and six rejection controls pass. Matched repeated hosts and budgets remain; D2 and D3 are not implemented. Observer clocks can report zero
for tiny phases; zero is below clock resolution, not free computation.

All local checks use `scripts/local-guard.py` serially: four Clang phase groups,
three historical budget groups, Python syntax/actionlint/docs, and four complete
artifact audits passed. No full local fwp builds, suites or benchmarks.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees; no universal ARC-free claim |
| 3 | Verified | Maintain scoped F1–F3 call/recursion guarantees |
| 4 | In progress | Finish PR #225 repairs and final production gates |
| 5 | In progress | D1 output and repeated-host budgets, then D2/D3 |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 baselines and integrity checks |
| 8 | Pending | V1–V2 larger-program correctness and scale |

## Active PR to finish first

PR #225 at 18ae46cd, production `40813465621`, has confirmed Windows LF/CRLF oracle
failures and a macOS ARM regular artifact-read failure after all tests passed.
Local CPU-worktree repairs remove fixture line endings, publish Windows failures
earlier, and verify evidence archives with per-file failure diagnostics before
direct upload. EILSEQ's original cause is unresolved. Docs, benchmarks and macOS
ARM ownership pass/audited; other suites still run. Finish all-log audit then batch
repairs and require nine production jobs plus docs at the repaired head. Squash
one line <=80 chars, empty body, no trailers/attribution; verify tested/merged tree.
Rebase this branch onto that verified squash before opening its PR, retaining
measured 21a1 with a source tag. No runtime changes on this branch. The output checker now uses current
`fwp_heap_` collector names; 21a1 checked the obsolete `fwp_gc_` prefix. Audit
actual output images with the corrected check; this does not change timed code.

Primary checkout is detached at #209: preserve its recovery pointer and untracked
compiler-abort report. Historical Intel abort remains unexplained. About 71 GiB
free; guard limits remain unchanged. No agents.
