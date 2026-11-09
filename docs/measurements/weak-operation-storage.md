# Weak references: target and backing storage

**Verified on Linux ARM64 and AMD64.** [Results and source identities](weak-operation-verification-2026-11-09/README.md). This fills the native C/Rust/Swift storage gap in
the [ownership comparison](ownership-peers.md#weak-registrations). It uses the
same separately compiled operations as the [six-phase caller](weak-operation-phases.md).
These are diagnostic processes; their elapsed time is not a performance result.

## What each process does

Create either 64 or 4,096 targets. End a fresh process at each of four boundaries:

| Stage | Work completed | Deliberately retained owners |
|---|---|---|
| 0 | Create targets | Strong target owners |
| 1 | Create weak references; successfully look up every target | Strong and weak owners |
| 2 | Release every strong owner; verify every weak lookup fails | Weak owners only |
| 3 | Release the weak owners too | None |

For 64 targets, stage 1 prints `live:64, expired:0`. Stage 2 also prints
`live:64, expired:0`: its 64 earlier live lookups succeeded, and **zero later
lookups succeeded after expiration**. These are separate counts, not a checksum
in which opposite errors could cancel. The complete JSON also identifies the
population and stage.

The native allocation profiler records allocations and requested bytes still
allocated at process exit. For example, if each target requested 24 bytes, 64
deliberately retained targets would account for 1,536 bytes. That is an example,
not a measured layout. Every process frees the caller's slot arrays. Stages 0–2
deliberately omit destruction of the owners stored in those slots; stage 3
performs all releases. No replacement target allocation or extra Rust `Box` is
introduced.

Expected lifetime distinctions:

- **C:** the target and weak metadata occupy separate allocations. Stage 2 must
  release the target allocation while retaining its weak metadata.
- **Rust:** `Rc<Target>` stores its counters and target in one allocation. Stage
  2 destroys the value, but `Weak<Target>` keeps this allocation until stage 3.
- **Swift:** native class storage and weak-reference side storage are attributed
  separately. Stage 2 must release the class storage; stage 3 must release the
  weak storage. One-time type metadata is reported separately from both.

Allocation stacks identify the actual factory/downgrade paths. Missing target
attribution fails the observation. Unrecognized Swift factory paths also fail;
they must be examined rather than labelled zero allocation or lumped into
temporary object storage. The existing lifetime checks establish destruction
and expiration behavior; this experiment adds native backing-storage evidence.

## Collection and controls

[The collector](../../scripts/profile-weak-operations.py) uses native Linux
ARM64/AMD64, GCC/Rust O2 and Swift O, with debug information for attribution.
Factories and callers compile separately without LTO. Record explicit target
flags, compiler versions, CPU, source revision and native ELF hashes. Use
`suite=weak-operation-profiles` in the numerical workflow.
The source is frozen as `roadmap/weak-operation-storage-2026-11-09`
(`2470f2a94`) before collection. [Native run](https://github.com/e6qu/fun-with-pipes/actions/runs/42635657945)
and [documentation controls](https://github.com/e6qu/fun-with-pipes/actions/runs/42635673348)
pass; raw-stack reconstruction and release controls pass on both hosts.

- Three binaries, eight ordinary result checks per binary.
- Two independent profiles of each population/stage: **48 profiles per host**.
- The existing allocator control must observe three real allocations and the
  known retained bytes after an actual omitted free.
- Verify the selected unwinder before trusting stack attribution.
- Require the same target allocation count at every stage, positive retained
  storage at the deliberate omissions, and the representation-specific release
  transitions above. Keep every failed build/profile while checking other groups.
- Reconstruct summaries from raw allocation stacks; verify source fixtures,
  command results, native image hashes and every retained file's digest.
- Reader tests reject missing/doubled events, falsely reported release, incorrect
  live/expired results, duplicate fields and boolean counters.

Keep whole-process allocation totals and every raw stack. Bytes attributed to a
factory at the **whole-process heap peak** are not that factory's independent
maximum. This does not measure allocator-internal transient peaks, RSS, reserved
addresses, ARC instruction counts, callback-service time or fwp managed bytes.
The [parser memory experiment](parser-process-memory.md) and weak-operation timing
work retain their separate acceptance requirements.

## Actual address reuse

[The reuse checker](../../scripts/check-weak-operation-reuse.py) prepares a
separate correctness experiment, using the same native operation modules. Each
ordinary binary repeats this sequence 1,024 times:

1. Create a target, save its address as an integer, and create its weak reference.
2. Verify a live lookup; release the strong owner; verify expiration.
3. Create a replacement target. Compare its address with the saved integer.
4. Require the old weak reference to remain expired and the replacement's weak
   reference to work. Release the replacement and both weak references.

C/Swift must observe at least one actual reused target address. A result with no
reuse fails this evidence requirement; repeating allocations alone is insufficient.
Rust must observe **zero** reused addresses while the old `Weak` retains the
original `Rc` allocation. Its backing storage has not yet been freed. The test
does not pretend these representations have the same reuse boundary.

No released object is inspected: only the saved integer address is compared.
An actual fault build checks a newly created weak link to the replacement in
place of the expired link. It must return the specific reuse-check diagnostic,
demonstrating that the observer rejects a link which refers to the new target.

`suite=weak-operation-reuse` builds ordinary/fault callers at C/Rust O1/O2 and
Swift Onone/O: **12 builds and 18 result/fault/argument checks per host**. Reports
retain exact reuse counts, source/binary identities and every failure. Three
local reader tests and both native jobs pass. The existing
[fwp runtime control](../../tests/fixtures/weak_channel_lifetimes.c) already
requires actual channel-address reuse; this addition fills the native peer gap.
Source `63accd105` is frozen as `roadmap/weak-operation-reuse-2026-11-09`;
[the native run](https://github.com/e6qu/fun-with-pipes/actions/runs/42639145010)
passes on both architectures; C/Swift observe 1,024 reused addresses per build,
while Rust observes zero while the old backing allocation remains alive.
