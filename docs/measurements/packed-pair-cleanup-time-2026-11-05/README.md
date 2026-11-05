# Pair reuse after the cleanup repair: runtime results

**Storage and stack checks pass; timing targets remain open.** All four qualified
sessions finish. None of the 32 long-case results reaches the required 5% gain.
AMD64 also exceeds the 2% small-case limit twice: session 1 one-update current
is 2.8315% slower; session 2 zero-update current is 2.2158% slower.

Output, ownership counts, cleanup, raw storage, reported frame limits and
identical-executable copy controls pass in all sessions. Keep the verified
reductions under the agreed policy; these 34 timing misses are not passing
results. No measured session was rerun or omitted.

## Compared work and timer

Frozen source `373955e82a74d8de2eb12ff2b81f6cc74c089e5e`. The allocating reference
disables only private pair reuse. Both retain the single-owner repair and record
and reverse the same derivatives. Ratios below isolate this storage choice
within fwp; they are not comparisons with an older released compiler.

“3-199” means three coordinates and 199 updates. “Current” returns final
coordinates; “history” requests successive vectors and takes the last, allowing
unused history to be removed. Every solve starts from the same values.

- Two warmups, then 98 balanced rounds; seven fresh processes per sample.
- Solves/process: 3-0 = 32,768; 3-1 = 512; 3-199 = 32; 3-1999 = 4;
  33-199 = 32; 129-199 = 8.
- Timing includes process launch, complete solves, printing every result and
  teardown. Compilation, observers, output checking and sample storage are outside
  the timed interval. Zero-update cases still construct and print their values.
- Native EPYC 7763 / Neoverse-N2, GCC O2, checked arithmetic, no fast math,
  no floating-point contraction or LTO, explicit x86-64 / armv8-a targets.
  Reports retain exact compiler versions and commands.

## Reuse versus allocating reference

Ratios are reuse / reference: 0.9600 means 4% less elapsed time. Long cases
require at most 0.9500; small cases at most 1.0200. Copy variation must stay
within 2%; it does in every session.

| Case / form | ARM1 | ARM2 | AMD1 | AMD2 |
|---|---:|---:|---:|---:|
| 3-0 current | 1.0044 | 1.0037 | 1.0075 | 1.0222 |
| 3-0 history | 1.0010 | 1.0006 | 0.9935 | 0.9956 |
| 3-1 current | 0.9909 | 0.9882 | 1.0283 | 1.0190 |
| 3-1 history | 0.9985 | 1.0007 | 0.9757 | 1.0061 |
| 3-199 current | 0.9655 | 0.9660 | 0.9945 | 0.9663 |
| 3-199 history | 0.9679 | 0.9677 | 0.9797 | 0.9932 |
| 3-1999 current | 0.9676 | 0.9722 | 0.9637 | 0.9528 |
| 3-1999 history | 0.9651 | 0.9619 | 0.9816 | 0.9750 |
| 33-199 current | 0.9958 | 0.9956 | 0.9964 | 1.0004 |
| 33-199 history | 0.9978 | 0.9979 | 1.0028 | 0.9919 |
| 129-199 current | 0.9972 | 0.9975 | 0.9953 | 0.9916 |
| 129-199 history | 0.9993 | 0.9993 | 0.9940 | 0.9982 |

## Memory and generated code

The [independent allocation census](../packed-pair-cleanup-census-2026-11-05/README.md)
verifies 727 -> 528 requests and 9,248 -> 7,200 peak charged bytes for a fresh
129/199 solve. Final managed/raw storage is zero. These figures measure runtime
value storage, not all memory used by the process.

Across all runtime cases/forms/sessions, measured process RSS ratios span
0.8719–1.2268. RSS includes runtime, allocator and OS costs and is sampled separately
from timing. These mixed observations do not establish a general RAM reduction.

