#!/usr/bin/env python3
"""Reconstruct service profiles from retained outputs, stacks and source names."""
import argparse
import gzip
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


def audit_replay(folder, source, decoder, arch, names):
    """Rebuild saved replay results; no profiler or workload is executed."""
    manifest = json.loads((folder/'sha256.json').read_text())
    files = {str(p.relative_to(folder)) for p in folder.rglob('*')
             if p.is_file() and p.name != 'sha256.json'}
    assert files == set(manifest), 'missing or extra replay files'
    for name, digest in manifest.items():
        assert hashlib.sha256((folder/name).read_bytes()).hexdigest() == digest, name
    report = json.loads((folder/'summary.json').read_text())
    original = json.loads(gzip.decompress((folder/'original-summary.json.gz').read_bytes()))
    assert report['recordingSource'] == original['source'] == source
    assert report['decoderSource'] == decoder and original['settings']['arch'] == arch
    assert report['originalFailures'] == original['failures']
    assert not report['failures']
    assert set(report['profiles']) == {f'{peer}-4096-{mode}' for peer in PEERS for mode in range(4)}
    commands = original['commands']
    outputs = {}
    for command in commands:
        assert command['status'] == 0 and 'timeoutSeconds' not in command
        args = command['command']
        if len(args) >= 4 and Path(args[-4]).name == 'program':
            peer = Path(args[-4]).parent.name.split('-')[0]
            assert peer in PEERS
            values = decode_output(command['stdout'], *map(int, args[-3:]))
            key = f'{peer}-{values["population"]}-{values["mode"]}'
            outputs[key] = outputs.get(key, 0)+1
    assert outputs == report['verifiedOutputCounts']
    assert set(outputs) == set(original['cases']) == {f'{peer}-{n}-{m}' for peer in PEERS for n, m in CASES}
    # Source mapping is immutable input to attribution, never reconstructed by guessing IDs.
    assert names.count('service') == 1
    for peer in PEERS:
        for population, mode in CASES:
            key = f'{peer}-{population}-{mode}'
            row = original['cases'][key]
            binary = original['binaries'][peer]['path']

            def result(index, batches):
                command = commands[index]
                assert command['index'] == index
                assert Path(command['command'][-4]).parts[-2:] == Path(binary).parts[-2:]
                assert command['command'][-3:] == list(map(str, (population, mode, batches)))
                assert not command['stderr']
                return decode_output(command['stdout'], population, mode, batches)

            result(row['correctnessCommand'], 1)
            if population == 64:
                assert row['correct'] and row['pilots'] == []
                continue
            assert 1 <= len(row['pilots']) <= len(BATCHES)
            for i, pilot in enumerate(row['pilots']):
                assert pilot['batches'] == BATCHES[i]
                values = result(pilot['command'], BATCHES[i])
                assert (values['serviceNs'] >= MINIMUM_NS) == (i == len(row['pilots'])-1)
            assert row['batches'] == row['pilots'][-1]['batches']
            result(row['ordinaryCommand'], row['batches'])
            sampled = [c for c in commands if c['command'][1:2] == ['record']
                       and Path(c['command'][c['command'].index('--output')+1]).parts[-2:] == (key, 'perf.data')]
            assert len(sampled) == 1
            recording = sampled[0]['command'][sampled[0]['command'].index('--output')+1]
            flat = [c for c in commands if c['command'][1:2] == ['report']
                    and recording in c['command']]
            assert len(flat) == 1 and not flat[0]['stderr']
            sample = sampled[0]
            assert sample['command'][-3:] == list(map(str, (population, mode, row['batches'])))
            decode_output(sample['stdout'], population, mode, row['batches'])
            recording_messages(sample['stderr'])
            replay = report['profiles'][key]
            assert replay['correct'] and 'failure' not in replay
            assert len(replay['commands']) == 2
            directory = folder/key
            for command in replay['commands']:
                assert command['status'] == 0 and 'timeoutSeconds' not in command
                assert not (directory/(command['role']+'.stderr')).read_text()
            raw = stacks((directory/'user-stacks.txt').read_text())
            decoded = stacks((directory/'user-stacks.demangled.txt').read_text())
            assert len(raw) == len(decoded)
            for before, after in zip(raw, decoded):
                assert before['period'] == after['period'] and len(before['frames']) == len(after['frames'])
                assert all(a['ip'] == b['ip'] and a['dso'] == b['dso'] for a, b in zip(before['frames'], after['frames']))
            rebuilt = attribute(decoded, histogram(flat[0]['stdout'], False), peer=peer,
                                functions=names if peer == 'fwp' else None)
            assert rebuilt == replay['attribution'], key
    return dict(cases=len(outputs), profiles=len(report['profiles']), files=len(files))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_subparsers(dest='mode', required=True)
    collection = modes.add_parser('collection')
    replay = modes.add_parser('replay')
    for mode in (collection, replay):
        mode.add_argument('--input', type=Path, required=True)
        mode.add_argument('--source', required=True)
        mode.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    replay.add_argument('--decoder', required=True)
    replay.add_argument('--functions', type=Path, required=True)
    args = parser.parse_args()
    if args.mode == 'replay':
        names = json.loads(args.functions.read_text())
        result = audit_replay(args.input, args.source, args.decoder, args.arch, names)
    else:
        result = audit(args.input, args.source, args.arch)
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
