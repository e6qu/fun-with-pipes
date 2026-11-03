# Reference upload and collection-count repairs

The first runtime audit and draft-PR documentation check found two bookkeeping
bugs. Neither is a runtime correctness failure. Their full logs and original
job metadata are retained in [the index](index.json).

- **Missing reference artifact:** the workflow's upload condition named older
  reference directories but omitted `scalar-array-map-reference`. Measurements
  and their embedded source/compiler manifests survived; the separate reference
  files did not upload. Audit `41654788718` correctly rejected both ARM64
  sessions. [Complete failed audit](reference-upload.log.gz),
  [saved summary](failed-audit-summary.zip).
- **Stale collection inventory:** draft docs run `41655295706` expected three
  `mapped_array_construction` tests after this PR added a fourth. The producer's
  expected count and the control transcript now both require four; the complete
  collection target set totals 59 tests. [Complete docs log](collection-inventory.log.gz).
  The earlier duplicate-target, unknown-target and intentional failed-harness
  diagnostics are existing rejection controls; no other failure was found.

The upload condition now uses the explicitly selected reference directory. An
explicit `scalar-array-map-recover` workflow builds the original frozen reference
on each native architecture, then requires its compiler, source, patch and
manifest to match the hashes saved during measurement exactly. It audits the
original samples without executing their binaries or repeating timings. Recovery
records distinguish reconstructed files from original artifacts. A mismatch
fails recovery; it does not relax the original evidence requirements.

Local controls reject altered compiler bytes, source, patch, every manifest
field, source identity and architecture. The upload regression requires the
selected directory; collection controls still reject missing/ignored/failed
or duplicate tests. All three native recovery jobs now pass: [four original sessions](../../direct-array-time-2026-11-03/README.md#original-evidence-and-exact-reference-recovery)
have matching reference hashes and complete raw audits. Repaired documentation
run [41656730058](https://github.com/e6qu/fun-with-pipes/actions/runs/41656730058)
also passes; its complete log contains only the three existing rejection controls.
