"""Publish a runner-only allocation driver with identical State native source."""
from pathlib import Path
import hashlib, json, subprocess
REPO = 'repos/e6qu/fun-with-pipes'
BASE = 'd5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0'
BRANCH = 'ownership-evidence-phase2-exit-review'
SUBJECT = 'Review explicit tracing fallbacks and checked buffer growth'
RECEIPT = Path('/private/tmp/fwp-phase2-exit-review-publication.json')
def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-phase2-exit-review-api-input.json');path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))
assert not RECEIPT.exists()
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha'] == BASE
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
files = {
 'runtime/fwp_rt_ops.c':Path('/private/tmp/fwp-structural-buffer-draft.c').read_text(),
 'tests/structural_buffer.rs':Path('/private/tmp/fwp-structural-buffer-test.rs').read_text(),
 'tests/fixtures/structural_buffer_probe.c':Path('/private/tmp/fwp-structural-buffer-probe.c').read_text(),
 '.github/workflows/phase2-exit-review-evidence.yml':Path('/private/tmp/fwp-phase2-exit-review-evidence.yml').read_text(),
 'scripts/check-explicit-fallback-review.py':Path('/private/tmp/fwp-check-explicit-fallback-review-draft.py').read_text(),
 'tests/fixtures/primitive-fallback-review.json':Path('/private/tmp/fwp-phase2-explicit-fallback-review-draft.json').read_text(),
}
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
    stage='Finite fallback and buffer review published; actual-source controls pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
