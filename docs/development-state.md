# Current work

**Next:** verify the arithmetic-helper repair and whole-fixture memory limits in
[PR #238](https://github.com/e6qu/fun-with-pipes/pull/238), then run the full nine-job
matrix. Head `ea354e13` passed focused run `41303592060` and docs `41303595440`,
but its nested derivative fixture allocates more memory than #237. It is not
accepted. [The protocol](measurements/derivative-recording-moves.md) defines acceptance.

Worktree `/private/tmp/fwp-returned-callables`, branch `move-derivative-weights`.
Base `94abb83cb33cb52bdcafb19c67c855cf9007059f`. Preserve the primary checkout's
unrelated edits. Publication and squash merge are authorized after all gates pass:
one-line subject, at most 80 characters, empty body and no trailers or attribution.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Protocol published as `238926d0` |
| 2 | Implemented | Direct arguments, ownership transfer and tuple-lowering repair pass focused checks |
| 3 | Implemented | Counts/cleanup pass; repair extra arithmetic callback allocations |
| 4 | In progress | Expanded focused suite, evidence audit, full exact-head gates and merge |

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

### Memory regression found during artifact audit

On all three hosts, the nested 256-operation fixture at `ea354e13` charges
100,576 bytes cumulatively and peaks at 31,776. With stack promotion, #237 used
43,056 and 31,664 respectively. Final live charge is zero in both. Zero recording
argument records therefore did not establish a net allocation improvement.

Generated C shows that the rewritten curried arithmetic helpers construct runtime
partial callbacks; the original complete-operation workers specialize directly.
The repair restores tuple-input workers with explicit `curry`/`curry3`, retaining
the new direct recording arguments and strict call-stage ownership rules. The
fixture now checks total and peak charge against #237 for each type/stack setting.
Retain the failed observation; verify the repair before starting full CI.

Compact rejected-head observations: `/private/tmp/fwp-238-recording-evidence.json.gz`.
Generated C comparison: `/private/tmp/fwp-238-{current,baseline}-nested.c`.

Full logs are `/private/tmp/fwp-238-{focused,repair}-{arm,amd,mac}.log` and
`/private/tmp/fwp-238-docs-{first,repair}.log`. The prepared read-only artifact audit
is `/private/tmp/fwp-238-collect-evidence.py RUN SOURCE OUTPUT.gz`; after a passing
focused run, verify its source/image hashes, architecture and control statuses.

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
