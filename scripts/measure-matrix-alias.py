"""Runner-only experiment communicating fresh matrix output to the C compiler.

Compare a restrict-qualified output parameter with the existing local pointer.
Inputs may alias. The helper is required to inline; runtime source is unchanged.
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

def separate_output(source):
    # Only the fresh output is disjoint. The two inputs may share storage.
    signature = 'static V fwp_p_matrix_mul_f64('
    start = source.index(signature)
    loop = source.index('    for(size_t ib=0;', start)
    end = source.index('    bench_kernel_ns+=', loop)
    body = source[loop:end]
    assert body.count('FWP_TICK();') == 1
    helper = ('static inline __attribute__((always_inline)) void fwp_matrix_product_f64('
              'size_t m, size_t k, size_t n, const unsigned char *a, '
              'const unsigned char *b, unsigned char *restrict out) {\n'
              + body + '}\n')
    call = '    fwp_matrix_product_f64(m,k,n,a,b,out);\n'
    candidate = source[:start] + helper + source[start:loop] + call + source[end:]
    assert candidate.count(body) == 1
    return candidate, dict(freshOutputParameters=1)


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
    environment = dict(os.environ)
    results, hashes, changed = {}, {}, {}
    for profile in [False, True]:
        suffix = 'profile' if profile else 'timing'
        binaries = {}
        filename = f'matrix-{suffix}.c'
        source = (args.input / filename).read_text()
        digest = hashlib.sha256(source.encode()).hexdigest()
        recorded = [value for key, value in evidence['sourceHashes'].items() if key.endswith('/' + filename)]
        assert recorded == [digest], (filename, recorded, digest)
        hashes[filename] = digest
        assert 'FWP_ARC_ONLY' not in source
        candidate, count = separate_output(source)
        changed[filename] = count
        for mode, code in [('parameter', candidate), ('local', source)]:
            label = f'{mode}-{suffix}'
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
                symbols = run(['nm', binary]).stdout
                assert 'fwp_matrix_product_f64' not in symbols, 'kernel helper must inline'
                assert not any(symbol in symbols for symbol in ['fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'])
        labels = list(binaries)
        if not profile:
            for binary in binaries.values():
                run([binary], environment)
        for process in range(1 if profile else 4):
            order = labels[process % 2:] + labels[:process % 2]
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
    assert clean(results['parameter-profile']) == clean(results['local-profile'])
    for mode, counts in [('parameter', (0, 0, 16)), ('local', (0, 0, 16))]:
        for sample in results[f'{mode}-profile']['samples']:
            assert tuple(sample[key] for key in ['retains', 'nonlastReleases', 'releaseChecks']) == counts, sample
            assert sample['requests'] == 40 and sample['liveChargedBytes'] == 0, sample
    summary = {label: dict(medianKernelNs=statistics.median(row['kernelNs'] for row in record['samples']),
                          medianAllocationInclusiveNs=statistics.median(row['allocationInclusiveNs'] for row in record['samples']))
               for label, record in results.items() if label.endswith('-timing')}
    hardware = dict(uname=run(['uname', '-a']).stdout, machine=platform.machine(),
                    cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout)
    report = dict(head=os.environ['GITHUB_SHA'], emittedHead=evidence['head'], evidenceRun=os.environ['EVIDENCE_RUN'],
                  sourceHashes=hashes, changedOutputDeclarations=changed, hardware=hardware, compiler=run([cc, '--version']).stdout,
                  buildCommands=commands, results=results, summary=summary,
                  scope='Same-run matrix experiment: the existing local restrict output pointer versus the identical loop in an always-inlined helper with a restrict output parameter. Only fresh output is disjoint; inputs may alias. The emitted baseline C is hash-verified. Kernel arithmetic, checks, scheduler ticks, allocation and ownership profiles must agree. Four alternating two-binary batches give twenty samples per binary after warmup; profiles are separate. Native symbols must exclude an out-of-line helper and collector symbols. This is an emitted-C experiment, not changed-compiler acceptance, C/Rust parity or a portable speed claim.')
    (output / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
