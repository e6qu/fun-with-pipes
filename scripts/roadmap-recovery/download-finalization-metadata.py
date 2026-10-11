"""Extract only bounded publication metadata; leave binaries on GitHub."""
from pathlib import Path
import io, json, subprocess, zipfile

REPO = 'repos/e6qu/fun-with-pipes'
ARTIFACT = 11711546988
OUT = Path('/private/tmp/fwp-resource-network-finalized-export')
info = json.loads(subprocess.check_output(['gh', 'api', f'{REPO}/actions/artifacts/{ARTIFACT}']))
assert info['name'] == 'resource-network-finalization' and not info['expired']
assert info['size_in_bytes'] < 64 * 1024 * 1024
# The archive includes native measurement binaries. Keep it in bounded memory,
# and write only the manifest, linear history and source audit needed to publish.
data = subprocess.check_output(['gh', 'api', f'{REPO}/actions/artifacts/{ARTIFACT}/zip'])
assert len(data) < 64 * 1024 * 1024
with zipfile.ZipFile(io.BytesIO(data)) as archive:
    wanted = ['finalization.json', 'prepared-commits.json.gz', 'primitive-inventory.json']
    matches = {}
    for name in wanted:
        # Nested preparation artifacts contain the older export too. Only the
        # finalizer's top-level files describe the integrated candidate.
        found = [entry for entry in archive.infolist() if entry.filename == name]
        assert len(found) == 1, (name, len(found))
        matches[name] = found[0]
    assert sum(entry.file_size for entry in matches.values()) < 10 * 1024 * 1024
    OUT.mkdir(exist_ok=True)
    for name, entry in matches.items():
        assert entry.file_size < 5 * 1024 * 1024
        target = OUT / name
        assert not target.exists(), target
        target.write_bytes(archive.read(entry))
        print(name, entry.file_size, flush=True)
print('Native binaries remain in the runner artifact; publication metadata extracted')
