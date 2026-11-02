# Remaining reference counts in derivative callbacks

**Status:** complete-field transfers pass focused Linux ARM64/AMD64 GCC/Clang
O1/O2 checks and all 96 count observations. Callback-input ownership is next;
combined timings and the final platform matrix remain. [Plan](../../PLAN.md).

## First-stage results

[Run 41538264130](https://github.com/e6qu/fun-with-pipes/actions/runs/41538264130)
uses source `ceecb569c6748a226ec6ddebc417dc16351490e9`. Both architectures pass
30 tests: four selection controls and 26 native cases across GCC/Clang. All
16 target logs and both full job logs are audited, without diagnostics.

The largest current-only O2 solve changes:

| Measurement | Packed-record baseline | Complete-field transfers |
|---|---:|---:|
| Retains | 77,411 | 51,939 |
| Managed allocations | 156,943 | 156,943 |
| Requested bytes | 5,382,142 | 5,382,142 |
| Peak managed bytes | 17,824 | 17,824 |
| Final managed/raw storage | 0 | 0 |

Each of the 96 observations removes exactly `p=(coordinates-1)*updates` retains.
The projection site disappears; the mapper-input sites remain exactly `2*p`.
Raw tape/workspace storage, derivative work and output agree. Both zero-update
forms are unchanged. Largest O2 instruction bytes fall by 80 on ARM64 and 160 on
AMD64; all 128-byte frame-growth limits pass. This is no elapsed-time claim.

All 40 saved native probes have verified architecture and observed exit status:
16 normal probes pass; 24 deliberately broken retain/release controls fail as
required. Checks cover two/eight fields, shared/repeated children, direct/boxed
entries, traps, real cancellation and result-boxing failure.

- [Verified counts, sources and image identities](field-owner-transfer-checks-2026-11-03/verified-counts.json.gz)
- [Archive identities](field-owner-transfer-checks-2026-11-03/verified-artifacts.json)
  and [actual probe results](field-owner-transfer-checks-2026-11-03/verified-probes.json)
- Full passing logs: [ARM64](field-owner-transfer-checks-2026-11-03/arm-verified.log.gz),
  [AMD64](field-owner-transfer-checks-2026-11-03/amd-verified.log.gz)

The initial candidate indexed a stored function body, while C generation emitted
a clone. Both new native controls rejected the absent selection under both C
compilers on both hosts. The repaired lazy index belongs to the exact emission
body, as does call liveness. All failures and completed targets were audited
before repair. Initial logs: [ARM64](field-owner-transfer-checks-2026-11-03/arm-initial.log.gz),
[AMD64](field-owner-transfer-checks-2026-11-03/amd-initial.log.gz);
[artifact identities](field-owner-transfer-checks-2026-11-03/initial-artifacts.json).

A **retain** increments a reference count so another owner can keep a value
alive. Removing temporary owners can remove both that increment and its later
release. The [packed-record change](derivative-temporary-storage-2026-11-02/README.md)
reduces allocations, but deliberately leaves callback argument ownership alone.

## Where the remaining operations occur

The retained baseline is compiler `a4f3200c9b97b955c3f3603788eacbfac19fde4e`,
[run 41511493637](https://github.com/e6qu/fun-with-pipes/actions/runs/41511493637).
Its compiler sources equal PR #248's final compiler sources. The
[counts](derivative-temporary-storage-2026-11-02/verified-counts.json.gz) cover
six inputs, current/history forms, O1/O2, workspace off/on and both architectures.

With `d` coordinates and `u` updates, `p = (d - 1) * u` adjacent pairs are
differentiated. Every one of the 96 observations has these counts:

| Site | Retains | Current ownership rule |
|---|---:|---|
| First mapped input | `p` | Give the consuming callback a reference from its input list |
| Second mapped input | `p` | Do the same for the other input list |
| First field of the callback's tuple | `p` | Retain the field before releasing its original tuple owner |

For 129 coordinates and 199 updates, `p = 25,472`. These sites account for
76,416 of the current-only O2 solve's 77,411 retains: 98.7%. That is a measured
target, not proof that all those operations can be removed.

## Two proofs to develop together

**Move fields that already have separate owners.** The generated worker receives
two independently owned values, but ownership insertion still sees one tuple:

```text
Current:  retain first → name first → name second → release original first
Proposed: move first owner to its name → move second owner to its name
```

Prove exactly one owner for each value at the next potentially failing operation.
Start with complete, uninterrupted transfers. Repeated field reads, borrowed
parents, partial transfers and observable resources require their own proof;
do not remove operations just by matching generated C text.

A bounded first selection can inspect consecutive field bindings from the same
already-separated record: every field exactly once, followed by release of that
record, with no remaining parent use. Reject intervening calls, branches, traces
or resource frames. Inspect at most the existing direct-call field limit (eight),
then emit moves to the destination locals. Later call-liveness information stays
valid because ownership after the complete transfer is unchanged. Prove this on
the typed ownership expression before emitting C; preserve boxed entry cleanup.
Index the last local mentions once per eligible function, then check each group
against that index. Repeated continuation scans would become quadratic; the
index also checks enclosing continuations beyond the immediate group.

**Keep input elements borrowed through the callback.** Both input lists remain
alive during the eager map. A callback may use their element boxes without
owning them only when every call it forwards to obeys that contract too.

In the saved largest case, `w164` simply calls `w124(l1, l0)`. Neither parameter
is read afterward. Current inference requires continuing owners and excludes
nested records, so allowing one extra type or deleting argument retains is
insufficient. Compare an explicit ownership proof through those calls with
passing their numeric fields directly. Prefer the smaller sound implementation;
avoid an extra callable wrapper solely to bypass the ownership analysis.

## Delivery requirements

The first stage has [frozen field-transfer requirements](field-owner-transfer-protocol.md).
They require at least `p` fewer retains and leave mapper input ownership unchanged.
The separate [numeric-input protocol](numeric-callback-input-protocol.md) selects
passing numeric leaves and freezes its acceptance rules before second-stage code.

- Publish selection rules and numerical acceptance limits before compiler edits.
  Separate field-transfer savings (`p`) from input-preparation savings (`2*p`).
  Freeze a same-source reference that disables only the chosen change.
- Preserve arithmetic, output, callback/effect order and the packed buffer's
  allocation savings. Recheck all 96 observations, raw tape/workspace counters,
  peak storage and zero final storage; attribute each count change to its site.
- Compare both interpreters with native GCC/Clang O1/O2. Include identical/shared
  inputs, retained aliases, empty/unequal lists, direct/function-value calls,
  repeated/reordered/unused fields and excluded resource-bearing records.
- Test entry/intermediate traps, cancellation and allocation failure; count real
  destruction and require deliberately broken cleanup to fail.
- Bound additional compiler analysis and measure fixed representative inputs.
  Freeze that cost budget before implementation. Preserve the existing timing
  drivers and old failed limits; fewer retains alone do not establish speedup.
- Group implementation, controls, measurements and docs. Run focused checks while
  developing, then one complete final platform matrix after the batch is ready.

The [source audit](../../scripts/check-derivative-owner-sites.py) verifies archive
digests, all 48 saved C sources, site locations and every observation. It reads
retained evidence and does not execute saved code. Its required arguments name
both archives, the counts file, expected source and output report explicitly.
The [retained site report](derivative-owner-sites.json.gz) includes every C-source
hash, measured site and observation. Replay it with the ARM64/AMD64 count archives
identified in the [baseline verification](derivative-temporary-storage-2026-11-02/verification.md):

```sh
python3 scripts/check-derivative-owner-sites.py \
  --counts docs/measurements/derivative-temporary-storage-2026-11-02/verified-counts.json.gz \
  --arm64-archive /path/to/arm64-counts.zip \
  --amd64-archive /path/to/amd64-counts.zip \
  --source a4f3200c9b97b955c3f3603788eacbfac19fde4e \
  --output /path/to/owner-sites.json
```
