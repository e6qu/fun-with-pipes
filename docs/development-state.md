# Session handoff

Updated 2026-10-16. This worktree prepares the following ownership batch, not a
second delivery PR. [PLAN.md](../PLAN.md) retains the seven project work areas.

## Delivery chain

PR #151 is accepted as `3dff03b644c4922845f7c4b9f3a9673dece5ef16`, with
identical tested tree and verified one-line message. All nine production jobs
`38872161681` and docs `38872161673` passed at `27cdc7ff`; duplicate postmerge
production `38884089916` is confirmed canceled.

PR #152 is now the sole active delivery. Final numerical head is
`ed936381240c57d4af45d526ac16b744405c0ca6`, with production `38884588161` and
docs `38884587999` queued/running. The draft-only skipped run is not acceptance.
Its main-workspace handoff is authoritative for the numerical batch. Focused
six-native, two-WASI, four-host costs and paired timing passed; do not change
that PR head for unrelated decoder preparation. Merge only after all final gates.

This worktree `/private/tmp/fwp-owned-decoders`, branch `owned-value-decoders`,
is based on `3577ba37`. Only its later delta belongs to the following batch.
Do not replay or separately publish the numerical preparation chain.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver numerical batch, then owned value decoders |
| 3 | In progress | Measure remaining C/Rust gaps and inspect generated code |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | In progress | Measure lane kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable, repeated measurements and storage costs |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Next ownership batch and acceptance

Remove remaining collector-dependent scratch from value decoders. Begin with
balanced ternary: trits are digits -1, 0 and +1; lists and packed bytes must have
explicit owners, including partial-list cleanup. Traverse input lists directly,
write packed bytes directly, and construct owned result lists without scratch
arrays. Preserve digit order, width checks, negative counts and end-of-input.
Then review URL/form and HTTP-head decoders: protect temporary native buffers and
partially decoded fields on parse and allocation failures. Their current success
and error paths still create unowned composite results and abandoned scratch.
This is distinct from asynchronous socket/server ownership, which remains open.

Before claiming support, require raw/optimized interpreter and native parity,
tracing stress/reuse verification, checked ARC zero final storage, injected
partial-construction failures and negative controls. Exercise pure decoders on
actual WASI where supported. Record allocations and generated code for the
removed scratch; no speedup claim without comparable repeated measurements.
Add explicit macOS assignments for new test targets without reshuffling old ones.
Full builds, suites and evidence run on GitHub. Local checks use the unchanged
fixed `python3 scripts/local-guard.py` limits. No compiler build is permitted as a
retry of the earlier guard refusal. Keep one delivery PR, exact-head acceptance
and one-line <=80-character commits with empty bodies and no attribution.

## Decoder implementation and validation

Eight ternary and eight URL/form/HTTP contracts own results and protect partial
construction. They traverse lists and HTTP lines directly, avoiding pointer/index
scratch arrays. Six compressed-byte contracts cover gzip/deflate, CRC32 and
WebSocket parsing/inflation; encoders protect native output across managed result
allocation. Native compression allocation failures retain their process-exit
policy; managed-allocation injection does not claim recoverable native OOM.
Those compressed-byte helpers remain unavailable on WASI.

The retained [ternary/text evidence](measurements/value-decoders-2026-10-16.json)
at `e912227b` includes all six target artifacts and exact allocation counts.
It records that whole Windows jobs failed neighboring web prerequisites, despite
passing decoder tests. Both WASI jobs `38879832821` passed. Packing/converting 40
trits needs one result allocation. Text decoder cases need 3/7/13/12/6 requests;
after disposal, charged storage returns to its initial value. These are storage
measurements, not timing or C/Rust parity claims.

`8f848fde` passes all four Linux/macOS jobs and both WASI jobs `38881944210`.
It adds compressed-byte tests and installs cached pinned native OpenSSL and HTTP/2
curl prerequisites for Windows peers. Windows revealed two existing runtime bugs:

- `clock_gettime64` failed to link. `72321a55` uses existing `fwp_unix_ns` instead.
- After linking, native cleartext HTTP/2 closed sockets on Winsock would-block.
  `30399066` uses existing `fwp_socket_again` in both server transport loops.

At `72321a55`, both Windows jobs `38884840137` pass owned decoder tests but fail
four native HTTP/2 peers. All four Linux/macOS jobs pass, and both actual WASI jobs `38884843627` pass.
Fresh six-native `38886033175` validates the second repair. Preserve coverage:
full Windows acceptance now includes web/std-library peers with HTTP/2 curl.
An independent fixed Python gzip input, portable null device and targeted console
shutdown replace Unix-only fixture assumptions. Interpreter Windows shutdown
handles console events consistently with native execution. No tests are removed.

Earlier injected ternary checks caught a fixture incorrectly using `fwp_rc_drop`
for final-owner destruction; `e912227b` fixes input/output disposal and checks the
initial budget. Missing-field/list/native-buffer cleanup controls remain required.
Superseded incomplete preparation runs are not acceptance; `38881941135` is
confirmed canceled after both Windows dependency caches were saved.

## Local checks

