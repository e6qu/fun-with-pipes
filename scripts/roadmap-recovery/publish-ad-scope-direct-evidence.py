"""Publish a runner-only allocation driver with identical State native source."""
from pathlib import Path
import hashlib, json, subprocess
REPO = 'repos/e6qu/fun-with-pipes'
BASE = '1aadb8a075e1737d0e6a4db96eae5d675f6fb404'
BRANCH = 'ownership-evidence-ad-scope-direct'
SUBJECT = 'Pass gradient inputs directly through scoped callbacks'
RECEIPT = Path('/private/tmp/fwp-ad-scope-direct-publication.json')
def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-ad-scope-direct-api-input.json');path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))
assert not RECEIPT.exists()
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha'] == BASE
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
files = {n:(Path('/private/tmp/fwp-ad-scope-direct-draft')/n).read_text() for n in ['src/interp.rs','src/cgen.rs','src/ownership.rs','lib/autodiff.fwp','runtime/fwp_rt_kernel.c','tests/fixtures/ad_scope_probe.c']}
files['scripts/measure-ad-scope-allocations-complete.py']=Path('/private/tmp/fwp-measure-ad-scope-allocations-complete.py').read_text()
files['.github/workflows/ad-scope-direct-evidence.yml']=Path('/private/tmp/fwp-ad-scope-direct-evidence.yml').read_text()
parent = api('/git/commits/' + BASE)
before = api('/git/trees/' + parent['tree']['sha'] + '?recursive=1');assert not before['truncated']
tree = api('/git/trees', dict(base_tree=parent['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=content) for name, content in files.items()]))
after = api('/git/trees/' + tree['sha'] + '?recursive=1');assert not after['truncated']
b = {x['path']:x['sha'] for x in before['tree'] if x['type'] != 'tree'}
a = {x['path']:x['sha'] for x in after['tree'] if x['type'] != 'tree'}
assert set(a) - set(b) == {'.github/workflows/ad-scope-direct-evidence.yml','scripts/measure-ad-scope-allocations-complete.py'}
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
    stage='Source-identical allocation driver published; measurements pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
