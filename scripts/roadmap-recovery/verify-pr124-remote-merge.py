"""Verify the accepted squash using GitHub's signed raw commit payload."""
from pathlib import Path
import hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
HEAD='3aae99bfa705e26babc2cf251b0e583dfd95cf38'
BASE='b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
SUBJECT='Own resource and State lifetimes and preserve inferred effects'
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
post=json.loads(Path('/private/tmp/fwp-pr124-postmerge.json').read_text())
gates=json.loads(Path('/private/tmp/fwp-pr124-final-gate-proof.json').read_text())
assert post['merged'] and post['head']['sha']==HEAD and post['base']['sha']==BASE
sha=post['merge_commit_sha'];accepted=api('/git/commits/'+sha);tested=api('/git/commits/'+HEAD)
assert api('/git/ref/heads/main')['object']['sha']==sha
assert [p['sha'] for p in accepted['parents']]==[BASE]
assert accepted['tree']['sha']==tested['tree']['sha']
verification=accepted['verification'];assert verification['verified'] and verification['payload']
raw=verification['payload'].encode();headers,message=raw.split(b'\n\n',1)
subject=message.decode().rstrip('\n')
assert subject in {SUBJECT,SUBJECT+' (#124)'} and len(subject)<=80
assert message in {subject.encode(),subject.encode()+b'\n'}
assert accepted['message'].rstrip('\n')==subject
assert [row[7:].decode() for row in headers.splitlines() if row.startswith(b'parent ')]==[BASE]
assert not any(term in subject.lower() for term in ['co-authored','authored by','authored-by','ai attribution'])
for gate in (gates['ci'],gates['docs']):
    assert gate['headSha']==HEAD and gate['status']=='completed' and gate['conclusion']=='success'
    assert all(j['conclusion']=='success' and j['completedAt']<=post['merged_at'] for j in gate['jobs'])
proof=dict(sha=sha,mergedAt=post['merged_at'],subject=subject,message=message.decode(),
    characters=len(subject),tree=accepted['tree']['sha'],acceptedHead=HEAD,parents=[BASE],
    rawPayloadHash=hashlib.sha256(raw).hexdigest(),verification='GitHub verified signed commit payload',
    localMain='68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4',localFastForward='Deferred while free disk is below 64 GiB')
Path('/private/tmp/fwp-pr124-merge-proof.json').write_text(json.dumps(proof,indent=2)+'\n')
Path('/private/tmp/fwp-pr124-signed-payload.txt').write_bytes(raw)
print('Verified squash',sha,'subject characters',len(subject),'tree',proof['tree'],flush=True)
