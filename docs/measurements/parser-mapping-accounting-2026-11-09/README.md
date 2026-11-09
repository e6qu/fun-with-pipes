# Reserved address space, accounting flags and resident pages

Both native Linux hosts pass four O1/O2 observations and eight actual
omitted-touch/unmap controls. Their existing overcommit policy was **mode 0**;
no host settings were changed. The control creates one named 16 MiB mapping.

| Stage | Ordinary: accountable extent | No-reservation extent | RSS, both variants |
|---|---:|---:|---:|
| Before mapping | 0 | 0 | 0 |
| Inaccessible reservation | 0 | 16 MiB (`nr`) | 0 |
| Enable writes | 16 MiB (`ac`) | 16 MiB (`nr`, no `ac`) | 0 |
| Touch every page | 16 MiB (`ac`) | 16 MiB (`nr`, no `ac`) | 16 MiB |
| Unmap | 0 | 0 | 0 |

These columns describe the control's mapping, not total process memory.
**Accountable extent is not resident or guaranteed RAM.** The observer separately
records system-wide `CommitLimit` and `Committed_AS`; changes in those quantities
cannot be attributed to this process on a shared runner. The [protocol](../parser-internal-memory.md)
links the kernel definitions and keeps application to real parser checkpoints open.

Source `3c214f136`, tag `roadmap/parser-accounting-controls-2026-11-09`:

| Native job | Artifact | Result |
|---|---|---|
| [AMD64 129331981618](https://github.com/e6qu/fun-with-pipes/actions/runs/42666647306/job/129331981618) | `13697990396` | Four observations, eight real fault controls pass |
| [ARM64 129331981260](https://github.com/e6qu/fun-with-pipes/actions/runs/42666647306/job/129331981260) | `13697820590` | Four observations, eight real fault controls pass |

Both Linux jobs execute the ten mapping/child-cleanup tests and two accounting
reader tests. The latter also reject misclassified flags despite correct mapping
sizes and RSS. [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42666658591)
passes. Both complete native logs contain no compiler warnings or errors.

Every downloaded source, native control and snapshot matches its artifact manifest.
The ordinary observations and expected fault rejections reconstruct from all raw
mapping and policy files. The two `*-evidence.tar.gz` archives preserve those files,
commands, native binaries and manifests. [files.json](files.json) records compressed
and original hashes. Kernel modes 1/2 have reader controls but were not exercised
by changing these hosts' policy.
