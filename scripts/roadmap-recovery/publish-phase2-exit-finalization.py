"""Publish a runner-only allocation driver with identical State native source."""
from pathlib import Path
import hashlib, json, subprocess
REPO = 'repos/e6qu/fun-with-pipes'
BASE = None
BRANCH = 'ownership-phase2-exit-finalization'
SUBJECT = 'Prepare finite ownership exit and checked buffer delivery'
RECEIPT = Path('/private/tmp/fwp-phase2-exit-finalization-publication.json')
def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-phase2-exit-finalization-api-input.json');path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))
assert not RECEIPT.exists()
proof=json.loads(Path('/private/tmp/fwp-pr124-merge-proof.json').read_text())
assert proof['acceptedHead']=='d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0'
assert proof['verification']=='GitHub verified signed commit payload'
BASE=proof['sha'];assert api('/git/ref/heads/main')['object']['sha']==BASE
assert 'Archived handoff after PR #124' in Path('docs/roadmap-history.md').read_text()
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
files = {
 'scripts/finalize-phase2-exit.py':Path('/private/tmp/fwp-finalize-phase2-exit-on-runner.py').read_text(),
 'scripts/export_prepared_commits.py':Path('/private/tmp/fwp-export-prepared-commits.py').read_text(),
 '.github/workflows/phase2-exit-finalization.yml':Path('/private/tmp/fwp-phase2-exit-finalization.yml').read_text(),
}
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
files.update({name:Path(name).read_text() for name in DOCS})
parent = api('/git/commits/' + BASE)
before = api('/git/trees/' + parent['tree']['sha'] + '?recursive=1');assert not before['truncated']
tree = api('/git/trees', dict(base_tree=parent['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=content) for name, content in files.items()]))
after = api('/git/trees/' + tree['sha'] + '?recursive=1');assert not after['truncated']
b = {x['path']:x['sha'] for x in before['tree'] if x['type'] != 'tree'}
a = {x['path']:x['sha'] for x in after['tree'] if x['type'] != 'tree'}
assert set(a) - set(b) == set(files) - set(b)
assert all(a[name] == sha for name, sha in b.items() if name not in files)
for name, content in files.items():
    raw = content.encode();assert a[name] == hashlib.sha1(b'blob ' + str(len(raw)).encode() + b'\0' + raw).hexdigest()
assert len(SUBJECT) <= 80 and '\n' not in SUBJECT
commit = api('/git/commits', dict(message=SUBJECT, tree=tree['sha'], parents=[BASE]))
assert commit['message'] == SUBJECT and [p['sha'] for p in commit['parents']] == [BASE]
ref = api('/git/refs', dict(ref='refs/heads/' + BRANCH, sha=commit['sha']))
assert ref['object']['sha'] == commit['sha']
RECEIPT.write_text(json.dumps(dict(head=commit['sha'], base=BASE, branch=BRANCH,
    unchangedNativeTree=parent['tree']['sha'],
    sourceHashes={name:hashlib.sha256(content.encode()).hexdigest() for name,content in files.items()},
    stage='Phase2 exit finalization published; runner validation pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
