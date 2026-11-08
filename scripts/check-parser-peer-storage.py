#!/usr/bin/env python3
"""Observe native parser allocation transitions and verify ordinary Rust frames."""
import argparse
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import shutil
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
MEASURE_SPEC = importlib.util.spec_from_file_location('parser_measure', ROOT / 'scripts/measure-parser-workspace.py')
MEASURE = importlib.util.module_from_spec(MEASURE_SPEC)
MEASURE_SPEC.loader.exec_module(MEASURE)
FRAME_SPEC = importlib.util.spec_from_file_location('buffer_frames', ROOT / 'scripts/prepare-buffer-baselines.py')
FRAMES = importlib.util.module_from_spec(FRAME_SPEC)
FRAME_SPEC.loader.exec_module(FRAMES)
CASES = (('small', 5, False), ('medium', 9, False), ('large', 13, False), ('left', 64, True))


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def replace_once(text, before, after):
    assert text.count(before) == 1, ('changed parser boundary', before)
    return text.replace(before, after)


def instrument(language, source, observer):
    if language == 'c':
        source = replace_once(source, 'static uint64_t now(void) {', observer + '\nstatic uint64_t now(void) {')
        source = replace_once(source, '        uint64_t begin = now();',
                              '        parser_storage_begin();\n        uint64_t begin = now();')
        return replace_once(source, '        uint64_t released = now();',
                            '        uint64_t released = now();\n        parser_storage_finish();')
    source = replace_once(source, '#[derive(Clone, Copy)]', observer + '\n#[derive(Clone, Copy)]')
    source = replace_once(source, '        let begin = Instant::now();',
                          '        let _parser_storage_scope = parser_storage_begin();\n        let begin = Instant::now();')
    return replace_once(source, '        let released = Instant::now();',
                        '        let released = Instant::now();\n        parser_storage_finish();')


def expected_storage(nodes, omitted):
    # The actual peers grow two separate vectors, starting with eight entries.
    # Tokens are built first; tree construction then appends nodes in postorder.
    events = []
    capacities = []
    for stride in (16, 24):
        capacity = 0
        while capacity < nodes:
            following = 8 if capacity == 0 else capacity * 2
            events.append([capacity * stride, following * stride])
            capacity = following
        capacities.append(capacity * stride)
    if not omitted:
        events.append([capacities[1], 0])
    events.append([capacities[0], 0])
    live = peak = requests = requested = 0
    for before, after in events:
        assert live >= before
        live += after - before
        peak = max(peak, live)
        requests += after != 0
        requested += after
    return dict(requests=requests, requestedBytes=requested, peakLiveBytes=peak,
                finalLiveBytes=live, events=events)


