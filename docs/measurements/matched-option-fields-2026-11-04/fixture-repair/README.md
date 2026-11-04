# Fixture application and formatting repair

[Run 41803373296](https://github.com/e6qu/fun-with-pipes/actions/runs/41803373296)
tests source `15d94416027b4a377addef008fcee8b4ade6f6b5` on Linux ARM64/AMD64
with GCC and macOS ARM64 with Clang.

Each host passes 268 unit tests (four deliberately ignored), all seven selection
checks, 56 integration tests and all 22 new native owner controls. One source
fixture test and its formatting fail; the other 14 integration targets pass.
Every target log and all 499 execution/status records per host were audited.

The failing example selected a function from a list, then tried to apply it
through a pipe. That expression entered function composition during inference.
Use explicit application to make the intended call clear:

```fwp
apply "!" (["a", "b"] | map concat | nth 1 | pick (concat "missing"))
```

Here `pick` returns the optional payload or its supplied default. `map concat`
creates two captured functions; `nth 1` selects the second. Applying it to `"!"`
produces `"!b"`. This still exercises ownership of an escaping captured function.
The language formatter also fixes the nested `match` and long array example.

- The fixture's raw/optimized interpreter outputs agree after repair, using the
  checksum-verified packaged compiler from PR #255. This is a fixture check, not
  verification of the new native optimization.
- Compiler/runtime code is unchanged by this repair.
- The repair batch also adds direct physical-release controls for numeric list
  and array payloads, and a slice-alias example. Updating the selected slice must
  leave the original array unchanged.
- Keep the failed batch's full logs, target results, selection records and native
  owner observations. Passing controls within a failed job do not make it green.

[Index](index.json) records each host. The compressed audit reports map every
retained source/image to its original archive path and digest. Native image
headers were checked against the actual host architecture. Original artifact
identities and full job logs are retained alongside the compact control archives.
