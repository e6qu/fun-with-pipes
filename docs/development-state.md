# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing, prefer ownership
and borrowing, and use ARC only for necessary sharing. JIT is excluded.

## Current action

**Next:** audit the final-head production jobs for
[PR #206](https://github.com/e6qu/fun-with-pipes/pull/206), then inspect their artifacts.
The consolidated change is being published and marked ready for the full matrix. Require all nine production jobs, docs and exact-head binary
inspection before the authorized one-line squash merge.

Delivery: `/private/tmp/fwp-array-pipeline-delivery`, branch `array-pipeline-delivery`.
Last focused head: `64c487652a2861ccff5dcb64f56604f43bc7ee47`.
The final publication receipt below records the consolidated head and CI run IDs.
Base: verified #205 merge `336692f4329d9f628c05d6a42a7353c1702bdc09`.
The consolidated delivery includes measurement reports, metadata recording,
CI control wiring and documentation changes. Continue in this checkout.
Preparation `/private/tmp/fwp-array-list` retains earlier source/docs copies.
Primary checkout stays detached at the base, with only this handoff modified.

## Evidence and repairs

- Native focused run `40052749788` at the focused head passes all six
  hosts and all fifteen targets. All complete logs are audited. All six hosts pass independent
  review of 168 outcomes, two stack reports and 24 physical layout cases each.
  [Native results](measurements/array-native-results.md) retain the costs and source IDs.
- Compiler/runtime/library/build files match measured source
  `19addb905e762a0a06e7a8ba970e2e40b89f565c`. Measurement run `40051285670` passes
  both Linux logs and 338 binary inspections. The report retains seven complete
  jobs across four runs (1,183 inspected files), plus five explicitly uninspected
  ARM64 rows from an interrupted run. CPU changes and noisy controls are explicit.
- Constant-array initialization now reuses one temporary descriptor per array.
  Clang's roughly 15 KiB frame is removed. Measured individual frames include
  Mac ARM entry O1/O2 720/704 bytes, Windows ARM entry 672/672, GCC AMD initializer
  160 and GCC ARM initializer 176. These are not whole-call-stack bounds.
- The initial Windows frame check wrongly required a function that Clang had
  inlined into the Windows thread entry. Both failed jobs and all other targets
  were audited before repair. The test now selects the platform entry, checks all
  surviving startup frames and saves evidence before asserting. Parser controls
  reject missing, malformed, oversized and dynamic reports. Rust O1 controls pass.
- An earlier ARM64 measurement exceeded a 60-second compiler deadline. Failed C
  matched a successful source. Builds now have an explicit 180-second CI deadline,
  separate execution deadlines, command journals and compiler-child cleanup.
  The local guard's limits are unchanged.
- Interrupted runs also lacked final hardware/toolchain records. The reporting repair
  writes `environment.json` before workloads and uses a separate `run_record`
  for final reporting. Five real failure/cleanup controls pass (1.97s); comparison
  of parsed Python code confirms settings, flags, workloads and timed loops are
  unchanged. The existing production benchmark job runs these controls. Formatting, docs,
  frozen primitive contracts and fourteen native runner controls pass (12.87s).
  Publication separately audits all real Cargo targets against both native shards.

[Array examples](measurements/array-text.md) explain construction, display,
String reuse and iterator state. [Numerical results](measurements/array-output-results.md)
name programs, tolerances, timing boundaries, CPU models, memory scope and every
observed row. Fewer allocations are not a C/Rust parity or timing claim.

## Receipts and tools

Paths below are under `/private/tmp`; full source IDs are retained in receipts.

- `fwp-array-delivery-publication.json`: current PR/head;
  `fwp-array-delivery-final-publication.json`: consolidated publication and checks; initial receipt backed up
  as `fwp-array-delivery-initial-publication.json`.
- `fwp-array-frame-check-{publication,audit}.json`: current native run.
  `fwp-inspect-array-frame-host.py --host HOST` runs once per uninspected host.
- `fwp-array-native-evidence/64c487652a28` and
  `fwp-array-layout-review/64c487652a28`: current native reports and saved binaries.
- `fwp-array-output-evidence/{41f6438cf6fb,dbef97e1a9e8,6516169a0768,19addb905e76}`:
  completed measurement inspections. Reporting-repair check:
  `fwp-array-reporting-repair-check.json`.
- Final-delivery audit/discovery/inspection and pruning helpers named
  `fwp-*-array-delivery-*.py` are prepared, not yet run. They read the publication
  receipt and require the final source/runs. Discovery distinguishes draft skips
  from the required nine production jobs; skipped jobs never establish support.
- Unique failed archives remain in `fwp-array-*-failure-evidence`. Do not discard
  them. Verified duplicate ZIPs were pruned only after checking remote originals.

#205's nine production jobs, docs, 7,158 inspected outcomes and exact squash tree
passed. [History](roadmap-history.md#float-printing-and-numerical-cost-measurements-pr-205)
records it; duplicate main CI was cancelled. Clean merged checkouts #198–205 were
pruned with receipts. Do not rerun helpers referencing those removed checkouts.
Use the local guard serially; full builds/tests/benchmarks stay on GitHub. Preserve
64 GiB free disk and all other limits. Prior detailed handoff:
`fwp-array-handoff-before-final-summary.md`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
