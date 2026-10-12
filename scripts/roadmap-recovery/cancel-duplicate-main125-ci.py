"""Cancel duplicate main CI only after exact pre-merge and tree parity proofs."""
from pathlib import Path
import json,subprocess
REPO='repos/e6qu/fun-with-pipes'
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
proof=json.loads(Path('/private/tmp/fwp-phase2-exit-merge-proof.json').read_text());gates=json.loads(Path('/private/tmp/fwp-phase2-exit-final-gate-proof.json').read_text())
assert proof['acceptedHead']=='37e94c1efa1bb99e955d026b8dde46dfe632e972'
assert proof['verification']=='GitHub verified signed commit payload'
assert api('/git/ref/heads/main')['object']['sha']==proof['sha']
assert api('/git/commits/'+proof['sha'])['tree']['sha']==api('/git/commits/'+proof['acceptedHead'])['tree']['sha']==proof['tree']
assert len(gates['gates']['CI']['proof']['jobs'])==6 and len(gates['gates']['Roadmap documentation']['proof']['jobs'])==1
for gate in [gates['gates']['CI']['proof'],gates['gates']['Roadmap documentation']['proof']]:
 assert gate['headSha']==proof['acceptedHead'] and gate['status']=='completed' and gate['conclusion']=='success'
 assert all(j['status']=='completed' and j['conclusion']=='success' and j['completedAt']<=proof['mergedAt'] for j in gate['jobs'])
runs=api('/actions/runs?head_sha='+proof['sha']+'&per_page=30')['workflow_runs']
selected=[r for r in runs if r['path']=='.github/workflows/ci.yml' and r['head_branch']=='main' and r['event']=='push']
assert len(selected)<=1
record=dict(accepted=proof,passingGates=gates,duplicates=[])
for run in selected:
 assert run['head_sha']==proof['sha']
 jobs=api('/actions/runs/'+str(run['id'])+'/jobs')['jobs']
 assert not any(j['conclusion'] in {'failure','timed_out','action_required'} for j in jobs), 'Diagnose duplicate-run failures before cancellation'
 record['duplicates'].append(dict(run=run,jobs=jobs))
 if run['status']!='completed':subprocess.run(['gh','run','cancel',str(run['id'])],check=True)
Path('/private/tmp/fwp-main125-duplicate-ci-proof.json').write_text(json.dumps(record,indent=2)+'\n')
print('Duplicate main CI examined:',len(selected),'with exact pre-merge proof retained')
