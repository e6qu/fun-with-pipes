# Service storage is released in C, Rust and Swift

Both Linux architectures pass 16 diagnostic builds and 80 allocation profiles.
The service's returned sender/receiver statistics agree across success,
cancellation, expiration and handled errors. Ordinary service allocations are
fully released; real omitted-release controls retain the expected bytes.

## Ordinary service storage

These are native allocator requests attributed to the separately compiled service.
The byte column is its live storage **at the whole-process heap peak**, not an
independent maximum. Two samples and both architectures agree on these values.

| Implementation | Messages | Requests | Service bytes at process peak | Unreleased service bytes |
|---|---:|---:|---:|---:|
| C | 64 | 68 | 9,776 | 0 |
| Rust | 64 | 67 | 11,824 | 0 |
| Swift | 64 | 68 | 11,896 | 0 |
| C | 4,096 | 4,100 | 622,640 | 0 |
| Rust | 4,096 | 4,099 | 753,712 | 0 |
| Swift | 4,096 | 4,100 | 753,784 | 0 |

The Swift handled-error case adds one service request and 32 bytes at the process
peak; those bytes are released. Its separately attributed type metadata retains
552/560 bytes on AMD64/ARM64, or 568/576 with the handled error. These caches are
not message payloads. The complete reports also retain process totals, caller
formatting/runtime allocations and all fault cases; zero service bytes does not
mean zero bytes retained by the entire runtime at exit.

C deliberately omitted payload release retains `128 × messages` bytes; omitted
weak-registration release retains 16 bytes. Numeric results still match, so only
checking output would miss those failures. The ordinary profiler controls also
verify three known allocations and a real omitted free before observing services.
[Protocol](../weak-callback-service.md#native-allocation-observation).

These are not ARC operation counts, fwp managed-slot charges or RSS. fwp's
[separate physical-ownership check](../weak-callback-service-2026-11-09/README.md)
verifies cleanup; the later four-language [service timings](../weak-callback-time-2026-11-09/README.md)
report the complete elapsed-time comparison.

## Verification and audit repair

Source `c0ac432fc2b802d71d472085ea4fa6b0100b624f`, tag
`roadmap/weak-service-profiles-2026-11-09`:

| Native job | Artifact | Result |
|---|---|---|
| [AMD64 129325013027](https://github.com/e6qu/fun-with-pipes/actions/runs/42664664795/job/129325013027) | `13696740792` | All 16 diagnostic builds and 80 profiles pass |
| [ARM64 129325013096](https://github.com/e6qu/fun-with-pipes/actions/runs/42664664795/job/129325013096) | `13695853774` | All 16 diagnostic builds and 80 profiles pass |

The collector reconstructs all stacks, sources, ELF architecture/hashes, outputs
and ordinary/fault counts before passing. Both use GCC 13.3, Rust 1.99.1 and Swift
6.4.2. [Docs](https://github.com/e6qu/fun-with-pipes/actions/runs/42664675441) pass.
Complete native logs contain the package installer's optional g++ manual-page
notice and libtool's normal install-time relinking notice.

The later [complete-journal audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42666652513)
failed because its stricter diagnostic rule rejected heaptrack's normal stderr
statistics. Both archives had already reconstructed. The repair parses the exact
three-counter status block, checks allocation totals against retained stacks and
still rejects added warnings or unexpected text. Four reader tests and all 164
real status blocks pass locally. Repair source `f3f023820` passes
[run 42669442687 / job 129341760168](https://github.com/e6qu/fun-with-pipes/actions/runs/42669442687/job/129341760168),
artifact `13697573842`: both archives reconstruct, all 954 command records are
audited, and all 164 profiler status blocks match their raw allocation totals.
[Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42669449481)
also passes. No native profile was rerun.

[files.json](files.json) preserves the original reports, complete native/docs logs
and failed audit. Raw journals exceed the local download limit: the repaired audit
processed them on GitHub and retained the compact journals and complete stack/text
archives here. Their compressed hashes match the runner report; local limits were
not increased.
