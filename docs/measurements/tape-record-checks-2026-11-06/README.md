# Tape records: focused correctness

[Run 42290415866](https://github.com/e6qu/fun-with-pipes/actions/runs/42290415866)
tests source `b4b291e3184cae5046d7a1eba27e777c67b1884a`.

| Host | Job | Result |
|---|---|---|
| Linux AMD64, GCC | `128142085029` | Pass |
| Linux ARM64, GCC | `128142085462` | Pass, including real wasm32 allocation bounds |
| macOS ARM64, Clang | `128142085304` | Pass |

Each host passes 305 compiler tests, all ten native targets, formatting, lint
and the primitive inventory; Linux also runs the allocation/output controls. Four existing unit tests
are separate compiler measurements; their names and reasons remain in the logs.
They are not claimed as executed here. No unexpected diagnostics occur in any
complete job log. [Log hashes and source identities](logs.json) are retained
alongside the compressed logs and GitHub job records.

The [complete artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42319675956)
passes with [no issues](summary.json). It checks all source/file hashes, exact
target inventories, all 900 native executable headers, and 1,215 probe status
records. The four excluded unit measurements must match the declared set;
the actual wasm32 result must be present on ARM64.

The compressed `arm-audit.json.gz`, `amd-audit.json.gz` and `mac-audit.json.gz`
retain every file hash, image identity, target result and probe status.
[Artifact metadata](audit-artifact.json), [audit job](audit-job.json) and its
[complete log](audit-job.log.gz) identify the original 74,782,077-byte archive.
Its SHA-256 and all three report/job-log hashes pass local verification.
Large probe archives remain in the identified GitHub artifact.

The first audit attempt failed before jobs because a reusable workflow lacked
caller-granted `actions: read`. Explicit read-only permissions repaired that
failure; the passing replacement above ran the complete audit.
