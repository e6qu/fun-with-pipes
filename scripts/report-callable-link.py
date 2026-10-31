#!/usr/bin/env python3
"""Relink retained callable objects with a map; require identical executables."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = json.loads((args.input / 'report.json').read_text())
    assert report['source'] == args.source and report['machine'] == 'aarch64'
    args.output.mkdir(parents=True)
    records = []

    def run(command, stderr_expected):
        result = subprocess.run([str(value) for value in command], capture_output=True, text=True, timeout=30)
        records.append(dict(command=[str(value) for value in command], status=result.returncode,
                            stdout=result.stdout, stderr=result.stderr))
        (args.output / 'commands.json').write_text(json.dumps(records, indent=2) + '\n')
        assert result.returncode == 0 and (stderr_expected or not result.stderr), result
        return result

    assert run([args.cc, '--version'], False).stdout == report['versions']['cc']
    linker = run([args.cc, '-print-prog-name=ld'], False).stdout.strip()
    run([linker, '--version'], False)
    results = {}
    for level in (1, 2):
        label = f'fwp-O{level}'
        folder = args.input / label
        binary = args.output / label
        command = [args.cc, '-fno-lto', folder / 'callable.o', folder / 'observer.o',
                   '-lm', '-lpthread', '-o', binary]
        run([args.cc, '-###', *command[1:]], True)
        assert not run([*command, '-Wl,-Map=' + str(args.output / (label + '.map'))], False).stdout
        digest = hashlib.sha256(binary.read_bytes()).hexdigest()
        assert digest == report['programs'][label]['binarySha256'], (label, digest)
        results[label] = dict(binarySha256=digest, identical=True,
                              map=label + '.map', originalText=report['programs'][label]['sections'])
    (args.output / 'report.json').write_text(json.dumps(dict(source=args.source, programs=results), indent=2) + '\n')
    print('Both mapped links reproduce the original executable hashes; no timing measurement')


if __name__ == '__main__':
    main()
