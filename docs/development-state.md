# Session handoff

## Next action

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172), branch
`compact-set-storage`, is ready. This revision fixes empty-set construction:
return the static empty set before allocating temporary storage.

Next: publish this repair, run the six-host collection matrix, and replace
superseded production run `39294160658`. After the collection run succeeds,
run `suite=collection-report` on GitHub with its run ID and exact source revision.
Inspect its binary report there and download the resulting JSON. Require all
nine production jobs and documentation for the final head, including actual WASI
execution, before squash merge. Supply a one-line subject and empty body.
Full builds and large evidence collection stay on GitHub runners.

## Current batch

Sets now store keys without unused unit-value slots. Maps keep key/value pairs,
including maps with unit values. The interpreter distinguishes sets from maps,
so compile-time constants generate the correct layout. Native construction,
updates, set operations, cleanup, decoders, JSON, comparisons and hashing use the
appropriate entry size. Logical values and evaluation order stay unchanged.

A freshly built set of `n` distinct keys requests `8 + 8*n` container bytes,
previously `8 + 16*n`. Empty sets use static storage and skip construction scratch.
These figures exclude allocator headers, rounding, scratch and separately
allocated keys. Insertion can reserve capacity. No elapsed-time or C/Rust parity
claim follows from this change.

Tests cover raw/optimized interpretation, native ARC/tracing at O0/O2, nested and
wide-number keys, sharing, JSON, protocol round trips, REPL linking, constants and
WASI. A probe checks allocation requests for 0, 1, 7, 257 and 4096 keys; restoring
an unused slot must fail. Existing allocation/retain failures, cancellation and
reuse checks remain. The report collector requires all 41 focused tests per host
and inspects generated C, executables, disassembly and byte counts.

## CI evidence and unresolved checks

- Accepted [PR #171](roadmap-history.md#mixed-tail-recursion-pr-171) merged as
  `f3f3bd811c6d3935cd84fca2f7e6e877dc13c3d0`, identical to tested head
  `13210b757db74379c4f1d9893fd0049d2e774916`. All nine jobs and documentation passed.
- Initial focused Linux run `39292052172` passed 39/41. Both test assumptions were
  repaired: select `--fn build-set` for inspection, and arm the omitted-drop
  control only during injected failures. Both repairs passed on all six hosts.
- Six-host run [39294156070](https://github.com/e6qu/fun-with-pipes/actions/runs/39294156070)
  tested `8c5e3851383a3924122b2c517979c8bfc0be6160`. Every host passed 40 tests,
  failed only the empty-set allocation assertion, and ignored none. All six
  complete logs were audited: 240 passed, six instances of that one failure.
  The runtime repair keeps the strict zero-request assertion.
- The map/set failure probe cleaned every injected exit: 104 points normally,
  106 with reuse poisoning. Smaller sets fit more entries before needing growth.
  Both deliberately omitted-cleanup controls still failed as required.
- Documentation `39294160469` passed. The empty-set repair still needs complete
  CI validation; no new compiler was built locally.
- Older superseded production `39292969344` was cancelled; its available logs had
  no additional failures. Cancellation and partial passes are not acceptance.

## Local checks

All workloads used `python3 scripts/local-guard.py`, serially, with unchanged
limits. The accepted ARM Mac compiler at
`/private/tmp/fwp-170-accepted-macos/fwp-macos-arm64/fwp` identifies head
`142117d2`; it supplied reference output and C scaffolding, not a new compiler.

- Rust/fwp formatting, `git diff --check` and the documentation audit pass.
  The audit checks 60 document sets, 106 immutable anchors and seven work areas.
- `python3 scripts/test-collection-evidence.py`: five tests pass. They reject
  missing/failed targets, cancelled runs, extra slots and incomplete byte counts.
- Raw interpretation of `tests/fixtures/compact_sets.fwp` supplied its twelve-line
  reference output. Explicit `build --emit-c --gc arc --fn build-set` retains the
  selected builder.
- `/private/tmp/fwp-selected-set-probe.c` uses that builder scaffold with current
  runtime sections and the explicit one-column operations record. Guarded Clang
  O0/O2 builds pass in 0.51/0.85 seconds; executions pass in 0.50/0.26 seconds.
  Requests are 0/16/64/2064/32776 bytes at the five sizes; allocator charges are
  0/16/64/2560/32776. ARC charge returns to its starting value after each result.
  This checks the runtime path, not the new compiler's generated wrapper.
- An earlier direct-runtime probe passed at O0/O2; restoring a wasted slot exited
  211 as required. Its ARM64 disassembly showed eight-byte indexed key access.
- `/private/tmp/fwp-audit-172-failures.py` verified all six complete CI logs in
  0.22 seconds. The documentation audit after this repair passed in 3.07 seconds.

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
further proofs. JIT is excluded. Select the next cost using representative
programs and equivalent-work measurements; move accepted evidence to history.
