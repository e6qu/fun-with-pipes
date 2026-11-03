# Current work

**Next:** implement the [selected scalar map-to-zip buffer change](measurements/temporary-list-storage.md#selected-storage-change), including its same-source reference and semantic/cleanup controls. Census verification is complete. Keep implementation, grouped measurements, docs and final production gates in draft PR #250.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `temporary-list-storage`.
  The primary checkout is untouched.
- Base: verified PR #249 squash `46af240b8c540746b942b687b416cd52f6a91f9e`.
  Tested source `6ca3c41106d78f8251d3d59e3750470a3c270f68`, tag
  `roadmap/callback-owner-final-2026-11-03`; identical tree
  `ce8dab3adb4fca4643cd600286233ebf11d884bc`.
- Verified census source `c8e8a17ad7a68ef3235be4e5de59167589c55d4b`, run
  `41573569217`; production sources equal the verified #249 tree.
- Count baseline: [96 attributed observations](measurements/temporary-list-census-2026-11-03/verified-counts.json.gz).
  No dependency on an older fwp compiler or API is needed.
- Protocol anchors: `roadmap/temporary-list-protocol-2026-11-03` (census) and
  `roadmap/scalar-map-zip-protocol-2026-11-03` (selected implementation).

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve census controls and evidence |
| 2 | Contract frozen | Implement and verify the exact same-source reference switch |
| 3 | Next | Compiler selection, scalar buffer/zip generation, native semantic and cleanup controls |
| 4 | Pending | Grouped cost measurements, final platform gates and verified squash |

## Verified evidence and selected change

[Both native census jobs](measurements/temporary-list-census-2026-11-03/README.md)
pass: ARM64 `125711836846`, AMD64 `125711837155`; docs `125711765045` also passes.
The runner reconstructs instrumented C/site tables, hashes every archived file,
checks native images and recomputes counts. All 118 C compilation logs per host
and both full job logs are clean. All 96 observations preserve output, derivative
work, managed/raw counts and zero final storage; cross-host caller counts agree.

The largest solve creates 25,671 scaled-adjustment cells. The selected change
replaces its sole-use map result with a numeric buffer, then lets zip-with read
it directly. Expected saving: 25,870 allocations and 823,064 requested bytes per
129-coordinate/199-update solve. These are predictions, not measured savings.
Preserve full map-before-zip order, aliases, traps, cancellation and cleanup.
Keep prior timing failures open; preserve the 2%/5% limits in PLAN.md.

The original census attempt `41572713222` failed because an exit handler replaced
the invalid-site diagnostic's status. Both jobs were audited before repair.
Diagnostic failure now flushes stderr and uses `_Exit(234)`; the repaired native
controls pass. [Original raw evidence](measurements/temporary-list-census-2026-11-03/README.md#first-attempt-diagnostic-exit-status-repaired)
and source tag `roadmap/constructor-census-attempt-2026-11-03` are retained.

## Implementation preparation

No compiler change yet. Relevant code: `src/cgen/packed_records.rs`, native body
variants in `src/ir.rs`, ownership/scoped-effect visitors and `src/cgen.rs`.
The adjustment passes through a local alias: prove and update the complete
single-use chain. Collect uses once; avoid repeated tail scans. Preserve data-last
zip argument order and handle either mapped-input slot. If both inputs qualify,
select only one. Numeric records, captures and wide boxed values are excluded.

Draft semantic input: `/private/tmp/fwp-scalar-map-zip-order.fwp` (not executed).
Its key case maps three elements, traps on the third, and zips against one: the
trap must still occur before zip. Preparation notes are in
`/private/tmp/fwp-scalar-map-zip-design.md`; the published contract is authoritative.

## Checks and local limits

No local full build, suite or benchmark. All checks used `scripts/local-guard.py`:
seven constructor tests (0.74s), 13 ownership-profile tests (0.13s), 14 derivative
profile tests (13.58s), workflow lint (6.46s), roadmap/link audit (3.03s). Saved-C
rewrite attributes all 277 sites; caller detection now handles kernel macros and
multiline signatures. Artifact/log/cross-host audit passes (0.63s); all 96 map/zip
count formulas pass (0.14s). Published commits have one line, 57/59/62 characters,
no body/trailers. The early test-discovery mistake and serialization refusal were
resolved by direct, serial checks; no guard limit was bypassed.

Passing archives: `/private/tmp/fwp-census-passing-{arm,amd}.zip`; their hashes
match GitHub metadata. Retained ordinary C: `/private/tmp/fwp-census-largest-{arm,amd}.c`.
Guarded audit helper: `/private/tmp/fwp-audit-constructor-census.py`.
Preserve 64 GiB free disk, target data below 2 GiB, workload RSS below 1 GiB and
the 180-second deadline. Move refused checks to runners; never raise the limits.
