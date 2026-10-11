"""Bound the collector hook by the actual allocation during State growth."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';OLD='277681334b4dcaec7e702cd0a2b59d37260813b9'
BRANCH='ownership-evidence-list-applicative';RUN=38159499262
SUBJECT='Scan only allocated State words during growth controls'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-state-probe-range-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
name='tests/fixtures/state_slot_probe.c';candidate=Path('/private/tmp/fwp-state-slot-probe.c').read_bytes()
old=api('/contents/'+name+'?ref='+OLD);prior=base64.b64decode(old['content'])
assert b'hi < lo + fwp_state_cap * sizeof(V)' in prior and candidate!=prior
assert b'if(scanned<fwp_state_len)' in candidate and b'i<limit' in candidate
gate=api('/actions/runs/'+str(RUN));assert gate['head_sha']==OLD
if gate['status']=='queued':
    assert all(j['status']=='queued' for j in api('/actions/runs/'+str(RUN)+'/jobs')['jobs'])
    subprocess.run(['gh','run','cancel',str(RUN)],check=True)
else:assert gate['status']=='completed','Retain any running controls until completion'
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=name,mode='100644',type='blob',content=candidate.decode())]))
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and len(SUBJECT)<=80 and '\n' not in SUBJECT
staged=api('/contents/'+name+'?ref='+commit['sha']);assert base64.b64decode(staged['content'])==candidate
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-state-probe-range-publication.json').write_text(json.dumps(dict(
    head=commit['sha'],previous=OLD,branch=BRANCH,supersededRun=RUN,
    sourceHashes={name:hashlib.sha256(candidate).hexdigest()},
    stage='Collector range probe corrected; runtime source unchanged and runner checks pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
