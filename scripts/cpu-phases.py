#!/usr/bin/env python3
"""Separate calculation and runtime work in explicitly instrumented CPU peers."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import re
import statistics
import struct
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('scalar_bounds', ROOT / 'scripts/scalar-bounds.py')
BOUNDS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BOUNDS)
PROGRAMS = ('loop', 'text-length')
LANGUAGES = ('c', 'rs', 'fwp')
KINDS = tuple(kind for language in LANGUAGES for kind in (language, language + '-identical', language + '-phases'))
SETTINGS = dict(samples=72, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all')
EXPECTED = {'loop': '300000003\n', 'text-length': '28518516\n'}
LABELS = {'c': ('calculation', 'output'), 'rs': ('calculation', 'output'),
          'fwp': ('launcher-and-thread-start', 'runtime-setup', 'calculation', 'output',
                  'entry-return', 'worker-cleanup', 'join-and-final-flush')}
C_CLOCK = r'''
#include <inttypes.h>
#include <time.h>
static uint64_t phase_marks[8];
static unsigned phase_seen[8];
static __attribute__((noinline, noclone)) void phase_mark(unsigned index, uint64_t value) {
    /* Keep the completed result live at the boundary; do not change loop inputs. */
    __asm__ volatile ("" : : "r"(value) : "memory");
    if (index >= 8 || phase_seen[index]++) _Exit(246);
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now)) _Exit(246);
    phase_marks[index] = (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
    __asm__ volatile ("" : : : "memory");
}
static void phase_report(unsigned count) {
    for (unsigned i = 0; i < count; i++) if (phase_seen[i] != 1) _Exit(246);
    fputs("{\"marksNs\":[", stderr);
    for (unsigned i = 0; i < count; i++) fprintf(stderr, "%s%" PRIu64, i ? "," : "", phase_marks[i]);
    fputs("]}\n", stderr);
}
'''


def replace_once(source, old, new):
    assert source.count(old) == 1, f'expected one instrumentation boundary: {old}'
    return source.replace(old, new)


def instrument_c(name, source):
    assert name in PROGRAMS
    source = '#define _POSIX_C_SOURCE 200809L\n#include <stdlib.h>\n' + source
    source = replace_once(source, 'int main(void) {', C_CLOCK + '\nint main(void) {\n    phase_mark(0, 0);')
    result = 'acc' if name == 'loop' else 'total'
    source = replace_once(source, '    printf("%" PRId64 "\\n", ' + result + ');',
                          '    phase_mark(1, (uint64_t)' + result + ');\n    printf("%" PRId64 "\\n", ' + result + ');')
    return replace_once(source, '    return 0;\n}',
                        '    if (fflush(stdout)) _Exit(246);\n    phase_mark(2, 0);\n    phase_report(3);\n    return 0;\n}')


def instrument_rust(name, source):
    assert name in PROGRAMS
    source = 'use std::hint::black_box;\nuse std::io::{self, Write};\nuse std::time::Instant;\n\n' + source
    source = replace_once(source, 'fn main() {', 'fn main() {\n    let phase_start = Instant::now();')
    print_line = '    println!("{}", acc);' if name == 'loop' else '    println!("{total}");'
    result = 'acc' if name == 'loop' else 'total'
    replacement = ('    let _ = black_box(' + result + ');\n    let phase_compute = phase_start.elapsed().as_nanos();\n'
                   + print_line + '\n    io::stdout().flush().expect("phase stdout flush");\n'
                   '    let phase_end = phase_start.elapsed().as_nanos();\n'
                   '    eprintln!("{{\\"marksNs\\":[0,{phase_compute},{phase_end}]}}");')
    return replace_once(source, print_line, replacement)


def instrument_fwp(source):
    source = replace_once(source, 'typedef uint64_t V;', 'typedef uint64_t V;\n' + C_CLOCK)
    source = replace_once(source, 'static V fwp_print_integer(V value, int is_signed) {',
                          'static V fwp_print_integer(V value, int is_signed) {\n    phase_mark(3, value);')
    start = source.index('static V fwp_print_integer(')
    end = source.index('\n}', start) + 2
    body = replace_once(source[start:end], '    return FWP_UNIT;',
                        '    if (fflush(fwp_prog_out)) _Exit(246);\n    phase_mark(4, 0);\n    return FWP_UNIT;')
    source = source[:start] + body + source[end:]
    source = replace_once(source, 'static void *fwp_main_thread(void *arg) {\n    (void)arg;',
                          'static void *fwp_main_thread(void *arg) {\n    (void)arg;\n    phase_mark(1, 0);')
    source = replace_once(source, '    fwp_init_consts();\n    V r = caf0();',
                          '    fwp_init_consts();\n    phase_mark(2, 0);\n    V r = caf0();\n    phase_mark(5, r);')
    source = replace_once(source, '    fflush(stdout);\n    return 0;\n}\n\n#ifdef _WIN32\nstatic DWORD',
                          '    fflush(stdout);\n    phase_mark(6, 0);\n    return 0;\n}\n\n#ifdef _WIN32\nstatic DWORD')
    source = replace_once(source, 'int main(int argc, char **argv) {',
                          'int main(int argc, char **argv) {\n    phase_mark(0, 0);')
    return replace_once(source, '    fflush(stdout);\n    return fwp_exit_code;',
                        '    fflush(stdout);\n    phase_mark(7, 0);\n    phase_report(8);\n    return fwp_exit_code;')


def phase_durations(language, process):
    data = json.loads(process['stderr'])
    assert set(data) == {'marksNs'}
    marks = data['marksNs']
    assert len(marks) == len(LABELS[language]) + 1
    assert all(type(value) is int and value >= 0 for value in marks)
    assert all(a <= b for a, b in zip(marks, marks[1:]))
    elapsed = marks[-1] - marks[0]
    assert elapsed <= process['seconds'] * 1e9, 'internal clock exceeds whole-process time'
    return dict(zip(LABELS[language], [b - a for a, b in zip(marks, marks[1:])], strict=True))


def check_case(name, row, settings, budget):
    assert settings == SETTINGS and row['stdout'] == EXPECTED[name]
    assert set(row['binaries']) == set(KINDS)
    for language in LANGUAGES:
        assert row['binaries'][language] == row['binaries'][language + '-identical']
    for binary in row['binaries'].values():
        assert re.fullmatch('[0-9a-f]{64}', binary['sha256']) and binary['bytes'] > 0
    observations = row['observations']
    assert len(observations) == 9 * (SETTINGS['samples'] + SETTINGS['warmups'])
    times = {kind: [] for kind in KINDS}
    phases = {language: {label: [] for label in LABELS[language]} for language in LANGUAGES}
    residual = {language: [] for language in LANGUAGES}
    for index, observation in enumerate(observations):
        round_index, position = divmod(index, 9)
        warmup = round_index < SETTINGS['warmups']
        phase_round = round_index if warmup else round_index - SETTINGS['warmups']
        kind = KINDS[(phase_round + position) % 9]
        assert (observation['kind'], observation['phase'], observation['round']) == (kind, 'warmup' if warmup else 'sample', phase_round)
        assert observation['binarySha256'] == row['binaries'][kind]['sha256']
        processes = observation['processes']
        assert len(processes) == SETTINGS['processes'][name]
        for process in processes:
            assert process['status'] == 0 and process['stdout'] == EXPECTED[name]
            assert math.isfinite(process['seconds']) and process['seconds'] > 0
            if kind.endswith('-phases'):
                language = kind.removesuffix('-phases')
                durations = phase_durations(language, process)
                if not warmup:
                    for label, value in durations.items():
                        phases[language][label].append(value)
                    residual[language].append(process['seconds'] * 1e9 - sum(durations.values()))
            else:
                assert not process['stderr']
        assert observation['seconds'] == sum(p['seconds'] for p in processes)
        if not warmup:
            times[kind].append(observation['seconds'])
    medians = {kind: statistics.median(values) for kind, values in times.items()}
    controls = {}
    for language in LANGUAGES:
        pair = language + '-identical'
        ratios = sorted(max(a, b) / min(a, b) for a, b in zip(times[language], times[pair], strict=True))
        controls[language] = dict(medianRatio=max(medians[language], medians[pair]) / min(medians[language], medians[pair]),
                                  pairRatio95=ratios[math.ceil(0.95 * SETTINGS['samples']) - 1])
    control = controls['fwp']
    return dict(medianBatchSeconds=medians, identicalCodeControls=controls,
                fwpControl='stable' if control['medianRatio'] <= 1.03 and control['pairRatio95'] <= budget['maxControlPairRatio'] else 'inconclusive',
                diagnosticOverOrdinary={k: medians[k + '-phases'] / medians[k] for k in LANGUAGES},
                medianPhaseNs={k: {label: statistics.median(v) for label, v in values.items()} for k, values in phases.items()},
                medianUnaccountedWallNs={k: statistics.median(v) for k, v in residual.items()},
                caution='Diagnostic code and flushing differ from ordinary images. C/Rust startup and exit work are unobserved. Residual includes process/launcher work and diagnostic reporting. Individual phase medians are not additive. No speedup or causal overhead claim follows from these observations alone.')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')


def qualification(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.architecture
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    cpu = {r['field']: r['data'] for r in json.loads(subprocess.check_output(['lscpu', '-J'], text=True))['lscpu']}
    host = dict(model=cpu['Model name:'], vendor=cpu['Vendor ID:'], architecture=cpu['Architecture:'], allowedCpuCount=len(os.sched_getaffinity(0)))
    compilers = [subprocess.check_output([args.cc, '--version'], text=True).strip(),
                 subprocess.check_output([args.rustc, '-vV'], text=True).strip()]
    inputs = {name: {kind: digest(ROOT / f'bench/{name}/main.{kind}') for kind in LANGUAGES} for name in PROGRAMS}
    return dict(source=args.source, architecture=args.architecture, run=int(os.environ['GITHUB_RUN_ID']),
                host=host, compilers=compilers, inputs=inputs, tableSha256=digest(args.table))


def measure(args):
    report = qualification(args)
    assert json.loads(args.qualification.read_text()) == report, 'host or inputs changed after qualification'
    budgets = BOUNDS.qualify(json.loads(args.table.read_text()), report['host'], report['compilers'], report['inputs'])
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    inspection = json.loads(args.inspection.read_text())
    memory = json.loads((args.memory / 'report.json').read_text())
    memory_inspection = json.loads(args.memory_inspection.read_text())
    assert all(r['source'] == args.source and r['architecture'] == args.architecture for r in (inspection, memory, memory_inspection))
    assert inspection['ownership'] == memory['ownership'] == 'counted'
    assert memory['inspectionSha256'] == digest(args.inspection)
    assert memory_inspection['reportSha256'] == digest(args.memory / 'report.json')
    directory, = (args.input / args.source).iterdir()
    assert digest(directory / 'report.md') == inspection['reportSha256']
    report.update(settings=SETTINGS, programs={}, commands=[],
                  evidence=dict(inspection=digest(args.inspection), memory=digest(args.memory / 'report.json'), memoryInspection=digest(args.memory_inspection)),
                  scope='Diagnostic clock boundaries and explicit stdout flushing change the programs. Ordinary whole-process timing is retained separately. Phase durations are diagnostic observations, not accepted optimization measurements. Timed C diagnostic images have stack reports; ordinary fwp profiles are separately instrumented managed-storage builds.')
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', LC_ALL='C')

    def command(argv, label):
        argv = list(map(str, argv))
        actual = subprocess.run(argv, env=environment, capture_output=True, timeout=120)
        (args.output / (label + '.stdout')).write_bytes(actual.stdout)
        (args.output / (label + '.stderr')).write_bytes(actual.stderr)
        report['commands'].append(dict(argv=argv, status=actual.returncode, stdout=label + '.stdout', stderr=label + '.stderr'))
        write_json(args.output / 'report.json', report)
        assert actual.returncode == 0, (argv, actual.stderr.decode(errors='replace'))
        return actual

    for name in PROGRAMS:
        original, = [p for p in inspection['programs'] if p['name'] == name]
        mem, = [p for p in memory['programs'] if p['name'] == name]
        assert original['stdout'] == EXPECTED[name]
        generated = directory / (name + '-generated.c')
        assert digest(generated) == original['generatedCSha256']
        paths = {}
        details = {}
        for language in LANGUAGES:
            ordinary = directory / (name + '-' + language)
            assert digest(ordinary) == original['files'][language]['binarySha256']
            source = directory / (name + '-source.' + language)
            assert digest(source) == report['inputs'][name][language] == original['files'][language]['sourceSha256']
            paths[language] = paths[language + '-identical'] = ordinary.resolve()
            diagnostic = args.output / (name + '-' + language + '-phases.exe')
            diagnostic_source = diagnostic.with_suffix('.rs' if language == 'rs' else '.c')
            if language == 'rs':
                diagnostic_source.write_text(instrument_rust(name, source.read_text()))
                argv = [args.rustc, '--edition=2021', '--crate-name', 'cpu_phase_probe', '-O', diagnostic_source, '-o', diagnostic]
            else:
                text = instrument_fwp(generated.read_text()) if language == 'fwp' else instrument_c(name, source.read_text())
                diagnostic_source.write_text(text)
                argv = [args.cc, '-O2', '-std=gnu11' if language == 'fwp' else '-std=c11', '-ffp-contract=off', '-fstack-usage',
                        '-w', diagnostic_source, '-o', diagnostic, '-lm', '-lpthread', '-ldl']
            command(argv, name + '-' + language + '-compile')
            paths[language + '-phases'] = diagnostic
            for kind, path in [(language, ordinary), (language + '-phases', diagnostic)]:
                image = path.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert struct.unpack_from('<H', image, 18)[0] == {'aarch64': 183, 'x86_64': 62}[args.architecture]
                assert struct.unpack_from('<Q', image, 24)[0] != 0
                symbols = command([args.objdump, '--section-headers', '--syms', path], name + '-' + kind + '-symbols').stdout
                command([args.objdump, '-d', path], name + '-' + kind + '-assembly')
                sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
                assert len(sections) == 1
                details[kind] = dict(textBytes=int(sections[0], 16))
            details[language + '-phases']['sourceSha256'] = digest(diagnostic_source)
        # Check the C clock observer itself: a missing boundary must fail even
        # when the calculation and stdout are otherwise correct.
        source = (args.output / (name + '-fwp-phases.c')).read_text()
        missing = replace_once(source, '    phase_mark(2, 0);', '    /* omitted boundary */')
        missing_source = args.output / (name + '-missing-mark.c')
        missing_binary = args.output / (name + '-missing-mark.exe')
        missing_source.write_text(missing)
        command([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', missing_source, '-o', missing_binary, '-lm', '-lpthread', '-ldl'], name + '-missing-compile')
        broken = subprocess.run([str(missing_binary)], env=environment, capture_output=True, text=True, timeout=120)
        write_json(args.output / (name + '-missing-mark.json'), dict(status=broken.returncode, stdout=broken.stdout, stderr=broken.stderr,
                   sourceSha256=digest(missing_source), binarySha256=digest(missing_binary)))
        assert broken.returncode == 246 and broken.stdout == EXPECTED[name] and not broken.stderr
        row = dict(stdout=EXPECTED[name], binaries={kind: dict(sha256=digest(path), bytes=path.stat().st_size) for kind, path in paths.items()},
                   code=details, observations=[], ordinaryMemory=mem,
                   diagnosticStack={p.name: p.read_text() for p in args.output.glob(name + '-*-phases*.su')})
        assert len(row['diagnosticStack']) == 2  # Actual timed C/fwp diagnostic images; no Rust stack claim.
        report['programs'][name] = row
        for phase, rounds in [('warmup', SETTINGS['warmups']), ('sample', SETTINGS['samples'])]:
            for index in range(rounds):
                for position in range(9):
                    kind = KINDS[(index + position) % 9]
                    observation = dict(kind=kind, phase=phase, round=index, binarySha256=row['binaries'][kind]['sha256'], processes=[], seconds=0)
                    row['observations'].append(observation)
                    for process_index in range(SETTINGS['processes'][name]):
                        start = time.perf_counter()
                        try:
                            result = subprocess.run([str(paths[kind])], env=environment, capture_output=True, text=True, timeout=SETTINGS['timeout'])
                        except subprocess.TimeoutExpired as error:
                            write_json(args.output / 'report.json', report)
                            write_json(args.output / 'timeout.json', dict(name=name, kind=kind, phase=phase, round=index, process=process_index,
                                       stdout=(error.stdout or b'').decode(errors='replace'), stderr=(error.stderr or b'').decode(errors='replace')))
                            raise
                        elapsed = time.perf_counter() - start
                        process = dict(seconds=elapsed, status=result.returncode, stdout=result.stdout, stderr=result.stderr)
                        observation['processes'].append(process)
                        observation['seconds'] += elapsed
                        try:
                            assert result.returncode == 0 and result.stdout == EXPECTED[name]
                            if kind.endswith('-phases'):
                                phase_durations(kind.removesuffix('-phases'), process)
                            else:
                                assert not result.stderr
                        except (AssertionError, ValueError):
                            write_json(args.output / 'report.json', report)
                            raise
                    write_json(args.output / 'report.json', report)
        row['result'] = check_case(name, row, SETTINGS, budgets[name])
        write_json(args.output / 'report.json', report)
        print(name, json.dumps(row['result'], indent=2), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='command', required=True)
    for name in ('qualify', 'measure'):
        command_parser = commands.add_parser(name)
        command_parser.add_argument('--source', required=True)
        command_parser.add_argument('--architecture', choices=['aarch64', 'x86_64'], required=True)
        command_parser.add_argument('--cc', required=True)
        command_parser.add_argument('--rustc', required=True)
        command_parser.add_argument('--table', type=Path, required=True)
        command_parser.add_argument('--output', type=Path, required=True)
        if name == 'measure':
            for path in ('input', 'inspection', 'memory', 'memory-inspection', 'qualification'):
                command_parser.add_argument('--' + path, type=Path, required=True)
            command_parser.add_argument('--objdump', required=True)
    args = parser.parse_args()
    if args.command == 'qualify':
        record = qualification(args)
        assert not args.output.exists(), 'preserve original host observations'
        args.output.parent.mkdir(parents=True, exist_ok=True)
        write_json(args.output, record)
        BOUNDS.qualify(json.loads(args.table.read_text()), record['host'], record['compilers'], record['inputs'])
    else:
        measure(args)


if __name__ == '__main__':
    main()
