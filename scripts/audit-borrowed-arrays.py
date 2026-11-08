#!/usr/bin/env python3
"""Retain and independently check the complete borrowed-array timing run."""
import argparse
import gzip
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import zipfile

SPEC = importlib.util.spec_from_file_location('costs', Path(__file__).with_name('measure-borrowed-arrays.py'))
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)
OBSERVATION_SPEC = importlib.util.spec_from_file_location('observations', Path(__file__).with_name('observe-array-costs.py'))
OBSERVATIONS = importlib.util.module_from_spec(OBSERVATION_SPEC)
OBSERVATION_SPEC.loader.exec_module(OBSERVATIONS)


def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences', path])


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def unpack(data, metadata, destination):
    assert metadata['digest'] == 'sha256:' + hashlib.sha256(data).hexdigest()
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        names = archive.namelist()
        assert len(set(names)) == len(names)
        for name in names:
            path = Path(name)
            assert not path.is_absolute() and '..' not in path.parts
        archive.extractall(destination)


def audit_observations(folder, identity):
    directory = folder / 'array-observations'
    summary = json.loads((directory / 'summary.json').read_text())
    assert summary['source'] == identity['source'] and summary['identity'] == identity
    rows = [json.loads(line) for line in (directory / 'commands.jsonl').read_text().splitlines()]
    commands = {row['output']: row for row in rows}
    assert len(commands) == len(rows)
    consumed = set()

    def command(relative, observed):
        row = commands[relative]
        consumed.add(relative)
        assert row['status'] == 0 and row['timedOut'] is False
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        path = directory / relative
        assert not path.with_suffix('.stderr').read_bytes()
        cost = dict(elapsedNs=row['elapsedNs'])
        arguments = row['command']
        if observed:
            assert arguments[:3] == ['/usr/bin/time', '-v', '-o']
            assert arguments[3].endswith('/array-observations/' + relative + '.resources')
            arguments = arguments[4:]
            cost.update(OBSERVATIONS.resources(path.with_suffix('.resources').read_text()))
            assert all(value >= 0 for value in cost.values())
        return path.with_suffix('.stdout').read_bytes(), cost, arguments

    reports = {}
    for case in COSTS.programs():
        name = case['name']
        saved = folder / 'array-costs' / name
        path = directory / name
        report = {}
        for role in COSTS.ROLES[:2]:
            prefix = name + '/' + role
            raw, rss, arguments = command(prefix + '-rss', True)
            assert len(arguments) == 1 and arguments[0].endswith('/array-costs/' + prefix)
            timing = json.loads(raw)
            assert timing['initialLiveBytes'] == timing['finalLiveBytes']
            original = json.loads((saved / 'round-0-candidate.stdout').read_text())
            assert timing['checksum'] == original['checksum']
            assert timing['initialLiveBytes'] == original['initialLiveBytes']
            _, emitter, arguments = command(prefix + '-emit', True)
            assert arguments[1:6] == ['build', '--fn', 'measure', '--emit-c', '-O2']
            assert arguments[6].endswith('/array-costs/' + name + '/program.fwp')
            assert arguments[7] == '-o' and len(arguments) == 9
            assert arguments[8].endswith('/array-observations/' + prefix + '-generated.c')
            assert (path / (role + '-generated.c')).read_bytes() == (saved / (role + '-generated.c')).read_bytes()
            for phase, suffix, source_path, observed in (
                ('c-build', '-ordinary', '/array-costs/' + prefix + '.c', True),
                ('memory-build', '-memory', '/array-observations/' + prefix + '-memory.c', False),
            ):
                raw, cost, arguments = command(prefix + '-' + phase, observed)
                assert not raw
                flags = identity['flags']
                assert arguments[1:1+len(flags)] == flags
                tail = arguments[1+len(flags):]
                assert len(tail) == 6 and tail[0].endswith(source_path)
                assert tail[1] == '-o' and tail[2].endswith('/array-observations/' + prefix + suffix)
                assert tail[3:] == ['-lm', '-lpthread', '-ldl']
                if observed:
                    c_compiler = cost
                image = (path / (role + suffix)).read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[identity['machine']]
            assert (path / (role + '-memory.c')).read_text() == OBSERVATIONS.memory_source((saved / (role + '.c')).read_text())
            rebuilt, _, arguments = command(prefix + '-rebuilt-check', False)
            assert len(arguments) == 1 and arguments[0].endswith('/array-observations/' + prefix + '-ordinary')
            rebuilt = json.loads(rebuilt)
            assert rebuilt['initialLiveBytes'] == rebuilt['finalLiveBytes'] == timing['initialLiveBytes']
            assert rebuilt['checksum'] == timing['checksum']
            raw, _, arguments = command(prefix + '-memory-run', False)
            assert len(arguments) == 1 and arguments[0].endswith('/array-observations/' + prefix + '-memory')
            measured, counts = [json.loads(line) for line in raw.splitlines()]
            assert measured['checksum'] == timing['checksum']
            assert measured['initialLiveBytes'] == measured['finalLiveBytes'] == timing['initialLiveBytes']
            assert counts['initialLiveBytes'] == counts['finalLiveBytes'] == timing['initialLiveBytes']
            assert counts['peakLiveBytes'] >= counts['initialLiveBytes']
            assert all(type(value) is int and value >= 0 for value in counts.values())
            ordinary = saved / role
            report[role] = dict(memory=counts, ordinaryProcess=rss, compiler=emitter,
                                cCompiler=c_compiler, imageBytes=ordinary.stat().st_size,
                                imageSha256=hashlib.sha256(ordinary.read_bytes()).hexdigest())
        assert report['candidate']['memory'] == report['reference']['memory']
        if case['kind'] == 'loop':
            assert report['candidate']['memory']['requests'] == report['candidate']['memory']['retains'] == 0
        assert report == summary['cases'][name]
        reports[name] = report
    assert consumed == set(commands) and set(reports) == set(summary['cases'])
    return dict(cases=reports, commands=len(commands))


