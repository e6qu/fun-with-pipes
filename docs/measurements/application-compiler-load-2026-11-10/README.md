# Application workflows, compiler cost and HTTP load, November 10

**All focused checks and timed sessions pass.** This completes the planned
measurements, not the final cross-platform delivery gates of PR #274.
Source: `7a65a8bb2ac23df0554610dfb90609c5fed30ee8`; immutable tag:
`roadmap/application-tooling-measurements-2026-11-10`.

- Three complete applications work through the interpreter, native builds, REPL,
  notebook and debugger. O0–O3 inspection and the AMD64 browser checks pass.
- The compiler accepts 512 independent uses of one generic function. Direct and
  mutual expanding recursion still stop at the dependent-instantiation bound.
- All 48 compiler case/session comparisons pass identical-copy noise controls.
  Type checking is the largest measured fwp phase; GCC dominates the largest
  definition and generic-use programs.
- All 34 HTTP trials complete without a failed request. Sampled server RSS stays
  flat within every trial. These are fwp-only loopback measurements, not a
  comparison with Swift, C or Rust, nor an internet capacity guarantee.

The [protocol](../application-tooling.md) fixes inputs and settings. The
[walkthroughs](../../application-workflows.md) explain the applications.
[Earlier checks](../compiler-http-checks-2026-11-09/README.md) retain the original
fixture failure, allocation controls and slow-client cleanup results.

## What compiler time means

Each sample launches a fresh release fwp process to emit C, then separately runs
GCC to build that C and checks the executable's result. The table reports the
median of eight ordinary samples. Compilation includes bundled-library work;
it is not the time to execute the compiled program. OS caches were not flushed.

- Inputs grow from 16 to 1,024 independent definitions, 8 to 512 concrete generic
  uses, and 8 to 512 nested bindings. Every definition/use is reached.
- Four treatments: ordinary compiler, identical copy, phase reporting, and an
  identical copy with reporting. One warmup per treatment; eight balanced rounds.
- GCC 13.3.0, O2, GNU C11, no LTO/fast math/contraction; explicit `armv8-a` or
  `x86-64`. Each child has a 120-second deadline. Rust 1.99.1 builds fwp.
- RSS is resident memory: the maximum reported process high-water mark among
  the eight samples, in MiB. fwp and GCC memory are separate; neither is
  per-phase memory, managed bytes, or aggregate simultaneous process memory.

Largest input in each family (time in milliseconds, memory in MiB):

| Host/session | Input | fwp time | GCC time | fwp peak RSS | GCC peak RSS |
|---|---|---:|---:|---:|---:|
| N2 / 1 | definitions-1024 | 411.9 | 5585.0 | 60.3 | 209.5 |
| N2 / 1 | generic-512 | 391.3 | 4262.7 | 58.9 | 180.0 |
| N2 / 1 | nesting-512 | 459.0 | 503.3 | 54.6 | 60.4 |
| N2 / 2 | definitions-1024 | 425.1 | 5847.5 | 60.3 | 209.4 |
| N2 / 2 | generic-512 | 408.0 | 4435.2 | 58.9 | 179.3 |
| N2 / 2 | nesting-512 | 468.9 | 515.3 | 54.6 | 60.4 |
| Xeon 6973P-C / 1 | definitions-1024 | 382.6 | 1960.5 | 61.4 | 181.0 |
| Xeon 6973P-C / 1 | generic-512 | 369.4 | 1694.5 | 59.9 | 173.4 |
| Xeon 6973P-C / 1 | nesting-512 | 435.1 | 444.1 | 55.4 | 67.8 |
| Xeon 8573C / 2 | definitions-1024 | 454.2 | 2343.7 | 61.6 | 180.9 |
| Xeon 8573C / 2 | generic-512 | 434.8 | 2038.9 | 60.0 | 173.0 |
| Xeon 8573C / 2 | nesting-512 | 513.9 | 535.8 | 55.5 | 67.8 |

