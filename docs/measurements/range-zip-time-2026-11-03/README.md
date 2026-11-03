# Runtime cost of private range consumption

All four native sessions and independent audits are complete. Larger solves take
about 7.1–10.0% less time. Some small cases improve by less than the required 5%,
so timing acceptance remains open. Exact allocation savings and compiler-cost
checks pass separately; no completed timing was rerun for a better result.

## What was compared

- **Candidate/reference:** frozen source `3be9479c4150d7aae5695d7f7aa4ce3f84d0f738`,
  tag `roadmap/range-zip-measurement-2026-11-03`. The reference disables only
  `range_zip::lower`. Both keep all preceding optimizations and run identical
  complete derivative solves. This measures one compiler change within fwp.
- **Forms:** current-only returns final coordinates; history returns every step.
  Coordinates/updates are the six pairs in the table below. Each process repeats
  32,768, 512, 32, 4, 32 or 8 complete solves, respectively, and prints every result.
- **Timing:** 98 samples per cell; each sample sums seven fresh process runs.
  Startup, computation, formatting and teardown are included. Compilation and
  instrumented allocation runs are separate. The fixed schedule, warmups and
  source/driver hashes are retained in the raw reports.
- **Hosts:** two sessions each on native four-vCPU Neoverse N2 ARM64 and
  EPYC 7763 AMD64. GCC 13.3.0 / 15.2.0, respectively; Rust 1.99.1 builds fwp.
  [Exact compilation settings and acceptance rules](../range-zip-storage.md).

## Results

Each ratio is candidate time divided by reference time: 0.90 means 10% less time;
1.01 means 1% more time. Identical-copy controls pass in every session.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 0.96255 | 0.96378 | 1.00422 | 1.00260 |
| 3 / 0 | history | 1.01675 | 1.01519 | 0.98856 | 0.98623 |
| 3 / 1 | current | 1.01370 | 1.00806 | 1.00823 | 0.99418 |
| 3 / 1 | history | 1.01139 | 1.01144 | 0.99353 | 0.99103 |
| 3 / 199 | current | 0.95396 | 0.95016 | 0.94868 | 0.93427 |
| 3 / 199 | history | 0.95642 | 0.94262 | 0.95897 | 0.95603 |
| 3 / 1999 | current | 0.94594 | 0.94328 | 0.93345 | 0.91783 |
| 3 / 1999 | history | 0.93446 | 0.94160 | 0.95078 | 0.96028 |
| 33 / 199 | current | 0.90579 | 0.90550 | 0.92864 | 0.92212 |
| 33 / 199 | history | 0.90569 | 0.90499 | 0.92128 | 0.91885 |
| 129 / 199 | current | 0.90351 | 0.90303 | 0.91402 | 0.91617 |
| 129 / 199 | history | 0.89995 | 0.89989 | 0.91264 | 0.91199 |

The frozen 5% requirement (ratio ≤0.95) is missed in these cases:

- ARM64 3/199 current in both sessions, plus session 1 history: 4.36–4.98% less time.
- AMD64 3/199 and 3/1999 history in both sessions: 3.97–4.92% less time.

Every other timing/copy limit passes, including the 2% zero/one-update regression
limit. Keep the verified reductions and leave these misses open under the accepted
policy. This result does not resolve earlier experiments' separate missed goals.

Across the 48 program/session comparisons, the largest compiler-reported frame
grows by at most 112 bytes (limit 128). Text-section size changes range from
-656 to 1,008 bytes. [Executable/text sizes and frame records](footprints.json)
are separate from elapsed-speed evidence. Frame reports describe individual
functions; they do not measure total live call-stack use or dynamic stack storage.

## Process memory

Separate GNU time observations measure peak resident memory (RSS) for one process
running eight 129/199 solves, including runtime, libraries, computation and output:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,892 → 1,756 | 2,664 → 2,856 |
| aarch64-2 | 1,892 → 1,764 | 2,664 → 2,664 |
| x86_64-1 | 2,416 → 2,308 | 3,076 → 3,008 |
| x86_64-2 | 2,308 → 2,308 | 3,012 → 3,204 |

These are individual process high-water observations, not a repeated RSS benchmark.
[Raw RSS and managed/raw allocator profiles](largest-process-memory.json.gz) retain
all values. The [single-solve storage table](../range-zip-storage-2026-11-03/README.md#verified-storage-reduction)
uses a different scope. Managed allocation counts, raw derivative storage and
whole-process RSS must remain separate; adding their peaks would double-count
memory and combine peaks from different moments.

## Audits and source identities

- ARM64: run `41603246961`, jobs `125806772559` / `125806772536`.
  Raw audit `41605943666` / `125815667922` passes:
  [reports](arm-audit.zip), [artifact identities](arm-audit-artifacts.json),
  [audit log](arm-audit-job.log.gz).
- AMD64: run `41603882629`, jobs `125808854223` / `125808854159`.
  Raw audit `41607485480` / `125820866330` passes:
  [reports](amd-audit.zip), [artifact identities](amd-audit-artifacts.json),
  [audit log](amd-audit-job.log.gz).

All report/log digests, source hashes, exact reference patches and 5,336 raw-file
inventory entries reconcile independently. Both audit logs are clean. All four
measurement jobs fail only their final timing assertion; correctness, equivalent
work, allocation, memory and code/frame checks pass. [Machine-readable outcomes](verified-outcomes.json)
retain every failed limit. Original raw archives remain identified in the audit records.

## Rejected hosts

Original AMD64 jobs stopped before building because GitHub supplied EPYC 9V74.
Both full logs contain only the expected rejection exit. Source, artifact digests,
job steps and skipped build/timing work were audited. Their replacements above
qualified on EPYC 7763; no measured outcome was replaced.

| Session | Job | Evidence |
|---|---:|---|
| Original AMD64 1 | 125806772756 | [Host/job](rejected-hosts/initial-amd1.json), [full log](rejected-hosts/initial-amd1.log.gz) |
| Original AMD64 2 | 125806772669 | [Host/job](rejected-hosts/initial-amd2.json), [full log](rejected-hosts/initial-amd2.log.gz) |
