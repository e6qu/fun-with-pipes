"""Runner-only equivalent gradient allocation evidence; exact source and flags retained."""
from pathlib import Path
import json,os,re,subprocess
ROOT=Path.cwd();OUT=Path(os.environ['FWP_AD_ALLOCATION_ARTIFACTS']);OUT.mkdir(parents=True,exist_ok=True)
BASE='602e076604d3dd759c47b396c10cf848dd9dbb61'
CANDIDATE=os.environ['FWP_SCOPE_CANDIDATE']
SOURCE='''loss : List[Rev[F64]] -> Rev[F64]
loss = nth 0 | option.unwrap-or (rev.const 0.0)
step : I64 -> F64
step = const [1.0, 2.0] | grad loss | sum
main = 0 | step | echo
'''
fixture=OUT/'gradient.fwp';fixture.write_text(SOURCE)
env=dict(os.environ);env.pop('FWP_NO_OPT',None)
def run(*args,cwd=ROOT,environment=env):
 p=subprocess.run(args,cwd=cwd,env=environment,capture_output=True)
 if p.returncode:raise RuntimeError(f'{args}: exit {p.returncode}: '+p.stderr.decode(errors='replace'))
 return p.stdout
PROBE=r'''
static void *measured_realloc(void *p,size_t n) {
    measured_external_calls++;measured_external_bytes+=n;return realloc(p,n);
}
static void *measured_calloc(size_t n,size_t size) {
    measured_external_calls++;measured_external_bytes+=n*size;return calloc(n,size);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    uint64_t cold_managed=measured_managed_calls,cold_requested=measured_managed_bytes;
    uint64_t cold_external=measured_external_calls,cold_external_bytes=measured_external_bytes;
    if (fwp_f64(fSTEP(0))!=1) return 81;
    uint64_t warm_calls=measured_managed_calls-cold_managed,warm_bytes=measured_managed_bytes-cold_requested;
    uint64_t warm_external_calls=measured_external_calls-cold_external,warm_external_bytes=measured_external_bytes-cold_external_bytes;
    fwp_gc_collect();
    uint64_t before_calls=measured_managed_calls,before_bytes=measured_managed_bytes;
    uint64_t before_external=measured_external_calls,before_external_bytes=measured_external_bytes;
    for (uint64_t i=0;i<4096;i++) if (fwp_f64(fSTEP(i))!=1) return 82;
    uint64_t calls=measured_managed_calls-before_calls,bytes=measured_managed_bytes-before_bytes;
    uint64_t external=measured_external_calls-before_external,external_bytes=measured_external_bytes-before_external_bytes;
    fwp_gc_collect();
    printf("{\"iterations\":4096,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,"
           "\"externalCalls\":%llu,\"externalRequestedBytes\":%llu,"
           "\"warmManagedCalls\":%llu,\"warmManagedRequestedBytes\":%llu,"
           "\"warmExternalCalls\":%llu,\"warmExternalRequestedBytes\":%llu,"
           "\"liveBytesAfterCollection\":%zu,\"peakLiveBytes\":%zu,\"collections\":%zu,"
           "\"tapeSize\":%zu,\"tapeAlignment\":%zu}\n",
           (unsigned long long)calls,(unsigned long long)bytes,(unsigned long long)external,(unsigned long long)external_bytes,
           (unsigned long long)warm_calls,(unsigned long long)warm_bytes,
           (unsigned long long)warm_external_calls,(unsigned long long)warm_external_bytes,
           fwp_gc.live,fwp_gc.peak,fwp_gc.ncollect,sizeof(fwp_tape),_Alignof(fwp_tape));
    return 0;
}
'''
results={}
for label,head in [('baseline',BASE),('candidate',CANDIDATE)]:
 checkout=ROOT.parent/('ad-allocation-'+label)
 run('git','worktree','add','--detach',str(checkout),head)
 target=OUT/(label+'-target')
 run('cargo','build','--bin','fwp','--target-dir',str(target),cwd=checkout)
 executable=target/'debug/fwp'
 raw=run(str(executable),'run','--interp',str(fixture),environment=dict(env,FWP_NO_OPT='1'))
 (OUT/(label+'.raw.stdout')).write_bytes(raw)
 if label=='baseline':reference=raw
 else:assert raw==reference,'Raw interpreter behavior changed'
 cfile=OUT/(label+'.original.c')
 run(str(executable),'build',str(fixture),'--emit-c','-o',str(cfile))
 source=cfile.read_text()
 marker='static inline void *fwp_gc_alloc(size_t n, int leaf) {'
 assert source.count(marker)==1
 source=source.replace(marker,'static uint64_t measured_managed_calls,measured_managed_bytes;\n'+marker+'\n    measured_managed_calls++;measured_managed_bytes+=n;')
 comment=source.index('/* step :')
 step='f'+source[comment:].split('static V f',1)[1].split('(',1)[0]
 a=source.index('/* ------------------------------------------------------------------ tapes */');b=source.index('/* ---------------------------------------------------------------- kernels */',a)
 declarations='static uint64_t measured_external_calls,measured_external_bytes;\nstatic void *measured_realloc(void *,size_t);\nstatic void *measured_calloc(size_t,size_t);\n'
 tapes=source[a:b].replace('realloc(','measured_realloc(').replace('calloc(','measured_calloc(')
 source=(source[:a]+declarations+tapes+source[b:]).replace('int main(int argc, char **argv)','int original_main(int argc, char **argv)')
 source+='\n'+PROBE.replace('fSTEP',step)
 instrumented=OUT/(label+'.measured.c');instrumented.write_text(source)
 # Reuse the actual repository compilation entry to preserve platform/TLS flags.
 helper=OUT/(label+'-compile.rs')
 helper.write_text('fn main() { let a: Vec<String> = std::env::args().collect(); fwp::cgen::compile_c(&std::fs::read_to_string(&a[1]).unwrap(), std::path::Path::new(&a[2]), &a[3]).unwrap(); }\n')
 libraries=list((target/'debug/deps').glob('libfwp-*.rlib'));assert len(libraries)==1
 helper_bin=OUT/(label+'-compile')
 run('rustc','--edition=2021',str(helper),'--extern','fwp='+str(libraries[0]),'-L','dependency='+str(target/'debug/deps'),'-o',str(helper_bin))
 for opt in ['-O1','-O2']:
  binary=OUT/(label+opt)
  run(str(helper_bin),str(instrumented),str(binary),opt)
  result=subprocess.run([str(binary)],env=dict(env,FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0'),capture_output=True)
  prefix=OUT/(label+opt)
  prefix.with_suffix('.stdout').write_bytes(result.stdout);prefix.with_suffix('.stderr').write_bytes(result.stderr)
  prefix.with_suffix('.status').write_text(str(result.returncode)+'\n')
  assert result.returncode==0,(label,opt,result.returncode,result.stderr.decode(errors='replace'))
  data=json.loads(result.stdout);assert data['iterations']==4096 and data['collections']>=2
  results[label+opt]=dict(head=head,opt=opt,**data)
  print(label,opt,json.dumps(data),flush=True)
 # Build intermediates are not artifacts; emitted source and native binaries are.
 import shutil
 shutil.rmtree(target)
report=dict(baseline=BASE,candidate=CANDIDATE,results=results,
 limits='Equivalent 4096 steady-state gradient calls after one warmup; requested bytes and allocation API calls, not libc usable sizes or timing. Warmup and registry layout reported separately. GC verification enabled; this is not a no-tracing proof.')
(OUT/'comparison.json').write_text(json.dumps(report,indent=2)+'\n')
for opt in ['-O1','-O2']:
 before=results['baseline'+opt];after=results['candidate'+opt]
 assert after['managedCalls']<=before['managedCalls'],('managed allocation count regression',opt,before,after)
 assert after['managedRequestedBytes']<=before['managedRequestedBytes'],('managed allocation byte regression',opt,before,after)
 assert after['externalCalls']==before['externalCalls'] and after['externalRequestedBytes']==before['externalRequestedBytes'],('external steady-state allocation regression',opt,before,after)
print('Scoped gradient steady-state allocation parity verified',flush=True)
