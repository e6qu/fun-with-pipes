# Compiler and HTTP correctness checks, November 9

Source: `7fa50257155abf63fa220cd17f9500ea6d9bdd16`. These are focused checks,
not final platform delivery or sustained performance results.

| Check | ARM64 | AMD64 |
|---|---|---|
| Compiler growth: three families, four sizes each | All 12 pass | All 12 pass |
| Ordinary/observed C, native outputs and early/late errors | Match | Match |
| One-second API check, correct replies including late completion | 11,497; no failures | 13,232; no failures |
| Driver wrong/partial/timeout controls | Pass | Pass |
| Physical cleanup, allocation counter and disabled-counter control | Pass | Pass |
| Slow-client/backpressure probe | Pass | Pass |
| Application compiler-option tests | 7 pass; one fixture error | 7 pass; one fixture error |

The 512-type case now succeeds. All three application workflows, eight integer
output tests and O0–O3 inspection checks pass on both hosts; AMD64 browser checks
also pass. The recursive-expansion test omitted required `rec` declarations,
so it failed before reaching specialization. Both fixtures are corrected in the
following repair; their expansion-limit verification remains pending here.
Exact-float process accounting passes on both hosts.

## What the slow-client test establishes

A diagnostic route returns an 8 MiB runtime-created body. Small socket send
buffers force writes to wait: the probes observe 552 waits on ARM64 and 529 on
AMD64. Other clients still receive their replies while the large body is unread.
Full/partial transfers, partial requests, disconnects and final cancellation pass.

| Memory/socket observation | ARM64 | AMD64 |
|---|---:|---:|
| Idle managed bytes after each cohort | 2,640 | 2,640 |
| First → last idle RSS (KiB) | 26,376 → 26,392 | 27,372 → 27,392 |
| Whole-probe peak managed slot bytes | 16,790,511 | 16,790,511 |
| Final open sockets / managed bytes | 0 / 0 | 0 / 0 |

All 72 accepted sockets close. Allocation traffic includes setup, controls,
partial work and cancellation; it is not an isolated cost per item request.
RSS includes allocator pages and other process storage. This diagnostic's socket
settings and instrumentation are absent from ordinary timed load.

## Retained evidence

- `audit.json`: exact sources, jobs, steps and artifact identities.
- `job-*.log.gz`: all six complete native-job logs, including the fixture failure.
- `arm/` and `amd/`: compiler summaries, exact HTTP attempts/responses, source
  variants, process samples and slow-client memory records. Large summaries and
  logs use lossless gzip; original binaries remain in the identified CI artifacts.
- `files.json`: SHA-256 and size of each retained file.

Selected archive members passed ZIP CRC checks; whole-archive digests in metadata
were reported by GitHub. The HTTP reader independently reconstructs both check
summaries from retained attempt records. A one-second correctness check is not a
capacity measurement. Follow the [protocol](../application-tooling.md) for timed
sessions and [the handoff](../../development-state.md) for current delivery status.
