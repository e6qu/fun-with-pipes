# Weak operations: verified behavior and native storage

Linux ARM64 and AMD64 pass the operation, queued-cleanup, storage and actual
address-reuse checks below. **Weak-operation timings and callback-service costs
remain unmeasured.** These results do not count ARC instructions.

## What passed

| Experiment | Frozen source | Run / AMD64 job / ARM64 job | Per-host result |
|---|---|---|---|
| Six phases and minimal Swift cancellation repair | `8848e837c6e2d708060459c563788a0bba25352d` | `42631166444` / `129207545716` / `129207545782` | 36 phase builds, 252 native checks, 2 interpreter checks; 22 peer checks; 8 Swift diagnostic cases |
| Native storage | `2470f2a944df025accf8afd19ce61e069279e639` | `42635657945` / `129223014018` / `129223014753` | 3 binaries, 24 ordinary results, 48 profiles and raw-stack reconstruction |
| Actual target-address reuse | `63accd10536196f60b39c693da16a80b4e367b95` | `42639145010` / `129235261160` / `129235261107` | 12 builds, 18 checks, 6 ordinary observations |

[Phase protocol](../weak-operation-phases.md) ·
[Storage/reuse protocol](../weak-operation-storage.md) ·
[Original Swift failure and source comparisons](../weak-queued-cleanup-2026-11-09/README.md).

The cancellation-only Swift repair passes with the original filename and
assertions, at optimized settings with and without debug information. The
original and lookup-only variants still trap; those are expected diagnostic
results, not lifetime passes. No Swift compiler defect is established.

## Measured native storage

Both populations (64 and 4,096), repetitions and architectures agree. These are
**requested bytes per target**, derived from retained factory allocations;
allocator rounding, caller slot arrays and RSS are excluded.

| Implementation | Target allocation | Separate weak allocation | Storage after last strong release | After last weak release |
|---|---:|---:|---:|---:|
| C counted target | 16 B | 16 B | 16 B weak metadata | 0 B |
| Rust `Rc<Target>` / `Weak<Target>` | 24 B, including counters | None | 24 B backing allocation | 0 B |
| Swift class / native weak reference | 24 B | 32 B | 32 B weak metadata | 0 B |

For example, 64 Swift targets retain 1,536 target bytes and 2,048 weak-storage
bytes before releasing the strong owners. After that release, the 1,536 target
bytes disappear while the 2,048 weak bytes remain. Releasing the weak references
removes those too. Rust destroys the target value earlier but retains its shared
allocation until the final weak reference goes away. No factory-attributed type
metadata was observed in this experiment; whole-process costs remain in reports.

These are ordinary native peer representations, not fwp channel payload bytes.
Stack-attributed bytes at the process heap peak are retained separately; they are
not independent peaks for each factory or allocator-internal transient peaks.

## Reuse and evidence

At both tested optimization levels, C and Swift each reused the released target
address in all 1,024 rounds. The old weak reference stayed expired. Rust observed
zero reuse while the old `Weak` retained the original allocation, as required.
Replacing the old link with a real link to the new target fails all six fault
builds on each host. No freed object is dereferenced.

Original artifacts: phase AMD `13685148043`, ARM `13686030886`; storage AMD
`13685608029`, ARM `13684854190`; reuse AMD `13687052117`, ARM `13686123281`.
Selected report members were read with ZIP CRC checks; full large archives were
not downloaded locally. The storage runner reconstructs attribution from every
raw stack and verifies fixture, native image, command and manifest identities.
[File hashes](files.json) cover retained reports and complete job logs.

Docs pass at source `8848e837c` (run `42631171172`, job `129207557246`) and
`2470f2a94` (run `42635673348`, job `129223066100`). Full-log review found only
optional manual-page notices and libtool's install-time relinking notices in
setup. Documentation logs include deliberate failed/hung runner controls; their
parent tests pass. There are no unexpected compiler or program failures in these
batches. These focused results do not replace final production gates.
