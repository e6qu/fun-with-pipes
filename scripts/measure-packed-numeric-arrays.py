"""Runner-only typed worker signatures, bit bridges and target ABI evidence."""
from pathlib import Path
import hashlib,json,os,platform,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
ROOT=Path.cwd();OUT=Path(os.environ['FWP_NUMERIC_LAYOUT_ARTIFACTS']);OUT.mkdir(parents=True,exist_ok=True)
HEAD='cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
subprocess.run(['git','merge-base','--is-ancestor',HEAD,'HEAD'],check=True)
changed=set(subprocess.check_output(['git','diff','--name-only',HEAD,'HEAD'],text=True).splitlines())
assert changed <= {'CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md'} | {'src/cgen.rs','src/proto.rs','tests/protocol.rs','tests/fixtures/protocol_count_probe.c','scripts/finalize-numeric-storage.py','.github/workflows/ci.yml','tests/packed_numeric_storage.rs','tests/array_size_limits.rs','tests/wasm.rs','tests/fixtures/numeric_layout_probe.c','tests/fixtures/packed_array_size_probe.c','tests/array_element_ownership.rs','tests/kernel_stack_bounds.rs','tests/fixtures/kernel_stack_probe.c','tests/fixtures/packed_array_memory_probe.c','scripts/measure-packed-array-memory.py','scripts/measure-packed-numeric-arrays.py','tests/fixtures/numeric_layout_baseline.fwp','tests/fixtures/packed_numeric_arrays.fwp','tests/run/unboxed_records.fwp','.github/workflows/packed-numeric-arrays.yml'} | { 'runtime/'+n for n in ['fwp_rt.c','fwp_rt_gc.c','fwp_rt_ops.c','fwp_rt_prims.c','fwp_rt_num.c','fwp_rt_json.c','fwp_rt_exec.c','fwp_rt_kernel.c'] }
fixture=ROOT/'tests/fixtures/numeric_layout_baseline.fwp'
env=dict(os.environ);env.pop('FWP_NO_OPT',None);env.pop('FWP_TYPED_ABI',None);env.pop('FWP_PACKED_ARRAYS',None)
def run(*argv,environment=None):
 p=subprocess.run(argv,env=environment or env,capture_output=True)
 if p.returncode:raise RuntimeError(str(argv)+'\n'+p.stderr.decode(errors='replace'))
 return p.stdout
run('cargo','build','--bin','fwp')
fwp=ROOT/'target/debug/fwp';reference=run(str(fwp),'run','--interp',str(fixture),environment=dict(env,FWP_NO_OPT='1'))
(OUT/'raw.stdout').write_bytes(reference)
# The original golden record program must agree in both ABI modes.
record_fixture=ROOT/'tests/run/unboxed_records.fwp'
def execute(argv, environment):
 p=subprocess.run(argv,env=environment,capture_output=True)
 return p.stdout,p.stderr,p.returncode
