#!/usr/bin/env python3
"""Compare tracing and ARC compile admission; this does not execute programs."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import tempfile


def inventory(compiler, root, sources, optimization, timeout, output):
    programs = sorted(sources.glob('*.fwp'))
    if not programs:
        raise ValueError(f'No programs in {sources}')
    environment = {key: value for key, value in os.environ.items() if not key.startswith('FWP_')}
    environment['FWP_STACK'] = '1'
    report = dict(
        source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
        compiler_sha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
        platform=platform.platform(), optimization=optimization, memory='dynamic', stack=True,
        scope='C emission only: no native execution, cleanup proof or performance comparison.',
        programs=[], counts={},
    )
    infrastructure_errors = []
    with tempfile.TemporaryDirectory(prefix='fwp-arc-inventory-') as directory:
        generated = Path(directory) / 'program.c'
        for program in programs:
            record = dict(path=program.relative_to(root).as_posix(),
                          source_sha256=hashlib.sha256(program.read_bytes()).hexdigest(), modes={})
            for mode in ['tracing', 'arc']:
                generated.unlink(missing_ok=True)
                command = [str(compiler), 'build', '--gc', mode, '--memory', 'dynamic',
                           f'-{optimization}', '--emit-c', program.name, '-o', str(generated)]
                try:
                    result = subprocess.run(command, cwd=program.parent, env=environment,
                                            capture_output=True, timeout=timeout)
                    outcome = dict(exit_code=result.returncode,
                                   stdout=result.stdout.decode('utf-8', errors='replace'),
                                   stderr=result.stderr.decode('utf-8', errors='replace'))
                    if result.returncode == 0:
                        code = generated.read_bytes()
                        if (b'#define FWP_ARC_ONLY 1' in code) != (mode == 'arc'):
                            raise ValueError(f'{program} {mode}: incorrect emitted memory mode')
                        outcome.update(c_sha256=hashlib.sha256(code).hexdigest(), c_bytes=len(code))
                    elif result.returncode != 1 or b'panicked at' in result.stderr:
                        infrastructure_errors.append(f'{program.name} {mode}: exit {result.returncode}')
                except subprocess.TimeoutExpired:
                    outcome = dict(timeout_seconds=timeout)
                    infrastructure_errors.append(f'{program.name} {mode}: timeout')
                record['modes'][mode] = outcome
            modes = record['modes']
            if any('timeout_seconds' in value for value in modes.values()):
                category = 'timeout'
            elif modes['tracing']['exit_code'] == 0:
                category = 'both-accepted' if modes['arc']['exit_code'] == 0 else 'arc-rejected'
            else:
                category = 'tracing-rejected'
                if modes['arc']['exit_code'] == 0:
                    infrastructure_errors.append(f'{program.name}: ARC accepts a tracing rejection')
            record['category'] = category
            report['counts'][category] = report['counts'].get(category, 0) + 1
            report['programs'].append(record)
            print(record['path'], category, flush=True)
    report['infrastructure_errors'] = infrastructure_errors
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report['counts'], sort_keys=True))
    if infrastructure_errors:
        raise RuntimeError('; '.join(infrastructure_errors))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--root', required=True, type=Path)
    parser.add_argument('--sources', required=True, type=Path)
    parser.add_argument('--optimization', required=True, choices=['O0', 'O1', 'O2', 'O3'])
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    if args.timeout <= 0:
        parser.error('--timeout must be positive')
    inventory(args.compiler.resolve(), args.root.resolve(), args.sources.resolve(),
              args.optimization, args.timeout, args.output.resolve())


if __name__ == '__main__':
    main()
