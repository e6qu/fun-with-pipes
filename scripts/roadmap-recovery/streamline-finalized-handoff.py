"""Keep the live handoff focused while retaining original evidence in history."""
from pathlib import Path
ROOT = Path('/Users/zardoz/projects/fun-with-pipes')
state_path = ROOT / 'docs/development-state.md'
old = state_path.read_text()
archive_heading = '## Resource bundle preparation before finalization'
history_path = ROOT / 'docs/roadmap-history.md'
history = history_path.read_text()
assert archive_heading not in history
start = old.index('## Autodiff tape bug fixes prepared for the next bundle')
end = old.index('## Local checks and durable recovery')
history_path.write_text(history + '\n' + archive_heading + '\n\n'
    'Historical preparation notes below preserve failures, repairs and proof paths.\n'
    'Their queued/pending statements describe earlier observations. The live handoff\n'
    'supersedes their next actions; finalization38163941948 now passes.\n\n'
    + old[start:end])
contract = old[old.index('## Execution contract'):old.index('## Main and next delivery')]
main = old[old.index('## Main and next delivery'):old.index('## Evidence and preservation requirements')]
main = main.replace('Actual-main documentation status must still be\ncollected; do not infer it from the PR gate.',
                    'Actual-main documentation38161107226 passes independently.')
