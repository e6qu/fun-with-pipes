"""Audit accepted phase2 source after verified exact-head squash acceptance."""
from pathlib import Path
import hashlib,json,os,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=ROOT/'phase2-accepted-source';OUT.mkdir(exist_ok=True)
REPO='repos/e6qu/fun-with-pipes';BRANCH='ownership-exit-and-buffer-bundle'
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
def git(*a,cwd=ROOT):return subprocess.check_output(['git',*a],cwd=cwd,text=True).strip()
prs=api('/pulls?state=closed&head=e6qu:'+BRANCH+'&per_page=20')
accepted=[p for p in prs if p['merged_at']];assert len(accepted)==1
pr=api('/pulls/'+str(accepted[0]['number']));assert pr['merged'] and pr['head']['ref']==BRANCH
HEAD=pr['head']['sha'];BASE=pr['merge_commit_sha']
assert api('/git/ref/heads/main')['object']['sha']==BASE
squash=api('/git/commits/'+BASE);tested=api('/git/commits/'+HEAD)
assert squash['tree']['sha']==tested['tree']['sha'] and len(squash['parents'])==1
v=squash['verification'];assert v['verified'] and v['payload']
raw=v['payload'].encode();headers,message=raw.split(b'\n\n',1)
subject=message.decode().rstrip('\n');assert '\n' not in subject and len(subject)<=80
assert message in {subject.encode(),subject.encode()+b'\n'}
assert not any(x in subject.lower() for x in ['co-authored','authored by','authored-by','ai attribution'])
parent=squash['parents'][0]['sha'];previous=api('/pulls/124')
assert previous['merged'] and previous['merge_commit_sha']==parent
assert [x[7:].decode() for x in headers.splitlines() if x.startswith(b'parent ')]==[parent]
runs=json.loads(subprocess.check_output(['gh','run','list','--repo','e6qu/fun-with-pipes','--branch',BRANCH,'--limit','30','--json','databaseId,workflowName,headSha,status,conclusion'],text=True))
gates={}
for workflow in ['CI','Roadmap documentation']:
 matches=[r for r in runs if r['headSha']==HEAD and r['workflowName']==workflow];assert matches
 latest=matches[0];assert latest['status']=='completed' and latest['conclusion']=='success'
 gate=json.loads(subprocess.check_output(['gh','run','view',str(latest['databaseId']),'--repo','e6qu/fun-with-pipes','--json','headSha,status,conclusion,jobs'],text=True))
 assert gate['headSha']==HEAD and gate['status']=='completed' and gate['conclusion']=='success'
 names={'test','bench','macos (macos-15)','macos (macos-15-intel)','macos_gc (macos-15)','macos_gc (macos-15-intel)'} if workflow=='CI' else {'roadmap_docs'}
 assert len(gate['jobs'])==len(names) and {j['name'] for j in gate['jobs']}==names
 assert all(j['status']=='completed' and j['conclusion']=='success' and j['completedAt']<=pr['merged_at'] for j in gate['jobs'])
 gates[workflow]=dict(run=latest['databaseId'],proof=gate)
assert git('rev-parse','origin/main')==BASE
assert git('rev-parse',BASE+'^{tree}')==squash['tree']['sha']
WT=ROOT.parent/'phase2-actual-source';subprocess.run(['git','worktree','add','--detach',str(WT),BASE],check=True)
env=dict(os.environ,FWP_INVENTORY_EXPECTED_HEAD=BASE)
subprocess.run(['python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(OUT/'inventory.json')],cwd=WT,env=env,check=True)
subprocess.run(['python3','scripts/check-explicit-fallback-review.py','--inventory',str(OUT/'inventory.json'),'--review','tests/fixtures/primitive-fallback-review.json','--output',str(OUT/'fallback-review.json')],cwd=WT,env=env,check=True)
subprocess.run(['python3','scripts/check-roadmap.py'],cwd=WT,env=env,check=True)
assert not git('status','--porcelain',cwd=WT)
inventory=json.loads((OUT/'inventory.json').read_text());fallback=json.loads((OUT/'fallback-review.json').read_text())
assert inventory['head']==fallback['head']==BASE and fallback['declarations']==177 and fallback['symbols']==167
record=dict(head=BASE,testedHead=HEAD,parent=parent,pr=pr['number'],mergedAt=pr['merged_at'],tree=squash['tree']['sha'],subject=subject,rawPayloadSha256=hashlib.sha256(raw).hexdigest(),gates=gates,inventoryReport=inventory,fallbackReport=fallback,status='Phase2 accepted source coverage verified; phase3 may proceed',limits='Tracing remains required for explicit shared fallbacks and unreachable cycles; no tracing-free or unmeasured performance claim')
(OUT/'phase2-acceptance.json').write_text(json.dumps(record,indent=2)+'\n');(OUT/'signed-payload.txt').write_bytes(raw)
print('Verified accepted phase2 source',BASE,flush=True)
