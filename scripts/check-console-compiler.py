#!/usr/bin/env python3
"""Reproduce compiler failures with named console inputs; never retry a failure."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

# The input families in console_input_matches_raw_interpretation. Only compilation
# runs here; the production test separately checks interpreted/native I/O results.
CASES = {
    'all': 'read-all () | echo',
    'line': '[read-line (), read-line (), read-line ()] | echo',
    'lines': 'read-lines () | echo',
    'secret': '[term.read-secret (), term.read-secret (), term.read-secret ()] | echo',
    'tty': '[-2147483648, -1, 0, 1, 2, 3, 2147483647] | map term.is-tty | echo',
    'width': 'term.width () | echo',
    'fold': '0 | fold-lines (curry (.0 | add 1)) | echo',
    'args': 'args () | echo',
    'environment': r'[env.get "FWP_ENV_COPY", env.get "FWP_ENV_EMPTY", env.get "FWP_ENV_ABSENT", env.get "FWP_ENV_COPY\0suffix"] | echo',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--rounds', type=int, required=True)
    parser.add_argument('--allocator', choices=('ordinary', 'checked'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.rounds < 1:
        parser.error('--rounds must be positive')
    compiler = args.compiler.resolve(strict=True)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    env.pop('FWP_NO_OPT', None)
    if args.allocator == 'checked':
        env.update(MallocScribble='1', MallocCheckHeapStart='1',
                   MallocCheckHeapEach='1000', MallocCheckHeapAbort='1',
                   MallocErrorAbort='1', MallocLogFile=str(output / 'malloc.log'))
    metadata = dict(compiler=str(compiler), sha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                    rounds=args.rounds, allocator=args.allocator,
                    source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip())
    (output / 'compiler.json').write_text(json.dumps(metadata, indent=2) + '\n')
    for name, body in CASES.items():
        (output / f'{name}.fwp').write_text(f'main = {body}\n')
    with (output / 'attempts.jsonl').open('x') as records:
        for iteration in range(args.rounds):
            for name in CASES:
                for gc in ('tracing', 'arc'):
                    command = [str(compiler), 'build', '--gc', gc, '--emit-c',
                               str(output / f'{name}.fwp'), '-o', str(output / f'{name}-{gc}.c')]
                    attempt = dict(iteration=iteration, case=name, gc=gc, command=command)
                    (output / 'current.json').write_text(json.dumps(attempt, indent=2) + '\n')
                    started = time.monotonic()
                    with (output / 'stdout.log').open('wb') as stdout, (output / 'stderr.log').open('wb') as stderr:
                        result = subprocess.run(command, env=env, stdout=stdout, stderr=stderr, timeout=60)
                    attempt.update(returncode=result.returncode, seconds=time.monotonic() - started)
                    records.write(json.dumps(attempt) + '\n')
                    records.flush()
                    if result.returncode:
                        print(json.dumps(attempt), flush=True)
                        raise SystemExit('Compiler failed; input, command and diagnostics preserved')
            print(f'Completed {iteration + 1}/{args.rounds} rounds (18 compilations each)', flush=True)


if __name__ == '__main__':
    main()
