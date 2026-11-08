# Computed numeric inputs: passing focused checks

[Run 42417868388](https://github.com/e6qu/fun-with-pipes/actions/runs/42417868388),
source `8b24da94a4e54c023f5e4b2341896d97dff092b9`.

GCC ARM64/AMD64 and Clang ARM64 each pass:

- Nine compiler proof tests, including original/transformed values, shared
  inputs and left-to-right traps. The actual derivative edge now receives four
  numeric fields; its previously rejected computed arguments qualify.
- Mixed numeric/boxed ownership at O1 and O2, with stack storage enabled and
  disabled. Outputs agree with the unoptimized interpreter and all four native
  variants release their managed storage.
- Local derivative endpoints, empty/singleton arrays, aliases, analytic results
  and callback trap order. Values and failures match unoptimized interpretation.
- Canonical prototype formatting and measurement acceptance controls.

[index.json](index.json) records all three jobs, artifact identities, full logs
and per-file hashes. The three original ZIPs retain all 21 native executables,
their generated C and execution records. GitHub archive digests, source identity,
empty format patches, native architecture headers, zero-live ownership exits
and failure diagnostics were verified under the resource guard (0.13 s).

These checks establish focused correctness. Subsequent [allocation and timing results](../computed-numeric-time-2026-11-07/README.md),
[compiler comparisons](../computed-numeric-analysis-2026-11-07/README.md) and
[final six-platform verification](../computed-numeric-delivery-2026-11-08/README.md)
provide their separate evidence; the focused checks alone do not establish those claims.