N2 is ARM Neoverse-N2. The AMD64 compiler sessions use **different Intel CPUs**:
Xeon 6973P-C and Xeon Platinum 8573C. Keep their results separate.

The smallest inputs take 263–313 ms in fwp. Increasing size 64-fold raises fwp
process time 1.39–1.70× in these families; fixed startup/library work dominates
small inputs. This is not a proof of linear inference or a bound for all programs.
For the largest inputs, type checking accounts for 57–69% of observed fwp process
time. Exclusive times exclude nested phases, so they are not counted twice.
[Phase accounting](../../compiler-pipeline.md#observe-compiler-phases) explains
build-action time versus whole-process time and unassigned work.

The observer/ordinary median ratios range from **0.9799 to 1.0177**: about 2.0%
less to 1.8% more elapsed time. Both identical-copy controls are within the frozen
2% limit for every case. This small variation does not prove that reporting is
free or faster; the ordinary path still accesses the thread-local observer slot.
No observer cost was subtracted from the results.

All 1,728 emit-C invocations (including 192 warmups) emit equivalent C for their
case and pass subsequent GCC compilation and execution. The receipt keeps all
1,536 measured samples plus warmups, not just qualifying medians.

## What HTTP load means

The server handles plain HTTP/1.1 `GET /items/42` on loopback and returns the exact
body `{"id":42,"name":"item 42"}`. Each persistent connection sends one request,
waits for the whole response, then sends another. This is closed-loop load.

- Two sessions per architecture; two 30-second windows at 1/8/32/64 connections
  per session. Each trial has a fresh server and five seconds of warmup.
- Request deadline: five seconds. Shutdown deadline: twenty seconds. Session 1
  additionally runs one 300-second, 32-connection soak per architecture.
- GCC 13.3.0 O2, explicit architecture, no LTO/fast math/contraction. The copied
  application explicitly allows 10,000,000 requests per connection; the maintained
  example's 1,000 limit is unchanged. There is no reconnect/retry loop.
- Server and native generator run on distinct allowed logical CPUs. Hosted CPU
  topology is recorded; physical-core exclusivity is not established.
- Throughput counts correct replies completed inside the window. Latency runs
  from sending a request to consuming its reply. Setup and waiting for an idle
  connection are excluded. Record writing costs throughput, outside request latency.

Each range below covers the two runs at that connection count. **p99** means
99% of measured successful responses completed within that many milliseconds.
All failures are zero; failure-inclusive percentiles therefore equal successful
response percentiles. Late successes remain recorded separately from throughput.

| Host/session | Connections | Replies/second | p99 latency, ms |
|---|---:|---:|---:|
| N2 / 1 | 1 | 13,405–13,428 | 0.102–0.103 |
| N2 / 1 | 8 | 14,127–14,591 | 4.524–8.054 |
| N2 / 1 | 32 | 14,861–15,866 | 11.254–19.839 |
| N2 / 1 | 64 | 15,574–16,903 | 6.245–22.807 |
| N2 / 2 | 1 | 11,250–11,567 | 0.117–0.120 |
| N2 / 2 | 8 | 14,318–14,466 | 0.901–0.955 |
| N2 / 2 | 32 | 15,815–15,935 | 3.034–3.036 |
| N2 / 2 | 64 | 15,979–16,773 | 5.085–5.470 |
| EPYC 9V45 / 1 | 1 | 10,590–10,769 | 0.119–0.121 |
| EPYC 9V45 / 1 | 8 | 18,517–18,733 | 0.653–0.667 |
| EPYC 9V45 / 1 | 32 | 20,550–20,923 | 2.278–3.113 |
| EPYC 9V45 / 1 | 64 | 20,720–21,538 | 4.358–4.534 |
| EPYC 7763 / 2 | 1 | 6,706–6,872 | 0.177–0.181 |
| EPYC 7763 / 2 | 8 | 8,562–8,593 | 1.305–1.312 |
| EPYC 7763 / 2 | 32 | 8,672–8,757 | 5.253–5.303 |
| EPYC 7763 / 2 | 64 | 8,738–8,784 | 10.484–10.538 |

The AMD64 HTTP sessions ran on **different AMD CPUs**, EPYC 9V45 and EPYC 7763.
They also differ from the Intel compiler-measurement hosts. These data do not
rank architectures or show a regression between sessions.

Five-minute soaks (server RSS is constant throughout the sampled window):

| Host | Replies/second | p99, ms | Server RSS, MiB | Generator CPU, fraction of one core |
|---|---:|---:|---:|---:|
| N2 / 1 | 16,249 | 8.898 | 12.21 | 0.134 |
| EPYC 9V45 / 1 | 20,815 | 2.282 | 13.83 | 0.254 |

Across all trials, **26,807,548 attempts including warmup and late replies have
zero failures**. Every trial's one-second server RSS samples are flat, ranging
from 9.24 to 16.99 MiB across connection counts/hosts. Flat sampled RSS is not
proof of zero allocation, zero transient peaks, or bounded memory for every input.
The server uses approximately one CPU core; the generator uses 0.09–0.26 cores.
This suggests server-side work limits these trials, but does not identify an
allocator, ARC, scheduler or protocol bottleneck.

[Separate diagnostic runs](../compiler-http-checks-2026-11-09/README.md) verify
allocation traffic, eight returns to the idle managed baseline, all 72 socket
closures and zero managed bytes after cancellation. A diagnostic 8 MiB response
forces write backpressure while other clients progress. Neither its counters nor
its deliberately small send buffer appear in the timed server. Diagnostic traffic
includes setup/partial requests/cancellation; it is not an isolated per-request
allocation count.

## Evidence and reproduction

- [Application/fixture run](https://github.com/e6qu/fun-with-pipes/actions/runs/42724971788):
  both hosts pass all eight compiler-option tests, three SDK applications,
  eight integer tests and O0–O3 reports; browser checks pass on AMD64.
- [Compiler run](https://github.com/e6qu/fun-with-pipes/actions/runs/42725018602) and
  [HTTP run](https://github.com/e6qu/fun-with-pipes/actions/runs/42725023571): all
  four sessions pass in each workflow. All ten complete focused-job logs were
  inspected; no further failures or compiler warnings were found.
- `audit.json`: source, run/job identities, artifact IDs, hashes and expiration.
  `analysis.json`: all 48 compiler rows and 34 HTTP rows used for these tables.
- `arm-1/`, `arm-2/`, `amd-1/`, `amd-2/`: compiler raw sample/command rows and
  identities; HTTP summaries, CPU/RSS traces, exact request/response samples,
  original/configured applications and toolchain settings. Large text uses gzip.
- `files.json`: SHA-256 and size for every retained file except itself.

All selected archive members passed ZIP CRC checks. Whole-archive digests are
GitHub metadata, not independently recomputed hashes. All compiler medians,
noise controls and schedules and all 34 process traces were independently
recomputed from retained rows. Each CI runner validates every HTTP attempt before
compression. The millions of raw attempt records were not independently reread
locally; their summaries and process traces were checked here.

**Retention limit:** individual nested compiler span reports, generated C/binaries
and full HTTP per-attempt streams remain in the identified CI artifacts, which
expire February 8, 2027. The tracked receipt retains their member lists, summaries
and identities, not those full archives. Use the frozen source and explicit
[workflow settings](../application-tooling.md#delivery) to reproduce
new observations; reproduction does not replace these original measurements.

## What this changes in the plan

Compiler growth, reporting cost, sustained load and cleanup now have measured
starting points. The next performance investigation should separate bundled-library
checking from user-code checking and attribute server CPU work before choosing a
change. No syntax addition or new performance promise follows from these results.
Original noisy/unmet milestone 1–3 timing targets remain open. Final delivery still
requires the exact-head nine-job platform matrix, docs and complete-log audit;
[the handoff](../../development-state.md) records that status.
