#!/usr/bin/env python3
"""Runner-only F64 lane pipelines beside equivalent stack-array C and Rust."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import resource
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
iteration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(iteration)
run = iteration.run
C_SOURCE = r'''
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
int main(void) {
 double weights[N]; for(int lane=0;lane<N;lane++) weights[lane]=0.5;
 double total=0.0;
 for(int step=0;step<REPEATS;step++) {
  double input[N], product[N];
  for(int lane=0;lane<N;lane++) input[lane]=(double)step;
  for(int lane=0;lane<N;lane++) product[lane]=input[lane]*weights[lane];
  double dot=product[0];for(int lane=1;lane<N;lane++)dot+=product[lane];total+=dot;
 }
 printf("Some %"PRId64"\n",(int64_t)total);
#if PROFILE
 fprintf(stderr,"{\"applicationHeapRequests\":0,\"declaredArrayBytes\":%zu,\"finalApplicationHeapBytes\":0}\n",3*N*sizeof(double));
#endif
 return 0;
}
'''
RUST_SOURCE = r'''
#[cfg(profile)] mod allocations {
 use std::alloc::{GlobalAlloc,Layout,System};use std::sync::atomic::{AtomicBool,AtomicUsize,Ordering::Relaxed};
 pub static ACTIVE:AtomicBool=AtomicBool::new(false);pub static REQUESTS:AtomicUsize=AtomicUsize::new(0);
 pub struct Counted;unsafe impl GlobalAlloc for Counted {
  unsafe fn alloc(&self,l:Layout)->*mut u8{let p=System.alloc(l);if ACTIVE.load(Relaxed)&&!p.is_null(){REQUESTS.fetch_add(1,Relaxed);}p}
  unsafe fn dealloc(&self,p:*mut u8,l:Layout){System.dealloc(p,l)}
 }
}
#[cfg(profile)] #[global_allocator] static ALLOCATOR:allocations::Counted=allocations::Counted;
fn main() {
 #[cfg(profile)] allocations::ACTIVE.store(true,std::sync::atomic::Ordering::Relaxed);
 let weights=[0.5f64;N];let mut total=0.0;
 for step in 0..REPEATS {
  let input=[step as f64;N];let mut product=[0.0;N];
  for lane in 0..N {product[lane]=input[lane]*weights[lane];}
  let mut dot=product[0];for lane in 1..N {dot+=product[lane];}total+=dot;
 }
 #[cfg(profile)] allocations::ACTIVE.store(false,std::sync::atomic::Ordering::Relaxed);
 println!("Some {}",total as i64);
 #[cfg(profile)] eprintln!("{{\"applicationHeapRequests\":{},\"declaredArrayBytes\":{},\"finalApplicationHeapBytes\":0}}",allocations::REQUESTS.load(std::sync::atomic::Ordering::Relaxed),3*N*8);
}
'''


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure only on GitHub runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ['CC']
    env = dict(os.environ)
    env.pop('FWP_NO_OPT', None)
    results = {}
    for name, lanes, repeats in [('four-lanes', 4, 32768), ('sixty-four-lanes', 64, 8192)]:
        directory = out / name
        directory.mkdir(exist_ok=True)
        program = (f'dot : Vec[{lanes}, F64] -> F64\ndot = simd.dot (simd.splat 0.5)\n'
                   'as-integer : F64 -> Option[I64]\nas-integer = float.to-int\n'
                   f'main = range 0 {repeats} | map (int.to-float | simd.splat | dot) | sum | as-integer | echo\n')
        source = directory / 'lanes.fwp'
        source.write_text(program)
        expected = run([compiler, 'run', '--interp', source], dict(env, FWP_NO_OPT='1')).stdout
        assert expected == f'Some {lanes * repeats * (repeats - 1) // 4}\n'
        variants, binaries = {}, {}
        for label in ['fwp-arc', 'c', 'rust']:
            cfile = directory / (label + '.c')
            binary = directory / label
            emit_ns = 0
            if label.startswith('fwp'):
                start = time.perf_counter_ns()
                run([compiler, 'build', '--emit-c', source, '-o', cfile], env)
                emit_ns = time.perf_counter_ns() - start
                measured = directory / (label + '-profile.c')
                measured.write_text(iteration.instrument(cfile.read_text()))
            elif label == 'c':
                cfile.write_text(f'#define N {lanes}\n#define REPEATS {repeats}\n' + C_SOURCE)
                measured = cfile
            else:
                cfile = directory / 'reference.rs'
                cfile.write_text(f'const N:usize={lanes};const REPEATS:usize={repeats};\n' + RUST_SOURCE)
                measured = cfile
            commands = []
            for instrumented, input_path, destination in [(False, cfile, binary), (True, measured, directory / (label + '-profile'))]:
                command = (['rustc', '--edition=2021', '-C', 'opt-level=2', input_path, '-o', destination] + (['--cfg', 'profile'] if instrumented else []) if label == 'rust' else
                           [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', f'-DPROFILE={int(instrumented)}', input_path, '-o', destination, '-lm', '-lpthread'])
                start = time.perf_counter_ns()
                run(command, env)
                commands.append(dict(command=list(map(str, command)), wallNs=time.perf_counter_ns() - start))
            timed = run(['/usr/bin/time', '-l' if platform.system() == 'Darwin' else '-v', binary], env)
            assert timed.stdout == expected
            pattern, scale = (r'(\d+)\s+maximum resident set size', 1) if platform.system() == 'Darwin' else (r'Maximum resident set size \(kbytes\):\s*(\d+)', 1024)
            rss = re.search(pattern, timed.stderr)
            assert rss, timed.stderr
            (directory / (label + '-rss.txt')).write_text(timed.stderr)
            observed = run([directory / (label + '-profile')], env)
            assert observed.stdout == expected
            counters = json.loads(observed.stderr)
            if label.startswith('fwp'):
                assert counters['finalChargedBytes'] == 0, counters
                assert set(counters) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
            else:
                assert counters['applicationHeapRequests'] == counters['finalApplicationHeapBytes'] == 0, counters
            assembly = run(['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]).stdout
            (directory / (label + '.asm')).write_text(assembly)
            variants[label] = dict(sourceSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(), binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                assemblySha256=hashlib.sha256(assembly.encode()).hexdigest(), sourceBytes=cfile.stat().st_size, binaryBytes=binary.stat().st_size,
                emitWallNs=emit_ns, builds=commands, profile=counters, unprofiledProcessPeakRssBytes=int(rss[1]) * scale, samples=[])
            binaries[label] = binary
        labels = list(binaries)
        for sample in range(18):
            offset = sample % len(labels)
            order = labels[offset:] + labels[:offset]
            if (sample // len(labels)) % 2:
                order.reverse()
            for label in order:
                cpu_before = resource.getrusage(resource.RUSAGE_CHILDREN)
                start = time.perf_counter_ns()
                observed = run([binaries[label]], env)
                wall = time.perf_counter_ns() - start
                cpu_after = resource.getrusage(resource.RUSAGE_CHILDREN)
                assert observed.stdout == expected and not observed.stderr
                cpu = (cpu_after.ru_utime + cpu_after.ru_stime - cpu_before.ru_utime - cpu_before.ru_stime) * 1e9
                variants[label]['samples'].append(dict(order=order, wallNs=wall, childCpuNs=round(cpu)))
        for row in variants.values():
            row['medianWallNs'] = statistics.median(sample['wallNs'] for sample in row['samples'])
            row['medianChildCpuNs'] = statistics.median(sample['childCpuNs'] for sample in row['samples'])
        ratios = {label: {reference: {'wall': row['medianWallNs'] / variants[reference]['medianWallNs'],
                                      'cpu': row['medianChildCpuNs'] / variants[reference]['medianChildCpuNs']}
                          for reference in ['c', 'rust']} for label, row in variants.items() if label.startswith('fwp')}
        results[name] = dict(lanes=lanes, repetitions=repeats, source=program, expected=expected, variants=variants, ratios=ratios)
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        cCompiler=run([cc, '--version']).stdout, rustCompiler=run(['rustc', '--version', '--verbose']).stdout, results=results,
        scope='Each program fills N F64 lanes with the iteration index, multiplies each by 0.5, sums lanes left to right starting with lane zero, then sums iteration results. All values are exactly representable for these inputs. C/Rust use fixed stack arrays that their compiler may eliminate; fwp uses ordinary Vec pipes and may allocate intermediates. No fast math or multiply-add contraction; optimization level 2. All validate output against raw interpretation. One warmup/RSS process precedes eighteen balanced rotating wall/child-CPU process samples including startup, construction, calculation, checked result conversion in fwp, and printing. C/Rust conversion is valid for these known inputs but does not implement general optional conversion. Compilation and profiles are separate. fwp counts managed requests/retains/charged storage, excluding initial constants; final live storage must return to its baseline. C has no explicit heap allocation; Rust verifies no allocator calls during the calculation. Reference counts exclude startup/printing allocator internals; declared stack-array bytes are source storage, not measured frame size. Full generated code/disassembly, commands and hashes are retained; no SIMD instruction, zero-cost or parity claim follows from the API.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: work['ratios'] for name, work in results.items()}, indent=2))


if __name__ == '__main__':
    main()
