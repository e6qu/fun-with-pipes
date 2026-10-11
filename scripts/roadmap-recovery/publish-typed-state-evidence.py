"""Publish an independent exact-source State candidate; full PR gates stay separate."""
from pathlib import Path
import base64, hashlib, json, subprocess

REPO = 'repos/e6qu/fun-with-pipes'
BASE = '9550aab94bf5cb2adb4f6a462381537d37ce3644'
BRANCH = 'ownership-evidence-typed-state'
SUBJECT = 'Retain typed State values through scopes and task switches'
RECEIPT = Path('/private/tmp/fwp-typed-state-publication.json')
NATIVE = ['src/ownership.rs', 'src/cgen.rs', 'runtime/fwp_rt.c',
          'runtime/fwp_rt_task.c', 'runtime/fwp_rt_prims.c']

def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-typed-state-api-input.json')
        path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))

assert not RECEIPT.exists(), 'Do not repeat a completed publication'
assert api('/pulls/124')['head']['sha'] == BASE
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
preparation = json.loads(Path('/private/tmp/fwp-typed-state-preparation.json').read_text())
assert preparation['base'] == BASE
recipe = json.loads(Path('/private/tmp/fwp-typed-state-ownership-patch.json').read_text())
assert set(recipe) == set(NATIVE)
files = {}
for name in NATIVE:
    staged = api('/contents/' + name + '?ref=' + BASE)
    original = base64.b64decode(staged['content'])
    assert hashlib.sha256(original).hexdigest() == preparation['sourceHashes'][name], name
    replay = original.decode()
    for edit in recipe[name]:
        assert replay.count(edit['old']) == 1, name
        replay = replay.replace(edit['old'], edit['new'], 1)
    target = Path('/private/tmp/fwp-typed-state-draft') / name
    assert target.read_text() == replay, name
    files[name] = replay
files.update({
    'tests/typed_state_ownership.rs': Path('/private/tmp/fwp-typed-state-test.rs').read_text(),
    'tests/fixtures/typed_state_probe.c': Path('/private/tmp/fwp-typed-state-probe.c').read_text(),
    'scripts/typed-state-ownership-patch.json': Path('/private/tmp/fwp-typed-state-ownership-patch.json').read_text(),
    '.github/workflows/typed-state-evidence.yml': Path('/private/tmp/fwp-typed-state-evidence.yml').read_text(),
})
assert len(SUBJECT) <= 80 and '\n' not in SUBJECT
parent = api('/git/commits/' + BASE)
tree = api('/git/trees', dict(base_tree=parent['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=data) for name, data in files.items()]))
entries = api('/git/trees/' + tree['sha'] + '?recursive=1')
assert not entries['truncated']
hashes = {entry['path']: entry['sha'] for entry in entries['tree']}
for name, content in files.items():
    raw = content.encode()
    assert hashes[name] == hashlib.sha1(b'blob ' + str(len(raw)).encode() + b'\0' + raw).hexdigest(), name
commit = api('/git/commits', dict(message=SUBJECT, tree=tree['sha'], parents=[BASE]))
assert commit['message'] == SUBJECT and [p['sha'] for p in commit['parents']] == [BASE]
ref = api('/git/refs', dict(ref='refs/heads/' + BRANCH, sha=commit['sha']))
assert ref['object']['sha'] == commit['sha']
RECEIPT.write_text(json.dumps(dict(head=commit['sha'], base=BASE, branch=BRANCH,
    sourceHashes={name: hashlib.sha256(data.encode()).hexdigest() for name, data in files.items()},
    stage='Independent State candidate published; compilation and runtime validation pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
