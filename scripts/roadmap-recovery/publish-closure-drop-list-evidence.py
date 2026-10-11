"""Bundle recovered closure-cleanup contexts into the existing list evidence."""
from pathlib import Path
import base64,hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes')
REPO='repos/e6qu/fun-with-pipes'
OLD='05556bfb3d7f7e2299cdfcad84d220d5455f75f2'
BASE='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
BRANCH='ownership-evidence-list-applicative'
SUBJECT='Reset closure destruction contexts after recovered traps'
def api(endpoint,payload=None,method='POST'):
 args=['gh','api',REPO+endpoint]
 if payload is not None:
  path=Path('/private/tmp/fwp-closure-list-api-input.json');path.write_text(json.dumps(payload))
  args+=['--method',method,'--input',str(path)]
 return json.loads(subprocess.check_output(args,text=True))
def source(head,name):
 result=api('/contents/'+name+'?ref='+head);assert result['encoding']=='base64'
 return base64.b64decode(result['content']).decode()
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
run=api('/actions/runs/38148442793');assert run['head_sha']==OLD
if run['status']=='queued':
 assert all(j['status']=='queued' for j in api('/actions/runs/38148442793/jobs')['jobs'])
 subprocess.run(['gh','run','cancel','38148442793'],check=True)
else:
 assert run['status']=='completed','Preserve a running evidence job until it completes'
original=source(BASE,'runtime/fwp_rt_gc.c')
draft=Path('/private/tmp/fwp-closure-drop-runtime.c').read_text()
a=original.index('static void fwp_closure_drop(V f) {');b=original.index('\n#ifndef FWP_UNWIND',a)
c=draft.index('/* A recovered allocation/type trap');d=draft.index('\n#ifndef FWP_UNWIND',c)
assert original[:a]+draft[c:d]+original[b:]==draft
candidate=original[:a]+draft[c:d]+original[b:]
recipe_path=Path('/private/tmp/fwp-list-ap-ownership-patch.json')
recipe=json.loads(recipe_path.read_text());assert 'runtime/fwp_rt_gc.c' not in recipe
recipe['runtime/fwp_rt_gc.c']=[dict(old=original[a:b],new=draft[c:d])]
files={
 'runtime/fwp_rt_gc.c':candidate,
 'tests/list_applicative_ownership.rs':Path('/private/tmp/fwp-list-ap-test.rs').read_text(),
 'tests/fixtures/closure_drop_probe.c':Path('/private/tmp/fwp-closure-drop-probe.c').read_text(),
 'scripts/list-ap-ownership-patch.json':json.dumps(recipe,indent=2)+'\n',
 '.github/workflows/list-applicative-evidence.yml':Path('/private/tmp/fwp-list-ap-evidence.yml').read_text(),
}
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[
 dict(path=name,mode='100644',type='blob',content=data) for name,data in files.items()]))
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
for name,data in files.items():assert source(commit['sha'],name)==data,name
recipe_path.write_text(files['scripts/list-ap-ownership-patch.json'])
Path('/private/tmp/fwp-closure-drop-runtime.c').write_text(candidate)
Path('/private/tmp/fwp-closure-drop-list-publication.json').write_text(json.dumps(
 dict(head=commit['sha'],previous=OLD,base=BASE,branch=BRANCH,
      supersededRun=38148442793,sourceHashes={name:hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()},
      stage='Published closure cleanup repair and controls; native checks and allocation parity pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
