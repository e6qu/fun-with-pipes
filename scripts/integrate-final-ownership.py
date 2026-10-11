"""Integrate verified codec and allocation repairs before PR124 final gates."""
from pathlib import Path
import hashlib,json,os,subprocess
from export_prepared_commits import export_history
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=ROOT/'final-ownership-evidence';OUT.mkdir(exist_ok=True)
WT=ROOT.parent/'pr124-final-ownership';BASE='1aadb8a075e1737d0e6a4db96eae5d675f6fb404'
SCOPE='42774f981491bb321f4d66a43d6c7088da7db70b';CODEC='b837f55fc91f073ef147455916d704b1ed12c673'
FRONT='bbb68321b522f5e732c6988df8b77345967ecd2f'
BRANCH='ownership-resource-network-bundle'
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
def git(*a,cwd=ROOT):return subprocess.check_output(['git',*a],cwd=cwd,text=True).strip()
def blob(head,name):return subprocess.check_output(['git','show',head+':'+name],cwd=ROOT)
def gate(number,head,prefix):
 r=json.loads(subprocess.check_output(['gh','run','view',str(number),'--json','headSha,status,conclusion,jobs,url'],text=True))
 assert r['headSha']==head and r['status']=='completed' and r['conclusion']=='success',r
 assert len(r['jobs'])==3 and {j['name'] for j in r['jobs']}=={prefix+' ('+s+')' for s in ['ubuntu-latest','macos-15','macos-15-intel']}
 assert all(j['status']=='completed' and j['conclusion']=='success' for j in r['jobs'])
 return r
checks={
 'scope':gate(38176126768,SCOPE,'allocations'),
 'codec':gate(38175125107,CODEC,'codecs'),
 'state':gate(38174682933,'771c2b83b9a5db0142df759006b960704606a86a','allocations'),
 'list':gate(38175393180,'186cd79f64a0781cb9588975f863c983b072d1ac','allocations'),
}
front=json.loads(subprocess.check_output(['gh','run','view','38177992930','--json','headSha,status,conclusion,jobs,url'],text=True))
assert front['headSha']==FRONT and front['status']=='completed' and front['conclusion']=='success'
assert len(front['jobs'])==1 and front['jobs'][0]['name']=='codecs' and front['jobs'][0]['conclusion']=='success'
checks['functionArguments']=front
assert git('rev-parse','origin/'+BRANCH)==BASE
assert git('rev-parse','origin/main')=='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
assert json.loads(subprocess.check_output(['gh','pr','view','124','--json','headRefOid'],text=True))['headRefOid']==BASE
subprocess.run(['git','worktree','add','--detach',str(WT),BASE],check=True)
NATIVE=['src/interp.rs','src/cgen.rs','src/ownership.rs','runtime/fwp_rt_kernel.c','lib/autodiff.fwp']
changed=set(NATIVE+['src/infer.rs','tests/call_effects.rs']+DOCS+['tests/ad_tape_scopes.rs','tests/fixtures/ad_scope_probe.c','tests/serializer_leaf_ownership.rs','scripts/check-primitive-inventory.py'])
for name in NATIVE+['tests/ad_tape_scopes.rs','tests/fixtures/ad_scope_probe.c']:(WT/name).write_bytes(blob(SCOPE,name))
for name in ['src/infer.rs','tests/call_effects.rs']:(WT/name).write_bytes(blob(FRONT,name))
recipe=json.loads(blob('HEAD','scripts/codec-leaf-ownership-patch.json'));assert set(recipe)=={'src/ownership.rs'}
p=WT/'src/ownership.rs';s=p.read_text()
for edit in recipe['src/ownership.rs']:
 assert s.count(edit['old'])==1;s=s.replace(edit['old'],edit['new'])
p.write_text(s)
(WT/'tests/serializer_leaf_ownership.rs').write_bytes(blob(CODEC,'tests/serializer_leaf_ownership.rs'))
(WT/'scripts/check-primitive-inventory.py').write_bytes(blob('HEAD','scripts/check-primitive-inventory-final.py'))
for name in DOCS:(WT/name).write_bytes(blob('HEAD',name))
for kind in ['typed-state','ad-scope','list-callback']:
 name='scripts/measure-'+kind+'-allocations-complete.py';(WT/name).write_bytes(blob('HEAD',name));changed.add(name)
