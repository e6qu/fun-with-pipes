# Close the live roadmap only after verified merge and source acceptance.
from pathlib import Path
import json
root=Path('/Users/zardoz/projects/fun-with-pipes')
proof=json.loads(Path('/private/tmp/fwp-ownership-merge-proof.json').read_text())
a=json.loads(Path('/private/tmp/fwp-accepted-ownership-source/phase5-6-acceptance.json').read_text())
audit=json.loads(Path('/private/tmp/fwp-accepted-ownership-source/download.json').read_text())
assert (a['accepted'],a['tested'],a['tree'])==(proof['sha'],proof['acceptedHead'],proof['tree'])
assert a['status'].startswith('Actual merged-source phases5–6 accepted:')
required={'test','bench','macos (macos-15)','macos (macos-15-intel)','macos_gc (macos-15)','macos_gc (macos-15-intel)'}
assert {j['name'] for j in a['gates']['CI']['jobs']}==required
assert all(j['status']=='completed' and j['conclusion']=='success' for g in a['gates'].values() for j in g['jobs'])
assert len(proof['subject'])<=80 and '\n' not in proof['subject']
pr=proof['pr'];ci=a['gates']['CI']['run'];docs=a['gates']['Roadmap documentation']['run']
p=root/'PLAN.md';s=p.read_text().replace('| 5 | In preparation: broaden ownership/performance regression evidence |','| 5 | Done: ownership/performance regression evidence |').replace('| 6 | In preparation: checked native ARC execution after coverage |','| 6 | Done: checked native ARC execution for the proved ownership subset |')
start=s.index('## Current delivery');end=s.index('## Validation limits',start)
s=s[:start]+f'''## Completed roadmap

Phases1–6 are accepted on main through PR #{pr}. Native macOS ARM/Intel support,
runtime ownership contracts, packed numeric storage and views, typed aggregate
ABI, fused numerical kernels, blocked matrices, bounded reusable autodiff
workspaces, loop ownership improvements and checked native ARC execution pass
their required gates. The handoff records the tested and merged sources,
all six jobs, documentation and actual merged-source acceptance.

ARC support is explicit: admitted immutable graphs and scoped File owners
reclaim without tracing. Unproved mutable cycles, boxed I128/U128 owners, raw
reverse-mode tapes/pointers and external/deployment boundaries remain rejected.
The retained C/Rust comparisons make no universal speedup or parity claim.
No implementation task remains in this roadmap. Windows, new
deployment interfaces and a new backend remain outside its scope.

'''+s[end:]
start=s.index('## Concrete remaining deliveries')
s=s[:start]+'''## Completion boundary

Keep supported memory-mode boundaries and original Pipe semantics intact.
Existing tracing-mode features remain available; ARC never switches to tracing
when eligibility fails. Future coverage or performance work must start from the
retained measurements and current handoff rather than an archived next action.
''';p.write_text(s)
p=root/'docs/development-state.md';old=p.read_text();recovery=old[old.index('Durable recovery branch:'):old.index('## Execution contract')]
recovery=recovery.replace('Phases1–4 are accepted; PR #128 delivers phases5–6.','All six phases are accepted; no implementation delivery remains.')
p.write_text(f'''# Session handoff

Updated 2026-10-12. The active roadmap is complete. Read [PLAN](../PLAN.md),
[design](design.md) and [ownership](ownership.md) for the accepted scope.
[History](roadmap-history.md) preserves prior evidence; the immutable
[queue](roadmap-queue.md) does not supply new work.

'''+recovery+f'''
## Accepted source and gates

PR #{pr} is squash-merged at `{proof['sha']}`.
Tested head: `{proof['acceptedHead']}`.
Complete tree: `{proof['tree']}`. The signed squash has one parent and exactly
the tested tree. Its complete message is the single line
`{proof['subject']}` ({proof['characters']} characters), with no body or trailers.
All six jobs pass at the tested head in CI{ci}; roadmap_docs{docs} passes.
Actual merged-source audit{audit['run']} at driver{audit['driver']}
verifies hashes, the full source delta, primitive
inventory, compatibility review and that all gates completed before merge.

Proofs: fwp-ownership-final-gate-proof.json, fwp-ownership-merge-proof.json,
fwp-ownership-signed-payload.txt and /private/tmp/fwp-accepted-ownership-source.
The acceptance audit publication and download receipts identify driver and run.
Never substitute a skipped, superseded or cancelled run for a passing gate.

## Delivered scope and evidence

Phases1–4 deliver native macOS on both architectures, checked runtime ownership
boundaries, natural-width numeric storage and retained views, typed scalar/record
workers, fused array kernels, guarded blocked matrices and bounded reusable
reverse-mode autodiff workspaces. Phase5 removes per-element loop-field counts,
unneeded scalar unwind scopes and mutable descriptor dispatch. Phase6 adds
checked native ARC with physical reclamation and actual binary controls.
Fusion registers synthesized Step variants; eligibility uses their ordinary
variant metadata. Inlining preserves constructed and compile-time aggregate
types. Return-origin and field tracking preserve unboxed aggregates through
typed aliases and intervening bindings. Allocation, owned-child and observable
effect regressions cover these paths. Formatting renders directly into a
cleanup-protected buffer.

Preparation350500f2 passes all three complete jobs in38242709162. Each target
executes21 named ARC corpus cases, reports47 eligibility rejections and verifies
3 expected compilation errors (71 entries), with seven native disassemblies.
Normal-return ledgers require zero new charged live storage and zero collections;
missing-free and forced-tracing controls fail deliberately. The original deep
recursion native/golden control also has a bounded raw-interpreter counterpart.
The production matrix additionally verifies removal of the Step-by-name exception.

Reports: docs/measurements/numerical-kernels-2026-10-12.json and
ownership-and-arc-2026-10-12.json in the same directory. Sources, hardware/flags,
allocations, counts, live memory, timings and uninstrumented assembly are in
/private/tmp/fwp-complete-ownership-platform-evidence and
/private/tmp/fwp-complete-arc-platform-evidence. Numerical timings describe the
existing memory mode; explicit ARC evidence is separate. No universal speedup
or C/Rust parity is claimed.

ARC accepts proved immutable counted graphs and scoped File owners. Unproved
mutable cycles, raw reverse-mode tape/pointer lifetimes, boxed I128/U128 without
counted owners, custom native signatures and foreign/deployment boundaries are
explicitly rejected. Rejection never selects tracing. Existing tracing-mode
features remain available. Register spills are normal lowering; protocol-defined
alternatives are peers. Avoid needless wrappers/fallbacks and hidden defaults.

## Remaining ownership deliveries

None. The accepted source satisfies all six implementation phases. Final
documentation delivery is described below.

## Local workspace and next action

The local source checkout remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4.
Free disk was54GiB, below the required64GiB reserve; target data was101MiB.
No local build, checkout, rebase or fast-forward ran below the reserve. Accepted
implementation sources are on main and in retained artifacts; local docs are
current. Preserve all12 authoritative docs and user changes before any later
synchronization. Use the fwp guard in CONTRIBUTING.md for local checks, never
the other repository's fr guard. Full workloads remain on GitHub runners.

No implementation or defect task remains. Final documentation delivery uses
complete-language-roadmap-docs. If its PR is open, finish all required gates
and the authorized single-line squash; once merged, no roadmap task remains.
Do not reopen archived preparations or repeat completed publication/download
helpers. Preserve
these proofs and the current recovery snapshot. Windows, new deployment
interfaces and a new backend remain deferred, not automatic next tasks.
''')
p=root/'docs/ownership.md';s=p.read_text().replace('Optional tracing-free execution remains phase6.','Checked native ARC has the eligibility boundaries below.').replace('requirements until phase 6 proves eligibility for execution without collection.','requirements at unproved boundaries, which checked native ARC explicitly rejects.').replace('The phase6 preparation checks `--gc arc`','The compiler checks `--gc arc`').replace('subject to the current preparation/production gates in the handoff.','covered by the accepted production gates recorded in the handoff.').replace('The handoff records the current preparation and production gates.','The handoff records the accepted source and production gates.');p.write_text(s)
p=root/'docs/primitive-ownership.md';t=p.read_text().replace('compatibility model; phase6 must separately prove tracing-free eligibility and\nits cycle policy.','compatibility model. Checked native ARC separately enforces its proved eligibility\nand cycle policy, rejecting these unproved shared boundaries.');p.write_text(t)
p=root/'docs/design.md';t=p.read_text().replace('The prepared `fwp build --gc arc` mode','The `fwp build --gc arc` mode');p.write_text(t)
p=root/'docs/reference.md';s=p.read_text().replace('The prepared `--gc arc` mode','The `--gc arc` mode');p.write_text(s)
p=root/'docs/numerics.md';s=p.read_text().replace('The accepted phase4 implementation allocates no array intermediates but still\nretains/releases its carried array once per element. Matrix multiplication allocates one output;','The current implementation allocates no intermediate arrays and performs no\nper-element retains/releases of its carried array. Matrix multiplication allocates one output;').replace('Phase5 targets the per-element counts; the two public-boundary Matrix records\nremain explicit representation costs.','The two public-boundary Matrix records remain explicit representation costs.').replace('Phase5 preparation gives flat loop fields independent owners and removes','Flat loop fields have independent owners, removing');p.write_text(s)
p=root/'docs/numerics.md';s=p.read_text().replace('[../PLAN.md](../PLAN.md) tracks the remaining performance evidence and checked\nnative ARC delivery.','[../PLAN.md](../PLAN.md) records the completed roadmap, retained performance\nevidence and checked native ARC scope.');p.write_text(s)
p=root/'docs/ownership.md';s=p.read_text().replace('## Remaining ownership coverage','## Ownership boundaries').replace('Remaining work is measured optimization\nand the eligibility/cycle policy for optional tracing-free execution.','Measured optimizations and checked native ARC enforce the eligibility and\ncycle policy below.').replace('Extend measured borrowing and deterministic cleanup to the remaining container,\ncallback and runtime boundaries in focused changes.','Future extensions to borrowing or deterministic cleanup must preserve these\ncontainer, callback and runtime contracts; they are outside the completed roadmap.');p.write_text(s)
p=root/'docs/roadmap-history.md'
p.write_text(p.read_text()+f'\n## Accepted final ownership and ARC bundle (PR #{pr})\n\n'
    +f'Merged{proof["sha"]} has tested tree{proof["tree"]}, with all six jobs in CI{ci}, '
    +f'roadmap_docs{docs} and actual-source audit{audit["run"]} passing. '
    +'The complete signed message is one line without trailers.\n\n'
    +'Post-lowering eligibility exposed four lost temporary types at a2500e0f. '
    +'Head2d4bf66a registered synthesized Step fields and restored three cases; '
    +'its failed/cancelled run38242127912 identified a compile-time record whose type '
    +'inlining discarded. Head350500f2 retains aggregate constant types and passes '
    +'all three complete jobs in38242709162 with21 named ARC executions,47 rejections '
    +'and3 expected compiler errors per platform. Production removes the Step-by-name '
    +'exception and passes the full matrix. Failure IR and reports remain in '
    +'fwp-arc-step-type-failure; final platform artifacts and source acceptance are '
    +'retained by the designated recovery map. These records supply no new next task.\n')
print('Closed all six roadmap phases after accepted source',proof['sha'])
