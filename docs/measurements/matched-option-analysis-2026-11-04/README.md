# Compiler cost of matched optional fields

All ten input/architecture comparisons pass the frozen time, peak-memory and
noise limits. The largest time increase is 0.81%; the largest peak-RSS increase
is 0.39%. These results bound compiler overhead. They do not measure program
execution speed or establish a speedup.

## Comparison

- Source `82963531dddb6d9a5f32ec26657dc220736f4055`, immutable tag
  `roadmap/matched-option-measurement-2026-11-04`.
- The reference disables only direct field returns for immediately matched list
  `last`/`nth` and internal final-iteration results. Both compilers retain earlier
  ownership and iteration work. The reference changes two conditions in
  `src/cgen.rs`; runtime and library sources remain identical.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  This includes startup, parsing, typing, optimization, ownership analysis and C
  emission. Compiler construction, C compilation and program execution are outside
  the timer. GNU `time -v` measures whole-compiler peak RSS.
- Five inputs: field-owner transfer, the autodiff tutorial, and derivative solves
  with coordinate/update counts 3/0, 33/199 and 129/199. Inputs match the frozen
  fixtures or generator exactly.
- Each architecture executes 240 commands: two identical copies per compiler,
  two warmups and ten balanced measured rounds per copy. Time medians exclude
  warmups; peak RSS includes them. Copy variation must be at most 2%; candidate
  time and RSS must be at most 1.05 times their reference values.

## Hosts and settings

| Setting | ARM64 | AMD64 |
|---|---|---|
| Native Linux CPU | ARM implementer `0x41`, part `0xd49` | Intel Xeon Platinum 8370C |
| GCC | 13.3.0 | 15.2.0 |
| Rust | 1.99.1 | 1.99.1 |

The compiler is built at O1 with debug assertions, checked overflow and two build
jobs. Both measured compilers use `FWP_LTO=0`, `FWP_VRET=1`,
`FWP_FRAME_FIELDS=1` and `LC_ALL=C`; other fwp environment settings are removed.
The compiler-cost protocol requires native architectures. The separate runtime
protocol requires specific CPU models, including EPYC 7763 for AMD64.

## Results

Ratios divide candidate by reference: 1.01 means 1% more time or memory.

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| Field-owner transfer | 1.0008 | 1.0011 | 0.9877 | 1.0025 |
| Autodiff tutorial | 0.9983 | 1.0016 | 0.9929 | 1.0006 |
| Derivative 3/0 | 1.0008 | 1.0029 | 0.9899 | 1.0026 |
| Derivative 33/199 | 1.0061 | 1.0003 | 0.9886 | 1.0025 |
| Derivative 129/199 | 0.9980 | 1.0080 | 0.9887 | 1.0039 |

Maximum identical-copy variation is 1.24%, below 2%. No timing was repeated.
These results do not close earlier comparisons with different references.

## Evidence

[Run 41811652687](https://github.com/e6qu/fun-with-pipes/actions/runs/41811652687)
passes both jobs. Audits verify all 480 commands, source inputs, raw time/RSS
records, generated C, compiler images, reference edits and explicit settings.
Every invocation succeeds; full logs contain no compiler warning or error.

- ARM64: [samples](aarch64-report.json.gz), [full log](aarch64-job.log.gz),
  [reference manifest](aarch64-reference.json), [audit](aarch64-audit.json).
- AMD64: [samples](x86_64-report.json.gz), [full log](x86_64-job.log.gz),
  [reference manifest](x86_64-reference.json), [audit](x86_64-audit.json).
- [Native correctness](../matched-option-fields-2026-11-04/README.md) and the
  [frozen contract](../matched-option-fields.md) define the separate ownership,
  runtime, stack and delivery requirements.
