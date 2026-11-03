# Current work

**Next:** publish the batched range-selection and fault-injection repairs, then
run `range-zip-checks` on both Linux architectures. Audit all target logs and all
96 count observations before starting the prepared range measurements. Continue
auditing the merged scalar-buffer platform gates while runners work.

## Checkout and source identities

- Worktree `/private/tmp/fwp-array-consumption`, branch `scalar-buffer-performance`.
  Primary checkout untouched. Draft [PR #251](https://github.com/e6qu/fun-with-pipes/pull/251)
  bundles scalar-buffer reports, private index-list removal and CI repairs.
- User merged #250 as `a8a5568d5c1ee791f872de382c6d7e850cec09df` before full gates.
  Its tree `ec6935165379492d07cb236d0f8f05a75f8b6fd9` equals focused-tested
  `da510f18b089c3db5527466b349fec0f2f3ee9ef`. One-line squash verified.
- Scalar measurements remain at `roadmap/scalar-map-zip-measurement-2026-11-03`
  (`da510f18`). No production edits or timing-limit changes enter that comparison.
- Range contract: `e86ee4ccc0f505b31e7421c9faaa45e7a0d104ba`, tag
  `roadmap/range-zip-protocol-2026-11-03`. Failed attempt: `aeae4afd`, retained
  as `roadmap/range-zip-attempt-2026-11-03`. Metadata/routes published at `5d6750b6`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Five of nine pass; audit the four remaining merged-head gates and repair failures |
| 2 | Verified | Measurements and raw audits complete; timing acceptance remains open |
| 3 | Verified | Contract and reference published; keep frozen bounds unchanged |
| 4 | In progress | First attempt failed; verify repairs, measure change, pass nine final-head jobs plus docs |

## Range repair and pending verification

[Full first-attempt report](measurements/range-zip-storage-2026-11-03/README.md).
Run `41596501915`: ARM64 `125785012603`, AMD64 `125785012332`. Both fail the same
four steps: GCC/Clang cleanup fixture, count comparison and independent count
assertion. All completed targets and full logs were audited before repair.

- **Missed inline ranges:** typed IR contains the range directly inside zip's
  argument, not a named binding. The first pass selected only named producers,
  so all derivative counts were unchanged. Repair handles direct arguments at
  their original evaluation position; both-slot IR and effect-order regressions
  added. Predicted savings stay 25,870 requests / 823,064 bytes at 129/199.
- **Persistent test fault:** the injected record failure stayed armed during the
  next case's input setup. Faults are now one-shot and reset before setup.
  No production runtime change was needed for this fixture defect.
- Each host passes 16 unit tests and 35 integration executions, with two fixture
  executions failing. All 96 count observations preserve baseline outputs,
  work and storage; each host's 80 failed savings assertions have the same cause.
  Each host has 118 clean C compilation logs.
- New compiler code is **not yet runner-verified**. Run corrected focused checks
  before `range-zip-analysis` / `range-zip-time`; supply their passing run as
  `evidence_run`. Freeze measurement source before timing. `range-zip-report`
  independently retains complete outcomes, including failed limits and host
  rejections. No repeated completed timing for a better outcome.

## Completed scalar-buffer evidence

- Focused `41578060081`: both native hosts and docs pass; all logs audited.
  All 96 count predictions match. Largest current-only solve: 156,943 → 131,073
  requests, 5,382,142 → 4,559,078 requested bytes; retains 995, managed peak
  17,824 bytes, final storage zero. History saves the same requests/bytes.
  [Records](measurements/temporary-list-storage-2026-11-03/README.md).
- Compiler `41591971248`: both hosts pass. All 480 commands, references, images,
  source hashes, RSS and summaries audited. Maximum elapsed overhead 1.15%, RSS
  overhead 0.32%, copy variation 1.64%; all limits pass.
  [Report](measurements/scalar-map-zip-analysis-2026-11-03/README.md).
- Runtime: four qualified sessions complete. ARM64 original `41591978166`;
  AMD64 session 2 `41593285140`, session 1 `41595396878`. Raw audits
  `41593988021`, `41595559659`, `41597796416` pass; all source/reference hashes,
  5,336 raw-file inventory entries and reported limits independently reconciled.
  [Complete report](measurements/scalar-map-zip-time-2026-11-03/README.md).
- Timing goals stay open: ARM64 zero-update current is 3.32% slower in both
  sessions; both architectures miss small-case speed limits. Large cases are
  about 7–8.5% faster. All identical-copy controls pass. Saved zero branch,
  repeated-solve main and outer loop are textually unchanged; the slowdown's
  cause remains unknown. Allocation gains do not resolve timing acceptance.
- Every rejected AMD64 host was retained separately; replacements ran only
  after rejection before building/timing. No additional scalar run is needed.

## Merged-head production gates

Run `41591834975`, source `a8a5568d`; do not cancel as redundant.

| Gate | Job | Status / audit |
|---|---:|---|
| C/Rust benchmarks | 125770098958 | Pass; full log clean, 21 images and memory controls |
| macOS ARM64 regular | 125770099192 | Pass; 131 target logs clean; expected Homebrew notice only |
| macOS ARM64 ownership | 125770099175 | Pass; 126 target logs clean; expected Homebrew notice only |
| Linux AMD64 | 125770099249 | Pass; 257 target logs and full log clean |
| Windows ARM64 | 125770099313 | Pass; 57 target logs and full log clean |
| Linux ARM64 | 125770099083 | Running |
| macOS AMD64 regular | 125770099310 | Running |
| macOS AMD64 ownership | 125770099197 | Running |
| Windows AMD64 | 125770099451 | Running |

Compact logs and verified artifact identities:
[platform records](measurements/temporary-list-storage-2026-11-03/platforms/).
Merged docs `41591834978` pass. PR #251 metadata docs `41597725595` also pass;
full log has only the three intentional runner-failure controls. Final-head
production gates for the repaired range implementation have not started.

## Local checks and retained files

All checks use `scripts/local-guard.py`; no local full build, suite or benchmark.

- Exact failed C fixture replay: Apple Clang 17, production O1/O2; two ordinary
  exits 0, six omitted-cleanup controls exit 90, empty stderr (3.46s).
- Matching merged native compiler emits the diagnostic typed IR (0.49s);
  inline-order interpreter example passes (0.26s). No local compiler build.
- Rust formatting passes (2.02s). Both failed-attempt audits pass (1.22s).
  New completed platform log/digest audits pass (0.14s).
- Prepared routes already passed reference isolation, 16 allocation controls,
  15 timing-budget controls, seven compiler-schedule controls, 14 archive controls
  and workflow lint. Primitive inventory: 394 declarations, 384 symbols,
  no unreviewed symbols. Repaired reference controls pass (0.13s); inventory passes (1.09s).
  Roadmap audit initially rejected descriptive status labels; fixed to the allowed
  labels while keeping details in the remaining-work column.

Raw archives, full logs and audit helpers live under `/private/tmp/fwp-*`:
`fwp-range-{arm,amd}-attempt1.zip`, `fwp-range-{arm,amd}-counts-attempt1.zip`,
`fwp-audit-range-attempt1.py`, `fwp-range-diagnostic.{fwp,ir,c}`,
`fwp-range-fixed-probe.c`, `fwp-replay-range.py`, `fwp-complete-scalar-report.py`,
`fwp-audit-250-platforms.py`, `fwp-250-production-artifacts.json`.
Reports retain hashes and original artifact URLs; preserve failed evidence.

Last disk check: about 66 GiB free, zero target data. Keep 64 GiB free, generated
target data below 2 GiB, sampled RSS below 1 GiB and the 180s guard deadline.
Move refused work to runners; never bypass limits. Final merge requires all nine
exact-head production jobs plus docs, audited logs, explicit one-line squash
subject ≤80 characters, empty body/trailers and verified message/tree equality.
