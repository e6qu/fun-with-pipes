# Session handoff

## Next action

Next: integrate the verified map-construction repair in [PR #166](https://github.com/e6qu/fun-with-pipes/pull/166).
The timeout and failure-artifact repairs are published; six-host
replacement `39108116774` at `b8700990` passes all 78 tests and its report
`39109026750` passes. Its 120-binary report is verified and recorded. Joining related buffers fixes sorting
on both measured EPYC models. Investigate the separate Xeon slowdown using
AMD64 repeats: `39106417923` landed on EPYC 7763 and `39107501057` on EPYC 9V45;
both pass but neither answers the Xeon-specific question.
Integrate the preparation into this same PR and start full final-head validation
while investigating the unresolved Xeon-specific timing result. Require all nine production jobs, docs and
affected evidence for the final PR commit before merging. Fix every encountered
issue, including unrelated/pre-existing failures; do not hide or defer fixes.

Refresh audits with the root guard:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-refresh-current-audits.py`.
Audit every failed job and completed target before a coherent repair push.
Queued CI gates merging, not independent work. Keep one active delivery PR.

## Workspaces and sources

- Root branch `collection-build-storage`, PR #166 head
  `7f782388270b5d73a60eaf3c253a6f9a6e680e95`. Only this handoff is uncommitted.
- Preparation `/private/tmp/fwp-collection-runtime-costs`, branch
  `collection-runtime-costs`, published head
  `fe78f7000a17e4a1ba417d823ad9f39407838667`. No second PR.
- Repair compiler/runtime/tests: `725e2198d721e835be282e2032d99ac5f10b4605`.
  Later preparation commits change measurement/report tools and docs only;
  `git diff` verifies compiler/runtime/test identity.
- Diagnostic source: `93cb93a0f717b317814ecfc162de0c2f516dbfbd`.
  Never relabel measurements after integration or rebasing.
- Shared root `target/debug/fwp` contains the repair compiler, not the root PR
  compiler. Candidate checks run from preparation with the root resource guard.
  Downloaded executables are data only; never execute them locally.
- `/private/tmp/fwp-collection-build-storage` is detached and inactive.

## Current checks

| Check | Run | Latest audited result |
|---|---|---|
| Original PR production, `7f782388` | `39102055758` | All nine jobs pass: 1,270 summaries, 3,670 passed, zero failed, 72 ignored. |
| Original PR docs | `39102055788` | Pass |
| Repair correctness/costs, `725e2198` | `39104669727` | **Workflow failed.** All 78 tests passed, but Intel macOS timed out building the release compiler; costs never ran there. Five complete jobs pass. |
| Collection report, collector `934517ff` | `39107047829` | Failed: correctly rejected the failed evidence run; upload also failed because no early metadata artifact existed. Both causes audited. |
| Replacement collection workflow, `b8700990` | `39108116774` | All six jobs pass: 78 tests, no failures/skips; all costs complete within the unchanged limit. |
| First repair performance, `725e2198` | `39104667835` | Both hosts and 76 actual binary/sample audits pass; Xeon timing concern remains. |
| Construction/query diagnostics, `93cb93a0` | `39106005017` | Both hosts and 92 binary/sample audits pass; EPYC reproduces the old problem and verifies the repair. |
| AMD64 repeat, `93cb93a0` | `39106417923` | Pass, 46 audited binaries. EPYC 7763: full ratios 0.920/0.840; construction 0.196/0.187, queries essentially unchanged. |
| Further AMD64 repeat, same immutable source | `39107501057` | Pass, 46 audited binaries. EPYC 9V45: full ratios 1.007/0.990 with overlapping ranges; construction 0.861/0.877. |

Ignored/skipped tests do not establish support. Focused jobs do not replace final
production acceptance. Original logs/audits: `/private/tmp/fwp166-final-*`.
Focused prefixes: `collection-joined`, `map-storage`, `storage-diagnostics`,
`storage-repeat`.

The failed report must not be relabeled or accepted. Replacement report
`39109026750` succeeds at `b8700990`, using successful run `39108116774`.
Its artifact audit passes: six hosts, 78 tests and 120 binaries; compiler paths
and hashes are retained in `collection-joined-storage-2026-10-18.json`. The collector requires five fused-map requests,
`3*n+6` ordinary-map requests, 48 allocation failures, 64 callback exits and two
deliberately leaked allocations in broken controls. Require all 120 binaries and
six hosts. Original report record: `/private/tmp/fwp-joined-report-publication.json`.

The previous handoff incorrectly called six completed jobs successful: the
temporary refresh display showed test totals and only highlighted `failure`,
missing `cancelled`. It now prints every unsuccessful job, explicit successful
job counts and overall run failure. The collector correctly rejected the run.
The Intel log and annotation show a 30-minute timeout during the extra release
build after all 13 tests passed. Repair: use the dev compiler already built by
the integration tests, selected explicitly by `--compiler`; native programs
still compile at O2 and only their execution is timed. Compiler path and hash
are recorded alongside source identity. The 30-minute limit stays unchanged. This removes redundant
compilation rather than reducing coverage. Collector request/run JSON is now
written before acceptance checks and uploaded even on early failure. Four
regressions cover rejected/incomplete/cancelled runs and retained metadata;
focused syntax/workflow/docs checks pass. A local preflight also caught an
unsupported compiler `--version` request in the new metadata code; source and
executable hash identify the compiler directly, with bounded-memory hashing.
The corrected preflight passes (5.18 s guarded); publication is `b8700990`
(4.13 s guarded). Record `/private/tmp/fwp-collection-workflow-repair-publication.json`.

## Change and limits

Numeric map/set construction avoids intermediate lists, immediate range lists,
eligible numeric tuples and known-callback dispatch. Sets avoid unused temporary
value buffers. Dynamic map callbacks can still box results; managed captures
can still need counts. Evaluation order, duplicates, floating-key order, aliases,
traps and cancellation remain tested observable behavior.

The repair joins map key/value lanes into one allocation, including sort scratch.
Each allocation has one owner, with complete byte-count guards and no arbitrary
padding or sentinel word. Empty ordinary maps avoid scratch storage. Final
containers remain exact-size allocations; sets retain unused final value slots,
small numbers occupy words, and temporary storage grows with input length.

## Performance evidence and remaining question

The maintained program builds 500,000 entries from scrambled distinct keys
`(index * 7919) modulo 1000003`, prints map size, then makes two million lookups.
Construction sorts the input. C/Rust have different sorts/overflow guarantees;
equal output does not establish universal language overhead. Profiles are separate
from ordinary timed binaries. The guide names hardware, work and limitations.

Original construction combining cut requests from 1,500,009 to eight but worsened
AMD64 tracing medians 8.3% for full work and 36.4% for construction. The small
65,536-input/257-key comparison missed this. EPYC phase probes found sorting near
19–35 or 100–109 ms, correlated with address bit 22; no cache/TLB mechanism proven.

The first joined-layout run used Intel Xeon 8573C, where both layouts sort quickly.
Its joined tracing full-work median is 419.958 versus 401.488 ms, 4.6% slower;
all 24 paired rounds are slower despite faster construction. Do not dismiss this
as fixed by the EPYC result. The repeat separates construction/query intervals.

The diagnostic run returns to AMD EPYC 9V74: old slow sorting 99–108 ms versus
joined 14–22 ms, both address-bit values covered. Full joined/separate ratios
are 0.905 tracing and 0.768 ARC; construction ratios 0.394/0.174. All 24 full-work
paired rounds improve in both modes. Queries remain near 273–279 ms: this proves
the construction repair, not elimination of query overhead.

ARM64 construction stays stable. First full-work ratios are 0.988/0.994; repeat
ratios are 0.951/1.069. ARC ranges overlap widely, 14/24 paired rounds are slower,
and the median paired ratio is 1.020. Query intervals vary roughly 421–502 ms.
Preserve slower samples and do not claim a universal full-program speedup.

Joined full work has six requests versus eight, unchanged 2,000,001 retain
requests, peak counted bytes 24,000,008 versus 24,000,040 and zero final charge.
Tracing collections fall two to one; ARC has none. Counts exclude allocator
overhead and process resident memory. Actual AMD64 query/sort instructions match
after address normalization; code shrinks 384 bytes in each mode. Cached-table
frames: 104 → 88 bytes tracing, 88 unchanged ARC. ARM64 ARC code shrinks 416 bytes
and its frame 112 → 96. These are scoped frames, not whole-program stack bounds.

Artifacts/audits: `/private/tmp/fwp-joined-storage`, `fwp-storage-diagnostics`,
`fwp-storage-repeat`. Run `/private/tmp/fwp-audit-joined-storage.py` under root
guard; later runs take explicit run, source, directory and `--diagnostics`
(or `--diagnostics-amd64`). Initial reports/code inspections are committed in
preparation as `docs/measurements/large-map-storage-2026-10-18.json`.
The full diagnostic report is committed in preparation,
as `docs/measurements/large-map-storage-phases-2026-10-18.json` (2.82 s guarded).
All sixteen timed-binary/source/profile identities match the earlier run exactly;
the different CPU and timing distributions are not compiler changes. The AMD64 repeats are recorded in `large-map-storage-repeats-2026-10-18.json`. The measured compiler and diagnostic sources
are preserved as `evidence/collection-joined-buffers-20261018` and
`evidence/map-storage-probes-20261018`; these are evidence anchors, not acceptance
of the incomplete collection workflow.

## Fast performance repeats

Run `39109230202` at `fe78f700` uses the new `map-replay` workflow repeats 16 verified ordinary/diagnostic binaries
from successful run `39106005017`, source `93cb93a0`, on four independent AMD64
runners. It verifies run success, source, architecture, executable size/hash and
generated-source hash before any execution. No compiler or native build is
repeated. Reports retain original evidence, current CPU identity, 24 balanced
ordinary samples and 16 separate phase samples. Four rejection regressions and
validation of all 16 actual files pass locally without executing them (5.28 s
guarded). A later documentation check caught the streamlined handoff missing
its required seven-row roadmap table and `Next:` marker; both are restored. All four jobs pass and all 64 replayed binary identities are audited (24.46 s
guarded). Three use EPYC 7763 and one EPYC 9V74; full ratios range 0.761–0.929
tracing and 0.770–0.928 ARC. `large-map-replay-2026-10-18.json` retains all samples.
The Xeon-specific question remains open; do not claim another CPU answers it.

## Local validation and tool repairs

All checks use the unchanged root resource guard, serially:

- Repair formatting/Clippy and three collection tests: pass, 74.75 s.
- Eight collection/map ownership tests after overflow guards: pass, 65.01 s.
  Raw/native O1/O2, ARC, stressed tracing, reuse, aliases, 48 allocation failures,
  64 callback exits and 104/106 managed-operation failures; no failures/skips.
- Tiny old/new storage comparison: pass, 10.63 s; interpreter agreement,
  requests 8 → 6, unchanged 17 retains, zero final charge/collections.
- Eight tiny phase probes: pass, 8.92 s. The first incorrectly assumed construction
  happened inside queries and failed. The corrected probe preserves earlier
  construction, verifies one before queries and none inside, and requires positive
  full-work runner durations. Raw report wording about sorted input is corrected
  explicitly without altering samples or source IDs.
- Collector counter fixes: twelve actual ARM64 rows pass, twelve deliberately
  wrong counts rejected, three log-audit regressions/docs pass, 2.89 s. Earlier
  failure/leak expectation fix passes, 3.39 s. Exact checks are retained.
- Independent ARM64/AMD64 binary inspection: pass, 0.21/0.15 s. The first AMD64
  parser stopped at eight prologue lines and failed; reading through the first
  call fixes it. An earlier name-only audit mistook ARC's deliberate collection
  trap for tracing; actual trap instructions and absent scan/mark/sweep routines,
  with positive tracing controls, correct that audit error.
- Initial evidence recording: pass, 2.76 s. Collector publication checks: pass,
  6.14 s, including empty compiler/runtime/test diff against measured source.

Full builds, suites, benchmarks and large generation stay on GitHub. Preserve
64 GiB free disk, target below 2 GiB, sampled workload RSS below 1 GiB and the
180-second guard deadline. Never raise or bypass limits.

## Earlier evidence and delivery

PR #165 is accepted as `695907781c5efff02e0f202f8b7fa99283df5ef4` after nine jobs
and docs passed for `836f39b3`: 964 targets, 3,652 passed, zero failed, 72 ignored.
Message/tree/parent verified; duplicate `39101178854` cancelled.
[History](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165) preserves
the contracts and failure audits; record `/private/tmp/fwp165-merge-record.json`.

Earlier PR #166 stages each pass 78 native tests and 120 binary inspections:
`488d1822`, `8fcd7486`, `c34ca8e3`, preserved by the `evidence/collection-build-20261018`,
`collection-set-storage-20261018`, `collection-direct-sets-20261018` tags and
committed reports. The first run's 16 failures were repaired: three NaN-sign
fixture assumptions and 13 Windows ARM64 tests using the wrong compiler after
a forbidden download. Authenticated/checksummed downloads and setup guards fix
the cause. Do not relabel original failures as passing evidence.

Original large-map control: `9f0632f9`, run `39102838322`, tag
`evidence/large-map-baseline-20261018`; phase experiments: `f01f50bf`, run
`39103286520`, tag `evidence/large-map-phases-20261018`. Lower-bound search was
8–9% slower on ARM64; separate initialization had no clear gain and larger code.
Neither was adopted. The longer previous handoff is saved at
`/private/tmp/fwp-handoff-before-storage-streamline.md`; it is not a second plan.

Preserve this authoritative handoff and squash preparation into the existing
PR branch. Full validation can run while the timing investigation continues;
the unresolved Xeon result must stay visible and is not claimed fixed.
Update the description around the final change, then require all final-head
gates. Squash-merge with explicit one-line subject, at most 80 characters, empty
body, no trailers/attribution. Verify complete message, parent and identical
tested/merged tree; cancel duplicate post-merge production and continue.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | Controlled C/Rust gaps and actual machine code |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Representative applications and browser execution |


All seven [PLAN.md](../PLAN.md) areas remain open: ownership/GC removal;
functional costs; machine performance; differentiation; numerical kernels;
dependable measurement; larger programs. Cached-value retain requests are measured
remaining work; removing them needs a lifetime proof preserving reentrant
initialization and failure order. JIT is excluded, not deferred. A completed
delivery does not complete the language's memory or performance goals.
