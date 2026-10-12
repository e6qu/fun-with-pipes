"""Fetch bounded original controls from the accepted phase2 tree."""
from pathlib import Path
import base64,hashlib,json,subprocess
ROOT=Path('/private/tmp/fwp-packed-array-original-controls');ROOT.mkdir(exist_ok=True)
REPO='repos/e6qu/fun-with-pipes';SHA='cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
def api(p):return json.loads(subprocess.check_output(['gh','api',REPO+p]))
commit=api('/git/commits/'+SHA);t=api('/git/trees/'+commit['tree']['sha']+'?recursive=1');assert not t['truncated'];entries={x['path']:x for x in t['tree']};names=['tests/array_element_ownership.rs','tests/array_size_limits.rs','tests/kernel_stack_bounds.rs','tests/device_bounds.rs','tests/fixtures/array_size_probe.c','tests/fixtures/kernel_stack_probe.c','tests/fixtures/device_bounds_probe.c','tests/worker_boxing_ownership.rs','tests/worker_preparation_ownership.rs','tests/numerics.rs'];files={}
for name in names:
 e=entries[name];assert e['type']=='blob' and e['size']<200000;r=api('/git/blobs/'+e['sha']);assert r['encoding']=='base64';data=base64.b64decode(r['content']);assert hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()==e['sha'];p=ROOT/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data);files[name]=dict(blob=e['sha'],sha256=hashlib.sha256(data).hexdigest())
(ROOT/'manifest.json').write_text(json.dumps(dict(head=SHA,tree=commit['tree']['sha'],files=files),indent=2)+'\n');print('Retained',len(files),'original control sources')
