# Allocation savings from reusing numeric storage

**All predicted counts and cleanup checks pass on ARM64 and AMD64.**
This is an untimed allocation experiment. It establishes neither a speedup nor
lower process RAM; those measurements are separate.

## Comparison

Both compilers come from `07541ff956d582bb9c3936b86261e43fa25b0b2f`, frozen at
`roadmap/owned-numeric-measurement-2026-11-05`. The reference disables only the
private consuming array-map and coordinate-list transformations. All earlier
optimizations, arithmetic and inputs are identical. [The contract](../owned-numeric-updates.md)
was frozen before implementation.

Each solve minimizes the Rosenbrock function by repeated gradient updates,
starting from alternating coordinates `[-1.2, 1.0, -1.2, …]`, with step size `0.001`.
The driver captures the initial list once and repeats the solve. Thus the first
update must preserve a shared input; later private coordinate lists can be reused.
“Current” returns the final coordinates directly. “History” constructs successive
values and reads the last; earlier history may be optimized away.

For N coordinates and U updates, one solve saves:

- U array requests, each asking for `8N + 8` bytes.
- `N × max(U−1, 0)` coordinate-cell requests, each asking for 24 bytes.
- No additional retains. Raw derivative workspace allocation is unchanged.

## Observed counts

These are totals per process, including every repeated solve and output.
Both result forms, both architectures and workspace reuse on/off give identical
managed counts. Every row exactly matches the prediction.

| Coordinates / updates | Solves per process | Requests saved | Requested bytes saved |
|---|---:|---:|---:|
| 3 / 0 | 32,768 | 0 | 0 |
| 3 / 1 | 512 | 512 | 16,384 |
| 3 / 199 | 32 | 25,376 | 659,968 |
| 3 / 1,999 | 4 | 31,972 | 831,296 |
| 33 / 199 | 32 | 215,456 | 6,750,208 |
| 129 / 199 | 8 | 205,928 | 6,559,744 |

For the largest case (eight solves):

| Measurement | Reference | Candidate |
|---|---:|---:|
| Managed requests | 223,026 | 17,098 |
| Managed requested bytes | 16,684,704 | 10,124,960 |
| ARC retains | 3,192 | 3,192 |
| Peak managed bytes | 15,232 | 13,664 |
| Peak raw derivative bytes | 33,904 | 33,904 |
| Final managed / raw bytes | 0 / 0 | 0 / 0 |

That is 25,741 fewer requests and 819,968 fewer requested bytes **per solve**.
Requested bytes measure allocation traffic, not simultaneously live memory.
Managed bytes and raw derivative buffers are separate counters; neither is total
process RAM. Peak managed storage never grows in any case. Zero-update profiles
are identical. All executions release final managed and raw storage.

## Reproduce and inspect

[Run 41925013907](https://github.com/e6qu/fun-with-pipes/actions/runs/41925013907)
uses `owned-numeric-census` with correctness run `41920964943` as its prerequisite.
It collects no timing samples. Native hosts:

| Host | Compiler | Job |
|---|---|---|
| Neoverse-N2, ARM64 | GCC 13.3.0 | `126907012020` |
| AMD EPYC 9V45, AMD64 | GCC 15.2.0 | `126907012115` |

Compiler builds use Rust O1 with assertions and overflow checks. Generated C uses
GCC O2, `-fno-fast-math`, `-ffp-contract=off`, explicit `armv8-a` / `x86-64`,
reuse enabled and LTO disabled. [The driver](../../../scripts/check-owned-numeric-census.py)
records every command and setting. Five negative controls reject incorrect counts,
extra retains/live storage, raw-buffer changes and leaks.

Each host's independent audit checks all 99 commands, 24 native ELF images and
48 executions against the saved raw output and profiles. Every printed solution
matches an independent handwritten derivative. It also verifies the exact
reference patch, unchanged ownership/runtime sources, profile instrumentation,
workspace cleanup and full job log. No unexpected diagnostics remain.

[ARM64 receipt](arm/verified.json) and [AMD64 receipt](amd/verified.json) contain
compact counts. Each host directory retains the job/artifact identities, full
compressed job log, all-file hashes and `evidence.zip`: source, generated and
instrumented C, native images, stack reports, raw outputs/profiles, report,
reference patch and machine/toolchain details. The original compiler binary is
identified by hash in the reference manifest; it remains in the source artifact
rather than being duplicated here. Every retained file is listed in
`retained-files.json`.

The subsequent runtime run rejected one AMD64 session before building or timing:
GitHub assigned EPYC 9V74 rather than the required EPYC 7763. Its
[qualification](rejected-timing-host/qualification.json), full log and safety
metadata are retained here. No timing sample was discarded. Replacement run
`41927345094` requests only that missing session with unchanged requirements.

Next: compiler-cost and runtime measurements, then all final production gates.
See [the current handoff](../../development-state.md).
