# Exact scalar constants: delivery

[PR #261](https://github.com/e6qu/fun-with-pipes/pull/261) merged as
`2e6e09f539bcdab965d062f0184b585b340b29d8`. Its tree exactly matches tested
source `80e4ee7b483d4881801eed3ff3b12c312b4ec868`. The verified squash message
has one 50-character line, with no body or trailers.

- All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42080858908) pass.
- [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42080855434) passes at the same source.
- The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42096023194)
  verifies all ten job logs and retained test logs, with no unresolved issues.

Linux has 257 targets per architecture. Each macOS architecture has 131 regular
and 126 ownership targets. Each Windows architecture has 57 early targets plus
155 native targets matched to successful executions. Benchmark evidence and
documentation are included in the audit.

[The receipt](receipt.json) records source identities, artifact size/digest and
the two cancelled duplicate postmerge runs. `audit.zip` retains the full audit,
job logs and target logs; its SHA-256 digest was checked after downloading.

This completes the implementation group. The [27 missed speed targets](../scalar-constant-time-2026-11-05/README.md)
remain open under the agreed acceptance policy. Long solves improved by 1.7–6.3%;
measured allocation and stack costs did not change. No unchanged timing was rerun.
