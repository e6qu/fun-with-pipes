# Compiler cost of sharing validated tape access

All fourteen observed input/architecture comparisons pass the 5% time/RSS and
2% identical-copy limits. The largest time increase is 1.31%; the largest peak
RSS increase is 0.29%. These measure the compiler, not the generated program.

**Hardware qualification remains explicit:** ARM64 records implementer `0x41`,
part `0xd49` (Neoverse N2); AMD64 used **EPYC 9V74**, not EPYC 7763. The compiler
workflow recorded hardware but did not apply the runtime host filter. The 9V74
results are retained as observations while the host-policy decision is pending;
they do not verify the frozen EPYC 7763 requirement.

## What was compared

- Source `319782736b0a983022f2a48879b35c9e57992949`. The reference changes only
  AD_RECORDING_SCOPES to false; earlier lookup/append/capacity changes stay enabled.
- Timed command: `fwp build --memory dynamic --emit-c -O2 program.fwp -o output.c`.
  Time covers process startup through C emission. It excludes compiler builds,
  C compilation and execution of the generated program.
- Seven inputs: field-owner transfer, the autodiff tutorial, three derivative
  solves, 64 shared-scope callbacks and a worker containing 5,120 callback calls.
  `33/199` means 33 coordinates and 199 updates.
- Two identical copies of each compiler, two warmup rounds and ten measured
  rounds: 48 commands per input, 336 per architecture. Six additional checks per
  architecture verify source/selection without contributing timing samples.
- Time uses medians after warmups. Peak process RSS includes warmups; it is
  compiler process memory, not fwp-managed application storage. Identical-copy
  controls require runs of identical compiler bytes to agree within 2%.
- Compiler builds use O1, debug assertions, overflow checks, two build jobs and
  no LTO. Complete CPU, commands, flags and resource records are retained below.

Ratios are candidate/reference: 1.01 means 1% more time or memory, 0.99 means 1%
less. Absolute seconds and KiB for both versions are in [the summary](summary.json).

| Input | ARM64 time | AMD64 time | ARM64 peak RSS | AMD64 peak RSS |
|---|---:|---:|---:|---:|
| field-transfer | 1.0008 | 1.0131 | 0.9988 | 1.0029 |
| autodiff-tutorial | 1.0035 | 1.0050 | 1.0000 | 0.9996 |
| derivative-3-0 | 1.0026 | 1.0053 | 0.9989 | 1.0008 |
| derivative-33-199 | 1.0003 | 1.0056 | 1.0003 | 1.0002 |
| derivative-129-199 | 1.0023 | 1.0080 | 1.0003 | 1.0004 |
| repeated-scopes | 1.0038 | 1.0118 | 1.0000 | 0.9970 |
| large-scoped-worker | 0.9988 | 0.9956 | 1.0010 | 0.9991 |

## Verification and records

Measurement run `42224658244`: ARM `127915006870`, AMD `127915007195`.
All 672 commands and twelve untimed checks pass. Complete producer logs are
clean. Audit `42228884598` / `127929341718` checks every retained command, input,
generated-C hash, reference edit and resource record; its complete log is clean.
No samples were repeated.

- ARM64: [audit](aarch64-audit.json), [samples](aarch64-report.json.gz),
  [producer log](aarch64-job.log.gz), [reference](aarch64-reference.json),
  [records](aarch64-records.zip), [file hashes](aarch64-retained-files.json).
- AMD64: [audit](x86_64-audit.json), [samples](x86_64-report.json.gz),
  [producer log](x86_64-job.log.gz), [reference](x86_64-reference.json),
  [records](x86_64-records.zip), [file hashes](x86_64-retained-files.json).
- Full audit: [job](audit-job.json), [log](audit-job.log.gz),
  [artifact identity](audit-artifact.json). Artifact `13509230474`, 12,341,293 bytes,
  SHA-256 `56146859799ab87ff4f5a01d9ab9cd6681f602d82fec71b1a2f19a544d0e7902`.
  Local guarded checks verified its source/hash, clean log and fourteen empty
  limit-failure lists (0.12–0.13 s). Large originals were audited on GitHub.

[Contract](../recording-context-scopes.md) ·
[Correctness and cleanup](../recording-context-checks-2026-11-06/README.md) ·
[Current plan](../../../PLAN.md). Compiler-cost observations do not establish
application speed or close any earlier comparison's missed limit.
