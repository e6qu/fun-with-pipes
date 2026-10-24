# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC only for necessary sharing. JIT is excluded.

## Current action

**Next:** complete exact-head acceptance of [PR #208](https://github.com/e6qu/fun-with-pipes/pull/208),
squash-merge after its nine production jobs, documentation and binary reviews
pass, then deliver the grouped benchmark/map work. One active PR at a time.
Use one subject of at most 80 characters and an empty body; verify the merge.

## Active PR: API memory and stack cleanup

Checkout `/private/tmp/fwp-http-application-memory`, branch `http-memory-delivery`,
clean at `227e671257d885185e54b3f915f6d1ebf470b3ea`.
Production `40074183388`: bench and both macOS ARM64 shards pass; six other jobs
are still running. Docs `40074183289` passes. Complete finished logs are audited;
no known failures. Audit again with `fwp-audit-http-memory-delivery-final.py`.
Receipts and helpers are under `/private/tmp`, prefixed `fwp-http-memory-delivery`.

The group adds bounded API request/disconnect/shutdown checks, ordinary Linux
task-stack pages, checked Unix guard setup and single-owner Windows test sockets.
The source retains unchanged API budgets and complete failed/repaired evidence.
The delivery guard fixture uses 1 MiB stacks; final-head checks must cover that
adjustment. Focused evidence at `cf3a11e4` does not replace final acceptance.

Final binary review is COMPLETE for `macos-15`: ownership, arrays, layouts,
floating output, files, six API images and two static-guard images. Its verified
ZIP copies were pruned (341.7 MiB), retaining reviews and download hashes.
Other hosts are unreviewed. Use `fwp-review-http-memory-delivery-host.py --host HOST
--phase PHASE`: download, ownership, arrays, floats, Linux-only controls, files,
services, prune. Both Mac shards must pass before that host's download.
Review reports: `fwp-http-memory-delivery-evidence/227e671257d8` and layout directory.
The merge/after-merge helpers are syntax checked but UNRUN. Never merge before
all ten gates and six-host reviews pass. Earlier publication/wiring helpers are
COMPLETE. Initial `d8fc00eb` cancelled runs are not acceptance of this head.

## Next grouped PR: explicit benchmarks and lower map peak memory

Checkout `/private/tmp/fwp-arc-benchmark-comparison`, branch `arc-benchmark-comparison`,
HEAD `6a6e8eea325cc3183e39cd472209cd452c497089`, with additional review/docs/artifact
changes still uncommitted. No second PR is open. The old clean #207 checkout was
moved here; `/private/tmp/fwp-file-http-delivery` no longer exists. Its branches,
commits and reports remain. Do not rerun completed #207 helpers.

The general C/Rust comparison explicitly requires `CC`, memory mode and `FWP_LTO=0`.
Production now measures checked ARC. Historical scalar measurement explicitly
selects tracing. Inspect actual images and raw samples; reject wrong modes,
architectures, object files and missing samples. Separate GNU-time RSS runs and
instrumented fwp binaries measure memory without entering the ordinary timer.

Verified preparations (all publication helpers are COMPLETE; inspect JSON receipts):

| Source | Run | Result |
|---|---|---|
| `617bb2319760` | `40075912779` | Both Linux hosts pass; 42 actual baseline images and eight corrupted-copy controls reviewed |
| `b16ed5e33f29` | `40076674217` | Both pass; 70 timed/profile images, all RSS/count samples and fourteen leak controls reviewed |
| `18ac20729402` | `40077293691` | Both output checks pass; 98 baseline/experiment images reviewed. Arithmetic screen passes ARM64 but fails AMD64; no compiler rule selected |
| `6a6e8eea325c` | `40078374681`, `40078376733` | All six map jobs and both Linux benchmarks pass with complete logs audited; final artifact review pending |

The arithmetic experiment retains all noisy/slower rows and a fixed screen.
Its new portable inspector and readable result report are uncommitted. Loop
speed alone does not pass the all-program screen. See the preparation's
`docs/measurements/checked-bounds-results.md` and `arc-comparison.md`.

Map/set builders compact sorted borrowed words in their input scratch lanes and
free sort scratch before result allocation. Callers keep original owners alive
or use unboxed words, and discard these lanes after return. Duplicate-key identity
and last-value rules stay unchanged. Failure injection now includes comparisons
while scratch is live and after release. A 4,096-key regression uses exact large
allocations; delayed scratch release must exceed its peak budget. Six-host ARC,
tracing, reuse and failure checks pass at GCC on Linux and Clang elsewhere.

Linux profiles at `6a6e8eea` show map peak charged bytes 24,000,008 → 16,000,008;
four requests, 24,000,032 requested bytes and one retain remain unchanged.
Ordinary final charge is zero and injected leaks are detected. These scoped
managed counts exclude raw buffers, allocator metadata and stacks. No timing
improvement or universal C/Rust parity is claimed. Current-source benchmark
archives are fully reviewed under `fwp-map-scratch-benchmark-evidence/6a6e8eea325c`.

Before the next publication, finish the known evidence repairs already in the tree:
save three previously omitted cleanup/control binaries, upload map evidence in
production, keep separate memory measurements in the production benchmark job,
and update the map and collection reports' stale test counts (inline CAF 2 → 6; maps
6 → 7). The new count guard caught a local path typo, fixed immediately; all
seven original collection controls pass (0.13s). A new peak/cleanup/exit control
also checks that incorrect map evidence is rejected. All eighteen native coverage/upload/
failure controls pass (7.67s). Repeat focused map CI for the additional saved
binaries, then review them. Do not restart PR #208 for these independent changes.

## Previous delivery and retained evidence

PR #207 is verified and merged at `46a7235a81c46d30d0c155f319913e6b7fe4ddbc`.
Tested `bd0dc0100a516099590c340c012f74b7b666ebd2` passed all ten checks and
8,406 binary reviews. Primary checkout is detached at that merge; only this
operational handoff is dirty. Preserve it when advancing after #208.

Keep unique failed evidence: `ef66ca99` metric parsing; `027be46e` Linux RSS and
Windows idle timeout; `10626760` socket-reset diagnostic. All were repaired;
original archives remain in `/private/tmp/fwp-http-memory-failures-027be46e` and
mapping/socket directories. Isolated Windows repeats were not the repair.
Completed publications/downloads/reviews require inspecting receipts before retry.

## Local limits and checks

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, suites and
benchmarks stay on GitHub. Keep 64 GiB free, target below 2 GiB and workload RSS
below 1 GiB. A full local API Clang build exceeded RSS earlier: never retry it
or raise limits. Only verified duplicate caches/clean published copies were pruned.
Keep dirty work, source tags and unique failures. Check disk before downloads.

Map preparation formatting/workflow/Python/docs checks pass (4.45s); native
acceptance uses the runs above. Arithmetic and benchmark binary inspections use
LLVM without executing downloaded images. The primary handoff's prior version
is saved at `/private/tmp/fwp-handoff-before-benchmark-consolidation.md`.

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
