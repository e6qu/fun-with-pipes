# Fewer temporary owners in derivative callbacks

**Status:** both compiler changes are implemented. Count and source-site audits
pass, together with focused GCC/Clang checks on both native hosts.
Compiler-cost/runtime measurements and the final platform gates remain. [Draft PR #249](https://github.com/e6qu/fun-with-pipes/pull/249) · [Plan](../../PLAN.md).

## What is measured

The workload follows the [autodiff tutorial](../tutorials/20-autodiff-and-devices/main.fwp):
minimize Rosenbrock's function by subtracting `0.001 * gradient` from each
coordinate. Initial coordinates alternate -1.2 and 1.0. Each adjacent pair
`(x, y)` contributes `100 * (y - x*x)^2 + (1 - x)^2` to the function.

- Inputs are **coordinates / updates**: 3/0, 3/1, 3/199, 3/1999, 33/199 and 129/199.
- **Current** keeps the latest coordinate vector; **history** keeps every vector
  before selecting the last. Both print the same complete final vector.
- A **retain** increments an ownership count. Removing it can also remove its
  later release; it does not imply removing an allocation or a CPU instruction.
- Counts cover both forms, GCC O1/O2, reusable derivative scratch storage off/on
  and both architectures: 96 observations. Ordinary and instrumented executions
  must agree with raw interpretation and the numerical oracle.
- Count hosts have four virtual CPUs: Neoverse-N2 / GCC 13.3.0 and AMD EPYC 9V74 /
  GCC 15.2.0. Exact toolchains, images and host records are in the retained reports.

This compares fwp with the same workload before the two changes. It is not a
measurement of overhead relative to C, Rust or Swift. Peak **managed** bytes
cover selected fwp storage, including size-class rounding; separately recorded
raw derivative storage and whole-process RSS are different measurements.

## Results and source attribution

For `d` coordinates and `u` updates, differentiation visits `p=(d-1)*u` adjacent
pairs. The original callback creates `2*p` temporary input owners and `p` owners
while separating the input tuple's fields. The two changes remove those sites.

Largest current-only solve, 129 coordinates / 199 updates, GCC O2, workspace off:

| Measurement | Packed-storage baseline | Field moves | Numeric inputs too |
|---|---:|---:|---:|
| Retains | 77,411 | 51,939 | 995 |
| Managed allocations | 156,943 | 156,943 | 156,943 |
| Requested bytes | 5,382,142 | 5,382,142 | 5,382,142 |
| Peak managed bytes | 17,824 | 17,824 | 17,824 |
| Final managed/raw bytes | 0 | 0 | 0 |

That is **76,416 fewer retains (98.7%)**, with unchanged allocation traffic and
peak storage. All 96 observations agree with the required `p` then `2*p` savings;
raw tape/workspace storage, derivative work and output remain unchanged.
Zero-update counts stay unchanged. Static-frame growth stays within 128 bytes.
No elapsed-time improvement is claimed yet.

The compiler proofs are explained in [design](../design.md#numeric-callback-inputs).
Their frozen contracts are [complete field transfers](field-owner-transfer-protocol.md)
and [numeric input fields](numeric-callback-input-protocol.md). In both cases,
selection follows typed expressions, not a search-and-delete operation on C text.

## First-stage results

[Run 41538264130](https://github.com/e6qu/fun-with-pipes/actions/runs/41538264130)
uses `ceecb569c6748a226ec6ddebc417dc16351490e9`. Each host passes four unit and
26 native GCC/Clang controls. Both full logs, all 16 target logs, all 96 counts
and 40 saved probes are audited. Sixteen probes return normally; 24 intentionally
broken retain/release controls fail as required. Coverage includes shared/repeated
children, two/eight fields, boxed entries, traps, cancellation and boxing failure.

- [Counts and source/image hashes](field-owner-transfer-checks-2026-11-03/verified-counts.json.gz)
- [Artifacts](field-owner-transfer-checks-2026-11-03/verified-artifacts.json) ·
  [probe outcomes](field-owner-transfer-checks-2026-11-03/verified-probes.json)
- Full logs: [ARM64](field-owner-transfer-checks-2026-11-03/arm-verified.log.gz) /
  [AMD64](field-owner-transfer-checks-2026-11-03/amd-verified.log.gz)

The initial index used the stored function body while emission used a clone.
The repair indexes the exact emitted body. All original failures were audited:
[ARM64](field-owner-transfer-checks-2026-11-03/arm-initial.log.gz),
[AMD64](field-owner-transfer-checks-2026-11-03/amd-initial.log.gz),
[artifact identities](field-owner-transfer-checks-2026-11-03/initial-artifacts.json).

## Initial numeric-input checks

[Run 41542603016](https://github.com/e6qu/fun-with-pipes/actions/runs/41542603016),
source `043fcc1cfc1205cb3141f2da5b10b6824f6c7c28`, passed build/lint and all counts.
Each host reported 46 passing checks and three failures:

- An invalid unit fixture marked an argument-taking function as a cached value,
  which requires a zero-argument entry. A valid named-entry fixture replaces it.
- GCC and Clang both rejected the expected nested-callee signature because the
  tiny test function had been inlined. A larger polynomial preserves the call.

Review also separated numeric rewriting from packed lowering so comparison
switches remain independent, excluded execution/constant-function entries and
checked numeric caller leaf types. No extra whole-program clone was added.

Evidence: [counts](numeric-input-checks-2026-11-03/initial-counts.json.gz),
[artifacts](numeric-input-checks-2026-11-03/initial-artifacts.json), full logs
[ARM64](numeric-input-checks-2026-11-03/arm-initial.log.gz) /
[AMD64](numeric-input-checks-2026-11-03/amd-initial.log.gz).

### Follow-up selection failure

[Run 41545062127](https://github.com/e6qu/fun-with-pipes/actions/runs/41545062127),
source `1075628e5032ccf7e4f17afb882fada81088c581`, passed nine unit and 38 native
checks per host. The top-level function-value fixture still excluded its callee
under both C compilers. Saved C/executables showed ordinary execution, but no
required signature rewrite. This was not accepted as transformation coverage.

All 20 target logs and both full job logs were audited: no other failures.
All 96 counts passed, with exact map → forwarding worker → numeric callee
attribution. Evidence: [counts/sites](numeric-input-checks-2026-11-03/repair-counts.json.gz),
[artifacts](numeric-input-checks-2026-11-03/repair-artifacts.json), full logs
[ARM64](numeric-input-checks-2026-11-03/arm-repair.log.gz) /
[AMD64](numeric-input-checks-2026-11-03/amd-repair.log.gz).

### Local callee selection verified

[Run 41547177941](https://github.com/e6qu/fun-with-pipes/actions/runs/41547177941),
source `ea5deea50bd4447b3864f09f25db780bd8d37518`, passes ten unit controls and
the native fixture. A local callee matches the internal-call requirement.
The source-to-IR control proves the parameter changes; native checks cover the
emitted signature, mixed inputs, output order, aliases and cleanup.

All four saved ARM64 GCC images (O1/O2, stack off/on) return normally and release
all 1,344 allocated bytes. Full logs have no diagnostics:
[log](numeric-input-checks-2026-11-03/selection.log.gz),
[artifact/image identities](numeric-input-checks-2026-11-03/selection-artifacts.json).

### Complete focused verification

[Run 41548218462](https://github.com/e6qu/fun-with-pipes/actions/runs/41548218462)
on `5af0366c0c1ad91feeb08ddbd42a035858b635e4` passes on both architectures.
Each host passes ten unit controls and forty native checks under GCC/Clang O1/O2.
Both full job logs and all twenty target logs have no diagnostics.

All 400 saved probes were audited against their source, native image headers and
expected status: 184 ordinary returns and 216 rejected, deliberately broken
ownership/cleanup controls. The selected callback releases all allocated storage;
failure and cancellation checks include numeric, boxed and mixed inputs.
All 96 count observations pass, and every retain reduction matches an attributed
site. This establishes count and cleanup behavior, not elapsed-time performance.

- [Counts and source/image identities](numeric-input-checks-2026-11-03/verified-counts.json.gz)
- [Artifact identities](numeric-input-checks-2026-11-03/verified-artifacts.json) ·
  [saved probe outcomes](numeric-input-checks-2026-11-03/verified-probes.json)
- Complete logs: [ARM64](numeric-input-checks-2026-11-03/arm-verified.log.gz) /
  [AMD64](numeric-input-checks-2026-11-03/amd-verified.log.gz)

## Prepared performance experiments

| Workflow | Comparison and acceptance |
|---|---|
| `numeric-input-analysis` | Five fixed compiler commands through C emission; reference disables numeric inputs only. Two copies each, two warmups, ten balanced rounds; copy medians within 2%, elapsed time and peak RSS at most 5% above reference (RSS includes warmups). |
| `callback-owners-time` | Complete solves with both owner changes disabled in the reference; packed storage stays enabled. Two qualified sessions per architecture; at least `3*p` fewer retains, unchanged storage/work, 2% noise/regression limits, 5% speedup for ≥199 updates. |
| `callback-owners-report` | Independently audit every sample, original outcome, source patch and actual image identity. Retain failed/noisy results. |

Both experiments require passing focused jobs with matching compiler, runtime,
library and test sources. Compilation timing includes startup, parsing, typing,
optimization, ownership analysis and C emission; it does not run the program.
Runtime timing measures complete solves. C/Rust peers use explicit derivatives,
so their ratios include differentiation-strategy costs, not isolated language
overhead. [Swift comparisons](swift-allocations.md) are separate measurements.

These experiments are prepared, not measured. Fewer retains alone prove no
speedup. The final delivery also requires nine production jobs and documentation.

## Replaying the original site audit

The original packed-storage baseline is `a4f3200c9b97b955c3f3603788eacbfac19fde4e`,
[run 41511493637](https://github.com/e6qu/fun-with-pipes/actions/runs/41511493637).
Its compiler sources equal PR #248's final compiler sources.
The [site report](derivative-owner-sites.json.gz) retains every source hash and
observation. Using its [verified archives](derivative-temporary-storage-2026-11-02/verification.md):

```sh
python3 scripts/check-derivative-owner-sites.py \
  --counts docs/measurements/derivative-temporary-storage-2026-11-02/verified-counts.json.gz \
  --arm64-archive /path/to/arm64-counts.zip \
  --amd64-archive /path/to/amd64-counts.zip \
  --source a4f3200c9b97b955c3f3603788eacbfac19fde4e \
  --output /path/to/owner-sites.json
```
