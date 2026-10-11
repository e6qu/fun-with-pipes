"""Add State dead-root cleanup to the existing list evidence bundle."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
OLD='88b5e20a497e6482ea7918d26a961531588499b0'
BASE='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
BRANCH='ownership-evidence-list-applicative'
SUBJECT='Clear inactive State roots after returns errors and task exits'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-state-list-api-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
def source(head,name):
    result=api('/contents/'+name+'?ref='+head);assert result['encoding']=='base64'
    return base64.b64decode(result['content']).decode()
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
recipe=json.loads(Path('/private/tmp/fwp-state-list-ownership-patch.json').read_text())
assert set(recipe)=={'src/cgen.rs','src/ownership.rs','runtime/fwp_rt_prims.c',
                     'runtime/fwp_rt_gc.c','runtime/fwp_rt.c','runtime/fwp_rt_grpc.c','runtime/fwp_rt_task.c'}
files={}
for name,edits in recipe.items():
    candidate=source(BASE,name)
    for edit in edits:
        count=edit.get('count',1)
        assert candidate.count(edit['old'])==count,(name,edit['old'])
        candidate=candidate.replace(edit['old'],edit['new'])
    rendered=Path('/private/tmp')/('fwp-state-cleared-'+name.replace('/','-'))
    if rendered.exists():
        assert candidate==rendered.read_text(),name
        files[name]=candidate
    else:
        assert candidate==source(OLD,name),name
files.update({
    'tests/list_applicative_ownership.rs':Path('/private/tmp/fwp-list-ap-test.rs').read_text(),
    'tests/fixtures/state_slot_probe.c':Path('/private/tmp/fwp-state-slot-probe.c').read_text(),
    'scripts/list-ap-ownership-patch.json':json.dumps(recipe,indent=2)+'\n',
    '.github/workflows/list-applicative-evidence.yml':Path('/private/tmp/fwp-list-ap-evidence.yml').read_text(),
})
run=api('/actions/runs/38152053646');assert run['head_sha']==OLD
if run['status']=='queued':
    assert all(j['status']=='queued' for j in api('/actions/runs/38152053646/jobs')['jobs'])
    subprocess.run(['gh','run','cancel','38152053646'],check=True)
else:
    assert run['status']=='completed','Retain running evidence until it completes'
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
    dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==OLD
# Verify every staged blob before exposing the new evidence head.
entries=api('/git/trees/'+tree['sha']+'?recursive=1');assert not entries['truncated']
hashes={entry['path']:entry['sha'] for entry in entries['tree']}
for name,data in files.items():
    raw=data.encode();assert hashes[name]==hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest(),name
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
for name,data in files.items():assert source(commit['sha'],name)==data,name
Path('/private/tmp/fwp-list-ap-ownership-patch.json').write_text(files['scripts/list-ap-ownership-patch.json'])
Path('/private/tmp/fwp-state-slot-list-publication.json').write_text(json.dumps(
    dict(head=commit['sha'],previous=OLD,base=BASE,branch=BRANCH,supersededRun=38152053646,
         sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
         stage='State cleanup and controls published; native and allocation checks pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
