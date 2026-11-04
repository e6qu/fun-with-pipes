#!/usr/bin/env python3
"""Retain exact C call sites for matched optional results and whole-value controls."""
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
SPEC = importlib.util.spec_from_file_location('application', ROOT / 'scripts/measure-ad-application.py')
AD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AD)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--expected-selection', choices=('candidate', 'reference'), required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'compiler checks belong on CI'
    compiler, output = args.compiler.resolve(), args.output.resolve()
    output.mkdir(exist_ok=False)
    cases = {
        'nth': ('main = read-all () | string.length | range 0 | nth 1 | option.unwrap-or 9 | echo\n', {'nth': True}),
        'last': ('main = read-all () | string.length | range 0 | last | option.unwrap-or 9 | echo\n', {'last': True}),
        'iteration': ('finish = fn count -> 0 | iterate count (add 1) | last | option.unwrap-or 9\n'
                      'main = read-all () | string.length | finish | echo\n', {'iteration': True}),
        'stored-option': ('finish = fn count -> [0 | iterate count (add 1) | last]\n'
                          'main = read-all () | string.length | finish | echo\n', {'iteration': False}),
        'shared-history': ('finish = fn count -> 0 | iterate count (add 1) | both id (last | option.unwrap-or 9)\n'
                           'main = read-all () | string.length | finish | echo\n', {'iteration': False, 'last': True}),
        'gradient-history': (AD.program(3, 3, True), {'iteration': True}),
        'gradient-current': (AD.program(3, 3, False), {'iteration': False}),
    }
    calls = {'nth': 'fwp_list_nth_fields', 'last': 'fwp_list_last_fields', 'iteration': 'fwp_p_iterate_last_own'}
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', FWP_VRET='1', FWP_FRAME_FIELDS='1',
                       FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_DUMP_IR='all')
    records = []
    for label, (source, expected) in cases.items():
        path = output / (label + '.fwp')
        path.write_text(source)
        cfile = output / (label + '.c')
        command = [str(compiler), 'build', '--memory', 'dynamic', '--emit-c', '-O2', str(path), '-o', str(cfile)]
        observed = run_capture(command, timeout=180, env=environment, cwd=ROOT,
                               input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
        (output / (label + '.stdout')).write_bytes(observed.stdout)
        (output / (label + '.ir')).write_bytes(observed.stderr)
        record = dict(case=label, command=command, exit=observed.returncode)
        if observed.returncode == 0:
            code = cfile.read_text()
            # Runtime definitions and generic boxed entries do not count as
            # selected calls. Direct code-generation temporaries are named tN.
            found = {name: re.findall(r'\bfwp_option_result t[0-9]+ = ' + symbol + r'\([^;]+;', code)
                     for name, symbol in calls.items()}
            wanted = {name: selected and args.expected_selection == 'candidate' for name, selected in expected.items()}
            record.update(calls=found, expected=wanted,
                          selectionPass=all(bool(found[name]) == selected for name, selected in wanted.items()))
        records.append(record)
        (output / 'commands.json').write_text(json.dumps(records, indent=2) + '\n')
        print(label, 'exit', observed.returncode, 'source and diagnostics retained', flush=True)
    manifest = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
                    compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                    expectedSelection=args.expected_selection, environment={key: value for key, value in environment.items() if key.startswith('FWP_')},
                    files={path.name: hashlib.sha256(path.read_bytes()).hexdigest() for path in sorted(output.iterdir()) if path.is_file()})
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    failures = [record for record in records if record['exit'] or not record['selectionPass']]
    assert not failures, f'{len(failures)} compilation/selection failures: inspect every retained record'


if __name__ == '__main__':
    main()
