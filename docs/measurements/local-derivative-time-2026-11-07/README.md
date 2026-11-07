# First tape-free derivative comparison

The prototype is **not accepted yet**. All four sessions completed and passed
their observation audits. The 33-coordinate ARM64 case misses the required 20%
gain; three 3-coordinate/1,999-update copy controls exceed the 2% noise limit.
Do not rerun these unchanged sessions or describe inconclusive timings as passes.

Source `0ddde8224c3ab39e9ef4d9770483a72372b17c42`,
[run 42413370794](https://github.com/e6qu/fun-with-pipes/actions/runs/42413370794).
The [frozen contract](../local-derivatives.md) defines inputs, algorithms,
hardware, compiler flags, timing scope and acceptance limits.

## Elapsed time

Each number is local forward AD time divided by ordinary reverse AD time.
For example, 0.6331 means 36.69% less elapsed time. Both compute derivatives
automatically. The local program exposes neighboring interactions and avoids
the global tape; it is a different algorithm, not a faster implementation of
arbitrary `grad`.

| Coordinates / updates | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3 / 0 | 1.0106 | 1.0104 | 0.9857 | 0.9971 |
| 3 / 1 | 0.9904 | 0.9903 | 0.9928 | 0.9866 |
| 3 / 199 | 0.6331 | 0.5980 | 0.5966 | 0.5898 |
| 3 / 1999 | 0.5572 | 0.5245* | 0.5235* | 0.5222* |
| 33 / 199 | 0.8107 | 0.8066 | 0.6959 | 0.7544 |
| 129 / 199 | 0.7594 | 0.7549 | 0.6868 | 0.7353 |

`*` Inconclusive: identical copies differ by 2.18%, 2.16% and 3.01%, respectively.
The two ARM 33/199 gains are 18.93% and 19.34%, below the required 20%.
All zero/one-update limits pass. See [costs.csv](costs.csv) for all 144 rows,
absolute process times, C ratios, allocation counts and peak process memory.
Times include launch, repeated solves, output and exit; compilation is excluded.
C/Rust use handwritten derivatives, so those ratios are not isolated language
or reference-counting overhead.

## What the allocations reveal

ARM2, 129 coordinates, 199 updates, eight solves:

| Program | Managed allocation requests | Requested bytes | Peak managed bytes | Peak raw tape bytes |
|---|---:|---:|---:|---:|
| Local forward AD | 409,297 | 11,470,416 | 8,736 | 0 |
| Ordinary reverse AD | 4,361 | 5,005,064 | 11,584 | 33,888 |
| Handwritten fwp arrays | 1,745 | 1,689,152 | 8,736 | 0 |

All three have eight retains and zero live managed storage at exit. Requested
bytes count allocation traffic, not simultaneously resident memory.

The local candidate has exactly `2 × 128 × 199 × 8 = 407,552` more requests than
the handwritten array program. Its saved C creates two heap `Dual` inputs per
following-edge call; the preceding edge is already scalar arithmetic. The known
edge is called directly. Dynamic dispatch in the separate generic semantic probe
does not explain this complete-solve path.

## Retained evidence

[index.json](index.json) identifies every job, artifact, archive digest, report
and full job log. Compressed reports preserve all observations in their summaries;
compressed audits preserve the complete source/image/observation file inventory.
The original four GitHub artifacts contain the complete individual files.
All archive digests and retained report hashes were verified locally under the
resource guard (0.25 s). Every failed job failed only its final timing gate;
all four complete observation audits pass. No source or measurements were changed
to produce these tables.
