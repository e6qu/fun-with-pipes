# Where the small-matrix copy mismatch appears

This is a descriptive analysis of the four retained November 2 matrix sessions,
not a new benchmark or acceptance rule. It uses all 4,608 measured processes per
role and all five samples per process. Each sample contains eight matrix products;
its `kernelNs` timer covers calculation only.

[The complete summary](matrix-sample-positions-2026-11-02.json) records all roles,
architectures, sample positions, round copy ratios and original failed limits.
Regenerate it with `scripts/summarize-kernel-samples.py`, explicitly selecting
`matrix-65-67-63` and `matrix-columns-2026-11-02/`. Report hashes are checked
against the independently audited index before reading samples.

In AMD64 session 2, byte-identical copies differ mainly in early sample positions:

| Program | First sample median, ms | Second sample median, ms | Fifth sample median, ms |
|---|---:|---:|---:|
| Paired fwp | 0.9512 | 1.2392 | 0.8301 |
| Its identical copy | 0.8512 | 0.8346 | 0.8281 |
| Scalar reference | 1.4733 | 1.6192 | 1.1389 |
| Its identical copy | 1.1634 | 1.1524 | 1.1353 |

Each entry is the median for that position across processes, not a ratio from
paired samples or a replacement for the original median-round statistic. The
paired/copy round totals differ by 4.8–7.8% throughout all 18 rounds in session 2.
The process-total distributions are broad: the paired fwp 10th–90th percentile
is 4.11–6.62 ms, compared with 3.44–3.57 ms for C. Session 1's copy differences
vary more across rounds; both sessions remain in the summary.

This points to a within-process startup/warmup question; it does **not** establish
CPU frequency, page placement, caches or any particular allocator operation as
the cause. No samples are discarded. Keeping only the fifth sample would change
the experiment after seeing its outcome and would not settle the original limit.
Earlier [CPU-affinity and address observations](timing-variation.md#what-the-diagnostic-establishes)
already reject those measured factors as sufficient explanations for older runs.

Before another timing experiment, declare a diagnostic that observes setup and
per-process sample progression on the same preserved programs. It must separate
measurement overhead from numerical work, keep every output/storage check, and
state which earlier hypothesis it tests. Do not increase process counts again or
repeat unchanged runs to obtain a pass. The six small-AMD64 controls stay open.
