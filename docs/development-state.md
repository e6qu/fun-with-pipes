# Session handoff

## Next action

Next: publish `deliver-channel-receive-fields` as a draft PR, finish the receive
result-layout comparison and focused ownership checks below, then run all nine
production jobs and documentation on its final head. Fix every failure. One active
PR at a time; squash merge only after final-head acceptance, with an explicit
one-line subject of at most 80 characters and empty body.

The user merged [PR #176](https://github.com/e6qu/fun-with-pipes/pull/176) as
`90f0ab9f6b30da75682f598ef5afd8f9fef7bfed` before production CI completed.
That is this delivery's base. Its tree equals `ddff413a`; its commit message is
one line without trailers. Keep original production `39371117507` running and
fix any failures in the next delivery. Its benchmark gate and documentation
`39371117707` pass. Only duplicate post-merge runs `39372193646`/`39372193575`
were cancelled after tree verification. [History](roadmap-history.md#loop-state-and-known-function-calls-pr-176)
records the completed focused checks and measured loop/direct-call improvements.

## Current changes

Eligible receives now keep the result's tag and message in local fields instead
of allocating `Some message`. Whole-value callers keep boxed results. Both forms
transfer the same queued owner and share the runtime receive loop; an explicit
result-form argument selects the representation. The current candidate returns
a two-word C struct so the target ABI can select registers or caller storage.
There is no new syntax, fallback or ownership contract.

Boxed results are allocated before dequeue so failure leaves the message available
for retry. Review found the uncounted tracing path dequeued first; this delivery
repairs it with a forced-failure/retry test. Tests also cover zero-valued messages,
timeouts, blocked cancellation, close, received function calls and failure cleanup.
The existing native/WASI fixture carries the new language cases.

## Checks and measurements

| Revision | Checks | Current outcome |
|---|---|---|
| `78dc983e`, output-pointer result | Counts `39371671562` | Both Linux hosts pass; all 180 samples and 20 ordinary binaries audited |
| `78dc983e` | Ownership `39371669060` | Both Linux and both WASI hosts pass; macOS/Windows running/queued |
| `a44d52a1`, two-word result | Counts `39372647179` | Pending |
| `a44d52a1` | Ownership `39372650018` | Pending |

The delivery has the same compiler/runtime/test changes as `a44d52a1`; its later
edits update the plan and accepted-work records. The preparation branch is
`unbox-channel-receives` in `/private/tmp/fwp-channel-receives`; it is not a second
PR. Do not repeat its work as a new task.

[The receive report](measurements/channel-receive-results.md) compares the first
candidate against PR #176's measured implementation `75da96b8`. Fresh-text
allocations fall from two to one per additional message; shared text falls from
one to zero. Other cases and all retain counts are unchanged. All ARC samples end
with zero charged storage. These are operation counts, not timings or C/Rust
comparisons. Actual code sections shrink for text cases, but the receive helper's
frame grows by 16 bytes on both architectures; that motivates the struct-return
experiment. Its results are not yet known. Keep both measurements and compare
actual binaries before selecting the final form.

A saved diagnostic interpreter rejected the new callback pipe with an effect
mismatch. The original expression remains in the tests, and both Linux runner
checks pass: the accepted inference repair already handles it. No wrapper or
inference workaround was added. Superseded runs `39371506883`/`39371509365` were
cancelled before any job executed; they supply no evidence.

## Local checks and resources

Use `python3 scripts/local-guard.py COMMAND...` for serial bounded checks.
No local compiler or generated-native build was run. Heavy work belongs on
runners. Disk is near the 64 GiB floor; keep target data below 2 GiB and sampled
aggregate workload RSS below 1 GiB. Do not raise the guard's limits.

Guarded `cargo fmt --all` passes after the struct change (1.76s).
`python3 scripts/check-roadmap.py` passes after tracking the report (2.89s).
The primitive inventory against its frozen baseline passes (1.33s); contracts
are unchanged. `scripts/summarize-channel-costs.py` audits the first candidate
against run/source/artifacts (1.54s); ELF section comparison passes (0.14s).
Artifacts are `/private/tmp/fwp-channel-receive-costs`, baseline artifacts
`/private/tmp/fwp-channel-alias-costs`, and the audited count report
`/private/tmp/fwp-channel-receive-counts.json`. Revision tag
`roadmap/revision-channel-receive-78dc983e` preserves the first measurement.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion still need proofs. Default native execution retains tracing;
zero additional shared-text allocations do not eliminate setup storage or ARC.
Function-message costs remain. JIT is excluded. Follow [AGENTS.md](../AGENTS.md).
