"""Retain bounded restoration evidence; do not restore or execute helpers locally."""
from pathlib import Path
import hashlib,io,json,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes';HEAD='2091ad9bacf33806b8de1cecddf626e667575eef';RUN=38198377356
OUT=Path('/private/tmp/fwp-verified-active-numeric-restoration');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path]))
r=api('/actions/runs/'+str(RUN));assert r['head_sha']==HEAD and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs'];assert len(jobs)==1 and jobs[0]['conclusion']=='success'
assert {s['name'] for s in jobs[0]['steps'] if s['conclusion']=='success'} >= {'Verify temporary recovery restoration without executing helpers','Run actions/checkout@v7','Run actions/upload-artifact@v7'}
a=[x for x in api('/actions/runs/'+str(RUN)+'/artifacts')['artifacts'] if x['name']=='recovery-restoration'];assert len(a)==1 and not a[0]['expired'] and a[0]['size_in_bytes']<16*1024*1024
raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(a[0]['id'])+'/zip']);assert len(raw)<16*1024*1024
files={}
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 for name in ['validation.json','recovery-restoration.json']:
  matches=[x for x in z.infolist() if x.filename==name];assert len(matches)==1 and matches[0].file_size<1024*1024
  files[name]=z.read(matches[0])
v=json.loads(files['validation.json']);m=json.loads(files['recovery-restoration.json'])
assert v['head']==m['head']==HEAD and v['tree']==m['tree']
assert v['verifiedTargets']>40 and v['bytes']<64*1024*1024
assert v['restorationSha256']==hashlib.sha256(files['recovery-restoration.json']).hexdigest()
assert v['status']=='Temporary recovery restoration and source hashes verified; helpers and compiler were not executed'
OUT.mkdir()
for name,data in files.items():(OUT/name).write_bytes(data)
(OUT/'proof.json').write_text(json.dumps(dict(head=HEAD,run=RUN,artifact=a[0],archiveSha256=hashlib.sha256(raw).hexdigest(),reportHashes={name:hashlib.sha256(data).hexdigest() for name,data in files.items()},verifiedTargets=v['verifiedTargets'],bytes=v['bytes'],scope='Actual restoration on disposable GitHub runner; metadata downloaded only, no local restoration, helper execution or compiler check'),indent=2)+'\n')
print('Verified runner restoration:',v['verifiedTargets'],'targets,',v['bytes'],'bytes at',HEAD)
