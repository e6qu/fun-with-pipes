#!/usr/bin/env python3
"""Runner evidence for checked native I128/U128 workers and boxed boundaries."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
iteration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(iteration)
run = iteration.run


def main():
    import argparse
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    results = {}
    for kind in ('I128', 'U128'):
        suffix = kind.lower()
        source = out / (suffix + '.fwp')
        source.write_text(f'''rec sum-wide : {kind} -> {kind}
sum-wide = if (eq 0{suffix}) (const 0{suffix}) (fork add id (sub 1{suffix} | sum-wide))
main = 256{suffix} | sum-wide | echo
''')
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1')).stdout
        assert reference == '32896\n', reference
        for enabled in ('0', '1'):
            label = suffix + ('-native' if enabled == '1' else '-boxed')
            env = dict(environment, FWP_WIDE_WORKERS=enabled)
            cfile = out / (label + '.c')
            run([compiler, 'build', '--gc', 'arc', '--emit-c', source, '-o', cfile], env)
            code = cfile.read_text()
            assert ('/* native wide worker:' in code) == (enabled == '1')
            workers = []
            for section in code.split('/* native wide worker:')[1:]:
                worker = section.split('\nstatic V f', 1)[0]
                assert 'fwp_box_' not in worker and 'fwp_alloc' not in worker
                workers.append(worker)
            profile = out / (label + '-profile.c')
            profile.write_text(iteration.instrument(code))
            commands = []
            for path, executable in ((cfile, out / label), (profile, out / (label + '-profile'))):
                command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', path, '-o', executable, '-lm', '-lpthread']
                run(command, env)
                commands.append(list(map(str, command)))
            samples = []
            for _ in range(5):
                start = time.perf_counter_ns()
                actual = run([out / label], env)
                samples.append(time.perf_counter_ns() - start)
                assert actual.stdout == reference
            measured = run([out / (label + '-profile')], env)
            assert measured.stdout == reference
            counters = json.loads(measured.stderr)
            assert counters['collections'] == 0 and counters['finalChargedBytes'] <= 0, counters
            binary = out / label
            asm = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
            (out / (label + '.asm')).write_text(run(asm).stdout)
            (out / (label + '.symbols')).write_text(run(['nm', binary]).stdout)
            results[label] = dict(output=reference, counters=counters, commands=commands,
                processWallNs=samples, medianProcessWallNs=statistics.median(samples),
                sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(), nativeWorkers=len(workers))
        assert results[suffix + '-native']['counters']['requests'] < results[suffix + '-boxed']['counters']['requests']
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        cc=run([cc, '--version']).stdout, rustc=run(['rustc', '--version', '--verbose']).stdout,
        elements=256, results=results,
        scope='Equivalent checked arithmetic with worker lowering enabled/disabled. Fixed 256-element source workload. Process timings include startup and output; no speed threshold. Separate instrumented binaries count managed requests, retains and charged live storage, excluding allocator metadata. Native disassembly and symbols are retained. No universal C/Rust parity claim.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: r['counters'] for name, r in results.items()}, indent=2))


if __name__ == '__main__':
    main()
