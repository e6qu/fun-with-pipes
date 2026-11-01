# Move derivative weights into the tape

Delivered in [PR #238](../roadmap-history.md#direct-derivative-recording-pr-238).
The protocol below was fixed before implementation. Baseline: PR #237, merge
`94abb83cb33cb52bdcafb19c67c855cf9007059f`, with all production/docs gates passed.
The [tape example](../terminology.md#tape-and-backward-pass) explains recording.

## Selected work

Recording takes two parent IDs and two local derivative weights. Currently they
arrive in a record; typed recording retains both weights and the caller later
releases its copies. For 256 operations that is 512 avoidable retain/release
pairs when the incoming weights can transfer ownership. This is a boundary
count, not a whole-program count: a caller that keeps or shares a weight still
needs a separate owner. Report those limits rather than claiming every retain
in a 256-operation calculation disappears.

Use explicit curried arguments for `ad.push`, `ad.push-owned` and `rev._push`:

```text
parent-a -> weight-a -> parent-b -> weight-b -> new-node
```

For example, recording weight 1 from `node` and no second parent becomes
`ad.push-owned node 1.0f128 -1 0.0f128`. Each application still takes one argument.
The fully applied native primitive receives separate values; it needs no argument
record. Keep conversions for F16/BF16/F32/F64 explicit and in the original order.

| Argument | Native ownership |
|---|---|
| Parent IDs | Immediate integers; no owner |
| F64 weights | Immediate numeric bits; no owner |
| Typed weights | Consume one independently owned value per argument |

Typed recording protects both incoming weights before any validation or growth
that can fail. On success, move both owners into the tape and publish its new
length only after both values/parent IDs are stored. On failure, release both
incoming owners and leave the old tape prefix valid. When both parents are
inactive, release the weights and return the inactive ID. Keep the previous
validation order and messages, including mixed/stale nodes and task identity.

A reused caller value still owns its own reference. Passing the same value twice
requires two incoming owners; the tape later releases both. No identity test may
silently merge those owners. Interpreter values follow their existing Rust-owned
representation and must preserve the same language results and failures.

## Required evidence

- Scalar F64, F128 and nested 256-operation chains: exactly 256 recording calls,
  zero recording argument records with `FWP_STACK=0` and `1`; same raw interpreter
  output. Check GCC/Clang O1/O2 and workspace off/on.
- A typed token/heap ledger: zero retains inside recording; two incoming owners
  transfer to an active tape and are physically released at retirement. Cover
  shared aliases, equal weights, inactive parents, both parents equal and growth.
- Failure before growth, after growth and before publication: release both
  weights, preserve earlier nodes and permit a successful subsequent recording.
  Also cover stale/mixed nodes, wrong task, capacity limits, cancellation and
  nested backward callbacks. Keep cleanup registrations and final storage at
  their starting baseline.
- Deliberately omit one weight's cleanup and add one extra retain; each must be
  detected. Require unique instrumentation sites. Replace the obsolete
  second-retain failure test with failures at the actual transfer boundaries.
- Existing precision, checkpoint, workspace, scope and library tests continue
  passing. Audit the explicit new signatures/contracts against the frozen
  inventory; do not rewrite its baseline.

Retain generated C, native images/hashes, count/charge observations and static
frame reports using the existing typed-derivative suite. Report changes against
the recorded baseline with their scope: allocator charge is not RSS, static
frames are not total runtime stack, and counts establish no execution speedup.
No elapsed-time acceptance limit is introduced here; D2/N1/N2 remain open.

## Integration

Update library code, raw interpreter, native lowering, manual fixtures, public
examples and generated library docs together. No compatibility wrappers. Retire
the old current-source scalar-recording measurement mode, whose reference
depends on the removed record representation. Preserve its immutable reports
and result checker; historical reproduction uses its recorded source.

Run all affected focused targets together after implementation, then one full
final-head production matrix plus documentation. Fix every encountered issue;
merge only after all nine production jobs and docs pass. Local checks use the
unchanged resource guard; full builds and suites run on GitHub.

## Additional regression check

[Saved observations](derivative-recording-moves-rejected-2026-11-01.json.gz)
from `ea354e13` show that zero recording records can coexist with
more allocations elsewhere: nested arithmetic callbacks raised cumulative charge
from 43,056 to 100,576 bytes with stack promotion. That candidate is rejected.
The source repair preserves complete-operation arithmetic workers. In addition
to the frozen count/ownership requirements, enforce these #237 whole-fixture
ceilings on every host, optimization level and workspace setting:

| Weight type | Stack promotion | Cumulative charged bytes | Peak charged bytes |
|---|---|---:|---:|
| F128 | Off | 30,608 | 11,056 |
| F128 | On | 18,320 | 11,056 |
| Rev[F64] | Off | 96,384 | 31,680 |
| Rev[F64] | On | 43,056 | 31,664 |

These counters cover the complete 256-operation fixture, including setup and
backward arithmetic. They measure fwp-managed charge, not process RSS or speed.

## Focused results

[Run 41307125882](https://github.com/e6qu/fun-with-pipes/actions/runs/41307125882)
passes at `4c4b2ed5cbb08e3e63906e8e39ec27f0cc4aaebf`. Linux ARM64 uses GCC 13.3,
Linux AMD64 uses GCC 15.2, and macOS ARM64 uses Clang 23.1.4. Each passes all
34 native tests in nine targets, two ownership unit tests, lint and the frozen
primitive inventory. Documentation run `41307132107` also passes.

[Retained measurements](derivative-recording-moves-2026-11-01.json.gz) contain
compiler identities, outputs, source/image hashes and static-frame reports.
The artifact audit checks native architecture and hashes for 102 image/source
pairs, all 84 typed outcomes and 72 transfer-control outcomes across three hosts.

- F64, F128 and nested chains: 256 recording calls, zero heap argument records
  with stack storage off/on. Interpreter and native answers agree.
- Typed recording: zero weight retains inside the primitive. Alias owners survive;
  failure before/after growth and before publication releases incoming owners.
  Missing cleanup and extra-retain controls fail with 237 and 243 respectively.
- The earlier adjoint/result ownership checks still pass, including deliberately
  broken extra-owner and borrowed-zero-drop cases. Final fixture charge is zero.

Both optimization levels and workspace settings agree on the complete-fixture
charges below. The baseline is #237's matching fixture; both calculate the same
256-edge identity derivative and check that the caller's input remains unchanged.

| Weight type | Cumulative bytes: baseline stack off / on → current either | Peak bytes: baseline off / on → current either |
|---|---:|---:|
| F128 | 30,608 / 18,320 → 18,320 | 11,056 / 11,056 → 11,056 |
| Rev[F64] | 96,384 / 43,056 → 43,056 | 31,680 / 31,664 → 31,664 |

The stack switch also changes other eligible records. Only the dedicated record
counter isolates the 256 recording arguments. Current allocation totals match
the baseline with stack promotion enabled; this is not a claim of lower total
allocation in that setting. The rejected helper rewrite and its larger totals
remain recorded above.

Instrumented executable sizes are identical with stack storage off/on:

| Host | F128 O1 / O2 bytes | Nested O1 / O2 bytes |
|---|---:|---:|
| Linux ARM64 | 156,272 / 155,880 | 79,568 / 79,248 |
| Linux AMD64 | 130,288 / 146,448 | 73,904 / 77,760 |
| macOS ARM64 | 148,160 / 164,528 | 89,344 / 89,232 |

The largest reported static frame stays 704 bytes on Linux ARM64 and 720 on
macOS ARM64. AMD64 F128 stays 688/720 at O1/O2; nested O1 stays 688, while nested
O2 rises from a 720-byte maximum to 768. In that image, the generated `f3` frame
changes from 672 to 768 bytes. These are per-function compiler reports, not
whole-program stack bounds. [Baseline image/frame costs](typed-derivative-owners.md#focused-results)
remain available. No execution times were measured; D2/N1/N2 remain open.

The focused result establishes the stated count, memory and cleanup requirements.
All nine final-head production jobs and documentation subsequently passed;
[history](../roadmap-history.md#direct-derivative-recording-pr-238) records the
verified source and squash merge.
