"""Runner-only equivalent C/Rust/generated numerical workloads and memory profiles."""
from pathlib import Path
import hashlib,json,os,platform,re,statistics,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
root=Path.cwd();out=Path(os.environ['FWP_ARRAY_FUSION_ARTIFACTS'])/'performance';out.mkdir(parents=True,exist_ok=True)
cc=os.environ.get('CC','clang');commands=[]
def run(args,environment=None):
 p=subprocess.run(list(map(str,args)),env=environment,capture_output=True,text=True)
 if p.returncode:raise RuntimeError(str(args)+'\n'+p.stdout+'\n'+p.stderr)
 return p
flags=['-O2','-std=gnu11','-ffp-contract=off','-w']
c_source=root/'tests/fixtures/numerical_bench.c';rust_source=root/'tests/fixtures/numerical_bench.rs';harness=(root/'tests/fixtures/numerical_bench_native.c').read_text()
entries={};sources={}
for case,path,label in [('array','original-1.c','reduce64'),('matrix','matrix-original-1.c','product-data')]:
 source=(out.parent/path).read_text();at=source.index('/* '+label+' :');entry='f'+source[at:].split('static V f',1)[1].split('(',1)[0]
 source=source.replace('typedef uint64_t V;','''typedef uint64_t V;
static uint64_t bench_clock(void);static void bench_sample_live(void);
static uint64_t bench_kernel_ns,bench_calls,bench_bytes,bench_retains,bench_nonlast_releases,bench_release_checks;
''',1)
 if case=='matrix':
  start=source.index('static V fwp_p_matrix_mul_f64(');end=start+source[start:].index('return result;\n}')+len('return result;\n}')
  body=source[start:end];assert body.count('for(size_t ib=0;')==1
  body=body.replace('for(size_t ib=0;','bench_sample_live();uint64_t bench_started=bench_clock();\n    for(size_t ib=0;',1)
  body=body.replace('fwp_cleanup_pop(&cleanup);','bench_kernel_ns+=bench_clock()-bench_started;\n    fwp_cleanup_pop(&cleanup);',1)
  source=source[:start]+body+source[end:]
 source=source.replace('int main(int argc, char **argv)','int original_main(int argc, char **argv)')+'\n'+harness.replace('fBENCH_ENTRY',entry)
 sources[case]=source
results={}
for profile in [False,True]:
 suffix='profile' if profile else 'timing'
 binaries={}
 for language,src,cmd in [
  ('c',c_source,[cc,*flags,'-DPROFILE='+str(int(profile)),str(c_source),'-o',str(out/('c-'+suffix))]),
  ('rust',rust_source,['rustc','--edition=2021','-C','opt-level=2',*(['--cfg','memory_profile'] if profile else []),str(rust_source),'-o',str(out/('rust-'+suffix))]),
 ]:
  run(cmd);commands.append(cmd);binaries[language]=out/(language+'-'+suffix)
 for case,source in sources.items():
  if profile:
   changes={
    'static inline void *fwp_gc_alloc(size_t n, int leaf) {':'static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){bench_calls++;bench_bytes+=n;}',
    'static inline void *fwp_alloc_init(size_t n) {':'static inline void *fwp_alloc_init(size_t n) {\nbench_calls++;bench_bytes+=n;',
    'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {':'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {\n        bench_retains++;',
    'static inline void fwp_rc_drop_slot(uint8_t *slot) {':'static inline void fwp_rc_drop_slot(uint8_t *slot) {\nbench_nonlast_releases++;',
    'static inline int fwp_rc_release_last(V v) {':'static inline int fwp_rc_release_last(V v) {\nbench_release_checks++;',
   }
   for before,after in changes.items():assert source.count(before)==1,before;source=source.replace(before,after,1)
  path=out/(case+'-'+suffix+'.c');path.write_text(source)
  binary=out/('fwp-'+case+'-'+suffix);cmd=[cc,*flags,'-DPROFILE='+str(int(profile)),'-DMATRIX_BENCH='+str(int(case=='matrix')),str(path),'-o',str(binary),'-lm','-lpthread'];run(cmd);commands.append(cmd)
  binaries['fwp-'+case]=binary
 for case in ['array','matrix']:
  for language in ['c','rust','fwp']:
   binary=binaries[language if language!='fwp' else 'fwp-'+case];args=[str(binary)]+([] if language=='fwp' else [case])
   timed=['/usr/bin/time', '-l' if platform.system()=='Darwin' else '-v',*args]
   env=dict(os.environ,FWP_GC_STRESS='0',FWP_GC_VERIFY='0',FWP_REUSE_VERIFY='0')
   p=run(timed,env);data=json.loads(p.stdout)
   if platform.system()=='Darwin':match=re.search(r'(\d+)\s+maximum resident set size',p.stderr);scale=1
   else:match=re.search(r'Maximum resident set size \(kbytes\):\s*(\d+)',p.stderr);scale=1024
   assert match,p.stderr
   data['peakProcessRssBytes']=int(match[1])*scale
   data['environment']={k:env[k] for k in ['FWP_GC_STRESS','FWP_GC_VERIFY','FWP_REUSE_VERIFY']}
   data['profileInstrumented']=profile;data['invocation']=timed
   key=case+'-'+language+'-'+suffix;results[key]=data;(out/(key+'.json')).write_text(json.dumps(data,indent=2)+'\n');(out/(key+'-process.txt')).write_text(p.stderr)
   if profile:
    expected=8 if case=='array' else (40 if language=='fwp' else 24)
    assert all(s['requests']==expected for s in data['samples']),(key,data)
for case in ['array','matrix']:
 hashes={s['hash'] for key,r in results.items() if key.startswith(case+'-') for s in r['samples']};assert len(hashes)==1,(case,hashes)
summary={key:dict(medianAllocationInclusiveNs=statistics.median(s['allocationInclusiveNs'] for s in r['samples']),medianKernelNs=statistics.median(s['kernelNs'] for s in r['samples']),peakProcessRssBytes=r['peakProcessRssBytes']) for key,r in results.items() if key.endswith('-timing')}
hardware={'uname':run(['uname','-a']).stdout,'machine':platform.machine()}
hardware['cpu']=run(['sysctl','-n','machdep.cpu.brand_string'] if platform.system()=='Darwin' else ['lscpu']).stdout
report=dict(head=os.environ['GITHUB_SHA'],hardware=hardware,compiler=run([cc,'--version']).stdout,rustCompiler=run(['rustc','--version','--verbose']).stdout,buildCommands=commands,workloads={'array':dict(elements=65537,rounds=8,samples=5,kernelScope='Consumes the existing input and releases it; input allocation/fill excluded, ownership cost included.'),'matrix':dict(rows=65,inner=67,columns=63,tile=32,rounds=8,samples=5,kernelScope='Multiply/accumulate only, after output allocation and zeroing; input construction and all cleanup are in allocation-inclusive time.')},results=results,summary=summary,sourceHashes={str(p.relative_to(root)) if p.is_relative_to(root) else str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in [c_source,rust_source,root/'tests/fixtures/numerical_bench_native.c',*out.glob('*.c')]},scope='Identical dimensions, inputs, ordered arithmetic and result hashes. Timings use separate uninstrumented binaries; instrumented profile timings are not compared. C/Rust memory is allocator-requested payload. Native charged bytes include allocator size classes, exclude metadata, and are sampled at proven allocation peaks with no collections. Peak process RSS comes from each executable independently. No shared-runner timing threshold is asserted.')
(out/'comparison.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(summary,indent=2))
