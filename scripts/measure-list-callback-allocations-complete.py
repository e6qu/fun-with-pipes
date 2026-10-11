"""Runner-only equivalent list callback allocation and reclamation evidence."""
from pathlib import Path
import hashlib,json,os,shutil,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true','Compiled measurements run only on GitHub runners'
ROOT=Path.cwd();OUT=Path(os.environ['FWP_LIST_AP_ARTIFACTS'])/'allocations';OUT.mkdir(parents=True,exist_ok=True)
BASE='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
CANDIDATE=os.environ.get('FWP_LIST_CANDIDATE','4f21a9ea99c1a06a3f1ba67818936194fe43e42a')
SOURCE='''chunk : I64 -> List[String]
chunk = show | repeat 2
export step : I64 -> I64
step = singleton | list.flat-map chunk | list.ap [id, concat "!"] | map string.length | sum
main = 0 | step | echo
'''
fixture=OUT/'pipeline.fwp';fixture.write_text(SOURCE)
env=dict(os.environ);env.pop('FWP_NO_OPT',None);env['CARGO_PROFILE_DEV_DEBUG']='0'
def run(*args,cwd=ROOT,environment=env):
 result=subprocess.run(args,cwd=cwd,env=environment,capture_output=True)
 if result.returncode:raise RuntimeError(f'{args}: exit {result.returncode}: '+result.stderr.decode(errors='replace'))
 return result.stdout
