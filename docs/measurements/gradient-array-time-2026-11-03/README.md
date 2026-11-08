# Runtime cost of private gradient arrays

All four native sessions and independent raw audits are complete. **Every 5%
speed target is missed.** Larger ARM64 solves take about 3–4% less time;
AMD64's largest cases improve by 0.67–1.52%. Small repeated updates are slower.
Keep the verified allocation reduction under the accepted policy, with these
speed goals open. No completed timing was rerun for a better result.

## What was compared

- **Candidate/reference:** both compilers use frozen source
  `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`, tag
  `roadmap/gradient-array-measurement-2026-11-03`. The reference removes the
  complete seven-file gradient-array change. Both retain previous optimizations
  and run the same programs. This isolates the storage change within fwp.
- **Programs:** complete Rosenbrock gradient-descent solves. Current-only returns
  final coordinates. The history form builds `iterate count descend`, then takes
  its last vector; this compiler retains the intermediates but prints only the
  final vector. For the six coordinate/update pairs below, each process repeats
  32,768, 512, 32, 4, 32 or 8 solves, respectively, printing every result.
- **Timing:** 98 samples per case/form/session, each summing seven fresh process
  runs. Startup, computation, output and cleanup are included. Compilation,
  instrumented allocation counts and RSS observations are separate. Saved reports
  retain every sample, warmup, execution order, command and source hash.
