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

These changes are unverified. First run `stream-clients` on Linux AMD64 through
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
