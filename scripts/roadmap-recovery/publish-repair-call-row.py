"""Publish the minimal ambient-call-row repair after failed preflight review."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
BASE='9550aab94bf5cb2adb4f6a462381537d37ce3644'
OLD='32205aeaae51cd9d38944e10d674847ee46cd53e'
RECOVERY='b9527f81af81342742daf48ce386ec3c9bd9b37b'
BRANCH='ownership-pr124-combined-repair'
SUBJECT='Keep ambient State effects out of stored function types'
def api(endpoint,payload=None,method='POST'):
 argv=['gh','api',REPO+endpoint]
 if payload is not None:
  p=Path('/private/tmp/fwp-call-row-driver-input.json');p.write_text(json.dumps(payload));argv+=['--method',method,'--input',str(p)]
 return json.loads(subprocess.check_output(argv,text=True))
for number,head in [(38167118922,'ec1915e7386128352a792071701c16b076084e75'),(38166896486,'ac7b518c5b1d80dd55c385728cdae5bbdde1f44e')]:
 run=api('/actions/runs/'+str(number));assert run['head_sha']==head and run['status']=='completed' and run['conclusion']=='success'
 jobs=api('/actions/runs/'+str(number)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
run=api('/actions/runs/38170352491');assert run['head_sha']==OLD and run['status']=='completed' and run['conclusion']=='failure'
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
assert api('/pulls/124')['head']['sha']==BASE
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha']==BASE
assert api('/git/ref/heads/main')['object']['sha']=='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
tip=api('/git/ref/heads/roadmap/handoff-pr123-20261011')['object']['sha']
if tip!=RECOVERY:
 ancestry=api('/compare/'+RECOVERY+'...'+tip);assert ancestry['status']=='ahead' and ancestry['merge_base_commit']['sha']==RECOVERY
files={'scripts/integrate-pr124-repair.py':Path('/private/tmp/fwp-integrate-pr124-repair-on-runner.py').read_text(),
 'scripts/call-row-ambient-patch.json':Path('/private/tmp/fwp-call-row-ambient-patch.json').read_text(),
 'scripts/typed-state-expanded-test.rs':Path('/private/tmp/fwp-typed-state-expanded-test.rs').read_text()}
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
files.update({name:Path(name).read_text() for name in DOCS})
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and [p['sha'] for p in commit['parents']]==[OLD]
entries=api('/git/trees/'+tree['sha']+'?recursive=1');assert not entries['truncated']
observed={entry['path']:entry['sha'] for entry in entries['tree']}
for name,data in files.items():
 encoded=data.encode();assert observed[name]==hashlib.sha1(b'blob '+str(len(encoded)).encode()+b'\0'+encoded).hexdigest(),name
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH');assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-combined-repair-call-row-publication.json').write_text(json.dumps(dict(head=commit['sha'],previous=OLD,base=BASE,branch=BRANCH,recovery=RECOVERY,sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},stage='Minimal repair published for preflight; production PR unchanged'),indent=2)+'\n')
print(commit['sha'],flush=True)