PROBE=r'''
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    uint64_t cold_calls=measured_calls,cold_bytes=measured_bytes;
    if ((int64_t)fSTEP(3)!=6) return 91;
    uint64_t warm_calls=measured_calls-cold_calls,warm_bytes=measured_bytes-cold_bytes;
    fwp_gc_collect();
    uint64_t before_calls=measured_calls,before_bytes=measured_bytes;
    uint64_t before_dup=measured_dup,before_drop=measured_drop,before_share=measured_share,before_clears=measured_clears;
    double before_freed=fwp_gc.freed;
    for(uint64_t i=0;i<2048;i++) {
        uint64_t digits=0,value=i;do { digits++;value/=10; } while(value);
        if ((int64_t)fSTEP(i)!=(int64_t)(4*digits+2)) return 92;
    }
    uint64_t calls=measured_calls-before_calls,bytes=measured_bytes-before_bytes;
    uint64_t duplicates=measured_dup-before_dup,drops=measured_drop-before_drop;
    uint64_t shares=measured_share-before_share,clears=measured_clears-before_clears;
    double freed=fwp_gc.freed-before_freed;
    fwp_gc_collect();
    long rss=fwp_gc_status_kb("VmHWM");
    printf("{\"iterations\":2048,\"managedCalls\":%llu,\"managedRequestedBytes\":%llu,"
           "\"warmManagedCalls\":%llu,\"warmManagedRequestedBytes\":%llu,"
           "\"countedDuplicates\":%llu,\"countedDecrements\":%llu,\"shareCalls\":%llu,\"sharedCountClears\":%llu,"
           "\"managedFreedBytes\":%.0f,\"liveBytesAfterCollection\":%zu,\"peakCollectedLiveBytes\":%zu,"
           "\"collections\":%zu,\"peakRssKiB\":%ld,\"valueSize\":%zu,\"valueAlignment\":%zu}\n",
           (unsigned long long)calls,(unsigned long long)bytes,(unsigned long long)warm_calls,(unsigned long long)warm_bytes,
           (unsigned long long)duplicates,(unsigned long long)drops,(unsigned long long)shares,(unsigned long long)clears,
           freed,fwp_gc.live,fwp_gc.peak,fwp_gc.ncollect,rss,sizeof(V),_Alignof(V));
    return 0;
}
'''
results={}
for label,head in [('baseline',BASE),('candidate',CANDIDATE)]:
 checkout=ROOT.parent/('list-callback-allocation-'+label)
 assert not checkout.exists(),checkout
 run('git','worktree','add','--detach',str(checkout),head)
 target=checkout/'target-measurements'
 run('cargo','build','--bin','fwp','--target-dir',str(target),cwd=checkout)
 executable=target/'debug/fwp'
 raw=run(str(executable),'run','--interp',str(fixture),environment=dict(env,FWP_NO_OPT='1'))
 (OUT/(label+'.raw.stdout')).write_bytes(raw)
 assert raw==b'6\n',raw
 cfile=OUT/(label+'.original.c')
 run(str(executable),'build',str(fixture),'--fn','step','--emit-c','-o',str(cfile))
 source=cfile.read_text()
 marker='typedef uint64_t V;';assert source.count(marker)==1
 source=source.replace(marker,marker+'\nstatic uint64_t measured_calls,measured_bytes,measured_dup,measured_drop,measured_share,measured_clears;')
 marker='static inline void *fwp_gc_alloc(size_t n, int leaf) {';assert source.count(marker)==1
 assert source.count('fwp_gc_alloc(n, 0)') == 1
 source=source.replace(marker,marker+'\n    if (leaf != 0) { measured_calls++;measured_bytes+=n; }')
 marker='static inline void *fwp_alloc_init(size_t n) {';assert source.count(marker)==1
 source=source.replace(marker,marker+'\n    measured_calls++;measured_bytes+=n;')
 marker='static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {';assert source.count(marker)==1
 source=source.replace(marker,marker+'\n        measured_dup++;')
 marker='static inline void fwp_rc_drop_slot(uint8_t *slot) {';assert source.count(marker)==1
 source=source.replace(marker,marker+'\n    measured_drop++;')
 a=source.index('static void fwp_rc_share(V v) {');b=source.index('static inline int fwp_rc_young',a)
 sharing=source[a:b];assert sharing.count('fwp_rc_clear_slot(')==2
 sharing=sharing.replace('static void fwp_rc_share(V v) {','static void fwp_rc_share(V v) {\n    measured_share++;').replace('fwp_rc_clear_slot(c);','measured_clears++;fwp_rc_clear_slot(c);').replace('fwp_rc_clear_slot(d);','measured_clears++;fwp_rc_clear_slot(d);')
 source=source[:a]+sharing+source[b:]
 comment=source.index('/* step :');step='f'+source[comment:].split('static V f',1)[1].split('(',1)[0]
 source=source.replace('int main(int argc, char **argv)','int original_main(int argc, char **argv)')
 source+='\n'+PROBE.replace('fSTEP',step)
 instrumented=OUT/(label+'.measured.c');instrumented.write_text(source)
 helper=OUT/(label+'-compile.rs')
 helper.write_text('fn main() { let a: Vec<String> = std::env::args().collect(); fwp::cgen::compile_c(&std::fs::read_to_string(&a[1]).unwrap(), std::path::Path::new(&a[2]), &a[3]).unwrap(); }\n')
 libraries=list((target/'debug/deps').glob('libfwp-*.rlib'));assert len(libraries)==1
 helper_bin=OUT/(label+'-compile')
 run('rustc','--edition=2021',str(helper),'--extern','fwp='+str(libraries[0]),'-L','dependency='+str(target/'debug/deps'),'-o',str(helper_bin))
 for opt in ['-O1','-O2']:
  binary=OUT/(label+opt);run(str(helper_bin),str(instrumented),str(binary),opt)
  output=subprocess.run([str(binary)],env=dict(env,FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0'),capture_output=True)
  prefix=OUT/(label+opt)
  prefix.with_suffix('.stdout').write_bytes(output.stdout);prefix.with_suffix('.stderr').write_bytes(output.stderr)
  prefix.with_suffix('.status').write_text(str(output.returncode)+'\n')
  assert output.returncode==0,(label,opt,output.returncode,output.stderr.decode(errors='replace'))
  data=json.loads(output.stdout)
  assert data['iterations']==2048 and data['collections']>=2 and data['managedCalls']>0
  assert data['valueSize']==8 and data['valueAlignment']==8 and data['peakRssKiB']>0
  results[label+opt]=dict(head=head,opt=opt,**data)
  print(label,opt,json.dumps(data),flush=True)
 shutil.rmtree(target)
 # Compilation helpers include linked Rust code; the emitted C/native evidence remains.
 helper_bin.unlink()
report=dict(baseline=BASE,candidate=CANDIDATE,results=results,
 sourceHashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in OUT.iterdir() if p.is_file() and (p.suffix in {'.c','.fwp','.rs'} or p.name.endswith(('-O1','-O2')))},
 settings=dict(FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0'),
 limits='Equivalent 2048 runtime-dependent pipeline calls after one warmup. Managed heap allocator API calls/requested bytes, counted increments/decrements and explicit shared count clears, not libc usable sizes or all external allocations. Freed bytes use the runtime counted-storage counter. Peak live bytes are collection samples; RSS is process high-water KiB. No timing or tracing-free claim.')
(OUT/'comparison.json').write_text(json.dumps(report,indent=2)+'\n')
for opt in ['-O1','-O2']:
 before=results['baseline'+opt];after=results['candidate'+opt]
 assert after['managedCalls']<=before['managedCalls'],('managed allocation count regression',opt,before,after)
 assert after['managedRequestedBytes']<=before['managedRequestedBytes'],('managed allocation byte regression',opt,before,after)
 assert after['sharedCountClears']<before['sharedCountClears'],('Sharing was not reduced on the exercised pipeline',opt,before,after)
 assert after['managedFreedBytes']>before['managedFreedBytes'],('The exercised pipeline did not reclaim more counted storage',opt,before,after)
print('Equivalent list callback allocation parity and counted reclamation verified',flush=True)
