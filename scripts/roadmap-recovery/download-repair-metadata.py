"""Download bounded repair publication metadata after successful preflight."""
from pathlib import Path
import argparse, io, json, subprocess, zipfile

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--run', type=int, required=True)
p.add_argument('--driver', required=True)
a = p.parse_args()
repo = 'repos/e6qu/fun-with-pipes'
def api(endpoint):
    return json.loads(subprocess.check_output(['gh', 'api', repo + endpoint]))
run = api('/actions/runs/' + str(a.run))
assert run['head_sha'] == a.driver and run['status'] == 'completed' and run['conclusion'] == 'success'
artifacts = api('/actions/runs/' + str(a.run) + '/artifacts')['artifacts']
found = [item for item in artifacts if item['name'] == 'pr124-combined-repair']
assert len(found) == 1
artifact = found[0]
assert not artifact['expired'] and artifact['size_in_bytes'] < 64 * 1024 * 1024
data = subprocess.check_output(['gh', 'api', repo + '/actions/artifacts/' + str(artifact['id']) + '/zip'])
assert len(data) < 64 * 1024 * 1024
out = Path('/private/tmp/fwp-pr124-combined-repair-export')
out.mkdir(exist_ok=True)
with zipfile.ZipFile(io.BytesIO(data)) as archive:
    for name in ['repair.json', 'prepared-commits.json.gz', 'primitive-inventory.json']:
        entries = [entry for entry in archive.infolist() if entry.filename == name]
        assert len(entries) == 1 and entries[0].file_size < 5 * 1024 * 1024
        target = out / name
        assert not target.exists(), 'Do not replace a retained publication export'
        target.write_bytes(archive.read(entries[0]))
        print(name, entries[0].file_size, flush=True)
(out / 'download.json').write_text(json.dumps(dict(run=a.run, driver=a.driver,
    artifact=artifact['id'], compressedBytes=len(data)), indent=2) + '\n')
