#!/usr/bin/env python3
"""Runner-only comparison of equivalent typed hashes in fwp, C and Rust."""
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
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>
static uint64_t byte(uint64_t h,uint64_t b){return (h^(b&255))*UINT64_C(0x100000001b3);}
static uint64_t word(uint64_t h,uint64_t x){for(int i=0;i<8;i++)h=byte(h,x>>(8*i));return h;}
static uint64_t length(uint64_t h,uint64_t n){do{unsigned b=n&127;n>>=7;h=byte(h,b|(n?128:0));}while(n);return h;}
int main(void){
 uint64_t *data=malloc(N*sizeof *data);if(!data)return 102;
 for(size_t i=0;i<N;i++)data[i]=i;
 uint64_t result=0;
 for(uint64_t iteration=0;iteration<REPEATS;iteration++){
  uint64_t h=word(UINT64_C(0xcbf29ce484222325),iteration);h=length(h,N);
  for(size_t i=0;i<N;i++)h=word(h,data[i]);result^=h;
 }
 free(data);printf("%"PRIu64"\n",result);
#if PROFILE
 fprintf(stderr,"{\"arrayAllocationRequests\":1,\"arrayRequestedBytes\":%zu,\"peakArrayBytes\":%zu,\"finalArrayBytes\":0}\n",N*sizeof(uint64_t),N*sizeof(uint64_t));
#endif
 return 0;
}
'''
RUST_SOURCE = r'''
#[cfg(profile)] use allocations::{REQUESTS,BYTES,PEAK,LIVE};
#[cfg(profile)] use std::sync::atomic::Ordering::Relaxed;
#[cfg(profile)] mod allocations {
 use std::alloc::{GlobalAlloc,Layout,System};use std::sync::atomic::{AtomicBool,AtomicUsize,Ordering::Relaxed};
 pub static ACTIVE:AtomicBool=AtomicBool::new(false);pub static REQUESTS:AtomicUsize=AtomicUsize::new(0);
 pub static BYTES:AtomicUsize=AtomicUsize::new(0);pub static LIVE:AtomicUsize=AtomicUsize::new(0);pub static PEAK:AtomicUsize=AtomicUsize::new(0);
 pub struct Counted;unsafe impl GlobalAlloc for Counted {
  unsafe fn alloc(&self,l:Layout)->*mut u8{let p=System.alloc(l);if ACTIVE.load(Relaxed)&&!p.is_null(){REQUESTS.fetch_add(1,Relaxed);BYTES.fetch_add(l.size(),Relaxed);let live=LIVE.fetch_add(l.size(),Relaxed)+l.size();PEAK.fetch_max(live,Relaxed);}p}
  unsafe fn dealloc(&self,p:*mut u8,l:Layout){if ACTIVE.load(Relaxed){LIVE.fetch_sub(l.size(),Relaxed);}System.dealloc(p,l)}
 }
}
#[cfg(profile)] #[global_allocator] static ALLOCATOR:allocations::Counted=allocations::Counted;
fn byte(h:u64,b:u64)->u64{(h^(b&255)).wrapping_mul(0x100000001b3)}
fn word(mut h:u64,x:u64)->u64{for i in 0..8{h=byte(h,x>>(8*i));}h}
fn length(mut h:u64,mut n:u64)->u64{loop{let b=n&127;n>>=7;h=byte(h,b|if n!=0{128}else{0});if n==0{return h;}}}
fn main(){
 #[cfg(profile)] allocations::ACTIVE.store(true,std::sync::atomic::Ordering::Relaxed);
 let data:Vec<u64>=(0..N as u64).collect();let mut result=0u64;
 for iteration in 0..REPEATS {let mut h=word(0xcbf29ce484222325,iteration);h=length(h,N as u64);for &v in &data{h=word(h,v);}result^=h;}
 drop(data);
 #[cfg(profile)] allocations::ACTIVE.store(false,std::sync::atomic::Ordering::Relaxed);
 println!("{result}");
 #[cfg(profile)] {
 eprintln!("{{\"arrayAllocationRequests\":{},\"arrayRequestedBytes\":{},\"peakArrayBytes\":{},\"finalArrayBytes\":{}}}",REQUESTS.load(Relaxed),BYTES.load(Relaxed),PEAK.load(Relaxed),LIVE.load(Relaxed));}
}
'''
BUFFERED = '''fwp_buf b={0};fwp_encode(&b,v,d);uint64_t h=0xcbf29ce484222325ULL;
for(size_t i=0;i<b.len;i++){h^=(unsigned char)b.d[i];h*=0x100000001b3ULL;}
free(b.d);return h;'''


def profile(code):
    code = iteration.instrument(code)
    marker = 'typedef struct { char *d; size_t len, cap; } fwp_buf;'
    assert code.count(marker) == 1
    code = code.replace(marker, marker + '\nstatic int hash_profile_active;\nstatic uint64_t hash_profile_requests,hash_profile_bytes;\nstatic size_t hash_profile_peak;\n')
    marker = '        char *data = (char *)realloc(b->d, cap);'
    assert code.count(marker) == 1
    code = code.replace(marker, '        if(hash_profile_active){hash_profile_requests++;hash_profile_bytes+=cap;if(cap>hash_profile_peak)hash_profile_peak=cap;}\n'+marker)
    marker = 'static uint64_t fwp_hash(V v, const fwp_desc *d) {'
    assert code.count(marker) == 1
    start = code.index(marker); finish = code.index('\n}', start)+2
    function = code[start:finish].replace('fwp_hash(', 'hash_profile_body(', 1)
    wrapper = '\n'+marker+'hash_profile_active=1;uint64_t h=hash_profile_body(v,d);hash_profile_active=0;return h;}\n'
    code = code[:start]+function+wrapper+code[finish:]
    code = code.replace('/* numeric hash without type dispatch */',
                        '/* numeric hash without type dispatch */ hash_profile_active=1;')
    code = code.replace('return hash_state;', 'hash_profile_active=0; return hash_state;')
    start = code.index('static void *fwp_main_thread(void *arg) {')
    prefix, body = code[:start], code[start:]
    marker = '    fwp_cl_finish();\n'
    assert body.count(marker) == 1
    body = body.replace(marker, marker+r'''
    fprintf(stderr,"{\"hashBufferRequests\":%llu,\"hashBufferRequestedBytes\":%llu,\"peakHashBufferCapacityBytes\":%zu}\n",(unsigned long long)hash_profile_requests,(unsigned long long)hash_profile_bytes,hash_profile_peak);
