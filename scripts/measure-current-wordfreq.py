#!/usr/bin/env python3
"""Record qualified whole-program word-frequency baselines; do not accept speedups."""
import argparse
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import signal
import statistics
import struct
import subprocess
import time

from process_wait import communicate

ROOT = Path(__file__).resolve().parent.parent
WORD_SPEC = importlib.util.spec_from_file_location('word_frequency', ROOT / 'scripts/measure-wordfreq.py')
WORD = importlib.util.module_from_spec(WORD_SPEC)
WORD_SPEC.loader.exec_module(WORD)
ORDER_SPEC = importlib.util.spec_from_file_location('numerical_order', ROOT / 'scripts/numerical-baselines.py')
ORDER = importlib.util.module_from_spec(ORDER_SPEC)
ORDER_SPEC.loader.exec_module(ORDER)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def observe(command, input_path, environment, timeout, log, metadata):
    """Retain even failed/partial child output; the parent opens stdin before timing."""
    command = list(map(str, command))
    timed_out = False
    spawn_error = None
    interruption = None
    with input_path.open('rb') as source:
        started = time.perf_counter_ns()
        try:
            child = subprocess.Popen(command, stdin=source, stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE, env=environment, cwd=ROOT,
                                     start_new_session=True)
        except OSError as error:
            spawn_error = str(error)
            status, stdout, stderr = None, b'', b''
        else:
            with child:
                try:
                    stdout, stderr = communicate(child, timeout, None)
                except BaseException as error:
                    timed_out = isinstance(error, subprocess.TimeoutExpired)
                    if not timed_out:
                        interruption = error
                    try:
                        if child.returncode is None:
                            os.killpg(child.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass  # The process group may have exited at the deadline.
                    stdout, stderr = child.communicate()
                status = child.returncode
        elapsed = time.perf_counter_ns() - started
    row = dict(metadata, command=command, input=str(input_path), status=status,
               timedOut=timed_out, spawnError=spawn_error, elapsedNs=elapsed,
               interruption=type(interruption).__name__ if interruption else None,
               stdoutBase64=base64.b64encode(stdout).decode('ascii'),
               stderrBase64=base64.b64encode(stderr).decode('ascii'),
               stdoutSha256=digest(stdout), stderrSha256=digest(stderr))
    with log.open('a', encoding='utf-8') as stream:
        stream.write(json.dumps(row) + '\n')
    if interruption is not None:
        raise interruption
    return row, stdout, stderr


def verify_result(result, expected):
    row, stdout, stderr = result
    assert row['status'] == 0 and not row['timedOut'] and row['interruption'] is None, row
    assert stdout == expected and stderr == b'', (row, stdout, stderr)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'qualification', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['cc', 'rustc', 'c-arch', 'rust-cpu', 'size', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['rounds', 'warmups', 'processes', 'seed', 'timeout', 'session']:
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--case', action='append', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.rounds, args.warmups, args.processes, args.seed, args.timeout) == (16, 2, 64, 20261030, 180)
    assert args.session in [1, 2]
    assert args.case == ['4096:64', '65536:1024']
    machine = platform.machine()
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[machine]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[machine]
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected']
    assert qualification['actual']['machine'] == machine
    assert len(os.sched_getaffinity(0)) == 4
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == qualification['actual']['cVersion']
    assert subprocess.check_output([args.rustc, '--version'], text=True).strip() == qualification['actual']['rustVersion']
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ['GH_TOKEN', 'GITHUB_TOKEN']}
    environment.update(CC=args.cc, LC_ALL='C', FWP_LTO='0', FWP_STACK='1',
                       FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1')
    configuration = dict(source=os.environ['GITHUB_SHA'], qualification=qualification,
        arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()},
        environment={k: v for k, v in environment.items() if k.startswith('FWP_') or k in ['CC', 'LC_ALL']},
        compilerSha256=digest(compiler.read_bytes()), allowedCpus=sorted(os.sched_getaffinity(0)),
        scope='Baseline observations only; no candidate or timing acceptance. Timings cover launch through reaped output; parent input-file opening and evidence writes are outside that clock.')
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2)+'\n')
    empty = output / 'empty.stdin'
    empty.write_bytes(b'')
    sequence = 0

    def run(command, input_path, metadata, env):
        nonlocal sequence
        result = observe(command, input_path, env, args.timeout, output / 'commands.jsonl', dict(metadata, sequence=sequence))
        sequence += 1
        return result

    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-march='+args.c_arch,
             '-fstack-usage', '-UFWP_NO_REUSE']
    paths = {label: output / name for label, name in [
        ('c', 'program-c'), ('rust', 'program-r'),
        ('fwp', 'program-f'), ('fwp-identical', 'program-i')]}
    program = output / 'wordfreq.fwp'
    program.write_bytes((ROOT / 'examples/wordfreq.fwp').read_bytes())
    c_source = output / 'c.c'
    c_source.write_bytes((ROOT / 'tests/fixtures/wordfreq_bench.c').read_bytes())
    rust_source = output / 'rust.rs'
    rust_source.write_bytes((ROOT / 'tests/fixtures/wordfreq_bench.rs').read_bytes())
    generated = output / 'fwp.c'
    builds = [
        ('c', [args.cc, *flags, '-Wall', '-Wextra', '-Werror', c_source, '-o', paths['c']]),
        ('rust', [args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                  '-C', 'target-cpu='+args.rust_cpu, rust_source, '-o', paths['rust']]),
        ('frontend', [compiler, 'build', '-O2', '--emit-c', program, '-o', generated]),
        ('fwp', [args.cc, *flags, '-w', generated, '-o', paths['fwp'], '-lm', '-lpthread', '-ldl']),
    ]
    for label, command in builds:
        verify_result(run(command, empty, dict(phase='build', label=label), environment), b'')
    profile = output / 'fwp-profile.c'
    profile.write_text(WORD.PROFILE.instrument(generated.read_text()))
    profile_binary = output / 'fwp-profile'
    verify_result(run([args.cc, *flags, '-w', profile, '-o', profile_binary, '-lm', '-lpthread', '-ldl'],
                      empty, dict(phase='build', label='profile'), environment), b'')
    shutil.copyfile(paths['fwp'], paths['fwp-identical'])
    paths['fwp-identical'].chmod(0o755)
    binaries = {}
    for label, path in paths.items():
        binary = path.read_bytes()
        assert binary[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', binary, 18)[0] == {'x86_64': 62, 'aarch64': 183}[machine]
        result = run([args.size, '-A', path], empty, dict(phase='sections', label=label), environment)
        assert result[0]['status'] == 0 and not result[2]
        (output / (label + '-sections.txt')).write_bytes(result[1])
        binaries[label] = dict(path=path.name, sha256=digest(binary), bytes=len(binary), sections=result[1].decode())
    assert binaries['fwp']['sha256'] == binaries['fwp-identical']['sha256']
    stack_reports = list(output.glob('*.su'))
    assert len(stack_reports) == 3 and all(p.stat().st_size > 0 for p in stack_reports), 'All three GCC stack reports are required'
    (output / 'binaries.json').write_text(json.dumps(binaries, indent=2)+'\n')
    controls = [b'', b' \t\r\n\v\f', b'a A a, b. B', b'z y x w v u',
                b'... , . A', b'one\vtwo\fone\rTWO\tthree', b'Keep-hyphens keep-hyphens!']
    for number, data in enumerate(controls):
        input_path = output / f'control-{number}.stdin'
        input_path.write_bytes(data)
        expected = WORD.oracle(data)
        verify_result(run([compiler, 'run', '--interp', program], input_path,
                          dict(phase='control', case=number, label='raw-interpreter'),
                          dict(environment, FWP_NO_OPT='1')), expected)
        for label, binary in paths.items():
            verify_result(run([binary], input_path, dict(phase='control', case=number, label=label), environment), expected)
    results = {}
    for case in args.case:
        tokens, vocabulary = map(int, case.split(':'))
        data = WORD.make_input(tokens, vocabulary)
        expected = WORD.oracle(data)
        input_path = output / (case.replace(':', '-')+'.stdin')
        input_path.write_bytes(data)
        (output / (case.replace(':', '-')+'-expected.stdout')).write_bytes(expected)
        totals = {label: [] for label in ORDER.LABELS}
        for round_index in range(-args.warmups, args.rounds):
            round_totals = dict.fromkeys(ORDER.LABELS, 0)
            for position, label in enumerate(ORDER.execution_order(round_index % args.rounds, args.seed, args.processes)):
                result = run([paths[label]], input_path,
                    dict(phase='warmup' if round_index < 0 else 'timing', case=case,
                         round=round_index, position=position, label=label), environment)
                verify_result(result, expected)
                round_totals[label] += result[0]['elapsedNs']
            if round_index >= 0:
                for label in ORDER.LABELS:
                    totals[label].append(round_totals[label])
        result = run([profile_binary], input_path, dict(phase='profile', case=case, label='fwp'), environment)
        assert result[0]['status'] == 0 and result[1] == expected
        profile_counts = json.loads(result[2])
        assert set(profile_counts) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
        assert all(type(v) is int and v >= 0 for v in profile_counts.values())
        assert profile_counts['finalChargedBytes'] == 0 and profile_counts['requests'] > 0
        rss = {}
        for label, binary in paths.items():
            result = run([args.time, '-v', binary], input_path, dict(phase='rss', case=case, label=label), environment)
            assert result[0]['status'] == 0 and result[1] == expected
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result[2])
            assert match, result
            rss[label] = int(match[1])*1024
        medians = {label: statistics.median(values) for label, values in totals.items()}
        results[case] = dict(tokens=tokens, vocabulary=vocabulary, inputBytes=len(data),
            inputSha256=digest(data), expectedSha256=digest(expected), roundTotalsNs=totals,
            medianRoundTotalNs=medians, perProcessEquivalentNs={k:v/args.processes for k,v in medians.items()},
            fwpOverC=medians['fwp']/medians['c'], fwpOverRust=medians['fwp']/medians['rust'],
            fwpOverIdentical=medians['fwp']/medians['fwp-identical'],
            managedProfile=profile_counts, peakProcessRssBytes=rss)
        (output / 'results.json').write_text(json.dumps(results, indent=2)+'\n')
    files = {p.name: dict(bytes=p.stat().st_size, sha256=digest(p.read_bytes())) for p in output.iterdir() if p.is_file()}
    (output / 'comparison.json').write_text(json.dumps(dict(configuration=configuration, binaries=binaries,
        results=results, files=files, commands=sequence,
        decision='baseline-only; budgets must be published before a candidate'), indent=2)+'\n')
    print(json.dumps({case:{key:row[key] for key in ['fwpOverC','fwpOverRust','fwpOverIdentical']}
                      for case,row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
