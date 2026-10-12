"""Restore verified source helpers from the published handoff, without testing."""
from pathlib import Path
import argparse,ast,hashlib,io,json,re,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes'
BRANCH='roadmap/handoff-pr123-20261011'
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--head',help='Immutable checkpoint to restore; defaults to the published recovery tip')
args=parser.parse_args()
def api(path):
    return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
tip=api('/git/ref/heads/'+BRANCH)['object']['sha']
actual=args.head or tip
assert re.fullmatch(r'[0-9a-f]{40}',actual)
if actual != tip:
    ancestry=api('/compare/'+actual+'...'+tip)
    assert ancestry['status'] in {'ahead','identical'}
    assert ancestry['merge_base_commit']['sha']==actual
commit=api('/git/commits/'+actual)
assert len(commit['message'].splitlines())==1 and len(commit['message'])<=80
tree=api('/git/trees/'+commit['tree']['sha']+'?recursive=1')
assert not tree['truncated']
entries={row['path']:row for row in tree['tree']}
# One bounded source archive replaces hundreds of per-blob API calls.
archive_command=subprocess.Popen(['gh','api',REPO+'/zipball/'+actual],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
archive_bytes=archive_command.stdout.read(64*1024*1024+1)
if len(archive_bytes)>64*1024*1024:
    archive_command.kill();archive_command.wait()
    raise RuntimeError('Recovery source archive exceeds the 64 MiB bound')
error=archive_command.stderr.read();assert archive_command.wait()==0,error.decode(errors='replace')
archive=zipfile.ZipFile(io.BytesIO(archive_bytes));archive_entries={}
roots=set()
for item in archive.infolist():
    if item.is_dir():continue
    prefix,name=item.filename.split('/',1);roots.add(prefix)
    assert name not in archive_entries
    archive_entries[name]=item
assert len(roots)==1

def blob(name):
    entry=entries[name];assert entry['type']=='blob'
    item=archive_entries[name];assert item.file_size<=4*1024*1024
    raw=archive.read(item);assert len(raw)==item.file_size
    assert hashlib.sha1(b'blob '+str(len(raw)).encode()+b'\0'+raw).hexdigest()==entry['sha']
    return raw

maps=[]
for publisher in sorted(entries):
    if publisher.startswith('scripts/roadmap-recovery/publish-') and publisher.endswith('.py'):
        source=blob(publisher).decode()
        module=ast.parse(source)
        assignments=[node for node in module.body if isinstance(node,ast.Assign)
            and any(isinstance(target,ast.Name) and target.id=='HELPERS' for target in node.targets)]
        if len(assignments)!=1:
            continue
        values=ast.literal_eval(assignments[0].value)
        if not isinstance(values,dict) or not all(isinstance(k,str) and isinstance(v,str)
            and Path(v).resolve().is_relative_to(Path('/private/tmp').resolve()) for k,v in values.items()):
            continue
        mapping=list(values.items())
        if not all(name in entries and entries[name]['type']=='blob' for name,_ in mapping):
            continue
        if not any(name==publisher for name,_ in mapping):
            continue
        maps.append((len(mapping),publisher,mapping))
assert maps,'No complete safe recovery map found'
_,publisher,mapping=max(maps)
assert len(mapping)>40
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
