"""Runner-only equivalent Array fusion behavior and actual allocation controls."""
from pathlib import Path
import hashlib,json,os,platform,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=Path(os.environ['FWP_ARRAY_FUSION_ARTIFACTS']);OUT.mkdir(exist_ok=True,parents=True)
env=dict(os.environ);env.pop('FWP_NO_OPT',None)
def execute(args,environment=env):return subprocess.run(args,env=environment,capture_output=True)
def run(*args,environment=env):
 p=execute(args,environment)
 if p.returncode:raise RuntimeError(str(args)+'\n'+p.stderr.decode(errors='replace'))
 return p.stdout
run('cargo','build','--bin','fwp')
fwp=ROOT/'target/debug/fwp';fixture=ROOT/'tests/fixtures/numeric_array_fusion.fwp'
reference=execute([str(fwp),'run','--interp',str(fixture)],dict(env,FWP_NO_OPT='1'));assert reference.returncode==0
for mode in ['0','1']:
 for opt in ['-O1','-O2']:
  binary=OUT/('semantics-'+mode+opt);run(str(fwp),'build',opt,str(fixture),'-o',str(binary),environment=dict(env,FWP_ARRAY_FUSION=mode))
  p=execute([str(binary)],dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'))
  assert (p.stdout,p.stderr,p.returncode)==(reference.stdout,reference.stderr,reference.returncode)
helper=OUT/'compile.rs';helper.write_text('fn main() { let a: Vec<String> = std::env::args().collect(); fwp::cgen::compile_c(&std::fs::read_to_string(&a[1]).unwrap(), std::path::Path::new(&a[2]), &a[3]).unwrap(); }\n')
libs=list((ROOT/'target/debug/deps').glob('libfwp-*.rlib'));assert len(libs)==1
compiler=OUT/'compile';run('rustc','--edition=2021',str(helper),'--extern','fwp='+str(libs[0]),'-L','dependency='+str(ROOT/'target/debug/deps'),'-o',str(compiler))
reports={}
for mode in ['0','1']:
 cfile=OUT/('original-'+mode+'.c');run(str(fwp),'build','--fn','reduce64','--emit-c',str(fixture),'-o',str(cfile),environment=dict(env,FWP_ARRAY_FUSION=mode))
 source=cfile.read_text();at=source.index('/* reduce64 :');entry='f'+source[at:].split('static V f',1)[1].split('(',1)[0]
 probe=(ROOT/'tests/fixtures/array_fusion_allocation_probe.c').read_text().replace('fREDUCE64',entry).replace('FUSED',mode)
 source=source.replace('typedef uint64_t V;','typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes;')
 source=source.replace('static inline void *fwp_gc_alloc(size_t n, int leaf) {','static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){measured_calls++;measured_bytes+=n;}')
 source=source.replace('static inline void *fwp_alloc_init(size_t n) {','static inline void *fwp_alloc_init(size_t n) {\nmeasured_calls++;measured_bytes+=n;')
 source=source.replace('int main(int argc, char **argv)','int original_main(int argc, char **argv)')+'\n'+probe
 path=OUT/('measured-'+mode+'.c');path.write_text(source)
 for opt in ['-O1','-O2']:
  binary=OUT/('measured-'+mode+opt);run(str(compiler),str(path),str(binary),opt)
  data=run(str(binary),environment=dict(env,FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0'))
  reports[binary.name]=json.loads(data);(OUT/(binary.name+'.json')).write_bytes(data)
 command=['otool','-tvV',str(binary)] if platform.system()=='Darwin' else ['objdump','-d',str(binary)]
 (OUT/('production-'+mode+'.asm')).write_bytes(run(*command))
report=dict(head=os.environ['GITHUB_SHA'],hardware=run('uname','-a').decode(),compiler=run('clang','--version').decode(),optimization=['-O1','-O2'],results=reports,hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in OUT.iterdir() if p.is_file()},scope='Equivalent source and inputs, only Array fusion differs. Complete managed API allocation counters include initializer fast paths and exclude GC page overhead. No timing or whole-process memory claim.')
(OUT/'comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('Array numeric fusion semantics and zero managed-allocation controls passed')
