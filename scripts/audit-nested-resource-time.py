#!/usr/bin/env python3
"""Reconstruct ordinary service timing, copy qualification and RSS from raw observations."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import subprocess
import sys

from nested_resource_timing import LABELS, order, summarize
from weak_callback_source import boundary
from weak_callback_timing import CASES, COPY_LIMIT, MINIMUM_NS, PILOT_NS, ROUNDS, decode_output

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'peers'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    folder, peers = args.input.resolve(), args.peers.resolve()
    subprocess.run([sys.executable, ROOT / 'scripts/measure-weak-callback-service.py', 'audit',
                    '--input', peers, '--source', args.source, '--arch', args.arch], check=True)
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert set(manifest) == {str(path.relative_to(folder)) for path in folder.rglob('*')
                             if path.is_file() and path.name != 'manifest.json'}
    for name, digest in manifest.items():
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert hashlib.sha256((folder / name).read_bytes()).hexdigest() == digest, name
    report = json.loads((folder / 'report.json').read_text())
    peer_report = json.loads((peers / 'report.json').read_text())
    assert report['peerManifestSha256'] == hashlib.sha256((peers / 'manifest.json').read_bytes()).hexdigest()
    assert (report['source'], report['architecture']) == (args.source, args.arch)
    assert report['referenceSource'] == '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    assert not report['failures'] and report['ccVersion'] == peer_report['versions']['cc']
    assert report['protocol'] == dict(labels=list(LABELS), rounds=ROUNDS, pilotNs=PILOT_NS,
                                      minimumNs=MINIMUM_NS, copyLimit=COPY_LIMIT)
    assert (folder / 'clock.o').read_bytes() == (peers / 'clock.o').read_bytes()
    reference_source = (folder / 'reference.c').read_text()
    assert 'protected by enclosing frame' not in reference_source
    assert 'protected by enclosing frame' in (peers / 'original.c').read_text()
    assert (folder / 'fwp-reference-2-plain/factory.c').read_text() == boundary(reference_source)
    assert (folder / 'fwp-reference-2-plain/caller.c').read_bytes() == (peers / 'fixtures/weak_callback_service_time.c').read_bytes()
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    for index, row in enumerate(commands):
        assert row['index'] == index and row['status'] == 0 and row['stderr'] == ''
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
    root = Path(report['root'])
    assert set(report['binaries']) == {'reference', 'candidate'}
    for role, binary in report['binaries'].items():
        for key in ('path', 'copyPath'):
            image = (folder / binary[key]).read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
            assert hashlib.sha256(image).hexdigest() == binary['sha256'] and len(image) == binary['bytes']
        if role == 'candidate':
            assert binary['sha256'] == peer_report['binaries']['fwp']['binarySha256']
    seen = []

    def observation(index, label, population, mode, batches, prefix):
        row = commands[index]
        binary = report['binaries'][label.removesuffix('-copy')]
        path = binary['copyPath' if label.endswith('-copy') else 'path']
        assert row['command'] == [*prefix, str(root / path), str(population), str(mode), str(batches)]
        seen.append(index)
        return decode_output(row['stdout'], population, mode, batches)

    assert set(report['sessions']) == {'1', '2'}
    for session in ('1', '2'):
        assert set(report['sessions'][session]) == {f'{population}-{mode}' for population, mode in CASES}
        for population, mode in CASES:
            key = f'{population}-{mode}'
            case = report['sessions'][session][key]
            batches = case['batches']
            assert batches == peer_report['pilots'][key]['batches']
            assert [row['label'] for row in case['warmups']] == order(0) + order(1)
            for row in case['warmups']:
                observation(row['command'], row['label'], population, mode, batches, [])
            for row in case['samples']:
                phases = observation(row['command'], row['label'], population, mode, batches, [])
                assert row['ns'] == dict(service=phases['serviceNs'], process=commands[row['command']]['elapsedNs'])
            assert case['summary'] == summarize(case['samples'], population)
            assert set(case['memory']) == {'reference', 'candidate'}
            for role, rows in case['memory'].items():
                assert len(rows) == 3
                for row in rows:
                    observation(row['command'], role, population, mode, batches,
                                [report['settings']['time'], '-f', '%M', '-o', str(root / row['file'])])
                    assert row['peakRssKiB'] == int((folder / row['file']).read_text()) > 0
            peaks = {role: max(row['peakRssKiB'] for row in rows) for role, rows in case['memory'].items()}
            assert case['peakRssRatio'] == peaks['candidate'] / peaks['reference']
            assert case['rssTargetMet'] == (case['peakRssRatio'] <= 1.05)
    assert seen == sorted(set(seen)), 'reused or reordered observations'
    assert len(report['compile']) == 4
    for row in report['compile']:
        seconds, rss = (folder / row['file']).read_text().split()
        assert row['seconds'] == float(seconds) and math.isfinite(row['seconds']) and row['seconds'] >= 0
        assert row['peakRssKiB'] == int(rss) > 0
        assert commands[row['command']]['command'][:5] == [report['settings']['time'], '-f', '%e %M', '-o', str(root / row['file'])]
    print('Both timing sessions, unchanged copies, raw service results, RSS and compiler observations reconstruct')


if __name__ == '__main__':
    main()
