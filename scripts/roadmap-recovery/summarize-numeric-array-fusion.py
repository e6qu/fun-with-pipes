"""Retain metadata from permanent controls; do not rebuild their workloads."""
from pathlib import Path
import hashlib,json,os,platform,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
out=Path(os.environ['FWP_ARRAY_FUSION_ARTIFACTS'])
def command(*args):return subprocess.check_output(args,text=True)
reports={}
for mode in ['0','1']:
 for opt in ['-O1','-O2']:
  p=out/f'permanent-{mode}{opt}.json';reports[p.stem]=json.loads(p.read_text())
 for name in [f'original-{mode}.c',f'measured-{mode}.c',f'production-{mode}.asm']:assert (out/name).is_file()
report=dict(head=os.environ['GITHUB_SHA'],hardware=command('uname','-a'),compiler=command(os.environ.get('CC','cc'),'--version'),rustCompiler=command('rustc','--version','--verbose'),optimization=['-O1','-O2'],compilation='The permanent numeric_array_fusion control invokes fwp::cgen::compile_c with the recorded optimization level; compiler implementation source is included in the export.',results=reports,hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir() if p.is_file()},scope='Raw interpreter/native semantics, complete managed API allocation counters and actual assembly from the same permanent test binaries. Metadata collection performs no duplicate builds. No timing or process-memory claim.')
(out/'comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('Retained permanent Array fusion evidence without rebuilding')
