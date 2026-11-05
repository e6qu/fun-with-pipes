# Single-owner cleanup checks

The first repair at `14707729042f3202527998296ec8c5f196615cb0` removes the
redundant owner/cleanup record on reuse. [Run 42010857359](https://github.com/e6qu/fun-with-pipes/actions/runs/42010857359)
finished every target on Linux AMD64/ARM64 and macOS ARM64. Each host passes
24 of 25 native targets and 292 compiler units (four existing ignored tests).

All three hosts have the same two failures:

- Rust formatting requires the new long assertion to wrap. Clippy reports no
  separate diagnostic; the combined formatting/lint step fails on formatting.
- One ownership probe exits 249 on its first empty-input case. The observer that
  records the output buffer address was inserted before the second owner.
  That owner now exists only in the allocating/no-reuse branch, so the normal
  reuse path never sets the observation. The value/float-bit tests still pass.

The repair moves this observation before the mapping loop, outside conditional
allocation, including zero iterations. It keeps pointer-identity checks, exact
allocation counts, deliberate missing-free/extra-allocation/corruption controls,
trap/cancellation and alias checks. It changes test instrumentation, not the
compiler implementation or expected outputs.

[Full job results](first-results.json) and adjacent compressed logs retain all
25 outcomes per host. [Runner audit 42013195562](https://github.com/e6qu/fun-with-pipes/actions/runs/42013195562)
checks all target logs, 775 images and 791 probe records per host. Its rejection
contains only the recorded formatting and observer failures. [The receipt](first-artifact-audit.json)
and compressed full log preserve this result; the artifact retains all observations. The corrected focused run must
pass before new stack/census work; original failed checks are not discarded.

## Corrected focused result

[Run 42013253058](https://github.com/e6qu/fun-with-pipes/actions/runs/42013253058)
passes all three hosts at `ecdf2476b3095d31c7a5a88867cbc1ddcc45b3e4`.
Formatting/all-target lint, compiler units, primitive contracts, source selection
and all 25 native targets pass, including the corrected pointer observation.
Documentation 42013258857 passes. [Full artifact audit 42015894951](https://github.com/e6qu/fun-with-pipes/actions/runs/42015894951)
verifies all 25 targets, 822 native images and 838 probe records per host, with
no unexpected diagnostics. [Receipt](corrected-artifact-audit.json) and adjacent
compressed full log retain the result. Complete-program stack/allocation run
42015900941 also passes both architectures; its saved-data audit is next.

## Saved-stack audit repair

[Audit 42017767534](https://github.com/e6qu/fun-with-pipes/actions/runs/42017767534)
passed its eight budget and six initial stack controls, then rejected a valid
GCC `dynamic` entry for the existing `fwp_apply` dispatcher on ARM64. Its
argument array has a runtime length (`runtime/fwp_rt.c`); GCC reports the known
frame portion separately from that array. The new auditor incorrectly required
every entry to have a statically bounded total. That was never the frozen
+128-byte comparison rule. AMD64 had not yet been audited.

The correction accepts GCC's three documented qualifier combinations, keeps
all entries and lists unbounded dynamic entries separately in the receipt.
It still recomputes every reported byte count and the unchanged +128-byte
limit. A new control verifies the distinction; malformed qualifiers still fail.
Both architecture audits now run even if one fails. No native measurement is
repeated. [Failure receipt](first-stack-audit.json) and adjacent full log remain.
