# Ordinary compilation after borrowing type trees

**All complete-application comparisons pass.** Word counting takes 11–14% less
compilation time, queued callbacks 8–10% less, the numerical tutorial 5–7% less,
and HTTP 3–4% less. Peak process memory is essentially unchanged. Four AMD64
growth comparisons fail the identical-binary noise control; milestone 6's full
timing acceptance remains open. Nothing was rerun to obtain qualification.

## Exactly what was measured

Compare reference `35a12dfee0266134237d03d1262649be69df7c41` with candidate
`c65ecb37691538ef5a24619376f68b1d243cbdea`, retained by
`roadmap/compiler-borrowed-types-2026-11-10`. The reference's compiler sources
match merged #274; the candidate borrows inputs during two type-tree walks.
[Correctness and exact copy counts](../compiler-borrowed-types-2026-11-10/README.md)
pass separately on both architectures.

- **Programs:** the maintained word-count example, numerical tutorial, queued
  callback fixture and HTTP API, plus definitions at 16/64/256/1,024 uses,
  distinct generic uses at 8/32/128/512, and nested local names at 8/32/128/512.
  Exact input paths, source hashes and commands are retained in the reports.
- **Builds:** ordinary release fwp, Rust 1.99.1/LLVM 23.1.1, with release debug
  metadata disabled. Each fwp command uses `--target native --emit-c -O2`,
  explicit `CC=gcc`, `FWP_LTO=0` and a 120-second deadline.
- **Timer:** fresh-process emit-C wall time, including GNU time startup. No
  compiler phase reporter, copy counters, GCC compilation or application execution.
  These are compiler improvements, not application runtime or C/Swift parity claims.
- **Schedule:** two sessions per architecture; one warmup and eight balanced
  rounds per input, each with reference, identical reference copy, candidate and
  identical candidate copy. Total: 256 warmup builds and 2,048 timed builds.
- **Environment:** one allowed logical CPU per job, not reserved exclusively;
  caches are not flushed. ARM64 uses Neoverse-N2 in both sessions. AMD64 session 1
  uses Intel Xeon Platinum 8573C; session 2 uses AMD EPYC 7763. Keep their results
  separate. CPU/toolchain identities and all four compiler hashes are retained.

## Elapsed-time results

Entries show **percentage less median emit-C time** versus the reference in the
same session. All sixteen complete-application results meet the frozen targets
and both identical-binary controls.

| Application | ARM64 session 1 | ARM64 session 2 | AMD64: Xeon | AMD64: EPYC |
|---|---:|---:|---:|---:|
| Word counting | 11.79% | 12.72% | 13.88% | 11.46% |
| Numerical tutorial | 5.80% | 5.99% | 6.58% | 5.10% |
| Queued callbacks | 8.43% | 9.29% | 9.57% | 8.16% |
| HTTP API | 2.95% | 2.95% | 3.09% | 4.44% |

For scale, ARM64 session 1 word counting moves from 279.62 to 246.64 ms;
HTTP moves from 1,240.67 to 1,204.07 ms. The latter program spends more of its
compilation outside these type walks. These are comparisons of ordinary fwp
against its earlier implementation, not against another language's compiler.

## Memory and generated code

Maximum timed process RSS, including both identical copies, exceeds the reference
by at most **0.18%** in every case; the frozen limit allows 5% growth. For the
complete programs, peaks are roughly 41–42 MiB (words), 65–66 MiB (numerical),
56–57 MiB (callbacks) and 127–128 MiB (HTTP). Removing about 1.1 million transient
type copies per compilation does not imply lower peak resident memory.

Every timed invocation emits byte-identical C to the reference for that input.
Reports retain C byte sizes and hashes. This experiment does not measure generated
executable size, runtime stack use or application allocations; its outputs have
not changed. The separate observer counts type nodes, not heap allocation bytes.

## Four inconclusive growth comparisons

60 of 64 input/session comparisons meet all frozen criteria. Every memory limit
passes, and every observed candidate median is below its reference. Four growth
comparisons nevertheless fail the required 0.98–1.02 identical-copy ratio:

| Host/session | Input | Failing copy/original median ratio |
|---|---|---:|
| Xeon / 1 | 8 distinct generic uses | Candidate 1.02616 |
| EPYC / 2 | 8 distinct generic uses | Candidate 0.97714 |
| EPYC / 2 | 128 distinct generic uses | Candidate 1.02138 |
| EPYC / 2 | 8 nested local names | Reference 1.02798 |

These remain inconclusive. The implementation retains verified copy reductions
and complete-application gains, following the user's standing preference; it does
not complete the roadmap's original all-growth timing rule or weaken its limits.

## Verification and retained evidence

[Run 42764964658](https://github.com/e6qu/fun-with-pipes/actions/runs/42764964658)
passes all four jobs: ARM64 `129659189881`/`129659190218`,
AMD64 `129659190659`/`129659190229`. Complete logs are audited without unexpected
diagnostics. CI success means the measurement completed correctly; it is distinct
from each comparison's `timingQualified` and `acceptance` fields.

Host/session folders retain complete logs, build settings, identity and all raw
samples. `results.json` contains recomputed results; `files.json` records byte
sizes and SHA-256 hashes. Source IDs, binary-copy hashes, all schedules, C hashes
and computed results were independently rechecked locally through the guard.
Selected ZIP members passed CRC. GitHub archive digests/expiration are in
`artifacts.json`; whole archives were not rehashed locally. Generated C, binaries
and per-command outputs remain in those archives.
