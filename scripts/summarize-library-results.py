#!/usr/bin/env python3
"""Check saved C-library ownership evidence without executing downloaded code."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess


HOSTS = {
    'ubuntu-latest': ('elf64-x86-64', '.so'),
    'ubuntu-24.04-arm': ('elf64-littleaarch64', '.so'),
    'macos-15': ('mach-o arm64', '.dylib'),
    'macos-15-intel': ('mach-o 64-bit x86-64', '.dylib'),
    'windows-2025': ('coff-x86-64', '.dll'),
    'windows-11-arm': ('coff-arm64', '.dll'),
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inspect(path, host, llvm, expected_exports):
    names = subprocess.check_output([str(llvm / 'llvm-nm'), str(path)], text=True)
    symbols = {line.split()[-1].removeprefix('_')
               for line in names.splitlines() if line.split()}
    assert {'fwp_gc_alloc_slow', 'fwp_rc_free_obj'} <= symbols, (path, 'internal runtime names required')
    tracing = sorted(symbols.intersection({'fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'}))
    assert not tracing, (path, tracing)
    public_exports = None
    if path.suffix == '.dll':
        image = subprocess.check_output([str(llvm / 'llvm-objdump'), '-p', str(path)], text=True)
        table = image.split('Export Table:', 1)[1]
        public_exports = sorted(line.split()[-1] for line in table.splitlines()
                                if line.split() and line.split()[0].isdigit())
        assert expected_exports <= set(public_exports), (path, expected_exports - set(public_exports))
    releases = sorted(name for name in symbols if name.startswith('fwp_release_'))
    assert {'fwp_release_keep_text', 'fwp_release_twin', 'fwp_release_shared'} <= set(releases)
    assembly = subprocess.check_output(
        [str(llvm / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(path)], text=True)
    assert 'file format ' + HOSTS[host][0] in assembly, path
    assert re.search(r'<_?twin>:', assembly), path
    path.with_suffix(path.suffix + '.disassembly.txt').write_text(assembly)
    sizes = subprocess.check_output([str(llvm / 'llvm-size'), '--format=sysv', str(path)], text=True)
    sections = {}
    for line in sizes.splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[1].isdigit():
            sections[fields[0]] = sections.get(fields[0], 0) + int(fields[1])
    assert sections, path
    return {'file': path.name, 'sha256': digest(path), 'file_bytes': path.stat().st_size,
            'sections': sections, 'format': HOSTS[host][0], 'release_symbols': releases,
            'tracing_symbols': tracing, 'dll_public_exports': public_exports}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--audit', type=Path, required=True)
    parser.add_argument('--llvm-bin', type=Path, required=True)
    parser.add_argument('--record-results', choices=['boxed', 'direct'], required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    audit = json.loads(args.audit.read_text())
    assert args.artifacts.name == str(audit['run'])
    assert audit['status'] == 'completed' and len(audit['jobs']) == 6
    assert re.fullmatch('[0-9a-f]{40}', audit['head'])
    hosts = []
    for host, (_, extension) in HOSTS.items():
        directory = args.artifacts / ('library-results-' + host)
        assert (directory / 'source.txt').read_text().strip() == audit['head']
        source = (directory / 'library.c').read_text()
        assert '#define FWP_ARC_ONLY 1' in source
        direct = args.record_results == 'direct'
        assert ('/* move C result fields */' in source) == direct
        expected = (directory / 'reference.stdout').read_bytes()
        runs = []
        for opt in ['-O1', '-O2']:
            for shared in [False, True]:
                repeats = 3 if shared else 1
                for workspace in [0, 1]:
                    stem = f'{opt}-{str(shared).lower()}-{workspace}'
                    assert (directory / (stem + '.stdout')).read_bytes() == expected * repeats
                    # C diagnostic text streams may use CRLF; language output above is byte-exact.
                    memory = (directory / (stem + '.memory.txt')).read_text()
                    assert memory == '0 0\n' * repeats, (host, stem, memory)
                    stderr = (directory / (stem + '.stderr')).read_text()
                    counts = 'library result retains: keep=0 twin=1'
                    if direct:
                        counts += '; result boxes: keep=0 twin=0'
                    assert stderr.count(counts + '\n') == repeats, (host, stem, stderr)
                    runs.append({'optimization': opt, 'shared': shared, 'workspace_cache': workspace,
                                 'executions': repeats, 'shutdown_counted_bytes': 0, 'collections': 0,
                                 'identity_retains': 0, 'two_alias_fields_retains': 1,
                                 'record_boxes_asserted': 0 if direct else None})
        controls = {'box': 186, 'host': 186, 'extra-counts': 202}
        if direct:
            controls['extra-box'] = 205
        for name, status in controls.items():
            assert (directory / f'broken-{name}.status').read_text() == f'Some({status})\n'
            assert (directory / f'broken-{name}.exe').stat().st_size > 0
        expected_exports = {line.split('(')[0].split()[-1]
                            for line in (directory / 'library.h').read_text().splitlines()
                            if line.endswith(');')}
        binaries = [inspect(directory / f'library-{opt}-{kind}{suffix}', host, args.llvm_bin, expected_exports)
                    for opt in ['-O1', '-O2']
                    for kind, suffix in [('static', '.a'), ('shared', extension)]]
        jobs = [job for job in audit['jobs'] if job['name'] == f'library_results ({host})']
        assert len(jobs) == 1
        hosts.append({'host': host, 'job_audit': jobs[0],
                      'settings': (directory / 'settings.txt').read_text(),
                      'rustc': (directory / 'rustc.txt').read_text().strip(),
                      'clang': (directory / 'clang.txt').read_text().strip(),
                      'source_sha256': digest(directory / 'library.c'),
                      'runs': runs, 'controls': controls, 'binaries': binaries})
        print(host, 'ownership artifacts verified;', jobs[0]['conclusion'], 'whole test job', flush=True)
    report = {'source': audit['head'], 'run': audit['run'], 'record_results': args.record_results,
              'all_functional_jobs_pass': all(j['conclusion'] == 'success' for j in audit['jobs']),
              'scope': 'fwp C library ownership, not an elapsed-time comparison with C or Rust. '
                       '256 repeated call batches after warmup; static or three dynamic load/unload executions. '
                       'One retain is necessary for two independently released fields sharing one string. '
                       'Shutdown counts exclude host memory, allocator capacity and operating-system RSS. '
                       'Instrumented binaries are inspected as data, never executed by this collector.',
              'hosts': hosts}
    args.output.write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
