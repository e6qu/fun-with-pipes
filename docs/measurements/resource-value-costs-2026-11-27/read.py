"""Verify retained text records; native images and HTTP attempts were audited on CI."""
import gzip
import hashlib
import json
from pathlib import Path
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT.parents[2] / 'scripts'))

from resource_value_review import compiler, counts, runtime


def metadata(folder, name):
    return json.loads(gzip.decompress((folder / (name + '.json.gz')).read_bytes()))


for name in ('compiler', 'http-checks', 'http-load', 'counts'):
    folder = ROOT / name
    state = metadata(folder, 'run')
    files = metadata(folder, 'files')
    jobs = metadata(folder, 'jobs')
    source = state['head_sha']
    assert state['status'] == 'completed'
    assert source == ('33149ad2fd888a66ff36b8eb7f2c5b61faccfccb' if name == 'counts'
                      else 'cee08dcbd422831d5fa6a1f56963aaedfd09d1fd')
    with tempfile.TemporaryDirectory() as temporary, zipfile.ZipFile(folder / 'reports.zip') as archive:
        root = Path(temporary)
        assert set(archive.namelist()) == set(files)
        assert len(archive.namelist()) == len(files)
        assert sum(row['bytes'] for row in files.values()) < 128 * 1024 * 1024
        for path, expected in files.items():
            assert (root / path).resolve().is_relative_to(root)
            data = archive.read(path)
            assert len(data) == expected['bytes']
            assert hashlib.sha256(data).hexdigest() == expected['sha256']
        archive.extractall(root)
        for artifact in sorted(root.iterdir()):
            reconstructed = json.loads((artifact / 'reconstructed.json').read_text())
            if name == 'compiler':
                actual = compiler(artifact, source)
                assert actual == reconstructed
                unmet = [row for row in actual if not row['acceptance']]
                print(artifact.name, 'compiler comparisons', len(actual), 'unmet', len(unmet))
                for row in unmet:
                    print(row['case'], row['session'], row['candidateRatio'], row['timingQualified'], row['peakRssRatio'])
                # A refreshed summary cannot override an unchanged raw observation.
                path = artifact / 'nested-compiler-session-1/summary.json'
                original = path.read_bytes()
                altered = json.loads(original)
                next(iter(altered['cases'].values()))['samples'][0]['elapsedNs'] += 1
                path.write_text(json.dumps(altered))
                try:
                    compiler(artifact, source)
                except AssertionError as error:
                    assert str(error) == 'compiler sample differs from raw command'
                else:
                    raise AssertionError('altered compiler timing was accepted')
                path.write_bytes(original)
            elif name == 'counts':
                assert counts(artifact, source) == reconstructed
                print(artifact.name, 'count comparisons', len(reconstructed))
            else:
                original = json.loads((artifact / 'http-load/summary.json').read_text())
                assert original == reconstructed and not original['failures']
                assert original['identity']['source'] == source
                assert all(row['generatorStatus'] == 0 and row['allFailures'] == 0 for row in original['trials'])
                print(artifact.name, 'HTTP trials', len(original['trials']))
    for job in jobs['jobs']:
        if job['conclusion'] != 'skipped':
            assert gzip.decompress((folder / f'job-{job["id"]}.log.gz').read_bytes())
print('All retained archive members, original compiler observations and HTTP summary exports agree')
