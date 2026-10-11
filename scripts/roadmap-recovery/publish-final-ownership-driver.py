"""Publish a runner-only allocation driver with identical State native source."""
from pathlib import Path
import hashlib, json, subprocess
REPO = 'repos/e6qu/fun-with-pipes'
BASE = '1aadb8a075e1737d0e6a4db96eae5d675f6fb404'
BRANCH = 'ownership-pr124-final-ownership'
SUBJECT = 'Prepare final ownership integration with complete allocation checks'
RECEIPT = Path('/private/tmp/fwp-final-ownership-driver-publication.json')
def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-final-ownership-driver-api-input.json');path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))
assert not RECEIPT.exists()
assert api('/git/ref/heads/ownership-resource-network-bundle')['object']['sha'] == BASE
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
files = {
 'scripts/integrate-final-ownership.py':Path('/private/tmp/fwp-integrate-final-ownership-on-runner.py').read_text(),
 'scripts/export_prepared_commits.py':Path('/private/tmp/fwp-export-prepared-commits.py').read_text(),
 'scripts/codec-leaf-ownership-patch.json':Path('/private/tmp/fwp-serializer-leaf-ownership-patch.json').read_text(),
 'scripts/check-primitive-inventory-final.py':Path('/private/tmp/fwp-check-primitive-inventory-final-bundle-draft.py').read_text(),
 'scripts/measure-typed-state-allocations-complete.py':Path('/private/tmp/fwp-measure-typed-state-allocations-complete.py').read_text(),
 'scripts/measure-ad-scope-allocations-complete.py':Path('/private/tmp/fwp-measure-ad-scope-allocations-complete.py').read_text(),
 'scripts/measure-list-callback-allocations-complete.py':Path('/private/tmp/fwp-measure-list-callback-allocations-final.py').read_text(),
 '.github/workflows/final-ownership-preflight.yml':Path('/private/tmp/fwp-pr124-final-ownership.yml').read_text(),
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
    stage='Source-identical allocation driver published; measurements pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
