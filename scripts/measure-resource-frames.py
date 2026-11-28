#!/usr/bin/env python3
"""Observe saved native service/HTTP C; never use observer builds for timings."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import signal
import socket
import subprocess
import time
import traceback

from http_load import REQUEST, response_ok
from nested_resource_counts import COUNTERS, MEMORY, instrument, instrument_runtime
from process_wait import run_capture
from resource_frame_counts import decode, instrument as attribute
from weak_callback_service import CASES
from weak_callback_service_build import build_native
from weak_callback_source import boundary
from weak_callback_timing import decode_output

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def http_observer(source):
    source = instrument_runtime(source)
    declarations = '\nstatic size_t resource_initial_live;\n'
    source = source.replace('typedef uint64_t V;', 'typedef uint64_t V;' + declarations, 1)
    start = source.index('static void *fwp_main_thread(void *arg) {')
    prefix, main = source[:start], source[start:]
    marker = '    fwp_init_consts();\n'
    assert main.count(marker) == 1
    main = main.replace(marker, marker + '    resource_initial_live = fwp_heap.live;\n', 1)
    marker = '    /* Ownership observation point: before runtime teardown. */\n'
    assert main.count(marker) == 1
    fields = ','.join(f'\\"{key}\\":%llu' for key in (*COUNTERS, *MEMORY))
    values = ['observed_' + key for key in COUNTERS] + ['resource_initial_live', 'fwp_heap.live', 'fwp_heap.peak']
    report = (f'    fprintf(stderr, "FWP_HTTP_TOTAL {{{fields}}}\\n", '
              + ', '.join('(unsigned long long)' + value for value in values) + ');\n'
              '    if (fwp_heap.live != resource_initial_live || fwp_cleanups || fwp_tasks_active) abort();\n')
    return prefix + main.replace(marker, marker + report, 1)


def http_run(binary, folder, requests, env):
    """One persistent connection, exact validated replies, then graceful shutdown.

    This is an operation census, not a throughput or latency measurement. Save
    every response and the process output, including on timeout or failure.
    """
    folder.mkdir()
    environment = env | {'FWP_ADDR': '127.0.0.1:0'}
    (folder / 'request.bin').write_bytes(REQUEST)
    with (folder / 'stdout').open('wb') as out, (folder / 'stderr').open('wb') as err:
        child = subprocess.Popen([binary], cwd=ROOT, env=environment, stdout=out, stderr=err)
        result = dict(command=[str(binary)], requests=requests, responses=0, status=None)
        try:
            deadline = time.monotonic() + 15
            while True:
                text = (folder / 'stderr').read_text()
                address = re.search(r'listening on http://127\.0\.0\.1:(\d+)', text)
                if address:
                    break
                assert child.poll() is None, text
                assert time.monotonic() < deadline, 'HTTP startup timed out'
                time.sleep(.02)
            with socket.create_connection(('127.0.0.1', int(address[1])), timeout=5) as connection:
                pending = b''
                for index in range(requests):
                    connection.sendall(REQUEST)
                    while b'\r\n\r\n' not in pending:
                        chunk = connection.recv(8192)
                        assert chunk, 'closed before response header'
                        pending += chunk
                        assert len(pending) < 16384
                    header, _, body = pending.partition(b'\r\n\r\n')
                    length, = re.findall(rb'(?im)^content-length:\s*(\d+)\r?$', header)
                    size = int(length)
                    assert size < 8192
                    while len(body) < size:
                        chunk = connection.recv(8192)
                        assert chunk, 'closed before response body'
                        body += chunk
                    wire = header + b'\r\n\r\n' + body[:size]
                    (folder / f'response-{index}.bin').write_bytes(wire)
                    assert response_ok(wire)
                    result['responses'] += 1
                    pending = body[size:]
                assert not pending
            child.send_signal(signal.SIGTERM)
            result['status'] = child.wait(timeout=15)
            assert result['status'] == 0
        finally:
            if child.poll() is None:
                child.kill()
            child.wait()
            (folder / 'command.json').write_text(json.dumps(result, indent=2) + '\n')
    text = (folder / 'stderr').read_text()
    assert 'stopped\n' in text and not (folder / 'stdout').read_bytes()
    return text


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch', 'c-arch', 'cc'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    original = args.input.resolve() / 'resource-field-observations'
    census = json.loads((original / 'report.json').read_text())
    assert census['source'] == args.source and census['kind'] == 'plain-fields' and not census['failures']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    report = dict(source=args.source, toolSource=os.environ['GITHUB_SHA'], arch=args.arch,
                  host=platform.uname()._asdict(), selected={}, builds=[], cases={}, failures=[])
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1')

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    commands = []

    def run(command, expected, environment):
        command = list(map(str, command))
        result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                             text=True, encoding='utf-8', timeout=180, check=False)
        row = dict(command=command, status=result.returncode, stdout=result.stdout,
                   stderr=result.stderr, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as stream:
            stream.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0], row
        for key, value in zip(('stdout', 'stderr'), expected[1:]):
            assert value is None or row[key] == value, row
        return row

    report['ccVersion'] = run([args.cc, '--version'], (0, None, ''), env)['stdout']
    clock = folder / 'clock.o'
    fixtures = ROOT / 'tests/fixtures'
    run([args.cc, '-O2', '-fno-lto', '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
    for application, name in (('service', 'exported-service'), ('http', 'http')):
        case = census['cases'][name]
        saved = original / f'{name}-ordinary.c'
        assert digest(saved) == case['cSha256']
        base = instrument(boundary(saved.read_text())) if application == 'service' else http_observer(saved.read_text())
        for level in (1, 2):
            for label in ('baseline', 'attributed', 'extra-pair'):
                group = f'{application}/O{level}/{label}'
                try:
                    source = base
                    if label != 'baseline':
                        source, selected = attribute(source, case['observations'], label == 'extra-pair')
                        assert application not in report['selected'] or report['selected'][application] == selected
                        report['selected'][application] = selected
                        if application == 'service':
                            signature = 'ServiceStats service_run(size_t population, int mode) {'
                            prefix, bridge = source.split(signature)
                            marker = '    return result;'
                            assert bridge.count(marker) == 1
                            source = prefix + signature + bridge.replace(marker, '    resource_work_report();\n' + marker, 1)
                        else:
                            marker = '    /* Ownership observation point: before runtime teardown. */'
                            assert source.count(marker) == 1
                            source = source.replace(marker, '    resource_work_report();\n' + marker, 1)
                    if application == 'service':
                        binary, built = build_native(args, folder, 'fwp', source, label, level, 'diagnostic',
                                                     False, clock, (fixtures / 'weak_callback_service_time.c').read_text(), run, env)
                    else:
                        path = folder / f'http-{label}-{level}.c'
                        path.write_text(source)
                        binary = path.with_suffix('')
                        built = run([args.cc, '-std=gnu11', '-O' + str(level), '-fno-lto', '-ffp-contract=off',
                                     '-march=' + args.c_arch, '-w', path, '-lm', '-lpthread', '-ldl',
                                     '-lssl', '-lcrypto', '-o', binary], (0, '', ''), env)
                    image = binary.read_bytes()
                    assert image[:6] == b'\x7fELF\x02\x01'
                    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                    report['builds'].append(dict(group=group, path=str(binary.relative_to(folder)),
                                                 sha256=digest(binary), command=built['index']))
                    populations = CASES if application == 'service' else ((64, 0), (256, 0))
                    if label == 'extra-pair':
                        populations = ((64, 0),)
                    for population, mode in populations:
                        key = f'{group}/{population}-{mode}'
                        if application == 'service':
                            row = run([binary, population, mode, 1], (0, None, None), env)
                            decode_output(row['stdout'], population, mode, 1)
                            text = row['stderr']
                            total = json.loads(text.splitlines()[0])
                            entry = dict(command=row['index'], total=total)
                        else:
                            relative = key.replace('/', '-')
                            text = http_run(binary, folder / relative, population, env)
                            totals = [line.removeprefix('FWP_HTTP_TOTAL ') for line in text.splitlines() if line.startswith('FWP_HTTP_TOTAL ')]
                            total, = map(json.loads, totals)
                            entry = dict(directory=relative, total=total)
                        if label != 'baseline':
                            line, = [line for line in text.splitlines() if line.startswith('FWP_RESOURCE_WORK ')]
                            entry['work'] = decode(line, selected)
                        report['cases'][key] = entry
                        print('RESULT', key, json.dumps(entry), flush=True)
                        save()
                except Exception:
                    report['failures'].append(dict(group=group, error=traceback.format_exc()))
                    save()
    (folder / 'manifest.json').write_text(json.dumps(
        {str(path.relative_to(folder)): digest(path) for path in sorted(folder.rglob('*')) if path.is_file()}, indent=2) + '\n')
    assert not report['failures'], report['failures']


if __name__ == '__main__':
    main()
