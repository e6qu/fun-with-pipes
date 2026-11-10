# Current work

**Next:** publish the verified count/lifetime/HTTP evidence, open the normal PR,
and start ordinary runtime and compiler-cost measurements. Monitor sustained load
run `42797169205`; all four jobs reached the load protocol. Keep every noisy or
missed timing target explicit before final delivery.

Worktree `.worktrees/service-cpu-costs`, branch `service-cpu-costs`. The last native
correctness source is `cd661ff84b88736ceec83c75e0e2ecf7e6de551d`; the next publication
adds reports and starts the final matrix. Production compiler sources are unchanged
since `c49af8a6e873380cd328d2679c1df2a6a795b489`.

| Run | Source | ARM64 job | AMD64 job | Result |
|---|---|---|---|---|
| `42790112990` | `c49af8a6e` | `129741105253` | `129741105281` | Pass: 14 units, eight native targets / 34 tests, actual counts and fault controls |
| `42792514554` | `cd661ff84` | `129749269814` | `129749269413` | Pass: omitted-file-owner control, target and lints |
| `42793407188` | `cd661ff84` | `129752322335` | `129752322565` | Pass: HTTP responses, physical cleanup, broken counters and slow clients |

The complete logs contain no compiler warnings or failed tests.
[Counts](measurements/nested-resource-counts-2026-11-10/README.md) show 29.7–36.9%
fewer large-case cleanup registrations and 4.85–5.34% fewer actual reference
increments/decrements, with unchanged heap use. The [file-lifetime control](measurements/nested-resource-lifetime-2026-11-10/README.md)
exposes premature closure after removing a real protecting hold. [HTTP checks](measurements/nested-resource-http-checks-2026-11-10/README.md)
verify the second application. None of these establishes a speedup.

## What changed and what is still unverified

`src/cgen/resource_borrows.rs` proves when an enclosing resource owner protects an
inner parameter through exact aliases and immutable projections. It tracks only
initialized bindings and rolls back scope state. Reassigned IDs and loop/self-tail
rebinding prevent selection. All three native result representations use it;
ordinary argument owners and interpreter/debugger metadata stay intact. A frame
is omitted only when the proof removes its last parameter and it has no bindings.

[First focused checks](measurements/nested-resource-first-checks-2026-11-10/README.md)
pass 14 unit checks and eight targets / 34 integration tests per Linux architecture
at `0c73a4e7102876fef8d576abdce5b1290f0b28c0`. Initial missing rustfmt/Clippy setup
is repaired. Both lints passed at superseded head `1df44e5f2`; that run was cancelled
before measurements. Its complete logs/cancellation receipt remain in the report.
The file control removes a real protecting hold and exposes premature closure
on both hosts at O1/O2. Its complete small native archives are retained and locally
verified against their recorded size, SHA-256 digest and member checksums.

The [frozen contract](measurements/nested-resource-owners.md) uses ordinary reference
`65719f7fc2277a5b97c5a790df941fea6c5eb4d7`, retained by
`roadmap/service-cpu-software-clock-2026-11-10`. Both compilers are built from Rust;
no previous fwp executable is a build dependency. The earlier disabled-proof
reference was replaced before measurement because it omitted some added compiler
setup costs. Contract anchor `be57644e4` precedes production changes.

## Remaining validation

- Count/fault checks pass. Dispatch `nested-resource-time` with an
  exact `roadmap/weak-callback-time-*` tag and pass it through `weak_time_tag`.
  The workflow measures contemporary C/Rust/Swift/fwp peers, then reference/candidate
  binaries and identical copies using the audited C pilots. Two sessions per host;
  sixteen balanced rounds; original 2% copy limit. Preserve every missed/noisy case.
- Ordinary compiler costs cover four applications plus twelve growing inputs with
  the explicit `nested-resources` contract (at most 2% extra time / 5% extra RSS).
  A separate diagnostic compiler counts both proof scans and alias walks and must
  emit identical C. That observer has not yet compiled or run natively.
- Finish sustained HTTP load `42797169205`. Responses and disconnect/error cleanup
  pass. Static HTTP selection does not establish an HTTP speedup.
- Publish one normal PR. Finish nine exact-head production jobs, docs and the
  complete-log audit before squash merging with one subject of at most 80 characters,
  an empty body and no trailers. Then continue the remaining roadmap.

## Earlier verified evidence

[Service CPU attribution](measurements/service-cpu-attribution-2026-11-10/README.md)
passes native replay `42781360626` and independent local reconstruction. Saved
recordings/binaries were decoded without resampling or rebuilding. The pinned
perf reader repair recognizes the actual `0x` end marker; the old reader still
fails. All previous failed decoder/setup attempts remain recorded.

Identified ownership work is 40–43% of sampled CPU work on ARM64 and 48–51% on AMD64;
cleanup bookkeeping is also prominent. These are not elapsed-time gains. Inlining
erased service phase boundaries; unknown peer library work stays unclassified.

[PR #275 delivery](measurements/compiler-borrowed-final-gates-2026-11-10/README.md)
merged as `13d31fc4041a664129ed5674845750836faa0a84`, with an equal verified tree and
one-line message. Its nine production jobs, docs and complete-log audit pass.
Type copying fell 29–32%, with unchanged C/diagnostics; ordinary application
compilation improved. Four noisy AMD64 growth comparisons remain open.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | Verified profiles, count reductions and file/HTTP lifetime checks | Ordinary timing, compiler costs, sustained load and final delivery |


## Local checks and preservation

All local checks use `python3 scripts/local-guard.py` serially:

- `cargo fmt --all -- --check`: pass, no local builds.
- `actionlint` on the changed native/time/numerics/compiler workflows: pass.
- `test-nested-resource-counts.py`: two controls pass.
- `test-nested-resource-timing.py`: three controls pass.
- `test-compiler-build-comparison.py`: five controls pass, covering both contracts.
- `test-nested-resource-analysis.py`: two controls pass after fixing repeated
  instrumentation rejection; native observer verification is still pending.
- `summarize-nested-resource-counts.py`: raw cases and both hosts agree.
- Complete file-control ZIP hashes, member checksums, ELF architectures and results
  pass local verification; small HTTP reports agree with their raw outcomes.
- `check-roadmap.py`: 463 link sets, 106 immutable preparation anchors and seven
  roadmap steps pass with these reports. Earlier reader/replay checks are recorded
  with their measurement reports.

Keep 64 GiB free disk, generated target data below 2 GiB, sampled workload RSS
below 1 GiB and the 180-second guard deadline. Last free space: about 108 GiB.
Preserve unrelated root changes, old worktrees, stash
`451bbf713d451f2d62d80fd7676839404875846a` and pre-rebase backup
`540b0682408d751afb6e439d58a3b887bdcba373`.
