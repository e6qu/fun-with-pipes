# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** publish the list/array sort-storage measurements after bounded checks,
then finish six-host cleanup acceptance and the active PR's final binary reviews.
Keep one active PR and preserve passing final heads.

Checkout `/private/tmp/fwp-checked-peer-comparison`, branch
`checked-peer-comparison`, published at `883f1c140089574012a4fed0345c8bc6905cca07`.
The working changes add measurement scripts and record the rejected sorting
experiment. They do not change compiler/runtime behavior beyond that revision. They also
repair the Windows probe and close its production-coverage gap.

## Grouped work

- [Checked C/Rust peers](measurements/checked-peers.md): explicit signed arithmetic
  and trap order, repaired C allocation failures, repeated timing/RSS/counts and
  actual binaries. Both Linux jobs in `40084725349` pass on `31ee015e9435`;
  92 images independently reviewed. Loop and direct character counting remain
  slower in the documented comparisons. Changed peers are not a compiler gain.
- [Ordered-sort experiment](measurements/map-order-results.md): both jobs in
  `40085991550` pass on `cbacdff5e8cb`, but both candidates fail the performance
  screen. All 128 binary files and timing/stability records were independently
  reviewed. No shortcut is adopted. Retain failed and noisy cells.
- [List-copy cleanup](measurements/list-copy-cleanup.md): fix the real 80-byte
  handled-callback leak, protect partially constructed copies across seven list
  operations, and remove redundant plain-list/typed-array sort scratch. Source
  `883f1c140089` is in focused run `40088243982`; Linux and macOS on both architectures pass; all six completed logs are audited.
  Both Windows jobs fail only the old scalar-key probe's CRLF/LF expectation;
  all new failure/cancellation tests pass. The fixture now explicitly selects
  binary stdout, and the three list targets are added to Windows production
  coverage with an enforced coverage check. Rerun both Windows jobs at the
  repair revision. The 24 macOS ARM64 images also pass independent review.

Local guarded runtime checks pass 130 allocation/retain interruptions plus six
callback exits across eight rounds; three missing-cleanup controls fail as
expected. Those local probes use saved #206 C with current runtime/API edits,
not the current compiler. Current-source Linux GCC and macOS ARM64 Clang checks
now pass in the focused run. Formatting, the frozen inventory (392 declarations,
382 symbols, zero unclassified), 18 native-runner controls and all 124 tracked
documentation link sets passed before publication.

The pending `list-copy-costs` suite compares shared scratch with explicit
separate-lane controls at 0, 1, 32 and 4,096 input words, O1/O2. It measures
allocation requests/bytes, retains, charged peak, final balance, actual code
and compiler stack reports. It makes no timing or C/Rust parity claim.

## Active delivery

[PR #209](https://github.com/e6qu/fun-with-pipes/pull/209) stays at
`b298665da6ac97fe4bcc05318c66e671fed7a5a4`, checkout
`/private/tmp/fwp-arc-benchmark-comparison`. Production `40082867710`, docs
`40082867648`. Bench, docs, both macOS ARM64 jobs, macOS AMD64 GC and Windows AMD64
pass. The remaining gates are still running at the last complete audit.
macOS ARM64's full binary review passes, as does the benchmark; other host reviews
remain. The native file inspector's stale inherited-runtime assertion was repaired
against both exact publication manifests, and all file checks pass.

Helpers/receipts under `/private/tmp` use `fwp-arc-map-delivery`. Preparation and
publication are complete; merge is unrun. Audit all nine production jobs plus
docs, review 8,627 actual binary files, then squash-merge with one subject of at
most 80 characters and an empty body. Continue with this substantial group;
do not open another PR early. Never rerun completed publication helpers.

#208 is verified and merged at `058dc4e5954571ed222ca4d26af4403a52a8516b`.
[History](roadmap-history.md#api-memory-stack-guards-and-connection-cleanup-pr-208)
records its acceptance. Primary checkout remains there with an operational
handoff. Preserve that handoff and unique failed API artifacts.

## Local resources and receipts

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites and
benchmarks run on GitHub. Preserve 64 GiB free, target below 2 GiB, sampled RSS
below 1 GiB and the 180-second deadline. Never raise or bypass these limits.

A download stopped before crossing the disk limit. Independent APFS clones of
2,667 byte-identical evidence files recovered about 2 GiB while retaining every
path, byte and mode (`fwp-evidence-clones-oct24.json`). Reviewed artifact ZIP
copies are pruned only after matching unexpired GitHub digests; reports, layouts
and failure evidence remain. The macOS ARM64 download and review then passed.

List-copy helpers: `fwp-list-copy-publication.json` and
`fwp-audit-list-copy-preparation.py`; publication is COMPLETE. Runtime-only
reproductions: `/private/tmp/fwp-sort-callback-leak` and
`/private/tmp/fwp-list-copy-runtime-probe`. Sort-experiment download/reviews are
COMPLETE under `/private/tmp/fwp-map-order-benchmark/cbacdff5e8cb`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

A bounded current-compiler macOS ARM64 O1 counter check passes at 32 words:
list scratch saves two requests/528 requested bytes, array scratch one/264,
with unchanged retains and whole-program charged peak. Both finish at zero.
This is not the full Linux size/optimization matrix. Evidence and compiler
receipt: `/private/tmp/fwp-list-sort-current-probe` and
`/private/tmp/fwp-verified-list-copy-compiler`. The older manual-API diagnostic
failed to find a List descriptor omitted by the old compiler; it was replaced
with this verified current compiler instead of weakening that check.
