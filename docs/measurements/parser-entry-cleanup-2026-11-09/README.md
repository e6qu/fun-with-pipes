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
The subsequent rebuilt-compiler checks below now pass on both native Linux hosts.

The existing native and WASI parser regressions now cover both direct calls and
owning entries, surviving aliases, every observed allocation failure and parse
errors at O1/O2. A fault build restores the actual extra drop and must fail the
alias check. Existing extra-count and missing-free controls remain.

The focused native workflow also runs the parser test target and frozen primitive
inventory. The memory collector adds 48 real malformed-argument processes and a
fifth evidence-corruption control. [The protocol](../parser-process-memory.md)
retains unresolved allocator-internal peaks and committed-memory distinctions.

## Rebuilt compiler: both Linux hosts pass

Source `ee30d13b0e98542f6b58e1126c2fc7ed99f2ec61`, tag
`roadmap/parser-process-memory-owned-entry-2026-11-09`, run `42645911091`:

| Host | Job | Artifact |
|---|---|---|
| AMD64 | `129258996498` | `13688236081` |
| ARM64 | `129258997285` | `13688885253` |

Each host passes all six `parser_workspace` tests, the primitive inventory,
36 ordinary RSS observations, 24 five-checkpoint sequences, 24 wrong-result
controls, 48 malformed fwp arguments, eight interpreter checks and five evidence
corruptions. C/Rust allocation/frame/argument controls remain passing. The runner
reconstructs every source adapter, command result, mapping summary and image hash.
The 173 retained commands include only the intended 48 status-90 argument failures,
16 status-93 C/fwp wrong results and eight status-101 Rust wrong results.

Docs `42645917282`, job `129259006921`, also passes. Complete logs show no
unexpected compiler/program failures. Selected reports/commands have ZIP CRC
checks and are retained with the full logs; large archives remain on GitHub.
WASI and the other native production targets still require final-batch gates.

For the 8,191-node tree, three ordinary processes report these peak RSS ranges:

| Host | C | Rust | fwp |
|---|---:|---:|---:|
| ARM64 | 1,644 KiB | 2,132–2,144 KiB | 2,048–2,060 KiB |
| AMD64 | 1,892 KiB | 2,420 KiB | 2,312–2,316 KiB |

These include runtime, libraries, input and parser storage. They are not isolated
per-node costs. Diagnostic snapshots are separate executions: fwp reserves about
65 GiB of virtual address space, largely inaccessible, while observed resident
memory stays around 2–3 MiB at tree completion. Releasing objects does not require
the allocator to return cached pages immediately. Do not read the unchanged
post-release resident snapshot as proof of live objects or a leak.

The allocator-internal transient peak and a defensible per-process committed-byte
observation remain unresolved. Endpoint mappings, ordinary RSS and successful
object release do not answer those questions.
