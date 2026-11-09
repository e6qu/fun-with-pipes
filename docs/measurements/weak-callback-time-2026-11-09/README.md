# Callback service timing: verification and repairs

**No timing samples yet.** The [frozen protocol](../weak-callback-time.md)
measures complete queued-service calls in fwp, C, Rust and Swift. Native caller
verification must pass before the C-only pilot or any peer measurement starts.

## First native checks

Source `0fa6d394b285e973e717d71889a5026a71100fd3`, tag
`roadmap/weak-callback-time-2026-11-09`, [run 42672736829](https://github.com/e6qu/fun-with-pipes/actions/runs/42672736829), attempt 2:

| Host | Job / artifact | Completed builds / result checks | Failures |
|---|---|---|---|
| AMD64 | `129350479470` / `13700060870` | 18 / 108 | Both generated fwp descriptors rejected |
| ARM64 | `129350479632` / `13698787984` | 14 / 74 | Same descriptors; four ordinary/missing-delivery Rust links |

All completed C/Swift checks pass. AMD64 Rust checks pass; ARM64's two
backward-clock Rust builds pass. Both fwp interpreter modes pass on each host.
The logs retain 48 AMD64 and 32 ARM64 invalid-argument checks. No other native
failure was found in the complete command journals.

Two harness defects explain the failures:

- The descriptor reader expected a shortened record declaration. Actual emitted
  declarations include field order and ownership functions. The reader now
  requires that real shape, including trivially owned `I64` fields; it still
  derives offsets from the field-name table and rejects incompatible types.
- Rust's raw clock-object link argument appeared after system libraries. On
  ARM64 the clock's stack-protection reference then lacked its required library.
  Linking the clock through Rust's native static-library mechanism fixes library
  ordering. Stack protection remains enabled; the clock code is unchanged.

The repaired reader accepts both retained generated sources. Focused local Rust
caller checks pass with the static clock archive. These do not replace the pending
native GCC checks. [Docs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42672743140),
attempt 2, job `129350483940`.

Attempt 1 of both workflows ended before creating jobs with GitHub internal
server errors. Retrying the exact source discarded no measurements. Complete
native logs include only the optional g++ manual-page notice outside the failures
above. [File identities](files.json) cover the compressed reports, command journals,
actual generated sources and complete logs. The [handoff](../../development-state.md)
owns current run status and remaining work.
