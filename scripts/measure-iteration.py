#!/usr/bin/env python3
"""Runner-only current-compiler iterator/state memory and native-code evidence."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
CASES = {
    'array': 'flip array.generate id | array.to-list | iter.from-list | iter.map (mul 2) | iter.filter (rem 3 | eq 0) | iter.fold add 0',
    'iterate': 'sub 1000 | iter.iterate (add 2) | iter.take 1000 | iter.fold add 0',
    'fold': 'sub 1000 | iter.count-from | iter.take 1000 | iter.fold add 0',
    'each': 'sub 1000 | run-state 0 (iter.count-from | iter.take 1000 | iter.each (add | modify)) | .1',
    'find': 'sub 1000 | iter.count-from | iter.take 1000 | iter.find (gt 25)',
    'pipeline': 'sub 1000 | iter.count-from | iter.take 1000 | iter.map (add 1) | iter.filter (rem 2 | eq 0) | iter.fold add 0',
    'fold-until': 'range 0 | fold-until (add | flip compose (if (gt 100) Stop Again)) 0',
    'map-accum': 'range 0 | map-accum (add | flip compose (both id id)) 0 | .1',
}


def run(args, env=None):
    p = subprocess.run(list(map(str, args)), cwd=ROOT, env=env, text=True, capture_output=True)
    if p.returncode:
        raise RuntimeError(f'{args}: {p.stdout}\n{p.stderr}')
    return p


def wrap(code, signature, name, parameters, count):
    start = code.index(signature)
    opening = code.index('{', start)
    depth = 1
    end = opening + 1
    while depth:
        depth += (code[end] == '{') - (code[end] == '}')
        end += 1
    body = code[start:end].replace(name + '(', name + '_unmeasured(', 1)
    wrapper = signature + '\n' + count + f'\nvoid *p = {name}_unmeasured({parameters});\niteration_sample();\nreturn p;\n}}'
    return code[:start] + body + '\n' + wrapper + code[end:]


def instrument(code):
    declaration = '''typedef uint64_t V;
static int iteration_active;
static uint64_t iteration_requests, iteration_bytes, iteration_retains;
static double iteration_start_charge, iteration_peak;
static void iteration_sample(void);
'''
    assert code.count('typedef uint64_t V;') == 1
    code = code.replace('typedef uint64_t V;', declaration)
    code = wrap(code, 'static inline void *fwp_gc_alloc(size_t n, int leaf) {',
                'fwp_gc_alloc', 'n, leaf',
                'if(iteration_active && leaf!=0){iteration_requests++;iteration_bytes+=n;}')
    code = wrap(code, 'static inline void *fwp_alloc_init(size_t n) {',
                'fwp_alloc_init', 'n',
                'if(iteration_active){iteration_requests++;iteration_bytes+=n;}')
    retain = 'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {'
    assert code.count(retain) == 1
    code = code.replace(retain, retain + '\nif(iteration_active)iteration_retains++;')
    main = code.index('static void *fwp_main_thread(void *arg) {')
    prefix, body = code[:main], code[main:]
    sample = '''static double iteration_charge(void){return fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);}
static void iteration_sample(void){if(iteration_active){double live=iteration_charge()-iteration_start_charge;if(live>iteration_peak)iteration_peak=live;}}
'''
    assert body.count('    fwp_init_consts();\n') == 1
    assert body.count('    /* Ownership observation point: before runtime teardown. */\n') == 1
    body = body.replace('    fwp_init_consts();\n', '    fwp_init_consts();\n    iteration_start_charge=iteration_charge();iteration_active=1;\n')
    body = body.replace('    /* Ownership observation point: before runtime teardown. */\n', '''    /* Ownership observation point: before runtime teardown. */
    iteration_active=0;
    fprintf(stderr,"{\\"requests\\":%llu,\\"requestedBytes\\":%llu,\\"retains\\":%llu,\\"peakChargedBytes\\":%.0f,\\"finalChargedBytes\\":%.0f,\\"collections\\":%zu}\\n",(unsigned long long)iteration_requests,(unsigned long long)iteration_bytes,(unsigned long long)iteration_retains,iteration_peak,iteration_charge()-iteration_start_charge,fwp_gc.ncollect);
''')
    return prefix + sample + body



def loop_evidence(code):
    workers = []
    for section in code.split('/* loop of fused-iter')[1:]:
        worker = section[:section.index('\n}\n')]
        # Only forcing a lazy source tail may remain dynamically dispatched in
        # these known-callback probes. Filter paths contain separate call sites.
        tail_calls = len(re.findall(r'fwp_apply_owned\([^,]+, 1, \(V\[\]\)\{\(V\)0\}\)', worker))
        assert worker.count('fwp_apply_') == tail_calls
        assert 'fwp_record(' not in worker and 'fwp_closure(' not in worker
        workers.append(dict(tailCallSites=tail_calls, dynamicConsumerCallSites=0,
                            stateRecordConstructions=0))
    return workers


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    results = {}
    for name, expression in CASES.items():
        source = out / (name + '.fwp')
        source.write_text('main = () | args | head | option.and-then parse-int | option.unwrap-or 1000\n    | ' + expression + ' | echo\n')
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1')).stdout
        variants = ((True, True), (True, False), (False, False)) if name in ('fold', 'each', 'find', 'pipeline', 'iterate', 'array') else ((True, True),)
        for fused, producers in variants:
            label = name if producers else name + ('-consumer-only' if fused else '-unfused')
            variant_env = dict(environment, FWP_ITER_CONSUMERS='1' if fused else '0', FWP_ITER_PRODUCERS='1' if producers else '0')
            cfile = out / (label + '.c')
            run([compiler, 'build', '--gc', 'tracing', '-O2', '--emit-c', source, '-o', cfile], variant_env)
            workers = loop_evidence(cfile.read_text())
            if name in ('fold', 'each', 'find', 'pipeline', 'iterate', 'array'):
                assert bool(workers) == fused, (name, fused, workers)
                if producers:
                    assert all(w['tailCallSites'] == 0 for w in workers), (name, workers)
            profile = out / (label + '-profile.c')
            profile.write_text(instrument(cfile.read_text()))
            commands = []
            binary = out / label
            for path, executable in [(cfile, binary), (profile, out / (label + '-profile'))]:
                command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', path, '-o', executable, '-lm', '-lpthread']
                run(command, variant_env)
                commands.append(list(map(str, command)))
            samples = []
            for _ in range(5):
                start = time.perf_counter_ns()
                actual = run([binary, '1000'], variant_env)
                samples.append(time.perf_counter_ns() - start)
                assert actual.stdout == reference, (name, actual.stdout, reference)
            measured = run([out / (label + '-profile'), '1000'], variant_env)
            assert measured.stdout == reference
            counters = json.loads(measured.stderr)
            assert counters['collections'] == 0, (name, counters)
            asm = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
            (out / (label + '.asm')).write_text(run(asm).stdout)
            (out / (label + '.symbols')).write_text(run(['nm', binary]).stdout)
            results[label] = dict(output=reference, counters=counters, processWallNs=samples,
                                 medianProcessWallNs=statistics.median(samples), commands=commands,
                                 sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                                 generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                                 consumerFusion=fused, producerFusion=producers, fusedLoopWorkers=workers)
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(),
                  hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '--version', '--verbose']).stdout,
                  elements=1000, results=results,
                  scope='Allocation-inclusive process timings include startup, runtime argument parsing and output. Memory probes are separate binaries; charged live storage excludes allocator metadata. Peak sampled after every managed allocation; zero collections required. No speed threshold or comparison with C/Rust is asserted.')
    report['comparisons'] = {name: {key: results[name + '-unfused']['counters'][key] - results[name]['counters'][key] for key in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes')} for name in ('fold', 'each', 'find', 'pipeline', 'iterate', 'array')}
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    for name, reduction in report['comparisons'].items():
        assert reduction['requests'] > 0, (name, reduction)
        assert reduction['requestedBytes'] > 0, (name, reduction)
    print(json.dumps({name: r['counters'] for name, r in results.items()}, indent=2))


if __name__ == '__main__':
    main()
