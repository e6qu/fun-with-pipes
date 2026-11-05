# Compiler costs after the pair cleanup repair

Both hosts pass: compilation time grows at most 0.52%, peak compiler memory
at most 0.13% (5% limits). Identical copies vary at most 1.57% (2% limit).
These are compiler costs; they do not measure generated-program speed.

## What is compared

Source 373955e8, with the single-owner cleanup repair. The reference disables
only private pair reuse; both sides retain consuming ownership and earlier
optimizations. Seven inputs each use two identical copies per compiler, two
warmups and ten balanced measured rounds: 48 commands/input, 336/host.
Six additional untimed checks verify selected transformations.

The timer covers compiler startup through emitted C: parsing, inference,
optimization, ownership analysis and output. GNU `time -v` records peak RSS
(including warmups). Rust 1.99.1 builds the compiler at production O1 with
assertions and overflow checks. Commands use `build --memory dynamic --emit-c
-O2`; LTO is off and the established representation optimizations are on.

Hardware: Neoverse-N2 ARM64 and **EPYC 9V74 AMD64**. This AMD64 compiler run
is not the separately required EPYC 7763 runtime comparison. It does not settle
older compiler or runtime measurements on different hosts. CPU, compiler and
command records remain in the saved reports.

## Results

Ratios are candidate / allocating reference; 1.0052 means 0.52% more time.
Reports retain exact seconds, KiB and every sample.

| Input | ARM64 time | ARM64 peak RSS | AMD64 time | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0035 | 1.0000 | 0.9979 | 0.9972 |
| autodiff-tutorial | 0.9964 | 1.0008 | 1.0024 | 0.9983 |
| derivative-3-0 | 0.9947 | 1.0000 | 0.9958 | 0.9958 |
| derivative-33-199 | 0.9937 | 1.0000 | 1.0009 | 0.9961 |
| derivative-129-199 | 0.9999 | 1.0000 | 1.0017 | 1.0013 |
| repeated-scopes | 1.0044 | 1.0000 | 1.0049 | 0.9986 |
| large-scoped-worker | 0.9982 | 1.0006 | 1.0052 | 0.9982 |

## Evidence

[Run 42017186500](https://github.com/e6qu/fun-with-pipes/actions/runs/42017186500)
and [full audit 42018554796](https://github.com/e6qu/fun-with-pipes/actions/runs/42018554796)
pass. [ARM64](aarch64-audit.json) and [AMD64](x86_64-audit.json) receipts verify
all 336 scheduled commands, six untimed checks, outputs, resource records,
reference edits and image/source identities. Full logs have no unexpected
diagnostics. Reports, reference manifests and all observation archives are
adjacent; [retention.json](retention.json) identifies their audited bundle.
Compiler binaries remain in the original artifact identified by each receipt.

The [first implementation's results](../packed-pair-analysis-2026-11-05/README.md)
remain separate. [Stack/allocation verification](../packed-pair-cleanup-census-2026-11-05/README.md)
also passes. [Runtime results](../packed-pair-cleanup-time-2026-11-05/README.md)
retain 34 timing misses with all other gates passing; final production remains.
