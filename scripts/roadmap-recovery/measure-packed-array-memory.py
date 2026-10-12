"""Measure actual generated numeric slice ownership and allocation boundaries."""
from pathlib import Path
import hashlib,json,os,platform,re,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=Path(os.environ['FWP_NUMERIC_LAYOUT_ARTIFACTS'])/'array-memory';OUT.mkdir(exist_ok=True)
env=dict(os.environ,FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0');env.pop('FWP_NO_OPT',None)
def run(*args,environment=env):
 p=subprocess.run(args,env=environment,capture_output=True)
 if p.returncode:raise RuntimeError(str(args)+'\n'+p.stderr.decode(errors='replace'))
 return p.stdout
fwp=ROOT/'target/debug/fwp';helper=OUT/'compile.rs';helper.write_text('fn main() { let a: Vec<String> = std::env::args().collect(); fwp::cgen::compile_c(&std::fs::read_to_string(&a[1]).unwrap(), std::path::Path::new(&a[2]), &a[3]).unwrap(); }\n')
libs=list((ROOT/'target/debug/deps').glob('libfwp-*.rlib'));assert len(libs)==1
compiler=OUT/'compile';run('rustc','--edition=2021',str(helper),'--extern','fwp='+str(libs[0]),'-L','dependency='+str(ROOT/'target/debug/deps'),'-o',str(compiler))
reports={}
for mode in ['0','1']:
 cfile=OUT/('original-'+mode+'.c');run(str(fwp),'build','--fn','sliced','--emit-c','tests/fixtures/packed_numeric_arrays.fwp','-o',str(cfile),environment=dict(env,FWP_PACKED_ARRAYS=mode))
 source=cfile.read_text();probe=(ROOT/'tests/fixtures/packed_array_memory_probe.c').read_text()
 for name in ['compact-nested','compact','sliced','nested','empty']:
  at=source.index('/* '+name+' :');entry='f'+source[at:].split('static V f',1)[1].split('(',1)[0];probe=probe.replace('f'+name.upper().replace('-','_'),entry)
 drop=re.search(r'/\* Array\[I8\] \*/\nstatic void (fwp_drop\d+)\(V v\) \{',source);assert drop;probe=probe.replace('fARRAY_DROP',drop[1])
 marker='typedef uint64_t V;';assert source.count(marker)==1
 source=source.replace(marker,marker+'\nstatic uint64_t measured_calls,measured_bytes;')
 marker='static inline void *fwp_gc_alloc(size_t n, int leaf) {';assert source.count(marker)==1 and source.count('fwp_gc_alloc(n, 0)')==1
 source=source.replace(marker,marker+'\n    if (leaf != 0) { measured_calls++; measured_bytes+=n; }')
 marker='static inline void *fwp_alloc_init(size_t n) {';assert source.count(marker)==1
 source=source.replace(marker,marker+'\n    measured_calls++; measured_bytes+=n;')
 source=source.replace('int main(int argc, char **argv)','int original_main(int argc, char **argv)')+'\n'+probe
 path=OUT/('measured-'+mode+'.c');path.write_text(source)
 for opt in ['-O1','-O2']:
  binary=OUT/('memory-'+mode+opt);run(str(compiler),str(path),str(binary),opt);output=run(str(binary));(OUT/(binary.name+'.json')).write_bytes(output);reports[binary.name]=json.loads(output)
  if mode=='1':
   for name,old,new,expected in [('omit-backing-retain','fwp_rc_dup(owner);','(void)owner;',135),('omit-backing-drop','v = owner; continue;','return;',143),('omit-initializer-counter','static inline void *fwp_alloc_init(size_t n) {\n    measured_calls++; measured_bytes+=n;','static inline void *fwp_alloc_init(size_t n) {\n    (void)n;',141)]:
    assert old in source
    broken=OUT/(name+opt+'.c');broken.write_text(source.replace(old,new));bad=OUT/(name+opt);run(str(compiler),str(broken),str(bad),opt);p=subprocess.run([str(bad)],env=env,capture_output=True);(OUT/(name+opt+'.status')).write_text(str(p.returncode)+'\n');assert p.returncode==expected,(name,opt,p.returncode,p.stderr.decode(errors='replace'))
report=dict(driver=os.environ['GITHUB_SHA'],hardware=run('uname','-a').decode(),compiler=run('clang','--version').decode(),optimization=['-O1','-O2'],settings={k:env[k] for k in ['FWP_GC_STRESS','FWP_GC_VERIFY','FWP_REUSE_VERIFY']},results=reports,hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in OUT.iterdir() if p.is_file()},limits='Equivalent slice functions in word-layout and packed/view modes. Managed allocation API calls include initializer fast paths and count delegation once. Capacities are rounded managed object slots, not GC page overhead or whole process live bytes. Small views retain their whole backing allocation; this cost is explicit. Physical counted reclamation uses real GC storage with collection stress disabled; this is not tracing-free execution.')
(OUT/'comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('Packed slice ownership, complete counters and omission controls passed')
