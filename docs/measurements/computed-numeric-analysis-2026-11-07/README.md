# Compiler cost of computed numeric inputs

All fourteen candidate/reference comparisons stay within the 5% compilation-time
and peak-memory budgets. ARM64 passes every control. **Two AMD64 timings remain
inconclusive:** candidate copies differ by 2.41% for field transfer, and reference
copies differ by 3.35% for the autodiff tutorial, above the 2% copy limit.
The complete audit passes and retains both misses. No timings were repeated.

[Run 42418398638](https://github.com/e6qu/fun-with-pipes/actions/runs/42418398638),
source `8389403c566230680b61949e6e5e6837293215bf`. Native code matches the passing
[focused checks](../computed-numeric-inputs-2026-11-07/README.md).
The reference is `f1cc94cf4e013369cccb8a836bd745f41e5d757c`; only
`src/cgen/numeric_parameters.rs` differs among compiler/runtime/library/build
sources. Production builds have no dependency on this historical reference.

## Work and timing scope

Seven inputs: field ownership transfer, the autodiff tutorial, three derivative
program sizes, 64 calls sharing one scoped callback, and a large scoped callback.
Each full compiler command includes startup, parsing, typing, optimization,
ownership preparation and C emission. It does not run the generated program.

Both compilers use the production CI profile: Rust optimization level 1 with
debug assertions and overflow checks enabled. Each input has two warmups and
ten fixed balanced rounds for two byte-identical copies of each compiler:
336 scheduled commands per architecture. Six untimed checks verify selected
and retained ownership paths. GNU `time -v` measures each command's peak RSS;
this is not isolated memory used by the changed pass.

| Host | Largest measured time ratio | Largest peak-RSS ratio | Copy controls |
|---|---:|---:|---|
| ARM64 | 1.0053 | 0.9910 | All pass |
| AMD64 | 1.0129 | 1.0032 | Two misses above |

Ratios divide candidate cost by reference cost. A time ratio of 1.0129 means
1.29% more elapsed time. Do not infer a compiler-memory improvement from these
small RSS differences.

## Retained evidence

The two `*-report.json.gz` files contain every sample and summary; the
`*-records.zip` files retain complete generated C, commands, resource reports,
preflight checks, source/reference identities and output logs. Each
`*-retained-files.json` hashes those records. `*-audit.json` records the complete
audit and failed controls; `*-job.log.gz` retains each full producer log.
Compiler binaries remain in the original GitHub producer artifacts.

[artifact.json](artifact.json) identifies the passing complete audit archive.
The downloaded archive digest, report sources and retained summaries were
verified under the local guard together with original runtime archives (0.36 s).
