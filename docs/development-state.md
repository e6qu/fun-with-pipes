# Session handoff

Updated 2026-10-17 UTC. The seven work areas in [PLAN.md](../PLAN.md) remain open.
PR #155 is the current delivery; this branch prepares its successor and has no PR.
The root worktree holds the live acceptance status for #155. Do not open a second
PR or merge this preparation without the final production and documentation gates.

## Stream cache ownership candidate

Branch `own-remote-stream-caches`, worktree `/private/tmp/fwp-owned-stream-caches`.
The complete-client baseline passed all six native targets in run `38991578784`
at `456f2dbd381513af855e7e43186190b95b259c19`; its report and interpretation are in
[benchmarks](benchmarks.md#memory-used-by-complete-remote-stream-clients).
All three repetitions show 64 additional charged bytes remaining per consumed
integer after entry cleanup. The report excludes raw networking and process memory.
The immutable tag is `evidence/remote-client-memory-baseline-20261017`.

The candidate counts stream positions, consumes the position passed to a read,
moves an exclusive saved result, and retains a shared result. Typed destruction
releases the position/optional/tuple chain iteratively. The source allocation
moves to the next unread position and releases at the end, without cancelling the
connection. Runtime calls into the iterator use owned argument transfer. Custom
decoder callbacks transfer their byte input and release caught error values.
Connections, streams and retained decoder captures still require ownership work;
remote calls remain excluded from checked ARC.

These changes are unverified. Probe `38993403382` at `3be0c03e` runs
`stream-clients` on Linux AMD64 through
the evidence workflow's explicit `native_runner` choice; that probe does not
establish six-host support. Add last-owner, retained-wrapper, bounded-stack,
partial-failure and deliberate broken-cleanup controls, then run stress and all
six native targets. Preserve the baseline's actual source identity. Compare final
and peak charged storage, requests and retains at all three input sizes before
claiming improvement. Inspect generated C and binary cleanup paths.

The primitive inventory preserves its immutable baseline and explicitly checks
the new consuming `grpc._force` contract. No whole-graph ARC admission is implied.
The force fault fixture now supplies the error descriptor required by its fake
decoder. Local guarded `cargo fmt --all -- --check` passed in 1.03s; no local
compiler build or native execution ran. Full checks stay on GitHub runners.

The next probe also includes explicit cache-owner controls: 64/1,024/16,384
positions, aliases to positions/optional results/tuples, shared and exclusive
consuming reads, exact release counts, no-collection physical reclamation and
small collector/reuse-stress samples. Deliberately recursive cleanup must exceed
a 4 KiB sampled stack-address span; omitting source release must fail its count.
These tests have only been formatted locally (guarded check, 1.16s), not run yet.
The focused workflow checks the frozen primitive inventory and neighboring
force/canonical-decoding fixtures before collecting complete-client measurements.

## Probe results and repair

Linux AMD64 run `38993403382` at `3be0c03e` passed the original complete-client
probe. Unique reads ended at 6,480 charged bytes for all three sizes (64, 1,024,
16,384), versus the baseline's growth to 1,055,296 bytes. Retained iterators kept
their history until release, then returned to the same final charge. The three
repetitions agreed. Allocations still grow by five per integer; counted retains
rose from approximately one to five per integer. This is preliminary memory
lifetime evidence, not a timing or zero-cost claim. Download through the root
guard passed in 2.85s; no downloaded binary ran locally.

The expanded probe `38993688356` at `c203af5a` passed the primitive inventory and
neighboring decoding, shared-reader and receive-failure tests, but its new cache
stress test crashed. Generic record poisoning interpreted raw position/source
words as a record header. The repair uses the existing raw-storage/array release
path for those allocations and adjusts instrumentation to count both release
helpers. This repair is awaiting a rerun. The same batch adds custom decoder
success/error/trap controls; a trap now restores the enclosing error handler,
while an ordinary language error stays inside the decoder's handler until caught.
Negative controls require failure for legacy callback entry, leaked errors and
stale handlers. Guarded formatting passed in 1.14s. No acceptance is inferred
from the earlier non-stress probe.
