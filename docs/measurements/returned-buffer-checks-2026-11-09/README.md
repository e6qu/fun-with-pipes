# Returned-buffer verification

**The first run failed; the repair is awaiting verification.** No timing samples
or completed four-language native result are claimed. The
[comparison scope](../ownership-peers.md#returned-buffer-preparation) explains
the live arrays, separate factory/caller and surviving-owner reads.

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
