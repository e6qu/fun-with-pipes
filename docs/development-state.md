# Current work

**Next:** publish the strengthened identity-log audit, then dispatch `numerics.yml` with `suite=captured-maps`
and `evidence_run=42477156079`.
Keep the original measurements unchanged. Bundle the implementation, repair,
evidence and docs in one normal PR after the changed implementation is measured.

## Workspace

Branch `captured-array-map-reuse`, worktree `.worktrees/recording-capacity-gate`.
Base `f87796b52081889b96859dbd72bf4af9a6726207` is merged PR #270. Preserve unrelated
root-worktree changes. No PR is open yet; final production gates have not run.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #270 delivered fresh F64 stores and refreshed docs/tutorials. ARM64 improves 26–31%; original AMD64 timing acceptance stays open. |
| 2 | In progress | Empty-input repair passes expanded native checks. Measure it under the unchanged limits and complete final delivery; retain original timing misses. |
| 3 | Pending | Structured differentiation across three objective families; preserve general AD, nesting and precision. |
| 4 | Pending | Current Swift/C/Rust ownership comparisons, phase timings and explicit memory boundaries. |
| 5 | Pending | Three application/tooling paths; compiler phase/scaling costs and demonstrated usability repairs. |

## Implementation and current checks

The compiler snapshots known scalar captures at their original binding, passes
those numbers directly to a consuming map and retains closures needed by other
uses. Only the last array argument is consumed. Nonempty shared arrays and views
receive independent output. No language API or syntax change.

Repair source `ca837567a41c660c5a0150faca688b6b5917cd81` forwards an ordinary empty
array's existing owner without writes, allocation, cleanup scopes or count changes,
including shared inputs and no-reuse builds. Empty views still release their
potentially large backing owner. The physical-free/alias tests require this exact
behavior. Formatting passes locally; the first native run found stale assertions
in record/temporary-map tests. The compiler source is unchanged by their repair.

Expectation repair `4da9011873ce7cc6f67af71448cd3591c1d5562c` is published.
Expanded focused run `42477156079`:

| Host | Job | Last observed state |
|---|---|---|
| AMD64 GCC | 128720938835 | Passed |
| ARM64 GCC | 128720938985 | Passed |
| macOS ARM64 Clang | 128720938966 | Passed |

All 57 native tests in ten targets and 14 ownership/identity units pass per host.
Full logs contain no compiler warnings or errors. Docs `42477158452`, job
`128720942662`, passes. Prior docs `42475717410`,
job `128716518586`, passes at compiler source `ca837567a`.
In failed run `42475715012`, all completed targets and full job logs were reviewed:
13 ownership units and the other seven targets pass on every host. The batch updates exact
empty-result identity/allocation counts for returned records and temporary inputs,
adds contextual diagnostics, and repairs the same assumption in the float
identity control. Alias, empty-view and physical-free assertions remain required.
The expanded focused suite includes the affected float/identity targets.
The evidence auditor now also requires their three saved unit/target logs;
ten local auditor tests pass, including complete/missing/failed/ignored controls.

## Original measurements: preserved, not accepted as complete

[The four-session report](measurements/captured-map-initial-2026-11-08/README.md)
retains all raw observations, sources, flags, hashes and job logs. Run
`42472528452`, source `025016fbedfcac2127619e4a053415aa83b9d6b0`, is anchored by
`evidence/captured-maps-initial-20261108`. Every job and reconstruction audit passes.

| Session | Job | Outcome |
|---|---|---|
| ARM1, N2 | 128711666600 | 9 inconclusive computation controls; no qualified regression |
| ARM2, N2 | 128711666641 | 6 inconclusive controls; shared empty sensor/pixel regressions 3.77%/4.45% |
| AMD1, EPYC 9V74 | 128711666753 | 33 inconclusive controls; shared empty pixel regression 2.44% |
| AMD2, EPYC 9V45 | 128711666605 | 38 inconclusive controls; no qualified regression |

Qualified large cases show roughly 83–94% less computation, but missing copy
qualification and the three regressions prevent combined acceptance. Do not pool
CPU models, weaken the 2% noise/regression limits or rerun unchanged timings for a
pass. The empty-input repair changes the implementation and must be measured anew.

Memory counts match across both architectures for all 48 cases. Largest exclusive
199-update cases remove 199 array allocations: 600 requests become 401. Sensor
requested bytes fall from 419,441,600 to 2,105,168; peak managed storage roughly
halves. Retains remain 200; final live storage is zero. Remaining heap/ARC work is
not removed. The report includes RSS, compiler time/RSS, code and stack costs.

## Safety evidence and earlier delivery

[Initial safety evidence](measurements/captured-map-checks-2026-11-08/README.md):
run `42471671589`, source `46ac4cf383c614aceb715675aba71e2b85416a4f`; 13 ownership
units, 47 native tests in eight targets and nine bounded traversal observations
pass per host. Audit job `128706453822` checks 382 probe outcomes per host and
native images, with no issues. The verified archive and full artifact metadata
are retained. These checks precede the empty-input repair.

[The contract](measurements/captured-array-maps.md) retains the two earlier failed
runs and their repairs: actual bound callbacks needed indexing; exported roots
were needed for selection checks; missing-owner cleanup rejects at exact status
248 before the physical-leak check. All completed targets/logs were reviewed.

[#270's delivery record](measurements/fresh-array-delivery-2026-11-08/README.md)
retains all nine native production jobs, docs, tested/merged tree identity and the
passing complete audit. Its recovered-checkout audit repair is included in this
branch; ten controls and actual-log replay pass. Earlier timing misses remain open.

## Local checks and delivery requirements

All local checks use `python3 scripts/local-guard.py`, serially. Full builds,
native suites, benchmarks and large evidence generation run on GitHub runners.

- Rust formatting passes after the empty-owner repair.
- Four captured-map and 14 borrowed-array measurement controls pass.
- Eight clock helpers pass 64 Clang O1/O2 executions; docs CI also checks GCC.
- Measurement/fixture programs pass isolated production parser/formatter checks.
- Markdown links, five roadmap rows and workflow size/YAML checks pass.
- Original artifact digests, compact record hashes and reported fields are checked
  locally; the complete observation audits passed on their measurement runners.
- Guarded `/tmp/fwp-replay-empty-owner.py` replays the exact failing CI-generated
  C with the repaired fixture at Apple Clang 17 O1/O2: reuse and no-reuse pass;
  corrupted output, missing suffix cleanup and missing captured-input cleanup
  reject at exact statuses 241/90/248. All ten cases pass in 5.43 seconds, 2.32
  sampled CPU seconds. This does not replace GCC or the added identity checks.

Disk has fluctuated across the 64 GiB reserve. Local checks stopped at 54 GiB and
resumed only after recovery to 78 GiB. No limits were raised or bypassed.
Final delivery still needs nine production jobs, docs and a complete audit for the
exact final PR head, followed by authorized squash merge with a one-line subject
of at most 80 characters and an empty body.