''')
    return prefix+body


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure only on GitHub runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve(); out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'; cc = os.environ['CC']
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0',
               FWP_ARRAY_FUSION='1', FWP_MAP_BUILD='1')
    env.pop('FWP_NO_OPT', None); env.pop('FWP_GC', None)
    result = {}
    for name, n, repeats, collection in [('small', 16, 4096, 'array'),
                                        ('large', 4096, 1024, 'array'),
                                        ('set', 65536, 64, 'set')]:
        directory = out / name; directory.mkdir(exist_ok=True)
        constructor = {'array': 'array.from-list', 'set': 'set.from-list'}[collection]
        program = f'main = range 0 {repeats} | map (both id (const (range 0 {n} | {constructor})) | hash) | fold bit.xor 0u64 | echo\n'
        source = directory / 'hash.fwp'; source.write_text(program)
        expected = run([compiler, 'run', '--interp', source], dict(env, FWP_NO_OPT='1')).stdout
        variants, binaries = {}, {}
        for label in ['fwp-tracing', 'fwp-arc', 'fwp-arc-generic', 'fwp-arc-buffered', 'c', 'rust']:
            cfile = directory / (label+'.c'); binary = directory / label
            emit_ns = 0
            if label.startswith('fwp'):
                memory = 'tracing' if label == 'fwp-tracing' else 'arc'
                typed = '0' if label in ['fwp-arc-generic', 'fwp-arc-buffered'] else '1'
                before = time.perf_counter_ns(); run([compiler, 'build', '--gc', memory, '--emit-c', source, '-o', cfile], dict(env, FWP_TYPED_HASH=typed))
                emit_ns = time.perf_counter_ns()-before; code = cfile.read_text()
                assert ('/* numeric hash without type dispatch */' in code) == (typed == '1'), label
                assert f'return fwp_p_{collection}_range(l0, l1,' in code, (name, label)
                if label.endswith('buffered'):
                    needle = 'return fwp_hash_value(0xcbf29ce484222325ULL, v, d);'; assert code.count(needle) == 1
                    code = code.replace(needle, BUFFERED); cfile.write_text(code)
                measured = directory / (label+'-profile.c'); measured.write_text(profile(code))
            elif label == 'c':
                code = f'#define N ((size_t){n})\n#define REPEATS {repeats}\n'+C_SOURCE
                cfile.write_text(code); measured = cfile
            else:
                cfile = directory / 'reference.rs'; cfile.write_text(f'const N:usize={n};const REPEATS:u64={repeats};\n'+RUST_SOURCE); measured = cfile
            commands = []
            for instrumented, input_path, destination in [(False,cfile,binary),(True,measured,directory/(label+'-profile'))]:
                command = (['rustc', '--edition=2021', '-C', 'opt-level=2', input_path, '-o', destination]+(['--cfg','profile'] if instrumented else []) if label == 'rust' else
                           [cc,'-O2','-std=gnu11','-ffp-contract=off','-w',f'-DPROFILE={int(instrumented)}',input_path,'-o',destination,'-lm','-lpthread'])
                before = time.perf_counter_ns(); run(command, env); duration = time.perf_counter_ns()-before
                commands.append(dict(command=list(map(str, command)), wallNs=duration))
            timed = run(['/usr/bin/time', '-l' if platform.system() == 'Darwin' else '-v', binary], env)
            assert timed.stdout == expected
            pattern, scale = (r'(\d+)\s+maximum resident set size', 1) if platform.system() == 'Darwin' else (r'Maximum resident set size \(kbytes\):\s*(\d+)',1024)
            rss = re.search(pattern,timed.stderr); assert rss,timed.stderr
            (directory/(label+'-rss.txt')).write_text(timed.stderr)
            measured_run = run([directory/(label+'-profile')], dict(env,FWP_GC='off') if label.startswith('fwp') else env)
            assert measured_run.stdout == expected
            counters = [json.loads(line) for line in measured_run.stderr.splitlines()]
            if label.startswith('fwp'):
                assert len(counters) == 2 and counters[1]['finalChargedBytes'] == counters[1]['collections'] == 0,counters
                assert bool(counters[0]['hashBufferRequests']) == label.endswith('buffered'),counters
            else:
                assert len(counters) == 1 and counters[0]['finalArrayBytes'] == 0,counters
            assembly = run(['otool','-tvV',binary] if platform.system() == 'Darwin' else ['objdump','-d',binary]).stdout
            (directory/(label+'.asm')).write_text(assembly)
            variants[label] = dict(sourceSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                assemblySha256=hashlib.sha256(assembly.encode()).hexdigest(),sourceBytes=cfile.stat().st_size,binaryBytes=binary.stat().st_size,
                emitWallNs=emit_ns,builds=commands,profile=counters,unprofiledProcessPeakRssBytes=int(rss[1])*scale,samples=[])
            binaries[label] = binary
        labels = list(binaries)
        for sample in range(2 * len(labels)):
            order = labels[sample % len(labels):]+labels[:sample % len(labels)]
            if sample >= len(labels):
                order.reverse()
            for label in order:
                before_cpu=resource.getrusage(resource.RUSAGE_CHILDREN); before=time.perf_counter_ns()
                execution=run([binaries[label]],env);elapsed=time.perf_counter_ns()-before;after_cpu=resource.getrusage(resource.RUSAGE_CHILDREN)
                assert execution.stdout == expected and not execution.stderr
                cpu=(after_cpu.ru_utime+after_cpu.ru_stime-before_cpu.ru_utime-before_cpu.ru_stime)*1e9
                variants[label]['samples'].append(dict(order=order,wallNs=elapsed,childCpuNs=round(cpu)))
        for row in variants.values():
            row['medianWallNs']=statistics.median(sample['wallNs'] for sample in row['samples'])
            row['medianChildCpuNs']=statistics.median(sample['childCpuNs'] for sample in row['samples'])
        ratios = {label:{reference:{'wall':row['medianWallNs']/variants[reference]['medianWallNs'],
                                   'cpu':row['medianChildCpuNs']/variants[reference]['medianChildCpuNs']}
                         for reference in ['c','rust','fwp-arc-generic','fwp-arc-buffered']} for label,row in variants.items() if label.startswith('fwp')}
        length_bytes = max(1, (n.bit_length() + 6) // 7)
        result[name]=dict(collection=collection,elements=n,repetitions=repeats,canonicalBytesPerHash=8+length_bytes+8*n,source=program,expected=expected,variants=variants,ratios=ratios)
    report=dict(head=run(['git','rev-parse','HEAD']).stdout.strip(),hardware=platform.uname()._asdict(),
                cpu=run(['sysctl','-n','machdep.cpu.brand_string'] if platform.system()=='Darwin' else ['lscpu']).stdout,
                cCompiler=run([cc,'--version']).stdout,rustCompiler=run(['rustc','--version','--verbose']).stdout,results=result,
                scope='Each case builds one ordered I64 array or set containing 0..N-1, hashes the canonical tuple (iteration, collection) with wrapping FNV-1a, and XORs the hashes. C/Rust store the same ordered keys in an array/vector and encode the same schema directly; there is no sorting in any construction. fwp-tracing and fwp-arc use type-specialized loops (FWP_TYPED_HASH=1); fwp-arc-generic uses descriptor dispatch (FWP_TYPED_HASH=0). The buffered control also selects generic dispatch and restores an encoded byte buffer. The iteration prefix changes each hash. One unprofiled RSS/warmup process precedes twelve balanced rotating/reversed wall/child-CPU samples including startup, input construction and printing; compilation and allocation profiles are separate. All use optimization level 2; C uses -ffp-contract=off. All fwp variants use the same compiler with array and collection fusion explicitly enabled. fwp counters distinguish managed storage from hash encoding-buffer requests/capacity; collection is disabled only for ownership profiles. C counts its explicit successful application malloc; Rust counts actual application allocator calls while its vector is live. These exclude allocator-internal and stdio storage; fwp managed counts can include output values. Peak RSS comes from uninstrumented programs. Ratios above one mean extra fwp time; no parity or universal speedup is assumed.')
    (out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({name:case['ratios'] for name,case in result.items()},indent=2))

if __name__ == '__main__':
    main()
