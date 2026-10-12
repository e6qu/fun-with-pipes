"""Export formatted source only after the coherent representation controls pass."""
from pathlib import Path
import gzip,hashlib,json,os,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
BASE='cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
PRIOR='21117f4971e838cf3ccfcf8aa001be804d16bc44'
OUT=Path('numeric-storage-finalization');OUT.mkdir(exist_ok=True)
def run(*a):return subprocess.check_output(a,text=True)
prior=json.loads(run('gh','run','view','38200555737','--repo','e6qu/fun-with-pipes','--json','headSha,status,conclusion,jobs'))
assert prior['headSha']==PRIOR and prior['status']=='completed' and prior['conclusion']=='success'
assert len(prior['jobs'])==3 and all(j['conclusion']=='success' for j in prior['jobs'])
run('cargo','fmt','--all','--','--check')
run('python3','scripts/check-roadmap.py')
environment=dict(os.environ,FWP_INVENTORY_EXPECTED_HEAD=os.environ['GITHUB_SHA'])
subprocess.run(['python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(OUT/'inventory.json')],env=environment,check=True)
subprocess.run(['python3','scripts/check-explicit-fallback-review.py','--inventory',str(OUT/'inventory.json'),'--review','tests/fixtures/primitive-fallback-review.json','--output',str(OUT/'fallback-review.json')],check=True)
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
FILES=['src/cgen.rs','src/proto.rs','.github/workflows/ci.yml','tests/array_element_ownership.rs','tests/array_size_limits.rs','tests/kernel_stack_bounds.rs','tests/fixtures/kernel_stack_probe.c','tests/packed_numeric_storage.rs','tests/wasm.rs','tests/protocol.rs','tests/fixtures/numeric_layout_baseline.fwp','tests/fixtures/packed_numeric_arrays.fwp','tests/fixtures/packed_array_memory_probe.c','tests/fixtures/packed_array_size_probe.c','tests/fixtures/numeric_layout_probe.c','tests/fixtures/protocol_count_probe.c','tests/run/unboxed_records.fwp']+['runtime/'+n for n in ['fwp_rt.c','fwp_rt_gc.c','fwp_rt_ops.c','fwp_rt_prims.c','fwp_rt_num.c','fwp_rt_json.c','fwp_rt_exec.c','fwp_rt_kernel.c']]
files={name:Path(name).read_text() for name in FILES+DOCS}
assert sum(len(v.encode()) for v in files.values())<8*1024*1024
with gzip.open(OUT/'production-files.json.gz','wt') as f:json.dump(files,f)
report=dict(driver=os.environ['GITHUB_SHA'],base=BASE,priorHead=PRIOR,priorGate=prior,files={name:hashlib.sha256(value.encode()).hexdigest() for name,value in files.items()},scope='Formatted production source and docs; focused native/WASI/ABI/memory/protocol controls passed. Full six-job production gate and actual merged-source acceptance remain required.')
(OUT/'finalization.json').write_text(json.dumps(report,indent=2)+'\n')
print('Exported formatted numeric representation bundle; full production gates remain required')
