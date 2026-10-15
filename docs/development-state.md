# Session handoff

Updated 2026-10-15. [PR #141](https://github.com/e6qu/fun-with-pipes/pull/141),
branch `autodiff-metadata-block`, delivers the final planned follow-up. Runtime,
tests, measurement tooling and workflows are frozen at `24620ead`; subsequent
changes only record evidence and documentation. Base is accepted `09f1a029`.
Publication, fixes and squash merge remain authorized after the gates below.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Verified | Seeded-prefix adjoint bounds and four-host evidence |
| 8 | Verified | Operation-only AD metadata and atomic weight retention |
| 9 | Verified | Geometric AD registry growth and workspace preservation |
| 10 | Verified | Registry cursor search; PR #140 merged with all gates |
| 11 | Implemented | Paired native AD metadata allocations and relocation controls |

## Accepted baseline and final change

Steps 1–10 are verified through [PR #140](https://github.com/e6qu/fun-with-pipes/pull/140),
merged as `09f1a029` with all nine production jobs and documentation at the
identical tested tree. [History](roadmap-history.md#accepted-registry-cursor-follow-up-pr-140)
retains its acceptance; preparation anchors are not work to replay.

Step 11 pairs native parent buffers and numeric derivative buffers while keeping
separate contiguous, naturally aligned regions. Growth copies only initialized
second regions. Old offsets remain valid until potentially trapping managed
weight growth finishes. Only base pointers own storage. Capturing the owner
before realloc allows numeric growth specialization. The interpreter, syntax,
arithmetic order, node bound and workspace budget are unchanged.

[Four-host evidence](measurements/ad-metadata-2026-10-15.json) verifies half as
many metadata requests with unchanged requested/peak payload and managed
counters. The mapped VJP uses 16 total native tape requests instead of 30;
all measured storage is reclaimed with zero collections. Timings are mixed,
including regressions, so no general speedup is claimed. [Benchmarks](benchmarks.md#paired-autodiff-metadata-allocations)
record copying costs, timings and actual instruction review. Archive and every
source/binary/disassembly hash were verified before recording the report.

## Validation

[Four-host AD and measurements](https://github.com/e6qu/fun-with-pipes/actions/runs/38726490082)
passed at `24620ead`. [Both actual WASM jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38726508454)
both passed at that revision, including semantic agreement and actual 32-bit
allocation-size controls. The final merge gate rechecks their conclusions. [Runtime-head documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38726466688)
passed, but the final documentation head needs its own audit.

All local checks used `python3 scripts/local-guard.py` with unchanged limits:

- `cargo test --test autodiff_capacity_bounds -- --test-threads=1`: final three
  controls passed (42.69s), including moving/overlapping allocation, exact bits,
  alignment, managed-growth trap recovery and deliberate defective controls.
- `cargo test --test ad_tape_scopes -- --test-threads=1`: four controls passed
  (33.16s). Workspace, ownership/unwind and library controls also passed; the
  corrected workspace padding control passed separately (4.14s).
- `cargo clippy --all-targets -- -D warnings`: passed (17.45s).
  `cargo fmt --check`: final formatting passed (1.07s).
- Measurement instrumentation syntax and checked ARC emission for five workloads:
  passed (5.39s); local compile/disassembly confirmed owner specialization without
  running benchmarks (1.21s). Workflow lint passed (0.26s).
- `python3 /private/tmp/fwp-collect-metadata.py`: all four artifact/hash/counter
  checks passed (0.26s). `python3 scripts/check-roadmap.py` passed all 11 steps,
  links, immutable anchors and commit messages (2.92s).

Resolved validation defects: scope/unwind ledgers expected frees for now-interior
pointers; the workspace negative control reserved before initializing length;
an ARC probe incorrectly enabled tracing reuse verification. Their corrected
controls pass in the final focused native run. Earlier native/WASM runs were
superseded and are not acceptance gates. No unresolved native failure remains.

## Next action

Next: publish the final documentation/evidence commit and make PR #141 ready.
Recheck the successful focused runs above and wait for all nine production jobs plus
`roadmap_docs` at the final PR head. Discover their run IDs from PR checks;
draft production `38726466710` was skipped and does not count. Fix any failure.
Verify the final head changes only documentation/evidence after `24620ead`.

Require Linux ARM64/AMD64, regular and GC-stress ARM/Intel macOS, benchmarks,
and native Windows ARM64/AMD64. Squash-merge with exactly this subject and an
explicit empty body: `Pair native autodiff metadata allocations`. Then verify
clean main, equality with the tested tree, and the raw one-line commit message
(no trailers, at most 80 characters).

Once PR #141 is merged under these gates, step 11 is verified and the complete
plan is finished. Next sessions should confirm that PR's merged state and checks,
then report completion; no further implementation work is queued. The pre-merge
wording above is an acceptance checklist, not a request to repeat completed CI.

Full builds, suites and benchmarks run on GitHub. Local checks remain serial
under the guard: 64 GiB free disk, target below 2 GiB, sampled workload RSS below
1 GiB, 180-second deadline. Do not raise limits or substitute skipped gates.
