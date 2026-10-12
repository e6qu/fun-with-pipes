"""Download bounded source and report evidence; no local compiler execution."""
from pathlib import Path
import hashlib,io,json,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes';RUN=38199430982;HEAD='1432b969b0ed1f780ffced363cc646e569bc4869'
OUT=Path('/private/tmp/fwp-packed-representation-evidence');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path]))
r=api('/actions/runs/'+str(RUN));assert r['head_sha']==HEAD and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
artifacts=api('/actions/runs/'+str(RUN)+'/artifacts')['artifacts'];OUT.mkdir();proof={}
for runner in ['ubuntu-latest','macos-15','macos-15-intel']:
 a=[x for x in artifacts if x['name']=='numeric-layout-controls-'+runner];assert len(a)==1 and not a[0]['expired'] and a[0]['size_in_bytes']<32*1024*1024
 raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(a[0]['id'])+'/zip']);assert len(raw)<32*1024*1024
 dest=OUT/runner;dest.mkdir();hashes={}
 with zipfile.ZipFile(io.BytesIO(raw)) as z:
  for entry in z.infolist():
   p=Path(entry.filename)
   if p.suffix not in ['.json','.c','.rs','.asm','.symbols','.status','.out','.stdout'] or entry.is_dir():continue
   assert not p.is_absolute() and '..' not in p.parts and entry.file_size<4*1024*1024
   data=z.read(entry);target=dest/p;target.parent.mkdir(exist_ok=True,parents=True);target.write_bytes(data);hashes[str(p)]=hashlib.sha256(data).hexdigest()
 report=json.loads((dest/'baseline.json').read_text());memory=json.loads((dest/'array-memory/comparison.json').read_text())
 assert report['driver']==memory['driver']==HEAD
 for name,value in memory['hashes'].items():
  if 'array-memory/'+name in hashes:assert hashes['array-memory/'+name]==value
 proof[runner]=dict(artifact=a[0],archiveSha256=hashlib.sha256(raw).hexdigest(),hashes=hashes)
proof.update(run=RUN,head=HEAD,source='cbf68ea60c3b9439a117ef9d9b28b472f23dc632',jobs=jobs,scope='Runner source, reports and assembly only; no binaries or local compilation')
(OUT/'proof.json').write_text(json.dumps(proof,indent=2)+'\n');print('Retained all three passing packed representation reports and assembly')
