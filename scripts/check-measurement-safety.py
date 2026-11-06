"""Require completed native correctness jobs and identical production sources."""
import argparse
import json
from pathlib import Path
import subprocess

GROUPS = {
    **dict.fromkeys(('gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity'),
                   'gradient_call_checks'),
    'owned-numeric': 'owned_numeric_checks', 'packed-input': 'packed_input_checks',
    'matched-option': 'matched_option_checks', 'final-iteration': 'final_iteration_checks',
    'scalar-array-map': 'scalar_array_checks', 'scalar-array-identity': 'scalar_array_checks',
    'gradient-array': 'gradient_array_checks', 'scalar-map-zip': 'derivative_forward_costs',
    'range-zip': 'derivative_forward_costs', 'numeric-inputs': 'numeric_owner_checks',
    'callback-owners': 'numeric_owner_checks',
}
SOURCE_PATHS = ('src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs')


def check_jobs(run, pages, comparison):
    group = GROUPS[comparison]
    variants = ('ubuntu-24.04-arm, gcc', 'ubuntu-latest, gcc', 'macos-15, clang')
    if group == 'gradient_array_checks':
        variants = ('ubuntu-24.04-arm, aarch64', 'ubuntu-latest, x86_64')
    elif group == 'derivative_forward_costs':
        variants = ('ubuntu-24.04-arm, aarch64, armv8-a', 'ubuntu-latest, x86_64, x86-64')
    elif group == 'numeric_owner_checks':
        variants = ('ubuntu-latest', 'ubuntu-24.04-arm')
    expected = {f'{group} ({variant})' for variant in variants}
    jobs = [job for page in pages for job in page['jobs'] if job['name'] in expected]
    assert len(jobs) == len(expected) and {job['name'] for job in jobs} == expected
    assert all(job['conclusion'] == 'success' and job['head_sha'] == run['head_sha'] for job in jobs)
    if comparison == 'scalar-array-identity':
        for job in jobs:
            step, = [item for item in job['steps'] if item['name'] == 'Same-type float bits, conversion maps and owner transfer']
            assert step['conclusion'] == 'success', job['name']


def check_sources(checkout, source):
    for name in SOURCE_PATHS:
        verified = subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=checkout)
        current = subprocess.check_output(['git', 'rev-parse', 'HEAD:' + name], cwd=checkout)
        assert verified == current, name


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--comparison', choices=tuple(GROUPS), required=True)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--checkout', type=Path, required=True)
    args = parser.parse_args()
    run = json.loads((args.input / 'run.json').read_text())
    pages = json.loads((args.input / 'jobs.json').read_text())
    check_jobs(run, pages, args.comparison)
    check_sources(args.checkout, run['head_sha'])
    print('Native correctness jobs pass and all production source trees match')


if __name__ == '__main__':
    main()
