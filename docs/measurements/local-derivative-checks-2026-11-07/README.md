# First local-derivative correctness checks

[Run 42411789323](https://github.com/e6qu/fun-with-pipes/actions/runs/42411789323)
tested source `3f0cea6b870701f2f1acc529060e2b5427705026`.

| Host / compiler | Interpreter versus native `-O2` | Job result |
|---|---|---|
| Linux AMD64 / GCC | Pass, 2.40 s | Formatting failed |
| Linux ARM64 / GCC | Pass, 3.51 s | Formatting failed |
| macOS ARM64 / Clang | Pass, 2.04 s | Formatting failed |

The test checks empty/singleton inputs, both endpoints, a nonlinear edge,
constant edges, unchanged input aliases and a trapping callback. Each native
program agrees with its own unoptimized interpreter. This establishes the
prototype's tested examples, not a speedup or full platform support.

All three formatters produced the same patch. It has been applied; the next
run adds an explicit preceding-versus-following trap-order test and retains
emitted C and native probes. No timing job ran from this failed workflow.

The ZIP files retain source identity, compiler identity, complete semantic output
and formatter patch. Compressed files retain the full job logs. [index.json](index.json)
records job/artifact identities and SHA-256 digests. Source identities, passing
semantic outputs and identical formatting patches pass a guarded check (0.13 s).
