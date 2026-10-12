"""Advance the live roadmap only after exact merged-source acceptance evidence."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes');OUT=Path('/private/tmp/fwp-accepted-phase2-source')
report=json.loads((OUT/'phase2-acceptance.json').read_text());download=json.loads((OUT/'download.json').read_text());proof=json.loads(Path('/private/tmp/fwp-phase2-exit-merge-proof.json').read_text())
for name,digest in download['hashes'].items():assert hashlib.sha256((OUT/name).read_bytes()).hexdigest()==digest
assert report['head']==proof['sha'] and report['testedHead']==proof['acceptedHead'] and report['tree']==proof['tree']
assert report['status']=='Phase2 accepted source coverage verified; phase3 may proceed'
remote=json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/git/ref/heads/main'],text=True));assert remote['object']['sha']==report['head']
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()=='68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
texts={name:(ROOT/name).read_text() for name in DOCS};heading='## Accepted phase2 ownership exit';assert heading not in texts['docs/roadmap-history.md']
state=texts['docs/development-state.md'];start=state.index('Main is `');end=state.index('## Local checks and recovery',start)
texts['docs/roadmap-history.md']+='\n\n'+heading+'\n\n'+state[start:end]+'\n\nVerified exact merged-source acceptance:\n\n```json\n'+json.dumps(report,indent=2)+'\n```\n'
ci=report['gates']['CI']['run'];docs=report['gates']['Roadmap documentation']['run']
current=f'''Main is `{report['head']}` (PR #{report['pr']}). Exact head
`{report['testedHead']}` passes all six jobs in CI{ci} and roadmap_docs{docs}
before squash at {report['mergedAt']}. The one-line subject `{report['subject']}`
has {len(report['subject'])} characters and no body, trailers or attribution.
One parent `{report['parent']}` and complete tree `{report['tree']}` are verified
against the signed commit payload and tested tree. Actual merged-source
acceptance passes runner{download['run']} at driver{download['driver']}.
Reports are retained in /private/tmp/fwp-accepted-phase2-source. Local main stays
68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4; no local compiled checks or fast-forward ran.

## Current verified coverage

Phase2 is complete for the documented compatibility model. All375 declarations
are inventoried:168 contracts,19 IR combinators,11 flat signatures and177
explicit fallback declarations covering167 runtime symbols. The actual merged
source verifies argument/result/callback, retention, teardown and cycle policies.
Tracing remains required for unmodeled graphs and unreachable shared cycles;
this acceptance does not establish tracing-free execution.

Buffer growth/allocation failure, array sizes, bump initialization/alignment,
kernel stack and constant decoding, and device output/workspace bounds pass
original semantic, binary, sanitizer, omission, GC and reuse controls. Interpreter
and native paths preserve checked arithmetic and observable validation/trap order.
Node24 CI actions and current documentation pass final production gates.
Earlier resource/State/AD allocation profiles and immutable queue anchors stay
in history; no new timing or GPU hardware claim follows.

## Remaining ownership deliveries

Queue33 and35–112 are accepted;34 is a verified duplicate. No resource ownership
preparation remains open. Phase6 still requires tracing-free eligibility and a
supported cycle policy; retain explicit compatibility fallbacks until then.

## Next concrete action

Deliver phase3 in one coherent representation/ABI bundle: descriptor-directed
naturally packed narrow numeric arrays, checked views retaining their backing
owners, and typed scalar/aggregate worker layouts with ordinary V bridges.
Start from the actual accepted main above; preserve Pipe semantics and all
existing generic, callback, ownership and exceptional controls. Prove exact
bytes, alignment, immutable update behavior, serialization/hash/FFI compatibility
and actual ARM/Intel ABI assembly before performance claims. Source preparation:
fwp-numeric-representation-design-preparation.json and its verified source
manifest. Refresh those snapshots to this accepted base before implementing.
Finish phases3–6 with full exact-head gates and one-line squash messages.

'''
local=state[end:]
if 'The cancelled d5 Linux log' in local:
 a=local.index('The cancelled d5 Linux log');b=local.index('Recovery checkpoint',a);local=local[:a]+local[b:]
texts['docs/development-state.md']=state[:start]+current+local
plan=texts['PLAN.md'];lines=[]
for line in plan.splitlines():
 if line.startswith('| 2 |'):line='| 2 | Done: typed ownership and explicit runtime compatibility fallbacks | Accepted merged-source coverage; callback/unwind/resource, alias, GC/reuse and reclamation controls |'
 if line.startswith('| 3 |'):line=line.replace('| Pending:', '| In progress:')
 lines.append(line)
plan='\n'.join(lines)+'\n';a=plan.index('## Current delivery');b=plan.index('## Validation limits',a)
plan=plan[:a]+f'''## Current delivery

Main through PR #{report['pr']} completes phase2's documented ownership model.
All177 remaining runtime declarations explicitly retain compatibility fallback;
tracing-free execution remains phase6. Resource and network queue anchors are
accepted and archived. Checked allocation/kernel boundaries and current CI
pass the exact final head and actual merged-source audit. The handoff records
those proofs and the actual base for phase3.

Next deliver natural-width numeric arrays, checked owner-retaining views and
typed worker ABI layouts in one coherent bundle. Preserve existing type inference,
Pipe semantics, ownership and trap order. Then complete phases4–6. Windows,
new deployment interfaces and a new backend remain deferred.

'''+plan[b:]
a=plan.index('Finish phase2',plan.index('## Concrete remaining deliveries'));b=plan.index('For phase3,',a);plan=plan[:a]+plan[b:];texts['PLAN.md']=plan
p=texts['docs/ownership.md'];a=p.index('## Ownership coverage');b=p.index('## Original resource semantics',a)
p=p[:a]+'''## Ownership coverage

Phase2 is accepted against the actual merged source recorded in the handoff.
All375 declarations are inventoried:168 contracts,19 IR combinators,11 flat
signatures and177 explicit fallback declarations/167 symbols. Their argument,
result, callback, retention, teardown and cycle policies are checked against the
compiler and runtime. This establishes the documented compatibility model.

Reconstructed/decoded graphs and cached/retained contexts require tracing unless
a typed contract proves their complete graph and teardown. Channel close preserves
queued values; draining breaks the tested counted cycle. Unreachable shared cycles
still require tracing. Natural numeric storage/views and later optimized kernels
must preserve these lifetimes. Optional tracing-free execution remains phase6.

'''+p[b:];texts['docs/ownership.md']=p
p=texts['docs/primitive-ownership.md'];a=p.index('## Prepared refinements');b=p.index('## Validation and limits',a)
texts['docs/primitive-ownership.md']=p[:a]+'''## Accepted ownership review

The finite177-declaration/167-symbol fallback review passes against the actual
merged source. All168 explicit contracts and remaining IR/flat boundaries are
inventoried. Original preparation and accepted binary/GC/reuse/omission controls
are retained in history and the immutable queue. Numeric representation and
tracing-free eligibility remain later work; no blanket no-GC claim is established.

'''+p[b:]
for name in DOCS:
 texts[name]=texts[name].replace('primitive-ownership.md#prepared-refinements','primitive-ownership.md#accepted-ownership-review')
 texts[name]=texts[name].replace("PR125's finite fallback classification still requires its final gates and\nactual merged-source audit before phase2 exit.", "The finite fallback classification passes against the actual accepted source;\nthe handoff records its exact gates and acceptance proof.")
 texts[name]=texts[name].replace('Finish PR125 and the actual merged-source finite coverage review before\nphase 3.', 'The actual merged-source finite coverage review passes after PR125 acceptance.\nPhase3 must preserve these contracts and explicit fallbacks.')
 texts[name]=texts[name].replace('Classify these conservative requirements explicitly before phase 3; phase 6 must\nprove eligibility separately.', 'These conservative requirements are explicitly classified in accepted phase2.\nPhase6 must prove tracing-free eligibility separately.')
backup=Path('/private/tmp/fwp-main-docs-pre-phase2');assert not backup.exists();backup.mkdir();hashes={}
for name in DOCS:
 data=(ROOT/name).read_bytes();destination=backup/name;destination.parent.mkdir(parents=True,exist_ok=True);destination.write_bytes(data);hashes[name]=hashlib.sha256(data).hexdigest()
(backup/'sha256.json').write_text(json.dumps(hashes,indent=2)+'\n')
for name,text in texts.items():(ROOT/name).write_text(text)
print('Recorded actual phase2 acceptance; phase3 is current, phases3–6 remain open')
