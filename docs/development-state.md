# Session handoff

Updated 2026-10-17 UTC. All seven project work areas remain open.

## Delivery sequence

Root input delivery [PR #159](https://github.com/e6qu/fun-with-pipes/pull/159)
is at `91398527`, production `39016595534` and docs `39016595480`. Documentation
and benchmarks pass; platform gates run. Root's exact-head watcher owns the
authorized merge. Keep one delivery PR at a time.

Server storage preparation is `/private/tmp/fwp-server-call-owners`, branch
`own-server-call-storage`. Stack-slot candidate `c298bdcd` runs Linux probe
`39017473996`; prior heap-slot candidate `d5adce34` runs `39017350539`.
Its own handoff owns all-six-platform measurements and binary inspection.
Transfer only the preparation delta, preserving root's accepted allocation-test
repairs and current delivery history. No server PR exists yet.

## Typed server values preparation

This worktree `/private/tmp/fwp-server-value-owners`, branch `own-server-values`,
starts at `c298bdcd`. It is isolated preparation, not verified support.

Generated service wrappers currently mark arguments/results as traced. The
compiler marks methods reachable but does not request their typed owning entries.
Generate those entries and use them to transfer decoded parameters into methods.
Protect partially decoded arguments, returned values and errors through failure,
cancellation, child joins and response encoding. Advance output iterators with
the existing owned-cursor rules, preserving lookahead and encoding order.

The cursor's destruction function should be explicit type metadata, usable for
both client inputs and server outputs without another runtime allocation. A
unique iterator node moves its continuation; shared aliases preserve it. Keep
non-owning scheduler back-pointers separate from storage ownership.

Server connection/request storage and channel sink contexts remain separate
lifetime work. Do not claim checked ARC or complete GC removal from this change.
Measure the same four server programs and record remaining memory/count costs.
Add meaningful failure/alias controls and compare interpreter/native behavior.

Uncommitted implementation now requests typed service entries/result destructors,
transfers decoded arguments into owning application, protects partial arguments
and results/errors, and advances responses with an owned cursor. The cursor was
factored into two value words plus explicit destruction metadata; sender records
keep their previous size. This has not compiled or run on CI yet.

Response-encoding fixture patterns and mock method metadata are adapted;
sender measurement hooks follow the factored cursor. The unused unowned iterator
helper is removed. The server workflow also runs client input/request fixtures.
Windows task-probe CRLF repair is copied from storage preparation `e6455c0d`;
preserve it once when transferring deltas. Storage's repaired all-six run is
`39018276989` at `e6455c0d`, tag `evidence/server-call-storage-windows-20261017`.

Next: publish this implementation for a Linux semantic/lifetime/measurement probe.
Fix compile/test failures, then add explicit served-value cleanup negative controls
covering partial decode, returned aliases, continuation failures and cancellation.
Existing client cursor controls remain required. Measurements/actual binaries and
all-six/full-production acceptance are outstanding. Do not copy this unverified
preparation into a delivery or treat a passing first probe as completion.

## Checks

Compiler metadata formatting passed in 1.27s; runtime/adapted-test formatting
passed in 1.31s. Documentation audit passed in 3.36s. No native check yet. Full compilation/tests/measurements run on
GitHub. Local checks use the root `scripts/local-guard.py` with fixed limits;
never execute downloaded programs locally. JIT is excluded.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