The previously failing AMD64 33/199 current frame is 720 bytes, equal to the
reference (first implementation: 928; permitted: 848). All reported frame limits
pass. [GCC's dynamic entries](../packed-pair-cleanup-repair.md#what-the-stack-comparison-establishes)
remain explicit; reported frame bytes do not bound total call-stack use.

For 129/199 current, reference -> reuse:

| Host | Instruction bytes | Executable file bytes |
|---|---:|---:|
| ARM64 | 41,500 -> 41,308 | 143,560 -> 143,544 |
| AMD64 | 42,946 -> 43,218 | 84,728 -> 84,672 |

Smaller files do not necessarily mean fewer instructions or faster execution.
Every program's code, stack, raw storage and phase records remain in the reports.

## C/Rust comparison: substantial work remains

The C/Rust peers use handwritten derivatives and two reusable contiguous buffers.
fwp records and reverses operations. All solve the same problem and match the
checked outputs, but their derivative algorithms and storage work differ.
These ratios are complete-implementation costs, not isolated language/ARC overhead.

For 129 coordinates / 199 updates, current form: each timed sample contains
seven processes × eight solves = **56 complete solves**. Milliseconds below
are per sample, not per process or per solve.

| Session | fwp sample ms | C sample ms | Rust sample ms | fwp / C | fwp / Rust |
|---|---:|---:|---:|---:|---:|
| ARM1 | 156.751 | 11.950 | 12.108 | 13.12× | 12.95× |
| ARM2 | 157.191 | 12.149 | 12.256 | 12.94× | 12.83× |
| AMD1 | 200.019 | 11.177 | 11.824 | 17.90× | 16.92× |
| AMD2 | 199.647 | 10.499 | 11.321 | 19.02× | 17.64× |

## Where to investigate next

Each eight-solve process records 1,630,208 derivative nodes across 1,592 updates.
Separate diagnostic executions time the solver stages: two warmups and 12
samples, alternating instrumented/ordinary programs. Shares below sum recorded
stage nanoseconds across diagnostic samples; they exclude work outside those
stages and are **not** shares of the ordinary end-to-end timing above.

| Session | Objective evaluation plus recording | Reverse traversal |
|---|---:|---:|
| ARM1 | 73.1% | 23.0% |
| ARM2 | 73.1% | 23.0% |
| AMD1 | 74.8% | 21.0% |
| AMD2 | 74.8% | 21.1% |

Recording time includes objective arithmetic and recording operations, not just
allocation. Investigate that source path and its work counts before assuming
another small allocation reduction can close the C/Rust gap. The
[remaining allocation sizes and lifetime constraints](../packed-pair-cleanup-census-2026-11-05/README.md#remaining-storage-and-its-constraints)
provide a separate memory-work list. Neither table establishes a new optimization.

## Retained outcomes

| Measured sessions | Measurement run | Full artifact audit | Saved records |
|---|---|---|---|
| ARM1, AMD2; two rejected hosts | [42018849842](https://github.com/e6qu/fun-with-pipes/actions/runs/42018849842) | [42021767931](https://github.com/e6qu/fun-with-pipes/actions/runs/42021767931) | [initial index](initial/index.json.gz) |
| ARM2 | [42020017429](https://github.com/e6qu/fun-with-pipes/actions/runs/42020017429) | [42022105422](https://github.com/e6qu/fun-with-pipes/actions/runs/42022105422) | [ARM2 index](arm2/index.json.gz) |
| AMD1 | [42020313941](https://github.com/e6qu/fun-with-pipes/actions/runs/42020313941) | [42023850878](https://github.com/e6qu/fun-with-pipes/actions/runs/42023850878) | [AMD1 index](amd1/index.json.gz) |

Each directory keeps compressed reports, complete logs, per-file hashes and
artifact identities. Large C/native archives remain in the digest-identified
retention artifacts. Audits passing establishes faithful evidence, not passing
timing. [Rejected-host records](rejected-hosts/index.json) retain four CPU
mismatches, including two replacement requests; every build/timing step was
skipped. Qualified replacements measured once. The
[first implementation's failures](../packed-pair-time-2026-11-05/README.md)
remain separate and unchanged. [Final production and delivery](../packed-pair-delivery-2026-11-05/README.md)
are verified; PR #260 is merged.
