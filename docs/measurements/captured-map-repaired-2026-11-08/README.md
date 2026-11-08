# Captured scalar maps after empty-owner transfer

**The largest workloads take 84–94% less computation time, with 199 fewer array
allocations per 199 updates. No qualified case regresses.** Combined timing
acceptance remains open: of 48 cases per session, identical-copy controls are
inconclusive in 7 and 7 on ARM, and 32 and 37 on AMD. Preserve those outcomes.

The candidate passes saved scalar arguments directly to a consuming map, reuses
exclusive arrays, and transfers empty ordinary arrays unchanged. The reference
is the same compiler with only captured-map selection disabled. This is a
comparison between two fwp implementations, **not parity with Swift/C/Rust**.
The [protocol](../captured-array-maps.md#measurement-contract-before-collecting-results)
fixes inputs, hosts, GCC O2 flags, two warmups, 24 rotated rounds and 2% limits.

## Computation time

Sensor calibration applies `value * 1.0 + 0.25`; pixel adjustment applies
`value * 1u8 + 1u8`. Initial values repeat 0 through 16. After 199 updates,
sensors start 49.75, 50.75, 51.75 and pixels start 199, 200, 201. Each process
checks all outputs and retained inputs outside the computation timer.

Change is `(candidate / reference - 1) × 100`; negative means less time.
`*` means the identical-copy control is **inconclusive**. Inputs are exclusive
except the two explicitly shared rows. Both ARM sessions use Neoverse-N2;
AMD1 uses EPYC 9V74 and AMD2 EPYC 9V45. Do not pool CPU models or sessions.

| Program / elements / updates | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| Sensor / 0 / 1, shared | -7.03% | -8.46% | -3.30%* | -15.89%* |
| Pixels / 0 / 1, shared | -7.21% | -6.17%* | -7.94%* | -4.60%* |
| Sensor / 65,537 / 1 | -85.02% | -84.76% | -90.76%* | -93.78%* |
| Sensor / 65,537 / 199 | -83.64% | -83.66% | -93.81%* | -90.76%* |
| Sensor / 262,145 / 1 | -84.85% | -84.70% | -93.54% | -93.61% |
| Sensor / 262,145 / 199 | -83.66% | -83.61% | -94.19% | -93.22% |
| Pixels / 65,537 / 1 | -85.18% | -85.17%* | -92.60%* | -93.05%* |
| Pixels / 65,537 / 199 | -84.69%* | -85.16% | -92.04% | -90.62% |
| Pixels / 262,145 / 1 | -85.26%* | -84.79% | -91.66%* | -87.65%* |
| Pixels / 262,145 / 199 | -84.73% | -84.72% | -92.56% | -91.44% |

Both largest 199-update applications exceed the 10% target in every session.
No shared-empty case has a qualified regression in these sessions; noisy
controls still prevent declaring every guard case accepted. No unchanged
completed session was rerun for a better result. Construction, final release and
whole-process timings are retained separately. Whole-process time includes the
checker and is not an application speed claim.

## Memory and remaining work

Session 1 observes memory after all ordinary timings. Both architectures report
identical managed counts for all 48 cases. Below: one exclusive 262,145-element,
199-update invocation, including construction and release, **reference → candidate**.

| Measure | Sensor | Pixels |
|---|---:|---:|
| Allocation requests | 600 → 401 | 600 → 401 |
| Requested bytes | 419,441,600 → 2,105,168 | 52,438,600 → 270,153 |
| Peak managed live bytes | 4,194,368 → 2,097,232 | 524,338 → 262,217 |
| Retains | 200 → 200 | 200 → 200 |
| Final managed live bytes | 0 → 0 | 0 → 0 |
| ARM process RSS, KiB | 7,872 → 3,840 | 2,680 → 2,048 |
| AMD process RSS, KiB | 8,484 → 4,452 | 3,164 → 2,656 |

The removed allocations are output arrays. The remaining 401 requests are not
free: generated C creates one input array, 200 loop-state records (initial state
plus 199 updates), and 200 `Again`/`Stop` boxes. `fwp_loop_payload` retains each
step's payload before dropping its box, accounting for 200 retains. This source
inspection agrees with the observed totals; no per-site instrumented attribution
was collected. Array reuse is neither heap-free nor ARC-free execution.

Managed storage excludes allocator metadata and native libraries; RSS measures
the whole process separately. Every case returns to its starting managed storage.

## Compiler, code and stack costs

Single observations for the largest sensor case, **reference → candidate**:

| Cost | ARM1 | AMD1 |
|---|---:|---:|
| fwp C emission, ms | 311.9 → 313.1 | 275.2 → 276.1 |
| GCC compilation, ms | 1,930.8 → 1,919.3 | 1,702.2 → 1,697.4 |
| fwp peak RSS, KiB | 41,408 → 41,732 | 42,932 → 42,788 |
| GCC peak RSS, KiB | 99,096 → 98,696 | 109,424 → 109,408 |
| Executable bytes | 148,696 → 148,408 | 126,808 → 126,560 |
| Measured entry's static stack bytes | 240 → 240 | 240 → 240 |

Driver frames are 272 bytes in both variants: static on ARM, bounded dynamic on
AMD. Retained `.su` files give per-function estimates, not whole-call-stack use.
Compiler observations do not establish a statistically qualified speed comparison
or general scaling. Separate ownership-analysis checks bound growing map/capture
inputs; the [contract](../captured-array-maps.md) states exactly what they count.

## Sources and complete evidence

[Run 42479872910](https://github.com/e6qu/fun-with-pipes/actions/runs/42479872910),
source `c8611f5e67c773a1d380255eb0c49088424325b8`, passes all four sessions and
reconstruction audits. Source tag: `evidence/captured-maps-repaired-20261108`.
[Expanded native safety checks](../captured-map-empty-checks-2026-11-08/README.md)
and docs run `42479874918`, job `128729292696`, pass. Final production delivery
is tracked in [the handoff](../../development-state.md).

| Session / job | Complete report | Raw observations | Full artifact ID |
|---|---|---|---|
| ARM1 / 128729874165 | [Report](arm-1.json.gz) | [Archive](arm-1-observations.zip), [log](arm-1.log.gz) | 13618180835 |
| ARM2 / 128729874189 | [Report](arm-2.json.gz) | [Archive](arm-2-observations.zip), [log](arm-2.log.gz) | 13617278569 |
| AMD1 / 128729874176 | [Report](amd-1.json.gz) | [Archive](amd-1-observations.zip), [log](amd-1.log.gz) | 13617836258 |
| AMD2 / 128729874145 | [Report](amd-2.json.gz) | [Archive](amd-2-observations.zip), [log](amd-2.log.gz) | 13616334748 |

Reports retain host/toolchain identities, file hashes, verified artifact digests,
runner audits and derived results. Compact archives preserve every raw sample,
command/status, source program, patch, resource observation and stack report.
Generated C and native images were audited on each runner and remain identified
by hash for reproduction with the recorded source and settings.

[Initial measurements](../captured-map-initial-2026-11-08/README.md) and the
[failed driver run](../captured-map-driver-repair-2026-11-08/README.md) stay unchanged.
Both variants now use correct reference drops in the driver; final-release and
whole-process changes across those versions include that driver repair.
