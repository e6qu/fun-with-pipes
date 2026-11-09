# A weak callback can fail without leaking its acquired owner

[Both native Linux jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42584848642)
at `9a7f1baafe49667bd21fdc9e6070e0252ef8a2dd`, retained by
`roadmap/weak-callback-errors-2026-11-09`. This extends the
[cancellation/expiration checks](../weak-peer-checks-2026-11-09/README.md).
It measures correctness, not execution time, allocations or ARC operations.

The new case follows this sequence:

1. Create target 9 and a weak registration.
2. Acquire a strong owner when entering the callback.
3. Release the outside owner inside the callback. Target 9 must remain usable.
4. Return an error in C, propagate `Result` with `?` in Rust, or throw in Swift.
5. Require target destruction before the dispatcher returns the error to its caller.
6. Try another dispatch through the expired registration. It must not enter.

C releases explicitly. Rust drops its acquired `Rc`; Swift keeps its native
strong reference through `withExtendedLifetime`, including the throwing path.
This tests ordinary callback errors, not Rust panic or Swift fatal-trap handling.

Each host passes six ordinary builds: C/Rust O1/O2 and Swift Onone/O. All print
`calls=2 destroyed=66 expired=1 cancelled=1 error=1`. The 66 destroyed targets are
the original callback target, 64 later targets, and the new failing callback's
target. This is a value-destruction count, not a backing-allocation count.

Eight actual C fault builds must exit 79 with `lifetime check failed`: omit normal
active release, error-path release, expiration, or weak-metadata release, each
at O1/O2. An abort or other unsuccessful status is not accepted. All six ordinary
builds also reject an unexpected CLI argument with status 2.

Both hosts use GCC 13.3.0, Rust 1.99.1 and Swift 6.4.2 on Ubuntu 24.04. The full
logs and 37 raw command records per host were reviewed. Both complete archives
match the digests in [artifact identities](artifacts.json); they retain prepared
sources, binaries and raw records. The separate JSON reports make those records
easy to inspect without unpacking the executables.

Queued cleanup, forced address reuse and callback-service/weak-operation costs
remain in the [comparison scope](../ownership-peers.md#weak-registrations).
