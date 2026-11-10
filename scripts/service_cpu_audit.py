#!/usr/bin/env python3
"""Reconstruct service profiles from retained outputs, stacks and source names."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from cpu_samples import histogram, recording_messages, stacks
from service_cpu_collect import MINIMUM_NS
from service_cpu_samples import attribute, fwp_functions
from weak_callback_timing import BATCHES, CASES, PEERS, decode_output


def audit(folder, source, arch):
    manifest = json.loads((folder/'sha256.json').read_text())
    files = {str(p.relative_to(folder)) for p in folder.rglob('*') if p.is_file() and p.name != 'sha256.json'}
    assert files == set(manifest), 'missing or extra evidence files'
    for name, digest in manifest.items():
        assert hashlib.sha256((folder/name).read_bytes()).hexdigest() == digest, name
    report = json.loads((folder/'summary.json').read_text())
    assert report['source'] == source and report['settings']['arch'] == arch
    assert report['settings']['action'] == 'collect'
    assert not report['failures'] and 'failure' not in report
    assert set(report['binaries']) == set(PEERS)
    assert set(report['cases']) == {f'{peer}-{n}-{mode}' for peer in PEERS for n, mode in CASES}
    commands = report['commands']
    assert all(c['status'] == 0 and 'timeoutSeconds' not in c for c in commands)
    names = fwp_functions((folder/'original.c').read_text())
    assert names == json.loads((folder/'function-names.json').read_text())
    for peer in PEERS:
        metadata = report['binaries'][peer]
        binary = folder/metadata['path']
        assert hashlib.sha256(binary.read_bytes()).hexdigest() == metadata['sha256']
        with binary.open('rb') as stream:
            header = stream.read(20)
        assert header[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', header, 18)[0] == metadata['elfMachine'] == {'aarch64': 183, 'x86_64': 62}[arch]
        for population, mode in CASES:
            key = f'{peer}-{population}-{mode}'
            row = report['cases'][key]
            assert row['correct'] and 'failure' not in row

            def output(index, batches, sampled):
                command = commands[index]
                assert command['index'] == index
                assert command['command'][-3:] == list(map(str, (population, mode, batches)))
                assert Path(command['command'][-4]).parts[-2:] == Path(metadata['path']).parts[-2:]
                if sampled:
                    recording_messages(command['stderr'])
                else:
                    assert not command['stderr']
                return decode_output(command['stdout'], population, mode, batches)

            output(row['correctnessCommand'], 1, False)
            if population == 64:
                assert row['pilots'] == [] and 'profile' not in row
                continue
            assert 1 <= len(row['pilots']) <= len(BATCHES)
            for i, pilot in enumerate(row['pilots']):
                assert pilot['batches'] == BATCHES[i]
                values = output(pilot['command'], BATCHES[i], False)
                if i == len(row['pilots'])-1:
                    assert values['serviceNs'] >= MINIMUM_NS and row['batches'] == BATCHES[i]
                else:
                    assert values['serviceNs'] < MINIMUM_NS, 'continued after qualifying pilot'
            output(row['ordinaryCommand'], row['batches'], False)
            sampled = row['profile']
            output(sampled['command'], row['batches'], True)
            assert sampled['stdout'] == commands[sampled['command']]['stdout']
            recording = str(Path(commands[sampled['command']]['command'][
                commands[sampled['command']]['command'].index('--output')+1]))
            flat = [c for c in commands if c['command'][1:2] == ['report'] and recording in c['command']]
            assert len(flat) == 1
            assert histogram(flat[0]['stdout'], False) == sampled['flat']
            directory = folder/key
            raw = stacks((directory/'user-stacks.txt').read_text())
            decoded = stacks((directory/'user-stacks.demangled.txt').read_text())
            assert len(raw) == len(decoded)
            for before, after in zip(raw, decoded):
                assert before['period'] == after['period'] and len(before['frames']) == len(after['frames'])
                assert all(a['ip'] == b['ip'] and a['dso'] == b['dso'] for a, b in zip(before['frames'], after['frames']))
            reconstructed = attribute(decoded, sampled['flat'], peer=peer, functions=names if peer == 'fwp' else None)
            assert reconstructed == sampled['attribution']
            assert reconstructed == json.loads((directory/'attribution.json').read_text())
    return dict(cases=len(report['cases']), profiles=sum('profile' in r for r in report['cases'].values()), files=len(files))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    print(json.dumps(audit(args.input, args.source, args.arch), indent=2))


if __name__ == '__main__':
    main()
