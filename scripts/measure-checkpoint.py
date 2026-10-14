#!/usr/bin/env python3
"""Runner-only checkpoint recomputation/storage tradeoff on equivalent VJPs."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('iteration_measurement', ROOT / 'scripts/measure-iteration.py')
iteration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(iteration)
run = iteration.run

LEDGER = r'''
static struct {void *p;size_t bytes;} checkpoint_blocks[64];
static uint64_t checkpoint_requests, checkpoint_bytes;
static size_t checkpoint_live, checkpoint_peak;
static void *checkpoint_realloc(void *old,size_t bytes){
    size_t i=0;while(i<64 && (old?checkpoint_blocks[i].p!=old:checkpoint_blocks[i].p!=NULL))i++;
    if(i==64)abort();void *p=realloc(old,bytes?bytes:1);if(!p)abort();
    checkpoint_requests++;checkpoint_bytes+=bytes;
    checkpoint_live-=checkpoint_blocks[i].bytes;checkpoint_live+=bytes;
    checkpoint_blocks[i].p=p;checkpoint_blocks[i].bytes=bytes;
    if(checkpoint_live>checkpoint_peak)checkpoint_peak=checkpoint_live;
    return p;
}
static void *checkpoint_calloc(size_t n,size_t bytes){
    if(n && bytes>SIZE_MAX/n)abort();void *p=checkpoint_realloc(NULL,n*bytes);memset(p,0,n*bytes);return p;
}
static void checkpoint_free(void *p){
    if(!p)return;size_t i=0;while(i<64 && checkpoint_blocks[i].p!=p)i++;
    if(i==64)abort();checkpoint_live-=checkpoint_blocks[i].bytes;
    memset(&checkpoint_blocks[i],0,sizeof checkpoint_blocks[i]);free(p);
}
'''


def instrument(code):
    start = code.index('/* ------------------------------------------------------------------ tapes */')
    end = code.index('/* ---------------------------------------------------------------- kernels */', start)
    tape = re.sub(r'\b(realloc|calloc|free)\(', lambda m: 'checkpoint_' + m[1] + '(', code[start:end])
    code = code[:start] + LEDGER + tape + code[end:]
    code = iteration.instrument(code)
    marker = '    fwp_cl_finish();\n'
    assert code.count(marker) == 1
    return code.replace(marker, marker + r'''
    fwp_tape_finish();
    if(checkpoint_live)exit(211);
    fprintf(stderr,"{\"tapeRequests\":%llu,\"tapeRequestedBytes\":%llu,\"peakTapeBytes\":%zu,\"finalTapeBytes\":%zu}\n",
        (unsigned long long)checkpoint_requests,(unsigned long long)checkpoint_bytes,checkpoint_peak,checkpoint_live);
''')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_AD_WORKSPACE='0', FWP_GC_STRESS='0',
                       FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    results = {}
    reference = None
    for interval in [None, 16, 32, 64]:
        label = 'full-tape' if interval is None else f'checkpoint-{interval}'
        call = 'vjp (rev._replay 4096 (map (add 1.0))) [1.0]' if interval is None else (
            f'vjp-checkpointed {{steps = 4096, every = {interval}}} (map (add 1.0)) [1.0]')
        source = out / (label + '.fwp')
        source.write_text(f'main = [2.0] | {call} | echo\n')
        raw = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1')).stdout
        assert raw == '[1.0]\n', raw
        if reference is None:
            reference = raw
        assert raw == reference
        cfile = out / (label + '.c')
        run([compiler, 'build', '--gc', 'arc', '--emit-c', '-o', cfile, source], environment)
        profile = out / (label + '-profile.c')
        profile.write_text(instrument(cfile.read_text()))
        commands = []
        binary = out / label
        measured_binary = out / (label + '-profile')
        for code, executable in [(cfile, binary), (profile, measured_binary)]:
            command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', code,
                       '-o', executable, '-lm', '-lpthread']
            run(command, environment)
            commands.append(list(map(str, command)))
        samples = []
        for _ in range(7):
            start = time.perf_counter_ns()
            actual = run([binary], environment)
            samples.append(time.perf_counter_ns() - start)
            assert actual.stdout == reference and not actual.stderr
        measured = run([measured_binary], environment)
        assert measured.stdout == reference
        tape, managed = map(json.loads, measured.stderr.splitlines())
        assert tape['finalTapeBytes'] == 0 and managed['collections'] == 0
        assert managed['finalChargedBytes'] == 0, managed
        asm = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
        (out / (label + '.asm')).write_text(run(asm).stdout)
        results[label] = dict(interval=interval, output=reference, tape=tape, managed=managed,
                              processWallNs=samples, medianProcessWallNs=statistics.median(samples),
                              commands=commands, sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                              generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest())
    for label, result in results.items():
        if label != 'full-tape':
            assert result['tape']['peakTapeBytes'] < results['full-tape']['tape']['peakTapeBytes']
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(),
                  hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '-vV']).stdout,
                  steps=4096, results=results,
                  scope='ARC, no workspace cache. Equivalent additive VJPs with explicit recomputation intervals. '
                        'Separate profiles count managed allocation requests and charged live bytes plus actual C tape buffers. '
                        'Process timings include startup and output; no speedup threshold. Allocator metadata and OS reservations are excluded.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({key: dict(tape=value['tape'], managed=value['managed']) for key, value in results.items()}, indent=2))


if __name__ == '__main__':
    main()
