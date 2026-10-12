"""Publish a runner-only allocation driver with identical State native source."""
from pathlib import Path
import hashlib, json, subprocess
REPO = 'repos/e6qu/fun-with-pipes'
BASE = 'cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
BRANCH = 'ownership-evidence-packed-numeric-arrays'
SUBJECT = 'Pack numeric arrays and retain checked numeric slice views'
RECEIPT = Path('/private/tmp/fwp-packed-numeric-arrays-publication.json')
def api(endpoint, payload=None):
    argv = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-packed-numeric-arrays-api-input.json');path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))
assert not RECEIPT.exists()
assert api('/git/ref/heads/main')['object']['sha'] == BASE
probe = subprocess.run(['gh', 'api', REPO + '/git/ref/heads/' + BRANCH], capture_output=True, text=True)
assert probe.returncode != 0 and '404' in probe.stderr
files = {
 'src/cgen.rs':Path('/private/tmp/fwp-packed-array-runtime-draft/cgen.rs').read_text(),
 'scripts/measure-packed-numeric-arrays.py':Path('/private/tmp/fwp-measure-packed-numeric-arrays.py').read_text(),
 'tests/fixtures/numeric_layout_baseline.fwp':Path('/private/tmp/fwp-typed-worker-abi-fixture.fwp').read_text(),
 'tests/fixtures/packed_numeric_arrays.fwp':Path('/private/tmp/fwp-packed-numeric-arrays-fixture.fwp').read_text(),
 'tests/run/unboxed_records.fwp':Path('/private/tmp/fwp-unboxed-records-fixture-draft.fwp').read_text(),
 '.github/workflows/packed-numeric-arrays.yml':Path('/private/tmp/fwp-packed-numeric-arrays.yml').read_text(),
}
for name in ['fwp_rt.c','fwp_rt_gc.c','fwp_rt_ops.c','fwp_rt_prims.c','fwp_rt_num.c','fwp_rt_json.c','fwp_rt_exec.c','fwp_rt_kernel.c']:
 files['runtime/'+name]=(Path('/private/tmp/fwp-packed-array-runtime-draft')/name).read_text()
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
    stage='Packed numeric arrays and typed ABI preparation published; all runner controls pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