def run(*a,environment=None):subprocess.run(a,cwd=WT,env=environment or env,check=True)
env=dict(os.environ,CARGO_PROFILE_DEV_DEBUG='0',CARGO_PROFILE_TEST_DEBUG='0',CARGO_INCREMENTAL='0',RUST_TEST_THREADS='1',FWP_TYPED_STATE_ARTIFACTS=str(OUT/'state'),FWP_AD_SCOPE_ARTIFACTS=str(OUT/'scopes'),FWP_CODEC_ARTIFACTS=str(OUT/'codecs'))
run('rustfmt','--edition','2021','src/interp.rs','src/cgen.rs','src/ownership.rs','src/infer.rs','tests/call_effects.rs','tests/ad_tape_scopes.rs','tests/serializer_leaf_ownership.rs')
run('cargo','build','--bin','fwp');run(str(WT/'target/debug/fwp'),'fmt','lib/autodiff.fwp');run(str(WT/'target/debug/fwp'),'fmt','--check','lib/autodiff.fwp');run('cargo','fmt','--check')
run('cargo','test','--lib')
run('cargo','test','--no-fail-fast','--test','task_ownership','--test','ad_tape_ownership','--test','ad_tape_scopes','--test','serializer_leaf_ownership','--test','typed_state_ownership','--test','call_effects','--test','golden_check','--test','fmt','--test','stdlib_doc')
# Keep the current candidate handoff singular; archive earlier head chronology.
state=WT/'docs/development-state.md';text=state.read_text();a=text.index('## Current verified bundle evidence');b=text.index('## Remaining ownership deliveries',a)
history=WT/'docs/roadmap-history.md';history.write_text(history.read_text()+'\n\n## Before the final PR124 ownership integration\n\n'+text[a:b])
evidence='''## Current verified bundle evidence

The current runner integrates the passing typed State/effect repairs,14 fresh
serializer/codec contracts and direct scoped AD callbacks. Library units, all
type/effect snapshots, deadline callback argument rows, formatting/stdlib docs,
affine File rejection, input
aliases and original State/AD omission controls pass together. Public Pipe and
grad/vjp signatures are preserved; borrowed scoped inputs require Dup.

Complete initializer-aware allocation counters are preserved; the original
partial counters do not establish total allocation parity. Independent exact
three-platform State, list and scoped AD comparisons pass. The combined-source
Linux comparison follows, retaining original assertions and source/binary hashes.
No timing or tracing-free claim is established. Runtime ownership fallbacks and
cycles still require the finite phase2 exit review. Phases2–6 remain unfinished.

Next: publish the runner export with the exact1aadb lease, then require all six
exact-head production jobs and roadmap_docs on the resulting PR124 head before
squash. Earlier heads, preflights and cancelled runs cannot supply those gates.
Current production head must be queried from PR124; this preparation does not
claim publication or acceptance. Source manifest: final-ownership.json in the
runner artifact. Preserve one production PR and the required one-line commits.

'''
text=text[:a]+evidence+text[b:]
a=text.index('Current delivery is PR[');b=text.index('Duplicate main CI',a)
text=text[:a]+'''Current delivery is PR[#124](https://github.com/e6qu/fun-with-pipes/pull/124):
resource/network items74–112, compiler/cache and effect inference repairs, AD
and list/closure lifetimes, typed State and independent codec leaves. Previous
production head1aadb8a075e1737d0e6a4db96eae5d675f6fb404 is superseded by this
prepared native-source integration. Final publication and full current-head gates
remain required. Historical receipts remain in roadmap-history.md.

'''+text[b:];state.write_text(text)
run('python3','scripts/check-roadmap.py')
git('add',*sorted(changed),cwd=WT);assert set(git('diff','--cached','--name-only',cwd=WT).splitlines())<=changed
git('commit','-m','Remove scoped-gradient allocation overhead and own codec leaves',cwd=WT)
head=git('rev-parse','HEAD',cwd=WT);inventory=OUT/'primitive-inventory.json'
run('python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(inventory),environment=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head))
r=json.loads(inventory.read_text());assert r['counts']==dict(contract=168,runtime_or_specialization_review=177,flat_scalar_signature=11,ir_template=19) and r['reviewSymbols']==167 and r['declarations']==375 and r['distinctSymbols']==365
# Measurements build from committed source and record their actual head/bytes.
run('python3','scripts/measure-typed-state-allocations-complete.py',environment=dict(env,FWP_TYPED_STATE_ARTIFACTS=str(OUT/'combined-state-profile')))
run('python3','scripts/measure-ad-scope-allocations-complete.py',environment=dict(env,FWP_AD_ALLOCATION_ARTIFACTS=str(OUT/'combined-ad-profile'),FWP_SCOPE_CANDIDATE=head))
# This retained list recipe must measure this combined candidate, not its old driver.
list_script=WT/'scripts/measure-list-callback-allocations-complete.py';src=list_script.read_text();assert src.count("CANDIDATE=os.environ.get('FWP_LIST_CANDIDATE','4f21a9ea99c1a06a3f1ba67818936194fe43e42a')")==1
# A parameter supplies the measured revision without altering committed source.
# The profile script is prepared in the driver with an explicit env override.
run('python3','scripts/measure-list-callback-allocations-complete.py',environment=dict(env,FWP_LIST_AP_ARTIFACTS=str(OUT/'combined-list-profile'),FWP_LIST_CANDIDATE=head))
state.write_text(state.read_text().replace('The combined-source\nLinux comparison follows, retaining original assertions and source/binary hashes.','The combined-source\nLinux comparisons pass, retaining original assertions and source/binary hashes.')+'\nVerified final inventory:375 declarations/365 symbols,40 aliases,168 contracts,\n19 IR combinators,11 flat signatures and177 review declarations/167 symbols.\n')
git('add','docs/development-state.md',cwd=WT);git('commit','-m','Record final ownership inventory and complete allocation comparisons',cwd=WT)
head=git('rev-parse','HEAD',cwd=WT)
run('python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(inventory),environment=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head));run('python3','scripts/check-roadmap.py')
assert not git('status','--porcelain',cwd=WT)
record=dict(base=BASE,previous=BASE,head=head,branch=BRANCH,evidence=checks,inventoryReport=json.loads(inventory.read_text()),sourceHashes={n:hashlib.sha256((WT/n).read_bytes()).hexdigest() for n in changed},stage='Combined final ownership preflight passed; publication and exact-head production gates required')
record['export']=export_history(WT,BASE,head,OUT/'prepared-commits.json.gz');record['tree']=record['export']['tree'];(OUT/'final-ownership.json').write_text(json.dumps(record,indent=2)+'\n');print('Final ownership export',head,flush=True)
