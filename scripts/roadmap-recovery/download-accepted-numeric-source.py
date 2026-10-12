from pathlib import Path
import hashlib,io,json,subprocess,zipfile
repo='repos/e6qu/fun-with-pipes';run=38214129076;driver='b1b5372e9d7bfffe19361cbb8a2634b33f4f874f';out=Path('/private/tmp/fwp-accepted-numeric-source');assert not out.exists()
def api(p):return json.loads(subprocess.check_output(['gh','api',repo+p]))
r=api('/actions/runs/'+str(run));assert r['head_sha']==driver and r['conclusion']=='success' and r['status']=='completed'
j=api('/actions/runs/'+str(run)+'/jobs')['jobs'];assert len(j)==1 and j[0]['name']=='accept_numeric_source' and j[0]['conclusion']=='success'
a=[a for a in api('/actions/runs/'+str(run)+'/artifacts')['artifacts'] if a['name']=='accepted-numeric-storage-source'];assert len(a)==1 and not a[0]['expired'] and a[0]['size_in_bytes']<8*1024*1024
raw=subprocess.check_output(['gh','api',repo+'/actions/artifacts/'+str(a[0]['id'])+'/zip']);assert len(raw)<8*1024*1024
files={}
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 for n in ['phase3-acceptance.json','inventory.json','fallback-review.json','signed-payload.txt']:
  e=[e for e in z.infolist() if e.filename==n];assert len(e)==1 and e[0].file_size<2*1024*1024;files[n]=z.read(e[0])
p=json.loads(Path('/private/tmp/fwp-numeric-storage-merge-proof.json').read_text());r=json.loads(files['phase3-acceptance.json'])
assert r['accepted']==p['sha'] and r['tested']==p['acceptedHead'] and r['tree']==p['tree']
assert r['signedPayloadSha256']==hashlib.sha256(files['signed-payload.txt']).hexdigest()==p['rawPayloadSha256']
assert api('/git/ref/heads/main')['object']['sha']==p['sha']
out.mkdir()
for n,b in files.items():(out/n).write_bytes(b)
(out/'download.json').write_text(json.dumps(dict(run=run,driver=driver,artifact=a[0],archiveSha256=hashlib.sha256(raw).hexdigest(),hashes={n:hashlib.sha256(b).hexdigest() for n,b in files.items()}),indent=2)+'\n')
print('Retained actual phase3 acceptance at',r['accepted'])
