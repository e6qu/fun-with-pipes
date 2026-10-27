#!/usr/bin/env python3
"""Audit native ARC artifacts and retain counts, source sites and binary costs."""

import argparse
from bisect import bisect_right
import importlib.util
import json
from pathlib import Path
import re


SPEC = importlib.util.spec_from_file_location('arc', Path(__file__).with_name('measure-arc-costs.py'))
ARC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ARC)


def caller_lines(code):
    masked = ARC.OWNERSHIP.mask_c(code)
    # Remove attributes while retaining offsets, so __attribute__ cannot be
    # mistaken for a function name. These emitted functions have single-line
    # signatures; retain the actual source line when no signature is found.
    masked = re.sub(r'__attribute__\(\([^\n]*?\)\)', lambda m: ' ' * len(m[0]), masked)
    functions = []
    for match in re.finditer(r'^static [^=;\n]*?\b(\w+)\([^;{\n]*\)\s*\{', masked, re.M):
        functions.append((code.count('\n', 0, match.start()) + 1, match[1]))
    return functions


def audit(directory, source, machine):
    report = json.loads((directory / 'report.json').read_text())
    assert report['source'] == source and report['machine'] == machine
    assert set(report['cases']) == {case[0] for case in ARC.cases()}
    results = {}
    for name, case in report['cases'].items():
        root = directory / name
        assert Path(name).name == name
        for filename, expected in case['files'].items():
            assert Path(filename).name == filename
            assert ARC.digest(root / filename) == expected, (name, filename)
        assert ARC.digest(root / 'ordinary.exe') == case['binarySha256']
        assert (root / 'ordinary.exe').stat().st_size == case['binaryBytes']
        assert ARC.digest(root / 'program.fwp') == case['sourceSha256']
        sites = json.loads((root / 'sites.json').read_text())
        code = (root / 'profile-base.c').read_text()
        lines = code.splitlines()
        functions = caller_lines(code)
        starts = [row[0] for row in functions]
        frames = []
        for line in (root / 'ordinary.su').read_text().splitlines():
            location, size, kind = line.split('\t')
            frames.append(dict(function=location.rsplit(':', 1)[1], bytes=int(size), kind=kind))
        text, = re.findall(r'^\s*\d+ \.text\s+([0-9a-fA-F]+)\s', (root / 'ordinary.sections').read_text(), re.M)
        active = set()
        inputs = {}
        for label, samples in case['inputs'].items():
            assert len(samples) == 3 and all(sample == samples[0] for sample in samples)
            for sample, expected in enumerate(samples):
                actual = ARC.parse_profile((root / f'{label}-{sample}.stderr').read_bytes(), sites)
                assert actual == expected, (name, label, sample)
                active.update(row['site'] for row in actual['sites'])
            inputs[label] = samples[0]
        selected_sites = []
        for index in sorted(active):
            site = sites[index]
            assert site['id'] == index and site['source'] == lines[site['line'] - 1].strip()
            position = bisect_right(starts, site['line']) - 1
            caller = functions[position][1] if position >= 0 else None
            selected_sites.append(dict(site, caller=caller))
        if name == 'observer-control':
            assert case['missingRetainObservationRejected'] is True
        results[name] = dict(binaryBytes=case['binaryBytes'], textBytes=int(text, 16),
                             binarySha256=case['binarySha256'], sourceSha256=case['sourceSha256'],
                             frames=frames, inputs=inputs, activeSites=selected_sites,
                             fileHashes=case['files'])
    return dict(machine=machine, platform=report['platform'], cpu=report['cpu'],
                cc=report['cc'], compilerSha256=report['compilerSha256'],
                reportSha256=ARC.digest(directory / 'report.json'), cases=results)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--amd64', required=True, type=Path)
    parser.add_argument('--arm64', required=True, type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--run', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source) and args.run.isdigit()
    hosts = {machine: audit(directory, args.source, machine)
             for machine, directory in [('x86_64', args.amd64), ('aarch64', args.arm64)]}
    for name, case in hosts['x86_64']['cases'].items():
        for label, profile in case['inputs'].items():
            other = hosts['aarch64']['cases'][name]['inputs'][label]
            for field in ('managed', 'operations'):
                assert profile[field] == other[field], (name, label, field)
    summary = dict(source=args.source, run=args.run, hosts=hosts,
                   scope='Audited three identical count samples per input per native host. '
                         'No timing or C/Rust comparison. Binary .text includes padding; '
                         'frames are per-function GCC estimates, not peak call-stack use. '
                         'Site caller names aid source review but do not classify ownership automatically.')
    args.output.write_text(json.dumps(summary, indent=2) + '\n')
    print(f'{len(hosts["x86_64"]["cases"])} cases: native counts agree; files, rows and samples verified')


if __name__ == '__main__':
    main()
