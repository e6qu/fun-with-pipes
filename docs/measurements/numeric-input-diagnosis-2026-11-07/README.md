# Why the first compiler extension did not select the measured call

[Run 42417084281](https://github.com/e6qu/fun-with-pipes/actions/runs/42417084281)
uses source `9cb7497f320ac80cdb00f95da5aabb4a7daf475e`.

- GCC ARM64/AMD64 and Clang ARM64 each pass nine unit checks.
- Each fails only `measured_local_edge_uses_numeric_arguments`.
- Its printed typed input shows scalar `let` computations around both numeric
  records, including the second input's checked array access. Every direct call
  is excluded by the pure-input rule. Function-value cloning cannot solve that.
- Mixed-ownership/native derivative checks and all runtime measurements were
  skipped after the unit failure. No native correctness or timing claim follows.

[index.json](index.json) hashes all three complete job logs; [jobs.json](jobs.json)
retains every step outcome. The [revised contract](../direct-numeric-workers.md)
replaces speculative cloning with ordered input evaluation and field passing.
