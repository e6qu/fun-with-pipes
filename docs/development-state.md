# Fold borrowing preparation

Updated 2026-10-17 UTC. This is an independent compiler preparation at
`/private/tmp/fwp-borrow-fold-captures`, branch `borrow-fold-captures`, based on
request/connection candidate `72a3cee01c8f5e69376c7cdfc5c11c5952255356`.
Root `free-server-call-values` owns PR #160 at `1e1773b6`; production
`39025708821` is running and docs `39025708823` passes. Root watcher session
82509 handles only that exact head. No new PR until its acceptance.

## Measured reason and proposed change

Actual AMD64/ARM64 channel-output binaries in PR #160 retain their captured
channel once per send, or 64 times per measured call. The loop's outer callback
owner keeps that channel alive throughout. A direct fold callback can borrow
its captures and source element while consuming its running result.

This preparation lowers known fold/fold-right callback bodies with explicit
borrowed parameters. Ordinary function entries keep their existing convention.
Returning or retaining a borrowed value still acquires an owner at that use.
The ownership verifier tracks the external lifetime separately from locally
acquired copies, and unwind cleanup includes only references actually owned.
Entry preemption protects the owned running result, not borrowed captures.
Recursive callbacks and resource-close scopes keep their existing compilation;
callbacks with no counted borrowed inputs gain no extra body.

New unit checks reject consuming/dropping a borrowed parameter without acquiring
an owner, and verify its external lifetime survives consumption of a local copy.
A native/interpreter comparison uses real heap strings in left/right folds and
counts retains inside each callback. Deliberately adding one retain must fail.
Existing alias, error, cancellation and scratch-cleanup controls cover both entry
forms. No counts, memory or machine-code improvement is verified yet.

Next: format/audit, publish this isolated preparation, run Linux server-repeat
with the ownership unit/fold suites added. Fix failures. Keep the request/connection
baseline `72a3cee0` and its Linux `39025894808` separate; after that probe passes,
run its six-host matrix before comparing compiler changes. Retain counts, live
storage and actual instructions; examine code size and register/stack costs.
Do not execute downloaded binaries. Full builds and tests run on GitHub.
All seven roadmap areas remain open, and JIT is excluded.

## Checks

Root-guarded formatting of the initial compiler changes passed in 1.25s. Worktree
creation passed in 0.43s. Final formatting passed in 1.23s and docs in 2.79s. Native checks remain
pending on GitHub. The request/connection baseline Linux probe now passes; its
unchanged six-host run is `39026702591`.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Server requests/connections and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

## First probe repairs

Linux `39026721148` failed to compile two new assertions because IR expressions
do not implement equality. The tests now match the expected expression shape.
The separate ownership preparation also fixes Windows API declaration order in
the existing client startup fixture; that same repair is included here.
Next: publish and rerun the Linux probe before claiming native results.

The second Linux probe `39027098579` passes all 31 ownership unit tests, the
borrowed-application test and existing left-fold aliases/reclamation. The new
string test failed its interpreter expectation: `flip concat "!"` prepends the
marker, whereas the captured string has it appended. The test now uses
`concat "!"`; this fixes the workload, without changing the expected result.
Next: rerun the focused probe; native zero-retain behavior remains unverified.
