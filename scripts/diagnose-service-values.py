from pathlib import Path
import re
import subprocess
import sys

compiler, cc = sys.argv[1:]
out = Path('service-diagnostic')
out.mkdir(exist_ok=True)
cfile = out / 'program.c'
subprocess.run([compiler, 'build', '--emit-c', 'tests/fixtures/service_values.fwp', '-o', str(cfile)], check=True)
code = cfile.read_text()
def descriptor(function):
    prefix = 'return ' + function + '('
    return next(line.strip()[len(prefix):-2] for line in code.splitlines() if line.strip().startswith(prefix) and line.strip().endswith(');'))
types = '#define METADATA_TYPE (' + descriptor('fwp_p_grpc_metadata') + ')\n#define SUBJECT_TYPE (' + descriptor('fwp_p_grpc_peer_subject') + ')\n'
code = code.replace('#define FWP_UNWIND 0', '#define FWP_UNWIND 1').replace('typedef uint64_t V;', 'typedef uint64_t V;\nstatic void service_allocation(void);')
for marker, hook in [('static inline void *fwp_alloc_init(size_t n) {', ' service_allocation();'), ('static inline void *fwp_heap_alloc(size_t n, int kind) {', ' if(kind!=0) service_allocation();')]:
    assert code.count(marker)==1
    code = code.replace(marker, marker + hook)
fixture = Path('tests/fixtures/service_values_cleanup.c').read_text()
# Keep the same assertions and execution; distinguish the shared exit code.
fixture = '\n'.join(line.replace('return 247;', '{fprintf(stderr,"service assertion line %d\\n",__LINE__);return 247;}') for line in fixture.splitlines())
fixture = fixture.replace('if(!completed||failed!=(operation?2:12))', 'fprintf(stderr,"operation=%d failed=%d completed=%d\\n",operation,failed,completed); if(!completed||failed!=(operation?2:12))')
source = code[:code.index('int main(')] + types + '\n#line 1 "service_values_cleanup.c"\n' + fixture
(out / 'probe.c').write_text(source)
subprocess.run([cc, '--version'],check=True)
for opt in ['-O1','-O2']:
    exe = out / ('probe' + opt)
    command = [cc,opt,'-std=gnu11','-ffp-contract=off',str(out/'probe.c'),'-o',str(exe),'-lssl','-lcrypto','-lm','-lpthread']
    subprocess.run(command,check=True)
    result = subprocess.run([str(exe)],capture_output=True,text=True)
    print(opt,'exit',result.returncode, 'stdout',result.stdout,'stderr',result.stderr,flush=True)
