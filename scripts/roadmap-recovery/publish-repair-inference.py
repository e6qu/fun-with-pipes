"""Publish a read-only runner finalizer after verifying every prerequisite gate."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
BASE='9550aab94bf5cb2adb4f6a462381537d37ce3644'
RECOVERY='b9527f81af81342742daf48ce386ec3c9bd9b37b'
BRANCH='ownership-pr124-combined-repair'
SUBJECT='Preserve returned function effects until their actual call'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-combined-repair-driver-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
gates={38167118922:('ec1915e7386128352a792071701c16b076084e75',3),38166896486:('ac7b518c5b1d80dd55c385728cdae5bbdde1f44e',3)}
verified={}
for number,(head,count) in gates.items():
    run=api('/actions/runs/'+str(number));assert run['head_sha']==head
    assert run['status']=='completed' and run['conclusion']=='success',(number,run['status'],run['conclusion'])
    jobs=api('/actions/runs/'+str(number)+'/jobs')['jobs']
    assert len(jobs)==count and all(j['status']=='completed' and j['conclusion']=='success' for j in jobs)
    verified[number]=dict(head=head,jobs=[j['name'] for j in jobs])
    print('Verified prerequisite',number,flush=True)
assert api('/git/ref/heads/main')['object']['sha']=='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
assert api('/git/ref/heads/roadmap/handoff-pr123-20261011')['object']['sha']==RECOVERY
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha']==BASE
assert api('/pulls/124')['head']['sha']==BASE
workflow=Path('/private/tmp/fwp-pr124-combined-repair.yml').read_text()
assert workflow.count(RECOVERY)==1 and 'FWP_RECOVERY_HEAD:' in workflow
files={'.github/workflows/pr124-combined-repair.yml':workflow,
 'scripts/integrate-pr124-repair.py':Path('/private/tmp/fwp-integrate-pr124-repair-on-runner.py').read_text(),
 'scripts/export_prepared_commits.py':Path('/private/tmp/fwp-export-prepared-commits.py').read_text(),
 'scripts/typed-state-expanded-test.rs':Path('/private/tmp/fwp-typed-state-expanded-test.rs').read_text(),
 'scripts/instantiate-function-effects-patch.json':Path('/private/tmp/fwp-instantiate-function-effects-patch.json').read_text()}
OLD='c4c28e998a5580498573da4f1c0fade411baacc5'
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
failed=api('/actions/runs/38169724664')
assert failed['head_sha']==OLD and failed['status']=='completed' and failed['conclusion']=='failure'
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
    dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==OLD
for name,data in files.items():
    staged=api('/contents/'+name+'?ref='+commit['sha']);assert base64.b64decode(staged['content']).decode()==data,name
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-combined-repair-inference-publication.json').write_text(json.dumps(dict(
    head=commit['sha'],base=BASE,branch=BRANCH,recovery=RECOVERY,prerequisites=verified,
    sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
    stage='Verified prerequisites and published read-only finalization driver; runner integration pending'),indent=2)+'\n')
print('Finalization driver',commit['sha'],flush=True)
