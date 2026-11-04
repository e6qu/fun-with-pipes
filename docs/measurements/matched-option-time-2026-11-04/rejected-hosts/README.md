# Hosts rejected before measurement

The frozen runtime comparison requires AMD EPYC 7763 for its AMD64 sessions.
These jobs received other CPUs and stopped before either compiler was built or
any program was timed. Replacing them does not repeat a completed measurement.

| Run | Session | CPU received |
|---|---|---|
| [41811658838](https://github.com/e6qu/fun-with-pipes/actions/runs/41811658838) | AMD64 1 | AMD EPYC 9V45 |
| [41813095015](https://github.com/e6qu/fun-with-pipes/actions/runs/41813095015) | AMD64 1 | Intel Xeon Platinum 8370C |
| [41813318807](https://github.com/e6qu/fun-with-pipes/actions/runs/41813318807) | AMD64 1 | AMD EPYC 9V45 |
| [41813530133](https://github.com/e6qu/fun-with-pipes/actions/runs/41813530133) | AMD64 1 | Intel Xeon Platinum 8573C |

Each run directory retains the full compressed log, host artifact and audit
record, including source, job, artifact identity and checksum. All use frozen
source `82963531dddb6d9a5f32ec26657dc220736f4055`. Audits verify that host
qualification is the only failed step and building/timing steps are skipped.

The [contract](../../matched-option-fields.md) keeps CPU qualification separate
from timing acceptance. The [native report](../../matched-option-fields-2026-11-04/README.md)
records completed correctness checks and links current measurement status.
