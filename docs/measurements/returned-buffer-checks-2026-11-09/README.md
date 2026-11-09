# Returned-buffer verification

**Both native Linux architectures pass the repaired four-language checks.** No
performance timing samples are collected. The
[comparison scope](../ownership-peers.md#returned-buffer-preparation) explains
the live arrays, separate factory/caller and surviving-owner reads.

## Verified repair

[Run 42590570921](https://github.com/e6qu/fun-with-pipes/actions/runs/42590570921)
uses `9d8bbb79a8c087b3c63c98d05aa515975ba9bfd1`, retained by
`roadmap/returned-buffer-checks-2026-11-09`. Each host passes 48 builds and:

| Native check | Count per host |
|---|---:|
| Ordinary results, including reads after releasing another owner | 224 |
| Exact argument-error results | 224 |
| Deliberately incorrect scan rejected | 16 |
| Normal C/fwp release observations | 56 |
| Actual omitted C/fwp release rejected | 8 |
| **Total** | **528** |

The raw and optimized fwp interpreters also agree on all seven inputs: 14 checks.
C/Rust use O1/O2; Swift uses Onone/O. Each factory and caller compiles separately
without LTO. All 671 command records and both full job logs were reviewed; no
comparison group failed. The setup warnings concern an absent optional C++ manual
page, not a compiler diagnostic from these programs.

The C observer counts logical buffers after its release routine; fwp checks its
managed live-byte baseline. These are not native allocation/ARC-operation counts
or process RAM. Native Rust/Swift release observations and the
[phase measurement](../returned-buffer-phases.md) remain separate work.

[Accepted artifact identities](artifacts.json) accompany the reports and compressed
raw commands/logs. Only these small records were fetched and ZIP-CRC checked;
the full native archives remain on GitHub. No local full-archive hash verification
is claimed. Documentation run `42590575105`, job `129070910754`, passes at the
same source, including all 27 actual-workflow cancellation packaging cases.

## Original failure

[Run 42586120264](https://github.com/e6qu/fun-with-pipes/actions/runs/42586120264)
uses `348cc12f58a10559b13aefa96f8885d890cb445b`, retained by
`roadmap/returned-buffer-first-2026-11-09`. Both native Linux hosts reach the same
Swift error after the C/Rust groups and 14 raw/optimized fwp interpreter results:

- A `for value in values` loop consumes the array when creating its iterator.
  That is incompatible with an explicitly `borrowing` parameter here.
- Returning a borrowed array as a second owner needs `copy values`.

The repair reads through `values.indices` and explicitly copies the native Array
owner when creating an alias. It retains the borrowed reader contract and adds
no wrapper representation. The checker now records independent build-group
failures and continues before failing its final result; the first failure had
prevented native fwp from running at all.

Complete job logs and raw command records from both failed hosts are retained.
[Artifact identities](first-artifacts.json) record the full archive locations
and published digests. Selected command records were fetched with byte ranges
and ZIP CRC checks; the full archives were not downloaded or locally hashed.
