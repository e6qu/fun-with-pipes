# Compiler cost of packed derivative inputs

All fourteen input/architecture comparisons pass the frozen limits. The largest
compiler-time increase is **4.32%**; the largest peak-RSS increase is **0.82%**.
These are compilation costs, not measurements of generated-program speed.

## What was measured

- Source `5f63ea1a9a7fb7a6bc1068bbd84c4224c176b106`, immutable tag
  `roadmap/packed-input-measurement-2026-11-04`.
- The reference disables only scoped objective specialization and private input
  packing. Earlier ownership optimizations, runtime and library are unchanged.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Timing covers startup through C emission, including parsing, typing and all
  compiler passes. Building the compiler, compiling C and running the generated
  program are excluded. GNU `time -v` records whole-compiler peak RSS.
- Seven inputs, each with two identical copies of each compiler, two warmups and
  ten balanced measured rounds per copy: **336 commands per architecture**.
  Time medians exclude warmups; peak RSS includes them. Four earlier untimed
  workload checks are excluded from both ratios.
- Acceptance: candidate time/RSS at most 1.05 times reference; variation between
  identical-copy time medians at most 2%. No timing was repeated.

## Workload checks before timing

The field-owner fixture, autodiff tutorial and derivative solves use the frozen
inputs. Derivative labels below give coordinate/update counts.

Two additional fixtures check specialization cost:

- **Repeated scopes:** 64 reachable calls share one specialized worker. Generated
  C must contain all 64 calls and one live specialization in the candidate;
  the reference retains its dynamic callback.
- **Large scoped worker:** one small wrapper calls one large shared helper with
  5,120 dynamic calls. Both versions must retain that helper without copying it.
  The separate compiler unit test checks rejection of directly oversized workers.

Both candidate and reference passed these checks on both architectures. The
[earlier fixture repair](../packed-input-checks-2026-11-04/README.md) happened before
any timings: unused exports and constant input had hidden the intended workload.

## Hosts and settings

| Setting | ARM64 | AMD64 |
|---|---|---|
| Native Linux CPU | ARM implementer `0x41`, part `0xd49` | AMD EPYC 7763 |
| GCC | 13.3.0 | 15.2.0 |
| Rust | 1.99.1 | 1.99.1 |

Both compilers were built at Rust O1 with debug assertions, checked overflow and
two build jobs. Explicit execution settings are `FWP_LTO=0`, `LC_ALL=C`,
`FWP_VRET=1`, `FWP_FRAME_FIELDS=1`, `FWP_PACKED_ARRAYS=1`, `FWP_STACK=1` and
`FWP_ARRAY_FUSION=1`; other fwp environment settings are removed.

## Results

Ratios divide candidate by reference: 1.04 means 4% more time or memory.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| Field-owner transfer | 1.0014 | 0.9948 | 1.0019 | 1.0034 |
| Autodiff tutorial | 1.0395 | 1.0432 | 1.0051 | 1.0053 |
| Derivative 3/0 | 1.0130 | 1.0078 | 1.0042 | 1.0063 |
| Derivative 33/199 | 1.0158 | 1.0034 | 1.0077 | 1.0054 |
| Derivative 129/199 | 1.0166 | 1.0054 | 1.0081 | 1.0041 |
| Repeated scopes | 1.0038 | 1.0046 | 1.0034 | 1.0049 |
| Large scoped worker | 1.0035 | 1.0045 | 1.0023 | 1.0022 |

Maximum identical-copy variation is 1.42%, below 2%. Passing these limits does
not close earlier comparisons against different references.

## Evidence

[Run 41849392317](https://github.com/e6qu/fun-with-pipes/actions/runs/41849392317)
passes both jobs. Audits verify all 672 scheduled commands and eight untimed
checks, input/output hashes, native compiler images, reference edits, raw
time/RSS samples and recomputed limits. Full logs contain no unexplained
failures or compiler warnings.

- ARM64: [samples](aarch64-report.json.gz), [full log](aarch64-job.log.gz),
  [reference](aarch64-reference.json), [audit and artifact identity](aarch64-audit.json).
- AMD64: [samples](x86_64-report.json.gz), [full log](x86_64-job.log.gz),
  [reference](x86_64-reference.json), [audit and artifact identity](x86_64-audit.json).
- Raw records: [ARM64 archive](aarch64-records.zip) / [inventory](aarch64-records.json),
  [AMD64 archive](x86_64-records.zip) / [inventory](x86_64-records.json).
  Each preserves 1,072 files: inputs, emitted C, untimed fixture checks, raw
  elapsed/RSS records and reference sources. The five compiler images per host
  were audited in the original artifact; these smaller archives omit them.
- Documentation also passes at this source: [job](docs-job.json),
  [full log](docs-job.log.gz), [diagnostic audit](docs-audit.json).
  Its rejected target names, deliberate panic and
  timeout messages test the test runner; they are expected negative controls.
- [Native correctness](../packed-input-checks-2026-11-04/README.md) and the
  [contract](../packed-derivative-inputs.md) define the separate runtime, ownership,
  stack and final delivery requirements.
