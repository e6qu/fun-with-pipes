"""Fetch bounded, blob-verified numeric design source without a local build."""
from pathlib import Path
import base64,hashlib,json,subprocess
HEAD='d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0';OUT=Path('/private/tmp/fwp-numeric-representation-source');OUT.mkdir(exist_ok=True)
def api(path):return json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes'+path]))
commit=api('/git/commits/'+HEAD);tree=api('/git/trees/'+commit['tree']['sha']+'?recursive=1');assert not tree['truncated']
wanted={'src/cgen.rs','src/rc.rs','src/mono.rs','src/ir.rs','src/value.rs','src/proto.rs','src/types.rs','src/prims_std.rs','src/json.rs','src/numerics.rs','src/linalg.rs','src/ffi.rs'}
entries=[x for x in tree['tree'] if x['type']=='blob' and (x['path'] in wanted or x['path'].startswith('runtime/') and x['path'].endswith(('.c','.h')))]
assert len(entries)<60 and sum(x.get('size',0) for x in entries)<5*1024*1024
record={}
for e in entries:
 p=OUT/e['path'];p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():data=p.read_bytes()
 else:
  r=api('/git/blobs/'+e['sha']);assert r['encoding']=='base64';data=base64.b64decode(r['content']);assert len(data)<1024*1024
 assert hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()==e['sha'],e['path']
 p.write_bytes(data);record[e['path']]=dict(blob=e['sha'],sha256=hashlib.sha256(data).hexdigest(),bytes=len(data))
(OUT/'manifest.json').write_text(json.dumps(dict(head=HEAD,tree=commit['tree']['sha'],files=record,status='Blob-verified source snapshot; no compiled check'),indent=2)+'\n')
print('Verified',len(record),'source files at',HEAD,flush=True)
