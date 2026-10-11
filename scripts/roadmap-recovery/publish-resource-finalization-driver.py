"""Publish a read-only runner finalizer after verifying every prerequisite gate."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
BASE='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
RECOVERY='69fa8ff9c173a78dc8a8d7875e7ae44cc569305a'
BRANCH='ownership-roadmap-finalization'
SUBJECT='Finalize the tested resource and runtime ownership bundle'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-finalization-driver-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
gates={
    38138731040:('9e7d0b24610524cf54125c44b47ee07185c0b7c3',6),
    38138731036:('9e7d0b24610524cf54125c44b47ee07185c0b7c3',1),
    38161107226:(BASE,1),
    38140923130:('82c7bc7509c04b9e94004c06b02d83d665539ac6',1),
    38161909445:('6f2ff860197831b990c2c918e25aa29871488ea3',1),
    38139112950:('602e076604d3dd759c47b396c10cf848dd9dbb61',3),
    38159488927:('fbc7e38087b3708c60d21302e29b9013c7d6fa2c',3),
    38159536008:('9ae50851389fbfa7c5c155fca477a4b958589c99',3),
    38160607296:('4f21a9ea99c1a06a3f1ba67818936194fe43e42a',3),
}
verified={}
for number,(head,count) in gates.items():
    run=api('/actions/runs/'+str(number));assert run['head_sha']==head
    assert run['status']=='completed' and run['conclusion']=='success',(number,run['status'],run['conclusion'])
    jobs=api('/actions/runs/'+str(number)+'/jobs')['jobs']
    assert len(jobs)==count and all(j['status']=='completed' and j['conclusion']=='success' for j in jobs)
    verified[number]=dict(head=head,jobs=[j['name'] for j in jobs])
    print('Verified prerequisite',number,flush=True)
post=api('/pulls/123');assert post['merged'] and post['merge_commit_sha']==BASE
assert api('/git/ref/heads/main')['object']['sha']==BASE
assert api('/git/ref/heads/roadmap/handoff-pr123-20261011')['object']['sha']==RECOVERY
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha']=='066b497040ff7b7f59fec6ff3337c63428f83d77'
workflow=Path('/private/tmp/fwp-finalize-resource-network-on-runner.yml').read_text()
assert 'REPLACE_WITH_' not in workflow and workflow.count(RECOVERY)==1
files={
    '.github/workflows/roadmap-resource-finalization.yml':workflow,
    'scripts/finalize-resource-network.py':Path('/private/tmp/fwp-finalize-resource-network-on-runner.py').read_text(),
    'scripts/export_prepared_commits.py':Path('/private/tmp/fwp-export-prepared-commits.py').read_text(),
}
probe=subprocess.run(['gh','api',REPO+'/git/ref/heads/'+BRANCH],capture_output=True,text=True)
assert probe.returncode!=0 and '404' in probe.stderr,'Do not replace an existing finalization driver'
parent=api('/git/commits/'+BASE)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
    dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[BASE]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==BASE
for name,data in files.items():
    staged=api('/contents/'+name+'?ref='+commit['sha']);assert base64.b64decode(staged['content']).decode()==data,name
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']))
assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-resource-finalization-driver-publication.json').write_text(json.dumps(dict(
    head=commit['sha'],base=BASE,branch=BRANCH,recovery=RECOVERY,prerequisites=verified,
    sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
    stage='Verified prerequisites and published read-only finalization driver; runner integration pending'),indent=2)+'\n')
print('Finalization driver',commit['sha'],flush=True)
