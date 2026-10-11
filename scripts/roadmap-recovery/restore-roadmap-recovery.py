"""Restore verified source helpers from the published handoff, without testing."""
from pathlib import Path
import base64,hashlib,json,re,subprocess
REPO='repos/e6qu/fun-with-pipes'
BRANCH='roadmap/handoff-pr123-20261011'
EXPECTED='1992c95d376c343b00a6ca662ac5f9b5f1c28888'
def api(path):
    return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
actual=api('/git/ref/heads/'+BRANCH)['object']['sha']
assert actual==EXPECTED,(actual,EXPECTED)
commit=api('/git/commits/'+actual)
assert len(commit['message'].splitlines())==1 and len(commit['message'])<=80
tree=api('/git/trees/'+commit['tree']['sha']+'?recursive=1')
assert not tree['truncated']
entries={row['path']:row for row in tree['tree']}
def blob(name):
    entry=entries[name];assert entry['type']=='blob'
    data=api('/git/blobs/'+entry['sha']);assert data['encoding']=='base64'
    raw=base64.b64decode(data['content'])
    assert hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest()==entry['sha']
    return raw
publisher='scripts/roadmap-recovery/publish-state-slot-checkpoint.py'
source=blob(publisher).decode()
mapping=re.findall(r"^    '([^']+)': '(/private/tmp/[^']+)',?$",source,re.M)
assert len(mapping)>40 and any(name==publisher for name,_ in mapping)
record={}
for name,target in mapping:
    raw=blob(name)
    Path(target).write_bytes(raw)
    record[target]=dict(source=name,sha256=hashlib.sha256(raw).hexdigest())
    print(name,flush=True)
Path('/private/tmp/fwp-recovery-restoration.json').write_text(json.dumps(
    dict(head=actual,tree=commit['tree']['sha'],restored=record,
         stage='Verified published source restored; no helper executed or compiler run'),indent=2)+'\n')
print('Restored',len(record),'verified helpers from',actual,flush=True)
