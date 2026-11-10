#!/usr/bin/env python3
"""Sample compiler CPU stacks on maintained applications; do not measure speedups."""
import argparse
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import traceback

from compiler_sample_stacks import decode
from compiler_scaling import APPLICATIONS, ROOT, digest, resources
from process_wait import run_capture

CORE_REGISTERS = {
    'aarch64': [f'x{i}' for i in range(30)] + ['lr', 'sp', 'pc'],
    'x86_64': ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp', 'sp', 'ip'] + [f'r{i}' for i in range(8, 16)],
}
REGISTER_WARNING = ('WARNING: The use of --call-graph=dwarf may require all the user registers, '
    'specifying a subset with --user-regs may render DWARF unwinding unreliable, '
    'so the minimal registers set (IP, SP) is explicitly forced.')


def recording_messages(text):
    # perf emits this warning for every explicit register list, even a complete
    # general-register set. Keep it visible; validate that set before recording.
    for line in text.splitlines():
        assert line == REGISTER_WARNING or re.fullmatch(
            r'\[ perf record: (Woken up \d+ times to write data|Captured and wrote .+) \]', line), line
        assert not re.search(r'lost|throttl|error', line, re.I), line


def histogram(text, parent):
    """Read explicitly selected perf TSV fields, keeping unresolved samples."""
    lost = re.findall(r'^# Total Lost Samples:\s*(\d+)\s*$', text, re.M)
    assert lost == ['0'], 'missing loss accounting or lost samples'
    headers = [line for line in text.splitlines() if line.startswith('# Overhead\t')]
    assert len(headers) == 1, 'missing or duplicate histogram header'
    columns = [' '.join(part.split()) for part in headers[0][2:].split('\t')]
    expected = ['Overhead', 'Samples', 'Period'] + (['Parent symbol'] if parent else []) + ['Shared Object', 'Symbol']
    assert columns == expected or columns == expected + ['IPC [IPC Coverage]'], columns
    has_ipc = len(columns) != len(expected)
    keys = ['overheadPercent', 'samples', 'period'] + (['parent'] if parent else []) + ['dso', 'symbol']
    rows = []
    for line in text.splitlines():
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        values = [part.strip() for part in line.split('\t')]
        if has_ipc:
            assert values.pop().split() == ['-', '-'], 'software-clock reports must not claim instruction counts'
        assert len(values) == len(keys), f'unexpected perf row: {line}'
        row = dict(zip(keys, values))
        row['overheadPercent'] = float(row['overheadPercent'].removesuffix('%'))
        row['samples'] = int(row['samples'])
        row['period'] = int(row['period'])
        assert 0 <= row['overheadPercent'] <= 100 and row['samples'] > 0 and row['period'] > 0
        rows.append(row)
    assert rows, 'perf returned no samples'
    period = re.findall(r'^# Event count \(approx\.\):\s*(\d+)\s*$', text, re.M)
    assert len(period) == 1 and sum(row['period'] for row in rows) == int(period[0]), 'event total differs from retained rows'
    return rows


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--perf', type=Path, required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--cpu', type=int, required=True)
    parser.add_argument('--frequency', type=int, required=True)
    parser.add_argument('--stack-bytes', type=int, required=True)
    parser.add_argument('--ring-bytes', type=int, required=True)
    parser.add_argument('--user-registers', required=True)
    parser.add_argument('--demangler', type=Path, required=True)
    parser.add_argument('--addr2line-timeout-ms', type=int, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'sample on GitHub runners'
    assert platform.system() == 'Linux' and platform.machine() in ('aarch64', 'x86_64')
    assert 0 < args.deadline <= 120 and 0 < args.frequency <= 1000
    assert 0 < args.addr2line_timeout_ms <= args.deadline * 1000
    assert 0 < args.stack_bytes <= 65528 and args.stack_bytes % 8 == 0
    assert args.ring_bytes > 0 and args.cpu in os.sched_getaffinity(0)
    assert args.user_registers.split(',') == CORE_REGISTERS[platform.machine()]
    os.sched_setaffinity(0, {args.cpu})
    output = args.output.resolve()
    output.mkdir(exist_ok=False, parents=True)
    compiler, perf = args.compiler.resolve(), args.perf.resolve()
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    config = output/'perf.config'
    config.write_text(f'[core]\naddr2line-timeout = {args.addr2line_timeout_ms}\n')
    environment.update(CC=args.cc, FWP_LTO='0', LC_ALL='C', DEBUGINFOD_URLS='', PERF_CONFIG=str(config))
    identity = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        compilerSha256=digest(compiler), rust=subprocess.check_output(['rustc', '-Vv'], text=True),
        perf=str(perf), perfVersion=subprocess.check_output([str(perf), '--version'], text=True),
        demangler=str(args.demangler), demanglerVersion=subprocess.check_output([str(args.demangler), '--version'], text=True),
        cc=args.cc, ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        kernel=platform.platform(), topology=subprocess.check_output(['lscpu'], text=True),
        affinity=sorted(os.sched_getaffinity(0)), event='cpu-clock:u', frequency=args.frequency,
        stackBytes=args.stack_bytes, ringBytes=args.ring_bytes, deadlineSeconds=args.deadline,
        userRegisters=args.user_registers, addr2lineTimeoutMs=args.addr2line_timeout_ms,
        perfConfig=str(config), perfConfigSha256=digest(config),
        releaseDebug=os.environ.get('CARGO_PROFILE_RELEASE_DEBUG'),
        scope='One ordinary and one sampled fresh-process emit-C build for each original application. '
              'No phase reporter, GCC compilation or application execution. User CPU stacks include '
              'the timed command and its descendants, not system-wide work. GNU time is also in that '
              'process tree. Sampling, debug metadata and shared-runner effects prevent a speedup claim. '
              'Decoded user stacks locate body/effect checking; they do not identify individual library definitions.')
    assert identity['releaseDebug'] == '2', 'full debug metadata required for inline stacks'
    (output/'identity.json').write_text(json.dumps(identity, indent=2)+'\n')
    shutil.copyfile(compiler, output/'fwp')
    summary = dict(identity=identity, applications={}, failures=[])
    for name, relative in APPLICATIONS.items():
        directory = output/name
        directory.mkdir()
        row = dict(source=relative, sourceSha256=digest(ROOT/relative), correct=False, commands=[])
        summary['applications'][name] = row
        try:
            shutil.copyfile(ROOT/relative, directory/'input.fwp')
            for sampled in (False, True):
                role = 'sampled' if sampled else 'ordinary'
                cfile = directory/(role+'.c')
                usage = directory/(role+'.resources')
                command = [str(args.time), '-v', '-o', str(usage), str(compiler), 'build',
                           '--target', 'native', '--emit-c', '-O2', str(ROOT/relative), '-o', str(cfile)]
                if sampled:
                    command = [str(perf), 'record', '--event', 'cpu-clock:u', '--freq', str(args.frequency),
                        '--strict-freq', '--inherit', '--call-graph', f'dwarf,{args.stack_bytes}',
                        '--user-regs='+args.user_registers,
                        '--mmap-pages', str(args.ring_bytes)+'B', '--no-buildid-cache',
                        '--output', str(directory/'perf.data'), '--', *command]
                entry = dict(role=role, command=command)
                row['commands'].append(entry)
                result = run_capture(command, env=environment, cwd=ROOT, input_data=None,
                    input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', timeout=args.deadline, check=False)
                entry['status'] = result.returncode
                (directory/(role+'.stdout')).write_bytes(result.stdout)
                (directory/(role+'.stderr')).write_bytes(result.stderr)
                assert result.returncode == 0 and not result.stdout, (entry, result.stderr.decode())
                if sampled:
                    recording_messages(result.stderr.decode())
                else:
                    assert not result.stderr, result.stderr
                entry.update(resources(usage.read_text()), cSha256=digest(cfile))
            assert (directory/'ordinary.c').read_bytes() == (directory/'sampled.c').read_bytes(), 'sampling changed C'
            role = 'all-symbols'
            fields = 'overhead,sample,period,dso,symbol'
            command = [str(perf), 'report', '--input', str(directory/'perf.data'), '--stdio',
                '--inline', '--no-children', '--no-exclude-other', '--call-graph', 'none', '--max-stack', '512',
                '--percent-limit', '0', '--percentage', 'absolute', '--field-separator', '\t',
                '--fields', fields, '--sort', 'dso,symbol']
            entry = dict(role=role, command=command)
            row['commands'].append(entry)
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None,
                input_stream=subprocess.DEVNULL, text=True, encoding='utf-8', timeout=args.deadline, check=False)
            entry['status'] = result.returncode
            (directory/(role+'.tsv')).write_text(result.stdout)
            (directory/(role+'.stderr')).write_text(result.stderr)
            assert result.returncode == 0 and not result.stderr, entry
            raw_rows = histogram(result.stdout, False)
            demangle_command = [str(args.demangler), '--no-strip-underscore', '--format=rust']
            decoded = run_capture(demangle_command, env=environment, cwd=ROOT, input_data=result.stdout,
                input_stream=None, text=True, encoding='utf-8', timeout=args.deadline, check=False)
            entry['demangleCommand'] = demangle_command
            entry['demangleStatus'] = decoded.returncode
            (directory/(role+'.demangled.tsv')).write_text(decoded.stdout)
            (directory/(role+'.demangle.stderr')).write_text(decoded.stderr)
            assert decoded.returncode == 0 and not decoded.stderr, entry
            rows = histogram(decoded.stdout, False)
            assert len(rows) == len(raw_rows)
            for raw, sample in zip(raw_rows, rows):
                assert all(raw[key] == sample[key] for key in ('overheadPercent', 'samples', 'period', 'dso'))
                sample['rawSymbol'] = raw['symbol']
            row[role] = dict(samples=sum(r['samples'] for r in rows), period=sum(r['period'] for r in rows),
                unresolvedSamples=sum(r['samples'] for r in rows if '[unknown]' in r['symbol'] or re.search(r'\b0x[0-9a-f]+$', r['symbol'])), rows=rows)
            row['checking-callers'] = decode(directory/'perf.data', directory, perf, args.demangler,
                environment, args.deadline, row['all-symbols']['rows'], row['commands'])
            row['correct'] = True
        except Exception as error:
            if isinstance(error, subprocess.TimeoutExpired):
                entry['timeoutSeconds'] = error.timeout
                (directory/(role+'.timeout.stdout')).write_bytes(error.output or b'')
                (directory/(role+'.timeout.stderr')).write_bytes(error.stderr or b'')
            row['failure'] = traceback.format_exc()
            summary['failures'].append(name)
        (output/'summary.json').write_text(json.dumps(summary, indent=2)+'\n')
        print(f'{name}: {"pass" if row["correct"] else row["failure"]}', flush=True)
    assert not summary['failures'], summary['failures']


if __name__ == '__main__':
    main()
