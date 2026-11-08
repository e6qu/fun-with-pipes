# Test import repair

[Focused run 41715801311](https://github.com/e6qu/fun-with-pipes/actions/runs/41715801311)
tested `f599dfba030b9fb70b53eb503bb001719a4ce8be` on both Linux architectures.
The new `iteration_consumers` test imported the private `fwp::interp::Value`
name. It must import the public type from its defining module, `fwp::value`.

| Check | ARM64 GCC | AMD64 GCC |
|---|---|---|
| Compiler build | Pass | Pass |
| Compiler unit tests | 268 pass, 4 ignored | 268 pass, 4 ignored |
| Primitive inventory | Pass | Pass |
| Collections tutorial, interpreter and native | Pass | Pass |
| Generated library docs, then check | Pass | Pass |
| Clippy including new test | Import error | Import error |
| Integration batch | Cannot compile the same test; no target executes | Same |

Both full logs and every saved step log were audited. There was no second error
cause. The unit log's scheduler panic messages are deliberate controls in passing
tests. The generated library documents are byte-identical and were imported into
`docs/stdlib.md` from these artifacts.

The still-queued macOS job was cancelled after both completed hosts were audited:
the same source could not build the test. Cancellation establishes no macOS
coverage. The repaired source must run the complete three-host focused batch.

Each host's ZIP retains its logs, source identity, generated docs and tutorial
outputs. The adjacent artifact metadata records its SHA-256; compressed full
job logs and job metadata preserve the failed steps. These results verify no
native ownership probe yet. [The subsequent repaired delivery](../../../roadmap-history.md#final-iteration-values-without-histories-pr-255)
passed its final gates; these failed first-attempt records remain unchanged.
