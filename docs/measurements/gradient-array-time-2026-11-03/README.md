# Gradient-array runtime comparison

**Status:** measurements in progress; no timing result is accepted yet.
Both compilers come from `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`, retained by
`roadmap/gradient-array-measurement-2026-11-03`. The reference removes only the
complete gradient-array change. [Native checks and allocation results](../gradient-array-storage-2026-11-03/README.md)
pass on both architectures before timing.

Each sample runs complete equivalent Rosenbrock solves, including process launch,
output and cleanup. The [contract](../gradient-array-storage.md) fixes six input
sizes, current/history outputs, two sessions per architecture, identical-copy
controls and the original timing/memory limits. C/Rust explicit derivatives are
separate algorithm comparisons, not isolated language overhead.

The original four-session run is [41629714632](https://github.com/e6qu/fun-with-pipes/actions/runs/41629714632).
Both ARM64 sessions and AMD64 session 2 qualified and are measuring. AMD64 session 1
has needed replacement hosts:

| Attempt/run | Host | Outcome |
|---|---|---|
| 41629714632 / 125895890311 | EPYC 9V74 | Rejected before building/timing |
| 41630230085 / 125897628367 | EPYC 9V74 | Rejected before building/timing |
| 41630692989 / 125899210881 | EPYC 9V45 | Rejected before building/timing |
| [41631438916](https://github.com/e6qu/fun-with-pipes/actions/runs/41631438916) | Pending | Requested only AMD64 session 1 |

The contract requires EPYC 7763. These rejected jobs collected no timing samples;
replacement jobs keep the same frozen source and limits. Records retain each
host, job and full log:

- Attempt 1: [host](rejected-amd64-session1/host.json), [job](rejected-amd64-session1/job.json), [log](rejected-amd64-session1/job.log.gz).
- Attempt 2: [host](rejected-amd64-session1-attempt2/host.json), [job](rejected-amd64-session1-attempt2/job.json), [log](rejected-amd64-session1-attempt2/job.log.gz).
- Attempt 3: [host](rejected-amd64-session1-attempt3/host.json), [job](rejected-amd64-session1-attempt3/job.json), [log](rejected-amd64-session1-attempt3/job.log.gz).

An audit-only defect was found before collecting timing reports: Git and Python
can format the same multi-file source change with different hunk boundaries.
The corrected checker applies each saved patch and verifies the exact seven
resulting files, rejecting extra files or changed contents. A regression test
uses the real Git-generated patch. The measured compiler/driver stay frozen.
