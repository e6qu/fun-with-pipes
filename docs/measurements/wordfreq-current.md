# Current word-frequency costs

This V1/B1 baseline was declared in `6d4df06b`, before its runner or measurements.
It replaces neither the [historical comparison](wordfreq.md) nor any failed D2/N1
result. Its purpose is to establish current whole-program costs and measurement
variation before choosing a word-frequency optimization or its timing budget.
No speedup or timing acceptance is claimed by a successful measurement job.

## Same work, stated differences

Use the maintained `examples/wordfreq.fwp` and the existing C/Rust peers in
`tests/fixtures/wordfreq_bench.{c,rs}`. Preserve the two inputs: 4,096 words with
64 distinct words and 65,536 words with 1,024 distinct words. Generation, the
independent Python result and seven empty/separator/tie/punctuation controls
come from `scripts/measure-wordfreq.py`. Check every complete output.

All peers normalize words, count in sorted contiguous key/count pairs, rank and
print five results. C/Rust combine the three normalization operations; fwp uses
its ordinary strings, lists and maps. Inputs are ASCII. This does not compare
arbitrary Unicode or all language features. Time the complete fresh process:
startup, input reads, normalization, counting, ranking, printing and cleanup.
Exclude input generation, compilation, the parent opening the input file and
evidence writes from that interval. Warmups reuse the same input files; no OS
cache flush is performed. This measures repeated launches over warmed inputs,
not cold-storage performance.

## Hosts, settings and repetitions

Run two independent sessions on each of the existing four-processor hosts:
Neoverse-N2 ARM64 and EPYC 7763 AMD64. Qualify the CPU, processor count,
architecture and exact compiler versions before building or executing. Use the
current pinned baseline toolchains: Rust 1.99.1, GCC 13.3 on ARM64 and GCC 15.2
on AMD64, with the full identities checked by `descent-baselines.py`.
Keep rejected hosts and do not count them as measurement sessions.

Use generated C at O2 with explicit `-march=armv8-a` or `-march=x86-64`,
`-ffp-contract=off` and no LTO. Rust uses O2, overflow checks and explicit
`target-cpu=generic` or `target-cpu=x86-64`. Enable ordinary ownership, stack
storage and unique reuse explicitly for fwp. Record all commands, settings,
compiler versions and source identities. Ordinary builds need no previous fwp.

Each session has four labels: C, Rust, fwp and a byte-identical copy of fwp.
Use equal-length executable paths for all four labels and require matching
hashes for the fwp copy before running it. For each input use two
warmup rounds followed by **16 measured rounds**, with **64 fresh processes per
label per round**: 1,024 measured processes per label. These counts are fixed
before seeing the new results; they exceed the old 24-process observations.

Use the existing balanced four-label schedule with seed **20261030**. Rotate the
16-entry cycle by one place per round and repeat it sixteen times within that
round. Preserve ordinary allowed CPU affinity and every observation, including
outliers. Processes in one round are samples, not independent runner sessions.

Sum each label's process times per round and report the median of the sixteen
round totals, its per-process equivalent, fwp/C and fwp/Rust ratios and the
fwp/copy ratio. Also retain all individual times, round totals, execution orders,
stdout, stderr and exit statuses. Partial failure output must survive a failed
or timed-out child. Do not rerun unchanged measured sessions until they pass.

## Memory, representation and subsequent budgets

Keep managed allocation requests/bytes, retains and peak/final charged bytes in
separate instrumented fwp executions; require final live charge zero. Record
fresh-process peak RSS separately for each peer. These quantities have different
scopes; they do not establish C/Rust allocation-count parity. Inspect native ELF
headers and retain binary/section sizes and GCC stack reports. No disassembly is
needed to diagnose source correctness or accept these observations.

The four audited sessions below set workload-specific timing limits before any
candidate implementation.
If variation prevents a useful comparison, record that limitation and repair the
measurement rather than accepting a noisy candidate. No universal percentage is
imported from another workload, and no D2/N1 limit changes. The final evidence
must make it clear whether it is a baseline, an inconclusive comparison or an
accepted optimization.

## Running and auditing

The `wordfreq-current` workflow selection requires `native_runner=all` and
`comparison_session=both` for the complete experiment. It builds the current
compiler only. Select one host/session only to replace a host rejected before
execution, retaining that rejection. Failed measured sessions are not retries.

