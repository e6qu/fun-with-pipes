# Captured-map safety checks

**Focused native checks and the complete evidence audit pass.** This verifies
selection, values and cleanup; runtime/memory measurements and final platform
delivery remain separate requirements in [the contract](../captured-array-maps.md).

| Host | Native job | Tests | Saved images / probe outcomes |
|---|---|---|---|
| Linux ARM64, GCC | 128703672142 | 13 ownership units + 47 tests in eight targets | 358 / 382 |
| Linux AMD64, GCC | 128703672234 | Same | 358 / 382 |
| macOS ARM64, Clang | 128703672177 | Same | 352 / 382 |

Controls cover capture order, exact float payloads, checked arithmetic, shared
inputs/views, allocation failure, cancellation and reuse disabled. Deliberately
removing the captured input's cleanup fails with status 248 at both O1 and O2 on
all hosts: the retained alias has an extra owner. Independent physical-allocation
checks still detect leaks. Nine compiler traversal observations per host meet the
frozen bounds. Full logs contain no unexpected diagnostics.

- [Focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/42471671589):
  `46ac4cf383c614aceb715675aba71e2b85416a4f`; compiler unchanged from `0c704421f`.
- [Audit job](https://github.com/e6qu/fun-with-pipes/actions/runs/42472528452/job/128706453822):
  `025016fbedfcac2127619e4a053415aa83b9d6b0`.
- [Artifact metadata](artifact.json), [audit archive](audit.zip): artifact
  `13614402438`, SHA-256
  `29391978968f75b6661d09b049290f8152e51afb7692127366c598fcb9822de6`.

The archive retains all three job logs, target records, probe statuses, native
image identities and the audit reports. Its summary has no issues. The auditor
checked the original native artifacts; the compact archive records their hashes
and results rather than duplicating every executable.