def audit(folder, machine, session, source):
    directory = folder / 'array-costs'
    identity = json.loads((directory / 'identity.json').read_text())
    assert identity['source'] == source and identity['session'] == session
    assert identity['machine'] == machine
    host = json.loads((folder / 'array-safety/host.json').read_text())
    assert host['qualified'] and host['source'] == source
    assert host['actual']['machine'] == machine
    assert (folder / 'array-reference/reference.patch').read_bytes() == (folder / 'array-reference/built.patch').read_bytes()
    manifest = json.loads((folder / 'array-reference/manifest.json').read_text())
    assert manifest == identity['reference'] and manifest['source'] == source
    reference = (folder / 'array-reference/cgen-reference.rs').read_bytes()
    patch = (folder / 'array-reference/reference.patch').read_bytes()
    assert hashlib.sha256(reference).hexdigest() == manifest['referenceSha256']
    assert hashlib.sha256(patch).hexdigest() == manifest['patchSha256']
    original = subprocess.check_output(['git', 'show', source + ':src/cgen.rs'], cwd=COSTS.ROOT)
    assert hashlib.sha256(original).hexdigest() == manifest['candidateSha256']
    transform = {'borrowed array metadata selection': COSTS.reference_source,
                 'array-metadata': COSTS.reference_source,
                 'fresh-array': COSTS.fresh_reference_source}[manifest['disabled']]
    assert transform(original.decode()).encode() == reference
    summary = json.loads((directory / 'summary.json').read_text())
    cases = list(COSTS.programs())
    assert set(summary) == {case['name'] for case in cases}
    commands = [json.loads(line) for line in (directory / 'commands.jsonl').read_text().splitlines()]
    assert len({row['output'] for row in commands}) == len(commands)
    commands = {row['output']: row for row in commands}
    consumed = set()

    def command(relative):
        row = commands[relative]
        consumed.add(relative)
        assert row['status'] == 0 and row['timedOut'] is False
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        path = directory / relative
        assert not path.with_suffix('.stderr').read_bytes()
        return path.with_suffix('.stdout').read_bytes(), row

    reports = {}
    for case in cases:
        name = case['name']
        path = directory / name
        saved = json.loads((path / 'case.json').read_text())
        for key, value in case.items():
            if key != 'expected':
                assert saved[key] == value, (name, key)
        assert (path / 'program.fwp').read_text() == case['source']
        if case['expected'] is None or case['count'] <= 16:
            raw, _ = command(name + '/interpreter-check')
            values = json.loads(raw)
            values = values if isinstance(values, list) else [values]
            assert COSTS.words(values, case['kind'] == 'loop') == COSTS.words(saved['expected'], case['kind'] == 'loop')
        if case['expected'] is not None:
            assert COSTS.words(saved['expected'], case['kind'] == 'loop') == COSTS.words(case['expected'], case['kind'] == 'loop')
        hashes = {}
        for role in COSTS.ROLES:
            image = (path / role).read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[machine]
            hashes[role] = hashlib.sha256(image).hexdigest()
        for role in COSTS.ROLES[:2]:
            assert hashes[role] == hashes[role + '-copy']
            for phase in ('emit', 'build', 'check'):
                command(name + '/' + role + '-' + phase)
            generated = (path / (role + '-generated.c')).read_text()
            assert (path / (role + '.c')).read_text() == COSTS.driver(generated, case, saved['expected'])
        rows = [json.loads(line) for line in (path / 'samples.jsonl').read_text().splitlines()]
        assert [(row['round'], row['role']) for row in rows] == [
            (number, role) for number in range(-2, 24) for role in COSTS.order(number)]
        for row in rows:
            raw, execution = command(f"{name}/round-{row['round']}-{row['role']}")
            assert row == json.loads(raw) | dict(round=row['round'], role=row['role'], processNs=execution['elapsedNs'])
            assert row['initialLiveBytes'] == row['finalLiveBytes']
        assert len({(row['checksum'], row['initialLiveBytes']) for row in rows}) == 1
        calculated = COSTS.summarize(rows) | dict(binaryHashes=hashes)
        assert summary[name] == calculated, name
        reports[name] = calculated
    assert consumed == set(commands), set(commands) - consumed
    report = dict(identity=identity, cases=reports, commands=len(commands), qualification=host)
    if manifest['disabled'] == 'fresh-array' and session == 1:
        report['observations'] = audit_observations(folder, identity)
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    run = json.loads(api(f'{repository}/actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['status'] == 'completed'
    assert run['conclusion'] == 'success'
    jobs = json.loads(subprocess.check_output(['gh', 'api', '--paginate', '--slurp',
        f'{repository}/actions/runs/{args.run}/jobs?per_page=100']))
    jobs = [job for page in jobs for job in page['jobs']]
    artifacts = json.loads(api(f'{repository}/actions/runs/{args.run}/artifacts'))['artifacts']
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    retained = output / 'retained'
    retained.mkdir()
    save(retained / 'run.json', run)
    save(retained / 'jobs.json', jobs)
    save(retained / 'artifacts.json', artifacts)
    results = {}
    for machine, runner, arch in (('aarch64', 'ubuntu-24.04-arm', 'ARM64'), ('x86_64', 'ubuntu-latest', 'X64')):
        for session in (1, 2):
            label = f'{machine}-{session}'
            job, = [job for job in jobs if job['name'] == f'array_metadata / measure ({runner}, {session})']
            assert job['conclusion'] == 'success' and job['head_sha'] == args.source
            metadata, = [item for item in artifacts if item['name'] == f'borrowed-array-costs-{arch}-{session}']
            assert not metadata['expired'] and metadata['workflow_run']['head_sha'] == args.source
            folder = output / label
            unpack(api(f"{repository}/actions/artifacts/{metadata['id']}/zip"), metadata, folder)
            report = audit(folder, machine, session, args.source)
            log = api(f"{repository}/actions/jobs/{job['id']}/logs")
            (retained / (label + '.log.gz')).write_bytes(gzip.compress(log, mtime=0))
            report['job'] = job['id']
            report['artifact'] = metadata
            report['logSha256'] = hashlib.sha256(log).hexdigest()
            save(retained / (label + '.json'), report)
            # Retain all observations and commands, without duplicating large C/images.
            with zipfile.ZipFile(retained / (label + '-observations.zip'), 'w', zipfile.ZIP_DEFLATED) as archive:
                for path in sorted(folder.rglob('*')):
                    if path.is_file() and path.suffix in ('.json', '.jsonl', '.stdout', '.stderr', '.su', '.patch', '.resources'):
                        archive.write(path, path.relative_to(folder))
            results[label] = report
    save(retained / 'summary.json', results)
    print('Verified all four sessions, 18 cases each; timing acceptance is separate.')


if __name__ == '__main__':
    main()
