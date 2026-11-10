#!/usr/bin/env python3
"""Locate service CPU costs on native runners; sampled durations are not timings."""
import argparse
from functools import partial
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import struct
import subprocess
import sys
import traceback

from cpu_samples import CORE_REGISTERS, decode, histogram, recording_messages
from process_wait import run_capture
from service_cpu_samples import attribute, fwp_functions
from weak_callback_service_build import build_native
from weak_callback_source import boundary
from weak_callback_timing import BATCHES, CASES, PEERS, decode_output

ROOT = Path(__file__).resolve().parent.parent
MINIMUM_NS = 1_000_000_000


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def preflight_attribution(samples, flat):
    assert len(samples) == sum(row['samples'] for row in flat)
    assert sum(s['period'] for s in samples) == sum(row['period'] for row in flat)
    assert any(s['frames'] for s in samples), 'probe has no decoded frames'
    return dict(samples=len(samples), period=sum(s['period'] for s in samples))


def record_command(args, directory, command):
    return [str(args.perf), 'record', '--event', 'cpu-clock:u', '--freq', str(args.frequency),
            '--strict-freq', '--inherit', '--call-graph', f'dwarf,{args.stack_bytes}',
            '--user-regs='+args.user_registers, '--mmap-pages', str(args.ring_bytes)+'B',
            '--no-buildid-cache', '--output', str(directory/'perf.data'), '--', *map(str, command)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('probe', 'collect'))
    for name in ('compiler', 'perf', 'addr2line', 'demangler', 'swift-demangler', 'output'):
        parser.add_argument('--'+name, type=Path, required=True)
    for name in ('source', 'tag', 'arch', 'cc', 'ar', 'rustc', 'swiftc', 'target', 'c-arch', 'rust-cpu', 'user-registers'):
        parser.add_argument('--'+name, required=True)
    for name in ('cpu', 'frequency', 'stack-bytes', 'ring-bytes', 'addr2line-timeout-ms'):
        parser.add_argument('--'+name, type=int, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.arch in CORE_REGISTERS and args.user_registers.split(',') == CORE_REGISTERS[args.arch]
    assert args.cpu in os.sched_getaffinity(0)
    assert 0 < args.deadline <= 120 and 0 < args.addr2line_timeout_ms <= args.deadline*1000
    assert (args.frequency, args.stack_bytes, args.ring_bytes) == (997, 32768, 262144)
    assert args.target == args.arch+'-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert args.source == os.environ['GITHUB_SHA'] and args.tag.startswith('roadmap/service-cpu-')
    for revision in ('HEAD', args.tag):
        assert subprocess.check_output(['git', 'rev-parse', revision], cwd=ROOT, text=True).strip() == args.source
    assert Path(shutil.which('addr2line')).resolve() == args.addr2line.resolve()
    os.sched_setaffinity(0, {args.cpu})
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if not k.startswith('FWP_')
           and k not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    config = output/'perf.config'
    config.write_text(f'[core]\naddr2line-timeout = {args.addr2line_timeout_ms}\n')
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1', SWIFT_BACKTRACE='enable=no',
               DEBUGINFOD_URLS='', PERF_CONFIG=str(config))
    report = dict(source=args.source, tag=args.tag, settings={k: str(v) for k, v in vars(args).items()},
                  commands=[], binaries={}, cases={}, failures=[], perfConfigSha256=digest(config))

    def save():
        (output/'summary.json').write_text(json.dumps(report, indent=2)+'\n')

    def run(command, expected, environment):
        command = list(map(str, command))
        entry = dict(command=command, index=len(report['commands']))
        report['commands'].append(entry)
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None,
                input_stream=subprocess.DEVNULL, text=True, encoding='utf-8', timeout=args.deadline, check=False)
            entry.update(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        except subprocess.TimeoutExpired as error:
            entry.update(status=None, timeoutSeconds=error.timeout,
                stdout=(error.stdout or b'').decode(errors='replace'), stderr=(error.stderr or b'').decode(errors='replace'))
            raise
        finally:
            save()
        assert entry['status'] == expected[0], entry
        assert expected[1] is None or entry['stdout'] == expected[1], entry
        assert expected[2] is None or entry['stderr'] == expected[2], entry
        return entry

    def profile(directory, command, symbol_command, attribution):
        sampled = run(record_command(args, directory, command), (0, None, None), env)
        recording_messages(sampled['stderr'])
        flat = run([args.perf, 'report', '--input', directory/'perf.data', '--stdio', '--inline',
            '--no-children', '--no-exclude-other', '--call-graph', 'none', '--max-stack', '512',
            '--percent-limit', '0', '--percentage', 'absolute', '--field-separator', '\t',
            '--fields', 'overhead,sample,period,dso,symbol', '--sort', 'dso,symbol'], (0, None, ''), env)
        rows = histogram(flat['stdout'], False)
        result = decode(directory/'perf.data', directory, perf=args.perf,
            symbol_command=symbol_command, environment=env, deadline=args.deadline,
            flat=rows, commands=report['commands'], attribution=attribution, cwd=ROOT)
        (directory/'attribution.json').write_text(json.dumps(result, indent=2)+'\n')
        return dict(command=sampled['index'], stdout=sampled['stdout'], flat=rows, attribution=result)

    try:
        report['host'] = dict(kernel=platform.platform(), affinity=sorted(os.sched_getaffinity(0)),
            topology=run(['lscpu'], (0, None, ''), env)['stdout'])
        report['versions'] = {name: run([getattr(args, name), '--version'], (0, None, ''), env)['stdout']
                              for name in ('cc', 'ar', 'rustc', 'swiftc', 'perf', 'demangler', 'addr2line')}
        report['addr2lineSha256'] = digest(args.addr2line)
        if args.action == 'probe':
            directory = output/'probe'
            directory.mkdir()
            command = [sys.executable, '-c', 'import time\nstart=time.process_time()\nwhile time.process_time()-start < 1: pass']
            report['probe'] = profile(directory, command,
                [args.demangler, '--no-strip-underscore', '--format=rust'], preflight_attribution)
            assert not report['probe']['stdout']
            return
        report['compilerSha256'] = digest(args.compiler)
        fixtures = output/'fixtures'
        fixtures.mkdir()
        for pattern in ('weak_callback_service*', 'callable_phase_clock.*'):
            for path in (ROOT/'tests/fixtures').glob(pattern):
                shutil.copyfile(path, fixtures/path.name)
        clock = output/'clock.o'
        run([args.cc, '-std=c11', '-O2', '-g', '-fno-lto', '-ffp-contract=off', '-march='+args.c_arch,
             '-Wall', '-Wextra', '-Werror', '-c', fixtures/'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
        generated = output/'original.c'
        emitted, functions = None, None
        try:
            run([args.compiler.resolve(), 'build', '--fn', 'service', '--memory', 'dynamic', '--emit-c',
                 '-O2', fixtures/'weak_callback_service.fwp', '-o', generated], (0, '', ''), env)
            functions = fwp_functions(generated.read_text())
            emitted = boundary(generated.read_text())
            (output/'function-names.json').write_text(json.dumps(functions, indent=2)+'\n')
        except Exception:
            report['failures'].append(dict(case='fwp emission', error=traceback.format_exc()))
        for peer in PEERS:
            try:
                extension = 'c' if peer == 'fwp' else peer
                factory = emitted if peer == 'fwp' else (fixtures/('weak_callback_service.'+peer)).read_text()
                assert factory is not None, 'fwp emission failed'
                caller = (fixtures/('weak_callback_service_time.'+extension)).read_text()
                binary, _ = build_native(args, output, peer, factory, 'sampled', 2, 'plain', True, clock, caller, run, env)
                with binary.open('rb') as stream:
                    header = stream.read(20)
                assert header[:6] == b'\x7fELF\x02\x01'
                machine = struct.unpack_from('<H', header, 18)[0]
                assert machine == {'aarch64': 183, 'x86_64': 62}[args.arch]
                report['binaries'][peer] = dict(path=str(binary.relative_to(output)), sha256=digest(binary), elfMachine=machine)
            except Exception:
                report['failures'].append(dict(case=peer+' build', error=traceback.format_exc()))
                save()
                continue
            for population, mode in CASES:
                key = f'{peer}-{population}-{mode}'
                directory = output/key
                directory.mkdir()
                row = dict(correct=False, pilots=[])
                report['cases'][key] = row
                try:
                    check = run([binary, population, mode, 1], (0, None, ''), env)
                    decode_output(check['stdout'], population, mode, 1)
                    row['correctnessCommand'] = check['index']
                    if population == 4096:
                        for batches in BATCHES:
                            trial = run([binary, population, mode, batches], (0, None, ''), env)
                            values = decode_output(trial['stdout'], population, mode, batches)
                            row['pilots'].append(dict(batches=batches, command=trial['index']))
                            save()
                            if values['serviceNs'] >= MINIMUM_NS:
                                break
                        assert values['serviceNs'] >= MINIMUM_NS, 'batch ladder did not reach one second'
                        row['batches'] = batches
                        ordinary = run([binary, population, mode, batches], (0, None, ''), env)
                        decode_output(ordinary['stdout'], population, mode, batches)
                        row['ordinaryCommand'] = ordinary['index']
                        symbol_command = ([args.swift_demangler, '--compact'] if peer == 'swift'
                            else [args.demangler, '--no-strip-underscore', '--format=rust'])
                        row['profile'] = profile(directory, [binary, population, mode, batches], symbol_command,
                            partial(attribute, peer=peer, functions=functions if peer == 'fwp' else None))
                        decode_output(row['profile']['stdout'], population, mode, batches)
                    row['correct'] = True
                except Exception:
                    row['failure'] = traceback.format_exc()
                    report['failures'].append(dict(case=key, error=row['failure']))
                save()
                print(key, 'pass' if row['correct'] else row['failure'], flush=True)
        assert not report['failures'], report['failures']
    except Exception:
        report['failure'] = traceback.format_exc()
        raise
    finally:
        save()
        manifest = {str(p.relative_to(output)): digest(p) for p in sorted(output.rglob('*')) if p.is_file()}
        (output/'sha256.json').write_text(json.dumps(manifest, indent=2)+'\n')


if __name__ == '__main__':
    main()
