"""Retain bounded runner-formatted production sources and coverage metadata."""
from pathlib import Path
import argparse,gzip,hashlib,io,json,subprocess,zipfile
p=argparse.ArgumentParser();p.add_argument('--run',type=int,required=True);p.add_argument('--driver',required=True);a=p.parse_args()
REPO='repos/e6qu/fun-with-pipes';OUT=Path('/private/tmp/fwp-numeric-storage-finalization-export');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path]))
r=api('/actions/runs/'+str(a.run));assert r['head_sha']==a.driver and r['conclusion']=='success' and r['status']=='completed'
jobs=api('/actions/runs/'+str(a.run)+'/jobs')['jobs'];assert len(jobs)==1 and jobs[0]['conclusion']=='success'
required={'Current bytes, original semantics and diagnostic ABI','Original ownership and allocation boundary controls','Actual wasm32 count boundaries','Exact packed bytes and raw native mode comparisons','Export the formatted production bundle'}
assert required <= {s['name'] for s in jobs[0]['steps'] if s['conclusion']=='success'}
art=[x for x in api('/actions/runs/'+str(a.run)+'/artifacts')['artifacts'] if x['name']=='numeric-storage-finalization'];assert len(art)==1 and not art[0]['expired'] and art[0]['size_in_bytes']<16*1024*1024
raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(art[0]['id'])+'/zip']);assert len(raw)<16*1024*1024
files={}
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 for name in ['finalization.json','production-files.json.gz','inventory.json','fallback-review.json']:
  entry=[x for x in z.infolist() if x.filename==name];assert len(entry)==1 and entry[0].file_size<8*1024*1024;files[name]=z.read(entry[0])
report=json.loads(files['finalization.json']);assert report['driver']==a.driver and report['base']=='cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
source=gzip.decompress(files['production-files.json.gz']);assert len(source)<8*1024*1024
source=json.loads(source);assert source.keys()==report['files'].keys()
assert all(hashlib.sha256(v.encode()).hexdigest()==report['files'][k] for k,v in source.items())
OUT.mkdir()
for name,data in files.items():(OUT/name).write_bytes(data)
(OUT/'download.json').write_text(json.dumps(dict(run=a.run,driver=a.driver,artifact=art[0],jobs=jobs,archiveSha256=hashlib.sha256(raw).hexdigest(),hashes={name:hashlib.sha256(data).hexdigest() for name,data in files.items()},scope='Formatted source and reports only; no binaries or local build'),indent=2)+'\n')
print('Verified formatted numeric production source and focused coverage export')
