# Empty array transfer: native safety checks

**The repaired consuming map passes expanded native checks.** An ordinary empty
array transfers its existing owner to the result without allocation or writes,
including shared inputs and reuse-disabled builds. Empty views still release
their backing owner. Capture expressions have already evaluated before entry;
only element-callback calls are skipped.

| Host | Job | Verified checks | Images / probe outcomes |
|---|---|---|---|
| Linux ARM64, GCC | 128720938985 | 14 units + 57 native tests in ten targets | 420 / 444 |
| Linux AMD64, GCC | 128720938835 | Same | 420 / 444 |
| macOS ARM64, Clang | 128720938966 | Same | 414 / 444 |

Checks cover captures, scalar bits, arithmetic, views/aliases, returned records,
temporary inputs, allocation failures, cancellation and disabled reuse. Both
O1/O2 runs reject corrupted output and missing cleanup at exact statuses
241/90/248. The evidence audit also requires all three saved identity/float logs;
controls reject missing, failed or ignored results. Full logs have no unexpected
diagnostics. The documentation audit passes.

- [Native run 42477156079](https://github.com/e6qu/fun-with-pipes/actions/runs/42477156079):
  `4da9011873ce7cc6f67af71448cd3591c1d5562c`; compiler unchanged from `ca837567a`.
- [Complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42478473189/job/128724990571):
  source `7ab93331027f65d02f1b029b51c8c909656d3fe4`, no issues.
- [Artifact metadata](artifact.json), [retained records](audit.zip): artifact
  `13616691909`, verified SHA-256
  `581cff4e3d2319d9bf0e07e4a979157a5c56cab570c098190f1c2b0e1338371e`.

The compact archive retains complete job logs, target/probe records and hashes
of the actual native images audited on the runner. The
[original timing regressions](../captured-map-initial-2026-11-08/README.md) remain
unchanged. New measurements and final platform delivery are still required by
[the contract](../captured-array-maps.md).
