"""Runner-only comparison of field moves and the former retain/drop conversion.

Use verified emitted matrix C. The control restores the counted conversions;
the matrix kernel, arithmetic, allocations and input shapes remain identical.
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

BOX = re.compile(r'int (t\d+) = fwp_rc_last\(t\d+\); /\* move boxed fields \*/')
FIELD = re.compile(r'/\* move owned field \*/ (l\d+) = (t\d+);')


def retained(source):
    # Use the existing shared-field conversion even for a unique parent.
    result, boxed = BOX.subn(r'int \1 = 0; /* retained control */', source)
    # Restore the selected child's temporary owner and typed nonlast release.
    def restore(match):
        local, field = match.groups()
        return (f'{local} = {field}; fwp_rc_dup({local}); '
                f'if (fwp_rc_release_last({local})) abort();')
    result, fields = FIELD.subn(restore, result)
    assert boxed == 4 and fields == 1, (boxed, fields)
    return result, dict(boxedConversions=boxed, selectedFields=fields)


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
        for gc, stem in [('arc', 'matrix-arc'), ('tracing', 'matrix')]:
            filename = f'{stem}-{suffix}.c'
            source = (args.input / filename).read_text()
            digest = hashlib.sha256(source.encode()).hexdigest()
            recorded = [value for key, value in evidence['sourceHashes'].items() if key.endswith('/' + filename)]
            assert recorded == [digest], (filename, recorded, digest)
            hashes[filename] = digest
            assert ('#define FWP_ARC_ONLY 1' in source) == (gc == 'arc')
            control, count = retained(source)
            changed[filename] = count
            for mode, code in [('moved', source), ('retained', control)]:
                label = f'{gc}-{mode}-{suffix}'
                cfile, binary = output / f'{label}.c', output / label
                cfile.write_text(code)
                command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                           f'-DPROFILE={int(profile)}', '-DMATRIX_BENCH=1', cfile,
                           '-o', binary, '-lm', '-lpthread']
                run(command); commands.append(list(map(str, command)))
                binaries[label] = binary
                if not profile:
                    command = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
                    (output / f'{label}.asm').write_text(run(command).stdout)
                    if gc == 'arc':
                        symbols = run(['nm', binary]).stdout
                        assert not any(symbol in symbols for symbol in ['fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'])
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
    clean = lambda record: [{k: v for k, v in sample.items() if k not in ['kernelNs', 'allocationInclusiveNs', 'retains', 'nonlastReleases', 'releaseChecks']} for sample in record['samples']]
    for gc in ['arc', 'tracing']:
        assert clean(results[f'{gc}-moved-profile']) == clean(results[f'{gc}-retained-profile'])
        for mode, counts in [('moved', (0, 0, 16)), ('retained', (24, 24, 56))]:
            for sample in results[f'{gc}-{mode}-profile']['samples']:
                assert tuple(sample[key] for key in ['retains', 'nonlastReleases', 'releaseChecks']) == counts, sample
                assert sample['requests'] == 40 and sample['liveChargedBytes'] == 0 and sample['collections'] == 0, sample
    summary = {label: dict(medianKernelNs=statistics.median(row['kernelNs'] for row in record['samples']),
                          medianAllocationInclusiveNs=statistics.median(row['allocationInclusiveNs'] for row in record['samples']))
               for label, record in results.items() if label.endswith('-timing')}
    hardware = dict(uname=run(['uname', '-a']).stdout, machine=platform.machine(),
                    cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout)
    report = dict(head=os.environ['GITHUB_SHA'], emittedHead=evidence['head'], evidenceRun=os.environ['EVIDENCE_RUN'],
                  sourceHashes=hashes, restoredOperations=changed, hardware=hardware, compiler=run([cc, '--version']).stdout,
                  buildCommands=commands, results=results, summary=summary,
                  scope='Same-run matrix comparison of field moves and the former retain/drop conversions. Verified emitted C is used for both; only record ownership operations change. Kernel source, ordered arithmetic, input shapes, outputs and allocation profiles agree. The retained control must perform 24 retains and 24 nonlast releases across eight products, versus zero for moves; both use forty allocations and end with zero live storage and collections. Both memory modes use identical C flags. Forty samples per binary from eight rotating four-binary batches after warmup; each binary occupies each position twice. Profiles are separate from timing. The control restores count traffic for these nonfailing inputs; it is not a previous compiler build and does not reproduce obsolete overflow-cleanup scaffolding. This isolates the counted conversions, not a C/Rust comparison, whole-program startup measurement or a general zero-cost claim.')
    (output / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
