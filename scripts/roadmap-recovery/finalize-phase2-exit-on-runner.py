"""Rebase the passing finite review onto the verified PR124 squash on a runner."""
from pathlib import Path
import hashlib,json,os,subprocess
from export_prepared_commits import export_history
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=ROOT/'phase2-exit-evidence';OUT.mkdir(exist_ok=True)
SOURCE='3aae99bfa705e26babc2cf251b0e583dfd95cf38';PREP='167d769deaa28fae9b361ba4e9fa33b443d1a79c'
ARRAY='296ea83b45bb153c2b86d1df68e05c799013b2eb'
KERNEL='d240231c5dd33e83ecdd5bf3df06715a0e279768'
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
ARRAY_FILES=['runtime/fwp_rt.c','runtime/fwp_rt_gc.c','src/prims_std.rs','tests/array_size_limits.rs','tests/fixtures/array_size_probe.c','tests/fixtures/bump_size_probe.c']
KERNEL_FILES=['runtime/fwp_rt_kernel.c','tests/numerics.rs','tests/kernel_stack_bounds.rs','tests/fixtures/kernel_stack_probe.c']
FILES=['runtime/fwp_rt_ops.c','tests/structural_buffer.rs','tests/fixtures/structural_buffer_probe.c','scripts/check-explicit-fallback-review.py','tests/fixtures/primitive-fallback-review.json']
def git(*a,cwd=ROOT):return subprocess.check_output(['git',*a],cwd=cwd,text=True).strip()
def blob(head,path):return subprocess.check_output(['git','show',head+':'+path],cwd=ROOT)
review=json.loads(subprocess.check_output(['gh','run','view','38180899508','--json','headSha,status,conclusion,jobs'],text=True))
assert review['headSha']==PREP and review['status']=='completed' and review['conclusion']=='success'
assert len(review['jobs'])==3 and {j['name'] for j in review['jobs']}=={'review ('+s+')' for s in ['ubuntu-latest','macos-15','macos-15-intel']}
assert all(j['status']=='completed' and j['conclusion']=='success' for j in review['jobs'])
array=json.loads(subprocess.check_output(['gh','run','view','38182446407','--json','headSha,status,conclusion,jobs'],text=True))
assert array['headSha']==ARRAY and array['status']=='completed' and array['conclusion']=='success'
assert len(array['jobs'])==3 and {j['name'] for j in array['jobs']}=={'arrays ('+v+')' for v in ['ubuntu-latest','macos-15','macos-15-intel']}
assert all(j['status']=='completed' and j['conclusion']=='success' for j in array['jobs'])
kernel=json.loads(subprocess.check_output(['gh','run','view','38186836622','--json','headSha,status,conclusion,jobs'],text=True))
assert kernel['headSha']==KERNEL and kernel['status']=='completed' and kernel['conclusion']=='success'
assert len(kernel['jobs'])==3 and {j['name'] for j in kernel['jobs']}=={'kernels ('+v+')' for v in ['ubuntu-latest','macos-15','macos-15-intel']}
assert all(j['status']=='completed' and j['conclusion']=='success' for j in kernel['jobs'])
pr=json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/pulls/124'],text=True))
assert pr['merged'] and pr['head']['sha']==SOURCE and pr['merge_commit_sha']
BASE=pr['merge_commit_sha'];assert git('rev-parse','origin/main')==BASE
assert git('rev-parse',BASE+'^{tree}')==git('rev-parse',SOURCE+'^{tree}')
message=subprocess.check_output(['git','show','-s','--format=%B',BASE],text=True).strip();assert '\n' not in message and len(message)<=80
assert not any(x in message.lower() for x in ['co-authored','authored by','authored-by','ai attribution'])
WT=ROOT.parent/'phase2-exit-final';subprocess.run(['git','worktree','add','--detach',str(WT),BASE],check=True)
for path in FILES:(WT/path).parent.mkdir(parents=True,exist_ok=True);(WT/path).write_bytes(blob(PREP,path))
for path in ARRAY_FILES:(WT/path).parent.mkdir(parents=True,exist_ok=True);(WT/path).write_bytes(blob(ARRAY,path))
for path in KERNEL_FILES:(WT/path).parent.mkdir(parents=True,exist_ok=True);(WT/path).write_bytes(blob(KERNEL,path))
for path in DOCS:(WT/path).write_bytes(blob('HEAD',path))
actions=json.loads(blob('HEAD','scripts/node24-actions-patch.json'))
assert set(actions)=={'.github/workflows/ci.yml','.github/workflows/roadmap.yml'}
for path,updated in actions.items():
 original=blob(BASE,path).decode()
 assert updated==original.replace('actions/checkout@v4','actions/checkout@v7').replace('actions/upload-artifact@v4','actions/upload-artifact@v7')
 (WT/path).write_text(updated)
