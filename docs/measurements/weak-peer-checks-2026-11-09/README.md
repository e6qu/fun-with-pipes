# Native weak-registration checks

[Both Linux jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42578072461)
at `5dfd82825fce7c7d6caa5040913e64ec7c708635`, retained by tag
`roadmap/weak-peer-checks-2026-11-09`. ARM64 job `129030203232` and AMD64 job
`129030203336` use GCC 13.3, Rust 1.99.1 and Swift 6.4.2. C/Rust run at O1/O2;
Swift runs at Onone/O. These are correctness checks, not timing or ARC counts.

## What happens

Each program follows the same serial sequence:

1. Create target 7 and a weak registration. A cancelled call never enters.
2. Enable the registration and acquire a strong owner for the callback.
3. Cancel further calls and release the outside owner inside that callback.
4. Reject a nested cancelled call, but allow a nested weak acquisition: the
   active callback still owns the target.
5. Return from the callback. The last strong owner disappears and the target's
   destructor runs. Later lookup fails, even if cancellation is cleared.
6. Create and destroy 64 more targets. The expired registration stays expired.

All three programs report `calls=1 destroyed=65 expired=1 cancelled=1`.
That means one callback ran; the original and 64 later targets were destroyed.
It does not mean the allocator reused an address. Actual reuse and queued-resource
failure/cancellation coverage remain in fwp's [existing tests](../../weak-channels.md#verification-and-boundaries).

Six ordinary builds per host return the expected output and reject extra CLI
arguments. Six C failure-control builds omit active-owner release, target
expiration or metadata release at each optimization level. Every omission returns
the expected lifetime-check failure (79); a crash is not accepted instead.

## What differs

- C uses separate target and weak-metadata allocations, with explicit serial
  retain/release. It checks target destruction and final metadata release.
- Rust uses ordinary `Rc<Target>`/`Weak<Target>`. The value's destructor runs
  before the last weak reference disappears; that is not backing-storage release.
- Swift uses a native weak field. `withExtendedLifetime` keeps the acquired
  owner through the complete callback, including nested lookup.

The counters observe callback entry and target destruction. They do not intercept
native allocations or ARC operations. These fixtures do not implement fwp's queue,
channel close, arbitrary OS-thread synchronization or application error handling.
Those differences must remain explicit in the [planned comparison](../ownership-peers.md#weak-registrations).

## Retained evidence

The ARM/AMD reports, command records and full job logs are beside this page.
All expected statuses and output were reviewed. Archives remain remote:

| Host | Artifact | Bytes | GitHub SHA-256 |
|---|---:|---:|---|
| ARM64 | 13655789211 | 16,091,107 | `06e0a04a92a09d898749c253eab3c3f2ce3117bbcc14b9d3ed4512d99cc13df9` |
| AMD64 | 13656435529 | 19,248,457 | `d4aa8f301022100454bbb0fe41c17b1e0763acdcb319f37e5cbb0feff72ef23e` |

Only selected small entries were downloaded, with ZIP CRC checks. No local
whole-archive hash check is claimed. The archives also retain generated sources,
ordinary and deliberately broken executables, plus the independent buffer/parser
checks from the same jobs.
