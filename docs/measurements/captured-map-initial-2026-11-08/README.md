# Captured scalar maps: initial results

**Large computations improve substantially, but the full acceptance rule is not
met.** Three qualified shared-empty-input comparisons regress beyond 2%, and many
copy controls are inconclusive. These results precede the empty-owner transfer
repair. Keep them unchanged when measuring that repair.

The candidate passes scalar captures directly to a consuming map and reuses an
exclusive array. The reference is the same compiler with only captured-map
selection disabled. This compares two fwp implementations, not fwp with C/Rust.
The [frozen protocol](../captured-array-maps.md#measurement-contract-before-collecting-results)
defines all 48 cases, strict GCC O2 flags, two warmups and 24 rotated rounds.
All four jobs and their complete reconstruction audits pass.

## Computation time

Sensor calibration repeatedly computes `value * 1.0 + 0.25`; pixel adjustment
computes `value * 1u8 + 1u8`. Initial elements repeat 0 through 16. After 199
updates, the first sensor values are 49.75, 50.75, 51.75; pixels start 199, 200, 201.
Every output and retained input is checked outside the computation timer.

Percent change is `(candidate / reference - 1) × 100`; negative means less time.
`*` marks an **inconclusive** identical-copy control. Rows are exclusive inputs
except the two explicitly shared empty cases. Each architecture's sessions remain
separate; AMD1 uses EPYC 9V74 and AMD2 uses EPYC 9V45. Both ARM sessions use N2.

| Program / elements / updates | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| Sensor / 0 / 1, shared | +1.50% | +3.77% | +9.46%* | +7.15%* |
| Pixels / 0 / 1, shared | +0.98% | +4.45% | +2.44% | -1.16%* |
| Sensor / 65,537 / 1 | -84.16%* | -84.17% | -92.35%* | -92.81%* |
| Sensor / 65,537 / 199 | -83.28% | -83.20% | -93.56% | -92.50%* |
| Sensor / 262,145 / 1 | -84.39% | -84.27% | -93.78% | -92.87%* |
| Sensor / 262,145 / 199 | -83.13% | -83.16% | -94.23% | -92.96% |
| Pixels / 65,537 / 1 | -85.28%* | -84.86% | -89.41%* | -91.88%* |
| Pixels / 65,537 / 199 | -84.68% | -84.68%* | -92.24% | -90.38%* |
| Pixels / 262,145 / 1 | -85.22%* | -85.20%* | -92.25%* | -88.65%* |
| Pixels / 262,145 / 199 | -84.94% | -84.70%* | -92.55% | -91.29% |

For an absolute example, AMD2's largest 199-update sensor case takes 23.66 ms
instead of 335.98 ms. Failed computation-copy controls number 9/6 on ARM1/2 and
33/38 on AMD1/2. No unchanged timing was rerun to obtain a pass. The reports below
retain all cases, both copy ratios and separate construction/release/process data.
Process timing includes result validation and is not an application speed claim.

## Memory and remaining ownership work

Session 1 observes memory after all ordinary timings. Counts match between
architectures for all 48 cases. The table covers one 262,145-element, 199-update
exclusive-input invocation, including input construction and final release.

| Measure | Sensor reference → candidate | Pixels reference → candidate |
|---|---:|---:|
| Allocation requests | 600 → 401 | 600 → 401 |
| Requested bytes | 419,441,600 → 2,105,168 | 52,438,600 → 270,153 |
| Peak managed live bytes | 4,194,368 → 2,097,232 | 524,338 → 262,217 |
| Retains | 200 → 200 | 200 → 200 |
| Final managed live bytes | 0 → 0 | 0 → 0 |
| ARM process RSS, KiB | 8,064 → 3,904 | 2,560 → 2,112 |
| AMD process RSS, KiB | 8,548 → 4,452 | 3,172 → 2,592 |

The 199 removed requests are result arrays. The remaining 401 requests and 200
retains are still real costs: this is neither heap-free nor ARC-free execution.
Managed counts exclude allocator metadata, native libraries and startup; RSS is
a separate single process observation. Shared inputs and views preserve their
values; all cases return to their initial zero managed live storage.

## Compiler, code and stack costs

Single observations for the largest sensor case, **reference → candidate**:

| Cost | ARM1 | AMD1 |
|---|---:|---:|
| fwp C emission, ms | 319.3 → 318.8 | 273.8 → 282.3 |
| GCC compilation, ms | 1,937.8 → 1,955.4 | 1,691.3 → 1,679.3 |
| fwp peak RSS, KiB | 41,508 → 41,732 | 42,864 → 42,992 |
| GCC peak RSS, KiB | 99,452 → 98,788 | 109,304 → 109,268 |
| Executable bytes | 148,696 → 148,408 | 126,808 → 126,560 |
| Measured entry's static stack bytes | 240 → 240 | 240 → 240 |

GCC reports the driver's frame as 272 bytes on ARM and 256 bounded dynamic bytes
on AMD, unchanged in each comparison. Per-function `.su` reports are retained;
these estimates do not measure the total call stack. Compiler observations are
not a statistically qualified speed comparison or a general scaling result.

## Reproduce and inspect

[Run 42472528452](https://github.com/e6qu/fun-with-pipes/actions/runs/42472528452)
uses source `025016fbedfcac2127619e4a053415aa83b9d6b0` and the
[passing focused safety evidence](../captured-map-checks-2026-11-08/README.md).
The source is anchored by `evidence/captured-maps-initial-20261108`.

| Session / job | Complete report | Raw observations | Full artifact ID |
|---|---|---|---|
| ARM1 / 128711666600 | [Report](arm-1.json.gz) | [Archive](arm-1-observations.zip), [log](arm-1.log.gz) | 13614939427 |
| ARM2 / 128711666641 | [Report](arm-2.json.gz) | [Archive](arm-2-observations.zip), [log](arm-2.log.gz) | 13615072690 |
| AMD1 / 128711666753 | [Report](amd-1.json.gz) | [Archive](amd-1-observations.zip), [log](amd-1.log.gz) | 13615108575 |
| AMD2 / 128711666605 | [Report](amd-2.json.gz) | [Archive](amd-2-observations.zip), [log](amd-2.log.gz) | 13615027948 |

Reports retain host/toolchain/flag identities, every file hash, verified full
artifact digests, the runner's audit and all derived results. Compact archives
retain all raw samples, commands/statuses, source programs, reference patches,
resource and stack reports. Generated C and executables remain identified by
hash; regenerate them with the recorded source and explicit settings. The runner
audited the actual native images before publishing these records.
