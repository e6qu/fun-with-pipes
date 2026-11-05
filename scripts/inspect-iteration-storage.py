#!/usr/bin/env python3
"""Save typed IR and C for a declared final-iteration storage review on CI."""

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location(
    'ad_application', ROOT / 'scripts/measure-ad-application.py')
AD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AD)


def reachable_bodies(emitted):
    """Generated bodies actually reached by main, direct calls and closures."""
    program = emitted.split('/* ---- program ---- */', 1)[1]
    bodies = {}
    for match in re.finditer(
            r'^static [^\n]*?\b((?:f|w|e|fs)\d+|fwp_(?:loop_fields|hof)\d+)\([^;\n]*\) \{\n', program, re.M):
        end = program.index('\n}\n', match.end())
        bodies[match[1]] = program[match.end():end]
    main = re.search(r'/\* main : [^\n]*\*/\nstatic [^\n]*? ([fw]\d+)\(', program)
    assert main and main[1] in bodies, 'missing main body in saved C'
    pending, reached = [main[1]], set()
    while pending:
        name = pending.pop()
        if name in reached:
            continue
        reached.add(name)
        body = bodies[name]
        calls = set(re.findall(r'\b([A-Za-z_]\w*)\(', body))
        calls.update('f' + index for index in re.findall(r'\bfc(\d+)\b', body))
        pending.extend((calls & bodies.keys()) - reached)
    return bodies, reached


def consuming_calls(emitted):
    """Follow actual main/loop calls and used closure constants, not metadata."""
    program = emitted.split('/* ---- program ---- */', 1)[1]
    private = {match[2]: match[1] for match in re.finditer(
        r'/\* (consumed-scalar-array-map|consumed-scalar-array-list-zip) : [^\n]*\*/\nstatic [^\n]*? (f\d+)\(', program)}
    bodies, reached = reachable_bodies(emitted)
    return {kind: sorted(name for name, actual in private.items() if actual == kind and name in reached)
            for kind in ('consumed-scalar-array-map', 'consumed-scalar-array-list-zip')}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--expected-selection', required=True, choices=('baseline', 'candidate'))
    parser.add_argument('--expected-input-storage', required=True, choices=('boxed', 'packed'))
    parser.add_argument('--expected-owned-storage', required=True, choices=('borrowed', 'consuming'))
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'compiler builds belong on CI'
    compiler = args.compiler.resolve()
    output = args.output.resolve()
    output.mkdir(exist_ok=False)
    cases = {
        'scalar': 'finish : I64 -> I64 -> Option[I64]\n'
                  'finish = fn count -> iterate count (add 1) | last\n'
                  'main = 0 | finish 3 | echo\n',
        'numeric-list': 'finish : I64 -> List[F64] -> Option[List[F64]]\n'
                        'finish = fn count -> iterate count (map (add 1.0)) | last\n'
                        'main = [1.0, 2.0] | finish 3 | echo\n',
        'shared-history': 'finish : I64 -> I64 -> (List[I64], Option[I64])\n'
                          'finish = fn count -> iterate count (add 1) | both id last\n'
                          'main = 0 | finish 3 | echo\n',
        'descent-small': AD.program(3, 3, True),
        'descent-large': AD.program(129, 200, True),
        'current-large': AD.program(129, 200, False),
    }
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', FWP_DUMP_IR='all', FWP_VRET='1',
                       FWP_FRAME_FIELDS='1', FWP_PACKED_ARRAYS='1', FWP_STACK='1')
    commands = []
    for label, source in cases.items():
        source_file = output / (label + '.fwp')
        source_file.write_text(source)
        for mode in ('raw', 'optimized'):
            selected = dict(environment)
            if mode == 'raw':
                selected['FWP_NO_OPT'] = '1'
            stem = output / (label + '-' + mode)
            command = [str(compiler), 'build', '--memory', 'dynamic', '--emit-c',
                       '-O2', str(source_file), '-o', str(stem) + '.c']
            result = run_capture(command, timeout=180, env=selected, cwd=ROOT,
                                 input_data=None, input_stream=None, text=False,
                                 encoding='utf-8', check=False)
            Path(str(stem) + '.stdout').write_bytes(result.stdout)
            Path(str(stem) + '.ir').write_bytes(result.stderr)
            record = dict(command=command, mode=mode, exit=result.returncode)
            if result.returncode == 0:
                emitted = Path(str(stem) + '.c').read_text()
                selected = '/* list._iterate-last :' in emitted
                expected = (args.expected_selection == 'candidate' and mode == 'optimized'
                            and label not in ('shared-history', 'current-large'))
                record.update(selected=selected, expected=expected, selectionPass=selected == expected)
                packed = '/* packed-indexed-records :' in emitted
                pairs = '/* packed-neighbor-pairs :' in emitted
                expected_packed = (args.expected_input_storage == 'packed'
                                   and mode == 'optimized'
                                   and label in ('descent-small', 'descent-large', 'current-large'))
                record.update(packedInputs=packed, packedPairs=pairs,
                              expectedPackedInputs=expected_packed,
                              inputStoragePass=packed == pairs == expected_packed)
                owned = consuming_calls(emitted)
                expected_owned = (args.expected_owned_storage == 'consuming'
                                  and mode == 'optimized'
                                  and label in ('descent-small', 'descent-large', 'current-large'))
                record.update(ownedCalls=owned, expectedOwnedStorage=expected_owned,
                              ownedStoragePass=all(bool(calls) == expected_owned for calls in owned.values()))
            commands.append(record)
            (output / 'commands.json').write_text(json.dumps(commands, indent=2) + '\n')
            print(label, mode, 'exit', result.returncode, 'diagnostics retained', flush=True)
    manifest = {
        'source': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        'compilerSha256': hashlib.sha256(compiler.read_bytes()).hexdigest(),
        'expectedSelection': args.expected_selection,
        'expectedInputStorage': args.expected_input_storage,
        'expectedOwnedStorage': args.expected_owned_storage,
        'settings': {key: value for key, value in environment.items() if key.startswith('FWP_')},
        'files': {path.name: hashlib.sha256(path.read_bytes()).hexdigest()
                  for path in sorted(output.iterdir()) if path.is_file()},
    }
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    failures = [record for record in commands if record['exit'] != 0
                or not record['selectionPass'] or not record['inputStoragePass'] or not record['ownedStoragePass']]
    assert not failures, f'{len(failures)} compilation/selection failures: see commands.json and retained diagnostics'


if __name__ == '__main__':
    main()
