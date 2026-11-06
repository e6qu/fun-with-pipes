# Capacity checks: all three hosts pass

[Focused run 42177517863](https://github.com/e6qu/fun-with-pipes/actions/runs/42177517863)
at `51edfc0e7884e1a75201bc9876fd13cb8ca25eee` passes on Linux ARM64 and AMD64
with GCC, and macOS ARM64 with Clang. Each host passes formatting/lint and all
25 native targets, supplying 864 native images and 880 observations.

The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42179352168)
checks every target log, compiler diagnostic, image header and observation.
It reports no issue. The retained archive digest, all job/record hashes and
per-target results were independently checked before measurements began.

This verifies the corrected source after the
[initial formatting failure](../recording-capacity-initial-2026-11-06/README.md).
It does not establish performance or replace the final nine-platform gate.

[Summary](summary.json), [artifact](artifact.json), `audit.zip`,
[audit job](audit-job.json) and [complete audit log](audit-job.log.gz) retain
all results. The [contract](../recording-capacity.md) defines the measured change.
