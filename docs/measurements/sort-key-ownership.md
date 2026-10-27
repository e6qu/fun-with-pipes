# Ownership of sort keys and scalar record reads

This batch removes two temporary owners in the word-frequency example. Both
native Linux hosts passed the correctness tests; [runner audit 40503213568](https://github.com/e6qu/fun-with-pipes/actions/runs/40503213568)
verified their [complete measurements](sort-key-ownership-2026-10-27.json).
Full production verification remains pending. [The handoff](../development-state.md)
tracks delivery; PR #219 must merge before this becomes the next PR.

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
releases**. Require 6D fewer retain attempts, 6D+2 fewer release attempts and
3D fewer last-owner queries. Successful last-owner queries and final releases
must be unchanged: the removed queries saw shared pairs or static closures and
returned false. Allocation requests,
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
source passed both hosts' correctness tests in `40501234007`. Its old budget
expectation failed; the corrected runner audit passed. Full production gates
remain required.

[Sort callbacks](../../tests/sort_callback_ownership.rs) compare raw/native output
for repeated/equal keys, live aliases, managed keys and callbacks, empty inputs,
effectful captures, partial failure and task cancellation. They also check zero
remaining managed bytes and deliberately broken result/key cleanup. Existing
record conversion-overflow and record update controls remain in the focused batch.
Full nine-job production, documentation and analysis gates are required before
claiming verified delivery.

The measurement run `40501234007` used source
`a44ed18ee72301fd9363ef934596064b55eb751f`, retained by
`evidence/sort-key-ownership-2026-10-27`. Its budget wrongly expected fewer
successful last-owner queries. Removed checks returned false, so successes must
stay unchanged. Reader repair `2baf3ec0` corrected that expectation, tightened
attempted counts to exact reductions and updated the String/pair attribution.
The passing audit verified unchanged compiler/runtime sources and reused the
original samples. It did not rerun or discard them.

## Measured result and remaining costs

For N input tokens and D distinct words, effective retains fall from
`N + 7D + 10` to `N + 5D + 10`: 512 fewer at N=4,096/D=256, and 8,192 fewer at
N=65,536/D=4,096. Shared String releases fall from `N + 4D` to `N + 3D`; shared
pair releases fall from `3D + 10` to `2D + 10`. The input-list/map/saved-key/output
owners remain. Allocations, requested bytes, peak/final managed bytes and count
metadata match the baseline on both hosts. All 12 other fixtures match their
original operation and memory totals.

| Ordinary word-frequency binary | Baseline | Candidate |
|---|---:|---:|
| AMD64 complete executable | 78,216 bytes | 77,128 bytes |
| AMD64 executable `.text` section | 42,018 bytes | 39,154 bytes |
| AMD64 `main` frame | 128 bytes | 128 bytes |
| ARM64 complete executable | 79,600 bytes | 78,568 bytes |
| ARM64 executable `.text` section | 42,156 bytes | 38,908 bytes |
| ARM64 `main` frame | 160 bytes | 160 bytes |

These GCC frame estimates are per function, not measured peak call-stack use.
The named specialized key still returns a boxed `(I64, String)` record to the
sort runtime. That per-key allocation remains an A4 candidate; this batch does
not claim to eliminate it. Extending the sort's key storage needs a separate
layout/cleanup proof, allocation budget and failure/cancellation controls.