- **Hosts:** two sessions each on native four-vCPU Neoverse N2 ARM64 and
  EPYC 7763 AMD64, GCC 13.3.0 / 15.2.0 and Rust 1.99.1.
  The [frozen contract](../gradient-array-storage.md#frozen-measurement-requirements)
  preserves compilation settings, numerical work and acceptance limits.

## Timings

Ratios are candidate time divided by reference time: 0.96 means 4% less time;
1.02 means 2% more time. Identical-copy controls pass in every session.

| Coordinates / updates | Form | ARM64 session 1 | ARM64 session 2 | AMD64 session 1 | AMD64 session 2 |
|---|---|---:|---:|---:|---:|
| 3 / 0 | current | 0.99641 | 0.99745 | 0.99831 | 1.00744 |
| 3 / 0 | history | 0.99815 | 0.99934 | 1.00285 | 0.99743 |
| 3 / 1 | current | 1.00158 | 1.00075 | 0.99581 | 0.98929 |
| 3 / 1 | history | 1.00207 | 1.00089 | 0.98254 | 0.99558 |
| 3 / 199 | current | 1.01274 | 1.01535 | 1.00318 | 1.01279 |
| 3 / 199 | history | 1.01653 | 1.01250 | 1.01741 | 1.00102 |
| 3 / 1999 | current | 1.02100 | 1.01903 | 1.01687 | 1.01959 |
| 3 / 1999 | history | 1.01330 | 1.01460 | 1.01321 | 1.01564 |
| 33 / 199 | current | 0.96668 | 0.96646 | 0.99892 | 1.00422 |
| 33 / 199 | history | 0.96670 | 0.96676 | 0.99995 | 0.99979 |
| 129 / 199 | current | 0.95788 | 0.95839 | 0.99326 | 0.99147 |
| 129 / 199 | history | 0.95992 | 0.95954 | 0.99103 | 0.98481 |

All 32 comparisons requiring at least 5% less time fail that limit. The 3/199
and 3/1999 cases take 0.10–2.10% more time. The 33/199 AMD64 cases are nearly
unchanged, including one 0.42% slowdown. Every zero/one-update regression stays
within its separate 2% limit. [Exact failed limits](verified-outcomes.json) retain
unrounded values; allocation savings do not turn these into timing passes.

The largest compiler-reported frame does not grow in any of the 48
program/session comparisons. Text-section changes range from −1,328 to +1,248
bytes. [Code/frame records](footprints.json) report those separately from speed.
Individual function frames do not measure total live call-stack use.

## Memory

[Single-solve allocation results](../gradient-array-storage-2026-11-03/README.md#allocation-result)
include replacement arrays: the largest current-only solve saves 25,472 requests
(24.2%) and 409,144 requested bytes (11.0%). Retains remain 995, peak managed
storage 14,976 bytes and final storage zero. Raw derivative buffers are unchanged.

GNU time separately observes peak resident memory (RSS) for one process running
eight 129/199 solves, including runtime, libraries, computation and output:

| Session | Current-only reference → candidate, KiB | History reference → candidate, KiB |
|---|---:|---:|
| aarch64-1 | 1,956 → 1,896 | 2,664 → 2,852 |
| aarch64-2 | 1,888 → 1,896 | 2,856 → 2,728 |
| x86_64-1 | 2,116 → 2,308 | 3,076 → 3,080 |
| x86_64-2 | 2,112 → 2,308 | 3,076 → 3,080 |

These individual high-water observations do **not** show a consistent RSS
reduction; both AMD64 current-only observations rise by about 9%.
They are not a repeated RSS benchmark or a measure of ARC operations.
[Raw RSS and allocator profiles](largest-process-memory.json.gz) retain each
scope. Never add managed, raw-buffer and RSS peaks: they overlap and can occur
at different times.

## C/Rust context

The same sessions also run C/Rust programs with manually derived gradients.
For 129/199 current-only, fwp's automatic differentiation takes 18.76–19.23 times
C's elapsed time on ARM64 and 25.29–27.39 times on AMD64; ratios to Rust are
18.46–19.04 and 24.17–25.67. This is an algorithm/implementation comparison:
those programs do not record or reverse a derivative tape, use different data
storage and print in different formats. It is not isolated language overhead,
and this change does not establish parity with C/Rust. The reference/candidate
comparison above holds the fwp algorithm and output format fixed.

## Audits and subsequent investigation

- ARM64 sessions 1/2 and AMD64 session 2: measurement run `41629714632`, jobs
  `125895890316`, `125895890374`, `125895890329`. Raw audit
  [41632779445](https://github.com/e6qu/fun-with-pipes/actions/runs/41632779445), job
  `125906293485`, passes: [reports](first-audit.zip),
  [artifact identities](first-audit-artifacts.json), [full audit log](first-audit-job.log.gz).
- AMD64 session 1: measurement run `41631438916`, job `125901736888`. Raw audit
  [41634286259](https://github.com/e6qu/fun-with-pipes/actions/runs/41634286259), job
  `125911419160`, passes: [reports](replacement-audit.zip),
  [artifact identities](replacement-audit-artifacts.json), [full audit log](replacement-audit-job.log.gz).

All four complete job logs, report hashes, commands, source/reference identities,
counts and timing outcomes reconcile; the audits verify 5,336 raw-file records.
Each measurement job fails only its final timing assertion. No warning or other
test failure was found. The retained archives identify original generated C,
native images, samples and patches without executing downloaded binaries.

Source review finds generic callback dispatch in scalar `array.map`; the previous
buffer map called its known function directly. That observation motivated the subsequent [scalar-map experiment](../direct-array-callbacks-2026-11-03/README.md);
it did not prove the cause of these differences. [The retained requirements](../unmet-comparisons.md)
preserve original failed limits independently of later changes.

## Rejected hosts

AMD64 session 1 needed three replacements before receiving the required EPYC
7763. Each rejected job stopped before building or collecting timing samples:

| Run / job | Host | Complete evidence |
|---|---|---|
| 41629714632 / 125895890311 | EPYC 9V74 | [Host](rejected-amd64-session1/host.json), [job](rejected-amd64-session1/job.json), [log](rejected-amd64-session1/job.log.gz) |
| 41630230085 / 125897628367 | EPYC 9V74 | [Host](rejected-amd64-session1-attempt2/host.json), [job](rejected-amd64-session1-attempt2/job.json), [log](rejected-amd64-session1-attempt2/job.log.gz) |
| 41630692989 / 125899210881 | EPYC 9V45 | [Host](rejected-amd64-session1-attempt3/host.json), [job](rejected-amd64-session1-attempt3/job.json), [log](rejected-amd64-session1-attempt3/job.log.gz) |

An audit-only repair accepts valid Git/difflib hunk layouts by verifying exact
patch application and resulting seven-file contents, rather than textual hunk
format. Its regression uses the actual Git patch and rejects changed/extra files.
The measured compiler, driver and limits remain frozen.
