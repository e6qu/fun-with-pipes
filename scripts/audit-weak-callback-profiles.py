#!/usr/bin/env python3
"""Reconstruct both complete service profile archives on a GitHub runner."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import traceback

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('service_profiles', ROOT / 'scripts/profile-weak-callback-service.py')
PROFILES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILES)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gh', required=True)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    args.output.mkdir(parents=True, exist_ok=False)
    report = dict(source=args.source, run=args.run, architectures={}, failures=[])
    for arch in ('x86_64', 'aarch64'):
        try:
            folder = args.output / arch
            subprocess.run([args.gh, 'run', 'download', str(args.run), '--repo', 'e6qu/fun-with-pipes',
                            '--name', f'weak-callback-profiles-{arch}-1', '--dir', str(folder)],
                           check=True, timeout=180)
            evidence = folder / 'weak-callback-profiles'
            PROFILES.audit(evidence, args.source, arch)
            commands = [json.loads(line) for line in (evidence / 'commands.jsonl').read_text().splitlines()]
            diagnostics = []
            for index, row in enumerate(commands):
                assert row['index'] == index
                if row['stderr'] and row['stderr'] not in (
                        'service storage not released\n', 'expected population 64|4096 and mode 0|1|2|3\n'):
                    diagnostics.append(dict(index=row['index'], stderr=row['stderr']))
                if re.search(r'(?im)(^|\s)(warning:|error:|traceback)', row['stdout']):
                    diagnostics.append(dict(index=row['index'], stdout=row['stdout']))
            report['architectures'][arch] = dict(commandCount=len(commands), diagnostics=diagnostics)
            assert not diagnostics, diagnostics
        except Exception as error:
            report['failures'].append(dict(architecture=arch, error=str(error), traceback=traceback.format_exc()))
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], report['failures']
    print('Both complete archives reconstruct all 160 profiles and 32 diagnostic builds without unreviewed command diagnostics')


if __name__ == '__main__':
    main()
