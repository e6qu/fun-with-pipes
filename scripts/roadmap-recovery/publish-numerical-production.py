"""Publish verified numerical sources and current docs as one production PR."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes');REPO='repos/e6qu/fun-with-pipes'
BASE='3a4582368f987ddb0233086be50c47995eb4ed3f';BRANCH='numerical-kernels-and-workspaces'
SUBJECT='Fuse numerical pipelines and reuse autodiff workspaces'
RECEIPT=Path('/private/tmp/fwp-numerical-production-publication.json');assert not RECEIPT.exists()
def api(path,payload=None):
 args=['gh','api',REPO+path]
 if payload is not None:
  p=Path('/private/tmp/fwp-numerical-production-api.json');p.write_text(json.dumps(payload));args+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(args))
proof=json.loads(Path('/private/tmp/fwp-numerical-platform-evidence/download.json').read_text())
r=api('/actions/runs/'+str(proof['run']));assert r['head_sha']==proof['head'] and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(proof['run'])+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
assert api('/git/ref/heads/main')['object']['sha']==BASE
assert not api('/pulls?state=open&base=main&per_page=100')
probe=subprocess.run(['gh','api',REPO+'/git/ref/heads/'+BRANCH],capture_output=True,text=True);assert probe.returncode!=0 and '404' in probe.stderr
mapping=json.loads(Path('/private/tmp/fwp-numerical-production-files.json').read_text());files={k:Path(v).read_text() for k,v in mapping.items()}
canonical=next(p for p in proof['reports'] if p['platform']=='ubuntu-latest')['formattedSourceHashes']
prepared=json.loads(Path('/private/tmp/fwp-numerical-lookup-publication.json').read_text());assert prepared['head']==proof['head']
for name,value in files.items():
 digest=hashlib.sha256(value.encode()).hexdigest()
 if name.startswith(('src/','runtime/')) or (name.startswith('tests/') and len(Path(name).parts)==2):assert digest==canonical[Path(name).name],name
 elif name!='.github/workflows/numerics.yml':assert digest==prepared['files'][name],name
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
for name in DOCS+['docs/measurements/numerical-kernels-2026-10-12.json']:files[name]=(ROOT/name).read_text()
parent=api('/git/commits/'+BASE);before=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not before['truncated'];prior={x['path']:(x['sha'],x['mode'],x['type']) for x in before['tree'] if x['type']!='tree'}
entries=[]
for name,value in files.items():
 data=value.encode();assert len(data)<2*1024*1024
 digest=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
 if prior.get(name,(None,))[0]!=digest:entries.append(dict(path=name,mode='100644',type='blob',content=value))
tree=parent['tree']['sha'];batch=[];size=0
for entry in entries:
 length=len(json.dumps(entry).encode());assert length<2*1024*1024
 if batch and size+length>2*1024*1024:
  tree=api('/git/trees',dict(base_tree=tree,tree=batch))['sha'];batch=[];size=0
 batch.append(entry);size+=length
if batch:tree=api('/git/trees',dict(base_tree=tree,tree=batch))['sha']
after=api('/git/trees/'+tree+'?recursive=1');assert not after['truncated'];now={x['path']:(x['sha'],x['mode'],x['type']) for x in after['tree'] if x['type']!='tree'}
assert set(prior)<=set(now) and {k for k in now if now[k]!=prior.get(k)}<=set(files)
for name,value in files.items():
 data=value.encode();assert now[name][0]==hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree,parents=[BASE]));assert commit['message']==SUBJECT and [p['sha'] for p in commit['parents']]==[BASE]
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
body="""Numeric Array pipelines allocate intermediate buffers, matrix multiplication repeatedly traverses boxed values, and autodiff rebuilds private tape buffers. This bundle fuses eligible numeric pipelines, specializes valid F64 matrix shapes into ordered blocked loops, and reuses one bounded autodiff workspace. It preserves Pipe syntax, immutable values, checked traps, arithmetic order and cast-shape behavior.

Borrowed record fields retain their parent lifetime without temporary counts. Lookup lowering keeps original IR nodes, fixing stale loop-tail and unwind metadata. Tape capacity checks precede allocation on native and actual wasm32 targets; scope exit, traps, cancellation and dynamic library unload release private owners.

Validation: the coherent Linux, ARM macOS and Intel macOS preparation passes compiler checks, original AD ownership/scopes, capacity and omission controls, matrix/view aliasing, raw interpreter comparisons and equivalent C/Rust workloads. Measurements include separate uninstrumented timings and disassembly, allocations, reference counts, live memory, collections and hardware/compiler/flag metadata. Stable allocation properties are asserted; timings have no shared-runner threshold. The docs record remaining per-element counting and platform-specific code generation, without claiming C/Rust parity or tracing-free support.

Full six-job production CI and roadmap_docs must pass at the exact PR head before squash."""
pr=api('/pulls',dict(title=SUBJECT,head=BRANCH,base='main',body=body,draft=False))
RECEIPT.write_text(json.dumps(dict(head=commit['sha'],base=BASE,tree=tree,branch=BRANCH,pr=pr['number'],url=pr['html_url'],preparationHead=proof['head'],preparationRun=proof['run'],files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()},docs=DOCS),indent=2)+'\n');print(pr['html_url'],commit['sha'])
