# Count the temporary iteration buffer separately

[Run 41723211349](https://github.com/e6qu/fun-with-pipes/actions/runs/41723211349)
tested `81a978b7322618426e854bb9435c5af4de8c3ec6` on GCC ARM64/AMD64 and Clang
ARM64. Each host passed 45 integration tests and failed one allocation assertion.
All nine target logs, full logs and native observations were audited.

The assertion counted list nodes and the final option, but omitted `iterate`'s
temporary pointer buffer. `fwp_p_iterate_owned` allocates that buffer through
`fwp_mem_alloc`, which uses the native managed allocator. The allocation ledger
therefore counts it. Reverse builds nodes without another buffer.

For a scalar callback producing **k positive values**:

| Path | List nodes | Temporary buffers | Final option | Total allocations |
|---|---:|---:|---:|---:|
| `iterate` → reverse/head | 2k | 1 | 1 | 2k + 2 |
| `iterate` → direct `last` | k | 1 | 1 | k + 2 |
| Selected final-value loop | 0 | 0 | 1 | 1 |

Nonpositive counts allocate none. The frozen requirement remains **2k fewer
list-node allocations**; the loop also removes the pointer buffer. The repair
corrects the exact total and prints observed/expected counts before checking them.
It does not change the compiler, runtime or acceptance limit. Wide-number callback
boxing is reported separately and is never counted as a list node.

On each host, only the 16 old/direct scalar observations failed, all with exit 80.
Selected-loop observations passed, including aliases, captures, slices, reuse,
traps, cancellation and deliberately omitted cleanup. The file-lifetime probe,
source behavior, count/effect order, optional-wrapper cleanup, eight other targets,
268 compiler units (4 ignored), all twelve selections, docs and tutorial passed.

## Source-level diagnosis

The three retained ARM64 C probes were compiled locally with Apple Clang 17.0.0
(`clang-1700.4.4.1`, ARM64 Darwin), O2, GNU11 and `-ffp-contract=off`. Only the
count assertion was corrected. All three complete probes passed, including their
cleanup checks. At k=64 they observed **130, 66 and 1 allocations**, respectively.
The guarded check took 1.48 seconds; it is a count diagnostic, not a timing
benchmark or substitute for the repaired three-host run. A second bounded check
uses the actual edited fixture, including the new diagnostic output: all three
paths exit 0 with complete cleanup and 90 when the result is deliberately leaked.
[Commands, hashes and observations](local-fixture-check.json) retain that check.

[Local diagnosis archive](local-clang-diagnosis.zip) retains original/modified C,
commands, binaries, hashes and outputs. Each host's `logs-and-probes.zip` retains
all step/target logs and three original scalar C/native probes. `retained.json`
checks their hashes against the complete original artifact; `audit.json.gz`
inventories 418 native executions plus eleven interpreter/inventory statuses.
These smaller archives do not contain every original image. Artifact metadata records the full download
identity/digest; complete originals remain in `final-iteration-third` scratch and
the linked run. No performance session had started at this repair. The
[subsequent three-host run](../README.md) verifies the corrected counts.
