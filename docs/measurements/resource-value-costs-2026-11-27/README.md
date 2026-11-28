# Constructed-value resource protection: verification and costs

**All 32 ordinary service timing comparisons pass; large cases take 5–16% less
time. Four original process-RSS comparisons miss the 5% limit, so memory
acceptance remains open.** The proof also removes 15–21% of large-service
cleanup registrations and 13.5–17% of successful retains. All 64 repaired
compiler-cost comparisons pass. [PR #279](https://github.com/e6qu/fun-with-pipes/pull/279)
passes all nine production jobs, documentation and the complete-log audit.

The reference is #278, `5a9047178b88c801f37a279dfeca55b0e190bf07`.
The [frozen contract](../resource-field-costs.md#correctness-and-measurement-acceptance)
predates implementation and keeps its original thresholds.

## Ordinary service time and resident memory

Source `33149ad2fd888a66ff36b8eb7f2c5b61faccfccb`, tag
`roadmap/resource-value-time-service-2026-11-27`,
[run 46067853489](https://github.com/e6qu/fun-with-pipes/actions/runs/46067853489),
compares complete service calls from #278 and the new proof. Each call constructs
64 or 4,096 messages with 16-integer payloads, dispatches or cancels them,
observes target expiration or a handled error, checks results and releases its
owned data. Timed service work includes entry/result ownership and cleanup;
process launch and output checking are outside that clock. Complete-process
times are retained separately. Ordinary binaries contain no ownership observer.

Two sessions per architecture use 16 balanced rounds, identical binary copies,
50 ms C-only pilot selection, a 5 ms minimum and the frozen 2% copy limit.
Native ARM Neoverse-N2 and AMD EPYC 7763 use GCC 13.3.0 O2, explicit `armv8-a`
or `x86-64`, no LTO or floating-point contraction. Rust 1.99.1 builds both fwp
compilers. Every large case meets 5% less time; every small case meets its 2%
regression limit. Every timing control qualifies.

| Host | Qualified comparisons | Less service time, 4,096 messages | Less time, 64 messages |
|---|---:|---:|---:|
| ARM64 | 16/16 | 5.15–9.24% | 6.40–10.29% |
| AMD64 | 16/16 | 9.79–15.66% | 11.90–16.53% |

Peak process RSS is measured separately with three executions per role/case,
using the maximum of each role's readings. Four original comparisons miss:

| Host/session | Case | Reference → candidate, KiB | Candidate/reference |
|---|---|---:|---:|
| ARM64 / 2 | 4,096 messages, cancellation | 2,824 → 3,072 | 1.08782 |
| AMD64 / 1 | 64 messages, handled error | 2,232 → 2,400 | 1.07527 |
| AMD64 / 2 | 64 messages, full delivery | 2,200 → 2,320 | 1.05455 |
| AMD64 / 2 | 64 messages, expired target | 2,188 → 2,352 | 1.07495 |

These are missed limits, not evidence that charged heap increased. Managed peak
is unchanged in the separate count builds. The cause of the original RSS misses
is unproved. The completed diagnostic below cannot replace these original
observations or establish an exact transient peak.

Code and static stack observations provide separate context:

| Host | Executable bytes, reference → candidate | `.text` bytes | Largest GCC function frame, bytes |
|---|---:|---:|---:|
| ARM64 | 153,720 → 152,816 | 69,500 → 65,532 | 3,632 → 2,784 |
| AMD64 | 140,048 → 135,048 | 78,338 → 73,330 | 4,304 → 3,328 |

The frame column is a per-function compiler report, not a whole-program dynamic
stack bound. Saved `.su`, section and unwind records accompany the raw timings.

### RSS diagnosis without a timing rerun

[Run 46073285460](https://github.com/e6qu/fun-with-pipes/actions/runs/46073285460)
uses the unchanged ordinary binaries, their identical copies, the original
container digest and libc 2.39-0ubuntu8.12. It stops each process for a memory-map
page walk every 50 ms, in four balanced rounds across all eight cases. Both
hosts pass mapping/touch/unmap controls and reject altered RSS, counter and
binary-hash reports. The original native images remain verified on the runner.
The diagnostic uses Neoverse-N2 and Intel Xeon 6975P-C hosts with 4 KiB pages;
the original AMD64 timing host was EPYC 7763. These are separate hosted jobs,
not observations recovered from the original processes.

All **256 executions and 4,805 snapshots** reconstruct from raw mappings.
Fast resident counters and page-walk totals agree exactly in every snapshot.
For the cases with original misses, observed resident peaks are:

| Diagnostic case | Reference range, KiB | Candidate range, KiB |
|---|---:|---:|
| ARM64, 4,096 cancellation | 3,180 | 3,172–3,176 |
| AMD64, 64 full delivery | 2,452–2,500 | 2,436–2,496 |
| AMD64, 64 expired target | 2,424–2,476 | 2,440–2,480 |
| AMD64, 64 handled error | 2,440–2,484 | 2,436–2,496 |

These later samples do not identify why the original GNU-time high-water ratios
missed. They do not capture every transient peak and are not replacement
acceptance runs. Whole-child `wait4` memory also includes the observer's inherited
pre-exec memory, so it is retained as a diagnostic rather than fwp-only RSS.
The four original 5% limits stay open.

## Contemporary peer comparison

The same service outcomes, populations and payload sums are checked against
handwritten C, Rust and Swift 6.4.2. These are whole-service comparisons. C uses
explicit owners and pointer queues; Rust uses `Vec` payloads and `Rc`/`Weak`
targets; Swift uses ARC targets, weak registrations and arrays. fwp uses its
general callable/channel runtime and immutable values. Synchronization, queue
representation and allocation work differ: the remaining gap is not all ARC.
The peers use GCC O2, Rust `opt-level=2` with checked overflow/no LTO, and Swift
`-O -whole-module-optimization`; exact compile/link commands are retained.

All full-delivery, 4,096-message peer ratios qualify in both sessions:

| Host | fwp / C time | fwp / Rust time | fwp / Swift time |
|---|---:|---:|---:|
| ARM64 | 15.67–15.73× | 13.48–13.50× | 4.00–4.06× |
| AMD64 | 13.26–13.48× | 11.25–11.33× | 4.76–4.78× |

The direct before/after comparison establishes the fwp improvement. Unpaired
historical peer ratios do not establish that the gap to C shrank. Complete
peer copy qualifications, RSS, code and unwind observations are retained.

## Original compiler costs and repair

Source `cee08dcbd422831d5fa6a1f56963aaedfd09d1fd`,
[run 46065857276](https://github.com/e6qu/fun-with-pipes/actions/runs/46065857276),
retains two sessions on each native Linux architecture. Every application/growth
case compiles correctly and every RSS ratio passes its 5% limit. Time and memory
acceptance passes 61 of 64 comparisons:

- AMD64 session 1, nesting-8: candidate/reference 1.03152; candidate copy ratio
  0.97828 falls outside the fixed 0.98–1.02 qualification interval.
- AMD64 session 2, generic-128: ratio 1.00924, but reference copy 1.02523 is noisy.
- AMD64 session 2, generic-512: qualified ratio 1.02059 exceeds the 1.02 limit.

The first two are inconclusive; the third is an actual missed acceptance limit.
The initial implementation classified every local type before scanning its uses.
The repair classifies types on demand and caches both per-local answers and
per-type results. [Repair run 46068984506](https://github.com/e6qu/fun-with-pipes/actions/runs/46068984506)
passes **all 64 comparisons** in two sessions on both architectures at
`06943ad60b13cf1c1953ae037cf3070228df4920`. Every copy control qualifies and
every 2% time/5% RSS limit passes. Exact emitted C matches the original candidate
on all four applications and twelve growth inputs, allowing the separately
measured runtime results to be reused. The original three misses remain above;
the new sessions measure an actual implementation change.
Across those 64 comparisons, candidate/reference emit-C time ranges from
0.98978 to 1.01872; peak-RSS ratios range from 0.99497 to 1.00214. These bounds
describe the recorded applications and growth inputs, not every compilation.

Each compiler sample is a fresh process emitting C at O2; it includes GNU time
startup, excludes C compilation and application execution, and uses one allowed
logical CPU. Two sessions use eight rounds and an untimed warmup, reference and
candidate copies, a 2% copy limit, 2% time limit and 5% process high-water RSS
limit. Hardware, GCC/Rust versions, commands, resource files and all original
samples are retained in `compiler/reports.zip`.
Both sets use ARM Neoverse-N2 and AMD64 Intel Xeon 6975P-C, GCC 13.3.0 and
Rust 1.99.1. They run in separate hosted-runner jobs. Each ratio compares its
candidate with #278 on the same host in that session; the difference between
the two candidate reports is not itself a paired speed comparison.

The source run failed before any service timing because its preparation tag
was rejected. Compiler measurements were independent and completed. The fixed
service preparation accepts the explicit new prefix; it does not rerun these
compiler observations unchanged.

## HTTP checks

[Run 46065944554](https://github.com/e6qu/fun-with-pipes/actions/runs/46065944554)
passes on native ARM64 and AMD64 at the same source. It checks physical cleanup,
allocation traffic and a broken-counter control, slow-client write pressure,
socket cancellation and the real load driver's failure controls. This is
correctness evidence, not a comparison of HTTP speed.

[Load run 46065948202](https://github.com/e6qu/fun-with-pipes/actions/runs/46065948202)
passes all 34 trials: **29,756,171 attempts, zero failures**, successful shutdowns.
Two sessions per architecture exercise 1/8/32/64 persistent loopback connections
with two 30-second trials each; session 1 adds a five-minute 32-connection soak.
Every trial uses five seconds of warmup, one outstanding request per connection,
and checks the complete `GET /items/42` reply. GCC 13.3.0 O2, no LTO/contraction,
explicit architecture and distinct allowed server/generator CPUs are retained.
Exclusive physical-core placement is not established. No speed comparison with
the reference compiler or other languages is made.

| Five-minute soak | Correct replies/s | p99 response latency | Peak sampled server RSS |
|---|---:|---:|---:|
| ARM Neoverse-N2 | 20,425 | 2.336 ms | 10.75 MiB |
| AMD64 Intel Xeon Platinum 8573C | 18,111 | 2.501 ms | 12.25 MiB |

The second AMD64 session uses AMD EPYC 7763; both ARM sessions use Neoverse-N2.
RSS is sampled process residency, not managed allocation traffic or a bound on
transient peaks between samples. Complete per-trial samples and CPU use remain
in `http-load/reports.zip`.

## Lifetime and count controls

[Run 46067857005](https://github.com/e6qu/fun-with-pipes/actions/runs/46067857005)
passes both native hosts at `33149ad2fd888a66ff36b8eb7f2c5b61faccfccb`.
Eleven proof tests and seven original-lifetime tests pass, along with the eight
native semantic targets. Added cases cover returned records, both branch arms,
newly returned files and strong callbacks observed through weak channels.
Raw and optimized interpretation agree with native O1/O2; dynamic/static heap
and physical-free/reuse checks retain their existing coverage.
The repaired compiler repeats and passes this full focused scope in
[run 46068988582](https://github.com/e6qu/fun-with-pipes/actions/runs/46068988582).
Its operation counts are identical to the original candidate on both hosts.

Each host reconstructs 32 native cases and eight real extra-cleanup/missing-free
controls, then rejects six altered reports. All 16 count comparisons agree across
architectures. Every large mode passes 10% fewer registrations and 5% fewer
successful retains; charged peak is unchanged, each call fully releases storage,
and allocation requests fall by 2,048–4,096 per call. These runs include counts,
not ordinary timings.

The queued service constructs 4,096 messages with 16-integer payloads per call.
The following O2 reductions compare the original #278 compiler with constructed-
value protection; ARM64 and AMD64 counts agree exactly.

| Service outcome | Fewer cleanup registrations | Fewer successful retains | Fewer allocation requests |
|---|---:|---:|---:|
| Full delivery | 16.22% | 14.09% | 4,096 |
| Cancel every fourth message | 17.36% | 14.71% | 4,096 |
| Expired target | 21.24% | 16.95% | 4,096 |
| Handled error halfway through delivery | 15.38% | 13.52% | 2,048 |

## Retained evidence

Runner exports `46068360511` (compiler) and `46068364228` (HTTP checks) verify
the original source, archive size/SHA-256 and every ZIP member before retaining
text records. Compiler summaries reconstruct from raw commands and GNU resource
files; HTTP attempt summaries reconstruct from every compressed native attempt.
Full compiler/native-image/HTTP-attempt archives remain in GitHub artifacts.
Small text archives, original run/job/artifact metadata and complete job logs
are retained here. Failed preparation and noisy/missed limits remain visible.
Exports `46068367762` (load) and `46069093836` (counts) additionally re-audit
every HTTP attempt and the complete native count archives. [The reader](read.py)
checks every retained member and reconstructs compiler/count results without
native-image downloads. Metadata is losslessly gzip-compressed.
Repair exports `46070520960` (compiler) and `46070235418` (counts) use the same
raw reconstruction; original and repaired reports remain separate.
Runtime export `46073885767` includes every original timing/RSS result and GCC
stack report. Corrected memory export `46075009391` reconstructs every saved raw snapshot,
including mapping controls, after filtering the retained archive;
its small archive contains text observations, not the native executables.
