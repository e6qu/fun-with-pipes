# Successful weak lookups allocate a temporary result cell

Linux ARM64 and AMD64 agree at GCC O1/O2: each successful `channel.upgrade`
allocates one 16-byte managed `Some` cell. The measured caller immediately drops
that result. Expired lookups allocate nothing. Final managed live storage is zero
in all eight cases per host.

| Phase | Allocation events | Managed slot bytes |
|---|---:|---:|
| Create N empty capacity-one channels | N | 96 × N |
| Create N weak references | N | 16 × N |
| Look up each live target L times | N × L | 16 × N × L, all result cells |
| Release strong owners | 0 | 0 |
| Look up expired targets | 0 | 0 |
| Release weak references | 0 | 0 |

For N=4,096 and L=64, the live-lookup phase makes 262,144 temporary allocations,
charging 4 MiB in total. It holds only one 16-byte result cell at a time, above
the 458,752 bytes of channel/weak storage. Total allocation traffic is not peak
memory. After strong release, 65,536 weak-metadata bytes remain until weak release.

The observer measures [managed allocation operations and slot charges](../weak-operation-census.md),
not native allocator backing, RSS, ARC counts or ordinary elapsed time. Separate
factory and caller modules keep the lookup API boundary visible. This is a
concrete temporary-allocation cost, not proof that it dominates a complete service.

## Verification

Source `54b818abc8ee3cce26a260681797c2cb2c01068f`, immutable tag
`roadmap/weak-operation-census-2026-11-09`:

| Native job | Artifact | Result |
|---|---|---|
| [ARM64 129278955989](https://github.com/e6qu/fun-with-pipes/actions/runs/42651550496/job/129278955989) | `13692126364` | Eight observations and eight controls pass |
| [AMD64 129278956168](https://github.com/e6qu/fun-with-pipes/actions/runs/42651550496/job/129278956168) | `13691796954` | Eight observations and eight controls pass |

Each ordinary case first checks real 17/33-byte allocations, their 32/48-byte
charges and final release. Real extra-allocation and omitted-free variants fail
with status 79; invalid arguments fail with status 2. The runner reconstructs
source transformations, ELF architecture/hashes, commands and every result.
Downloaded observations also match their complete raw command records.

[Documentation 42651562531](https://github.com/e6qu/fun-with-pipes/actions/runs/42651562531)
passes. Complete native logs contain only the package installer's optional missing
g++ manual-page notice. The docs log includes deliberate failed/hung test-runner
controls whose parent checks pass. [files.json](files.json) hashes the retained
reports, command journals and complete logs, both compressed and decompressed.
