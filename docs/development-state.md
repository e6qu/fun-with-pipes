# Current work

**Next:** finish [PR #275](https://github.com/e6qu/fun-with-pipes/pull/275): wait for
all nine production jobs, run the complete-log audit, then squash-merge with one
subject of at most 80 characters and an empty body. Verify the merge message and
tree. Keep four noisy compiler-growth comparisons open. Independently replay the
queued-service recordings with the prepared decoder repair; do not restart #275.

## Delivery gates

PR #275 is normal/open at `a232e1e35062a37aa013975ac77bbd8cb4620663`, tagged
`roadmap/compiler-borrowed-delivery-2026-11-10`. Its worktree is
`.worktrees/compiler-checking-costs`, branch `compiler-body-costs`; local handoff
edits stay uncommitted while exact-head CI runs.

Production run `42767361217`, attempt 1:

| Gate | Job | Current result |
|---|---|---|
| Linux ARM / AMD | `129666869054` / `129666869605` | Running |
| macOS ARM regular / ownership | `129666869689` / `129666869512` | Pass; complete logs audited |
| macOS Intel regular / ownership | `129666869676` / `129666869663` | Pass; complete logs audited |
| Windows ARM / AMD | `129666869805` / `129666869584` | Running |
| C/Rust benchmarks | `129666869539` | Pass; complete log audited |
| Documentation | `129666864000`, run `42767360650` | Pass; intended runner-failure controls only |

Mac logs `/tmp/fwp-m6-mac-{arm,amd}-{regular,ownership}.log` contain only the
expected already-installed OpenSSL warning. Benchmark/docs logs are
`/tmp/fwp-m6-final-{bench,docs}.log`. No production failure is currently reported.

After all nine pass, dispatch `numerics.yml` on `compiler-body-costs` with
`suite=production-log-audit`, `evidence_run=42767361217`, `production_attempt=1`,
`documentation_job=129666864000`, `audit_host=all`, and
`source_revision=a232e1e35062a37aa013975ac77bbd8cb4620663`. Verify all ten audit
reports, exact sources and artifact hashes before merge. Record delivery in the
next branch so a status-only push does not restart the passing matrix.

## Verified compiler work

Candidate `c65ecb37691538ef5a24619376f68b1d243cbdea` borrows input types in
`free_vars` and `zonk`; row flattening is unchanged. Reference `35a12dfee` has
ordinary compiler sources identical to merged #274. [Focused checks](measurements/compiler-borrowed-types-2026-11-10/README.md)
verify 29–32% fewer type copies, unchanged C/diagnostics and seven type controls
on both native Linux architectures. [Two timing sessions per architecture](measurements/compiler-type-time-2026-11-10/README.md)
verify 11–14% less word-count compilation time and 8–10% less callback compilation
time. All application targets and memory limits pass. Four AMD growth comparisons
remain inconclusive under the frozen 2% copy-noise limit; do not rerun them unchanged.

#274 was merged as `e8997ac874f2c57009a5a13a7a5192c4f762272e`; its tree matches
verified `9fdb5e7bd`. [All gates and the redundant main-run cancellation](measurements/application-final-gates-2026-11-10/README.md)
are retained. Its application, compiler-growth and HTTP measurements complete M5.

## Next preparation: queued-service CPU cost

Worktree `.worktrees/service-cpu-costs`, branch `service-cpu-costs`; no second PR.
Protocol `8fcea595d` is tagged `roadmap/service-cpu-protocol-2026-11-10`.
Observation source `fac4a47440fb02667ddbf385dba959ae8f91a310` is tagged
`roadmap/service-cpu-observation-2026-11-10`.

[First run `42772697088`](measurements/service-cpu-first-2026-11-10/README.md)
finishes both hosts with the same three decoding failures: fwp delivered,
cancelled and handled-error profiles. ARM job/artifact `129683968936` /
`13743108949`; AMD `129683968550` / `13744145167`. All 32 peer/case combinations
run on each host. Every retained service result is correct, including sampled
calls followed by a decoder failure. Full logs and all six stderr reports are retained.
C/Rust/Swift and the expired fwp case decode; complete attribution is not accepted.

The repair explicitly selects LLVM addr2line and replays all sixteen profiles
from each host's saved recordings, after verifying hashes and actual outputs.
Perf 6.8's GNU end-marker check can mistake short inline names for markers; a
verbose replay of the actual failing GNU exchange will test that diagnosis.
Do not rename generated functions, ignore diagnostics or rerun workloads.
The replay workflow uses `suite=service-cpu-replay`, the new decoder's
`service_cpu_tag`, `evidence_run=42772697088`, and `source_revision=fac4a47440fb02667ddbf385dba959ae8f91a310`.
Native validation of this repair remains pending.

[Shared-reader replay `42772707168`](measurements/service-reader-replay-2026-11-10/README.md)
already passes ARM `129684008878` and AMD `129684008607`. Every compiler attribution
row/count/period matches the previous verified reader. No compiler rebuild or
new timing run was needed. Both complete logs are clean.

After #275 merges, rebase this preparation onto the verified squash without losing
the immutable observation tags or local docs. Attribute service/HTTP work before
choosing and freezing a candidate optimization. Keep the public gradient API steady.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load and pressure repair; all gates | Recorded observation limits apply |
| 6 | In progress | Borrowed types: native correctness, fewer copies and all application speed/memory targets | Four noisy growth comparisons; final delivery gates |

## Local verification and preservation

Guarded reader controls pass: five compiler, five service and three collection/
raw-record controls. Collection controls also verify replay source/hash/output
checks. Changed workflows pass actionlint. Docs explain CPU samples with examples
and cross-links; the latest audit passes 453 doc sets, 106 preparation anchors and
six milestones. Run it again after staging the new evidence. Test stubs and the
retainer's string run-ID check were repaired before passing. No local native builds.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data <2 GiB,
sampled RSS <1 GiB, 180 seconds. Last free space: about 112 GiB. Preserve unrelated
root changes, old worktrees and stash `451bbf713d451f2d62d80fd7676839404875846a`.
