# Which lifetime records still hold plain fields?

Both native Linux hosts pass [run 42830283981](https://github.com/e6qu/fun-with-pipes/actions/runs/42830283981)
at `9b24e6965dd4c7cfb6e88163a34722e0b99ec901`. The compiler reports original lifetime
record fields without changing emitted C. This is a count of source sites, not
executed operations, memory savings or speedup.

| Program | Original lifetime records | Held fields | Plain fields |
|---|---:|---:|---:|
| Queued service, complete main | 21 | 31 | 5 |
| Same service, exported entry | 21 | 31 | 5 |
| HTTP endpoint | 755 | 1,111 | 20 |
| Word count, numerical tutorial, twelve compiler-growth inputs | 0 | 0 | 0 |

Plain HTTP fields are strings, bytes and durations. They still have ordinary
owners; the investigation concerns their extra resource-lifetime holds. Unknown
closures remain resource-bearing. No variant slots were selected.

- Ordinary and diagnostic compilers emit identical C for all 17 inputs.
- ARM64 and AMD64 agree on every C hash, field classification and total.
- Every reported context matches a generated original-lifetime cleanup marker.
  Three reader controls reject stale hooks, malformed reports and ordinary owners
  mislabeled as lifetime records. Complete job logs have no compiler warnings or
  unexpected failures.
- Production compiler/runtime/library/fixture sources are unchanged from merged
  #276. The diagnostic changes only a separate checkout's `src/cgen.rs`.

Artifacts: ARM64 `13771352240`, job `129878222562`; AMD64 `13770528937`, job
`129878222459`. The full generated C stays in those archives. Retained report,
identity and patch members pass individual CRC checks; the large archives were
not fully downloaded or hashed locally. Their reported identities are in
[artifacts.json](artifacts.json). The executed-count workflow verifies complete
archive size/hash/CRCs on runners before using them.

Reconstruct all retained totals and classifications:

```sh
python3 scripts/local-guard.py python3 docs/measurements/resource-field-census-2026-11-10/read.py
```

[Next](../resource-field-costs.md): count actual holds and releases in the service
and HTTP, then choose and freeze a production change. No elapsed-time target has
been selected or passed by this census.
