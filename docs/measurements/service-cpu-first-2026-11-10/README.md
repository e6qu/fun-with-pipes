# Service recordings retained; six stack reports rejected

Both native jobs in [run 42772697088](https://github.com/e6qu/fun-with-pipes/actions/runs/42772697088)
failed during stack decoding. Source `fac4a47440fb02667ddbf385dba959ae8f91a310`
is retained by `roadmap/service-cpu-observation-2026-11-10`.

| Host | Job | Artifact | Actual invocations with correct results |
|---|---|---|---|
| ARM64 | `129683968936` | `13743108949` | C 37, Rust 37, Swift 34, fwp 29 |
| AMD64 | `129683968550` | `13744145167` | C 36, Rust 36, Swift 34, fwp 28 |

These counts include correctness, calibration, ordinary and sampled calls. Every
retained service output matches its independent oracle, including calls followed
by decoder failure. Both hosts complete all 32 peer/case combinations. All C/Rust/
Swift profiles and fwp's expired-receiver profile decode. The other three fwp
profiles on each host fail with nonempty `addr2line` diagnostics; they are not
accepted attribution.

## Decode the saved records; do not measure again

The decoder reports misplaced end markers and subsequent unreadable records.
[Perf 6.8's GNU record parser](https://raw.githubusercontent.com/torvalds/linux/v6.8/tools/perf/util/srcline.c)
checks for an end marker after skipping the first two characters, even when the
line is an inline function name. Short names such as `f1`, and names ending only
in zeros after that prefix such as `f10`, can therefore be mistaken for end markers.
The same code supports LLVM's distinct comma marker.

The prepared repair explicitly selects LLVM addr2line and replays all original
recordings. It will retain a verbose GNU exchange to test this diagnosis against
the actual executable. No warning is ignored, program renamed, inline boundary
changed or workload rerun. Native verification of the repair is still pending.

[Hashes](files.json) cover both complete logs, the original summaries and all six
failed decoder diagnostics. [Artifact identities](artifacts.json) point to the
complete recordings, generated C, debug executables, source mappings and commands.
Selected local ZIP members passed CRC checks; the full archives remain on GitHub.
The package setup also reports a missing optional `g++` manual-page link; native
compiler commands complete successfully. The [protocol](../service-cpu-costs.md)
retains the sample accounting requirements and interpretation limits.
