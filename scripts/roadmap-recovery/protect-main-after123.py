from pathlib import Path
import hashlib, json, subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes')
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
BASE='68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'
HEAD='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
SUBJECT='Own library file and raw-memory resource lifetimes'
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT)
post=json.loads(Path('/private/tmp/fwp-pr123-postmerge.json').read_text())
assert post['merged'] and post['head']['sha']==HEAD
sha=post['merge_commit_sha']
raw=git('cat-file','commit',sha)
headers,message=raw.split(b'\n\n',1)
actual_subject=message.decode().rstrip(chr(10))
assert actual_subject in [SUBJECT,SUBJECT+" (#123)"] and len(actual_subject)<=80, message
assert message in [actual_subject.encode(),actual_subject.encode()+b"\n"], message
assert [line[7:].decode() for line in headers.splitlines() if line.startswith(b'parent ')]==[BASE]
tree=git('rev-parse',sha+'^{tree}').decode().strip()
assert tree==git('rev-parse',HEAD+'^{tree}').decode().strip()
proof=dict(sha=sha,mergedAt=post['merged_at'],subject=actual_subject,message=message.decode(),characters=len(actual_subject),tree=tree,acceptedHead=HEAD,parents=[BASE])
Path('/private/tmp/fwp-pr123-merge-proof.json').write_text(json.dumps(proof,indent=2)+'\n')
assert git('branch','--show-current').strip()==b'main'
assert git('rev-parse','HEAD').decode().strip()==BASE
assert not git('diff','--cached','--name-only'), 'Unexpected staged changes'
dirty=git('diff','--name-only').decode().splitlines()
assert set(dirty)<=set(DOCS), ('Preserve unexpected tracked changes before updating main',dirty)
backup=Path('/private/tmp/fwp-main-docs-pre123')
assert not backup.exists(), 'Do not overwrite an existing protected snapshot'
backup.mkdir()
hashes={}
for name in DOCS:
 data=(ROOT/name).read_bytes();dest=backup/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data);hashes[name]=hashlib.sha256(data).hexdigest()
(backup/'sha256.json').write_text(json.dumps(hashes,indent=2)+'\n')
(backup/'metadata.json').write_text(json.dumps(dict(base=BASE,acceptedHead=HEAD,squash=sha,dirty=dirty),indent=2)+'\n')
for name in DOCS:assert hashlib.sha256((backup/name).read_bytes()).hexdigest()==hashes[name]
if dirty:subprocess.run(['git','restore','--',*dirty],cwd=ROOT,check=True)
subprocess.run(['git','merge','--ff-only',sha],cwd=ROOT,check=True)
for name in DOCS:(ROOT/name).write_bytes((backup/name).read_bytes())
for name in DOCS:assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest()==hashes[name]
print('Verified one-line squash message and complete-tree parity; protected all11 docs and fast-forwarded main to',sha,flush=True)
