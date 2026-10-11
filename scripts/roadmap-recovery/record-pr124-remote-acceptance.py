"""Archive PR124 evidence only after verified exact-head squash acceptance."""
from pathlib import Path
import hashlib,json,re,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes')
HEAD='d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0';BASE='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
proof=json.loads(Path('/private/tmp/fwp-pr124-merge-proof.json').read_text());gates=json.loads(Path('/private/tmp/fwp-pr124-final-gate-proof.json').read_text())
assert proof['acceptedHead']==HEAD and proof['parents']==[BASE]
assert proof['verification']=='GitHub verified signed commit payload'
for gate in [gates['ci'],gates['docs']]:
 assert gate['headSha']==HEAD and gate['status']=='completed' and gate['conclusion']=='success'
 assert all(j['status']=='completed' and j['conclusion']=='success' and j['completedAt']<=proof['mergedAt'] for j in gate['jobs'])
assert len(gates['ci']['jobs'])==6 and len(gates['docs']['jobs'])==1
remote=json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/git/ref/heads/main'],text=True));assert remote['object']['sha']==proof['sha']
local=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip();assert local=='68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'
texts={n:(ROOT/n).read_text() for n in DOCS};state=texts['docs/development-state.md'];history=texts['docs/roadmap-history.md'];heading='## Archived handoff after PR #124';assert heading not in history
rows=[line for line in state.splitlines() if re.match(r'^\| (?:7[4-9]|[89][0-9]|10[0-9]|11[0-2]) ',line)];assert len(rows)==39
primitive=texts['docs/primitive-ownership.md'];prows=[line for line in primitive.splitlines() if re.match(r'^\| (?:7[4-9]|[89][0-9]|10[0-9]|11[0-2]) \|',line)];assert len(prows)==39
start=state.index('Main is `');end=state.index('## Next bundle preparation',start)
pa=primitive.index('## Prepared refinements');pb=primitive.index('## Validation and limits',pa)
texts['docs/roadmap-history.md']=history+'\n\n'+heading+'\n\n'+state[start:end]+'\n\nAccepted resource/primitive preparation:\n\n'+primitive[pa:pb]+'\nVerified acceptance: '+json.dumps(proof,sort_keys=True)+'\n'
new=f'''Main is `{proof['sha']}` (PR #124). Frozen head `{HEAD}` passes all six
jobs in CI38180852377 and roadmap_docs38180852369 before match-head squash
at {proof['mergedAt']}. Subject `{proof['subject']}` has{proof['characters']} characters,
one line and no body/trailers/attribution. One parent `{BASE}` and complete
tree `{proof['tree']}` match the tested head. Raw signed payload:
fwp-pr124-signed-payload.txt. All11 docs were backed up before these acceptance
edits in /private/tmp/fwp-main-docs-remote-pre124. Local main remains `{local}`;
no local fast-forward or compiled check ran while free disk is below64GiB.

Queue33 and35–112 are accepted;34 is a verified duplicate. PR124 accepts resource
and network owners, compiler/cache/effect repairs, scoped AD and list/closure
lifetimes, typed State and14 fresh codec leaves. Borrowed scoped inputs require
Dup; affine File rejection, type snapshots, actual WASI and all original nonlocal
exit/omission controls pass. Public Pipe and grad/vjp signatures remain unchanged.
Raw buffers still require mem.free; unknown reconstruction and retained contexts
keep tracing. Fake OpenCL tests do not establish GPU hardware support.

## Current verified bundle evidence

Accepted strict inventory:375 declarations/365 symbols,40 aliases,168 contracts,
19 IR combinators,11 flat signatures and177 review declarations/167 symbols.
Complete counters include initializer fast paths and count slow delegation once.
Independent Linux/ARM/Intel and final combined Linux profiles pass. Scoped grad
matches33 calls/720 requested bytes per gradient. State4096-call profiles reduce
managed calls16384→12288 and requested bytes272212→206676, with counted freed
bytes0→262144. List2048-call profiles retain43008 calls/965374 bytes and raise
counted freed bytes65536→917504. These are workload-specific results, without
a timing or tracing-free claim. Earlier partial counter reports remain archived.

## Remaining ownership deliveries

All immutable preparation rows74–112 are delivered; their contracts, heads and
original checks are archived in history. Queue anchors remain unchanged.
Next: rebase the passing finite fallback audit and checked structural-buffer fix
onto the actual PR124 squash, preserve all11 current docs, publish one focused
ownership exit PR and require its six exact-head jobs and roadmap_docs. Confirm
actual merged-source coverage before marking phase2 complete. Then implement
natural-width numeric storage and views, followed by phases4–6. No numeric
representation or tracing-free acceptance is established yet.

'''
texts['docs/development-state.md']=state[:start]+new+state[end:]
texts['docs/development-state.md']=texts['docs/development-state.md'].replace('Fold it into the next ownership exit bundle after PR124 acceptance;','Deliver it with the finite ownership exit review in the next bundle;')
texts['docs/primitive-ownership.md']=primitive[:pa]+'''## Prepared refinements

PR124 accepts resource/network, State, AD and list callback owners and14 codec
leaves after all six exact-head platform jobs and roadmap_docs pass. Original
preparation contracts and omission controls are archived in
[history](roadmap-history.md#archived-handoff-after-pr-124). The immutable queue
retains their anchors. The next finite exit review explicitly classifies177
remaining declarations with tracing fallback and includes checked structural
buffer growth; its exact-source three-platform preflight passes, while the
production bundle and actual merged-source phase2 exit remain required.

'''+primitive[pb:]
texts['docs/primitive-ownership.md']=texts['docs/primitive-ownership.md'].replace('Merged contracts through #103 passed their exact-head full platform gates.','Merged contracts through #124 passed their exact-head full platform gates.')
plan=texts['PLAN.md'];a=plan.index('Main includes #74');b=plan.index('Phase2 remaining audits',a)
texts['PLAN.md']=plan[:a]+'''Main includes #74–#124: native macOS ARM/Intel support, resource/network and
callback ownership, typed State, scoped AD and independent codec leaves.
Queue33 and35–112 are accepted;34 is a verified duplicate. Next bundle completes
the finite177-declaration ownership fallback review and checked structural-buffer
growth with current docs. Require actual-source validation and all final gates
before phase2 exit, then deliver numeric representation and phases4–6.

'''+plan[b:]
texts['PLAN.md']=texts['PLAN.md'].replace('Finish phase2 with the resource/State bundle, then serializer/codec contracts,\nthe scoped-gradient allocation regression and the finite177-declaration review.','Finish phase2 with the finite177-declaration fallback review and checked buffer\ngrowth on the actual accepted resource/State/AD/codec source.')
for name in ['docs/ownership.md','docs/primitive-ownership.md']:
 texts[name]=texts[name].replace('The PR124 final integration38179558348 verifies','The accepted PR124 inventory verifies').replace('Final production\nacceptance is recorded','Production\nacceptance is recorded').replace('in the PR124 candidate','in accepted PR124')
