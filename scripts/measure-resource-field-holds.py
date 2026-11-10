#!/usr/bin/env python3
"""Count executed plain-field lifetime holds in saved service C, without timing."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from nested_resource_counts import COUNTERS, MEMORY, decode, instrument
from process_wait import run_capture
from resource_field_census import HOLD_COUNTERS, observe_holds, validate_contexts
from weak_callback_service import CASES, unique_fields
from weak_callback_service_build import build_native
from weak_callback_source import boundary
from weak_callback_timing import decode_output

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch', 'cc', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    tool_source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert tool_source == os.environ['GITHUB_SHA']
    original = args.input.resolve() / 'resource-field-observations'
    census = json.loads((original / 'report.json').read_text())
    assert census['source'] == args.source and census['kind'] == 'plain-fields' and not census['failures']
    assert len(census['cases']) == 17
    case = census['cases']['exported-service']
    c = original / 'exported-service-ordinary.c'
    assert digest(c) == case['cSha256']
    assert c.read_bytes() == (original / 'exported-service-observed.c').read_bytes()
    source = c.read_text()
    assert validate_contexts(source, case['observations']) == case['totals']
    base = instrument(boundary(source))
    attributed, selected = observe_holds(base, case['observations'], False)
    extra, control_selected = observe_holds(base, case['observations'], True)
    assert control_selected == selected
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(toolSource=tool_source, compilerSource=args.source, architecture=args.arch,
                  host=platform.uname()._asdict(), selected=selected, cSha256=case['cSha256'],
                  scope='Untimed actual calls. Typed field releases include any child decrements.',
                  builds=[], cases={}, controls=[], failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, expected, environment):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=180, check=False)
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        except subprocess.TimeoutExpired as error:
            row = dict(status=None, stdout=str(error.stdout), stderr=str(error.stderr))
        row.update(command=command, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as stream:
            stream.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0], row
        for key, value in zip(('stdout', 'stderr'), expected[1:]):
            assert value is None or row[key] == value, row
        return row

    def failure(group):
        report['failures'].append(dict(group=group, error=traceback.format_exc()))
        save()

    report['ccVersion'] = run([args.cc, '--version'], (0, None, ''), env)['stdout']
    fixtures = ROOT / 'tests/fixtures'
    clock = folder / 'clock.o'
    run([args.cc, '-std=c11', '-O2', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror',
         '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
    caller = (fixtures / 'weak_callback_service_time.c').read_text()
    for level in (1, 2):
        for label, observed in (('baseline', base), ('attributed', attributed), ('extra-pair', extra)):
            try:
                binary, built = build_native(args, folder, 'fwp', observed, label, level,
                                             'diagnostic', False, clock, caller, run, env)
                image = binary.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                report['builds'].append(dict(level=level, label=label, path=str(binary.relative_to(folder)),
                                             sha256=digest(binary), command=built['index']))
            except Exception:
                failure(f'build/{level}/{label}')
                continue
            populations = CASES if label != 'extra-pair' else ((64, 0),)
            for population, mode in populations:
                key = f'O{level}/{label}/{population}-{mode}'
                try:
                    row = run([binary, population, mode, 1], (0, None, None), env)
                    decode_output(row['stdout'], population, mode, 1)
                    lines = row['stderr'].splitlines()
                    assert len(lines) == (1 if label == 'baseline' else 2), row
                    total = decode(lines[0])
                    entry = dict(command=row['index'], total=total)
                    if label != 'baseline':
                        prefix = 'FWP_PLAIN_HOLDS '
                        assert lines[1].startswith(prefix)
                        counts = json.loads(lines[1][len(prefix):], object_pairs_hook=unique_fields)
                        assert set(counts) == set(HOLD_COUNTERS)
                        assert all(type(value) is int and value >= 0 for value in counts.values())
                        assert counts['plainRetains'] <= counts['plainHolds']
                        assert counts['plainRetains'] <= total['retains']
                        assert counts['plainDecrements'] <= total['decrements']
                        entry['selected'] = counts
                    report['cases'][key] = entry
                    if label == 'attributed':
                        baseline = report['cases'][f'O{level}/baseline/{population}-{mode}']['total']
                        assert total == baseline, ('attribution changed actual work', key)
                        print('RESULT', key, json.dumps(entry['selected']), flush=True)
                    elif label == 'extra-pair':
                        prior = report['cases'][f'O{level}/attributed/{population}-{mode}']
                        delta = {key: total[key] - prior['total'][key] for key in (*COUNTERS, *MEMORY)}
                        assert all(delta[key] == 1 for key in ('dupCalls', 'retains', 'decrements')), delta
                        assert delta['dropCalls'] in (0, 1) and delta['releaseCalls'] in (0, 1), delta
                        assert delta['dropCalls'] + delta['releaseCalls'] == 1, delta
                        changed = {'dupCalls', 'retains', 'decrements', 'dropCalls', 'releaseCalls'}
                        assert all(value == 0 for key, value in delta.items() if key not in changed), delta
                        assert all(entry['selected'][key] == prior['selected'][key] + 1 for key in HOLD_COUNTERS)
                        report['controls'].append(dict(level=level, command=row['index'], delta=delta))
                except Exception:
                    failure(key)
                save()
    (folder / 'manifest.json').write_text(json.dumps(
        {str(path.relative_to(folder)): digest(path) for path in sorted(folder.rglob('*')) if path.is_file()}, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == 6 and len(report['cases']) == 34 and len(report['controls']) == 2


if __name__ == '__main__':
    main()
