"""Retain bounded exact-source acceptance evidence without local workloads."""
from pathlib import Path
import argparse,hashlib,io,json,subprocess,zipfile
p=argparse.ArgumentParser();p.add_argument('--run',required=True,type=int);p.add_argument('--driver',required=True);a=p.parse_args()
REPO='repos/e6qu/fun-with-pipes';OUT=Path('/private/tmp/fwp-accepted-phase2-source');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
r=api('/actions/runs/'+str(a.run));assert r['head_sha']==a.driver and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(a.run)+'/jobs')['jobs'];assert len(jobs)==1 and jobs[0]['name']=='accepted_source' and jobs[0]['conclusion']=='success'
artifacts=[x for x in api('/actions/runs/'+str(a.run)+'/artifacts')['artifacts'] if x['name']=='phase2-accepted-source'];assert len(artifacts)==1 and not artifacts[0]['expired'] and artifacts[0]['size_in_bytes']<8*1024*1024
raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(artifacts[0]['id'])+'/zip']);assert len(raw)<8*1024*1024
files={}
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 for name in ['phase2-acceptance.json','inventory.json','fallback-review.json','signed-payload.txt']:
  entries=[x for x in z.infolist() if x.filename==name];assert len(entries)==1 and entries[0].file_size<2*1024*1024;files[name]=z.read(entries[0])
report=json.loads(files['phase2-acceptance.json']);proof=json.loads(Path('/private/tmp/fwp-phase2-exit-merge-proof.json').read_text())
assert report['head']==proof['sha'] and report['testedHead']==proof['acceptedHead'] and report['tree']==proof['tree']
assert report['status']=='Phase2 accepted source coverage verified; phase3 may proceed'
assert report['rawPayloadSha256']==hashlib.sha256(files['signed-payload.txt']).hexdigest()==proof['rawPayloadSha256']
assert report['inventoryReport']['head']==report['fallbackReport']['head']==report['head']
assert report['fallbackReport']['declarations']==177 and report['fallbackReport']['symbols']==167
assert report['inventoryReport']['counts']['contract']==168
assert api('/git/ref/heads/main')['object']['sha']==report['head']
OUT.mkdir()
for name,data in files.items():(OUT/name).write_bytes(data)
(OUT/'download.json').write_text(json.dumps(dict(run=a.run,driver=a.driver,artifact=artifacts[0],archiveSha256=hashlib.sha256(raw).hexdigest(),hashes={n:hashlib.sha256(v).hexdigest() for n,v in files.items()},scope='Bounded report metadata only; no local compiler or audit executed'),indent=2)+'\n')
print('Retained verified phase2 acceptance at',report['head'])