env=dict(os.environ,CARGO_INCREMENTAL='0',CARGO_PROFILE_DEV_DEBUG='0',CARGO_PROFILE_TEST_DEBUG='0',RUST_TEST_THREADS='1',FWP_BUFFER_ARTIFACTS=str(OUT/'buffers'),FWP_ARRAY_SIZE_ARTIFACTS=str(OUT/'arrays'),FWP_KERNEL_BOUNDS_ARTIFACTS=str(OUT/'kernels'),FWP_CODEC_ARTIFACTS=str(OUT/'codecs'))
def run(*a,environment=None):subprocess.run(a,cwd=WT,env=environment or env,check=True)
run('rustfmt','--edition','2021','src/prims_std.rs','tests/structural_buffer.rs','tests/array_size_limits.rs','tests/kernel_stack_bounds.rs','tests/numerics.rs');run('cargo','fmt','--check')
run('cargo','clippy','--test','structural_buffer','--test','array_size_limits','--test','kernel_stack_bounds','--test','numerics','--','-D','warnings')
run('cargo','test','--lib');run('cargo','test','--no-fail-fast','--test','structural_buffer','--test','array_size_limits','--test','kernel_stack_bounds','--test','numerics','--test','serializer_leaf_ownership','--test','golden_check','--test','fmt','--test','stdlib_doc')
run('python3','scripts/check-roadmap.py')
changed=set(FILES+ARRAY_FILES+KERNEL_FILES+DOCS+list(actions));git('add',*sorted(changed),cwd=WT);assert set(git('diff','--cached','--name-only',cwd=WT).splitlines())<=changed
git('commit','-m','Record ownership fallbacks and check allocation boundaries',cwd=WT)
head=git('rev-parse','HEAD',cwd=WT)
run('python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(OUT/'inventory.json'),environment=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head))
run('python3','scripts/check-explicit-fallback-review.py','--inventory',str(OUT/'inventory.json'),'--review','tests/fixtures/primitive-fallback-review.json','--output',str(OUT/'fallback-review.json'))
state=WT/'docs/development-state.md';state.write_text(state.read_text()+'''\nFinite phase2 exit candidate: all177 remaining declarations explicitly retain
tracing-compatible argument/result/callback, retention and teardown policies.
The exact-source audit and checked buffer/array/bump/kernel controls pass together with codec
aliases, type snapshots, format/stdlib docs and71 library units. This candidate
still requires publication, all six exact-head jobs and roadmap_docs before
acceptance; phase2 is not complete yet. Numeric representation remains next.
''')
git('add','docs/development-state.md',cwd=WT);git('commit','-m','Record finite ownership coverage and checked buffer validation',cwd=WT)
head=git('rev-parse','HEAD',cwd=WT)
run('python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(OUT/'inventory.json'),environment=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head));run('python3','scripts/check-explicit-fallback-review.py','--inventory',str(OUT/'inventory.json'),'--review','tests/fixtures/primitive-fallback-review.json','--output',str(OUT/'fallback-review.json'));run('python3','scripts/check-roadmap.py')
assert not git('status','--porcelain',cwd=WT)
record=dict(base=BASE,previous=BASE,head=head,branch='ownership-exit-and-buffer-bundle',reviewEvidence=review,arrayEvidence=array,kernelEvidence=kernel,inventoryReport=json.loads((OUT/'inventory.json').read_text()),fallbackReport=json.loads((OUT/'fallback-review.json').read_text()),sourceHashes={n:hashlib.sha256((WT/n).read_bytes()).hexdigest() for n in changed},stage='Phase2 exit candidate prepared; full exact-head production gates and acceptance required')
record['export']=export_history(WT,BASE,head,OUT/'prepared-commits.json.gz');record['tree']=record['export']['tree'];(OUT/'phase2-exit.json').write_text(json.dumps(record,indent=2)+'\n');print('Final phase2 exit export',head,flush=True)
