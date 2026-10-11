"""Publish exact runner-formatted sources and keep the replay recipe identical."""
from pathlib import Path
import base64
import hashlib
import json
import subprocess

REPO = 'repos/e6qu/fun-with-pipes'
OLD = 'a44c3da1aa344266262fc99471b331b053db371b'
BASE = 'b0ae00d5512df825271970cafcf569f52dbfc0cd'
BRANCH = 'ownership-evidence-gc-build-diagnostics'
RUN = 38136959809
SUBJECT = 'Format compiler diagnostics and cache lifetime regression checks'
ARTIFACT = Path('/private/tmp/fwp-gc-build-diagnostics-a44-artifacts')


def api(endpoint, payload=None, method='POST'):
    args = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-formatted-diagnostics-api-input.json')
        path.write_text(json.dumps(payload))
        args += ['--method', method, '--input', str(path)]
    return json.loads(subprocess.check_output(args, text=True))


def source(head, name):
    data = api('/contents/' + name + '?ref=' + head)
    assert data['encoding'] == 'base64'
    return base64.b64decode(data['content']).decode()


assert len(SUBJECT) <= 80 and '\n' not in SUBJECT
run = api('/actions/runs/' + str(RUN))
assert run['head_sha'] == OLD and run['status'] == 'completed'
assert run['conclusion'] == 'failure'
assert ARTIFACT.joinpath('head.txt').read_text().strip() == OLD
assert api('/git/ref/heads/' + BRANCH)['object']['sha'] == OLD
files = {name: ARTIFACT.joinpath('formatted', name).read_text() for name in [
    'src/cgen.rs', 'src/ffi_interp.rs', 'src/aot.rs',
    'tests/gc.rs', 'tests/compiler_diagnostics.rs', 'tests/cache_lifetime.rs',
]}
recipe_path = Path('/private/tmp/fwp-compiler-diagnostics-patch.json')
recipe = json.loads(recipe_path.read_text())
old_format = 'return Err(format!("{}{}", compiler_failure("C compiler failed", &res), hint));'
new_format = '''return Err(format!(
            "{}{}",
            compiler_failure("C compiler failed", &res),
            hint
        ));'''
assert sum(edit['new'] == old_format for edit in recipe['src/cgen.rs']) == 1
for edit in recipe['src/cgen.rs']:
    if edit['new'] == old_format:
        edit['new'] = new_format
for name, edits in recipe.items():
    original = source(BASE, name)
    for edit in edits:
        assert original.count(edit['old']) == 1, (name, edit['old'])
        original = original.replace(edit['old'], edit['new'])
    assert original == files[name], ('Recipe must reproduce runner output', name)
files['scripts/compiler-diagnostics-patch.json'] = json.dumps(recipe, indent=2) + '\n'
parent = api('/git/commits/' + OLD)
tree = api('/git/trees', dict(base_tree=parent['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=value)
    for name, value in files.items()]))
commit = api('/git/commits', dict(message=SUBJECT, tree=tree['sha'], parents=[OLD]))
assert commit['message'] == SUBJECT and commit['parents'][0]['sha'] == OLD
ref = api('/git/refs/heads/' + BRANCH, dict(sha=commit['sha'], force=False), method='PATCH')
assert ref['object']['sha'] == commit['sha']
for name, value in files.items():
    assert source(commit['sha'], name) == value
recipe_path.write_text(files['scripts/compiler-diagnostics-patch.json'])
for name, local in {
    'tests/gc.rs': 'fwp-gc-strict-build-draft.rs',
    'tests/compiler_diagnostics.rs': 'fwp-compiler-diagnostics-test.rs',
    'tests/cache_lifetime.rs': 'fwp-cache-lifetime-test.rs',
}.items():
    Path('/private/tmp', local).write_text(files[name])
Path('/private/tmp/fwp-formatted-compiler-diagnostics-publication.json').write_text(
    json.dumps(dict(head=commit['sha'], previous=OLD, branch=BRANCH, failedRun=RUN,
                    sourceHashes={name: hashlib.sha256(value.encode()).hexdigest()
                                  for name, value in files.items()},
                    stage='Runner formatting repaired; focused lint/tests/controls pending'),
               indent=2) + '\n')
print(commit['sha'], flush=True)
