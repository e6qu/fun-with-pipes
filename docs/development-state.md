# Current work

**Next:** collect the frozen inside-one-process diagnostic in this same PR, then
audit its results and all retained archives before the nine final-head production
jobs. Resolve failures before squash merge. Original AMD64 construction failures
remain open; [the report](measurements/callable-phases.md) defines the new paired
procedure and its zero-call controls without changing original acceptance.

Worktree: `/private/tmp/fwp-returned-callables`; branch `callable-phase-costs`;
[PR #235](https://github.com/e6qu/fun-with-pipes/pull/235) is the only active PR.
The primary checkout has unrelated preserved work; do not reset it.

## Measured results

Source `dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae`, run `41219092543`:
ARM64 `124589718380` and AMD64 `124589718541` pass collection and artifact checks.
Each completes two sessions on the same host. All completed logs are reviewed.
Six record tests, 56 clock controls and 33 Swift arithmetic cases pass per host,
plus fwp count, omitted-release and failure/retry controls.

ARM64 meets all candidate timing/RAM limits: invocation takes 56–57% less time.
AMD64 has three qualified construction regressions (8.6–16.1%) and one noisy
addition case. Combined timing acceptance remains open. The immutable summary
retains 26 passing, three failed and three inconclusive phase decisions. Peak RAM
limits pass in all eight cases. Swift/C/Rust comparisons remain workload-specific;
Swift allocation/count instrumentation is not implemented.

Independent audit `41221077777` / `124595575639` passes. Complete phase archives
are now in the repository (about 4.3 MiB compressed), with a read-only test
recomputing all four sessions against the summary. Source tag:
`roadmap/callable-phases-2026-10-31`. No unchanged timing retry occurred.

## Constructor investigation

Report run `41220300146`: ARM64 `124593267740` and AMD64 `124593267611` pass.
All four original objects reproduce byte for byte. Factory, allocator, slow/refill,
count-slot forgetting and physical-free optimized bodies match between variants.
Complete report/object archives are retained with integrity/body-equality tests.
No source-level safety defect or production runtime repair was identified.

Shared-constructor run `41222337204`, diagnostic source `17a6d13c`: ARM64
`124599348603` and AMD64 `124599348496` pass collection, checksums and cleanup.
Both logs are reviewed: seven phase tests, four context tests and no compiler
diagnostics. Both complete diagnostic archives are retained.

ARM64 uses the original Neoverse-N2 CPU model; construction differences stay
within 0.54% across twelve cases. AMD64 uses EPYC 9V74 instead of the original
Xeon 8370C. It has 32 qualified and 16 inconclusive phase comparisons. Its
zero-call composition takes 2.33% less construction time in current mode even
though neither call path runs and copy controls pass. One qualified release
comparison is 2.01% slower. Preserve these observations; they do not explain or
repair the original Xeon regressions. Next compare modes inside one process,
with one allocator, balanced batch order and zero-call controls. Do not retry
unchanged runs or relax limits. The new paired collector, caller and four record
tests are implemented but unverified. It preserves 256 batches per mode, uses
ABBA/BAAB order, checks separate checksums and records actual/original CPU models
before sampling. It reports median per-process ratios and requires zero-call
mode agreement independently of copy controls.

## Delivery checks

The user merged PR #234 as `219e3a0130c18d60750fd55ec9c0a684c1dcefd4`, tree
`b4a70d124eb2674b3f9138ece4600f77cc427dab`, with a one-line subject and empty body.
Its full production matrix had not completed before merge. Main CI `41218527464`
now has eight passing jobs: Linux ARM64, all four macOS jobs, both Windows jobs
and C/Rust benchmarks. Their logs are reviewed, including intentional Windows
scheduler panics and TLS rejection controls. Linux AMD64 `124588033346` is still
running with no failed step reported. Main docs `41218527417` / `124588033356`
passes. Preserve the remaining gate; this is not yet fully verified delivery.

PR #235 remains draft. Docs at `68665d42` pass, including the seven-test immutable
summary check. Later archive and context-audit tests still await CI. Queued docs
at superseded heads were cancelled; current docs `41224822992` / `124606679773`
at `30090e24` is queued. The final update also adds the AMD archive test.
The docs gate now explicitly uses Ubuntu ARM64, preserving every check; it reads
archived binaries and runs only its small native controls. The nine production
jobs remain unchanged. Publish one completed batch before final validation.

## Existing evidence and local limits

[Swift results](measurements/swift-peers.md) retain source `80a0504a`, four native
jobs in `41214191081`, audit `41215212017`, noisy rows and different AMD64 CPUs.
Those earlier whole-program raw artifacts expire in January 2027; their summary
is not a complete archive. [Callable evidence](measurements/returned-callables.md)
retains baseline `7d7cf98b`, first candidate `1f929022`, revised `dacaf253`, immutable
archives and the original 17.7% ARM O1 text-budget failure. Count savings do not
replace timing acceptance; keep hardware erratum protection enabled.

Free disk remains below 64 GiB. The unchanged local guard refused checks before
execution; no local passing result is claimed. Do not bypass its limits or build
locally. Only small report/archive downloads and source edits were made here;
no saved executable ran. Verification runs on GitHub.

Require nine exact-head production jobs and docs before our squash merge. Use
one subject of at most 80 characters, empty body and no attribution/trailers.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Resolve callable controls and remaining B1/B2 peers |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged numerical budgets and failed controls.