All use the fixed `python3 scripts/local-guard.py` limits. Full compiler builds,
full suites and evidence generation remain on GitHub.

| Command after the guard | Latest result |
|---|---|
| Accepted compiler `run --interp tests/fixtures/metrics_ownership.fwp` | Pass, 0.25 s |
| `cargo fmt --all` | Pass, 1.08 s |
| Standalone `tests/stdlib_doc.rs` generator with `FWP_BLESS=1` | Pass, 0.74 s |
| `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-metrics-inventory/candidate.json` | Pass, 1.08 s; 298 contracted declarations, 45 distinct review symbols; frozen baseline unchanged |
| `python3 scripts/test-macos-test-shards.py` | Pass, 0.13 s; 225 explicit targets, old assignments unchanged |
| `python3 scripts/check-roadmap.py` | Pass, 2.57 s |

## Process metrics and syntax rendering

Review the remaining metric contracts in the same owned-value batch. A snapshot
is an immutable list of name/kind/value tuples; build only that result, with
partial-result cleanup instead of a temporary pointer array. Metric names must
preserve embedded NUL bytes and sort identically to interpreter strings. Native
registry storage intentionally lives for the process or library instance, grows
with distinct names, and must be released at library teardown; repeated updates
of the same names must not grow it. This is separate from managed snapshot
storage. Avoid the temporary concatenated name used for observation suffixes.

Acceptance requires interpreter/native parity for ordering, aliases, embedded
NUL, negative updates, kind changes and repeated snapshots; ARC and tracing
stress/reuse checks; every managed construction failure and a missing-cleanup
control; zero snapshot storage after disposal; actual WASI where available.
Also review `syntax.show`: protect its native text buffer across result
allocation, without changing its printed syntax. Test semantic parity and
failure cleanup before promoting either family to checked ARC support. Implementation and fault fixtures are prepared. The accepted-interpreter fixture
passes, including immutable earlier snapshots and complete embedded-NUL names.
Native tests require 12 managed allocations for three snapshot tuples and one
for a rendered syntax string, with zero charged storage and native scratch after
disposal; deliberate missing-field/buffer cleanup must fail. Actual WASI includes
the semantic fixture. Existing library-unload checks validate registry teardown.
These new checks still need fresh runner results before any support claim.

Next: finish local documentation checks, publish the combined metrics/syntax
preparation, and run fresh six-native plus actual WASI gates. Fix all failures.
Monitor #152 separately; merge it only after all nine final-head production jobs
and docs pass, then move only the delta after `3577ba37` into the next delivery.

## CPU kernel ownership preparation

This isolated branch starts at decoder preparation `21a621c6`; only later commits
belong to CPU kernel work. Decoder native `38886468434` and actual WASI
`38886471769` are validating separately. Combine only verified deltas into the
next substantial delivery; do not replace a tested PR head for preparation.

Review `device.run` and `device.sum`, the CPU executors for tensor expressions.
The elementwise executor currently allocates a full native output buffer, then
copies it into a language array. Let workers write result bytes directly into
one owned output array. Protect input-pointer tables, output and reduction
scratch until workers finish, including a thread-creation failure. The POSIX
path must report that failure after joining started workers, matching Windows,
instead of silently executing missing workers on the caller. Preserve the
existing thread-count bounds and explicit WASI single-thread behavior.

Validate malformed instructions, input lengths and size checks in their current
order, including counts too large for WASI. Keep elementwise arithmetic and
4096-element reduction order identical. Require interpreter/native bitwise
parity, aliases/views, empty and chunk/block boundary sizes, tracing stress,
checked ARC, real WASI and injected allocation/thread failures with cleanup
controls. Retain allocation and generated-code evidence; do not claim faster
execution without repeated comparable timings. GPU runtime compilation is
unchanged by this CPU work and remains an unresolved no-JIT policy gap.

Kernel implementation and tests are now prepared. Accepted-interpreter fixture
passes under the guard (0.26 s); formatting passes (1.07 s); inventory passes
(0.96 s) with 300 contracted declarations and 43 remaining review symbols.
No native result is claimed yet. Automatic approval review rejected the proposed
local C probe compilation under the standing resource rules; no probe executed
and it will run on GitHub, without a local retry. Existing standalone size-probe
controls are preserved with unwind-aware cleanup. New actual WASI controls omit
each count check and must expose 32-bit truncation.

Windows HTTP/2 repair `30399066` now passes both Windows hosts, Linux hosts and
ARM macOS in `38886033175`; Intel macOS is still running. Metrics/syntax-only
`21a621c6` gates `38886468434`/`38886471769` are still queued and can be superseded
by the combined decoder, metrics and CPU-kernel preparation to avoid duplicate
runner work. New `cpu_kernel_ownership` has an explicit macOS assignment (226
targets total); full Windows includes its semantics/failure checks and the native
size-validation-order test. Existing Unix sanitizer checks remain intact.

Next: publish this combined preparation from `owned-cpu-kernels`, run six-native
`decoders` plus actual `wasi-arc`, and fix every failure. Keep #152's current head
unchanged until its nine production gates pass; combine this branch only after
that PR merges, preserving the numerical delivery tree.
