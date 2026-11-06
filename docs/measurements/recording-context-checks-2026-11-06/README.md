# Numeric recording scopes: verification

Source: `b9de738671732289a6263a8db3c1a36e54a8cfd9`.
[The contract](../recording-context-scopes.md) defines the lifetime boundaries and
measurement rules. These checks do not establish a runtime speedup.

| Check | Result | Complete record |
|---|---|---|
| Measurement tools | 121 controls across sixteen suites pass. No unexpected diagnostics. | [Job log](controls-job.log.gz), run `42209127591`, job `127863148988` |
| Documentation | Passed, including the deliberate test-runner failure controls. | [Job log](docs-job.log.gz), run `42209102269`, job `127863034359` |
| Disabled-scope reference | All eight C outputs exactly match the delivered compiler. | [Report](parent-report.json), [job](parent-job.json), [full log](parent-job.log.gz) |
| Native behavior | Run `42209117885`: 24/25 targets pass on each host; the new loop release probe fails with exit 92. | See [current status](../../development-state.md). |

## What the reference comparison checks

Two compilers are built from source on Linux ARM64:

- Delivered commit `d992a5734a12cf976c1ca20f75e9829a18bde0cc`.
- Current source with only `AD_RECORDING_SCOPES` changed to false.

They emit C for direct recording calls, nested calls, a neighboring-pair map/fold,
and a branch. Each example runs through raw and optimized compiler modes: four
examples × two modes = eight exact byte comparisons. The optimized loop example
contains one selected pair-map and one fold. No generated program is timed here;
this checks the reference compiler's output, not native execution or speed.

[The archive](parent.zip) retains every input, both C outputs, command stdout/
stderr, comparison report and exact reference edit/manifest.
[Artifact metadata](parent-artifact.json) records ID `13497844564`, 2,624,467 bytes,
and SHA-256 `d4b92c7b371e9d7fbc104fb5219c94b7e604e0e3ef64aa6bf592ac7e402d8895`.
The archive hash and all sixteen C-file hashes were checked locally under the
guard. The producer is run `42209137797`, job `127863168674`.

The first focused run and its repairs are recorded in the handoff. Passing these
reference/tool checks does not replace the focused native tests, memory census,
compiler/runtime measurements, original-image audit or final platform gates.
