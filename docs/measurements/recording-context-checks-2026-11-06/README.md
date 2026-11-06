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

## Why the first release probe failed

[Diagnostic run 42211595925](https://github.com/e6qu/fun-with-pipes/actions/runs/42211595925)
rebuilt the original saved C and reproduced exit 92 before adding observations.
With four inputs and an invalid parent, it found 208 managed bytes still live;
the tape registry, workspace cache and extended-count table were empty.

The saved C defines `FWP_UNWIND=0`: the fixture had no recoverable error boundary.
The harness nevertheless installed a trap-recovery hook and jumped back after
an error. In that mode, generated calls and runtime value guards omit cleanup
needed to resume execution. This was a mismatch between the fixture and harness,
not evidence that sharing the tape lookup state leaked memory.

Commit `49371e06f5bba4598273a1b807140775dde64c57` gives the fixture an explicit,
typed `attempt` boundary and requires `FWP_UNWIND=1` before injecting failures.
`attempt` handles language errors; the C hook still supplies the injected trap
recovery. All release, alias and lookup assertions remain. The compiler/runtime
are unchanged. Native verification of this repair is pending.

[The small diagnostic archive](release-diagnostic.zip) preserves both C versions,
executables and outputs; [the complete job log](release-diagnostic-job.log.gz)
records job `127871298573`. Artifact `13499112406` is 378,998 bytes with SHA-256
`3234f7efa56548fe0090b1913bb299ad51a18dff8033710eb85e26f33fdde69d`, verified locally.
The original 172 MB native artifact was downloaded and rebuilt only on the runner.

## Earlier failures and repairs

Run `42204680001`, suite gradient-call-checks: AMD `127848244993`,
mac `127848245176`, ARM `127848245215`. All failed; complete logs reviewed.
All 75 native target results were audited: 24/25 pass on each host;
ad_tape_scopes has five passes and two new probe failures on each.

| Failure | Repair in this batch |
|---|---|
| Clippy: exported_probe.rs loaded twice in ad_tape_scopes. | Declare it once in the parent; import it into both test modules. No suppression. |
| Nested-call mutation expected `= w5(`, but scalar calls include a result cast. | Match the explicit callee and borrowed argument. Keep the broken-forwarding control. |
| Loop fixture used map, which does not select PackedRecordPairs. | Use the required indexed range-zip producer. Point values are indices; the fold returns (length−1)². Keep selection and runtime assertions. |
| Docs `42204664978` / `127848184855`: wrong handoff heading/status labels. | Restore Roadmap status and the supported labels. Other docs controls passed. |

All three compiler unit logs: 304 passed, zero failed, four existing runner-only
tests ignored. Formatting, builds, primitive inventory, source-reference and
common selection checks pass. Preflight artifact hashes/source verified:
AMD `13497750861`, mac `13496669557`, ARM `13496624934`.
Full logs are `/tmp/fwp-context-{amd,mac,arm}-first-job.log`; preflight ZIPs use
`/tmp/fwp-context-preflight-{amd,mac,arm}.zip`.

## Complete job listings

The repaired focused run has 128 job records. The auditors originally read only
GitHub's first 100; the three selected jobs happened to appear there. Both
focused and production auditors now read all pages and reject missing records,
duplicate IDs or a changing total. This prevents job ordering from hiding a gate.

Six local audit controls pass, including complete 128-record job/artifact lists,
empty lists and rejected malformed pages. A guarded metadata-only check reads
all 128 actual jobs. These checks took 0.13 s and 2.63 s respectively; they do not
replace the pending native runs or the complete artifact audit.
