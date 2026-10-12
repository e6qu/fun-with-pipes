from pathlib import Path
import hashlib,json
root=Path('/Users/zardoz/projects/fun-with-pipes');out=Path('/private/tmp/fwp-accepted-numeric-source');report=json.loads((out/'phase3-acceptance.json').read_text());d=json.loads((out/'download.json').read_text());proof=json.loads(Path('/private/tmp/fwp-numeric-storage-merge-proof.json').read_text())
for n,h in d['hashes'].items():assert hashlib.sha256((out/n).read_bytes()).hexdigest()==h
assert report['accepted']==proof['sha'] and report['tree']==proof['tree']
p=root/'docs/development-state.md';s=p.read_text();a=s.index('## Main and next delivery');b=s.index('## Local checks and recovery',a);c=s.index('## Prepared next-phase investigation',b)
h=root/'docs/roadmap-history.md';hs=h.read_text();heading='## Accepted phase3 numeric representation';assert heading not in hs
h.write_text(hs+'\n\n'+heading+'\n\n'+s[a:b]+'\n\nActual merged-source acceptance:\n\n```json\n'+json.dumps(report,indent=2)+'\n```\n')
current=f'''## Main and verified coverage

Main is `{proof['sha']}` (PR #126), merged {proof['mergedAt']}.
Exact tested head `{proof['acceptedHead']}` passes all six jobs in
CI38207662016 and roadmap_docs38207662006. Signed squash subject
`{proof['subject']}` is one line, {proof['characters']} characters,
with no body or trailers. Its sole parent is `{proof['parents'][0]}`;
complete tree `{proof['tree']}` matches the tested head.
Actual merged-source audit38214129076 passes at driver{d['driver']}.
Hash-verified reports: /private/tmp/fwp-accepted-numeric-source.
Local checkout remains68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4.

Phases1–3 are accepted. Phase2 retains the explicit tracing compatibility model:
375 declarations,168 ownership contracts,19 IR combinators,11 flat signatures,
and177 fallback declarations/167 symbols. Phase3 adds natural1/2/4-byte numeric
payloads, bounded backing-owner views, concrete scalar/record worker ABI and
checked protocol/count paths. Storage and ABI preserve exact float bits;
arithmetic NaN payload choices retain the existing compiler contract. F16/BF16
and128-bit formats keep their documented existing representations. This does
not establish tracing-free execution or a timing improvement.
Original ownership, binary representation, omission, GC stress, reuse, actual
wasm32 count and platform controls pass. Completed sources, failure repairs and
measurements are archived in history; they no longer supply next actions.

## Remaining ownership deliveries

Queue33 and35–112 are accepted;34 is a verified duplicate. No resource ownership
preparation remains open. Phase6 must establish tracing-free eligibility and a
supported cycle policy; retain explicit compatibility fallbacks until then.

'''
nextwork='''## Active phase4 bundle

Preparation branch ownership-evidence-numeric-array-fusion at
d2b9a90d2eb61448f5caf282137ac5d4424a5266 passes Linux runner38212917636.
Formatted source/reports: /private/tmp/fwp-rust-numeric-workspace-evidence.
Eligible pure Array map/fold/length fusion removes intermediate allocations;
original effect/trap, recursion, exact finite bits and arithmetic NaN controls
pass. Native and interpreter AD workspace caches are bounded to512KiB with
scoped owners; matching tape bounds and allocator-fault controls pass. Native
cold/warm allocation, cancellation, reentrancy and shutdown controls pass;
interpreter buffer identity, adjoint zeroing, stale token and over-budget
controls pass. These focused checks are preparation, not merged phase4 support.
The prior2f run failed because publication omitted an updated signed-zero
fixture; e166 repaired it without weakening assertions. Earlier arithmetic
NaN payload equality was overconstrained; exact results remain recorded and
copy/storage/ABI bit guarantees remain unchanged.

Next finish normal/nested native workspace scopes and library-unload cleanup,
actual wasm32 AD bounds, guarded blocked F64 matrix execution and equivalent
C/Rust performance/memory profiles. Then validate the coherent bundle on
Linux and both Macs, export formatted source, open one production PR from
accepted main and require all six exact-head jobs plus roadmap_docs before
squash. Continue phases5–6 after actual merged-source acceptance. Fix encountered
bugs and failed controls throughout; CI waiting gates merges, not preparation.

'''
s=s[:a]+current+s[b:c]+nextwork
s=s.replace('593553e47efa314b9c2b5df1803d9620caa7d693','85ea2b6d130c86ff260f4ad1850f9eae444b5919').replace('audit38207907474','audit38213004389').replace('verifies201 targets/9603759 bytes','verifies292 targets/15295098 bytes').replace('fwp-verified-current-numeric-restoration','fwp-verified-numerics-workspace-restoration').replace('Phase2 is accepted; phases3–6 remain unfinished.','Phases1–3 are accepted; phases4–6 remain unfinished.')
s=s.replace('Current finalization and protocol refinements need the next checkpoint.','Current phase3 acceptance and Rust workspace preparation need the next checkpoint.')
p.write_text(s)
p=root/'PLAN.md';s=p.read_text().replace('| 3 | In progress:','| 3 | Done:').replace('| 4 | Pending:','| 4 | In progress:');a=s.index('Main through PR #125');b=s.index('## Validation limits',a);s=s[:a]+'''Main through PR #126 completes phases1–3. Packed numeric storage, bounded
owner-retaining views, typed worker ABI and checked count/protocol paths pass
all six exact-head jobs, documentation and actual merged-source acceptance.
The handoff records exact source and proof hashes. Tracing remains an explicit
compatibility fallback until phase6 meets its separate criteria.

Deliver fused numerical loops, guarded blocked matrices and bounded reusable
autodiff workspaces as one coherent phase4 bundle, preserving type inference,
Pipe semantics, ownership and floating/trap order. Then complete phases5–6.
Windows, new deployment interfaces and a new backend remain deferred.

'''+s[b:];a=s.index('For phase3, implement');b=s.index('For phase4, preserve',a);s=s[:a]+s[b:];p.write_text(s)
print('Recorded accepted phase3; phase4 is active')
