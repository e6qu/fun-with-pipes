#!/usr/bin/env python3
"""Decode every retained service recording with an explicitly selected addr2line."""
import argparse
from functools import partial
import gzip
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import traceback

from cpu_samples import decode, histogram, recording_messages
from process_wait import run_capture
from service_cpu_collect import ROOT, digest
from service_cpu_samples import attribute, fwp_functions
from weak_callback_timing import CASES, PEERS, decode_output


def verify_recordings(source, revision, arch):
    manifest = json.loads((source/'sha256.json').read_text())
    for name, value in manifest.items():
        path = source/name
        assert path.resolve().is_relative_to(source.resolve()), name
        assert digest(path) == value, name
    report = json.loads((source/'summary.json').read_text())
    assert report['source'] == revision and report['settings']['arch'] == arch
    assert set(report['cases']) == {f'{peer}-{n}-{m}' for peer in PEERS for n, m in CASES}
    assert set(report['binaries']) == set(PEERS)
    assert all(c['status'] == 0 and 'timeoutSeconds' not in c for c in report['commands'])
    outputs = {}
    for command in report['commands']:
        args = command['command']
        if len(args) >= 4 and Path(args[-4]).name == 'program':
            peer = Path(args[-4]).parent.name.split('-')[0]
            assert peer in PEERS
            values = decode_output(command['stdout'], *map(int, args[-3:]))
            key = f'{peer}-{values["population"]}-{values["mode"]}'
            outputs[key] = outputs.get(key, 0)+1
    assert set(outputs) == set(report['cases']), 'missing actual service outputs'
    for peer, binary in report['binaries'].items():
        assert digest(source/binary['path']) == binary['sha256'], peer
    return report, outputs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('recordings', 'output', 'perf', 'addr2line', 'reference-perf', 'demangler', 'swift-demangler'):
        parser.add_argument('--'+name, type=Path, required=True)
    for name in ('source', 'run', 'arch'):
        parser.add_argument('--'+name, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    parser.add_argument('--addr2line-timeout-ms', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.arch and 0 < args.deadline <= 120
    assert 0 < args.addr2line_timeout_ms <= args.deadline*1000
    assert Path(shutil.which('addr2line')).resolve() == args.addr2line.resolve()
    source = args.recordings.resolve()/'service-cpu-evidence'
    original, outputs = verify_recordings(source, args.source, args.arch)
    restored = ROOT/'service-cpu-evidence'
    original_path = Path(original['settings']['output'])
    assert (ROOT/original_path).resolve() == restored.resolve()
    assert not restored.exists(), 'do not replace an existing observation'
    shutil.copytree(source, restored)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    config = output/'perf.config'
    config.write_text(f'[core]\naddr2line-timeout = {args.addr2line_timeout_ms}\n')
    env = dict(os.environ, LC_ALL='C', DEBUGINFOD_URLS='', PERF_CONFIG=str(config))
    report = dict(recordingRun=args.run, recordingSource=args.source,
        originalFailures=original['failures'], verifiedOutputCounts=outputs,
        decoderSource=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        addr2line=str(args.addr2line), addr2lineSha256=digest(args.addr2line),
        addr2lineVersion=subprocess.check_output([args.addr2line, '--version'], text=True),
        perfVersion=subprocess.check_output([args.perf, '--version'], text=True),
        perfConfigSha256=digest(config), profiles={}, failures=[])
    (output/'original-summary.json.gz').write_bytes(gzip.compress((source/'summary.json').read_bytes(), mtime=0))
    functions = fwp_functions((source/'original.c').read_text())
    assert functions == json.loads((source/'function-names.json').read_text())
    for peer in PEERS:
        for mode in range(4):
            key = f'{peer}-4096-{mode}'
            directory = output/key
            directory.mkdir()
            row = dict(correct=False, commands=[])
            report['profiles'][key] = row
            try:
                recording = restored/key/'perf.data'
                row['recordingSha256'] = digest(recording)
                # Use the original recording's sample totals, never a new run.
                flat_commands = [c for c in original['commands'] if c['command'][1:2] == ['report']
                                 and str(recording) in c['command']]
                assert len(flat_commands) == 1 and not flat_commands[0]['stderr']
                flat = histogram(flat_commands[0]['stdout'], False)
                recorded = [c for c in original['commands'] if c['command'][1:2] == ['record']
                            and str(recording) in c['command']]
                assert len(recorded) == 1
                recording_messages(recorded[0]['stderr'])
                symbol_command = ([args.swift_demangler, '--compact'] if peer == 'swift'
                    else [args.demangler, '--no-strip-underscore', '--format=rust'])
                row['attribution'] = decode(recording, directory, perf=args.perf,
                    symbol_command=symbol_command, environment=env, deadline=args.deadline,
                    flat=flat, commands=row['commands'],
                    attribution=partial(attribute, peer=peer, functions=functions if peer == 'fwp' else None), cwd=ROOT)
                row['correct'] = True
            except Exception:
                row['failure'] = traceback.format_exc()
                report['failures'].append(key)
            (output/'summary.json').write_text(json.dumps(report, indent=2)+'\n')
            print(key, 'pass' if row['correct'] else row['failure'], flush=True)
    # Keep the first failing GNU exchange as a source-level diagnosis. This never
    # supplies accepted attribution and does not execute a recorded program.
    command = [str(args.reference_perf), 'script', '-v', '--input', str(restored/'fwp-4096-0/perf.data'),
               '--inline', '--max-stack', '512', '--fields', 'period,event,ip,sym,dso']
    diagnostic = run_capture(command, env=env, cwd=ROOT, input_data=None,
        input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', timeout=args.deadline, check=False)
    for name, data in (('stdout', diagnostic.stdout), ('stderr', diagnostic.stderr)):
        (output/('gnu-diagnostic.'+name+'.gz')).write_bytes(gzip.compress(data, mtime=0))
    report['gnuDiagnostic'] = dict(command=command, status=diagnostic.returncode,
        shortFunctionRecords=len(re.findall(rb'addr2line read address for sentinel: [fe]\d+\n', diagnostic.stderr)),
        sentinelErrors=diagnostic.stderr.count(b'unexpected record instead of sentinel'))
    (output/'summary.json').write_text(json.dumps(report, indent=2)+'\n')
    manifest = {str(p.relative_to(output)): digest(p) for p in output.rglob('*') if p.is_file()}
    (output/'sha256.json').write_text(json.dumps(manifest, indent=2)+'\n')
    assert not report['failures'], report['failures']
    assert diagnostic.returncode == 0 and report['gnuDiagnostic']['shortFunctionRecords'] > 0
    assert report['gnuDiagnostic']['sentinelErrors'] > 0, 'original decoder defect did not reproduce'


if __name__ == '__main__':
    main()
