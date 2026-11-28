# GNU-time peaks and actual terminal residency disagree

**GNU time reports less than the same child's terminal resident memory in 254
of 256 traced service executions.** Ordinary identical binaries also differ
by more than 5% in 42 of 128 copy comparisons. These observations establish a
measurement limitation for this experiment; they do not recover or clear the
[four original RSS misses](../resource-value-costs-2026-11-27/README.md).
No compiler or application runtime change follows from these results.

[Native run `46161194256`](https://github.com/e6qu/fun-with-pipes/actions/runs/46161194256)
passes both architectures at observer source
`afe192e806dbbac0a1cba1dfcbcd2641e16f1c47`, retained by
`roadmap/exec-memory-workers-2026-11-28`. The
[fixed protocol](../executable-rss-accounting.md) records the initial failed
single-thread assumption and its verified worker-tracking repair.

## What the readings mean

GNU time's `%M` is its reaped child's `wait4` high-water RSS. `VmHWM` is the
address space's high-water counter in `/proc/PID/status`. A `smaps` page walk
counts pages resident at the stopped snapshot; it does not recover previous
peaks. The observer traces GNU time and its child, records worker creation/exit,
and holds the terminal process stop until the worker has been reaped. It then
reads the same process's counters and mappings before kernel teardown.

Every GNU-time result exactly matches the observer's independent `wait4` receipt
for that child. Terminal `VmRSS` equals the raw page-walk total in all 256 traced
executions. Yet the high-water value returned by `wait4` is usually smaller than
the pages resident at that stop:

| Native host | Traced executions below terminal page residency | GNU time minus terminal `VmHWM`, KiB | GNU time minus terminal page residency, KiB |
|---|---:|---:|---:|
| ARM64, Neoverse-N2 | 128 / 128 | −440 to −88 | −440 to −88 |
| AMD64, EPYC 7763 | 126 / 128 | −456 to 0 | −456 to +8 |

All service processes create one worker. The timed child's pre-exec high-water
is only 84–88 KiB on ARM64 and 96–100 KiB on AMD64. The GNU-time parent has its
own separate usage receipt; it is never substituted for the service child's
memory. Thus the previous Python-parent inheritance issue is not used to explain
these lower child readings.

Both hosts use Linux `7.0.0-1020-azure`, 4 KiB pages, the original Swift container
digest `sha256:97b9d09f1e922ee794067ea8eec4874083c97d2d5027a6a409e398d82ebca016`
and libc `2.39-0ubuntu8.12`. These are separate jobs from the original experiment.
GNU Time's version string is `UNKNOWN`; its actual executable SHA-256 is retained.
GCC versions and exact O2/no-LTO/architecture commands for the observation
controls are retained. The fwp service binaries are not rebuilt.

### A kernel mechanism consistent with the observations

Upstream Linux v7.0's
[status reader](https://github.com/torvalds/linux/blob/v7.0/fs/proc/task_mmu.c)
sums the per-CPU resident counters when reporting `VmRSS` and the current-RSS
component of `VmHWM`. Its
[high-water helper](https://github.com/torvalds/linux/blob/v7.0/include/linux/mm.h)
instead uses the faster counter read. The
[exit accounting](https://github.com/torvalds/linux/blob/v7.0/kernel/exit.c)
and [resource-usage reader](https://github.com/torvalds/linux/blob/v7.0/kernel/sys.c)
use that helper. This is a source-based explanation consistent with the observed
disagreement. The exact vendor kernel source/configuration was not reconstructed;
it is not proof of the cause of each original missed comparison.

## Untraced copies and observation effects

The experiment reuses exact reference/candidate executables and identical copies
from source `33149ad2fd888a66ff36b8eb7f2c5b61faccfccb`, ordinary run `46067853489`.
Every call constructs 64 or 4,096 messages with 16-integer payloads and exercises
delivery, cancellation, expiration or a handled error. Original C-only pilot
batch counts and output checks remain unchanged.

Each architecture runs four balanced rounds of four binary labels across eight
cases, with one ordinary and one traced execution per label/round/case. Which
path runs first alternates by round. All 256 executions per host are retained;
none is selected or repeated based on its result. Timing output is retained only
to check the existing program output, not to claim speed or timing acceptance.

| Host | Ordinary identical-copy/original RSS ratio | Copy pairs differing by over 5% | Traced/ordinary RSS ratio |
|---|---:|---:|---:|
| ARM64 | 0.86639–1.15422 | 16 / 64 | 0.86100–1.16145 |
| AMD64 | 0.88183–1.14943 | 26 / 64 | 0.86828–1.17505 |

The copy-pair count uses larger/smaller > 1.05 and includes both implementations.
It is descriptive, not a newly substituted acceptance gate. Tracing, lifecycle
stops and executable-identity reads can change scheduling and page-cache state;
the ordinary path and all traced/ordinary ratios expose that effect. The traced
results do not stand in for an unobserved ordinary process's exact peak.

For the four case types with original misses, terminal page-resident ranges are:

| Case | Reference, KiB | Candidate, KiB |
|---|---:|---:|
| ARM64, 4,096 messages, cancellation | 3,164–3,168 | 3,156–3,160 |
| AMD64, 64 messages, full delivery | 2,420–2,484 | 2,404–2,480 |
| AMD64, 64 messages, expired target | 2,428–2,472 | 2,412–2,448 |
| AMD64, 64 messages, handled error | 2,440–2,488 | 2,408–2,476 |

These ranges include every round and identical copy. They describe terminal
residency, not a bound on maximum working memory. Managed allocation counts and
physical release evidence remain the separate #279 measurements.

## Native controls and reproducibility

All eleven lifecycle/failure tests pass in each original-image job. They cover
signal delivery, deadlines, extra-process rejection, snapshot failure, worker
joining and exit-notification ordering. Every failure path terminates and reaps
its tracees. Five altered-record controls reject changed raw counters (with a
refreshed hash), process identity, wait usage, GNU-time output and executable hash.

Three additional native controls are retained in full:

| Control | ARM64 GNU time / terminal HWM / terminal pages, KiB | AMD64 GNU time / terminal HWM / terminal pages, KiB |
|---|---:|---:|
| Touch 32 MiB, then unmap | 34,028 / 34,028 / 1,476 | 34,232 / 34,232 / 1,648 |
| Reserve without touching | 1,388 / 1,476 / 1,476 | 1,544 / 1,644 / 1,644 |
| Touch 32 MiB, then exec `/bin/true` | 34,080 / 1,032 / 1,032 | 34,312 / 1,364 / 1,364 |

The first preserves a real transient peak after unmapping; the second rejects
the missing-touch variant and also shows a lower GNU-time reading without fwp;
the third distinguishes whole-child usage from a replacement address space.

Runner export [46161831161](https://github.com/e6qu/fun-with-pipes/actions/runs/46161831161)
checks original source/artifact sizes, SHA-256 and ZIP members, then reconstructs
both the full and filtered text archives. [The reader](read.py) reconstructs
every retained raw observation, schedule and control, and reruns the five actual
altered-record controls without native-image downloads. Job logs and original
run/artifact/job metadata are retained; metadata is losslessly gzip-compressed.

The four original 5% limits stay open. A future memory contract needs a qualified
measurement mechanism that distinguishes resident snapshots, transient peaks,
managed storage and observer effects. These records justify that work; they do
not justify a runtime fix or a relaxed historical threshold.