record_reference=execute([str(fwp),'run','--interp',str(record_fixture)],dict(env,FWP_NO_OPT='1'))
stdout,stderr,status=record_reference
rendered=stdout+(b'--- stderr\n'+stderr if stderr else b'')+(b'--- exit '+str(status).encode()+b'\n' if status else b'')
assert rendered==record_fixture.with_suffix('.out').read_bytes()
(OUT/'records.original.out').write_bytes(rendered)
for mode in ['0','1']:
 for opt in ['-O1','-O2']:
  executable=OUT/('records-'+mode+opt);run(str(fwp),'build',opt,str(record_fixture),'-o',str(executable),environment=dict(env,FWP_TYPED_ABI=mode))
  assert execute([str(executable)],dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'))==record_reference
for opt in ['-O1','-O2']:
 binary=OUT/('original'+opt);run(str(fwp),'build',opt,str(fixture),'-o',str(binary));actual=run(str(binary),environment=dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'));assert actual==reference
 (OUT/('original'+opt+'.stdout')).write_bytes(actual)
packed_fixture=ROOT/'tests/fixtures/packed_numeric_arrays.fwp'
packed_reference=execute([str(fwp),'run','--interp',str(packed_fixture)],dict(env,FWP_NO_OPT='1'))
assert packed_reference[2]==0
for packing in ['0','1']:
 for reuse in ['0','1']:
  for opt in ['-O1','-O2']:
   binary=OUT/('packed-'+packing+'-reuse'+reuse+opt)
   run(str(fwp),'build',opt,str(packed_fixture),'-o',str(binary),environment=dict(env,FWP_PACKED_ARRAYS=packing,FWP_REUSE=reuse))
   assert execute([str(binary)],dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'))==packed_reference
cfile=OUT/'baseline.original.c';run(str(fwp),'build','--fn','step','--emit-c',str(fixture),'-o',str(cfile));source=cfile.read_text();marker=source.index('/* step :');symbol='f'+source[marker:].split('static V f',1)[1].split('(',1)[0]
main='int main(int argc, char **argv)';assert source.count(main)==1
probe=r'''
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    V result=fSTEP(257);
    const char *names[]={"I8","U8","I16","U16","I32","U32","F32","F64"};
    const int kinds[]={K_I8,K_U8,K_I16,K_U16,K_I32,K_U32,K_F32,K_F64};
    const size_t widths[]={1,1,2,2,4,4,4,8};
    const V words[]={UINT64_C(0xffffffffffffff80),UINT64_C(255),UINT64_C(0xffffffffffff8000),UINT64_C(65535),UINT64_C(0xffffffff80000000),UINT64_C(4294967295),UINT64_C(0x80000000),UINT64_C(0x8000000000000000)};
    if (OBJ(result)->n!=8) return 120;
    if (sizeof(fwp_arr)!=8 || offsetof(fwp_arr,d)!=8 || sizeof(V)!=8) return 121;
    printf("{\"headerBytes\":%zu,\"payloadOffset\":%zu,\"wordBytes\":%zu,\"wordAlignment\":%zu,\"arrays\":[",sizeof(fwp_arr),offsetof(fwp_arr,d),sizeof(V),_Alignof(V));
    for (size_t k=0;k<8;k++) {
        V a=OBJ(result)->f[k];
        const fwp_desc elem={.kind=kinds[k]};
        size_t width=fwp_array_stride(&elem);
        if (width!=widths[k] || fwp_array_len(a)!=257 || ((uintptr_t)fwp_array_data(a))%width) return 122;
        for (size_t i=0;i<257;i++) {
            if (fwp_array_load(a,i,&elem)!=words[k]) return 123;
            if (memcmp(fwp_array_data(a)+i*width,&words[k],width)) return 133;
        }
        printf("%s{\"type\":\"%s\",\"length\":257,\"elementBytes\":%zu,\"firstWord\":\"%016llx\",\"storageRequestBytes\":%zu}",k?",":"",names[k],width,(unsigned long long)fwp_array_load(a,0,&elem),sizeof(fwp_arr)+257*width);
    }
    puts("]}");
    if (!fwp_rc_release_last(result)) return 124;
    for (size_t k=0;k<8;k++) {V a=OBJ(result)->f[k];if (!fwp_rc_release_last(a)) return 125;fwp_rc_free_arr(a);}
    fwp_rc_free_obj(result);return 0;
}
'''
measured=OUT/'baseline.bytes.c';measured.write_text(source.replace(main,'int original_main(int argc, char **argv)')+'\n#include <stddef.h>\n'+probe.replace('fSTEP',symbol))
helper=OUT/'compile.rs';helper.write_text('fn main() { let a: Vec<String> = std::env::args().collect(); fwp::cgen::compile_c(&std::fs::read_to_string(&a[1]).unwrap(), std::path::Path::new(&a[2]), &a[3]).unwrap(); }\n')
libraries=list((ROOT/'target/debug/deps').glob('libfwp-*.rlib'));assert len(libraries)==1
compiler=OUT/'compile';run('rustc','--edition=2021',str(helper),'--extern','fwp='+str(libraries[0]),'-L','dependency='+str(ROOT/'target/debug/deps'),'-o',str(compiler))
results={}
for opt in ['-O1','-O2']:
 binary=OUT/('bytes'+opt);run(str(compiler),str(measured),str(binary),opt)
 output=run(str(binary),environment=dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'));(OUT/('bytes'+opt+'.json')).write_bytes(output);results[opt]=json.loads(output)
 assert [x['elementBytes'] for x in results[opt]['arrays']]==[1,1,2,2,4,4,4,8]
# Keep no-inline diagnostics separate from production flags and claims.
wrapper=OUT/'diagnostic-cc';wrapper.write_text('#!/bin/sh\nexec clang -fno-inline "$@"\n');wrapper.chmod(0o755)
diagnostic=OUT/'abi-diagnostic';run(str(compiler),str(measured),str(diagnostic),'-O2',environment=dict(env,CC=str(wrapper)))
command=['otool','-tvV',str(diagnostic)] if platform.system()=='Darwin' else ['objdump','-d',str(diagnostic)]
(OUT/'abi-diagnostic.asm').write_bytes(run(*command));(OUT/'abi-diagnostic.symbols').write_bytes(run('nm','-a',str(diagnostic)))
abi_results={}
for function in ['floats','scalar']:
 original=OUT/(function+'.original.c');run(str(fwp),'build','--fn',function,'--emit-c',str(fixture),'-o',str(original));body=original.read_text();at=body.index('/* '+function+' :');entry='f'+body[at:].split('static V f',1)[1].split('(',1)[0]
 if function=='floats':
  check='V r=fENTRY(fwp_from_f64(1.25)); if (OBJ(r)->n!=3) return 126; const double expected[]={1.25,1.5,-1.25}; for(size_t i=0;i<3;i++) if(OBJ(r)->f[i]!=fwp_from_f64(expected[i])) return 127; printf("{\\"structBytes\\":%zu,\\"fieldBytes\\":%zu}\\n",sizeof(fwp_wrWORKER),sizeof(((fwp_wrWORKER*)0)->f0)); if(!fwp_rc_release_last(r))return 128;fwp_rc_free_obj(r);'
 else:
  check='if(fENTRY(fwp_from_f64(1.25))!=fwp_from_f64(1.375))return 129;puts("{\\"returnWordBytes\\":8}");'
 code='int main(void) {fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();'+check.replace('fENTRY',entry).replace('WORKER',entry[1:])+'return 0;}\n'
 candidate=OUT/(function+'.bytes.c');candidate.write_text(body.replace(main,'int original_main(int argc, char **argv)')+'\n'+code)
 binary=OUT/(function+'-production');run(str(compiler),str(candidate),str(binary),'-O2');output=run(str(binary),environment=dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'));abi_results[function]=json.loads(output);(OUT/(function+'.json')).write_bytes(output)
 production=OUT/(function+'-production')
 if production.exists():
  command=['otool','-tvV',str(production)] if platform.system()=='Darwin' else ['objdump','-d',str(production)]
  (OUT/(function+'.production.asm')).write_bytes(run(*command))
 binary=OUT/(function+'-diagnostic');run(str(compiler),str(candidate),str(binary),'-O2',environment=dict(env,CC=str(wrapper)))
 command=['otool','-tvV',str(binary)] if platform.system()=='Darwin' else ['objdump','-d',str(binary)]
 (OUT/(function+'.asm')).write_bytes(run(*command));(OUT/(function+'.symbols')).write_bytes(run('nm','-a',str(binary)))
# Exact negative-zero and NaN payloads must survive ordinary worker bridges.
for function,kind,ctype,width,words in [('bits64','f64','double',8,[0,0x8000000000000000,0x7ff8000000001234,0x7ff0000000001234]),('bits32','f32','float',4,[0,0x80000000,0x7fc01234,0x7f801234])]:
 original=OUT/(function+'.original.c');run(str(fwp),'build','--fn',function,'--emit-c',str(fixture),'-o',str(original));body=original.read_text();at=body.index('/* '+function+' :');entry='f'+body[at:].split('static V f',1)[1].split('(',1)[0];worker=entry[1:]
 literals=','.join('UINT64_C('+str(x)+')' for x in words)
 controls=f'_Static_assert(sizeof(fwp_wr{worker})==3*{width},"natural aggregate width");\n_Static_assert(_Generic(((fwp_wr{worker}*)0)->f0,{ctype}:1,default:0),"native field type");\n'
 code=f'int main(void) {{fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();const V bits[]={{{literals}}};for(size_t j=0;j<4;j++){{ V r={entry}(bits[j]);for(size_t k=0;k<3;k++)if(OBJ(r)->f[k]!=bits[j])return 130;if(!fwp_rc_release_last(r))return 131;fwp_rc_free_obj(r);}}puts("exact-bit bridges passed");return 0;}}\n'
 candidate=OUT/(function+'.bytes.c');candidate.write_text(body.replace(main,'int original_main(int argc, char **argv)')+'\n'+controls+code)
 for opt in ['-O1','-O2']:
  binary=OUT/(function+opt);run(str(compiler),str(candidate),str(binary),opt);run(str(binary),environment=dict(env,FWP_GC_STRESS='1',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='1'))
 binary=OUT/(function+'-diagnostic');run(str(compiler),str(candidate),str(binary),'-O2',environment=dict(env,CC=str(wrapper)));command=['otool','-tvV',str(binary)] if platform.system()=='Darwin' else ['objdump','-d',str(binary)];(OUT/(function+'.asm')).write_bytes(run(*command));(OUT/(function+'.symbols')).write_bytes(run('nm','-a',str(binary)))
# Require the scalar worker to use double input and output at its C boundary.
scalar_source=(OUT/'scalar.bytes.c').read_text();original=(OUT/'scalar.original.c').read_text();at=original.index('/* scalar :');worker=original[at:].split('static V f',1)[1].split('(',1)[0]
assert f'static double w{worker}(double al0)' in original
static=f'_Static_assert(_Generic(&w{worker},double (*)(double):1,default:0),"typed scalar ABI");\n'
scalar_probe=OUT/'scalar.signature.c';scalar_probe.write_text(scalar_source.replace('int main(void)',static+'int main(void)'));run(str(compiler),str(scalar_probe),str(OUT/'scalar-signature'),'-O2');run(str(OUT/'scalar-signature'))
print('Typed scalar/aggregate signatures and exact floating payload controls passed',flush=True)
report=dict(head=HEAD,driver=os.environ['GITHUB_SHA'],hardware=run('uname','-a').decode(),compiler=run('clang','--version').decode(),rust=run('rustc','--version').decode(),productionOptimization=['-O1','-O2'],diagnosticExtraFlags=['-fno-inline'],results=results,abiResults=abi_results,hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in OUT.iterdir() if p.is_file()},limits='Typed scalar/aggregate worker ABI with exact-bit, original record goldens, raw/native and GC/reuse controls. Packed numeric arrays, views and descriptor bridges pass raw/native mode comparisons. storageRequestBytes is header plus payload size, not libc usable size or complete allocation/live-memory accounting. Diagnostic assembly is separate; no timing, packed-layout, wider-format, or tracing-free claim.')
(OUT/'baseline.json').write_text(json.dumps(report,indent=2)+'\n');print('Packed numeric arrays, views and typed ABI controls passed',flush=True)
