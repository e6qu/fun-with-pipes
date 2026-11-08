# Captured-map benchmark cleanup repair

Run `42478473189`, source `7ab93331027f65d02f1b029b51c8c909656d3fe4`, did not
complete a timing comparison. It exposed a benchmark-driver ownership bug.

| Job | Outcome |
|---|---|
| AMD session 1, `128725646945` | Rejected Intel Xeon Platinum 8573C before building/timing; the contract requires a listed EPYC host. |
| AMD session 2, `128725647003` | Shared empty sensor check exits 214: final live memory differs from its starting value. |
| ARM session 2, `128725646968` | Same check and exact failure status as AMD. |
| ARM session 1, `128725646991` | Cancelled during building once the driver failure was known. |

All completed logs were reviewed. No compiler diagnostic explains the failure.
The [expanded native safety audit](../captured-map-empty-checks-2026-11-08/README.md)
passes independently. Docs run `42478475287`, job `128724993198`, also passes.

## Cause and repair

An empty mapped array may now be the same object as the retained input alias:

```text
result ──┐
         ├── empty array, reference count 2
alias ───┘
```

The driver called `fwp_rc_free_arr` twice. This helper frees storage only when
the count is already one; it does not consume a shared reference. Both calls
therefore left the count at two. The driver now uses the runtime's normal order:

```c
if (fwp_rc_release_last(result)) fwp_rc_free_arr(result);
if (alias && fwp_rc_release_last(alias)) fwp_rc_free_arr(alias);
```

The first release changes two owners to one. The second frees the array. Distinct
results and aliases are each freed separately. View results remain independent
ordinary arrays; their backing alias is released too. Compiler code is unchanged.
Measurement failures now print exit status and timeout state as well as stderr.

## Verification and measurement boundaries

- The exact saved failing C reproduces status 214 with Apple Clang 17 at O1/O2.
- The corrected driver passes 24 checks: both optimization levels × lengths
  0/16 × updates 1/199 × exclusive/retained/view inputs. Values and aliases match;
  final managed storage equals initial storage.
- Four measurement-contract tests pass. The guarded replay takes 24.31 seconds
  wall time and 12.05 sampled CPU seconds. This does not replace GCC verification.
- Both candidate and reference use the corrected driver in subsequent sessions.
  Computation timing, inputs, repetition counts and acceptance limits are
  unchanged. Final-release and whole-process timing now include correct owner
  drops; do not treat those driver costs as a compiler-only change.

The [initial complete measurements](../captured-map-initial-2026-11-08/README.md)
remain unchanged: their older compiler returned separate empty result/alias
arrays, so this driver error did not occur there. Partial timings from the failed
run establish no acceptance result. Retry a rejected host only because no timing
ran; do not repeat completed unchanged sessions to obtain better results.

## Retained evidence

`artifacts.json` records original artifact metadata, SHA-256 digests, every file
hash and each retained archive digest. `amd-2.zip` and `arm-2.zip` retain commands,
raw output, identities and the failing generated C. `amd-1.zip` retains the
rejected host. Compressed logs cover all four jobs. `local-replay.json` records
all 26 reproduction/repair executions and exact source hashes.

The [measurement contract](../captured-array-maps.md) owns criteria;
[the handoff](../../development-state.md) owns the next action.
