#!/usr/bin/env python3
"""Attribute compiler phases on maintained programs without timing their execution."""
import argparse
import json
import os
from pathlib import Path
import platform
import subprocess
import time
import traceback

from compiler_scaling import APPLICATIONS, ROOT, digest, phase_totals, profile, resources
from process_wait import run_capture


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--ordinary-compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'run compiler observations on GitHub runners'
    assert platform.system() == 'Linux' and platform.machine() in ('aarch64', 'x86_64')
    assert 0 < args.deadline <= 120
    compiler = args.compiler.resolve()
    ordinary_compiler = args.ordinary_compiler.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', LC_ALL='C')
    identity = {
        'source': subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        'compilerSha256': digest(compiler),
        'ordinaryCompilerSha256': digest(ordinary_compiler),
        'machine': platform.machine(),
        'rustVersion': subprocess.check_output(['rustc', '-Vv'], text=True),
        'cc': args.cc,
        'ccVersion': subprocess.check_output([args.cc, '--version'], text=True),
        'topology': subprocess.check_output(['lscpu'], text=True),
        'kernel': platform.platform(),
        'affinity': sorted(os.sched_getaffinity(0)),
        'deadlineSeconds': args.deadline,
        'scope': 'One ordinary and one observed fresh-process emit-C build per maintained application, '
                 'using its original main and import location. Exact C equality is checked. '
                 'No C compilation or application execution; no paired timing or speedup claim. '
                 'GNU time reports process high-water RSS, not per-phase memory.',
    }
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')
    summary = {'identity': identity, 'applications': {}, 'failures': []}
    for name, relative in APPLICATIONS.items():
        source = ROOT / relative
        directory = output / name
        directory.mkdir()
        case = {'source': relative, 'correct': False, 'commands': {}}
        summary['applications'][name] = case
        try:
            text = source.read_bytes()
            (directory / 'input.fwp').write_bytes(text)
            case.update(sourceSha256=digest(source), sourceBytes=len(text))
            for observed in (False, True):
                role = 'observed' if observed else 'ordinary'
                cfile = directory / (role + '.c')
                report = directory / (role + '.json')
                usage = directory / (role + '.resources')
                command = [str(compiler if observed else ordinary_compiler), 'build', '--target', 'native', '--emit-c', '-O2',
                           str(source), '-o', str(cfile)]
                if observed:
                    command += ['--profile-compile', str(report)]
                row = {'command': command}
                case['commands'][role] = row
                start = time.perf_counter_ns()
                try:
                    result = run_capture([str(args.time), '-v', '-o', str(usage), *command],
                        env=environment, cwd=ROOT, input_data=None, input_stream=subprocess.DEVNULL,
                        text=False, encoding='utf-8', timeout=args.deadline, check=False)
                    row.update(elapsedNs=time.perf_counter_ns() - start, status=result.returncode,
                               timedOut=False)
                    (directory / (role + '.stdout')).write_bytes(result.stdout)
                    (directory / (role + '.stderr')).write_bytes(result.stderr)
                    row.update(resources(usage.read_text()))
                    assert result.returncode == 0 and not result.stdout and not result.stderr, row
                    row.update(cSha256=digest(cfile), cBytes=cfile.stat().st_size)
                    if observed:
                        report_data = profile(report, 0)
                        if 'type_walk_counts' in report_data:
                            counts = report_data['type_walk_counts']
                            assert set(counts) == {'type_clones', 'free_vars_clones', 'zonk_clones', 'free_vars_visits', 'zonk_visits'}
                            assert all(type(value) is int and value >= 0 for value in counts.values())
                            assert counts['free_vars_clones'] <= counts['type_clones']
                            assert counts['zonk_clones'] <= counts['type_clones']
                            row['typeWalkCounts'] = counts
                        row['phases'] = phase_totals(report_data)
                        assert 'type-check-library-group' in row['phases']
                        phases = row['phases']
                        group_names = ('type-check-library-group', 'type-check-user-group',
                                       'type-check-mixed-group')
                        assert sum(phases.get(k, {}).get('counts', {}).get('bindings', 0)
                                   for k in group_names) == phases['type-check']['counts']['bindings']
                        parts = {name: {} for name in group_names if name in phases}
                        events = report_data['phases']
                        for event in events:
                            parent = event['parent']
                            if parent is not None and events[parent]['phase'] in parts:
                                group = parts[events[parent]['phase']]
                                group[event['phase']] = group.get(event['phase'], 0) + event['inclusive_ns']
                        for group_name, group in parts.items():
                            group['group-setup-and-cleanup'] = phases[group_name]['exclusiveNs']
                            assert sum(group.values()) == phases[group_name]['inclusiveNs']
                        row['checkingPartsNs'] = parts
                except subprocess.TimeoutExpired as error:
                    row.update(elapsedNs=time.perf_counter_ns() - start, status=124, timedOut=True)
                    (directory / (role + '.stdout')).write_bytes(error.stdout or b'')
                    (directory / (role + '.stderr')).write_bytes(error.stderr or b'')
                    summary['failures'].append(f'{name}/{role}: compiler exceeded {args.deadline}s')
                except Exception as error:
                    row['error'] = str(error)
                    summary['failures'].append(f'{name}/{role}: {traceback.format_exc()}')
            rows = case['commands']
            if all('cSha256' in rows[r] and 'error' not in rows[r] and not rows[r]['timedOut']
                   for r in ('ordinary', 'observed')):
                assert (directory / 'ordinary.c').read_bytes() == (directory / 'observed.c').read_bytes(), 'observer changed C'
                case['correct'] = True
        except Exception as error:
            case['error'] = str(error)
            summary['failures'].append(f'{name}: {traceback.format_exc()}')
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
        print(f'{name}: {"pass" if case["correct"] else "fail"}', flush=True)
    if summary['failures']:
        raise RuntimeError('\n'.join(summary['failures']))
    assert len(summary['applications']) == len(APPLICATIONS)
    print('All four maintained programs preserve C; phase observations retained, programs not executed')


if __name__ == '__main__':
    main()
