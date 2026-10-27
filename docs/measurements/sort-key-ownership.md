# Ownership of sort keys and scalar record reads

This batch targets two temporary owners in the word-frequency example. It is
implemented on the next branch, but its combined checks and measurements are
pending. PR #219 remains the only active PR while its full matrix runs.

A **record** groups fields into one value; `(word, count)` is a two-field record.
`.1` selects its second field. In the word-frequency sort key,
`both (.1 | neg) .0` returns `(-count, word)`: negative counts sort larger counts
first, and the word breaks ties. The saved key needs an owner for its String
while the original record remains live.

The old generated path also acquired a temporary String owner merely to select
`count`, then immediately released it. It duplicated the input record so the two
selectors could consume it separately. Neither owner is needed when the compiler
can see the relevant reads and preserve their cleanup order.

## Changes and boundaries

The generic entry of a pure scalar projection reads its boxed input directly,
then consumes the record. Its direct worker still accepts separate fields.
Selection requires one consumed record parameter, a scalar result and a plain
field read. Resource-bearing inputs and borrowed-worker contracts are excluded.
Function entry interruption retains ordinary pending-owner cleanup. This change
also helps scalar projections that remain independently callable.

`sort-by` now participates in the existing known-callback specialization pass.
It can combine known `both`/composition/selector calls into one key calculation.
This removes the second temporary pair owner without introducing a source API
or a runtime choice of ownership mode. Unknown function values remain supported
with their ordinary call convention. Captured computations must run once, even
when the input list is empty; failure and cancellation must release partial keys.

## Declared comparison

Run the `arc-costs` suite in [the evidence workflow](../../.github/workflows/numerics.yml).
The focused `scalar-projections` choice runs the related correctness checks
without regenerating measurements. Both use the current Rust compiler on native
Linux AMD64/ARM64, GCC and the production Rust O1/debug-assertion/overflow settings.
Generated ordinary and instrumented C use O2 with the existing explicit flags.
No older fwp binary is a build dependency.

The baseline is [the unique-array report](unique-array-storage-2026-10-27.json),
source `b9d637b6336f8a66b05c0b721f7b010aaa5aa998`. All 13 A2 fixtures are repeated,
with unchanged source/input hashes. Word-frequency inputs contain 4,096 tokens
and 256 distinct words, or 65,536 tokens and 4,096 distinct words.

For D distinct words, require exactly **2D fewer effective retains and non-final
releases**, and D fewer effective last-owner queries. No helper's attempted-call
count may increase; specialization may also remove no-op calls on static function
values. Preserve every observed total and attributed site. Allocation requests,
requested bytes, peak/final managed bytes and count metadata must be unchanged.
All other fixtures' effective counts, attempted calls and memory totals must match
the baseline. A missing required String owner must fail, rather than count as an
extra saving.

Three fresh runs must agree exactly. The independent allocation observer and
site-level observer must agree; native output must match raw interpretation and
the existing word-frequency oracle. Retain generated C, binaries, sections,
stack-frame estimates, commands, host/tool identities, source hashes and samples.
Audit ordinary executable size and entry frames separately from count savings.
These are **fwp-before versus fwp-after operation counts**, not execution timing
or a C/Rust comparison. Do not infer a speedup from fewer reference counts.

## Correctness controls and status

[Record conversion](../../tests/record_conversion_ownership.rs) tests shared and
unique parents, String results, scalar bits that resemble pointers, physical
release and interruption at the actual entry tick. Deliberate extra-retain and
missing-free variants must fail at O1/O2. The scalar-only prototype passed both Linux hosts in `40499978041`; all six
ordinary/fault probe statuses and outputs per host were audited. The combined
change and measurements remain pending.

[Sort callbacks](../../tests/sort_callback_ownership.rs) compare raw/native output
for repeated/equal keys, live aliases, managed keys and callbacks, empty inputs,
effectful captures, partial failure and task cancellation. They also check zero
remaining managed bytes and deliberately broken result/key cleanup. Existing
record conversion-overflow and record update controls remain in the focused batch.
Full nine-job production, documentation and analysis gates are required before
claiming verified delivery.
