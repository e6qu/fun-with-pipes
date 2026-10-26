#!/usr/bin/env python3
"""Audit integer-output tests and inspect saved native binaries on all six hosts."""
import argparse
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location(
    'hash_report', Path(__file__).with_name('summarize-hashing.py'))
HASH = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(HASH)


def audit_tests(log):
    count = HASH.audit_tests(log)
    log = re.sub(r'\x1b\[[0-9;]*[A-Za-z]', '', log)
    for name in ['integer_output_preserves_widths_shared_strings_and_trap_order',
                 'immediate_integer_output_does_not_allocate_a_string',
                 'integer_print_keeps_binary_protocol_output_on_its_own_stream']:
        assert len(re.findall(r'test ' + name + r' \.\.\. ok', log)) == 1, name
    return count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--llvm-bin', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.head)
    args.artifacts.mkdir(parents=True, exist_ok=True)
    jobs = HASH.completed_run(args.run, args.head, args.artifacts, 'paths', HASH.HOSTS)
    hosts = []
    for host in HASH.HOSTS:
        job, = [job for job in jobs if job['name'] == f'paths ({host})']
        log = HASH.command('gh', 'api', f'repos/{HASH.REPO}/actions/jobs/{job["databaseId"]}/logs', '--allow-escape-sequences')
        (args.artifacts / f'{host}.log').write_text(log)
        passed = audit_tests(log)
        directory = args.artifacts / f'integer-output-{host}'
        HASH.command('gh', 'run', 'download', args.run, '--repo', HASH.REPO,
                     '--name', directory.name, '--dir', directory)
        assert (directory / 'source.txt').read_text().strip() == args.head
        binaries = []
        for case in ['widths', 'shared', 'trap']:
            for direct in ['0', '1']:
                for optimization in ['-O0', '-O2']:
                    name = f'{case}-counted-{direct}{optimization}'
                    source = directory / f'{name}.c'
                    code = source.read_text()
                    assert (code.count('fwp_print_integer(') > 1) == (direct == '1'), name
                    binaries.append(dict(case=case, direct=direct,
                        optimization=optimization, generatedSha256=HASH.digest(source),
                        inspection=HASH.COLLECTIONS.inspect(source.with_suffix('.exe'), host,
                            'arc', args.llvm_bin, require_tracing=False)))
        hosts.append(dict(host=host, job=job['databaseId'], passedTests=passed, binaries=binaries))
        print(host, passed, 'tests and', len(binaries), 'binaries inspected', flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(dict(source=args.head, testsRun=args.run,
        auditSource=HASH.command('git', 'rev-parse', 'HEAD').strip(),
        scope='Six native hosts compare raw interpretation with direct and ordinary integer '
              'output at O0/O2. Tests cover integer widths, shared strings, trap order and '
              'binary-output routing. A separate test requires zero output String '
              'allocations versus one in the ordinary control and rejects an inserted '
              'allocation. These counts do not measure whole-process allocation or time. '
              'The 72 saved semantic-test binaries are inspected without execution and '
              'must exclude tracing symbols. Assembly needs human review for stack/register '
              'claims. WASI and full production acceptance are separate gates.', hosts=hosts), indent=2) + '\n')


if __name__ == '__main__':
    main()
