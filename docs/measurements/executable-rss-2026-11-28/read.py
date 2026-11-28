"""Reconstruct all retained lifecycle observations; never execute native images."""
import gzip
import hashlib
import json
from pathlib import Path
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT.parents[2] / 'scripts'))

from exec_memory_analysis import controls
from resource_value_review import executables

SOURCE = 'afe192e806dbbac0a1cba1dfcbcd2641e16f1c47'
RUN = 46161194256


def metadata(name):
    return json.loads(gzip.decompress((ROOT / (name + '.json.gz')).read_bytes()))


state = metadata('run')
assert (state['id'], state['head_sha'], state['status'], state['conclusion']) == (RUN, SOURCE, 'completed', 'success')
files = metadata('files')
with tempfile.TemporaryDirectory() as temporary, zipfile.ZipFile(ROOT / 'reports.zip') as archive:
    root = Path(temporary)
    assert len(archive.namelist()) == len(files) and set(archive.namelist()) == set(files)
    assert sum(row['bytes'] for row in files.values()) < 128 * 1024 * 1024
    for path, expected in files.items():
        assert (root / path).resolve().is_relative_to(root)
        data = archive.read(path)
        assert len(data) == expected['bytes'] and hashlib.sha256(data).hexdigest() == expected['sha256']
    archive.extractall(root)
    assert {path.name for path in root.iterdir()} == {'exec-memory-aarch64', 'exec-memory-x86_64'}
    for folder in sorted(root.iterdir()):
        analysis = executables(folder, SOURCE)
        assert analysis == json.loads((folder / 'reconstructed.json').read_text())
        report = json.loads((folder / 'report.json').read_text())
        rejected = controls(folder, SOURCE, report['architecture'])
        assert rejected == json.loads((folder / 'audit-controls.json').read_text())
        assert sum(len(rows) for rows in report['cases'].values()) == 256
        print(folder.name, '256 executions, all lifecycle snapshots and five altered-record controls reconstruct')
        for key, result in analysis.items():
            gaps = result['lifetimeMinusTerminalHwmKiB']
            copies = result['ordinary']['copyRatios']
            print(key, 'same-child GNU-time minus terminal HWM KiB:', min(gaps), max(gaps),
                  'ordinary copy ratios:', {role: [min(rows), max(rows)] for role, rows in copies.items()})
jobs = metadata('jobs')
completed = [job for job in jobs['jobs'] if job['conclusion'] != 'skipped']
assert len(completed) == 2 and all(job['conclusion'] == 'success' for job in completed)
for job in completed:
    assert gzip.decompress((ROOT / f'job-{job["id"]}.log.gz').read_bytes())
print('All 512 service executions reconstruct; original memory acceptance remains separate')
