"""Require all current-head gates and verify a one-line numerical squash."""
from pathlib import Path
import hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';BRANCH='checked-arc-and-loop-ownership'
SUBJECT='Complete checked ARC execution and loop ownership optimizations'
NAMES={'test','bench','macos (macos-15)','macos (macos-15-intel)','macos_gc (macos-15)','macos_gc (macos-15-intel)'}
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
previous=json.loads(Path('/private/tmp/fwp-numerical-merge-proof.json').read_text())
prs=api('/pulls?state=all&head=e6qu:'+BRANCH+'&per_page=20');assert len(prs)==1
pr=api('/pulls/'+str(prs[0]['number']));assert pr['head']['ref']==BRANCH and not pr['draft']
HEAD=pr['head']['sha'];BASE=previous['sha'];assert pr['base']['ref']=='main' and pr['base']['sha']==BASE
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==HEAD
runs=json.loads(subprocess.check_output(['gh','run','list','--repo','e6qu/fun-with-pipes','--branch',BRANCH,'--limit','30','--json','databaseId,workflowName,headSha,status,conclusion'],text=True));gates={}
for workflow,names in [('CI',NAMES),('Roadmap documentation',{'roadmap_docs'})]:
 matches=[r for r in runs if r['headSha']==HEAD and r['workflowName']==workflow];assert matches
 latest=matches[0];assert latest['status']=='completed' and latest['conclusion']=='success'
 gate=json.loads(subprocess.check_output(['gh','run','view',str(latest['databaseId']),'--repo','e6qu/fun-with-pipes','--json','headSha,status,conclusion,jobs'],text=True))
 assert gate['headSha']==HEAD and gate['status']=='completed' and gate['conclusion']=='success'
 assert len(gate['jobs'])==len(names) and {j['name'] for j in gate['jobs']}==names
 assert all(j['status']=='completed' and j['conclusion']=='success' for j in gate['jobs'])
 gates[workflow]=dict(run=latest['databaseId'],proof=gate)
Path('/private/tmp/fwp-ownership-final-gate-proof.json').write_text(json.dumps(dict(pr=pr,gates=gates),indent=2)+'\n')
if not pr['merged']:
 assert pr['state']=='open' and api('/git/ref/heads/main')['object']['sha']==BASE
 subprocess.run(['gh','pr','merge',str(pr['number']),'--repo','e6qu/fun-with-pipes','--squash','--subject',SUBJECT,'--body','','--match-head-commit',HEAD],check=True)
post=api('/pulls/'+str(pr['number']));assert post['merged'] and post['head']['sha']==HEAD
sha=post['merge_commit_sha'];accepted=api('/git/commits/'+sha);tested=api('/git/commits/'+HEAD)
assert api('/git/ref/heads/main')['object']['sha']==sha
assert [p['sha'] for p in accepted['parents']]==[BASE] and accepted['tree']['sha']==tested['tree']['sha']
v=accepted['verification'];assert v['verified'] and v['payload'];raw=v['payload'].encode();headers,message=raw.split(b'\n\n',1);subject=message.decode().rstrip('\n')
assert subject in {SUBJECT,SUBJECT+' (#'+str(pr['number'])+')'} and len(subject)<=80
assert message in {subject.encode(),subject.encode()+b'\n'}
assert [x[7:].decode() for x in headers.splitlines() if x.startswith(b'parent ')]==[BASE]
assert not any(x in subject.lower() for x in ['co-authored','authored by','authored-by','ai attribution'])
assert all(j['completedAt']<=post['merged_at'] for g in gates.values() for j in g['proof']['jobs'])
proof=dict(sha=sha,acceptedHead=HEAD,tree=accepted['tree']['sha'],parents=[BASE],pr=pr['number'],mergedAt=post['merged_at'],subject=subject,message=message.decode(),characters=len(subject),rawPayloadSha256=hashlib.sha256(raw).hexdigest(),verification='GitHub verified signed commit payload',stage='Squash verified; actual merged-source phases5–6 audit remains required')
Path('/private/tmp/fwp-ownership-merge-proof.json').write_text(json.dumps(proof,indent=2)+'\n');Path('/private/tmp/fwp-ownership-signed-payload.txt').write_bytes(raw)
print('Verified checked ownership squash',sha,'PR',pr['number'])
