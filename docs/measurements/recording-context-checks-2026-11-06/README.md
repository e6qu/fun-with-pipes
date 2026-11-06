# Numeric recording scopes: verification

Initial source: `b9de738671732289a6263a8db3c1a36e54a8cfd9`.
The repaired fixture checks below use `49371e06f5bba4598273a1b807140775dde64c57`.
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
are unchanged. All three focused native jobs now pass; the complete artifact audit also passes (record below).

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

## Repaired fixture: reference and documentation

The reference comparison passes again with the explicit recovery boundary:
[report](parent-repaired-report.json), [job](parent-repaired-job.json),
[complete log](parent-repaired-job.log.gz), [archive](parent-repaired.zip) and
[artifact identity](parent-repaired-artifact.json). Run `42213046373`, job
`127876155092`; artifact `13502800917`, 2,642,670 bytes, SHA-256
`7e71e9f876276a965796d19d325f235dec790e48d48ea4a043b61af66db123df`.
The guarded audit verified the archive, source and all sixteen C-file hashes;
the eight paired outputs match and the full log is clean (0.13 s).

[Documentation](docs-native-repair.log.gz) passes at the same source: run
`42213039124`, job `127876122034`. Its complete log contains only the three
expected test-runner failure controls (guarded audit, 0.12 s).

The pagination repair also covers census, compiler-cost, diagnostic and HTTP
artifact readers. Shared audit logic lives in `scripts/github_records.py`;
requests are explicit, and raw log/archive downloads retain their existing APIs.
Six controls pass after integration. Actionlint syntax/expressions, changed
Python and embedded workflow syntax, and workflow-size checks pass (0.13 s each;
shellcheck/pyflakes were disabled). Native sources and measurement settings are
unchanged by these reader fixes.

## Repaired fixture: native results

Run `42213041403` at `49371e06f5bba4598273a1b807140775dde64c57` passes:

| Host | Job | Native targets | Compiler units |
|---|---|---|---|
| Linux ARM64, GCC | `127876137456` | 25/25 pass | 305 pass, four existing runner-only exclusions |
| Linux AMD64, GCC | `127876137274` | 25/25 pass | Same |
| macOS ARM64, Clang | `127876137522` | 25/25 pass | Same |

Every complete job log is clean: [ARM64](repaired-arm-job.log.gz),
[AMD64](repaired-amd-job.log.gz), [macOS](repaired-mac-job.log.gz);
[all target results](repaired-log-review.json). The repaired loop probe passes on all three
hosts, including nested failure cleanup, aliases, ID changes and deliberate
broken-scope/ID controls. The complete artifact/image audit is run `42220789909`;
it failed in the audit entry point, as explained below. This is focused verification, not final platform
acceptance or a measured performance gain.

Documentation and audit controls also pass at tool source
`3809353824e19f53117fcf7e8eaa56752dafa234`: run `42218866499`, job `127895597129`.
Its complete log contains only the three expected test-runner failure controls.

## Audit entry-point repair

[Audit log](focused-audit-failure.log.gz), run `42220789909`, job `127902024671`:
the imported pagination function `records` collided with a ZIP-writer local of
the same name. Python therefore stopped before reading evidence; the upload
step then had no files to retain. This was an audit integration error. Native
results and [latest documentation results](latest-docs-job.log.gz) stay valid.

The ZIP writer is now named `retained_files`. A new small integration control
calls the actual focused audit entry point with three native jobs on page two,
synthetic native headers, 25 passing target logs and retained records. It also
rejects a missing target. All seven audit controls pass locally (guard: 0.13 s).
The repaired full runner audit passes; its record follows.

## Complete artifact audit

Run `42221400241`, job `127904076811`, tool source
`319782736b0a983022f2a48879b35c9e57992949` audits native source
`49371e06f5bba4598273a1b807140775dde64c57`, run `42213041403`, attempt 1.
All three hosts pass: 25 targets, 894 native images and 910 probe observations
per host. The full logs, native image headers, observations and artifact
identities were checked on GitHub. The issue list is empty.

[Summary](audit-summary.json), [job](audit-job.json), [complete log](audit-job.log.gz),
[retained records](audit.zip), [artifact identity](audit-artifact.json).
Artifact `13503834185` is 7,293,923 bytes with SHA-256
`20e47ac1fab25227ae167f7b6dae717e1645eb01f0052efb12e3cd2c66da0c35`.
Local guarded checks verified its hash, source, all three retained-record hashes,
coverage and clean full log (0.12–0.13 s). Large original native archives stayed
on the runner. These checks do not establish a speedup or final platform support.

The repaired audit tools also pass documentation run `42221406301`, job
`127904085671`, at `319782736b0a983022f2a48879b35c9e57992949`:
[complete log](repaired-tools-docs.log.gz), [job identity](repaired-tools-docs-job.json).
All seven audit controls pass; the complete documentation log has only the
three expected test-runner failure controls. A guarded source-tree comparison
confirms that compiler/runtime/library/test sources still match the verified
native run (0.12 s including the log audit).

## Source lifetime review

The review at source `319782736b0a983022f2a48879b35c9e57992949` found no additional
defect in the new scope lifetime:

- The proof accepts only numeric values/records and known numeric callees. It
  rejects recursion, branches, unknown calls, lifecycle operations and task ticks.
- Each selected map/fold starts its own state after setup. Loop-exit boxing and
  cleanup cannot reuse it; ordinary and exported calls pass fresh state.
- A shared state checks the tape ID on every append. Buffer growth cannot move
  the registry entry; operations that could move or retire it are excluded.
- Ownership lowering preserves function identities and adds ownership operations
  for numeric values/records, which cannot invoke resource cleanup callbacks.

This source review complements the passing failure/ID/reuse probes above. It
does not replace the remaining final platform gates or measurement audits.
