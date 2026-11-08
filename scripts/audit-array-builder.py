#!/usr/bin/env python3
"""Check every source change, command, image and sample in the fresh-array diagnostic."""
import argparse
import difflib
import hashlib
import importlib.util
import json
import os
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('builder', Path(__file__).with_name('diagnose-array-builder.py'))
BUILDER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BUILDER)
AUDIT = BUILDER.AUDIT
COSTS = BUILDER.COSTS


def audit(folder, source, machine):
    directory = folder / 'builder-diagnosis'
    identity = json.loads((directory / 'identity.json').read_text())
    assert identity['source'] == source and identity['machine'] == machine
    host = json.loads((folder / 'builder-host.json').read_text())
    assert host['source'] == source and host['qualified'] and host['actual']['machine'] == machine
    original = AUDIT.audit(directory / 'original', machine, 1, identity['originalSource'])
    assert original == json.loads((directory / 'original-audit.json').read_text())
    assert identity['flags'] == original['identity']['flags']
    assert identity['ccVersion'] == original['identity']['ccVersion']
    rows = [json.loads(line) for line in (directory / 'commands.jsonl').read_text().splitlines()]
    commands = {row['output']: row for row in rows}
    assert len(commands) == len(rows)
    consumed = set()

    def command(relative):
        consumed.add(relative)
        row = commands[relative]
        assert row['status'] == 0 and type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        path = directory / relative
        assert not path.with_suffix('.stderr').read_bytes()
        return path.with_suffix('.stdout').read_bytes(), row['elapsedNs']

    summary = json.loads((directory / 'summary.json').read_text())
    reports = {}
    for case in COSTS.programs():
        name = case['name']
        path = directory / name
        reference = (directory / 'original/array-costs' / name / 'reference.c').read_text()
        candidate, changed = BUILDER.direct_stores(reference)
        assert (path / 'reference.c').read_text() == reference
        assert (path / 'candidate.c').read_text() == candidate
        assert (path / 'change.patch').read_text() == ''.join(difflib.unified_diff(
            reference.splitlines(True), candidate.splitlines(True), fromfile='reference.c', tofile='candidate.c'))
        if case['kind'] == 'loop':
            assert changed == 0
        elif case['kind'] == 'array' or case['updates'] > 0:
            assert changed > 0
        hashes = {}
        for role in COSTS.ROLES:
            image = (path / role).read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[machine]
            hashes[role] = hashlib.sha256(image).hexdigest()
        for role in COSTS.ROLES[:2]:
            assert hashes[role] == hashes[role + '-copy']
            command(name + '/' + role + '-build')
        samples = [json.loads(line) for line in (path / 'samples.jsonl').read_text().splitlines()]
        assert [(row['round'], row['role']) for row in samples] == [
            (number, role) for number in range(-2, 24) for role in COSTS.order(number)]
        for row in samples:
            raw, elapsed = command(f"{name}/round-{row['round']}-{row['role']}")
            assert row == json.loads(raw) | dict(round=row['round'], role=row['role'], processNs=elapsed)
            assert row['initialLiveBytes'] == row['finalLiveBytes']
        assert len({(row['checksum'], row['initialLiveBytes']) for row in samples}) == 1
        report = COSTS.summarize(samples) | dict(changedBuilders=changed, binaryHashes=hashes)
        assert report == summary[name]
        reports[name] = report
    assert consumed == set(commands) and set(reports) == set(summary)
    return dict(identity=identity, host=host, commands=len(commands), cases=reports)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    run = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['conclusion'] == 'success'
    artifacts = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}/artifacts'))['artifacts']
    args.output.mkdir(parents=True, exist_ok=False)
    reports = {}
    for arch, machine in (('ARM64', 'aarch64'), ('X64', 'x86_64')):
        metadata, = [item for item in artifacts if item['name'] == 'array-builder-diagnosis-' + arch]
        assert not metadata['expired'] and metadata['workflow_run']['head_sha'] == args.source
        folder = args.output / arch
        AUDIT.unpack(AUDIT.api(f"{repository}/actions/artifacts/{metadata['id']}/zip"), metadata, folder)
        reports[arch] = audit(folder, args.source, machine) | dict(artifact=metadata)
        AUDIT.save(args.output / 'summary.json', reports)
        print(arch, 'all sources, native images, commands and samples verified', flush=True)


if __name__ == '__main__':
    main()
