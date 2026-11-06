# Current work

**Next:** publish the verified capacity measurement receipts and frozen
`docs/measurements/recording-capacity-call-inputs.json`, then dispatch
`recording-call-analysis` with that explicit plan on both architectures. Require
all 48 original native images and intended capacity inlining before final gates.

Branch `recording-capacity-gate`, worktree `.worktrees/recording-capacity-gate`.
[PR #264](https://github.com/e6qu/fun-with-pipes/pull/264) is the only active PR,
currently draft. Current pushed head `a7665661ea6df7640a6dd9ee3aba9daa8512de3e`;
new measurement receipts and status updates are local pending publication.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | PR #263 delivery retained; capacity contract frozen before edits. |
| 2 | Verified | Corrected three-host checks, full audits and 116 tool controls pass. |
| 3 | In progress | Memory/compiler/runtime results audited; verify original images and capacity inlining. Retain all timing misses. |
| 4 | Pending | Final nine-job matrix, docs, full audits and verified squash merge. |

## Sources and completed checks

- PR #263 merge `53bd2d78e7a19afc5c7f697bf22ee380c4f9b2ac` exactly matches tested
  tree `c7bef970b64dc07dc487592a14402b8d46ccf388`; subject is one line, 42 chars.
  [Delivery receipt](measurements/recording-inline-delivery-2026-11-06/README.md).
- Capacity [contract](measurements/recording-capacity.md) frozen at
  `10b275c0eec9b7cb51921bce282ea4cf758d0a84` before edits. The reference recreates
  the old runtime byte for byte; growth/check order and failure cleanup remain.
- Initial source `4e8fbfd9` remains tagged
  `evidence/recording-capacity-initial-2026-11-06`. Its full audit found only
  Rust line wrapping; all native targets passed. [Initial receipt](measurements/recording-capacity-initial-2026-11-06/README.md).
- Corrected source `51edfc0e7884e1a75201bc9876fd13cb8ca25eee` passes focused run
  `42177517863`: AMD `127759292851`, ARM `127759293082`, mac `127759293154`.
  Full audit `42179352168` / `127765102666` passes. All 25 targets, 864 images
  and 880 observations per host, plus 8,304 retained records verified.
  [Corrected receipt](measurements/recording-capacity-checks-2026-11-06/README.md).

## Combined measurements: original source 51edfc0e

- [Memory](measurements/recording-capacity-census-2026-11-06/README.md): producer
  `42179964294` jobs AMD `127767049412`, ARM `127767049900` pass. Full audit
  `42181326578` / `127771398833` passes. Counts, peaks and largest frames
  unchanged; final storage zero. All 4,038 retained record hashes verified.
- [Compiler](measurements/recording-capacity-analysis-2026-11-06/README.md):
  producer `42179974129`, AMD `127767078406`, ARM `127767078878`, passes.
  Repaired audit `42182313740` / `127774534662` passes: all 14 comparisons
  qualify, 672 commands and 2,162 retained records verified.
- [Runtime](measurements/recording-capacity-time-2026-11-06/README.md):
  producer `42179983250`, AMD1/2 `127767111308` / `127767111269`, ARM1/2
  `127767111350` / `127767111433`. All hosts qualified; none replaced.
  Full audit `42183074888` / `127776942929` passes, preserving four failed
  producer jobs. All report/log hashes, archive digests and budgets verified.
- Long gains 1.86–14.02%; 17/32 meet 5%. Fifteen three-coordinate results miss;
  only AMD2 3/1999 history meets 5%. All larger cases pass. AMD2 3/1999 current
  has 2.2188% copy variation (limit 2%), so remains inconclusive. Small-case
  maximum regression 1.153%; no qualified timing repeated. All older limits
  in PLAN.md remain open. C/Rust peers use handwritten derivatives.

## Audit repair and local verification

First compiler audit `42181226529` / `127771091070` failed on both architectures:
Git and difflib align repeated braces differently. Repair `a7665661` validates
exact patch input/output, hunk positions/counts and newline markers. The complete
reference test now uses real Git diff. Production and measured compilers unchanged.
[Failed evidence and repair](measurements/recording-capacity-audit-repair-2026-11-06/README.md).

[Repair controls](measurements/recording-capacity-repair-controls-2026-11-06/README.md)
`42182321875` / `127774561016`: 15 suites / 116 tests pass, including historical
archives omitted from this sparse local checkout. All suite/full logs and digest
verified. Docs `42182289922` / `127774447845` pass; complete log has exactly the
three deliberate runner-failure controls. Draft CI `42182289841` is skipped,
not native platform evidence. Initial 114 controls also remain retained.

Guarded local checks: 4 complete reference tests (0.85s), 20 focused shared-reader
controls (0.94s), compiler/census receipt hashes (0.23/0.25s), runtime retention
and budget reconciliation (0.24/0.47s), docs links (0.13s). A local full Python
control target lacked four historical archives; its full CI run now passes.
No native build, full suite or benchmark ran locally. Last free disk about 78 GiB.

Scratch: `../gradient-work/capacity-*`, `../gradient-work/recording-capacity-*`,
`/tmp/fwp-capacity-*`, `/tmp/fwp-retain-capacity-*`. Do not rerun one-shot source
edit helpers. Keep status-only edits local while final-head gates run.