# Preserve other prepared work; only these delivered rules change their status.
design=texts['docs/design.md'];design=design.replace('- The prepared row-unifier repair refreshes','- The row-unifier refreshes').replace('- Prepared callback argument comparison widens','- Callback argument comparison widens')
a=design.index('- Native State uses per-task scanned word storage.');b=design.index('- A type descriptor per monomorphic type',a)
design=design[:a]+'''- Native State uses per-task scanned storage and typed stack owner records.
  Inactive words clear on pop/error/task exit; typed values retain borrowed
  initials, own gets/results and release replacements across return and nonlocal
  exits. Task switches preserve scope chains. Legacy/unmodeled payloads retain
  tracing fallback. PR124 passes aggregate and escaping-closure controls.
'''+design[b:]
texts['docs/design.md']=design
# Archive obsolete preparation prose and keep the live design about accepted behavior.
design=texts['docs/design.md'];a=design.index('## Prepared ownership implementation')
texts['docs/roadmap-history.md']+='\n\n## PR124 ownership implementation notes before acceptance\n\n'+design[a:]
design=design[:a]+"""## Ownership implementation

PR124 accepts compiler and runtime ownership for original resource frames,
File IO/storage, typed State, synchronous list callbacks, scoped AD and resource/
network contexts. Typed holders preserve original lifetime/trap order through
inlining and flattening. Incoming owners, partial retains, callback results and
scratch remain protected across error, raw trap and cancellation; frame assignment
follows successful acquisition. FWP_FRAME_FIELDS=0 preserves the boxed control.

Native File owners close at original frame boundaries independently of optional
ordinary freeing. Inline paths use aligned leaf storage; constructor rollback
closes streams and last-owner release removes library finalizers before freeing
unshared headers. Shared headers keep compatibility lifetime. Actual WASI verifies
logical aggregate/task resource counts; physical bump storage remains allocated.

HTTP/2 and gRPC owners protect metadata roots, dequeued/copied messages, status,
encoding scratch, connections and inherited task contexts. TLS options/metadata
retain their original scoped and task owners; completion releases acquired owners
through joins and cancellation. Length-framed full keys preserve pool identity;
aligned tail storage avoids separate option strings and connection addresses.
Library teardown drains tasks and finalizers before clearing read-once TLS caches.
Protocol bytes, receive order and observable evaluation/trap order stay unchanged.

Unknown reconstruction, cached decoded values and retained callback boundaries
keep tracing compatibility. Channel close preserves queued values; explicit drain
breaks the tested counted cycle, while unreachable shared cycles still require
tracing. [Ownership coverage](ownership.md#ownership-coverage) and
[the handoff](development-state.md) record the finite review and later work.
"""
design=design.replace('Other callback/runtime and exceptional ownership extensions are prepared separately.','Other runtime boundaries retain explicit sharing fallbacks.').replace('Wider callback registration stays prepared.','Unmodeled callback boundaries retain shared fallback.')
design=design.replace('Other resource boundaries stay prepared.','Unmodeled resource boundaries retain compatibility lifetimes.')
design=design.replace('  the prepared repair adds known ambient labels','  temporary call rows include known ambient labels').replace('  effect/type snapshots and simple closure State controls must pass before\n  acceptance.','  effect/type snapshots and positive/negative State controls pass in PR124.')
texts['docs/design.md']=design
ownership=texts['docs/ownership.md'];a=ownership.index('## Prepared ownership work');b=ownership.index('## Original resource semantics',a)
texts['docs/roadmap-history.md']+='\n\n## Ownership preparation coverage before PR124 acceptance\n\n'+ownership[a:b]
ownership=ownership[:a]+"""## Ownership coverage

PR124 accepts the resource/network, State, AD and list/codec contracts recorded
in [the handoff](development-state.md); original preparation controls and exact
heads are archived in history. All375 declarations are inventoried:168 contracts,
19 IR combinators,11 flat signatures and177 declarations retaining explicit
shared fallback. The finite review classifies arguments, results, callbacks,
retention and teardown for these remaining167 runtime symbols. Its three-platform
candidate audit passes; actual merged-source review and final production gates
are still required before phase2 exit.

Reconstructed/decoded graphs and cached/retained contexts require tracing unless
a typed ownership contract proves their full graph and teardown. Channel close
preserves queued values; draining breaks the tested counted cycle. Automatic
unreachable-cycle reclamation remains unproved. Numeric representation, optimized
kernels and tracing-free eligibility remain separate later phases.

"""+ownership[b:]
ownership=ownership.replace('when ignored; early close would change later IO failures. Prepared internal ResourceRegion\nanchors record these lifetimes before optimization and preserve them through\ninlining and fusion; their implementation still requires accepted bundle delivery.','when ignored; early close would change later IO failures. Internal ResourceRegion\nanchors record these lifetimes before optimization and preserve them through\ninlining and fusion, as accepted in PR124.')
ownership=ownership.replace('Prepared native File headers','Native File headers').replace('General unwind remains prepared.','Unmodeled payloads retain shared fallback.').replace('Other resource boundaries stay prepared.','Unmodeled resource boundaries retain compatibility lifetimes.')
texts['docs/ownership.md']=ownership
for name in DOCS:
 texts[name]=texts[name].replace('ownership.md#prepared-ownership-work','ownership.md#ownership-coverage').replace('[the prepared ownership work]','[ownership coverage]')
backup=Path('/private/tmp/fwp-main-docs-remote-pre124');assert not backup.exists();backup.mkdir();hashes={}
for name in DOCS:
 data=(ROOT/name).read_bytes();saved=backup/name;saved.parent.mkdir(parents=True,exist_ok=True);saved.write_bytes(data);hashes[name]=hashlib.sha256(data).hexdigest()
(backup/'sha256.json').write_text(json.dumps(hashes,indent=2)+'\n')
for name,text in texts.items():(ROOT/name).write_text(text)
print('Recorded verified PR124 acceptance; archived39 live rows and protected11 docs',flush=True)
