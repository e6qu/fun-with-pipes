# Delivery evidence

This is an index of completed deliveries and their test records. Current work
belongs in [the plan](../PLAN.md) and [session handoff](development-state.md).
Historical development runs may include failures later fixed; they are not new
tasks. The [preparation table](roadmap-queue.md) preserves original commit IDs.

A PR is a proposed change. Its **tested head** is the exact commit checked by CI
(continuous integration on GitHub runners). A **squash merge** makes one main-branch
commit from the PR. “Same files” means the tested head and merge have identical
Git trees, even though their commit IDs differ. A focused test run checks a subset;
production acceptance requires every platform job applicable to that delivery.
Cancelled, skipped or partially passing runs are not acceptance.

## Accepted deliveries

Earlier deliveries established native macOS ([PR #74](https://github.com/e6qu/fun-with-pipes/pull/74)),
ownership and representation ([#124](https://github.com/e6qu/fun-with-pipes/pull/124),
[#125](https://github.com/e6qu/fun-with-pipes/pull/125),
[#126](https://github.com/e6qu/fun-with-pipes/pull/126)), numerical kernels
([#127](https://github.com/e6qu/fun-with-pipes/pull/127)), checked reference counting
([#128](https://github.com/e6qu/fun-with-pipes/pull/128)), documentation and tacit
examples ([#129](https://github.com/e6qu/fun-with-pipes/pull/129),
[#130](https://github.com/e6qu/fun-with-pipes/pull/130)), and direct iterator
consumers ([#131](https://github.com/e6qu/fun-with-pipes/pull/131)). Their original
source IDs and gate links remain in the
[immutable record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#accepted-deliveries).

The following accepted merges have the same files as their tested heads. Before
PR #136 the production matrix had fewer jobs and did not establish complete
native Windows support. From #136 onward it requires all nine production jobs
plus documentation.

| PR | What changed | Merge / tested head | Passing production / docs |
|---|---|---|---|
| [#132](https://github.com/e6qu/fun-with-pipes/pull/132) | Linux ARM64, fewer iterator temporaries and more counted values | `c67800ec` / `7036eceb` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034611), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38381034667) |
| [#133](https://github.com/e6qu/fun-with-pipes/pull/133) | Owned decoding results and direct wide-number functions | `d14ec10d` / `70de8497` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073356), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073506) |
| [#134](https://github.com/e6qu/fun-with-pipes/pull/134) | More C/WASM ownership, numeric foundations and Windows groundwork | `5c0287c9` / `29b48c31` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467) |
| [#136](https://github.com/e6qu/fun-with-pipes/pull/136) | Complete Windows native support, float formats, nested derivatives and checkpointing | `2684241d` / `26f2c68a` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38583750060), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38583749770) |
| [#137](https://github.com/e6qu/fun-with-pipes/pull/137) | Store/scan only the derivative prefix needed by requested outputs | `38da1401` / `37104959` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927) |
| [#138](https://github.com/e6qu/fun-with-pipes/pull/138) | Stop storing operation metadata for original derivative inputs | `d77b3fea` / `f251fbd1` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38666526202), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38666481103) |
| [#139](https://github.com/e6qu/fun-with-pipes/pull/139) | Grow the active-tape table in chunks and preserve reusable buffers | `5d05cdd6` / `917d28a3` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38690176314), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38690140952) |
| [#140](https://github.com/e6qu/fun-with-pipes/pull/140) | Skip tape-table slots already known to be unavailable | `09f1a029` / `cdb76905` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38710624989), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38710579729) |
| [#141](https://github.com/e6qu/fun-with-pipes/pull/141) | Pair derivative metadata arrays to reduce allocation requests | `41f30475` / `f31f7b66` | [Production](https://github.com/e6qu/fun-with-pipes/actions/runs/38728631817), [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38728600304) |

PR #135 was merged before complete platform acceptance. PR #136 fixed the
remaining failures and supplied the full passing gate; #135's merge alone is
not support evidence. All eleven implementation steps in the current plan are
complete through #141. “Complete” describes that finite plan, not universal
collector-free execution or equal performance with C.

## Accepted paired metadata allocations (PR #141)

[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141) merged as
`41f30475c5e59951e784fe686aa6c69c7f2738e3`. Its tested head was
`f31f7b66b8ea625c86161cf2978732bcd9be310d`, with identical files.
[Four-platform derivative tests](https://github.com/e6qu/fun-with-pipes/actions/runs/38726490082)
and [both WebAssembly checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38726508454)
passed at runtime revision `24620eadbcc8c03fa1aefc2190bf1af483720840`.
The final production/docs gates are in the table above.

[Recorded measurements](measurements/ad-metadata-2026-10-15.json) compare two fwp
storage layouts. Pairing buffers reduces allocation requests, but growth copies
more bytes in some cases. Timings are mixed, including regressions; the
[benchmark guide](benchmarks.md#paired-autodiff-metadata-allocations) states the
comparison and limits. This is not a measurement against another language.

The squash subject was `Pair native autodiff metadata allocations`, with no body
or trailers. Final guarded verification took 6.90 seconds and merge/tree/message
verification 0.73 seconds. Duplicate post-merge production run `38740848937` was
cancelled only after verifying the same files and accepted PR gates; it is not
an additional passing gate.

## Historical detail

The sections below keep stable links used by other documents while replacing
obsolete session instructions with descriptions of the evidence. The immutable
snapshot retains the full original records, including failed or superseded runs.
Do not use their old “next” actions as the current plan.

## Accepted registry cursor follow-up (PR #140)

The active-tape search skips known occupied slots. At 16,384 simultaneous tapes
the recorded workload avoids 134,209,536 slot visits without extra heap allocation.
Small timing cases are mixed; arbitrary holes can still require linear search.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#accepted-registry-cursor-follow-up-pr-140).

## Archived numerics timing samples

These early timings lack recorded processor/compiler/flags and memory counts.
They are historical observations, not a current cross-language baseline.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#archived-numerics-timing-samples).

## Archived tensor kernel timing samples

These early samples include input construction on an unspecified loaded host.
They cannot establish current kernel speed or platform performance.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#archived-tensor-kernel-timing-samples).

## Archived representation measurement detail

Shape-specific binary layout and allocation probes motivated later changes.
Current representation rules are in [ownership](ownership.md).

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#archived-representation-measurement-detail).

## Archived primitive contract notes through queue18

Early tests checked which calls borrowed, retained or transferred references.
Use [primitive ownership](primitive-ownership.md) for the current contracts.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#archived-primitive-contract-notes-through-queue18).

## Recovery evidence

The old recovery checkpoint was `3af176bc210cd9de367bbdf98d2eb49b2626098f`
on `roadmap/handoff-pr123-20261011`. It is historical recovery evidence, not an
instruction to restore or republish already merged preparation branches.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#recovery-evidence).

## Ten-task platform and ownership bundle (PR #132)

This bundle added native Linux ARM64, combined iterator work and more typed
reference-counted results. [Measurements](measurements/native-ownership-2026-10-13.json)
separate managed result allocations from reusable derivative buffers.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#ten-task-platform-and-ownership-bundle-pr-132).

## Seven-step reconstruction and numerics bundle (PR #133)

Decoding and CLI values gained owned results; known iterator producers and wide
number functions avoided temporary objects. [Measurements](measurements/reconstruction-and-workers-2026-10-13.json)
record allocation and native-instruction evidence. Windows and true half/quad
formats were completed later, not by this delivery.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#seven-step-reconstruction-and-numerics-bundle-pr-133).

## PR #134 development evidence (not final acceptance)

Focused runs tested numeric software cores, decimal syntax, iterator production,
Windows foundations and WebAssembly reclamation. Some runs failed or were replaced;
only the final acceptance in the table establishes this delivery.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-134-development-evidence-not-final-acceptance).

## PR #134 merge closeout

The accepted subset supplied the foundations listed above. Its then-pending
float representations, Windows runtime and nested derivatives were completed in
later PRs; those old next actions are no longer active.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-134-merge-closeout).

## PR #135 development evidence

This PR introduced nested derivatives, checkpointing, actual float formats and
broader ownership, but merged before the final platform gate. Windows TLS and
other acceptance issues were resolved in #136. [Wide-record measurements](measurements/wide-records-2026-10-14.json)
and [checkpoint measurements](measurements/checkpoint-2026-10-14.json) retain scope.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-135-development-evidence).

## PR #136 implementation verification

An initial full run passed eight jobs; Intel macOS hit its existing time limit.
Moving REST/wide-worker tests between the two shards preserved total coverage
and allowed the subsequent complete acceptance. Limits were not increased.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-136-implementation-verification).

## PR #136 merge acceptance

All nine production jobs and documentation passed at the tested head in the
table. This accepted the complete six-step bundle, including both native Windows
architectures. The implementation verification run alone was not that gate.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-136-merge-acceptance).

## PR #137 focused evidence

The [prefix measurements](measurements/ad-prefix-2026-10-14.json) reduce peak tape
storage by 98,304 bytes for an unused recorded suffix. Forward work is unchanged
and timings show no consistent speedup.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-137-focused-evidence).

## PR #137 merge acceptance

The final production gate accepted the shorter backward storage/scan range
with validation order, seed arithmetic and cleanup preserved.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-137-merge-acceptance).

## PR #138 merge acceptance

Operation records no longer include input nodes. [Measurements](measurements/ad-operations-2026-10-15.json)
show lower storage, more cold growth requests in some cases and no consistent
speedup. Absolute node identities and input adjoints remain unchanged.

[Original test and source record](https://github.com/e6qu/fun-with-pipes/blob/41f30475c5e59951e784fe686aa6c69c7f2738e3/docs/roadmap-history.md#pr-138-merge-acceptance).
