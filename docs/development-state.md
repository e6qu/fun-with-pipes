# Current work

**Next:** publish the complete measurement report, mark PR #262 ready, and run
all nine production jobs plus docs on that exact final head. Audit every complete
log/artifact before the authorized squash merge. Do not repeat the completed timings.

Branch `recording-work-review`, worktree `.worktrees/scalar-constant-lowering`;
active draft [PR #262](https://github.com/e6qu/fun-with-pipes/pull/262).
Base: verified [PR #261 delivery](measurements/scalar-constant-delivery-2026-11-05/README.md),
merge `2e6e09f539bcdab965d062f0184b585b340b29d8`.
[Lookup contract](measurements/recording-lookups.md) frozen at `bfddc31e` before code.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Source accounting reconciles eight nodes per pair/update. |
| 2 | Verified | Closed numeric proof and focused lifetime controls pass. |
| 3 | Verified | Same-source comparison and original limits are frozen. |
| 4 | In progress | All measurement audits are complete, with 32 missed speed targets and one inconclusive compiler-time control retained. Final platform gates remain. |

## Sources and verified work

Safety/census/compiler source: `6a0ae280c4616f791df507b44cbd31935a16cd67`.
Runtime source: `31c04650527d7a3c9efdd63bd5b4eae8a15d5732`.
Compiler/runtime/library/test trees are identical. The later commit retains
evidence and fixes only census summary totals. This publication adds reports and
docs; no production code changes after these measurements.

| Evidence | Run / complete audit | Result |
|---|---|---|
| [Focused safety](measurements/recording-lookup-checks-2026-11-06/README.md) | `42129223759` / `42134128147` | Three hosts pass: 25 native targets and 302 compiler units per host, four existing ignored units. Audit covers 848 images and 864 probe observations per host. |
| [Measurement tools](measurements/recording-lookup-controls-2026-11-06/README.md) | `42123056112`, job `127580112855` | Eleven suites, 97 tests; full logs and source identity retained. |
| [Memory/work](measurements/recording-lookup-census-2026-11-06/README.md) | `42134160356` / corrected audit `42136506956` | Eight-to-three lookups per pair/update. Validation/node counts, allocation counts, raw/managed peaks and largest reported frames unchanged; cleanup and parent reconciliation pass. |
| [Compiler costs](measurements/recording-lookup-analysis-2026-11-06/README.md) | `42134169729` / `42135475969` | All 672 commands succeed; 13/14 timing cases qualify. All observed time/RSS ratios below 1.05. |
| Previous docs | `42136488509`, job `127625843070`, at `31c04650` | Pass; complete log reviewed, only three intentional runner-failure controls. New publication still needs its own docs job. |

AMD64 large callback worker compiler time is **inconclusive**: identical candidate
copies vary by 2.854%, above 2%. Saved samples rise later for all four copies;
generated C matches, but source/order review establishes no cause. Preserve the
failure under the standing policy to retain verified reductions with timing goals
open. Do not claim its time bound passed or rerun it for a pass.

The first census audit validated every probe but printed obsolete summary totals.
Corrected audit `42136506956`, job `127625915163`, derives 171 commands, 48 images
and 96 executions per architecture. Retained observation hashes pass; only saved
artifacts were re-audited. Earlier safety repairs are verified: explicit test ID
range for Clippy, real `ad.scope` entry with unscoped rejection control, and recovery
hooks confined to active `setjmp` frames.

## Runtime results

[All original results and complete audits](measurements/recording-lookup-time-2026-11-06/README.md)
are retained. The four qualified sessions each ran once on Neoverse-N2/EPYC 7763.

| Session | Measurement run | Job | Complete audit |
|---|---|---|---|
| ARM64 1/2 | `42136888829` | `127627213167` / `127627213106` | `42139232314` |
| AMD64 1 | `42137772065` | `127630185205` | `42140277966` |
| AMD64 2 | `42138616667` | `127632984326` | `42141026225` |

All four audits pass; all 32 long-case 5% speed targets remain unmet. ARM64 ranges
from 0.14% slower to 2.33% faster. AMD64 current-result cases are 1.13–3.90% slower;
history ranges from 0.40% slower to 1.80% faster. Small-case/copy, tracked memory,
cleanup and stack limits pass. Retain the verified lookup reduction under the
agreed policy, with timing goals open. An audit pass does not make timing pass.

Five rejected hosts failed before builds/timing. Their logs and qualifications
remain in the runtime report, including rejected-only run `42137525746`, audited
by `42138966228`. Four downloaded bundles passed digest checks. Combined report
checks verify source identities, CPU/settings, orders, medians, original budgets
and the five rejected attempts. Native binaries were audited on GitHub.

## Local checks and delivery

All full builds, native suites, benchmarks and large artifact audits ran on GitHub.
Focused local checks used `scripts/local-guard.py`: retained bundle hashes
0.25 seconds; combined saved-report validation/table generation 0.48 seconds.
The scratch report helper initially lacked the scripts import path; explicitly
setting `PYTHONPATH=scripts` fixed it. No benchmark or native test reran.
Scratch helpers/logs are in `/tmp/fwp-recording-*` and `../gradient-work/`.
About 80 GiB remains free.

No final production matrix has launched yet. Preserve the final head while gates
run. After all nine jobs, docs and complete audits pass, squash with one explicit
subject of at most 80 characters and an empty body; verify tested/merged trees and
commit message. Then select the next source-level diagnostic from the open plan.
