# Parser entry released a caller's surviving input

The first process-memory batch exposed a compiler ownership bug. The parser
worker consumed its input correctly, but its generated function-value entry
released the same owner again. A caller retaining an independent alias lost it.

```text
Caller retains input:          2 owners
Parser consumes its argument:  1 owner
Entry incorrectly drops it:    0 owners — caller's input is freed
```

The fix makes the entry use the same argument-ownership contract as direct
calls. A consuming worker handles its own input. An entry calling a borrowing
worker still releases the owner it received, including on unwinding. The shared
contract explicitly covers every compiler body variant.

## Original failures

Source `8848e837c6e2d708060459c563788a0bba25352d`, tag
`roadmap/parser-process-memory-combined-2026-11-09`, run `42631160983`:

| Host | Job | Artifact | Result |
|---|---|---|---|
| AMD64 | `129207526319` | `13683054975` | All 20 ordinary/diagnostic fwp observations failed |
| ARM64 | `129207526124` | `13684997120` | All 20 ordinary/diagnostic fwp observations failed |

The native C/Rust observations, eight interpreter results, mapping controls and
allocation/frame checks passed. The latter include 96 invalid arguments and 32
corrupted-record/frame controls. Original reports, commands and complete job logs
are retained with [hashes](files.json). No failed fwp memory result is accepted.

The original harness used status 93 for both wrong results and cleanup failures.
Its eight fwp wrong-result controls therefore **did not establish result checking**:
the ownership bug could satisfy the same status. The repaired harness checks
cleanup first with status 94, caller release with 95, node counts with 96, and
only then compares the numerical result with status 93. Malformed numeric
arguments now reject leading whitespace and negative unsigned wraparound too.

## Repair verification

A focused Apple Clang O2 diagnostic on the retained generated source confirms:

- Original entry: correct result 14, but live input storage falls from 32 B to
  zero before the caller releases it; status 93.
- Remove only the entry's duplicate cleanup: correct result 14 and 32 B remain
  until the caller releases its owner; final live storage returns to baseline.

This isolates the source bug; it is **not** a rebuilt-compiler or Linux GCC pass.
The repaired compiler still needs native verification.

The existing native and WASI parser regressions now cover both direct calls and
owning entries, surviving aliases, every observed allocation failure and parse
errors at O1/O2. A fault build restores the actual extra drop and must fail the
alias check. Existing extra-count and missing-free controls remain.

The focused native workflow also runs the parser test target and frozen primitive
inventory. The memory collector adds 48 real malformed-argument processes and a
fifth evidence-corruption control. [The protocol](../parser-process-memory.md)
retains unresolved allocator-internal peaks and committed-memory distinctions.
