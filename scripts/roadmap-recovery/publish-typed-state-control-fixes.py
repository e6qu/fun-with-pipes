"""Correct diagnosed State fixtures while preserving every native source blob."""
from pathlib import Path
import hashlib, json, subprocess
REPO='repos/e6qu/fun-with-pipes'
OLD='aedbd448b2cffb99ce9d4093bc68f9183754a659'
BRANCH='ownership-evidence-typed-state'
SUBJECT='Correct State control effects and verify actual free and poison paths'
RECEIPT=Path('/private/tmp/fwp-typed-state-control-fixes-publication.json')
def api(endpoint,payload=None,method='POST'):
    argv=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-typed-state-control-fixes-input.json');path.write_text(json.dumps(payload))
        argv+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(argv,text=True))
assert not RECEIPT.exists()
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
run=api('/actions/runs/38166093336');assert run['head_sha']==OLD and run['status']=='completed' and run['conclusion']=='failure'
jobs=api('/actions/runs/38166093336/jobs')['jobs'];assert len(jobs)==3 and all(j['status']=='completed' and j['conclusion']=='failure' for j in jobs)
log=Path('/private/tmp/fwp-typed-state-aed-arm-failed.log').read_bytes()
assert b'Some(125)' in log and b'effect `IO` is not allowed here' in log
files={'tests/typed_state_ownership.rs':Path('/private/tmp/fwp-typed-state-test.rs').read_text(),
       'tests/fixtures/typed_state_probe.c':Path('/private/tmp/fwp-typed-state-probe.c').read_text()}
parent=api('/git/commits/'+OLD)
before=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not before['truncated']
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
    dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
after=api('/git/trees/'+tree['sha']+'?recursive=1');assert not after['truncated']
b={x['path']:x['sha'] for x in before['tree'] if x['type']!='tree'}
a={x['path']:x['sha'] for x in after['tree'] if x['type']!='tree'}
assert set(a)==set(b)
assert {name for name in a if a[name]!=b[name]}==set(files)
for name,data in files.items():
    raw=data.encode();assert a[name]==hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest()
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and [p['sha'] for p in commit['parents']]==[OLD]
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
RECEIPT.write_text(json.dumps(dict(head=commit['sha'],previous=OLD,branch=BRANCH,
    unchangedNativeBlobs={name:a[name] for name in ['src/ownership.rs','src/cgen.rs','runtime/fwp_rt.c','runtime/fwp_rt_task.c','runtime/fwp_rt_prims.c']},
    failedRun=38166093336,failedLogHash=hashlib.sha256(log).hexdigest(),
    sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
    stage='Test-only State repairs published; replacement gates pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
