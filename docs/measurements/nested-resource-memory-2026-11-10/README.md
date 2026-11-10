# Service memory: page readings in the original container

**The candidate has lower observed resident-page peaks in every case on both
architectures. The four original process-RSS misses remain unexplained and open.**
These observations do not replace the original high-water measurements or establish
an exact transient peak. No timing experiment was repeated.

[Run 42812351743](https://github.com/e6qu/fun-with-pipes/actions/runs/42812351743)
uses observer `94882ca7c860771ee9106211fc2567789c187070` and the unchanged reference,
candidate and identical-copy executables from ordinary run `42798403679` at
`d80357c8c81d206c9d9934b141b5a5fafe97c430`.

## What was measured

The [fixed protocol](../nested-resource-rss.md) covers 64 and 4,096 messages with
delivery, cancellation, expiration and handled errors: four balanced rounds of
four binaries for every case, or 128 processes per architecture. Every 50 ms, the
observer stops its own child, reads its mappings and counters, then resumes it.

This corrects the [first diagnostic's environment mismatch](../nested-resource-host-memory-2026-11-10/README.md):

- Original Swift image digest:
  `sha256:bca121f6eb59fd80340d1296887b2698ed8f3eb9eca7d80c181f8af769dc7ee0`.
- Original libc package: `2.39-0ubuntu8.9`, explicitly checked.
- ARM Neoverse N2 and AMD EPYC 9V74; Linux `7.0.0-1017-azure`, 4 KiB pages.
- Original executable bytes, architecture and archive hashes verified on runners;
  no compiler build or change to fwp executable files.

## Results

Ranges cover all rounds and identical copies. Values are the largest page-resident
readings observed during each process, in KiB. They are not allocator totals.

| Messages / case | ARM64 reference | ARM64 candidate | AMD64 reference | AMD64 candidate |
|---|---:|---:|---:|---:|
| 64 / delivered | 2,136–2,140 | 2,116–2,120 | 2,464–2,532 | 2,440–2,504 |
| 64 / cancelled | 2,136 | 2,116 | 2,480–2,512 | 2,436–2,504 |
| 64 / expired | 2,124–2,128 | 2,104 | 2,468–2,520 | 2,424–2,488 |
| 64 / handled error | 2,136 | 2,116–2,120 | 2,464–2,512 | 2,452–2,488 |
| 4,096 / delivered | 3,200 | 3,180–3,184 | 3,532–3,592 | 3,500–3,536 |
| 4,096 / cancelled | 3,200–3,204 | 3,180 | 3,532–3,596 | 3,500–3,552 |
| 4,096 / expired | 3,152 | 3,132 | 3,496–3,532 | 3,468–3,488 |
| 4,096 / handled error | 3,200 | 3,180 | 3,548–3,580 | 3,504–3,564 |

ARM64 has 3,093 snapshots; AMD64 has 2,662. Fast RSS equals page-walk RSS in every
snapshot. Thus this diagnostic does **not** demonstrate the suspected counter
inaccuracy. The original processes were not sampled this way, so their missed
high-water limits cannot be assigned a cause from these observations.

The category readings explain the current snapshots:

- Executable residency drops by 16 KiB on ARM64 and 24 KiB on AMD64.
- Other mappings drop by 4 KiB per case. The mapped `[heap]` category stays at 8 KiB;
  it excludes allocations served from separate mappings.
- Stack residency varies by one 4 KiB page. ARM64 other-file residency stays at
  1,832 KiB; AMD64 varies with mapped file pages. Keep this variation separate
  from the [unchanged allocation requests and charged heap](../nested-resource-counts-2026-11-10/README.md).

The observer's `wait4` totals include pre-exec memory inherited from Python. An
actual allocate-then-exec control verifies that scope; those totals are not used
as fwp-only memory. Linux preserves usage across `exec`.
[Accounting semantics](https://man7.org/linux/man-pages/man2/getrusage.2.html).
The original comparison used GNU `time`; this observer issue does not explain
its misses. No compiler repair or relaxed memory limit is justified by these data.

## Verification and retained evidence

Both hosts pass five observer tests, eleven mapping-reader tests, real omitted-touch
and omitted-unmap controls, all 128 service outputs and complete snapshot audits.
Three altered reports are rejected even after their hashes are updated. Both
complete job logs contain no unexpected failure or compiler warning.

| Architecture | Job | Full native artifact |
|---|---|---|
| ARM64 | `129816709586` | `13763621490`, 7,987,536 bytes |
| AMD64 | `129816709062` | `13764106652`, 7,795,078 bytes |

The retained report ZIPs contain all case summaries, identity/settings, controls
and one observation with its first complete raw snapshot per host. Each downloaded
member passes CRC verification. Full archives and all raw snapshots remain on
GitHub; their whole-archive digests were not recomputed locally.

`review-summaries.py` checks coverage, computes every range and reconstructs the
retained raw snapshot. Both hosts pass; full raw-data and executable audits ran on
GitHub. From the repository root, use `PYTHONPATH=scripts`, explicit `--input`,
`--output` and `--identity complete`. [analysis.json](analysis.json) retains every
case and all measurement scope limits.
