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

## Diagnosis in progress

Source `24f7a033e` replaces anonymous Swift assertions with explicit line-numbered
checks. [Run 42605354450](https://github.com/e6qu/fun-with-pipes/actions/runs/42605354450)
passes all 22 native/fault builds on each host. It changes no explicit ownership
operations, but it changes the observed behavior. **This is not proof that the
original failure is repaired.** Reports, commands, complete logs and
[archive identities](diagnostic-artifacts.json) are retained. The only setup
warning concerns an optional C++ manual page.

One source-level concern is keeping the outside owner live until weak lookup.
Swift supplies [withExtendedLifetime](https://developer.apple.com/documentation/swift/withextendedlifetime(_:_:)-4mmpv)
for explicit lifetime requirements. Candidate `e9cf68009`, run `42607637111`,
extends the outside owner through lookup and the cancellation checkpoint, ending
that extension before callback entry. The callback still relies on its acquired
owner after clearing the outside reference. This candidate is not yet verified.

The [Swift-only diagnosis](../../../scripts/diagnose-swift-weak-lifetimes.py),
source `2c1d74410`, run `42610103348`, retains the original `precondition` calls.
It compares the original code, cancellation-only lifetime extension, lookup-only
extension and both together. Each uses ordinary optimized settings, then the
same settings with debug information. Failing processes get a noninteractive
[source backtrace](https://github.com/swiftlang/swift/blob/main/docs/Backtracing.rst).
Original source, binaries, exact exits and traces are retained. A successful
collection records observations; it does not turn an original trap into a passing
lifetime check. No root cause is claimed before reviewing these observations.
