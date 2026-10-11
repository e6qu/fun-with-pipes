"""Free runners occupied by the known-failing, superseded PR124 head."""
from pathlib import Path
import json,subprocess
REPO='e6qu/fun-with-pipes';OLD='d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0';NEW='3aae99bfa705e26babc2cf251b0e583dfd95cf38'
def gh(*args):return json.loads(subprocess.check_output(['gh',*args],text=True))
pr=gh('pr','view','124','--repo',REPO,'--json','state,headRefOid');assert pr['state']=='OPEN' and pr['headRefOid']==NEW
old=gh('run','view','38180852377','--repo',REPO,'--json','headSha,status,conclusion,jobs')
new=gh('run','view','38184549852','--repo',REPO,'--json','headSha,status,conclusion,jobs');assert old['headSha']==OLD and new['headSha']==NEW
assert any(j['name']=='macos (macos-15)' and j['conclusion']=='failure' for j in old['jobs'])
c=gh('api','repos/'+REPO+'/git/commits/'+NEW);assert [p['sha'] for p in c['parents']]==[OLD]
comparison=gh('api','repos/'+REPO+'/compare/'+OLD+'...'+NEW);assert comparison['status']=='ahead' and comparison['ahead_by']==1 and comparison['behind_by']==0
assert [f['filename'] for f in comparison['files']]==['tests/serializer_leaf_ownership.rs']
record=dict(old=old,new=new,comparison=comparison,reason='Known-failing earlier head superseded by three-platform verified fixture repair; cancellation is not a passing gate')
Path('/private/tmp/fwp-pr124-d5-superseded-ci-proof.json').write_text(json.dumps(record,indent=2)+'\n')
if old['status']!='completed':subprocess.run(['gh','run','cancel','38180852377','--repo',REPO],check=True)
print('Superseded old head; all new exact-head gates remain required',flush=True)
