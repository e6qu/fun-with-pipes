from pathlib import Path
import subprocess,json,os
root=Path.cwd();wt=root.parent/'resource-network';source='9ad102d5a16f';oldbase='3dba256655a3';target='b0ae00d5512df825271970cafcf569f52dbfc0cd';branch='ownership-resource-network-bundle'
docs=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
new_files={'src/cgen.rs','src/ownership.rs','src/ffi_interp.rs','lib/ffi.fwp','tests/ffi_pointer_arithmetic.rs','tests/raw_memory_ownership.rs'}
env=dict(os.environ,GIT_EDITOR='true')
def git(*args,cwd=root):return subprocess.check_output(['git',*args],cwd=cwd,env=env,text=True).strip()
def blob(rev,name):return subprocess.check_output(['git','show',rev+':'+name],cwd=root,text=True)
source=git('rev-parse',source);oldbase=git('rev-parse',oldbase)
assert not git('ls-remote','origin','refs/heads/'+branch)
assert git('merge-base',oldbase,source)==oldbase
originals=git('rev-list','--reverse',oldbase+'..'+source).splitlines();assert len(originals)==44
original_docs={name:blob(target,name) for name in docs}
ci_old='      - name: test\n        run: cargo test --all-targets --no-fail-fast\n'
ci_new='      - name: test\n        env:\n          FWP_REQUIRE_WASM_RESOURCE_COUNTS: "1"\n        run: cargo test --all-targets --no-fail-fast\n'
base_ci=blob(target,'.github/workflows/ci.yml');assert base_ci.count(ci_old)==1
expected_ci=base_ci.replace(ci_old,ci_new)
old_cgen=blob(oldbase,'src/cgen.rs');new_cgen=blob(target,'src/cgen.rs')
marker='ResultOwnership::FreshLeaf | ResultOwnership::FreshContainer => {'
end='ResultOwnership::AliasArgument { argument } => {'
def leaf_block(code):
 assert code.count(marker)==1
 a=code.index(marker);b=code.index(end,a);return code[a:b]
old_leaf=leaf_block(old_cgen);new_leaf=leaf_block(new_cgen)
old_pointer='return (V)((int64_t)l1 + (int64_t)l0 * (int64_t)sizeof({}));'
new_pointer='return (V)((uintptr_t)l1 + (uintptr_t)l0 * sizeof({}));'
old_owner=blob(oldbase,'src/ownership.rs');new_owner=blob(target,'src/ownership.rs')
match='    ) = match symbol {\n';assert old_owner.count(match)==new_owner.count(match)==1
raw=new_owner[new_owner.index(match)+len(match):new_owner.index('        "task.spawn" =>')]
assert '"ptr.read-string"' in raw
coverage='            (include_str!("../lib/task.fwp"), false),'
ffi_coverage='            (include_str!("../lib/ffi.fwp"), false),'
def corrected_original(rev,name):
 code=blob(rev,name)
 if name=='src/cgen.rs':
  assert code.count(old_pointer)==1 and code.count(old_leaf)==1
  return code.replace(old_pointer,new_pointer).replace(old_leaf,new_leaf)
 if name=='src/ownership.rs':
  assert code.count(match)==1 and code.count(coverage)==1 and ffi_coverage not in code
  return code.replace(match,match+raw).replace(coverage,coverage+'\n'+ffi_coverage)
 raise AssertionError(('Unexpected native conflict',name))
git('worktree','add','-b',branch,str(wt),source)
log=root/'rebase.log'
def rebase(*args):
 r=subprocess.run(['git','rebase',*args],cwd=wt,env=env,capture_output=True,text=True)
 with log.open('a') as f:f.write(r.stdout+r.stderr)
 return r
r=rebase('--reapply-cherry-picks','--empty=keep','--onto',target,oldbase)
while r.returncode:
 conflicts=git('diff','--name-only','--diff-filter=U',cwd=wt).splitlines()
 allowed=set(docs)|{'.github/workflows/ci.yml','src/cgen.rs','src/ownership.rs'}
 assert conflicts and set(conflicts)<=allowed,conflicts
 rev=git('rev-parse','REBASE_HEAD',cwd=wt)
 for name in conflicts:
  if name in docs:content=original_docs[name]
  elif name=='.github/workflows/ci.yml':content=expected_ci
  else:content=corrected_original(rev,name)
  (wt/name).write_text(content)
 for name in docs:(wt/name).write_text(original_docs[name])
 git('add',*docs,*[name for name in conflicts if name not in docs],cwd=wt)
 if not git('diff','--cached','--name-only',cwd=wt):
  assert set(git('diff','--name-only',rev+'^',rev,cwd=wt).splitlines())<=set(docs)
  git('commit','--allow-empty','-C',rev,cwd=wt)
 r=rebase('--continue')
head=git('rev-parse','HEAD',cwd=wt);rebased=git('rev-list','--reverse',target+'..'+head,cwd=wt).splitlines();assert len(rebased)==44
for before,after in zip(originals,rebased):assert git('show','-s','--format=%s',before)==git('show','-s','--format=%s',after)
assert blob(head,'.github/workflows/ci.yml')==expected_ci
assert blob(head,'tests/golden_run.rs')==blob(target,'tests/golden_run.rs')
assert set(git('diff','--name-only',source,head,cwd=wt).splitlines())<=set(docs)|new_files|{'.github/workflows/ci.yml','tests/golden_run.rs'}
def delta(a,b):
 lines=git('diff',a,b,'--',*sorted(new_files),cwd=wt).splitlines()
 return [line for line in lines if line.startswith(('+','-'))]
assert delta(oldbase,target)==delta(source,head),'Native changes differ from tested pointer/string repairs'
for name in docs:(wt/name).write_text(original_docs[name])
subprocess.run(['python3','scripts/check-roadmap.py'],cwd=wt,check=True)
git('add',*docs,cwd=wt)
if git('diff','--cached','--name-only',cwd=wt):git('commit','-m','Record resource network preparation on the candidate base',cwd=wt)
head=git('rev-parse','HEAD',cwd=wt);assert not git('status','--porcelain',cwd=wt)
for revision in git('rev-list',target+'..'+head,cwd=wt).splitlines():
 message=git('show','-s','--format=%B',revision,cwd=wt)
 assert len(message.splitlines())==1 and len(message)<=80
 assert not any(term in message.lower() for term in ['co-authored','authored-by','authored by','ai attribution'])
subprocess.run(['python3','scripts/check-roadmap.py'],cwd=wt,check=True)
record=dict(source=source,oldbase=oldbase,base=target,head=head,branch=branch,originalCommits=originals,rebasedCommits=rebased,includedRows=list(range(74,94)),stage='GitHub preparation published; final actual-squash rebase and full mandatory-WASI production CI pending',ciRequirement='Inherited exact golden diagnostics plus FWP_REQUIRE_WASM_RESOURCE_COUNTS=1')
(root/'preparation.json').write_text(json.dumps(record,indent=2)+'\n')
git('push','origin','HEAD:refs/heads/'+branch,cwd=wt)
assert git('ls-remote','origin','refs/heads/'+branch).split()[0]==head
print(head)
