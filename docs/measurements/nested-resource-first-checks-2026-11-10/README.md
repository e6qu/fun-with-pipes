# First nested resource-owner checks

Source `0c73a4e7102876fef8d576abdce5b1290f0b28c0`, tag
`roadmap/nested-resource-owner-proof-2026-11-10`.
[Run 42784994278](https://github.com/e6qu/fun-with-pipes/actions/runs/42784994278)
uses native GCC on Linux ARM64 and AMD64, O1/O2 without LTO.

| Check | ARM64 | AMD64 |
|---|---|---|
| Seven borrowing proof controls | Pass | Pass |
| Seven original resource-frame controls | Pass | Pass |
| Eight integration targets / 34 tests | Pass | Pass |
| Formatting and Clippy | Workflow setup failed | Workflow setup failed |

The native tests verify service outputs, physical release, weak expiration,
cancelled work, escaped values, file aliases, handled errors and recursion.
The optimized service must contain a selected nested borrow. Deliberately omitted
weak releases must fail the ownership ledger. These are correctness checks;
they do not establish speed, allocation reduction or final platform support.

The workflow omitted rustfmt/Clippy components. Formatting could not start, so
Clippy did not run. Both complete logs contain this same setup failure and no
native test failure or compiler diagnostic. The repair installs both components
explicitly. The separate [documentation run](https://github.com/e6qu/fun-with-pipes/actions/runs/42784998783)
passes.

- ARM64 job `129723892565`: [complete log](arm-job.log.gz).
- AMD64 job `129723892136`: [complete log](amd-job.log.gz).
- [Artifact metadata](artifacts.json) identifies retained generated C, binaries
  and per-target logs on GitHub. Complete native archives were not downloaded
  locally; no local archive-integrity claim is made.

Next: [actual operation counts and ordinary performance acceptance](../nested-resource-owners.md).
