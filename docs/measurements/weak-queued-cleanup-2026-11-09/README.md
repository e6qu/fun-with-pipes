# Queued weak callback cleanup

This extends [callback-error checks](../weak-callback-errors-2026-11-09/README.md)
with two queued messages. Each owns a payload and holds a weak target reference.
Cancelling the first must destroy its payload; after dropping the target owner,
draining the second must discard it without calling the expired target. In the
other path, the first callback drops the outside owner and returns an error:
the acquired target survives the call, then it and both payloads are destroyed.

## First run

[42603913802](https://github.com/e6qu/fun-with-pipes/actions/runs/42603913802),
source `c9bf8dfac`, tag `roadmap/weak-queued-cleanup-2026-11-09`:

| Native host | Passing builds | Failure |
|---|---|---|
| AMD64, job `129114853978` | C O1/O2, Rust O1/O2, Swift Onone; 16 actual C lifetime faults | Swift `-O` traps with no assertion text |
| ARM64, job `129114853988` | Same | Swift `-O` traps with no assertion text |

All independent groups run despite a failure. The C controls omit active/error/
queued-owner release, expiration, weak metadata release, payload destruction or
cleanup of unprocessed entries. Each produces its required lifetime diagnostic.
These are source-level lifetime checks, not allocation or timing comparisons.
C/Swift payloads are heap objects; Rust's payload has an inline destructor.

Full first reports, commands, logs and [artifact identities](first-artifacts.json)
are retained here. Selected archive members have ZIP CRC verification; whole ZIP
hashes were not independently computed locally. Docs repair `42603916827` passes;
its complete log is retained. Expected failing-child controls are not CI failures.

## Located failure and minimal repair

[Run 42610103348](https://github.com/e6qu/fun-with-pipes/actions/runs/42610103348),
source `2c1d74410`, preserves the original `precondition` calls. Both architectures
locate the trap at original line 146, immediately after clearing the owner:

```swift
owner = nil
precondition(counts.destroyed == 1)
```

The intended destruction was not observed at that checkpoint. The preceding
check (one payload disposed, target still alive) completed. The comparison
changes the cancellation boundary and weak lookup independently:

| Original assertions retained | AMD64 ordinary / debug | ARM64 ordinary / debug |
|---|---|---|
| Original code | Trap / trap | Trap / trap |
| Extend the owner through cancellation | Pass / pass | Pass / pass |
| Extend the owner only through weak lookup | Same trap / same trap | Same trap / same trap |
| Both lifetime changes | Pass / pass | Pass / pass |

Keep the cancellation-only repair:

```swift
withExtendedLifetime(owner) {
    queue[0] = nil
    precondition(counts.disposed == 1 && counts.destroyed == 0)
}
owner = nil
precondition(counts.destroyed == 1)
```

This makes the intended lifetime explicit before clearing the owner. It leaves
all original assertions and callback cleanup intact. The prepared fixture's
SHA-256 is `508fc9fb44f283ce008eba4ff5922439e7e254971e9685a7365787829491ef81`,
identical to the cancellation-only source that passes both optimized settings on
both hosts. The additional weak-lookup extensions and diagnostic assertion
wrapper are removed. These source-level comparisons isolate a sufficient repair;
they do not establish a lower-level Swift compiler defect.

[Original-check artifact identities](original-checks-artifacts.json), source
hashes, complete commands and source backtraces are retained. The first diagnosis
uses different Swift filenames per variant. The follow-up preserves the original
`swift-ordinary.swift` basename in separate directories and repeats the actual
C/Rust/Swift peer checks together with the source comparison. No final-head result
is claimed before that batch finishes.

## Earlier diagnostic checks

Source `24f7a033e`, run `42605354450`, replaces anonymous Swift assertions with
line-numbered checks and passes all 22 builds on both hosts. Changing the observer
also changed the behavior, so this was not accepted as the repair.
[Its artifacts](diagnostic-artifacts.json), commands, reports and logs remain.

Source `e9cf68009`, run `42607637111`, adds cancellation and weak-lookup lifetime
extensions to that diagnostic version. All 22 builds pass per host. The isolated
comparison above establishes that the lookup changes are unnecessary.
[Candidate artifacts](candidate-artifacts.json), commands, reports and logs remain.
The only setup warning in these runs concerns an optional C++ manual page.

Source anchors: `roadmap/weak-queued-diagnostics-2026-11-09`,
`roadmap/weak-queued-lifetimes-2026-11-09` and
`roadmap/weak-queued-original-2026-11-09`. The
[diagnostic collector](../../../scripts/diagnose-swift-weak-lifetimes.py) uses
[Swift source backtraces](https://github.com/swiftlang/swift/blob/main/docs/Backtracing.rst),
with the [explicit lifetime API](https://developer.apple.com/documentation/swift/withextendedlifetime(_:_:)-4mmpv).

The final minimal fixture and original-filename diagnosis now pass in the
[combined native batch](../weak-operation-verification-2026-11-09/README.md).
Original and lookup-only traps remain expected diagnostic observations.
