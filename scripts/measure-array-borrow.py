"""Runner-only comparison of cached and per-element F64 array-data selection.

Reuse emitted C from a completed solver evidence run. The control changes only
cached element reads back to fwp_array_load; arithmetic, owners and inputs match.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import statistics
import subprocess

LOAD = re.compile(r'V (t\d+) = 0; if \((t\d+)\) __builtin_memcpy\(&\1, array_data_(\d+) \+ \(size_t\)(\w+) \* sizeof\(V\), sizeof\(V\)\);')


def uncached(source):
    # NULL selects the existing eight-byte word representation, exactly F64.
    def replace(match):
        value, found, array, index = match.groups()
        return f'V {value} = {found} ? fwp_array_load(l{array}, (size_t){index}, NULL) : 0;'
    result, count = LOAD.subn(replace, source)
    assert count, 'missing generated cached F64 load'
    assert not re.search(r'__builtin_memcpy\([^;]*array_data_', result)
    return result, count


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure only on runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output
    output.mkdir(parents=True, exist_ok=True)
    evidence = json.loads((args.input / 'comparison.json').read_text())
    cc = os.environ['CC']
    commands = []
    def run(command, env=None):
        command = list(map(str, command))
        result = subprocess.run(command, env=env, capture_output=True, text=True)
        if result.returncode:
            raise RuntimeError(f'{command}: {result.returncode}\n{result.stdout}\n{result.stderr}')
        return result
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_GC', None)
    results, hashes, changed = {}, {}, {}
    for profile in [False, True]:
        suffix = 'profile' if profile else 'timing'
        binaries = {}
        for gc, stem in [('arc', 'array-arc'), ('tracing', 'array')]:
            filename = f'{stem}-{suffix}.c'
            source = (args.input / filename).read_text()
            digest = hashlib.sha256(source.encode()).hexdigest()
            recorded = [value for key, value in evidence['sourceHashes'].items() if key.endswith('/' + filename)]
            assert recorded == [digest], (filename, recorded, digest)
            hashes[filename] = digest
            assert ('#define FWP_ARC_ONLY 1' in source) == (gc == 'arc')
            control, count = uncached(source)
            changed[filename] = count
            for mode, code in [('cached', source), ('per-element', control)]:
                label = f'{gc}-{mode}-{suffix}'
                cfile, binary = output / f'{label}.c', output / label
                cfile.write_text(code)
                command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                           f'-DPROFILE={int(profile)}', '-DMATRIX_BENCH=0', cfile,
                           '-o', binary, '-lm', '-lpthread']
                run(command); commands.append(list(map(str, command)))
                binaries[label] = binary
                if not profile:
                    command = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
                    (output / f'{label}.asm').write_text(run(command).stdout)
                    if gc == 'arc':
                        symbols = run(['nm', binary]).stdout
                        assert not any(symbol in symbols for symbol in ['fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'])
        labels = list(binaries)
        if not profile:
            for binary in binaries.values():
                run([binary], environment)
        for process in range(1 if profile else 8):
            order = labels[process % 4:] + labels[:process % 4]
            for label in order:
                command = ['/usr/bin/time', '-l' if platform.system() == 'Darwin' else '-v', binaries[label]]
                execution = run(command, environment)
                data = json.loads(execution.stdout)
                pattern, scale = (r'(\d+)\s+maximum resident set size', 1) if platform.system() == 'Darwin' else (r'Maximum resident set size \(kbytes\):\s*(\d+)', 1024)
                rss = re.search(pattern, execution.stderr)
                assert rss, execution.stderr
                record = results.setdefault(label, dict(samples=[], processes=[], peakProcessRssBytes=0))
                record['samples'].extend(data['samples'])
                record['processes'].append(dict(order=order, samples=len(data['samples']), peakProcessRssBytes=int(rss[1])*scale))
                record['peakProcessRssBytes'] = max(record['peakProcessRssBytes'], int(rss[1])*scale)
                (output / f'{label}-process-{process}.txt').write_text(execution.stderr)
    result_hashes = {sample['hash'] for record in results.values() for sample in record['samples']}
    assert len(result_hashes) == 1
    clean = lambda record: [{k: v for k, v in sample.items() if k not in ['kernelNs', 'allocationInclusiveNs']} for sample in record['samples']]
    for gc in ['arc', 'tracing']:
        assert clean(results[f'{gc}-cached-profile']) == clean(results[f'{gc}-per-element-profile'])
    summary = {label: dict(medianKernelNs=statistics.median(row['kernelNs'] for row in record['samples']),
                          medianAllocationInclusiveNs=statistics.median(row['allocationInclusiveNs'] for row in record['samples']))
               for label, record in results.items() if label.endswith('-timing')}
    hardware = dict(uname=run(['uname', '-a']).stdout, machine=platform.machine(),
                    cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout)
    report = dict(head=os.environ['GITHUB_SHA'], emittedHead=evidence['head'], evidenceRun=os.environ['EVIDENCE_RUN'],
                  sourceHashes=hashes, replacedReads=changed, hardware=hardware, compiler=run([cc, '--version']).stdout,
                  buildCommands=commands, results=results, summary=summary,
                  scope='Same-run F64 array comparison: one cached address versus the existing per-element array-data selection. Reuses verified emitted C, checks its recorded hashes, changes only cached load expressions, preserves arithmetic and ownership, and compares result hashes and complete allocation profiles. The compiler optimizes away unused cached-pointer parameters in the control. Both tracing and ARC use identical C flags. Forty samples per binary from eight rotating four-binary batches, after warmup; each binary occupies each position twice. Profiles are separate from timing. This isolates a generated-code change; it is not a C/Rust comparison, whole-program startup measurement or a general zero-cost claim.')
    (output / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
