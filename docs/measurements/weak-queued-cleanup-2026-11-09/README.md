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
checks in run `42605354450`. It preserves the original ownership operations.
The failing boundary must be identified before attributing it to the compiler.
One source-level concern is keeping the outside owner live until a weak lookup:
Swift supplies [withExtendedLifetime](https://developer.apple.com/documentation/swift/withextendedlifetime(_:_:)-4mmpv)
for explicit lifetime requirements. This is a hypothesis, not an established cause
of the observed trap. No repaired result is claimed yet.
