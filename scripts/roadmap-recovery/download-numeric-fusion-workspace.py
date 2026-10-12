from pathlib import Path
import hashlib,io,json,subprocess,zipfile
repo='repos/e6qu/fun-with-pipes';run=38211872588;head='e166e1d67a11b2d9a3825f6de2936db5543b51ee'
def api(path):return json.loads(subprocess.check_output(['gh','api',repo+path]))
r=api('/actions/runs/'+str(run));assert r['head_sha']==head and r['status']=='completed' and r['conclusion']=='success'
a=[x for x in api('/actions/runs/'+str(run)+'/artifacts')['artifacts'] if x['name']=='numeric-array-fusion-evidence'];assert len(a)==1 and a[0]['size_in_bytes']<8*1024*1024
raw=subprocess.check_output(['gh','api',repo+'/actions/artifacts/'+str(a[0]['id'])+'/zip']);assert len(raw)<8*1024*1024
out=Path('/private/tmp/fwp-numeric-fusion-workspace-evidence');assert not out.exists();out.mkdir()
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 total=0
 for i in z.infolist():
  p=Path(i.filename);assert not p.is_absolute() and '..' not in p.parts
  assert i.file_size<2*1024*1024;total+=i.file_size;assert total<16*1024*1024
  if p.suffix in {'.rs','.c','.json','.asm'}:
   q=out/p;q.parent.mkdir(parents=True,exist_ok=True);q.write_bytes(z.read(i))
(out/'download.json').write_text(json.dumps(dict(head=head,run=run,artifact=a[0],archiveSha256=hashlib.sha256(raw).hexdigest(),status='Focused compiler, original ownership, tape bounds, workspace, semantic and zero-allocation controls passed on Linux'),indent=2)+'\n')
print('Retained verified Linux zero-allocation fusion sources and reports')
