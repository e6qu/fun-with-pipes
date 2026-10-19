# Session handoff

## Next action

This is isolated `direct-integer-output` preparation in
`/private/tmp/fwp-direct-integer-output`, based on hash preparation `c9b07366`.
PR #173 remains the only active PR; its primary-checkout handoff owns acceptance.
The hash batch must follow it before this preparation is delivered. Do not push
these changes onto either tested head or open a competing PR.

The initial ARM probe `39326880740` at `72865856` was still queued when a
local check caught the protocol fixture missing its required `# expose: cli`.
That fixture is fixed; the obsolete queued probe was cancelled.
Corrected run `39327114349` at `d8d98a1f` failed Clippy on an unnecessary borrowed
type reference before tests ran. Removed that borrow. Its second failure was an
artifact upload expecting files from the skipped test step; upload now depends
on that step running, and records the source before testing. Rerun the full probe;
these repairs do not establish that the integration tests pass.

Next: run six native `integer-output` jobs and both-Linux `wasi-arc` checks on
this source, inspect every failure, and retain actual binaries/allocation results.
No full compiler integration or timing improvement is established yet.

## Prepared change

An immediately consumed integer `show | print` uses a 24-byte stack buffer and
writes the same digits/newline to `fwp_prog_out`. This removes the temporary owned
String visible as the second managed request in the hash comparisons. It applies
only to resolved primitive show/print for inline signed/unsigned integers up to
64 bits. Stored/shared strings, wide numbers and other displays keep their work.
`FWP_DIRECT_INTEGER_PRINT=0` provides an explicit comparison control. No new syntax.

Tests compare raw interpretation with ARC/stressed tracing at O0/O2, both switch
settings, integer bounds, shared strings and trap order. A binary-protocol test
keeps printed diagnostics separate from framed results. A string-allocation probe
requires zero immediate-output strings versus one in the control; deliberately
adding a string must fail. Native binaries/C are retained by the focused suite.
The same boundary fixture joins the actual WASI shutdown corpus.

## Checks

All local checks use the primary checkout's `python3 scripts/local-guard.py` with
unchanged limits. No full compiler build or benchmark ran locally.

- `cargo fmt --all` passed in 1.34 seconds.
- The extracted actual runtime formatter passed 56 comparisons with standard C
  decimal formatting at O0/O2 in 1.03 seconds, including signed/unsigned extrema.
- Accepted interpreter ran the 19-line fixture in 0.27 seconds; formatting passed
  in 0.01 seconds. These do not validate the new compiler recognition path.
- Raw count, sharing, trap-order and binary-output fixture expectations passed
  with the accepted interpreter in 0.61 seconds after the exposure fix.
- The target-to-shard check passed in 0.15 seconds; documentation passed 61 sets,
  106 anchors and seven work areas in 2.54 seconds.
- Focused compiler/native integration, WASI, allocation controls and binary
  inspection remain pending; record their source and run IDs after dispatch.

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

All seven areas in [PLAN.md](../PLAN.md) remain open: ownership/tracing removal,
functional costs, machine performance, autodiff, numerical kernels, dependable
comparisons and larger applications. Persistent subscriptions, unknown retained
captures, resource-owning tail frames and mutual recursion still need proofs.
JIT is excluded. Completed measurements do not complete these work areas.
