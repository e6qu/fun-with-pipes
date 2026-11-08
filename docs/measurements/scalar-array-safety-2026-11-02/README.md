# Scalar-capture array safety

The candidate calls a known array callback directly when it saves only ordinary
numeric values. For example, `array.generate 3 (add 7)` returns `array[7, 8, 9]`
without a generic callback dispatch for each element.

[Focused run 41448056587](https://github.com/e6qu/fun-with-pipes/actions/runs/41448056587)
passes on source `240d889742e2fffc3e6a4375bec8a2b52e4900f3`:

| Host | Compiler | Results |
|---|---|---|
| Linux AMD64 | GCC | Five targets, 22 tests; construction diagnostic at O1/O2 |
| Linux ARM64 | GCC | Five targets, 22 tests; construction diagnostic at O1/O2 |
| macOS ARM64 | Clang | Five targets, 22 tests |

The tests cover count-before-capture evaluation, callback reuse, arithmetic and
size overflow, exact signed-zero/NaN/subnormal bits, partial failure and task
cancellation. Native results agree with the raw interpreter.

The scalar-callback probe checks zero generic dispatch and zero callback-owner
checks. At both O1 and O2, it also detects four deliberate errors: an extra owner
check, an extra dispatch, omitted partial-array cleanup and omitted cancellation
cleanup. All 30 executions across the three hosts return their required status.
The Linux diagnostic verifies every constructed element and reduction across
144 cases per build: materialized paths allocate once; composed source allocates
zero times. Missing-release controls fail as required.

All full job logs, all 15 target logs, saved callback probe statuses and the Linux
source/file/output records were audited. No compiler diagnostic remains.
[Index](index.json) records artifact digests, job IDs, probe source/binary hashes
and counts. Compressed reports and full job logs are retained here; complete
archives also contain generated C and binaries.

The first run, `41442126003` at `5437f39f`, exposed two test-harness defects:

- Its overflow expectation used UBSan wording instead of fwp's actual
  `arithmetic overflow in I64` diagnostic.
- Its cancellation hook used task declarations before they appeared in C.
  The hook now runs in the generated loop after two stores.

Both were repaired together. Production runtime code was unchanged. These
focused checks establish safety for the selected cases; [paired timing](../array-construction-costs.md#selected-change-known-scalar-captures)
and the full production matrix remain separate requirements.
