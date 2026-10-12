"""Publish verified numerical sources and current docs as one production PR."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes');REPO='repos/e6qu/fun-with-pipes'
BASE=json.loads(Path('/private/tmp/fwp-numerical-merge-proof.json').read_text())['sha'];BRANCH='checked-arc-and-loop-ownership'
SUBJECT='Complete checked ARC execution and loop ownership optimizations'
RECEIPT=Path('/private/tmp/fwp-ownership-production-publication.json');assert not RECEIPT.exists()
def api(path,payload=None):
 args=['gh','api',REPO+path]
 if payload is not None:
  p=Path('/private/tmp/fwp-ownership-production-api.json');p.write_text(json.dumps(payload));args+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(args))
proof=json.loads(Path('/private/tmp/fwp-complete-ownership-platform-evidence/download.json').read_text())
r=api('/actions/runs/'+str(proof['run']));assert r['head_sha']==proof['head'] and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(proof['run'])+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
acceptance=json.loads(Path('/private/tmp/fwp-accepted-numerical-source/phase4-acceptance.json').read_text());assert acceptance['accepted']==BASE
assert api('/git/ref/heads/main')['object']['sha']==BASE
assert not api('/pulls?state=open&base=main&per_page=100')
probe=subprocess.run(['gh','api',REPO+'/git/ref/heads/'+BRANCH],capture_output=True,text=True);assert probe.returncode!=0 and '404' in probe.stderr
mapping=json.loads(Path('/private/tmp/fwp-ownership-production-files.json').read_text());files={k:Path(v).read_text() for k,v in mapping.items()}
canonical=next(p for p in proof['reports'] if p['platform']=='ubuntu-latest')['formattedSourceHashes']
fixture=json.loads(Path('/private/tmp/fwp-ownership-production-draft/fixture-source.json').read_text());assert fixture['head']==proof['head']
for name,value in files.items():
 digest=hashlib.sha256(value.encode()).hexdigest()
 if name.startswith(('src/','runtime/')) or (name.startswith('tests/') and len(Path(name).parts)==2):assert digest==canonical[Path(name).name],name
 elif name=='tests/fixtures/array_fusion_allocation_probe.c':assert digest==fixture['sha256']
 else:assert name=='.github/workflows/numerics.yml'
# Step is an ordinary declared variant now that fusion registers its fields.
# This reviewed eligibility-only delta is covered by the production matrix;
# the retained preparation measurements describe their recorded source head.
old = ' | "std::Step"'
assert files['src/arc.rs'].count(old) == 1
files['src/arc.rs'] = files['src/arc.rs'].replace(old, '')
reviewed_delta = dict(path='src/arc.rs', removedBuiltinException='std::Step',
    validation='Requires all six exact-head production jobs; preparation evidence retains its original head')
DOCS=['AGENTS.md','CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
for name in DOCS+['docs/measurements/numerical-kernels-2026-10-12.json','docs/measurements/ownership-and-arc-2026-10-12.json']:files[name]=(ROOT/name).read_text()
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
body="""Numerical loops retained carried owners and performed avoidable unwind and descriptor dispatch work. This bundle gives loop fields independent owners, removes scopes from proven nontrapping scalar operations, and makes generated descriptors immutable. Inlining preserves constructed and compile-time aggregate parameter types so stack containers release their children. Fusion registers its synthesized Step variants for typed ownership lowering. Step uses the ordinary variant contract instead of a name-based eligibility exception. Formatting writes directly into one buffer, removing managed rendering temporaries.

An explicit native `--gc arc` mode checks monomorphic types, native declaration provenance and primitive ownership boundaries. Admitted immutable graphs and scoped File values reclaim through counts; the collector body is excluded. Unproved cyclic/mutable graphs, raw tape/pointer owners, boxed I128/U128, custom native declarations and unsupported deployment boundaries diagnose without switching memory mode. Pipe syntax and existing tracing mode remain available.

Validation covers Linux, ARM and Intel macOS: original numerical/AD ownership and cleanup regressions, original in-place allocation thresholds, zero-count loop probes, escaping functions, actual binary symbols/disassembly, physical-free omission and forced-tracing controls. The eligible golden corpus checks semantics and reclamation and lists rejections and expected compiler errors separately. Deep recursion keeps the original native/golden test plus a bounded raw-interpreter comparison. C/Rust comparisons retain hardware, flags, allocations, live memory and uninstrumented timing/assembly; no universal speedup or parity claim.

Full six-job CI and roadmap documentation must pass at this PR head before squash. The final merged-source audit is required before marking phases5–6 complete."""
pr=api('/pulls',dict(title=SUBJECT,head=BRANCH,base='main',body=body,draft=False))
RECEIPT.write_text(json.dumps(dict(head=commit['sha'],base=BASE,tree=tree,branch=BRANCH,pr=pr['number'],url=pr['html_url'],preparationHead=proof['head'],preparationRun=proof['run'],reviewedSourceDelta=reviewed_delta,files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()},docs=DOCS),indent=2)+'\n');print(pr['html_url'],commit['sha'])
