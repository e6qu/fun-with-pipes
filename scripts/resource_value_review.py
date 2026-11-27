"""Reconstruct compiler costs and HTTP load records without rerunning measurements."""
import hashlib
import json
from pathlib import Path

from compiler_build_comparison import comparison
from compiler_scaling import resources
from http_load import audit


def compiler(root, source):
    result = []
    for session in (1, 2):
        folder = root / f'nested-compiler-session-{session}'
        report = json.loads((folder / 'summary.json').read_text())
        identity = report['identity']
        assert identity['source'] == source and identity['session'] == session
        assert identity['referenceSource'] == '5a9047178b88c801f37a279dfeca55b0e190bf07'
        assert identity['contract'] == 'nested-resources'
        assert not report['failures'] and len(report['cases']) == 16
        commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
        assert len(commands) == 16 * 36
        observed = []
        for name, case in report['cases'].items():
            assert case['correct']
            assert hashlib.sha256((folder / name / 'input.fwp').read_bytes()).hexdigest() == case['sourceSha256']
            hashes = {}
            for sample in case['samples']:
                prefix = folder / name / f'round-{sample["round"]}-{sample["role"]}'
                raw = commands[len(observed)]
                assert {key: sample[key] for key in raw} == raw
                assert raw['status'] == 0 and not raw['timedOut']
                measured = resources(prefix.with_suffix('.resources').read_text())
                assert all(sample[key] == value for key, value in measured.items())
                assert not prefix.with_suffix('.stdout').read_bytes()
                assert not prefix.with_suffix('.stderr').read_bytes()
                role = sample['role'].removesuffix('-copy')
                hashes.setdefault(role, (sample['cSha256'], sample['cBytes']))
                assert hashes[role] == (sample['cSha256'], sample['cBytes'])
                observed.append(raw)
            actual = comparison(case['samples'], name, 'nested-resources')
            assert all(case[key] == value for key, value in actual.items())
            result.append(dict(session=session, case=name, **actual))
        assert observed == commands
    return result


def http(root, source):
    folder = root / 'http-load'
    report = json.loads((folder / 'summary.json').read_text())
    assert report['identity']['source'] == source and not report['failures']
    assert report['trials']
    for trial in report['trials']:
        path = folder / trial['name']
        header = json.loads((path / 'generator.stdout').read_text())
        assert header == trial['header']
        actual = audit(path / 'attempts', header, True)
        assert all(trial[key] == value for key, value in actual.items())
        assert trial['generatorStatus'] == 0 and trial['allFailures'] == 0
        assert not (path / 'generator.stderr').read_bytes()
    return report