def check_observation(row, nodes, expected, rounds, omitted):
    assert row['status'] == (78 if omitted else 0), row
    profiles = [json.loads(line) for line in row['stderr'].splitlines()]
    assert len(profiles) == (1 if omitted else rounds)
    for profile in profiles:
        assert profile == expected_storage(nodes, omitted), profile
    if omitted:
        assert row['stdout'] == ''
    else:
        output = json.loads(row['stdout'])
        assert (output['nodes'], output['result'], output['rounds']) == (nodes, expected, rounds)
        assert output['allocations'] == profiles[0]['requests']
        assert output['nodeCapacityBytes'] + output['tokenCapacityBytes'] == profiles[0]['peakLiveBytes']
    return profiles


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'rustc', 'c-arch', 'rust-cpu', 'objcopy', 'source', 'arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'native evidence collection runs on GitHub'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.source == os.environ['GITHUB_SHA']
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[args.arch]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[args.arch]
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD')}
    environment['LC_ALL'] = 'C'
    commands = []

    def run(command):
        command = list(map(str, command))
        try:
            result = run_capture(command, timeout=90, env=environment, cwd=ROOT,
                                 input_data=None, input_stream=None, text=True,
                                 encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or '', error.stderr or ''
            if isinstance(stdout, bytes):
                stdout = stdout.decode('utf-8', errors='replace')
            if isinstance(stderr, bytes):
                stderr = stderr.decode('utf-8', errors='replace')
            row = dict(command=command, status=None, timedOut=True, stdout=stdout, stderr=stderr)
        else:
            row = dict(command=command, status=result.returncode, timedOut=False,
                       stdout=result.stdout, stderr=result.stderr)
        commands.append(row)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        assert not row['timedOut'], row
        return row

    identity = run(['git', 'rev-parse', 'HEAD'])
    assert identity['status'] == 0 and identity['stdout'].strip() == args.source and not identity['stderr']
    report = dict(source=args.source, architecture=args.arch, versions={}, images={}, cases={}, frames={}, controls={})
    for name in ('cc', 'rustc'):
        version = run([getattr(args, name), '--version'])
        assert version['status'] == 0 and not version['stderr']
        report['versions'][name] = version['stdout']
    for language in ('c', 'rs'):
        original = ROOT / f'tests/fixtures/parser_arena_peer.{language}'
        observer = ROOT / f'tests/fixtures/parser_arena_storage.{language}'
        source = original.read_text()
        shutil.copyfile(observer, out / observer.name)
        for variant in ('ordinary', 'profile', 'omitted'):
            path = out / f'parser_{language}_{variant}.{language}'
            path.write_text(source if variant == 'ordinary' else instrument(language, source, observer.read_text()))
            binary = path.with_suffix('.exe')
            if language == 'c':
                command = [args.cc, '-std=gnu11', '-O2', '-ffp-contract=off', '-fno-fast-math',
                           '-fno-lto', '-fstack-usage', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror']
                if variant == 'omitted':
                    command += ['-DPARSER_STORAGE_OMIT_RELEASE']
            else:
                command = [args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                           '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=0',
                           '-C', 'panic=unwind', '-C', 'target-cpu=' + args.rust_cpu]
                if variant == 'omitted':
                    command += ['--cfg', 'parser_storage_omit_release']
            command += [path, '-o', binary]
            result = run(command)
            assert result['status'] == 0 and not result['stdout'] and not result['stderr'], result
            image = binary.read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[args.arch]
            report['images'][f'{language}-{variant}'] = dict(sha256=digest(binary), bytes=len(image))
            if language == 'rs' and variant == 'ordinary':
                stack_binary = out / 'parser_rs_stack.exe'
                stack = run(command[:-1] + [stack_binary, '-C', 'remark=prolog-epilog', '--error-format=json'])
                assert stack['status'] == 0 and not stack['stdout'], stack
                report['frames']['rust'] = FRAMES.rust_frames(stack['stderr'], 'prolog-epilog')
                (out / 'rust-stack.jsonl').write_text(stack['stderr'])
                sections = []
                for executable in (binary, stack_binary):
                    before = digest(executable)
                    section = executable.with_suffix('.text')
                    inspected = executable.with_suffix('.inspected')
                    extracted = run([args.objcopy, '--dump-section', f'.text={section}', executable, inspected])
                    assert extracted['status'] == 0 and not extracted['stdout'] and not extracted['stderr'], extracted
                    assert digest(executable) == before, 'inspection changed its input'
                    sections.append(section.read_bytes())
                assert sections[0] == sections[1], 'stack-report build changed ordinary instructions'
            if language == 'c' and variant == 'ordinary':
                usage, = out.glob(binary.stem + '*.su')
                report['frames']['c'] = FRAMES.c_frames(usage.read_text())
    for name, text, nodes, expected in (
        ('multiply', '* + 2 3 + 4 5', 7, 45), ('negative', '-7', 1, -7),
        ('minimum', '-9223372036854775808', 1, -9223372036854775808),
        ('missing', '+ 1', 3, None), ('trailing', '1 2', 1, None),
        ('invalid', 'invalid', 1, None),
        ('add-overflow', '+ 9223372036854775807 1', 3, None),
        ('mul-overflow', '* 9223372036854775807 2', 3, None),
    ):
        path = out / f'control-{name}.txt'
        path.write_text(text)
        controls = {}
        for language in ('c', 'rs'):
            for variant in ('ordinary', 'profile'):
                row = run([out / f'parser_{language}_{variant}.exe', path, '1',
                           str(expected if expected is not None else 0), str(nodes)])
                if expected is None:
                    status = 101 if language == 'rs' or name.endswith('-overflow') else 92
                    assert row['status'] == status and not row['stdout'], row
                elif variant == 'profile':
                    check_observation(row, nodes, expected, 1, False)
                else:
                    assert row['status'] == 0 and not row['stderr'], row
                    output = json.loads(row['stdout'])
                    assert (output['result'], output['nodes']) == (expected, nodes)
                controls[f'{language}-{variant}'] = len(commands) - 1
        report['controls'][name] = controls
    # Reproduce the first observer's scope error: an outer owner can be freed
    # while measurement is active, especially during an error unwind.
    observer = (ROOT / 'tests/fixtures/parser_arena_storage.rs').read_text()
    broken = replace_once(observer,
        '            STORAGE_SIZES[slot].store(0, Ordering::SeqCst);\n        }\n        System.dealloc(pointer, layout);',
        '            STORAGE_SIZES[slot].store(0, Ordering::SeqCst);\n'
        '        } else if STORAGE_ACTIVE.load(Ordering::SeqCst) {\n'
        '            parser_storage_event(layout.size(), 0);\n'
        '        }\n        System.dealloc(pointer, layout);')
    control_main = r'''
fn main() {
    let mode = std::env::args().nth(1).expect("expected outside or unwind");
    assert!(mode == "outside" || mode == "unwind");
    let outside = std::hint::black_box(vec![7u8; 1024]);
    {
        let _scope = parser_storage_begin();
        drop(outside);
        parser_storage_finish();
    }
    if mode == "unwind" {
        let failed = std::panic::catch_unwind(|| {
            let _scope = parser_storage_begin();
            let inside = std::hint::black_box(vec![3u8; 64]);
            assert_eq!(inside[0], 3);
            panic!("expected observer unwind control");
        });
        assert!(failed.is_err());
        drop(failed);
        assert!(!STORAGE_ACTIVE.load(Ordering::SeqCst));
    }
    println!("{} scope checked", mode);
}
'''
    report['observerControls'] = {}
    for variant, template in (('ordinary', observer), ('untracked-free', broken)):
        path = out / f'observer_{variant.replace("-", "_")}.rs'
        path.write_text(template + control_main)
        binary = path.with_suffix('.exe')
        built = run([args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                     '-C', 'lto=off', '-C', 'panic=unwind', '-C', 'target-cpu=' + args.rust_cpu,
                     path, '-o', binary])
        assert built['status'] == 0 and not built['stdout'] and not built['stderr'], built
        for mode in (('outside', 'unwind') if variant == 'ordinary' else ('outside',)):
            row = run([binary, mode])
            if variant == 'untracked-free':
                assert row['status'] == -6 and not row['stdout'], row
            else:
                assert row['status'] == 0 and row['stdout'] == f'{mode} scope checked\n', row
                first, rest = row['stderr'].split('\n', 1)
                assert json.loads(first) == dict(requests=0, requestedBytes=0, peakLiveBytes=0,
                                                finalLiveBytes=0, events=[])
                if mode == 'outside':
                    assert not rest, rest
                else:
                    assert 'expected observer unwind control' in rest, rest
            report['observerControls'][variant + '-' + mode] = len(commands) - 1
    rejected = 0
    for name, depth, left in CASES:
        text, nodes, expected = MEASURE.input_case(depth, left)
        path = out / (name + '.txt')
        path.write_text(text)
        observations = {}
        for language in ('c', 'rs'):
            ordinary = run([out / f'parser_{language}_ordinary.exe', path, '3', str(expected), str(nodes)])
            assert ordinary['status'] == 0 and not ordinary['stderr'], ordinary
            output = json.loads(ordinary['stdout'])
            assert (output['result'], output['nodes'], output['rounds']) == (expected, nodes, 3)
            for omitted in (False, True):
                variant = 'omitted' if omitted else 'profile'
                row = run([out / f'parser_{language}_{variant}.exe', path, '3', str(expected), str(nodes)])
                observations[f'{language}-{variant}'] = check_observation(row, nodes, expected, 3, omitted)
                if not omitted:
                    for change in ('missing', 'doubled', 'count', 'release'):
                        damaged = copy.deepcopy(row)
                        profiles = [json.loads(line) for line in row['stderr'].splitlines()]
                        first = profiles[0]
                        if change == 'missing':
                            first['events'].pop(0)
                        elif change == 'doubled':
                            first['events'].insert(0, first['events'][0])
                        elif change == 'count':
                            first['requests'] += 1
                        else:
                            first['finalLiveBytes'] = 24
                        damaged['stderr'] = '\n'.join(map(json.dumps, profiles)) + '\n'
                        try:
                            check_observation(damaged, nodes, expected, 3, False)
                        except AssertionError:
                            rejected += 1
                        else:
                            raise AssertionError(('accepted damaged storage evidence', name, language, change))
        report['cases'][name] = dict(nodes=nodes, result=expected, observations=observations)
    assert rejected == 32
    report['rejectedEvidenceControls'] = rejected
    report['scope'] = 'Successful native allocation API transitions during parsing and cleanup; allocator internals, input loading, RSS and total recursive stack are not measured. Diagnostic timings are not performance evidence.'
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    manifest = {str(path.relative_to(out)): digest(path) for path in sorted(out.rglob('*')) if path.is_file()}
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('Four parser shapes: ordinary outputs, storage/release, 32 damaged records and Rust frame identity checked')


if __name__ == '__main__':
    main()
