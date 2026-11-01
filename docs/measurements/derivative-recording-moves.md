# Move derivative weights into the tape

Preparation protocol, fixed before implementation. Baseline: PR #237, merge
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

Artifact review of `ea354e13` found that zero recording records can coexist with
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
