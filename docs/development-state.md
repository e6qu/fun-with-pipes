# Current work

**Next:** inspect independent ARM64 timing audit `41593988021` and diagnose its
zero-update slowdown from saved source/driver; monitor qualified AMD64 session 2
and every production job in `41591834975`. Compiler costs are audited and pass. Retain each outcome;
replace only timing hosts rejected before measurement. Prepare the next storage
change from saved constructor counts while these independent gates run.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `scalar-buffer-performance`.
  The primary checkout is untouched. No new PR yet; bundle measurements, needed
  CI repairs and the selected next storage improvement in one substantial PR.
- User merged PR #250 as `a8a5568d5c1ee791f872de382c6d7e850cec09df` before full
  platform and performance gates. Its tree equals focused-tested `da510f18`
  (`ec6935165379492d07cb236d0f8f05a75f8b6fd9`). Squash message is one line,
  no body or trailers. Do not cancel its production run as redundant.
- Measurements use full source `da510f18b089c3db5527466b349fec0f2f3ee9ef`, tag
  `roadmap/scalar-map-zip-measurement-2026-11-03`. Keep that comparison unchanged.
- Earlier retained identities: `roadmap/callback-owner-final-2026-11-03`,
  `roadmap/temporary-list-protocol-2026-11-03`,
  `roadmap/scalar-map-zip-protocol-2026-11-03`,
  `roadmap/scalar-map-zip-attempt-2026-11-03`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Nine-job merged-head production matrix and documentation audit |
| 2 | In progress | Audit completed compiler costs; complete and audit four runtime sessions |
| 3 | In progress | Publish the selected range-to-zip contract before compiler edits |
| 4 | Pending | Implement selected change, grouped verification, final gates and verified squash |

## Verified scalar-buffer behavior and storage

