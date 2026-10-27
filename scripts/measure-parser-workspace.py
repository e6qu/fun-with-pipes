#!/usr/bin/env python3
"""Measure actual scoped/counting parsers and explicit C/Rust indexed arenas."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess

ROOT = Path(__file__).resolve().parent.parent
BASELINE = '56d5aac63a9963ae6b16574f10d6dc3087a08d8a'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def input_case(depth, left):
    leaves = []

    def tree(level):
        if level == 1:
            value = len(leaves) % 17 - 8
            leaves.append(value)
            return str(value)
        return '+ ' + tree(level - 1) + ' ' + tree(1 if left else level - 1)

    text = tree(depth) + '\n'
    return text, len(leaves) * 2 - 1, sum(leaves)


def definition(code, name):
    pattern = r'/\* ' + re.escape(name) + r' :[^\n]*\*/\nstatic [^\n]+\([^\n]*\) \{\n.*?\n\}'
    matches = list(re.finditer(pattern, code, re.S))
    assert len(matches) == 1, (name, len(matches))
    return matches[0]


def instrument(code, region, profile):
    """Clock only top-level phase boundaries, including inlined evaluation."""
    entry = definition(code, 'calculate')
    if region:
        entry_id, = re.findall(r'static V (f\d+)\(', entry[0])
    else:
        # The counted scalar entry has an unboxed worker and an exported V
        # bridge. Time the same public bridge, not a guessed function shape.
        worker_id, = re.findall(r'static int64_t w(\d+)\(', entry[0])
        entry_id = 'f' + worker_id
        bridge = f'static V {entry_id}(V l0) {{ V r = (V)(int64_t)(w{worker_id}(l0)); return r; }}'
        assert code.count(bridge) == 1, bridge
    root_name = 'calculate'
    if region:
        root_name, = re.findall(r'/\* (calculate \[region \d+\]) :', code)
    root = definition(code, root_name)
    words = definition(code, 'words')
    words_id, = re.findall(r'static V (f\d+)\(', words[0])
    body = root[0]
    token_call = r'    V t\d+ = ' + words_id + r'\(l\d+\);'
    parse_call = r'    fwp_wr\d+ t\d+ = w\d+\(l\d+(?:, l\d+)?\);'
    for pattern, phase in [(token_call, 'token'), (parse_call, 'construct')]:
        calls = re.findall(pattern, body)
        assert len(calls) == 1, (phase, calls)
        call, = calls
        body = body.replace(call, f'    uint64_t {phase}_start = parser_now();\n{call}\n'
                            f'    parser_{phase}_ns += parser_now() - {phase}_start;')
    code = code[:root.start()] + body + code[root.end():]
    template = (ROOT / 'tests/fixtures/parser_workspace_timing.c').read_text()
    declarations, main = template.split('/* DECLARATIONS */')[1].split('/* MAIN */')
    code = code[:code.index('int main(')]
    code = code.replace('typedef uint64_t V;', 'typedef uint64_t V;\n' + declarations)
    if profile:
        charge = 'static inline void fwp_heap_charge(size_t bytes) {'
        assert code.count(charge) == 1
        code = code.replace(charge, charge + '\n    parser_heap_allocations++;')
    if region:
        start = 'static void fwp_region_release(void *context) {'
        code = code.replace(start, start + '\n    uint64_t release_start = parser_now();')
        end = '        block = next;\n    }\n}'
        assert code.count(end) == 1
        code = code.replace(end, '        block = next;\n    }\n'
                            '    parser_release_ns += parser_now() - release_start;\n}')
        if profile:
            changes = [
                ('        fwp_region_block *fresh =',
                 '        size_t before = fwp_heap.live;\n        fwp_region_block *fresh ='),
                ('        fresh->capacity = capacity;', '        fresh->capacity = capacity;\n'
                 '        parser_blocks++; parser_requested += sizeof(*fresh) + capacity;\n'
                 '        parser_rounded += fwp_heap.live - before;'),
                ('    return PTR(node);', '    parser_nodes++;\n    return PTR(node);'),
                ('        fwp_mem_free(block);',
                 '        parser_unused += block->capacity - block->used;\n        fwp_mem_free(block);'),
            ]
            for old, new in changes:
                assert code.count(old) == 1, old
                code = code.replace(old, new)
    main = main.replace('@entry@', entry_id)
    main = main.replace('@node_check@', 'if (parser_nodes != nodes * rounds) return 96;'
                        if region and profile else '')
    main = main.replace('@release_format@', '%" PRIu64 "' if region else 'null')
    main = main.replace('@release_argument@', 'parser_release_ns,' if region else '')
    return code + main


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', required=True, type=Path)
    parser.add_argument('--candidate', required=True, type=Path)
    parser.add_argument('--candidate-source', required=True)
    parser.add_argument('--analysis-report', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--cpu', required=True, type=int)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--rounds', required=True, type=int)
    parser.add_argument('--max-control-ratio', required=True, type=float)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert re.fullmatch('[0-9a-f]{40}', args.candidate_source)
    assert args.samples >= 6 and args.samples % 2 == 0 and args.warmups >= 1
    assert args.rounds >= 1024 and args.timeout > 0 and 1 < args.max_control_ratio < 2
    assert args.cpu in os.sched_getaffinity(0)
    args.output.mkdir(parents=True, exist_ok=False)
    shutil.copyfile(args.analysis_report, args.output / 'analysis.json')
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(LC_ALL='C', FWP_LTO='0', FWP_STACK='1', CC=args.cc)
    commands = []

    def run(command):
        command = list(map(str, command))
        commands.append(command)
        result = subprocess.run(command, capture_output=True, env=environment, timeout=args.timeout)
        assert result.returncode == 0, (command, result.returncode, result.stderr.decode(errors='replace'))
        assert not result.stderr, (command, result.stderr)
        return result.stdout

    assert run(['git', 'rev-parse', 'HEAD']).decode().strip() == args.candidate_source
    report = dict(source=args.candidate_source, baselineSource=BASELINE,
                  machine=platform.machine(), cpu=run(['lscpu']).decode(),
                  cc=run([args.cc, '--version']).decode(), rustc=run([args.rustc, '-Vv']).decode(),
                  settings={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()},
                  commands=commands, files={}, cases={}, compilation={}, failures=[],
                  compilerHashes={'baseline': digest(args.baseline), 'candidate': digest(args.candidate)},
                  generatedSettings={'memory': 'dynamic', 'FWP_LTO': '0', 'FWP_STACK': '1'})

    def save():
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-fstack-usage']
    fixture = (ROOT / 'tests/fixtures/parser_workspace.fwp').read_text().split('# This entry returns')[0]
    source = args.output / 'parser.fwp'
    source.write_text(fixture + '\nmain = \"+ 2 * 3 4\" | calculate | echo\n')
    for label, compiler in [('baseline', args.baseline), ('candidate', args.candidate)]:
        cfile = args.output / f'{label}-original.c'
        run([compiler, 'build', '--emit-c', '--memory', 'dynamic', '--fn', 'calculate', source, '-o', cfile])
        original = cfile.read_text()
        assert ('fwp_region region = {0};' in original) == (label == 'candidate')
        for profile in [False, True]:
            name = label + ('-profile' if profile else '')
            cfile = args.output / f'{name}.c'
            cfile.write_text(instrument(original, label == 'candidate', profile))
            run([args.cc, *flags, '-w', cfile, '-o', args.output / f'{name}.exe', '-lm', '-lpthread', '-ldl'])
    for language in ['c', 'rs']:
        original = ROOT / f'tests/fixtures/parser_arena_peer.{language}'
        copy = args.output / original.name
        shutil.copyfile(original, copy)
        binary = args.output / ('c.exe' if language == 'c' else 'rust.exe')
        if language == 'c':
            run([args.cc, *flags, '-Wall', '-Wextra', '-Werror', copy, '-o', binary])
        else:
            run([args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                 '-C', 'lto=off', '-D', 'warnings', copy, '-o', binary])
    shutil.copy2(args.output / 'baseline.exe', args.output / 'baseline-copy.exe')
    assert digest(args.output / 'baseline.exe') == digest(args.output / 'baseline-copy.exe')
    for path in sorted(args.output.iterdir()):
        if path.suffix in ('.exe', '.c', '.rs', '.su', '.fwp'):
            report['files'][path.name] = dict(sha256=digest(path), bytes=path.stat().st_size)
    report['peerControls'] = {}
    for name, text, nodes, expected in [
        ('multiply', '* + 2 3 + 4 5', 7, 45), ('negative', '-7', 1, -7),
        ('minimum', '-9223372036854775808', 1, -9223372036854775808),
        ('missing', '+ 1', 3, None), ('trailing', '1 2', 1, None),
        ('invalid', 'invalid', 1, None),
        ('add-overflow', '+ 9223372036854775807 1', 3, None),
        ('mul-overflow', '* 9223372036854775807 2', 3, None),
    ]:
        control = args.output / f'control-{name}.txt'
        control.write_text(text)
        results = {}
        for label in ['c', 'rust']:
            command = [str(args.output / f'{label}.exe'), str(control), '1', str(expected or 0), str(nodes)]
            commands.append(command)
            result = subprocess.run(command, capture_output=True, env=environment, timeout=args.timeout)
            results[label] = dict(status=result.returncode, stdout=result.stdout.decode(), stderr=result.stderr.decode())
            if expected is None:
                assert result.returncode != 0, (name, label)
            else:
                value = json.loads(result.stdout)
                assert result.returncode == 0 and not result.stderr
                assert value['result'] == expected and value['nodes'] == nodes
        report['peerControls'][name] = results
    report['analysis'] = json.loads((args.output / 'analysis.json').read_text())
    report['protocol'] = {str(path.relative_to(ROOT)): digest(path) for path in
                          [Path(__file__), ROOT / 'tests/fixtures/parser_workspace_timing.c',
                           ROOT / 'tests/fixtures/parser_workspace.fwp']}
    save()
    for case, depth, left in [('small', 5, False), ('medium', 9, False),
                              ('large', 13, False), ('left', 64, True)]:
        text, nodes, expected = input_case(depth, left)
        input_file = args.output / f'{case}.txt'
        input_file.write_text(text)
        rounds = args.rounds if case != 'large' else args.rounds // 16
        row = dict(nodes=nodes, depth=depth, result=expected, rounds=rounds,
                   inputSha256=digest(input_file), control=[], samples=[], profiles={})
        report['cases'][case] = row

        def sample(label, count):
            value = json.loads(run(['taskset', '--cpu-list', args.cpu,
                                    args.output / f'{label}.exe', input_file, count, expected, nodes]))
            assert value['rounds'] == count and value['result'] == expected and value['nodes'] == nodes
            assert value['totalNs'] > 0
            assert value['tokenizeNs'] + value['constructNs'] + value['walkAndReleaseNs'] == value['totalNs']
            if label.startswith(('baseline', 'candidate')):
                assert value['finalLiveBytes'] == 0
            return value

        for label in ['baseline-profile', 'candidate-profile', 'c', 'rust']:
            row['profiles'][label] = [sample(label, n) for n in [1, 16, 256]]
        for label in ['baseline', 'baseline-copy']:
            for _ in range(args.warmups):
                sample(label, rounds)
        for i in range(args.samples):
            order = ['baseline', 'baseline-copy'] if i % 2 == 0 else ['baseline-copy', 'baseline']
            row['control'].append({label: sample(label, rounds) for label in order})
        ratios = [p['baseline-copy']['totalNs'] / p['baseline']['totalNs'] for p in row['control']]
        noise = max(abs(r - 1) for r in ratios)
        row['controlEnvelope'] = noise
        row['allowedCandidateRatio'] = 1 + 2 * noise
        (args.output / f'budget-{case}.json').write_text(json.dumps(row, indent=2) + '\n')
        if 1 + noise > args.max_control_ratio:
            report['failures'].append(f'{case}: unstable identical-code timing control')
            save()
            continue
        labels = ['baseline', 'candidate', 'c', 'rust']
        for label in labels:
            for _ in range(args.warmups):
                sample(label, rounds)
        for i in range(args.samples):
            order = labels if i % 2 == 0 else labels[::-1]
            row['samples'].append({label: sample(label, rounds) for label in order})
        row['ratios'] = {label: statistics.median(p['candidate']['totalNs'] / p[label]['totalNs']
                         for p in row['samples']) for label in ['baseline', 'c', 'rust']}
        if row['ratios']['baseline'] > row['allowedCandidateRatio']:
            report['failures'].append(f'{case}: candidate exceeds the frozen timing budget')
        save()
    # Whole C-emission observations include frontend and emission, not just the
    # region pass. Both compilers are built by Rust with identical settings.
    definitions = fixture.split('# The graph is internal')[0]
    body = 'words | parse-expression | if (.1 | is-empty) (.0 | evaluate) (const "trailing input" | fail)'
    for count in [16, 32, 64]:
        scale = args.output / f'scale-{count}.fwp'
        scale.write_text(definitions + '\n' + '\n'.join(
            f'export job{n} : String -> I64 ! {{Error[String]}}\njob{n} = {body} | add {n}'
            for n in range(count)) + '\nmain = ()\n')
        observations = {}
        for label, compiler in [('baseline', args.baseline), ('candidate', args.candidate)]:
            samples = []
            for repeat in range(3):
                cfile = args.output / f'{label}-scale-{count}.c'
                stats = args.output / f'{label}-scale-{count}-{repeat}.time'
                run(['/usr/bin/time', '-f', '%e %M', '-o', stats, compiler, 'build', '--emit-c',
                     '--memory', 'dynamic', scale, '-o', cfile])
                seconds, rss = stats.read_text().split()
                samples.append(dict(seconds=float(seconds), maxRssKiB=int(rss)))
            code = cfile.read_text()
            observations[label] = dict(samples=samples, emittedBytes=cfile.stat().st_size,
                                       selectedEntries=code.count('fwp_region region = {0};'),
                                       sha256=digest(cfile))
        report['compilation'][str(count)] = observations
        save()
    assert not report['failures'], '\n'.join(report['failures'])
    print('Parser correctness, cleanup, peers, compiler observations and frozen timing budgets passed')


if __name__ == '__main__':
    main()