a = main.index('Next delivery:')
main = main[:a] + '''Next delivery: resource/network items74–112 plus compiler/cache diagnostics,
autodiff tape/scoped-gradient lifetimes, list callback owners, closure cleanup
and inactive State root clearing. All focused prerequisites pass; finalization
38163941948 passes at driver77f4e22f5d3b280482e65616e5f03abae1ac350e.
It retains all85 original commits, applies verified source transformations on
the actual squash, preserves mandatory WASI and audits the actual inventory.
Next: publish the integrated export with an exact066b4970 lease, update docs,
open the sole production PR and require all six exact-head jobs plus roadmap_docs.
These integration/focused passes do not replace production gates.

Duplicate main CI38161107239 was cancelled while all six jobs were queued,
after complete-tree identity and all seven passing pre-merge gates were proved.
This is duplicate-run avoidance, not a passing main gate. Proof:
/private/tmp/fwp-main123-duplicate-ci-proof.json.

'''
rows = old[old.index('## Remaining ownership deliveries'):old.index('## Finish phase2, then continue the plan')]
rows = rows.replace('39-item runner rebase and full gates pending', 'Runner integration passed; production gates pending')
exit_review = old[old.index('## Finish phase2, then continue the plan'):start]
prefix = '''# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`, checkpoint
69fa8ff9c173a78dc8a8d7875e7ae44cc569305a. Its docs audit38162836405 was last
observed queued. It retains all11 docs and recovery recipes/helpers under
scripts/roadmap-recovery/. The running finalizer binds this immutable checkpoint.
Its latest driver receipt is /private/tmp/fwp-resource-finalization-driver-publication.json.
Preserve the next publication receipt and fresh docs in a new checkpoint after
publication; do not rerun completed publishers. Restore source by verified Git
blob hashes with restore-roadmap-recovery.py if temporary files disappear.
Source recovery is not runtime verification. Phases2–6 remain unfinished.

'''
evidence = '''## Current verified bundle evidence

| Work | Exact source / driver | Passing run |
|---|---|---|
| 85 original resource commits | preparation driver82c7bc7509c04b9e94004c06b02d83d665539ac6 | 38140923130 |
| Compiler failure and cache lifetime controls | 6f2ff860197831b990c2c918e25aa29871488ea3 | 38161909445 |
| AD bounds, tape cleanup and token retirement | 602e076604d3dd759c47b396c10cf848dd9dbb61 | 38139112950; Linux/ARM/Intel |
| Scoped gradients and owned F64 results | fbc7e38087b3708c60d21302e29b9013c7d6fa2c | 38159488927; Linux/ARM/Intel |
| Equivalent gradient allocation comparison | 9ae50851389fbfa7c5c155fca477a4b958589c99 | 38159536008; Linux/ARM/Intel |
| List/closure/State controls and allocation comparison | 4f21a9ea99c1a06a3f1ba67818936194fe43e42a | 38160607296; Linux/ARM/Intel |
| Integrated export and primitive inventory | 77f4e22f5d3b280482e65616e5f03abae1ac350e | 38163941948 |

The finalizer verifies downloaded allocation reports and their source/binary
hashes. Scoped gradients add no steady-state managed calls/bytes on the tested
4096-call O1/O2 workload and preserve five external buffer calls per gradient.
List ownership adds no managed calls/bytes on the tested2048-call O1/O2 workload,
reduces shared-count clears and increases counted-storage reclamation. These
are workload-specific allocation results, with no timing or tracing-free claim.

All original controls remain: raw FWP_NO_OPT=1/native semantics, real collection,
GC/reuse verification, O1/O2, callback/trap order, allocation failure, task
cancellation and exact omission exits before invalid reads. Native compiler
failures now fail the GC gate; diagnostics include stdout/stderr/status/signals.
Cache pruning protects the returned executable and retains at least one entry.
AD bounds/identity cleanup preserves consumption and failure precedence; slots
retire at generation32767 rather than wrapping. Internal scopes preserve public
Pipe signatures. List.ap/flat-map own callback results and counted spines.
Closure nonlocal cleanup clears discarded work contexts and releases spills.
State pop/restore/task exit clear inactive scanned words without changing active
suspended states or proving typed State ownership. Final production gates remain
required for this combination. Detailed failures and controls are in
[preparation history](roadmap-history.md#resource-bundle-preparation-before-finalization).

The read-only finalizer exports complete snapshots instead of pushing with a
runner App. The publisher verifies blob hashes, all snapshot trees, one-line
subjects, parent chains and original metadata instants. Empty commits reuse
their parent's tree. Publication uses GitHub beforeOid as an exact branch lease.
Current prepared branch066b497040ff7b7f59fec6ff3337c63428f83d77 is not yet the
integrated production head. Export metadata is retained in
/private/tmp/fwp-resource-network-finalized-export; binaries stay on GitHub.

'''
local = '''## Local checks and recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local
workloads are serial, low priority and guarded: sampled aggregate RSS below1GiB,
target below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits;
never raise or bypass them. Use `python3 scripts/local-guard.py COMMAND...` for
fwp checks. The fun-refactor guard applies to that other repository.
Latest disk observation:38,958,772KiB available, about37.2GiB. No local compiled
check, broad doc audit, rebase or fast-forward ran. Only source edits and bounded
remote metadata publication/downloads ran serially at low priority.

Protect all11 authoritative docs before any guarded main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md,
docs/ownership.md, docs/primitive-ownership.md, docs/roadmap-queue.md,
docs/roadmap-history.md, docs/reference.md, docs/concurrency.md, docs/numerics.md.
Actual pre-acceptance hashed backup: /private/tmp/fwp-main-docs-remote-pre123.
Do not claim a local fast-forward or byte-for-byte restore that did not run.
Preserve other user changes. Last Rust checkout was
/private/tmp/fwp-library-resource-bundle-worktree; source identities require
guarded cleaning before switching compiled checkouts when resources permit.
Immutable tags, remote source heads and retained receipt hashes survive temporary
file loss. Never treat an earlier head, skipped check or source snapshot as a
passing production gate.
'''
state_path.write_text(prefix + contract + main + evidence + rows + exit_review + local)
primitive = ROOT / 'docs/primitive-ownership.md'
text = primitive.read_text().replace('This gate is prepared, not executed.',
    'The integrated candidate audit passes in finalization38163941948; its regular\nproduction gates and actual merged-source exit review remain required.')
text = text.replace('Both repairs remain pending focused\nLinux/macOS evidence and final bundle gates.',
    'Both repairs pass focused Linux/ARM/Intel evidence38160607296; final bundle\ngates remain required.')
text = text.replace('alias/error and real scheduler controls remain pending.',
    'alias/error and real scheduler controls pass the same focused matrix.')
primitive.write_text(text)
print('Live handoff shortened; original preparation evidence retained in history')
