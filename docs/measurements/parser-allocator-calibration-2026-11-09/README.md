# Allocator resize boundaries observed on both Linux hosts

Four controls pass with the installed glibc and matching debug symbols:

| Resize | Observed behavior |
|---|---|
| 64 → 72 bytes | Same allocation; original bytes preserved |
| 128 → 8,192 bytes | Replacement allocated before old storage is freed |
| 8,192 → 4,096 bytes | Shrinks in place; retained bytes preserved |
| 128 → `SIZE_MAX` | Fails with `ENOMEM`; original allocation remains usable |

The moving control observes 8,320 requested bytes alive together. This is **not**
allocator chunk extent, a parser peak, RSS or committed RAM. The observer records
actual allocation/free events, live arguments and return values; it does not read
released storage. Two reader tests reject missing/reordered events and mismatched
libc/debug identities. [Protocol and remaining work](../parser-internal-memory.md).

Source `0f8c2669b0f874ce38dcfbd2ff0a15d55b377ce0`, tag
`roadmap/parser-allocator-calibration-2026-11-09`:

| Native job | Artifact | Result |
|---|---|---|
| [AMD64 129312418213](https://github.com/e6qu/fun-with-pipes/actions/runs/42661050319/job/129312418213) | `13693889058` | Four controls pass |
| [ARM64 129312418586](https://github.com/e6qu/fun-with-pipes/actions/runs/42661050319/job/129312418586) | `13693899086` | Four controls pass |

Both use GCC 13.3, O2 without LTO, GDB 15.1 and glibc packages
`2.39-0ubuntu8.9`. The reports preserve loaded libc/debug build IDs and hashes of
the installed distro source archive and its allocator source. Downloaded reports
reconstruct from raw events and command journals. [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42661056292)
passes, including deliberate failed/hung runner controls.

The audit found **five GDB source-display warnings per host**: debug arguments were
available, but `./malloc/malloc.c` was not on GDB's source path. The prepared repair
extracts that source member, adds its directory and rejects debugger stderr.
Its native verification remains pending. The original warnings are retained;
passing exit codes do not mean a warning-free run.

[files.json](files.json) hashes compressed and original reports, events, command
journals and complete job logs. Parser observations, mapped/retry paths and commit
accounting remain open; these calibration results do not complete milestone 4.
