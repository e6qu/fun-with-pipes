# Session handoff

## Next action

This is the `direct-range-sets` preparation in `/private/tmp/fwp-direct-range-sets`,
based on PR #172's head `a6dd760904c5d72c09a5fcf720d8f255a19de1f1`.
PR #172 remains the only active PR. Its live acceptance handoff is in the primary
checkout, `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
Do not merge this batch or count its base as accepted before that PR passes.

Next: audit six-host collection run `39303492049`, which tests compiler/runtime
revision `7901a576019a01c490efe248c15730fac0602701`, preserved at
`roadmap/revision-range-sets-7901a576`. Later changes add C/Rust benchmark sources,
explicit tracing selection in the general benchmark runner, ISize/USize and
shared-input fixture cases, and documentation;
they do not change the measured compiler or collection runtime.
After PR #172 passes and merges, replay this change on main,
record its accepted evidence and publish the next substantial PR. Require all
nine production jobs and documentation at the final head before squash merge.

Six-host collection run `39303492049` now checks the same preparation. Audit all
hosts, then dispatch `suite=collection-report` with that run and its source ID.
Keep evidence on its measured source; final PR acceptance still requires all
nine production jobs and documentation for the eventual PR head.
ARM macOS passed all 44 tests and all nine cases; the other five hosts are queued.

The preparation passed Linux all-target Clippy, all 44 collection tests and all
nine measurement cases. Both WASI hosts passed 24 tests each, including actual
32-bit oversized-set rejection; no tests were ignored. Reports/logs are in
`/private/tmp/fwp-range-linux-report.json`, `/private/tmp/fwp-range-set-linux.log`
and `/private/tmp/fwp-range-wasi-{amd,arm}.log`. The
[Linux report](measurements/range-sets-linux-2026-10-19.json) and PR #172's
[six-host binary audit](measurements/compact-sets-2026-10-19.json) are retained
in the repository. They record their measured revisions, not this eventual PR head.

## Current batch

`range lo hi | set.from-list` now constructs inline integer keys directly in
one owned set buffer. Equal or descending bounds return the static empty set.
The compiler preserves evaluation order, checks byte limits before narrowing
to the target's size type, and leaves boxed integers and shared input lists on
their existing paths. No new language syntax or public function is introduced.

Three native tests compare raw/optimized interpretation and generated O0/O2
programs in ARC and stressed tracing modes. They cover integer widths/bounds,
alias updates, bound effects/traps, exact construction allocations, injected
allocation failure and oversized counts. Deliberately missing size checks,
missing release and disabled optimization must violate their respective checks.
Actual WASI coverage adds this fixture and explicit 32-bit overflow cases.

The six-host collection workflow now requires 44 focused tests, saves eight
range-set binaries per host, and compares ordinary/direct construction at
32/4,096/65,536 keys. It hashes every key and records eight timing samples per
version. The collector audits all targets, allocations and binary formats.
The [benchmark explanation](benchmarks.md#direct-integer-range-sets-comparison-in-preparation)
distinguishes the initial Linux timings, pending full report and allocation counts.

`bench/range-set` adds a million-key C/Rust/fwp comparison to the existing
production benchmark gate. All three hash the same canonical bytes; the report
distinguishes optimizer/storage differences and explicitly selects tracing.
No full benchmark was run locally. Guarded `/private/tmp/fwp-check-range-peers.py`
verified equal C/Rust/raw-fwp outputs for 0/1/257 keys in 3.05 seconds, with C and
Rust warnings treated as errors. Rust and fwp formatting passed. The complete
comparison remains pending on CI.

## Checks and unresolved validation

No new compiler was built locally. Full builds, suites and measurements stay
on GitHub. All local workloads use the primary checkout's shared
`python3 scripts/local-guard.py` with unchanged limits, even from this worktree.

- `cargo fmt --all` passed in 1.46 seconds.
- `python3 scripts/test-collection-evidence.py`: six tests passed in 0.22 seconds.
- `python3 scripts/test-native-test-runner.py Coverage.test_repository_targets_are_assigned_exactly_once`
  passed in 0.33 seconds; the new target belongs to one macOS production shard.
- `python3 scripts/check-roadmap.py`: 60 document sets, 106 immutable anchors
  and seven roadmap areas passed in 2.68 seconds. The handoff's required `Next:`
  marker was restored after the first check caught its omission. Python syntax
  and Rust formatting checks pass; the accepted formatter fixed the new fixture.
- The accepted ARM Mac compiler at
  `/private/tmp/fwp-170-accepted-macos/fwp-macos-arm64/fwp` ran the thirteen-line
  original range-set fixture, including eight fixed-width integer types and
  alias updates. Added ISize/USize cases also pass the raw accepted interpreter;
  those two types and an explicit shared-list case await the final-head CI run.
- `/private/tmp/fwp-count-range-set.py`, guarded Clang O2 and its executable
  counted ordinary construction: 4,099 requests/196,624 bytes for 4,096 keys.
  It counts initialized-allocation slow paths only once.
- `/private/tmp/fwp-check-range-runtime.py` passed O0/O2 checks in 3.07 seconds.
  It uses accepted compiler scaffolding with the new runtime, not a newly built
  compiler. At 0/1/7/257/4,096 keys, direct construction requests
  0/16/64/2,064/32,776 bytes; each nonempty set uses one request. ARC charge
  returns to baseline. Removed size guards and releases exit 245/243 as required.
- Linux compiler integration and WASI passed. Full native platform acceptance
  remains pending. Initial AMD EPYC 7763/Clang 18.1.3 ARC/O2 timing ratios are
  1.030/0.848/0.351 at 32/4,096/65,536 keys (direct/ordinary median, eight samples).
  Small-input samples overlap; retain the slightly slower small-input result.
  The largest case measured 2.112 ms versus 6.021 ms. These are whole-process
  fwp/fwp measurements, not C/Rust comparisons or a universal speed claim.
- The guard stopped a later documentation check below 64 GiB free disk. Removed
  only old downloaded artifacts from `/private/tmp/fwp-server-entry-evidence/39078070919`
  after verifying all 24 originals remain available on GitHub; the tracked report
  and source worktrees remain intact. Free disk returned to 65 GiB. The unchanged
  guard then passed `python3 scripts/check-roadmap.py` in 2.73 seconds.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Persistent subscriptions,
unknown retained captures, resource-owning tail frames and mutual recursion need
further proofs. JIT is excluded. Move accepted evidence to history; keep one live
next action and select further costs from representative measurements.
