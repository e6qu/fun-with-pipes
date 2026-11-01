# Current work

**Next:** publish the audited evidence for [PR #238](https://github.com/e6qu/fun-with-pipes/pull/238),
mark it ready, and monitor all nine production jobs plus documentation for that
final head. Focused source `4c4b2ed5cbb08e3e63906e8e39ec27f0cc4aaebf` passes run
`41307125882`; docs `41307132107` pass. All completed logs and native artifacts
are audited. [Results and limits](measurements/derivative-recording-moves.md#focused-results)
include the repaired allocation regression and the AMD64 O2 frame increase.

Worktree `/private/tmp/fwp-returned-callables`, branch `move-derivative-weights`.
Base `94abb83cb33cb52bdcafb19c67c855cf9007059f`. Preserve the primary checkout's
unrelated edits. Publication and squash merge are authorized after all gates pass:
one-line subject, at most 80 characters, empty body and no trailers or attribution.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Protocol published as `238926d0` |
| 2 | Implemented | Direct arguments, ownership transfer and tuple-lowering repair pass focused checks |
| 3 | Implemented | Counts, cleanup, aliases and baseline memory limits pass all focused hosts |
| 4 | In progress | Focused suite and artifact audit pass; full exact-head gates and merge remain |

## Current repair and evidence

- `f5f61bf2`: focused run `41301660682` failed to compile on all three hosts because
  `push_owned` needs a slice reference. `9285227a` passes `&a`; no native tests ran
  before that repair. Inventory and formatting passed.
- `9285227a`: run `41302699512` ran all 29 affected native cases per host on GCC
  ARM64/AMD64 and Clang ARM64. All three passed 23 and failed the same six tests.
  Recording/counts, cleanup, cancellation, workspace, capacity and library unload
  passed. Lint, two ownership unit tests, inventory and native reports passed.
- The six failures lose a computed tuple's type before native ownership checking:
  scopes, nested/Jacobian, precision and checkpoint semantics report `?`.
  The existing #236 compiler reproduces the bug with a small destructuring helper;
  adding a typed intermediate binding makes it compile. `ea354e13` preserves that
  type automatically in lowering. Ownership admission remains strict. The expanded
  suite includes `local_bindings` and a generic sine-derivative regression.
- All completed logs were audited. Docs `41301661813` and `41302703312` passed;
  their failure text is the deliberate runner-control fixture. The current head's
  focused suite passed all 34 native cases and two ownership unit tests per host.

### Allocation repair and accepted evidence

The rejected `ea354e13` helper rewrite increased nested cumulative/peak charge to
100,576/31,776 bytes. `4c4b2ed5` restores complete-operation arithmetic workers
with explicit `curry`/`curry3`: charge returns to 43,056/31,664 with either stack
setting. F128 uses 18,320/11,056. Zero recording argument records and zero final
charge hold across all hosts, O1/O2 and workspace settings. Whole-fixture baseline
limits now guard against moving allocations into other callbacks.

All 34 native cases, two ownership unit tests, lint and inventory pass on each
focused host. The audit verifies 102 image/source pairs, 84 typed outcomes and
72 transfer controls. The protocol links both accepted and rejected measurements.
AMD64 nested O2's largest static frame rises from 720 to 768 bytes; no speedup
or whole-program stack bound is claimed.

Completed logs: `/private/tmp/fwp-238-memory-{arm,amd,mac}.log` and
`/private/tmp/fwp-238-docs-memory.log`. Earlier failed-run logs remain under
`/private/tmp/fwp-238-{focused,repair}-{arm,amd,mac}.log`. The read-only artifact
audit is `/private/tmp/fwp-238-collect-evidence.py RUN SOURCE OUTPUT.gz`.

## Local checks and limits

Guarded Rust/language formatting, generated library docs, the frozen primitive
inventory (394 declarations, 384 symbols, no unresolved contracts), nine historical
timing-budget tests and roadmap checks passed (196 link sets, 106 preparation
pairs, four steps). A bounded Clang O1 runtime-only probe passed normal transfer,
missing cleanup and extra-retain controls with workspace reuse off/on (statuses
0, 237, 243). It uses saved minimal C plus the current runtime, not the new compiler:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-moves-runtime-check.py`.

The guard initially refused work below 64 GiB free. Removing duplicate downloaded
#237 artifacts restored room; no limits changed. Disk remains near the floor.
Use the unchanged guard, serially; full builds, suites and measurements use runners.

## Verified baseline and open goals

#237 passed production `41292025233` and docs `41292025256` on `7590f36b`; merge
`94abb83c` has the same tree `7d86145d9038ccea1b07e7ab719cf8490abf6da8` and a verified
one-line squash message. [History](roadmap-history.md#typed-derivative-owners-and-documentation-pr-237)
records it. Redundant post-merge run `41298428164` was cancelled with no failed steps.

D2/N1/N2 timing acceptance, original Xeon construction regressions and individual
Swift ARC counts remain open. Neither count reductions nor successful integration
prove a speedup. Preserve these limits when publishing the new evidence.
