# Current work

**Next:** run and monitor the nine final-head production jobs plus docs for
PR #251. Audit every failed step and completed target before any repair push.
When all pass, squash-merge with one explicit subject ≤80 characters and an empty
body; verify the message and tested-tree equality. Keep the missed timing goals
open and use the residual allocation census to select the next substantial task.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `scalar-buffer-performance`.
  Primary checkout untouched. [PR #251](https://github.com/e6qu/fun-with-pipes/pull/251).
- The final delivery test revision is tagged
  `roadmap/range-zip-final-checks-2026-11-03`. Resolve that tag / PR head for the
  exact commit. Compiler sources remain identical to the focused-tested revision.
- Range measurement source `3be9479c4150d7aae5695d7f7aa4ce3f84d0f738`, tag
  `roadmap/range-zip-measurement-2026-11-03`. Preserve it for every comparison.
- Contract `e86ee4ccc0f505b31e7421c9faaa45e7a0d104ba`, tag
  `roadmap/range-zip-protocol-2026-11-03`; failed attempt `aeae4afd`, tag
  `roadmap/range-zip-attempt-2026-11-03`. Reports retain both attempts.
- Scalar measurement tag `roadmap/scalar-map-zip-measurement-2026-11-03` points
  to `da510f18b089c3db5527466b349fec0f2f3ee9ef`. Its tree
  `ec6935165379492d07cb236d0f8f05a75f8b6fd9` equals user-merged #250 source
  `a8a5568d5c1ee791f872de382c6d7e850cec09df`; one-line squash verified.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | All nine merged-source production jobs and docs pass; all logs audited |
| 2 | Verified | Scalar measurements/audits complete; missed timing goals remain open |
| 3 | Verified | Range contract and isolated reference published before measurement |
| 4 | In progress | Native/count/compiler checks and runtime audits complete; final-head gates and merge remain |

## Current range results

[Native verification, failed attempt and exact storage results](measurements/range-zip-storage-2026-11-03/README.md).
Corrected run `41601233570`: ARM64 `125800213798`, AMD64 `125800214058`, both pass.
Docs `41601188883` / `125800044359` pass. All full/target logs are audited.

- Each host: 17 unit / 37 integration executions, 32 cleanup outcomes and 204
  native image architecture checks. All 96 allocation observations agree;
  each host has 118 clean C compilation logs.
- Largest current-only solve: 131,073 → 105,203 requests; 4,559,078 → 3,736,014
  requested bytes; retains remain 995; managed peak 17,824 → 14,976 bytes;
  final storage zero. History saves the same requests/bytes.
- First attempt missed inline range arguments and left test faults armed during
  the next case's setup. Both causes are repaired. No failed evidence was removed.
- [Compiler costs](measurements/range-zip-analysis-2026-11-03/README.md): run
  `41603242667` passes; ARM64 `125806753941`, AMD64 `125806753716`. All 480 commands,
  exact references, image/file hashes, RSS and full logs independently audited.
  Maximum time increase 0.17%, peak-RSS increase 0.28%, copy variation 1.08%.
- Code/frame figures and four remaining per-coordinate allocation groups are
  recorded in the native report. They guide later investigation; no additional
  implementation is selected while this candidate is being measured.

## Completed runtime comparison

[Report and retained host rejections](measurements/range-zip-time-2026-11-03/README.md).
All runs use `3be9479c` and passing correctness run `41601233570` as prerequisite.

- **ARM64 complete:** original run `41603246961`, sessions 1 `125806772559` and
  2 `125806772536`. Only the 3/199 timing limits fail: session 1 current/history
  ratios 0.953963 / 0.956425, session 2 current 0.950161, against ≤0.95.
  Larger cases take about 9.4–10.0% less time; all copy controls pass.
- **ARM64 audit complete:** `41605943666` / `125815667922` passes. Both downloaded
  archive digests and the full audit log are checked. Report/log digests, source
  hashes, exact reference and 2,668 raw-file inventory entries reconcile locally.
- **AMD64 complete:** replacement run `41603882629`, session 1 `125808854223`,
  session 2 `125808854159`. Both qualified on EPYC 7763. Both miss 5% on 3/199
  and 3/1999 history (3.97–4.92% less time); all other budgets pass. Independent
  audit `41607485480` / `125820866330` passes. The two downloaded archives, full
  audit log, report/source/reference hashes and 2,668-file inventories reconcile.
  Larger AMD64 cases take 7.1–8.8% less time.
  Original jobs `125806772756` / `125806772669` rejected EPYC 9V74 before builds
  or timing; host/job records, digests, skipped work and full logs are retained.
- All four sessions share identical source hashes and one exact reference patch;
  all 5,336 raw-file inventories reconcile. The maximum reported frame growth
  is 112 bytes, within 128; text changes range −656 to +1,008 bytes. Runtime RSS
  is reported separately as individual process observations, without treating
  allocator savings as proof of a whole-process memory reduction.
- Accepted policy: retain verified reductions and leave timing misses open.
  Do not relax limits or rerun completed timings for a pass. Old scalar-buffer,
  callback-owner and other PLAN.md timing goals remain open independently.

## Completed predecessor verification

#250 run `41591834975` passes all nine production jobs at `a8a5568d`; docs
`41591834978` pass. Every full/target log is audited. macOS notices only confirm
OpenSSL is already installed (ARM64 3.5.9, AMD64 3.6.3).
[Exact-source gates and logs](measurements/temporary-list-storage-2026-11-03/platforms/final-gates.json).

Scalar-buffer [compiler costs](measurements/scalar-map-zip-analysis-2026-11-03/README.md)
and [four runtime sessions](measurements/scalar-map-zip-time-2026-11-03/README.md)
are complete and audited. Compiler limits pass; small-case timing goals and
ARM64's 3.32% zero-update slowdown remain open. The saved zero branch/main/loop
are unchanged; its cause is not established. Do not infer a safety bug or resolution.

## Local checks and resume files

All substantive checks used `scripts/local-guard.py`; no local full build, suite
or benchmark. Formatting, reference isolation, inventory (394 declarations,
384 symbols, no unreviewed symbols) and roadmap pass. Latest roadmap check:
232 link sets, 106 preparation anchors and four steps (3.02s).

- Corrected C fixture replay: Apple Clang 17 O1/O2; ordinary exits 0, six
  omitted-cleanup controls exit 90, empty stderr (3.46s). Matching merged compiler
  IR diagnostic (0.49s) and inline-order interpreter example (0.26s) pass.
- Corrected native audits: 0.24/0.25s; cross-host count/full-log audit: 0.50s.
  Compiler audits: 2.48/2.71s; runtime-summary audits: 0.61/0.63s; platform audits:
  0.13–0.14s. All 48 native cases preserve their largest reported frame (0.25s).
- Local reader repairs: use actual artifact source metadata instead of assuming
  a source.txt; correct a negated source assertion; account for the exact inspected
  Homebrew notice. These change no tested output, experiment or acceptance limit.
- Latest published report-head docs `41605765870` / `125815070690` pass; the full
  log contains only intentional runner-failure controls. Final delivery docs must
  pass again on the final head. Four-session table/frame audit passes (0.50s),
  separate RSS summary passes (0.38s), and final full-log audit passes (0.13s).

Helpers and raw evidence are under `/private/tmp/fwp-*`. Key helpers:
`fwp-audit-range-runtime-summary.py LABEL` (`arm` / `amd`; matching
`fwp-range-LABEL-retention-*` files), `fwp-audit-range-analysis.py`,
`fwp-audit-range-repaired-counts.py`, `fwp-retain-range-repaired-controls.py`,
`fwp-retain-range-rejection.py`, `fwp-finalize-250-gates.py`.
Final report helpers: `fwp-finish-range-runtime-report.py` and
`fwp-range-memory-summary.py`. The report is complete; do not rerun measurements.

Keep 64 GiB free disk, generated targets below 2 GiB, sampled RSS below 1 GiB and
180s. Last free space about 65 GiB; no target data. Never bypass guard limits.
Final merge needs nine exact-head production jobs plus docs, all logs audited,
one-line squash ≤80 characters, empty body/trailers and verified message/tree.
