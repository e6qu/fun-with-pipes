"""Publish the runner-verified coherent representation bundle on accepted main."""
from pathlib import Path
import base64,gzip,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';ROOT=Path('/Users/zardoz/projects/fun-with-pipes')
OUT=Path('/private/tmp/fwp-numeric-storage-finalization-export');BRANCH='numeric-storage-and-worker-abi'
SUBJECT='Pack numeric arrays and specialize worker ABI boundaries'
RECEIPT=Path('/private/tmp/fwp-numeric-storage-production-publication.json');assert not RECEIPT.exists()
def api(path,payload=None):
 cmd=['gh','api',REPO+path]
 if payload is not None:
  p=Path('/private/tmp/fwp-numeric-production-api-input.json');p.write_text(json.dumps(payload));cmd+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(cmd))
proof=json.loads((OUT/'download.json').read_text());report=json.loads((OUT/'finalization.json').read_text());BASE=report['base']
r=api('/actions/runs/'+str(proof['run']));assert r['head_sha']==proof['driver']==report['driver'] and r['conclusion']=='success' and r['status']=='completed'
assert api('/git/ref/heads/main')['object']['sha']==BASE
assert not api('/pulls?state=open&base=main&per_page=100'), 'Keep one production PR open at a time'
probe=subprocess.run(['gh','api',REPO+'/git/ref/heads/'+BRANCH],capture_output=True,text=True);assert probe.returncode!=0 and '404' in probe.stderr
raw=(OUT/'production-files.json.gz').read_bytes();assert hashlib.sha256(raw).hexdigest()==proof['hashes']['production-files.json.gz']
files=json.loads(gzip.decompress(raw));assert files.keys()==report['files'].keys()
assert all(hashlib.sha256(v.encode()).hexdigest()==report['files'][k] for k,v in files.items())
docs=[k for k in files if k.endswith('.md')]
for name in docs:files[name]=(ROOT/name).read_text()
parent=api('/git/commits/'+BASE);before=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not before['truncated']
b={x['path']:(x['sha'],x['mode'],x['type']) for x in before['tree'] if x['type']!='tree'}
entries=[]
for name,value in files.items():
 data=value.encode();digest=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
 if b.get(name,(None,))[0]!=digest:
  entry=dict(path=name,mode='100644',type='blob',content=value)
  if len(json.dumps(entry).encode())>=2*1024*1024:
   assert len(data)<4*1024*1024
   blob=api('/git/blobs',dict(content=base64.b64encode(data).decode(),encoding='base64'));assert blob['sha']==digest
   entry=dict(path=name,mode='100644',type='blob',sha=digest)
  entries.append(entry)
tree=parent['tree']['sha'];batch=[];size=0
for entry in entries:
 length=len(json.dumps(entry).encode());assert length<2*1024*1024
 if batch and size+length>2*1024*1024:
  tree=api('/git/trees',dict(base_tree=tree,tree=batch))['sha'];batch=[];size=0
 batch.append(entry);size+=length
if batch:tree=api('/git/trees',dict(base_tree=tree,tree=batch))['sha']
after=api('/git/trees/'+tree+'?recursive=1');assert not after['truncated'];n={x['path']:(x['sha'],x['mode'],x['type']) for x in after['tree'] if x['type']!='tree'}
assert set(b)<=set(n) and {k for k in n if n[k]!=b.get(k)}<=set(files)
for name,value in files.items():
 data=value.encode();assert n[name][0]==hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree,parents=[BASE]));assert commit['message']==SUBJECT and [p['sha'] for p in commit['parents']]==[BASE]
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
body='Numeric arrays currently use eight-byte payload slots, and numeric workers cross direct calls as generic words. This change stores narrow numeric elements at their natural width, adds owner-retaining views with bounded small-slice retention, and uses typed scalar and aggregate worker boundaries while preserving generic V bridges.\n\nNative binary array decoding writes directly into destination storage. Protocol counts accept valid zero-byte records and reject overflowing counts before allocation.\n\nValidation: Linux and ARM/Intel macOS representation, ownership, immutable-update, exact-bit and omission controls; actual wasm32 count boundaries; runner formatting, all-target clippy, primitive/fallback inventory and documentation checks. Permanent regression tests cover byte widths, alignment, backing reclamation, small copies, ABI payloads and protocol bounds. Full six-job production CI and roadmap_docs must pass at this exact PR head before squash.\n\nFloating-point order and Pipe syntax are preserved. Existing F16/BF16/F128 representations and tracing compatibility fallbacks remain explicit in the docs; this is not a tracing-free execution claim.'
pr=api('/pulls',dict(title=SUBJECT,head=BRANCH,base='main',body=body,draft=False))
RECEIPT.write_text(json.dumps(dict(head=commit['sha'],base=BASE,tree=tree,branch=BRANCH,pr=pr['number'],url=pr['html_url'],driver=report['driver'],run=proof['run'],files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()}),indent=2)+'\n')
print(pr['html_url'],commit['sha'])
