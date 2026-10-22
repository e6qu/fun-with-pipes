#!/usr/bin/env python3
"""Check complete numerical outputs and detect missing C/Rust buffer releases."""

import argparse
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('coordinate', ROOT / 'scripts/measure-coordinate-work.py')
COORDINATE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COORDINATE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['cc', 'rustc', 'c-arch']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    # Equal prefixes, nonfinite numbers and missing repetitions must not pass.
    for invalid in [b'[1]\n[1]\n', b'[1, 2, 3]\n[1, 2, 3]\n',
                    b'[1, 2]\n', b'[1, 2]\n[1, 3]\n',
                    b'[NaN, 2]\n[NaN, 2]\n', b'[Infinity, 2]\n[Infinity, 2]\n',
                    b'[true, 2]\n[true, 2]\n']:
        try:
            COORDINATE.check_vectors(invalid, [1, 2], 2)
        except AssertionError:
            continue
        raise AssertionError(f'Invalid complete output accepted: {invalid!r}')
    COORDINATE.check_vectors(b'[1, 2]\n[1, 2]\n', [1, 2], 2)
    records = []
    with tempfile.TemporaryDirectory(prefix='fwp-coordinate-controls-') as temporary:
        directory = Path(temporary)
        for points, updates in [(2, 0), (2, 1), (3, 7)]:
            expected = COORDINATE.BATCHES.PEERS.AD.analytic(points, updates + 1)
            for language in ['c', 'rust']:
                extension = '.c' if language == 'c' else '.rs'
                for arrangement in ['coordinate', 'edge']:
                    fixture = 'descent_coordinate' if arrangement == 'coordinate' else 'descent_explicit'
                    template = (ROOT / ('tests/fixtures/' + fixture + extension)).read_text()
                    code = (f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' + template
                            if language == 'c' else template.replace('// Measurement parameters are inserted here.',
                                f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};'))
                    repeated = COORDINATE.BATCHES.edit_source(code, language, 2)
                    modes = ['checked', 'missing-release'] if (points, updates) == (3, 7) else ['checked']
                    for mode in modes:
                        source, binary = directory / ('probe' + extension), directory / 'probe'
                        source.write_text(COORDINATE.observe_peer_inputs(repeated, language, arrangement, mode))
                        if language == 'c':
                            command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math',
                                       '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror', str(source), '-o', str(binary), '-lm']
                        else:
                            command = [args.rustc, '--edition=2021', '-D', 'warnings', '-C', 'opt-level=2',
                                       '-C', 'overflow-checks=yes', '-C', 'codegen-units=1', '-C', 'target-cpu=generic',
                                       '-C', 'lto=off', str(source), '-o', str(binary)]
                        compiled = subprocess.run(command, capture_output=True, timeout=60)
                        assert compiled.returncode == 0, compiled.stderr.decode()
                        actual = subprocess.run([str(binary)], capture_output=True, timeout=60)
                        observations = [json.loads(line) for line in actual.stderr.splitlines()]
                        assert actual.returncode == (0 if mode == 'checked' else 226)
                        if mode == 'checked':
                            COORDINATE.check_vectors(actual.stdout, expected, 2)
                            assert observations == [dict(solve=i, inputRequests=2*i,
                                inputRequestedBytes=16*points*i, inputLiveBytes=0, inputPeakBytes=16*points)
                                for i in [1, 2]]
                        else:
                            # C deliberately exits without flushing stdout on a violated budget.
                            assert observations == [dict(solve=1, inputRequests=2,
                                inputRequestedBytes=16*points, inputLiveBytes=8*points, inputPeakBytes=16*points)]
                        records.append(dict(dimensions=points, updates=updates, language=language,
                            arrangement=arrangement, mode=mode, command=command, status=actual.returncode,
                            observations=observations, output=actual.stdout.decode()))
                        print(points, updates, language, arrangement, mode, 'passed', flush=True)
    assert len(records) == 16
    args.output.write_text(json.dumps(dict(outputRejectionControls=7, cases=records), indent=2) + '\n')


if __name__ == '__main__':
    main()
