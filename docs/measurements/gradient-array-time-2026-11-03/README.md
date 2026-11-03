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

- [Initial four-session run](https://github.com/e6qu/fun-with-pipes/actions/runs/41629714632).
- [Replacement AMD64 session 1](https://github.com/e6qu/fun-with-pipes/actions/runs/41630230085).

The initial AMD64 session 1 received an EPYC 9V74 instead of the required EPYC
7763. Qualification rejected it before building or timing; no measured samples
exist. The replacement requests only that session on the same frozen source.
The [host record](rejected-amd64-session1/host.json),
[job steps](rejected-amd64-session1/job.json) and
[full log](rejected-amd64-session1/job.log.gz) retain the rejected attempt.

An audit-only defect was found before collecting timing reports: Git and Python
can format the same multi-file source change with different hunk boundaries.
The corrected checker applies each saved patch and verifies the exact seven
resulting files, rejecting extra files or changed contents. A regression test
uses the real Git-generated patch. The measured compiler/driver stay frozen.
