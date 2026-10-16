# Session handoff

Updated 2026-10-16. This worktree prepares the following ownership batch, not a
second delivery PR. [PLAN.md](../PLAN.md) retains the seven project work areas.

## Delivery chain

PR #151 remains the only open delivery: final `27cdc7ff`, production
`38872161681`, docs `38872161673` passes. Require all nine production jobs before
squash merge. Its repaired macOS assignment preserves every target and limit.
The main workspace `owned-numerics-delivery` is prepared through `3577ba37`:
borrowed hash fields, direct range arrays, vector ownership, direct F64 storage,
proved lane pipeline fusion and direct ordered dot. Combined native `38874211385`,
WASI `38874214456` and four-host costs `38874218523` pass. The main branch now
also prepares scalar splat reduction at `b1a34ea0`, with fresh focused gates. Preserve
its full handoff when transferring or merging that batch.

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
portable gzip fixture construction/null devices and console shutdown events on
Windows. Interpreter shutdown registers the corresponding Windows console handler,
matching native behavior. Full Windows CI includes these web/std-library checks.
Fresh runner checks must validate both the added byte ownership and this repair.

Local byte fixture interpretation passes (0.25 s), formatting passes (1.12 s),
and inventory passes (1.25 s): 293 contracted declarations, 50 distinct remaining
review symbols. One new explicit macOS target raises the schedule to 224.
Next: finish local documentation/shard checks, publish, then run fresh six-native
and two-WASI gates. Retain failures and fix them before delivery acceptance.

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