[Run 41578060081](https://github.com/e6qu/fun-with-pipes/actions/runs/41578060081)
passes: ARM64 `125726094841`, AMD64 `125726094987`; docs `125725949307` also passes.
Every full/target log is audited; 11 unit and 33 integration executions pass per
host. Each host has 118 clean C compilation logs. All 96 allocation observations
match exact predictions, output/work and zero final storage. Largest current-only
solve: 156,943 → 131,073 requests; 5,382,142 → 4,559,078 requested bytes; retains
stay 995 and managed peak stays 17,824 bytes. History saves the same requests/bytes.
[Detailed results and both attempts](measurements/temporary-list-storage-2026-11-03/README.md).

First attempt `41576241072` failed a new unit-test helper lookup; `tee` hid the
unit-command status. Repaired helper and explicit Bash failure propagation pass.
Three older numeric-owner steps received the same reporting repair. All failed
steps and completed targets were audited before the repair push. Full raw C/images
remain in saved/GitHub archives; compact logs, outputs and file hashes are retained.

## Active measurements and platform gates

- **Production:** `41591834975`, merged source `a8a5568d`; benchmark job
  `125770098958` passes with a clean audited full log (21 images and memory controls). Linux/Windows jobs
  run; four macOS jobs queue. Docs: `41591834978`, job `125770098628`, passes; expected runner fault controls only.
- **Compiler cost:** `41591971248`, both jobs pass: AMD64 `125770529588`, ARM64
  `125770529929`. All 480 commands, exact reference patches, images, archived
  hashes, generated C, raw RSS and summaries are audited. Maximum elapsed overhead
  1.15%, RSS overhead 0.32%, copy variation 1.64%; all limits pass.
  [Report](measurements/scalar-map-zip-analysis-2026-11-03/README.md).
- **Runtime original:** `41591978166`. Both ARM64 sessions completed:
  session 1 `125770553887`, session 2 `125770553867`. Both are now complete and
  fail only final timing limits: zero-update current is 3.32% slower in both;
  several small cases miss 5% improvement. Independent audit `41593988021` runs.
  [Recorded outcomes](measurements/scalar-map-zip-time-2026-11-03/README.md).
  AMD64 sessions 1 `125770553924` and 2 `125770553865` rejected Intel CPUs before
  building/timing. Full logs, host metadata/digests and skipped work were audited.
- **AMD64 replacement 1:** `41592143741`, session 2 job `125771080311` rejected
  EPYC 9V74 before building/timing. Verified and retained separately.
- **AMD64 replacement 2:** `41592549006`, both sessions requested; monitor their
  CPU qualification failed for both. Independent retention audit `41593021814`
  passes; both raw host reports are independently checked and retained in
  `rejected-hosts/replacement2.zip` (EPYC 9V74 / 9V45). Replacement 3,
  `41593285140`: session 2 `125774733224` qualified and is measuring; session 1
  `125774733158` rejected Intel 6973P-C and is audited/retained. Request a new
  session 1 only: replacement 4 run `41594132242`. Required CPU remains EPYC 7763. Do not repeat completed timings.

[The frozen execution](measurements/temporary-list-storage.md#execution-of-the-frozen-comparison)
compares the same source with only `scalar_map_zip::lower` disabled. Compiler:
five programs, 240 commands per architecture, 2% identical-copy and 5% time/RSS
limits. Runtime: all six inputs, 98 samples, two sessions per qualified architecture;
2% copy/regression and 5% improvement for 199+ updates. Exact allocation savings,
unchanged retains/raw work, no managed peak growth, zero final storage, code-size
reporting and ≤128-byte frame growth. Prior PLAN.md timing failures stay open.

## Next storage investigation

The census attributes remaining `d*u` constructors to each of: input-index range,
input records, input list, gradient-result list and updated-coordinate list.
`lib/list.fwp` defines `enumerate = fork zip id (length | range 0)`;
`rev._seed-float` uses it before mapping `rev._leaf`. Saved generated C uses
`fwp_p_range_owned`, then a captured zip callback returning `Rev[F64]` records.
The backward path is `ad.backward | array.to-list | map float.convert` and becomes
a list-building loop. The selected next change is [direct range consumption](measurements/range-zip-storage.md):
one I64 range consumer, known callback with machine-scalar captures, scalar inputs
and scalar/flat numeric-record results. Preserve evaluated bounds at their original
position and use one protected output scratch buffer. Predicted largest saving:
25,870 requests and 823,064 bytes again. Contract is written but not yet published;
no compiler edit yet. Publish this preparation before implementation.

## Local checks and files

No local full build/suite or benchmark. All checks used `scripts/local-guard.py`.
Reference/measurement/evidence controls, Rust formatting, workflow lint and roadmap
pass. Primitive inventory has 394 declarations, 384 symbols and no unreviewed symbols.
Corrected native audit verifies 320 image headers, 32 scalar-unwind statuses and all
88 unit/integration executions (0.62s); all 96 count differences, compilation logs
and cross-host equality pass (0.36s). Host-rejection audits pass (0.13–0.14s).

Raw files under `/private/tmp/`:

- `fwp-250-scalar-repaired-{arm,amd}.zip` (native controls),
  `fwp-250-scalar-repaired-counts-{arm,amd}.zip` (count audits),
  `fwp-250-scalar-repaired-{arm,amd,docs}.log` (full logs).
- `fwp-scalar-analysis-{arm,amd}.zip`, matching `.log`, and
  `fwp-scalar-analysis-artifacts.json` (compiler measurements).
- Audit helper `fwp-audit-scalar-analysis.py`: arguments ARCHIVE METADATA
  ARTIFACT_ID SOURCE MACHINE. It saves reports in
  `docs/measurements/scalar-map-zip-analysis-2026-11-03`.
- Native helpers `fwp-retain-scalar-repaired-controls.py` and
  `fwp-audit-scalar-repaired-counts.py`; ordinary generated C
  `fwp-scalar-largest-{arm,amd}.c`. Earlier failed-attempt/census files remain.
- Host helper `fwp-retain-scalar-rejection.py`: LABEL RUN_LABEL ARTIFACT_ID.
  Retained host failures: `docs/measurements/scalar-map-zip-time-2026-11-03/rejected-hosts`.

Preserve 64 GiB free disk, targets below 2 GiB, sampled RSS below 1 GiB and 180s.
Last measured disk was about 66 GiB free with zero target data, before downloading
about 260 MB of compiler evidence. Compiler archive audits pass in 2.56s/2.78s;
one early check rejected an unfinished download, then passed after completion. Move refused checks
to runners, never raise limits. Final delivery still requires nine exact-head
production jobs plus docs, all logs audited, one-line squash ≤80 characters,
no body/trailers, and verified message/tested-tree equality.
