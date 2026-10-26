#!/usr/bin/env python3
"""Audit the two-host integer-text tests and direct-counting C/Rust comparison."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics
import struct
import subprocess

HOSTS = {'ubuntu-latest': (62, 'x86_64'), 'ubuntu-24.04-arm': (183, 'aarch64')}
PROGRAMS = {'fib', 'loop', 'map', 'pipeline', 'range-set', 'strings', 'text-length'}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def binary(path, machine):
    data = path.read_bytes()
    assert data[:6] == b'\x7fELF\x02\x01', path
    assert struct.unpack_from('<H', data, 18)[0] == machine, path
    offset = struct.unpack_from('<Q', data, 40)[0]
    width, count, names = struct.unpack_from('<HHH', data, 58)
    assert width == 64 and 0 < names < count
    sections = [struct.unpack_from('<IIQQQQIIQQ', data, offset + i * width)
                for i in range(count)]
    table = sections[names]
    strings = data[table[4]:table[4] + table[5]]
    text, = [section for section in sections
             if strings[section[0]:].split(b'\0', 1)[0] == b'.text']
    return {'sha256': hashlib.sha256(data).hexdigest(), 'fileBytes': len(data),
            'textSectionBytes': text[5], 'elfMachine': machine,
            'textSectionSha256': hashlib.sha256(data[text[4]:text[4] + text[5]]).hexdigest()}


def host_report(artifacts, host, source):
    machine, architecture = HOSTS[host]
    costs = artifacts / ('channel-costs-' + host)
    assert (costs / 'source.txt').read_text().strip() == source
    root = artifacts / ('scalar-text-bench-' + host)
    directory, = (root / 'bench-evidence' / source).iterdir()
    report = (root / 'bench.md').read_text()
    assert (directory / 'report.md').read_text() == report
    assert f'Source commit: `{source}`. Host: `linux/{architecture}`.' in report
    assert 'fwp build flags: `-O2`' in report
    assert 'Native fwp ownership: counted.' in report
    medians = re.findall(
        r'^\| (\S+) \| ([\d.]+) ms \| ([\d.]+) ms \| ([\d.]+) ms \|',
        report.split('## Raw elapsed samples')[0], re.M)
    assert {row[0] for row in medians} == PROGRAMS and len(medians) == len(PROGRAMS)
    raw_section = report.split('## Raw elapsed samples')[1].split('## Compilation')[0]
    samples = {}
    for line in raw_section.splitlines():
        parts = [part.strip() for part in line.split('|')]
        if len(parts) == 6 and parts[1] in PROGRAMS:
            samples[parts[1]] = {
                name: [float(value.removesuffix(' ms')) for value in column.split(', ')]
                for name, column in zip(('c', 'rust', 'fwp'), parts[2:5], strict=True)}
    assert set(samples) == PROGRAMS
    programs = []
    for program, c, rust, fwp in medians:
        times = dict(zip(('c', 'rust', 'fwp'), map(float, (c, rust, fwp)), strict=True))
        for name, values in samples[program].items():
            assert len(values) == 6 and all(value > 0 for value in values)
            assert abs(statistics.median(values) - times[name]) <= 0.00101
        files = {}
        for kind in ('c', 'rs', 'fwp'):
            path = directory / f'{program}-{kind}'
            files[path.name] = binary(path, machine)
            input_path = directory / f'{program}-source.{kind}'
            original = subprocess.check_output(
                ['git', 'show', f'{source}:bench/{program}/main.{kind}'])
            assert input_path.read_bytes() == original, input_path
            files[input_path.name] = {'sha256': digest(input_path)}
        generated = directory / f'{program}-generated.c'
        generated_text = generated.read_text()
        for collector in ('fwp_heap_collect', 'fwp_heap_sweep', 'fwp_gc_collect', 'fwp_gc_sweep'):
            assert collector not in generated_text, 'collector code in scalar-text evidence'
        files[generated.name] = {'sha256': digest(generated)}
        programs.append({'program': program, 'medianProcessMs': times,
                         'processSamplesMs': samples[program],
                         'fwpOverC': times['fwp'] / times['c'],
                         'fwpOverRust': times['fwp'] / times['rust'], 'files': files})

    # These are two peer comparisons of the same fwp calculation. Preserve
    # actual hashes rather than assuming the C toolchain chose identical code.
    same_fwp = {
        suffix: digest(directory / ('strings-' + suffix))
                == digest(directory / ('text-length-' + suffix))
        for suffix in ('fwp', 'generated.c')}
    same_fwp['textSection'] = (
        binary(directory / 'strings-fwp', machine)['textSectionSha256']
        == binary(directory / 'text-length-fwp', machine)['textSectionSha256'])
    tests = costs / 'text-length'
    expected = {f'semantics-counted{opt}' for opt in ('-O0', '-O2')}
    expected.update(
        f'allocation-check-counted{opt}-exit-{status}'
        for opt in ('-O0', '-O2')
        for status in (0, 247))
    assert {path.stem for path in tests.glob('*.exe')} == expected
    probes = []
    for label in sorted(expected):
        code = tests / (label + '.c')
        assembly = tests / (label + '.asm')
        assert '/* string._integer-length :' in code.read_text(), label
        assert assembly.stat().st_size > 0
        if label.startswith('allocation-check-'):
            assert (tests / (label + '.stdout')).read_bytes() == b'40240\n'
            assert (tests / (label + '.stderr')).read_bytes() == b''
            injected = '(void)fwp_alloc_leaf(16); return (V)fwp_i64_chars((int64_t)l0);'
            assert (injected in code.read_text()) == label.endswith('-exit-247')
        probes.append({'name': label, **binary(tests / (label + '.exe'), machine),
                       'generatedSha256': digest(code), 'assemblySha256': digest(assembly)})
    inventory = json.loads((costs / 'ownership-inventory.json').read_text())
    assert inventory['head'] == source and inventory['status'] == 'Expected contract changes verified'
    model, = re.findall(r'^Model name:\s*(.+)$', (costs / 'cpu.txt').read_text(), re.M)
    return {'host': host, 'cpu': model, 'kernel': (costs / 'kernel.txt').read_text().strip(),
            'cCompiler': (costs / 'cc.txt').read_text().splitlines()[0],
            'rustCompiler': (costs / 'rust.txt').read_text().strip(),
            'benchmarkReportSha256': digest(root / 'bench.md'),
            'programs': programs, 'identicalFwpForBothTextComparisons': same_fwp,
            'testBinaries': probes, 'inventorySha256': digest(costs / 'ownership-inventory.json')}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--source', required=True)
    parser.add_argument('--artifacts', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    run = json.loads(subprocess.check_output(
        ['gh', 'run', 'view', str(args.run), '--repo', 'e6qu/fun-with-pipes',
         '--json', 'headSha,status,conclusion,jobs,url'], text=True))
    assert run['headSha'] == args.source and run['status'] == 'completed'
    assert run['conclusion'] == 'success'
    jobs = [job for job in run['jobs'] if job['conclusion'] != 'skipped']
    assert {job['name'] for job in jobs} == {f'channel_transfer_costs ({host})' for host in HOSTS}
    assert len(jobs) == 2 and all(job['conclusion'] == 'success' for job in jobs)
    hosts = [host_report(args.artifacts, host, args.source) for host in HOSTS]
    result = {
        'source': args.source, 'run': args.run, 'url': run['url'], 'hosts': hosts,
        'scope': 'Seven complete programs, one warmup and six rotating-order fresh-process '
                 'samples per implementation. Medians and samples have 0.001 ms resolution. '
                 'Native fwp uses counted ownership, GCC O2 and LTO off; C uses GCC O2, Rust uses -O. '
                 'Compilation is excluded. text-length compares identical decimal-length '
                 'calculations for i=0..1999999: fwp eliminates text; C/Rust count digits '
                 'directly with checked multiplication and sums. strings peers still format. '
                 'Separate O0/O2 counted-ownership probes check results and zero managed leaf '
                 'allocations after constant initialization, with allocating controls. '
                 'They do not measure total allocations, RSS, peak memory or elapsed-time '
                 'improvement over an earlier fwp revision. ELF .text includes layout costs; '
                 'whole-file bytes include runtime and linking choices.'}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('Two hosts, seven complete programs each, and 24 test binaries audited')


if __name__ == '__main__':
    main()
