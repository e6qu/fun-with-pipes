# Timing weak references separately from callbacks

**Protocol prepared; no timing results yet.** The [phase checks](weak-operation-phases.md)
and [storage/reuse checks](weak-operation-verification-2026-11-09/README.md) pass
on native ARM64/AMD64. This experiment times those same separately compiled
operations. Queue handling and callback-service work remain separate measurements.

## Compared work

Create targets and weak references, perform live lookups, release every strong
owner, perform expired lookups, then release every weak owner. Each successful
lookup temporarily acquires and releases a strong owner. Count live and expired
results separately; none of the expired lookups may succeed.

| Targets alive together | Lookups per target, both before and after expiration | Purpose |
|---:|---:|---|
| 1 | 1 | A small complete lifetime; startup/clock costs may dominate |
| 64 | 16 | Repeated lookup on a small working set |
| 4,096 | 1 | Creation and teardown across many targets |
| 4,096 | 64 | Repeated lookup across many targets |

C uses a counted target and separate weak metadata; Rust uses `Rc`/`Weak`; Swift
uses a native class and weak field. fwp uses a real empty capacity-one channel
and its weak channel reference. **fwp's target also carries channel state.** No
messages are sent. Its generated owning entry receives a retained argument;
native peers borrow theirs. Those representation and entry costs are included.
This is not a claim about hypothetical generic weak boxes in fwp.

The six phase clocks include loops and calls across separately compiled modules.
Caller slot arrays and fwp scheduler initialization occur outside those phase
clocks but remain in complete-process time. No estimated overhead is subtracted.

## Frozen collection rules

- Native Linux ARM64/AMD64; explicit target flags; GCC/Rust O2 and Swift O;
  separate modules without LTO. Record compiler versions, CPU and native images.
- Verify all phase results, wrong-lookup/backward-clock/omitted-release controls
  at this source before timing. Freeze source under `roadmap/weak-operation-time-*`.
- Run a **C-only pilot** for each row: try 16, 64, 256, then 1,024 batches. Select
  the first whose six phases total at least 50 ms, or retain the 1,024 cap if none
  qualifies. Use that same work count for all peers and both sessions.
- Complete every pilot before any peer warmup. Run two sessions on the same host.
  Each case has two warmup rounds followed by 16 measured rounds. Each round
  contains each language and an identical executable copy. The eight-process
  order balances positions and preceding implementations over eight rounds.
- A phase comparison qualifies only if both implementations' two copy medians
  are at least 5 ms and each identical-copy ratio is at most 1.02. Keep short or
  noisy phases inconclusive, even when the complete process qualifies. Do not
  retry unchanged observations to qualify them.
- Report `fwp median / peer median` per phase and process. For example, 1.20 means
  fwp took 20% longer; 0.80 means it took 20% less time for this work. Require both
  sessions to qualify before describing a repeated advantage.
- Record three separate ordinary peak-RSS processes per peer/case/session. RSS
  includes runtime, libraries and input slots; it is not the live-target byte
  count from the allocation experiment. A zero counter is unresolved, not zero
  memory. Retain compilation time/RSS, image sizes, sections and unwind tables;
  the latter do not establish maximum dynamic stack use.

[The collector](../../scripts/measure-weak-operations.py) retains commands, partial
output on timeout, every independent failure and a file manifest. Its audit
reconstructs pilots, output counts, order, medians, qualification and RSS from raw
records. It verifies fixture source, original/copied image hashes and architecture.
[Six corruption controls](../../scripts/check-weak-timing-audit.py) must reject
changed pilots, order, hashes, durations, qualification or RSS even after updating
the manifest. No ARC-operation count is inferred from elapsed time.

Run `suite=weak-operation-time` with an explicit `weak_time_tag` in the numerical
workflow. Four ordinary binaries produce 1,024 measured processes, 128 warmups
and 96 RSS observations per host, plus the retained pilot trials. This advances
the [ownership comparison](ownership-peers.md#weak-registrations); it does not
complete the callback-service or parser allocator-internal measurement gaps.
