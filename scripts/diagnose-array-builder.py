#!/usr/bin/env python3
"""Test redundant fresh-array store checks using retained, unchanged program C."""
import argparse
import difflib
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import time

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-borrowed-arrays.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)
COSTS = AUDIT.COSTS


def direct_stores(source):
    descriptors = set(re.findall(r'^static const fwp_desc (d\d+) = \{K_F64, "F64", \.width = 0, \.dup = NULL, \.drop = NULL\};$', source, re.M))
    count = 0

    def change(match):
        nonlocal count
        body = match[0]
        allocation = re.search(r'fwp_array_builder result = \{fwp_array_typed_new\(n, &(d\d+)\), 0, &\1\};', body)
        if allocation is None:
            return body
        descriptor = allocation[1]
        assert descriptor in descriptors, 'diagnostic requires exact immediate F64 results'
        protect = '    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);\n'
        store = f'        fwp_array_store_owned(result.value, index, value, &{descriptor});\n        result.filled++;'
        assert body.count(protect) == 1 and body.count(store) == 1
        body = body.replace(protect, protect + '    unsigned char *result_data = (unsigned char *)(uintptr_t)result.value + sizeof(fwp_arr);\n')
        body = body.replace(store, '        memcpy(result_data + index * sizeof value, &value, sizeof value);')
        count += 1
        return body

    changed = re.sub(r'^static V fwp_hof\d+\([^\n]*\) \{\n.*?^\}', change, source, flags=re.M | re.S)
    return changed, count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    machine = platform.machine()
    arch = {'aarch64': 'ARM64', 'x86_64': 'X64'}[machine]
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    run = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['conclusion'] == 'success'
    artifacts = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}/artifacts'))['artifacts']
    metadata, = [item for item in artifacts if item['name'] == f'borrowed-array-costs-{arch}-1']
    assert not metadata['expired'] and metadata['workflow_run']['head_sha'] == args.source
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    saved = output / 'original'
    AUDIT.unpack(AUDIT.api(f"{repository}/actions/artifacts/{metadata['id']}/zip"), metadata, saved)
    original = AUDIT.audit(saved, machine, 1, args.source)
    AUDIT.save(output / 'original-audit.json', original)
    flags = original['identity']['flags']
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(original['identity']['settings'])
    identity = dict(source=os.environ['GITHUB_SHA'], originalSource=args.source,
        originalArtifact=metadata, machine=machine, cpu=Path('/proc/cpuinfo').read_text(),
        affinity=sorted(os.sched_getaffinity(0)), flags=flags,
        ccVersion=subprocess.check_output([args.cc, '--version'], text=True))
    assert identity['ccVersion'] == original['identity']['ccVersion']
    AUDIT.save(output / 'identity.json', identity)

    def run_command(command, destination):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        result = run_capture(command, timeout=180, cwd=COSTS.ROOT, env=environment,
            input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode,
                elapsedNs=elapsed, output=str(destination.relative_to(output)))) + '\n')
        assert result.returncode == 0 and not result.stderr, (command, result.stderr)
        return result.stdout, elapsed

    reports = {}
    for case in COSTS.programs():
        name = case['name']
        directory = output / name
        directory.mkdir()
        # Disable metadata caching on both sides: isolate only fresh output writes.
        reference = (saved / 'array-costs' / name / 'reference.c').read_text()
        candidate, changed = direct_stores(reference)
        if case['kind'] == 'loop':
            assert changed == 0
        elif case['kind'] == 'array' or case['updates'] > 0:
            assert changed > 0
        (directory / 'change.patch').write_text(''.join(difflib.unified_diff(
            reference.splitlines(True), candidate.splitlines(True), fromfile='reference.c', tofile='candidate.c')))
        binaries = {}
        for role, code in (('candidate', candidate), ('reference', reference)):
            cfile = directory / (role + '.c')
            cfile.write_text(code)
            binary = directory / role
            run_command([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'], directory / (role + '-build'))
            shutil.copy2(binary, directory / (role + '-copy'))
            binaries[role], binaries[role + '-copy'] = binary, directory / (role + '-copy')
        rows = []
        for number in range(-2, 24):
            for role in COSTS.order(number):
                raw, elapsed = run_command([binaries[role]], directory / f'round-{number}-{role}')
                row = json.loads(raw)
                assert row['initialLiveBytes'] == row['finalLiveBytes']
                rows.append(row | dict(round=number, role=role, processNs=elapsed))
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(rows[-1]) + '\n')
        report = COSTS.summarize(rows)
        report['changedBuilders'] = changed
        report['binaryHashes'] = {role: hashlib.sha256(path.read_bytes()).hexdigest() for role, path in binaries.items()}
        reports[name] = report
        AUDIT.save(output / 'summary.json', reports)
        print(name, json.dumps(report), flush=True)


if __name__ == '__main__':
    main()
