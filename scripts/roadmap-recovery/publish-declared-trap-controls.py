"""Repair undeclared fixture names and require actual runtime trap oracles."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-trap-controls-api-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
def source(head,name):
    d=api('/contents/'+name+'?ref='+head);assert d['encoding']=='base64'
    return base64.b64decode(d['content']).decode()
def publish(branch,old,run,files,subject,receipt,native):
    assert len(subject)<=80 and '\n' not in subject
    assert api('/git/ref/heads/'+branch)['object']['sha']==old
    gate=api('/actions/runs/'+str(run));assert gate['head_sha']==old
    jobs=api('/actions/runs/'+str(run)+'/jobs')['jobs']
    assert len(jobs)==3
    if gate['status']=='queued':
        assert all(j['status']=='queued' for j in jobs)
        subprocess.run(['gh','run','cancel',str(run)],check=True)
    else:
        assert gate['status']=='completed','Retain running evidence until it completes'
    parent=api('/git/commits/'+old)
    prior=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not prior['truncated']
    prior_hashes={e['path']:e['sha'] for e in prior['tree']}
    tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
        dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
    entries=api('/git/trees/'+tree['sha']+'?recursive=1');assert not entries['truncated']
    hashes={e['path']:e['sha'] for e in entries['tree']}
    for name,data in files.items():
        raw=data.encode();assert hashes[name]==hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest(),name
    for name in native:assert prior_hashes[name]==hashes[name],name
    commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[old]))
    assert commit['message']==subject and commit['parents'][0]['sha']==old
    assert api('/git/ref/heads/'+branch)['object']['sha']==old
    ref=api('/git/refs/heads/'+branch,dict(sha=commit['sha'],force=False),method='PATCH')
    assert ref['object']['sha']==commit['sha']
    Path(receipt).write_text(json.dumps(dict(head=commit['sha'],previous=old,branch=branch,previousRun=run,
        sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
        unchangedNativeBlobs={name:hashes[name] for name in native},
        stage='Declared trap controls published; replacement checks pending'),indent=2)+'\n')
    print(branch,commit['sha'],flush=True)
    return commit['sha']

scope_old='475cb242715961e5e396e4fe74026545160d2e3c'
gate=api('/actions/runs/38141558055')
assert gate['head_sha']==scope_old and gate['conclusion']=='failure' and gate['status']=='completed'
log=subprocess.check_output(['gh','run','view','38141558055','--log-failed'])
assert b'unknown name `panic`' in log
Path('/private/tmp/fwp-ad-scope-475-failed.log').write_bytes(log)
assert 'foreign "fwp" prim.trap : String -> a' in source(scope_old,'lib/prelude.fwp')
scoped=Path('/private/tmp/fwp-ad-scope-test.rs').read_text()
assert source(scope_old,'tests/ad_tape_scopes.rs').count('| panic')==2
assert '| panic' not in scoped and scoped.count('| prim.trap')==2
assert 'reference.status.code(),Some(101)' in scoped
scope=publish('ownership-evidence-autodiff-scopes',scope_old,38141558055,
    {'tests/ad_tape_scopes.rs':scoped},'Use declared traps in autodiff callback error controls',
    '/private/tmp/fwp-ad-scope-trap-publication.json',
    ['src/numerics.rs','src/interp.rs','src/cgen.rs','src/ownership.rs','lib/autodiff.fwp','runtime/fwp_rt_kernel.c'])

listed=Path('/private/tmp/fwp-list-ap-test.rs').read_text()
list_old='0d1c44fedd083aca203db7c5a4a4a8d4e27057a1'
assert source(list_old,'tests/list_applicative_ownership.rs').count('| panic')==2
assert '| panic' not in listed and listed.count('| prim.trap')==2
assert 'reference.status.code(),Some(101)' in listed
publish('ownership-evidence-list-applicative',list_old,38156088446,
    {'tests/list_applicative_ownership.rs':listed},'Require actual runtime traps in list ownership controls',
    '/private/tmp/fwp-list-ap-trap-publication.json',
    ['src/cgen.rs','src/ownership.rs','runtime/fwp_rt.c','runtime/fwp_rt_prims.c',
     'runtime/fwp_rt_gc.c','runtime/fwp_rt_grpc.c','runtime/fwp_rt_task.c','scripts/list-ap-ownership-patch.json'])

workflow=Path('/private/tmp/fwp-ad-scope-allocation.yml')
old_workflow=workflow.read_text();assert old_workflow.count(scope_old)==1
assert source('e586a4d12a477aefcc854e12f6bbf2f640299de8','.github/workflows/ad-scope-allocation.yml')==old_workflow
new_workflow=old_workflow.replace(scope_old,scope)
allocation=publish('ownership-evidence-autodiff-allocations','e586a4d12a477aefcc854e12f6bbf2f640299de8',38145198463,
    {'.github/workflows/ad-scope-allocation.yml':new_workflow},'Measure the repaired autodiff callback control head',
    '/private/tmp/fwp-ad-allocation-trap-publication.json',['scripts/measure-ad-scope-allocations.py'])
workflow.write_text(new_workflow)
print('Scope allocation driver',allocation,'candidate',scope,flush=True)
