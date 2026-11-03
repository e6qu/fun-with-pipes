# Complete the test programs' list layouts

[Run 41720302662](https://github.com/e6qu/fun-with-pipes/actions/runs/41720302662)
tested `73426169c8a1b29ceead23d83dd8dc30b6aa3664` on GCC ARM64 and AMD64.
Both hosts passed 44 integration tests and failed the same two test fixtures.
All nine target logs and complete job logs were audited; no other failure or
compiler warning was found.

The fixtures construct typed compiler input directly. Unlike normal source
lowering, they omitted the layouts for their list types. Ownership validation
therefore rejected `List[F64]` in the iteration probe and `List[File]` in the
resource probe before C generation. The repair supplies `Nil` and `Cons` layouts,
including both the inner numeric list and its outer history list. It changes no
compiler ownership rule or production code.

| Check on each host | Result |
|---|---|
| Formatting, Clippy and compiler build | Pass |
| Compiler units | 268 pass; 4 ignored |
| Primitive inventory | Pass |
| Raw/optimized selection | All 12 pass; four eligible optimized cases selected |
| Source behavior, order and count errors | Pass in both interpreters and native O1/O2 |
| Fresh optional-result cleanup | Pass at O1/O2; omitted protection correctly exits 90 |
| Eight other integration targets | All pass |
| Two hand-built list fixtures | Rejected before their native probes execute |
| Generated docs and collections tutorial | Pass |

The still-queued macOS job was cancelled after both completed hosts were audited.
That establishes no macOS coverage. The repaired fixtures must run on all three
hosts before performance measurement.

Each `logs-and-selection.zip` preserves all step/target logs, source identity,
toolchain, generated docs, tutorial output and the twelve source/IR/C selections.
The adjacent `retained.json` verifies every retained byte against the original
artifact inventory. `audit.json` inventories the complete original artifact,
including 305 native observations, but does not claim all those images are in
this smaller archive. Artifact metadata preserves the full download identity and
digest; full job logs are retained separately. Complete originals remain in the
local `final-iteration-second` scratch folder and the linked GitHub run.

See [the contract](../../final-iteration-storage.md) and
[handoff](../../../development-state.md) for remaining acceptance work.
