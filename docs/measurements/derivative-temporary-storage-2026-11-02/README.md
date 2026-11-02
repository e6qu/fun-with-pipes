# Temporary records before derivative summation

The current compiler still allocates a record and a list cell for each
adjacent-pair result before summing them. This baseline identifies that remaining
cost. It measures allocations and ownership, **not elapsed-time improvement**.
The initial replacement is implemented on the development branch; native
verification and the dedicated failure controls are still in progress.

## What the program computes

The [autodiff tutorial](../../tutorials/20-autodiff-and-devices/main.fwp) computes
Rosenbrock's function by mapping adjacent pairs, then summing their contributions:

```text
[-1.2, 1.0, 0.5]
  → pairs (-1.2, 1.0), (1.0, 0.5)
  → contributions 24.2, 25.0
  → sum 49.2, mathematically
```

Each pair contributes `100 * (y - x*x)^2 + (1 - x)^2`. During differentiation,
each result also carries an integer identifying its recorded operation. The
compiler represents this as `Rev[F64]`, a record with an F64 value and I64 index.
[Tape](../../terminology.md#tape-and-backward-pass) explains the recorded operations.

Both stages record operations. Preserve this sequence:

```text
map pair 1 → map pair 2 → obtain sum seed → add result 1 → add result 2
```

Ordinary map/fold fusion would interleave mapping and addition. The proposed
change instead packs all mapped records into private temporary storage, then
starts summation. No public syntax or collection API changes are needed.

## Verified current baseline

Source: `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`.
[Run 41497441785](https://github.com/e6qu/fun-with-pipes/actions/runs/41497441785)
passes both native jobs. Full logs and archive digests are audited; all 96
observations agree across architectures. The [complete counts](baseline.json.gz)
retain every phase, allocation/ownership site, raw-storage observation, file hash
and binary/stack cost. [Artifact metadata](artifacts.json) identifies both complete
archives. The source/measurement protocol is [the existing phase observer](../derivative-forward-costs.md).

| Host | Compiler | Job / artifact |
|---|---|---|
| ARM64 Neoverse-N2 | GCC 13.3.0-6ubuntu2~24.04.1 | `125455982054` / `13168172282` |
| AMD64 EPYC 7763 | GCC 15.2.0-16ubuntu1 | `125455981525` / `13167838127` |

Each host runs six inputs, current/history forms, O1/O2 and workspace reuse off/on.
One observation performs one complete solve. An update subtracts `0.001 * gradient`
from each coordinate; initial coordinates alternate -1.2 and 1.0. Current retains
only the latest vector; history retains all vectors before selecting the last.
Both produce the same complete final vector.

For the current form at O2, workspace off:

| Coordinates | Updates | Whole-solve requests | Requested bytes | Peak managed charge | Pair-result records |
|---:|---:|---:|---:|---:|---:|
| 3 | 0 | 4 | 98 | 128 | 0 |
| 3 | 1 | 42 | 1,088 | 448 | 2 |
| 3 | 199 | 7,368 | 183,249 | 480 | 398 |
| 3 | 1,999 | 73,968 | 1,839,244 | 480 | 3,998 |
| 33 | 199 | 55,158 | 1,712,942 | 5,568 | 6,368 |
| 129 | 199 | 208,086 | 6,607,982 | 21,888 | 25,472 |

Final managed and raw storage are zero in every observation. Managed charge is
allocator-accounted live storage, not RSS. Raw tape/workspace storage is reported
separately; these are not additive peak-memory measurements.

The largest current solve spends 130,147 requests / 3,925,896 requested bytes in
forward calculation and recording. History has the same forward counts but a
larger whole-solve peak: 841,024 bytes rather than 21,888. This is expected retained
history, not a leak.

The [callback audit](callback-boxes.json) verifies all 48 generated sources and
96 observations. In the [largest saved ARM64 source](largest-current-arm64.c.gz):

| Result | Generated function | Record allocations over 199 updates |
|---|---|---:|
| Input derivative values | `f167` | 25,671 |
| Adjacent-pair results | `f164` | 25,472 |
| Final fold result | `fwp_record_fold127` | 199 |

`w28` builds the pair-result list, drops its input-list owners, obtains the cached
zero seed, then calls the fold. The intermediate list has no other consumer.
The fold already keeps its accumulator fields in locals. The proposed change
targets mapped results and their list cells, not those already-removed accumulator
boxes. Function numbers identify this saved source only.

## Candidate requirements before compiler edits

Preparation tag `roadmap/derivative-temporary-storage-protocol-2026-11-02`
freezes this baseline and these requirements before implementation.

- Select a known, uncaptured map or zip-with callback returning a flat record of
  immediate numeric fields, followed by a known left fold with a direct numeric
  worker. Prove the mapped collection has one consuming use and no escaping alias.
  Initially exclude dynamic/captured callbacks, nested/resource-bearing records,
  boxed wide numbers, shared/escaping mapped lists and right folds.
- Preserve each input and seed evaluation point, map-before-fold order, callback
  counts, arithmetic, traps and effects. Recording operations are allowed; they
  must retain their order. Preserve existing input ownership preparation unless
  a separate proof and count control establishes a borrowing change.
- Use explicitly owned temporary storage with checked size arithmetic. Keep its
  allocations in the existing managed observer. Account for input scratch arrays,
  any length traversal, header, capacity and padding. Do not move allocations into
  an unmeasured allocator or introduce hidden preparation.
- Retain source owners and temporary storage through every throwing call. Verify
  empty/singleton/long inputs, unequal zip inputs, retained input aliases, effects,
  distinct map/seed/fold traps, cancellation, allocation failure during mapping
  and final result creation. Deliberately omit physical buffer release and require
  the memory check to fail. Keep existing fold-unwind and derivative regressions.
- Compare raw and optimized interpretation with native GCC/Clang O1/O2. Inspect
  generated C and native images to verify the selected representation; timings
  cannot prove ownership or allocation removal.

For `d` coordinates and `u` updates, let `p = (d - 1) * u`. In every nonzero
baseline case/mode, remove at least `2*p - u` managed requests and `32*p - 8*u`
requested bytes. These bounds allow one eight-byte-header buffer with two
eight-byte fields per result, while retaining both existing input scratch arrays:

```text
Before: n result records × 24 bytes + n list cells × 24 bytes
After:  one buffer, 8 + n × 16 bytes
Saving: 2n − 1 requests; 32n − 8 requested bytes, per update
```

Require no increase in effective retains or peak managed charge; final managed
and raw storage remain zero. Zero-update counts and all tape/workspace counters
must remain unchanged. Preserve all outputs and derivative operation counts.
Report actual buffer sizes, live charge, code size and static frames; largest
static-frame growth must not exceed 128 bytes. Code size is supporting evidence,
not a substitute for runtime and memory results.

After correctness/count checks, use a same-source reference disabling only this
selection. Freeze its exact patch. Reuse the [record-fold paired timing protocol](../derivative-record-folds.md#requirements-frozen-before-compiler-edits):
all six inputs, both forms, 98 rounds, seven processes per role, existing solve
counts and two qualified sessions per architecture. Keep the entire driver
identical between candidate/reference. Identical copies must differ by at most
2%; candidate/reference must be at most 1.02 everywhere and at most 0.95 for
cases with at least 199 updates. Retain every failure/inconclusive comparison;
do not repeat completed noisy sessions to seek a pass. Earlier D2 limits remain
open regardless of this candidate's result. Complete final production gates only
after the implementation, controls and report form one substantial batch.

## Reproduce the audits

Download both archives from the run above and check their SHA-256 digests against
`artifacts.json`. Run `scripts/summarize-derivative-forward-costs.py` with explicit
`--arm64`, `--amd64`, `--source`, `--run`, `--output` and `--comparison baseline`.
Then run `scripts/summarize-derivative-callback-boxes.py` with that `--summary`,
both archive paths, `--output` and `--accumulator direct-fields`. Both audits read
saved evidence without executing saved images. The older #239 audit uses explicit
`--accumulator boxed-each-step`; choosing the wrong layout must fail.


## First implementation: allocation results

Source `229ea441bec8fe9c568b423e22a5e6336c52b34b`, retained by tag
`roadmap/derivative-temporary-storage-counts-2026-11-02`, passes run
[41505591902](https://github.com/e6qu/fun-with-pipes/actions/runs/41505591902).
The [complete count audit](candidate-counts.json.gz), [artifact identities](candidate-artifacts.json)
and compressed job logs retain the evidence. Both GCC architectures pass all
96 observations against the frozen baseline. This is not a timing result or
final platform acceptance.

Whole-solve results below use current-only derivatives, GCC O2, workspace off.
Both architectures agree. Requested bytes count cumulative managed allocation
traffic; peak bytes count the maximum simultaneous managed charge. Neither is RSS
or the separately measured derivative-tape storage.

| Coordinates / updates | Requests before → after | Requested bytes before → after | Peak bytes before → after |
|---|---|---|---|
| 3 / 0 | 4 → 4 | 98 → 98 | 128 → 128 |
| 3 / 1 | 42 → 37 | 1,088 → 976 | 448 → 416 |
| 3 / 199 | 7,368 → 6,373 | 183,249 → 160,961 | 480 → 448 |
| 129 / 199 | 208,086 → 156,943 | 6,607,982 → 5,382,142 | 21,888 → 17,824 |

The candidate replaces result records and list cells with a word buffer and
removes the two old input scratch arrays. It still traverses input lengths before
mapping and prepares callback input owners normally. Effective retain counts,
derivative operations and raw tape/workspace counts remain unchanged. Every
final managed/raw count is zero. All largest-frame growth limits pass.
For the largest O2 case, instruction bytes change from 46,876 to 46,908 on ARM64
and from 49,602 to 50,226 on AMD64; code size is reported, not used as a speed claim.

Independent archive replay passes in 4.11s under the local guard; complete native
logs contain ten passing Rust tests per architecture and no diagnostics. The
first added cleanup controls at `0c5b9827` also pass GCC and Clang on both native
architectures in run `41507658382`. Further callback-owner and selection-exclusion
controls are being added before the paired timings and final production matrix.

The timing reference is prepared by `scripts/prepare-packed-records-reference.py`.
Its exact patch replaces only the call to packed-record lowering with a clone of
the preceding representation. The disabled branch remains type-checked; there is
no runtime setting. Existing record-fold optimizations stay enabled in both
compilers. The runner saves and verifies the patch, source hashes and compiler
identity, and the archive audit reconstructs the patch without executing saved
code. Use explicit `packed-records-time` and `packed-records-report` suites.
