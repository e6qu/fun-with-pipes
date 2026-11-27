# Constructed-value resource protection: verification and costs

The new lifetime proof removes 15–21% of large-service cleanup registrations
and 13.5–17% of successful retains. Ordinary runtime measurements and final
delivery gates are still pending. Counts alone do not establish a speedup.

The reference is #278, `5a9047178b88c801f37a279dfeca55b0e190bf07`.
The [frozen contract](../resource-field-costs.md#correctness-and-measurement-acceptance)
predates implementation and keeps its original thresholds.

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
per-type results. Its new measurements remain pending. Exact emitted C must
match the original candidate on all four applications and twelve growth inputs
before reusing the separately measured runtime results.

Each compiler sample is a fresh process emitting C at O2; it includes GNU time
startup, excludes C compilation and application execution, and uses one allowed
logical CPU. Two sessions use eight rounds and an untimed warmup, reference and
candidate copies, a 2% copy limit, 2% time limit and 5% process high-water RSS
limit. Hardware, GCC/Rust versions, commands, resource files and all original
samples are retained in `compiler/reports.zip`.

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

Each host reconstructs 32 native cases and eight real extra-cleanup/missing-free
controls, then rejects six altered reports. All 16 count comparisons agree across
architectures. Every large mode passes 10% fewer registrations and 5% fewer
successful retains; charged peak is unchanged, each call fully releases storage,
and allocation requests fall by 2,048–4,096 per call. These runs include counts,
not ordinary timings.

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