`scripts/measure-current-wordfreq.py` stores each child's command, input path,
status, duration and complete stdout/stderr in `commands.jsonl`. Byte streams use
base64 so invalid output remains lossless. Failed launches have no invented exit
status; timed-out process groups are killed and reaped before their partial
output is recorded. Generated C, peer sources, input files, expected output,
profiles, stack reports, section sizes and native images remain in the artifact.
Three real-child tests check failed launch, nonzero exit and timeout retention;
the shared schedule tests verify counts, positions and predecessor balance.


## Audited results

Source `dc963bb500748dabe393dfaed20f92a333f5996e` completes two qualified
sessions on each CPU. Each session retains 9,270 child observations: builds,
correctness controls, warmups, timed processes and separate memory observations.
All **37,080** statuses and complete outputs, manifests, native headers, execution
orders and calculated statistics are independently checked. All four complete
job logs pass their diagnostic audit; each also passes ten Python tests.

| CPU / session | Run / job | Measurement artifact |
|---|---|---|
| Neoverse-N2 / 1 | [40974666332 / 123799636907](https://github.com/e6qu/fun-with-pipes/actions/runs/40974666332/job/123799636907) | 12941778367 |
| Neoverse-N2 / 2 | [40974666332 / 123799637188](https://github.com/e6qu/fun-with-pipes/actions/runs/40974666332/job/123799637188) | 12941578578 |
| EPYC 7763 / 1 | [40975221824 / 123801495592](https://github.com/e6qu/fun-with-pipes/actions/runs/40975221824/job/123801495592) | 12942078196 |
| EPYC 7763 / 2 | [40976014339 / 123804111260](https://github.com/e6qu/fun-with-pipes/actions/runs/40976014339/job/123804111260) | 12941644239 |

Three AMD host assignments were rejected **before building or timing**: EPYC
9V45 and 9V74 in the first run, then 9V74 in the second. Only those unmeasured
sessions were replaced. The [evidence index](wordfreq-current-artifacts-2026-10-30.json)
retains all qualifications, rejected-job logs and artifact identities. Its
compressed reports share lossless source/output text by SHA-256. The repository also retains complete native images in a shared compressed
archive, alongside checked headers, hashes, sections and stack reports. Every
retained text and binary byte was reconstructed and compared with the originals.

Times are the median round total divided by 64, expressed in milliseconds per
process. These are **not** medians of individual process durations. A ratio of
2.49 means 149% more elapsed time than the named peer, not 249% more.

| CPU / session | Words | C ms | Rust ms | fwp ms | fwp / C | fwp / Rust | fwp / identical copy |
|---|---:|---:|---:|---:|---:|---:|---:|
| ARM64 / 1 | 4,096 | 1.214 | 1.659 | 2.381 | 1.960 | 1.435 | 1.015110 |
| ARM64 / 2 | 4,096 | 1.140 | 1.571 | 2.274 | 1.994 | 1.448 | 0.997504 |
| AMD64 / 1 | 4,096 | 1.367 | 1.896 | 3.049 | 2.230 | 1.608 | 1.028909 |
| AMD64 / 2 | 4,096 | 1.352 | 1.838 | 2.945 | 2.177 | 1.602 | 1.039017 |
| ARM64 / 1 | 65,536 | 9.747 | 12.692 | 24.262 | 2.489 | 1.912 | 0.999940 |
| ARM64 / 2 | 65,536 | 9.689 | 12.634 | 24.119 | 2.489 | 1.909 | 1.001043 |
| AMD64 / 1 | 65,536 | 10.549 | 16.119 | 31.936 | 3.027 | 1.981 | 1.003796 |
| AMD64 / 2 | 65,536 | 10.447 | 15.996 | 31.775 | 3.041 | 1.986 | 1.002043 |

On the larger input, fwp takes **149–204% more time than C** and **91–99% more
than Rust**. This establishes an application gap, not its cause or a language-wide
overhead. The short AMD case has a persistent difference between identical
images: 2.89% and 3.90%. Neither result is discarded, and equal code does not
make these timing labels interchangeable. No diagnosis is inferred from binaries.

All four sessions have the same managed counts. These include allocation after
constant initialization through cleanup, but exclude raw buffers, stacks and
allocator metadata. Requested bytes, managed charge and process RSS measure
different things; they cannot be subtracted to identify a particular cost.

| Words | Allocation requests | Requested bytes | Retains | Peak managed charge | Final charge |
|---|---:|---:|---:|---:|---:|
| 4,096 | 14,153 | 463,856 | 4,362 | 341,617 | 0 |
| 65,536 | 225,937 | 7,420,304 | 69,642 | 5,465,713 | 0 |

Separate larger-input process RSS is 4.43–4.86 MB for C, 6.12–6.50 MB for Rust
and 7.35–7.91 MB for the two fwp labels. There is only one RSS observation per
label/input/session; this is not a statistical memory regression limit or a
proof about storage between operations. Six-platform repeated cleanup checks
remain part of [application acceptance](../application-acceptance.md).

| Image | ARM64 file / text bytes | AMD64 file / text bytes |
|---|---:|---:|
| C | 70,904 / 1,552 | 16,608 / 1,672 |
| Rust | 4,697,672 / 231,660 | 4,567,448 / 257,075 |
| fwp | 78,088 / 35,548 | 72,544 / 37,938 |

These are unstripped complete images; library/linker layout differs. fwp readonly
data is 2,000/1,784 bytes on ARM64/AMD64. GCC's largest reported fwp frame is
65,744/65,776 bytes, versus 112 bytes in the C peer. These are individual-function
estimates, not peak call-stack measurements; dynamically sized frames remain
marked in the raw reports. No corresponding Rust frame estimate was collected.

## Limits for the next word-frequency candidate

These limits apply only to these inputs, CPUs, compilers and timing boundary.
They are declared after baseline measurement and **before a candidate exists**.
They do not accept an optimization or change any D2/N1 requirement.

For an identical pair, use the larger of the ratio and its reciprocal. The
largest observed difference is 3.902% for 4,096 words and 0.380% for 65,536 words.
Rounded control limits of 5% and 1% leave modest room beyond those observations;
minimum useful speed claims are larger than the corresponding observed variation.
Four sessions do not establish a confidence bound for all future runners.

| Input | Identical-copy ratio limit | Candidate / reference regression limit | Minimum reduction for a speed claim |
|---|---:|---:|---:|
| 4,096 words / 64 distinct | 1.05 | 1.05 | 10% (ratio ≤0.90) |
| 65,536 words / 1,024 distinct | 1.01 | 1.01 | 5% (ratio ≤0.95) |

Require two qualified sessions per architecture, every declared sample and output,
and passing reference/candidate copy controls in each session. Do not average
away a failed session. A large-input optimization must meet its 5% gain in all
four sessions while preserving the small-input regression limit; a small-input
speed claim separately needs 10%. If controls exceed their limit, the comparison
is inconclusive: retain it and investigate, without an unchanged rerun or a reset.

Managed requests, requested bytes, retains and peak charge may not exceed the
baseline table; final charge must remain zero. An allocation-reduction claim
must identify strictly lower requests/bytes. Keep ordinary versus instrumented
execution separate, and retain code, readonly-data, stack and RSS changes.
Before implementation, the candidate's own protocol must name its source change,
paired reference, execution schedule and acceptable code/stack tradeoff. No
candidate protocol or speed improvement is supplied by this baseline alone.

`check-current-wordfreq.py` independently reconstructs the ASCII result, fixed
schedule, round medians and ratios. `test-current-wordfreq-evidence.py` uses real
saved evidence to reject missing processes, wrong output, failed/timed-out work,
changed order or binary, invented statistics and retained managed storage—even
when modified file hashes are made consistent. These checks do not run fwp again.

To check one retained session without compiling or running a benchmark:

```sh
python3 scripts/local-guard.py python3 scripts/check-current-wordfreq.py \
  --retained-index docs/measurements/wordfreq-current-artifacts-2026-10-30.json \
  --source dc963bb500748dabe393dfaed20f92a333f5996e \
  --machine aarch64 --session 1 --output /tmp/wordfreq-audit.json
```

`aarch64` selects ARM64; `x86_64` selects AMD64. Sessions 1 and 2 are independent
runner allocations. The output is an audit summary; the stored measurements are
unchanged. Documentation CI checks both sessions on both architectures, including
all saved native-image bytes and complete job/rejection logs.
