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

## Byte decoding and Windows peer checks

The same batch now prepares six more contracts: gzip/deflate decoding, CRC32,
WebSocket frame parsing, close-payload parsing and message inflation. Typed result
fields own copied leaves and wrappers; frame parsing no longer allocates an unused
empty payload on success. Existing synchronous compression encoders protect native
output buffers across managed result allocation. Injected failures cover every
managed allocation, with separate missing-field and missing-native-buffer cleanup
controls. Native buffer allocations that terminate the process on failure retain
that existing policy; this is not a claim of recoverable native-allocator OOM.
These native-only helpers remain unavailable on WASI; no emulated support claim.

Focused `e912227b` passes both actual WASI jobs `38879832821`; its six-native
run `38879829259` exposed missing OpenSSL/curl prerequisites in the newly added
Windows web/std-library checks. Ternary and text ownership tests themselves pass
on both Windows architectures. The workflow now installs the pinned native peer
dependencies with HTTP/2 curl support. Web tests use that configured client,
an independent fixed gzip fixture, portable null devices and console shutdown events on
Windows. Interpreter shutdown registers the corresponding Windows console handler,
matching native behavior. Full Windows CI includes these web/std-library checks.
Revision `8f848fde` now has six-native `38881941135` and two-WASI `38881944210`
queued/running. The portable gzip fixture now contains independently generated Python gzip bytes,
verified against `zipped body` (guarded 0.14 s); formatting passes (1.33 s).
This test-only follow-up still needs the next final-head gate. Fresh runner checks
must validate both added byte ownership and
this repair. The [intermediate evidence](measurements/value-decoders-2026-10-16.json)
retains all six ternary/text artifact sets and exact counts (guarded 0.13 s),
including the neighboring Windows gate failures.

Local byte fixture interpretation passes (0.25 s), formatting passes (1.12 s),
and inventory passes (1.25 s): 293 contracted declarations, 50 distinct remaining
review symbols. One new explicit macOS target raises the schedule to 224.
All four Linux/macOS jobs and both WASI jobs pass at `8f848fde`. Windows AMD64
job `116910514622` now has working OpenSSL/HTTP2 curl, but native byte/web/std
checks fail linking `clock_gettime64`: WebSocket mask seeding still called the
POSIX clock directly. It now reuses the existing platform-aware `fwp_unix_ns`.
The independent gzip fixture at `c849cd54` is included in the next validation.
Clock repair `72321a55` is published. Fresh six-native `38884840137` and
two-WASI `38884843627` are queued/running. Both Windows dependency caches were
saved; superseded `38881941135` is confirmed canceled. Fix every failure before
delivery acceptance. PR #152 documentation passes; production is still running.

## Current progress

Direct owned ternary construction and URL/form/HTTP decoding are implemented.
The latter uses existing typed decoder cleanup for partial fields and scratch;
HTTP builds its owned header list without line/value scratch arrays. Header order,
first-line checks and malformed-input messages remain unchanged. The fixture
retains originals beside parsed values and exercises malformed early/late fields.
Native failure controls inject every managed allocation until successful completion;
missing partial-field/list cleanup must fail the charged-storage check. Counts
cover fast initialized objects and nonduplicated slow paths. HTTP counts must
match output storage with no scratch arrays; packing/converting 40 trits needs
only its result request. These are assertions awaiting native results, not
reported measurements. Runner artifacts retain counts, generated C, binaries
and disassembly; allocation evidence is not a timing or C/Rust parity claim.

Both fixtures are included in actual WASI checks. Accepted-interpreter checks
pass under the guard: ternary 0.26 s and text 0.25 s. The text fixture initially
used the runtime symbol `int.parse-hex`; it now uses the declared library name
`http.parse-hex`. Formatting passes (1.30 s), and inventory passes (1.07 s): 287
contracted declarations and 56 distinct symbols still under review. Its frozen
baseline is unchanged. These are preparation checks, not native acceptance.

Explicit macOS assignments add `ternary_ownership` to regular and
`text_decoder_ownership` to GC; previous targets do not move. The `decoders`
focused workflow covers all six native hosts, with full Windows inclusion and
actual WASI fixtures. Local generated-library documentation passes (1.20 s) and the explicit target
assignment tests pass (0.25 s). The first docs audit caught a missing required
roadmap-status section in this preparation handoff; that section is restored.
At `27334bdb`, Linux ARM64 job `116899769089` in `38878658827` passed text
decoder semantics, injected failures and exact request counts, but the ternary
fixture leaked its packed output: `fwp_rc_drop` only decrements shared counts.
The fixture now performs last-owner destruction for leaf storage and checks
its initial budget after freeing inputs too. The same input-cleanup correction
applies to the text fixture; runtime implementations are unchanged. Keep the
missing-free negative controls. Next: publish the correction and run fresh six-native and two-WASI gates;
these preparation results do not establish delivery acceptance.

Focused local commands use the fixed guard:

| Command after `python3 scripts/local-guard.py` | Result |
|---|---|
| `cargo fmt --all` | Pass, 1.09 s for final allocation checks |
| `python3 scripts/test-macos-test-shards.py` | Pass, 0.25 s |
| `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-decoder-inventory/candidate.json` | Pass, 1.07 s; baseline unchanged |
| `python3 scripts/check-roadmap.py` | Pass, 2.73 s after restoring the status section |

The standalone `tests/stdlib_doc.rs` generator was compiled/executed serially
under the same guard with `FWP_BLESS=1` (1.20 s); its source comments are the input.

## Next preparation: process metrics and syntax rendering

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
failure cleanup before promoting either family to checked ARC support. These
are planned implementation checks, not claims of passing support.

Clock repair `72321a55` removes the link failure. Both Windows jobs in
`38884840137` now pass owned decoder tests but fail native cleartext HTTP/2
web peers: the HTTP/2 server checks only Unix EAGAIN/EWOULDBLOCK/EINTR. It
therefore treats Winsock would-block as a closed connection. Both receive and
final-send loops now use the existing `fwp_socket_again` predicate, matching
the shared gRPC transport. Fresh Windows peers must pass before acceptance.
