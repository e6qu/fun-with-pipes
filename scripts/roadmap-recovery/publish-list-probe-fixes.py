"""Correct diagnosed scratch tracking and the State task-spawn fixture."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';OLD='e03f2a076d703b96f42d0c048d3c9aee569ac11e'
BRANCH='ownership-evidence-list-applicative';RUN=38159610009
SUBJECT='Correct scratch allocation tracking and State task fixtures'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-list-probe-fixes-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
files={'tests/list_applicative_ownership.rs':Path('/private/tmp/fwp-list-ap-test.rs').read_text(),
       'tests/fixtures/list_ap_probe.c':Path('/private/tmp/fwp-list-ap-probe.c').read_text()}
log=Path('/private/tmp/fwp-list-e03-arm-failed.log').read_bytes()
assert b'left: Some(99)' in log and b'found `String`' in log
for name,data in files.items():
    prior=api('/contents/'+name+'?ref='+OLD)
    assert base64.b64decode(prior['content']).decode()!=data,name
gate=api('/actions/runs/'+str(RUN));assert gate['head_sha']==OLD
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs']
assert len(jobs)==3 and any(j['conclusion']=='failure' for j in jobs)
assert all(j['status'] in {'queued','completed'} for j in jobs),'Retain running evidence until completion'
if any(j['status']=='queued' for j in jobs):
    subprocess.run(['gh','run','cancel',str(RUN)],check=True)
parent=api('/git/commits/'+OLD)
prior=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not prior['truncated']
prior_hashes={e['path']:e['sha'] for e in prior['tree']}
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
    dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
entries=api('/git/trees/'+tree['sha']+'?recursive=1');assert not entries['truncated']
hashes={e['path']:e['sha'] for e in entries['tree']}
for name,data in files.items():
    raw=data.encode();assert hashes[name]==hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest(),name
native=['src/cgen.rs','src/ownership.rs','runtime/fwp_rt.c','runtime/fwp_rt_prims.c',
        'runtime/fwp_rt_gc.c','runtime/fwp_rt_grpc.c','runtime/fwp_rt_task.c','scripts/list-ap-ownership-patch.json']
for name in native:assert prior_hashes[name]==hashes[name],name
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==OLD
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-list-probe-fixes-publication.json').write_text(json.dumps(dict(
    head=commit['sha'],previous=OLD,branch=BRANCH,supersededRun=RUN,failedJob=114529582483,
    sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
    failedLogHash=hashlib.sha256(log).hexdigest(),unchangedNativeBlobs={name:hashes[name] for name in native},
    stage='Diagnosed probe and task fixture repairs published; replacement validation pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
