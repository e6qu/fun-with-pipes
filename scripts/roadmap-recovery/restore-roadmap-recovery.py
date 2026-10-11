"""Restore verified source helpers from the published handoff, without testing."""
from pathlib import Path
import argparse,base64,hashlib,json,re,subprocess
REPO='repos/e6qu/fun-with-pipes'
BRANCH='roadmap/handoff-pr123-20261011'
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--head',help='Expected published checkpoint; defaults to the root handoff')
args=parser.parse_args()
handoff=Path('/Users/zardoz/projects/fun-with-pipes/docs/development-state.md').read_text()
match=re.search(r'Current checkpoint([0-9a-f]{40})',handoff)
assert args.head or match,'Supply --head when the root handoff has no checkpoint'
EXPECTED=args.head or match.group(1)
assert re.fullmatch(r'[0-9a-f]{40}',EXPECTED)
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
maps=[]
for publisher in sorted(entries):
    if publisher.startswith('scripts/roadmap-recovery/publish-') and publisher.endswith('-checkpoint.py'):
        source=blob(publisher).decode()
        mapping=re.findall(r"^    '([^']+)': '(/private/tmp/[^']+)',?$",source,re.M)
        maps.append((len(mapping),publisher,mapping))
_,publisher,mapping=max(maps)
assert len(mapping)>40 and any(name==publisher for name,_ in mapping)
record={}
for name,target in mapping:
    raw=blob(name)
    destination=Path(target)
    assert destination.resolve().is_relative_to(Path('/private/tmp').resolve()),target
    destination.parent.mkdir(parents=True,exist_ok=True)
    destination.write_bytes(raw)
    record[target]=dict(source=name,sha256=hashlib.sha256(raw).hexdigest())
    print(name,flush=True)
Path('/private/tmp/fwp-recovery-restoration.json').write_text(json.dumps(
    dict(head=actual,tree=commit['tree']['sha'],restored=record,
         stage='Verified published source restored; no helper executed or compiler run'),indent=2)+'\n')
print('Restored',len(record),'verified helpers from',actual,flush=True)
