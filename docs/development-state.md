# Session handoff

## Next action

This is isolated `direct-integer-output` preparation in
`/private/tmp/fwp-direct-integer-output`, based on hash preparation `c9b07366`.
PR #173 merged after all gates passed. PR #174, `numeric-hash-delivery`, is now
the only active PR; the primary checkout owns its final acceptance. Keep this
candidate isolated until the hash batch is delivered.

Next: rerun the complete native and WASI matrices with the combined test repairs
below, then audit and retain actual binaries/allocation results. The new output
tests passed on all six hosts at `d4c5b39f994b72b9991e8ffd09698aa63e0c5d84` in
`39330733812`, but both Windows jobs failed an existing arithmetic probe's
newline assertion. Both-Linux WASI `39330737723` is still running at that source.
No complete acceptance or timing improvement is established.

Both failed Windows logs were audited: their only failed test is
`full_width_unsigned_products_have_defined_overflow`. Its standalone C main
bypasses fwp's binary-stream setup, so Windows translated `\n` to `\r\n`.
The probe now selects binary stdout explicitly; arithmetic checks are unchanged.
Both this target and integer output now join permanent Windows production CI.
The WASI allocation diagnostics also advance the output phase for the new print
function, preserving useful leak locations. Neither repair changes generated code.

Run `39327804456` at `3a864f4d` passed all-target Clippy and four existing
protocol/trap tests, but all three new output tests failed: ownership lowering
separated `show` from `print` before the generator matcher ran. The fix moves
recognition before ownership lowering, introducing a typed backend-only print
operation with an explicit borrowed argument/unit result. Ordinary ownership
analysis now never creates the eliminated String; no cleanup is bypassed.

Earlier `39326880740` was cancelled while queued after fixing the CLI fixture's
missing `# expose: cli`. Run `39327114349` then caught a needless type borrow;
that and its secondary missing-artifact upload failure were repaired together.
The next run must validate the semantic fix; these repairs alone are not support.

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

## Binary audit preparation

After the repaired six-host test run passes, dispatch `integer-output-report`
with its exact `evidence_run` and `source_revision`. Do not use the failed
`39330733812` run as complete acceptance. The collector requires all
seven tests on all six hosts, rejects ignored/missing cases, verifies source
identity and inspects 144 actual binaries and their tracing symbols. It records
assembly and section sizes; inspect the output code before making stack claims.
No collector result exists yet. Its two validation tests pass in 0.22 seconds.

## Checks

All local checks use the primary checkout's `python3 scripts/local-guard.py` with
unchanged limits. No full compiler build or benchmark ran locally.

- `cargo fmt --all` passed in 1.34 seconds.
- Review corrected a stale runtime comment that still described sets with dummy
  value slots. Sets have stored one word per key since accepted PR #172; this
  comment-only repair does not change the measured output implementation.
- Cache review confirmed that `src/aot.rs` hashes generated C before selecting
  an executable. Both the integer-output and numeric-hash switches change that
  source; neither can accidentally reuse the other setting's executable.
- The extracted actual runtime formatter passed 56 comparisons with standard C
  decimal formatting at O0/O2 in 1.03 seconds, including signed/unsigned extrema.
- Accepted interpreter ran the 19-line fixture in 0.27 seconds; formatting passed
  in 0.01 seconds. These do not validate the new compiler recognition path.
- Raw count, sharing, trap-order and binary-output fixture expectations passed
  with the accepted interpreter in 0.61 seconds after the exposure fix.
- The target-to-shard check passed in 0.15 seconds; documentation passed 61 sets,
  106 anchors and seven work areas in 2.54 seconds.
- The extracted actual lowering passed typed fusion, shared-string preservation,
  target reuse and unsupported-float checks in 1.23 seconds. Accepted-compiler IR
  inspection confirms that show/print are adjacent before ownership lowering.
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
