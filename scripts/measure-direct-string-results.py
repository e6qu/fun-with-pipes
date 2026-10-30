#!/usr/bin/env python3
"""Measure direct string results against the exact old bodies and C/Rust peers."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
BASE_SPEC = importlib.util.spec_from_file_location('current_wordfreq', ROOT / 'scripts/measure-current-wordfreq.py')
BASE = importlib.util.module_from_spec(BASE_SPEC)
BASE_SPEC.loader.exec_module(BASE)
CHECK_SPEC = importlib.util.spec_from_file_location('direct_strings', ROOT / 'scripts/direct-string-evidence.py')
CHECK = importlib.util.module_from_spec(CHECK_SPEC)
CHECK_SPEC.loader.exec_module(CHECK)


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
    assert args.session in [1, 2] and args.case == ['4096:64', '65536:1024']
    machine = platform.machine()
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[machine]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[machine]
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected']
    assert qualification['actual']['machine'] == machine and len(os.sched_getaffinity(0)) == 4
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == qualification['actual']['cVersion']
    assert subprocess.check_output([args.rustc, '--version'], text=True).strip() == qualification['actual']['rustVersion']
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ['GH_TOKEN', 'GITHUB_TOKEN']}
    environment.update(CC=args.cc, LC_ALL='C', FWP_LTO='0', FWP_STACK='1',
                       FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1')
    configuration = dict(source=os.environ['GITHUB_SHA'], reference=CHECK.REFERENCE,
        qualification=qualification,
        arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()},
        environment={k: v for k, v in environment.items() if k.startswith('FWP_') or k in ['CC', 'LC_ALL']},
        compilerSha256=BASE.digest(compiler.read_bytes()), allowedCpus=sorted(os.sched_getaffinity(0)),
        scope='Two separate whole-process comparisons. Launch through reaped output; parent input-file opening and evidence writes excluded. No pooling across phases or host sessions.')
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    empty = output / 'empty.stdin'
    empty.write_bytes(b'')
    sequence = 0

    def run(command, input_path, metadata, env):
        nonlocal sequence
        result = BASE.observe(command, input_path, env, args.timeout, output / 'commands.jsonl',
                              dict(metadata, sequence=sequence))
        sequence += 1
        return result

    def build(command, label):
        BASE.verify_result(run(command, empty, dict(phase='build', label=label), environment), b'')

    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
             '-fstack-usage', '-UFWP_NO_REUSE']
    paths = {label: output / ('program-' + suffix) for label, suffix in [
        ('c', 'c'), ('rust', 'r'), ('candidate', 'f'), ('candidate-copy', 'i'),
        ('reference', 'a'), ('reference-copy', 'b')]}
    assert len({len(str(path)) for path in paths.values()}) == 1
    program = output / 'wordfreq.fwp'
    program.write_bytes((ROOT / 'examples/wordfreq.fwp').read_bytes())
    c_source, rust_source = output / 'c.c', output / 'rust.rs'
    c_source.write_bytes((ROOT / 'tests/fixtures/wordfreq_bench.c').read_bytes())
    rust_source.write_bytes((ROOT / 'tests/fixtures/wordfreq_bench.rs').read_bytes())
    build([args.cc, *flags, '-Wall', '-Wextra', '-Werror', c_source, '-o', paths['c']], 'c')
    build([args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
           '-C', 'target-cpu=' + args.rust_cpu, rust_source, '-o', paths['rust']], 'rust')
    generated = output / 'candidate.c'
    build([compiler, 'build', '-O2', '--emit-c', program, '-o', generated], 'frontend')
    runtime = (ROOT / 'runtime/fwp_rt_prims.c').read_text()
    frozen = json.loads((ROOT / 'tests/fixtures/direct-string-reference.json').read_text())
    reference, patch = CHECK.reference_source(generated.read_text(), runtime, frozen)
    (output / 'reference.c').write_text(reference)
    (output / 'reference-patch.json').write_text(json.dumps(patch, indent=2) + '\n')
    (output / 'runtime-primitives.c').write_text(runtime)
    (output / 'reference-functions.json').write_text(json.dumps(frozen, indent=2) + '\n')
    profiles = {}
    for label in ['candidate', 'reference']:
        source = output / (label + '.c')
        build([args.cc, *flags, '-w', source, '-o', paths[label], '-lm', '-lpthread', '-ldl'], label)
        profile = output / (label + '-profile.c')
        profile.write_text(CHECK.instrument_raw(BASE.WORD.PROFILE.instrument(source.read_text())))
        profiles[label] = output / (label + '-profile')
        build([args.cc, *flags, '-w', profile, '-o', profiles[label], '-lm', '-lpthread', '-ldl'], label + '-profile')
        shutil.copyfile(paths[label], paths[label + '-copy'])
        paths[label + '-copy'].chmod(0o755)
    binaries = {}
    for label, path in paths.items():
        binary = path.read_bytes()
        assert binary[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', binary, 18)[0] == {'x86_64': 62, 'aarch64': 183}[machine]
        result = run([args.size, '-A', path], empty, dict(phase='sections', label=label), environment)
        assert result[0]['status'] == 0 and not result[2]
        (output / (label + '-sections.txt')).write_bytes(result[1])
        binaries[label] = dict(path=path.name, sha256=BASE.digest(binary), bytes=len(binary), sections=result[1].decode())
    for label in ['candidate', 'reference']:
        assert binaries[label]['sha256'] == binaries[label + '-copy']['sha256']
    stack_reports = list(output.glob('*.su'))
    assert len(stack_reports) == 5 and all(p.stat().st_size > 0 for p in stack_reports)

    def stack(label):
        reports = list(output.glob(paths[label].name + '-*.su'))
        assert len(reports) == 1, reports
        return reports[0].read_text()

    representation = CHECK.representation_decision(binaries['reference']['sections'], binaries['candidate']['sections'],
                                                   stack('reference'), stack('candidate'))
    (output / 'representation.json').write_text(json.dumps(representation, indent=2) + '\n')
    (output / 'binaries.json').write_text(json.dumps(binaries, indent=2) + '\n')
    controls = [b'', b' \t\r\n\v\f', b'a A a, b. B', b'z y x w v u',
                b'... , . A', b'one\vtwo\fone\rTWO\tthree', b'Keep-hyphens keep-hyphens!']
    for number, data in enumerate(controls):
        input_path = output / f'control-{number}.stdin'
        input_path.write_bytes(data)
        expected = BASE.WORD.oracle(data)
        BASE.verify_result(run([compiler, 'run', '--interp', program], input_path,
            dict(phase='control', case=number, label='raw-interpreter'), dict(environment, FWP_NO_OPT='1')), expected)
        for label, binary in paths.items():
            BASE.verify_result(run([binary], input_path, dict(phase='control', case=number, label=label), environment), expected)
    results = {}
    failures = list(representation['failures'])
    phases = {
        'paired': dict(zip(BASE.ORDER.LABELS, ['reference', 'reference-copy', 'candidate', 'candidate-copy'])),
        'context': dict(zip(BASE.ORDER.LABELS, ['c', 'rust', 'candidate', 'candidate-copy'])),
    }
    for case in args.case:
        tokens, vocabulary = map(int, case.split(':'))
        data = BASE.WORD.make_input(tokens, vocabulary)
        expected = BASE.WORD.oracle(data)
        input_path = output / (case.replace(':', '-') + '.stdin')
        input_path.write_bytes(data)
        (output / (case.replace(':', '-') + '-expected.stdout')).write_bytes(expected)
        totals = {}
        for comparison, roles in phases.items():
            totals[comparison] = {label: [] for label in roles.values()}
            for round_index in range(-args.warmups, args.rounds):
                round_totals = dict.fromkeys(roles.values(), 0)
                for position, slot in enumerate(BASE.ORDER.execution_order(round_index % args.rounds, args.seed, args.processes)):
                    label = roles[slot]
                    result = run([paths[label]], input_path,
                        dict(phase='warmup' if round_index < 0 else 'timing', comparison=comparison,
                             case=case, round=round_index, position=position, label=label), environment)
                    BASE.verify_result(result, expected)
                    round_totals[label] += result[0]['elapsedNs']
                if round_index >= 0:
                    for label in roles.values():
                        totals[comparison][label].append(round_totals[label])
        profiles_by_label = {}
        for label, binary in profiles.items():
            result = run([binary], input_path, dict(phase='profile', case=case, label=label), environment)
            assert result[0]['status'] == 0 and result[1] == expected
            raw, managed = map(json.loads, result[2].splitlines())
            profiles_by_label[label] = dict(raw=raw, managed=managed)
            failures.extend(CHECK.profile_failures(case, label, managed, raw))
        rss = {}
        for label, binary in paths.items():
            result = run([args.time, '-v', binary], input_path, dict(phase='rss', case=case, label=label), environment)
            assert result[0]['status'] == 0 and result[1] == expected
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result[2])
            assert match, result
            rss[label] = int(match[1]) * 1024
        decision = CHECK.timing_decision(case, totals['paired'], totals['context'])
        failures.extend(decision['failures'])
        results[case] = dict(tokens=tokens, vocabulary=vocabulary, inputBytes=len(data),
            inputSha256=BASE.digest(data), expectedSha256=BASE.digest(expected), roundTotalsNs=totals,
            decision=decision, profiles=profiles_by_label, peakProcessRssBytes=rss)
        (output / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    files = {p.name: dict(bytes=p.stat().st_size, sha256=BASE.digest(p.read_bytes())) for p in output.iterdir() if p.is_file()}
    (output / 'comparison.json').write_text(json.dumps(dict(configuration=configuration, binaries=binaries,
        results=results, representation=representation, files=files, commands=sequence, failures=failures,
        decision='session-rejected' if failures else 'session-passes; all four sessions still required'), indent=2) + '\n')
    print(json.dumps(dict(results={case: row['decision'] for case, row in results.items()}, failures=failures), indent=2))
    assert not failures, failures


if __name__ == '__main__':
    main()
