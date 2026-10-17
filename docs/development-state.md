# Session handoff

Updated 2026-10-17 UTC. This is independent preparation on
`move-unique-closure-captures` in `/private/tmp/fwp-closure-capture-moves`.
PR #155 remains the only delivery; the root worktree tracks its final gates.
The preceding cache-ownership preparation is `own-remote-stream-caches` at
`886dad3b`, with all-six-host run `38994414068` in progress. Its handoff and
baseline report remain authoritative for that component.

## Move captures from consumed unique closures

A closure stores values for a later function call. Current dynamic application
duplicates those values, then releases the closure, even when no other owner can
use it. Move them when the closure has one owner; preserve typed duplication for
shared or uncounted closures. This applies both when adding arguments to a partial
application and when supplying enough arguments to enter its function. Clear the
consumed closure's capture count only after copying those values into the result
or callee argument slots. No allocation, suspension or trapping operation may
separate that transfer from its new ownership responsibility.

The current stream client has about five retains per consumed integer. A capture
move should remove the continuation's redundant retain without changing its
five allocation requests or its bounded final managed storage. Measure rather
than assume that effect. Other wrapper-field retains remain separate work.

Acceptance: unique/shared closures, partial and complete calls, overapplication,
scalar words resembling pointers, preserved aliases, error/trap cleanup and
collector/reuse stress; raw interpreter/native agreement; exact counts and
deliberately restored duplication/incorrect transfer controls; all six native
measurements and final production gates. Existing argument-preparation tests
already keep shared closures when injecting retain failures. No JIT, new syntax,
new closure fields or new fallback path is needed.

The candidate clears an exclusively consumed closure's capture count after
copying those captures to its destination. Shared closures still retain by type.
New controls measure effective captured-string retains before callee entry,
exercise partial and full applications with shared/unique closures, preserve
scalar words resembling pointers, and check success, language errors and traps.
Restored unconditional duplication and stealing shared captures must fail.
Physical reclamation and collector/reuse stress are both required. A diagnostic
assertion in the neighboring test now normalizes Windows line endings.

Next: run the single-host probe, fix failures, then validate broadly. The
implementation is unverified. Guarded formatting passed in 1.17s. Keep local checks under the root guard; native builds and execution stay
on GitHub runners. Bundle with the next delivery only after independent evidence.

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

Probe `38994754283` at `3a1ef122` found two test assumptions: the new C fixture
expected prefix concatenation order even though `concat` is data-last, and the
existing missing-function-release control expected a rounded freed-byte gap
that included the formerly duplicated captures. The string expectation now
matches the language body (`tailsecondfirst`). The existing control now requires
exact zero retained managed bytes after 10,000 failed calls and detects retained
closure storage independently of capture movement. All other selected ownership
and unwind tests passed in that run. The revised controls still need a rerun.
The cache component's six-host run `38994414068` has passed independently.
