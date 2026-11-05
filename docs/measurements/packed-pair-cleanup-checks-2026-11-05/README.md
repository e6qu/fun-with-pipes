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
25 outcomes per host. A runner audit also retains all target logs, probes and
image identities from the original artifacts. The corrected focused run must
pass before new stack/census work; original failed checks are not discarded.
