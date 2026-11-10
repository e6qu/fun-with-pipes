# Service memory: initial host-environment diagnostic

**All observation controls pass, but this run does not match the original library
environment. It does not explain or replace the four original RSS misses.**

[Run 42810648965](https://github.com/e6qu/fun-with-pipes/actions/runs/42810648965)
uses observer `4eeb669925ccc2ec8b471da912f4147a742984fd` and the unchanged service
executables from `d80357c8c81d206c9d9934b141b5a5fafe97c430`.
The [protocol and environment correction](../nested-resource-rss.md) record why
its host-library observations must be kept separate from the container experiment.

## Work and observations

Each architecture runs all eight delivery/cancellation/expiration/error cases
in four balanced rounds, with reference/candidate binaries and identical copies:
128 processes per host. Every 50 ms, the observer stops its own child, reads its
memory mappings and counters, then resumes it. No timing claim is made.

| Host | Snapshots | Small-case resident peak range, KiB: old → new | Large-case range, KiB: old → new |
|---|---:|---|---|
| ARM Neoverse N2 | 3,097 | 2,124–2,140 → 2,104–2,120 | 3,152–3,204 → 3,132–3,184 |
| Intel Xeon Platinum 8573C | 3,382 | 2,496–2,512 → 2,452–2,484 | 3,524–3,576 → 3,496–3,548 |

These ranges include all cases, rounds and copies; [analysis.json](analysis.json)
keeps each case separate. Candidate peaks are lower in every case. The executable
category drops by 16 KiB on ARM64 and 24 KiB on AMD64; other mappings mostly drop
by 4 KiB. Stack readings vary by one page. Other file mappings are normally stable;
one AMD64 candidate expiration observation has 16 KiB fewer file-backed pages.

- Fast RSS and page-walk RSS agree in every recorded snapshot. Counter inaccuracy
  is **not demonstrated** by this run.
- Both hosts use Linux `7.0.0-1017-azure`, 4 KiB pages and host libraries. The original
  timing/RSS run used the Swift container; identical executable files do not imply
  identical shared libraries or loaded pages.
- `wait4` reports 25–84 MiB across executions, far above the stopped fwp process.
  Its total includes pre-exec memory inherited from the Python observer. Linux
  retains resource usage across `exec`; these totals are not fwp-only RSS.
  [Accounting semantics](https://man7.org/linux/man-pages/man2/getrusage.2.html).
  The original comparison uses GNU `time` to launch fwp; this observer-specific
  issue does not explain its four missed limits.
- Stopped snapshots are not exact transient peaks. No unchanged elapsed-time
  experiment was repeated and no original acceptance limit changed.

## Verification and retained files

Both native jobs pass four observer tests, eleven mapping-reader tests, the actual
16 MiB touch/unmap controls, all service outputs and full raw-snapshot audits.
All three altered-report controls are rejected. Complete logs contain no unexpected
failure or compiler warning.

| Architecture | Job | Full native artifact |
|---|---|---|
| ARM64 | `129810920134` | `13762750285`, 8,058,108 bytes |
| AMD64 | `129810919952` | `13761704621`, 9,813,217 bytes |

The small report ZIPs retain all 128-row audit summaries, controls, archive member
lists, one complete observation with its first raw snapshot, and a 16 KiB metadata
prefix. Complete downloaded members passed CRC checks; the partial metadata prefix
has no whole-member CRC claim. Full native archives remain on GitHub; their whole
archive digests were not recomputed locally.

`review-summaries.py` independently checks row coverage, derives ranges and rebuilds
the retained raw snapshot. Both hosts pass. It does not repeat the runner's audit
of all raw snapshots or executable files. Run it from the repository root with
`PYTHONPATH=scripts`, explicit `--input`, `--output` and `--identity prefix`.
