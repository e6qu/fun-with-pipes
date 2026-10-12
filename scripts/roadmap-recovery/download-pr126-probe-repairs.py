from pathlib import Path
import hashlib,io,json,subprocess,zipfile
repo='repos/e6qu/fun-with-pipes';run=38207493251;head='f99f0a64e28f780ef61172fbb4b058994e7d89e1'
def api(path):return json.loads(subprocess.check_output(['gh','api',repo+path]))
r=api('/actions/runs/'+str(run));assert r['head_sha']==head and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(run)+'/jobs')['jobs'];assert len(jobs)==1 and jobs[0]['conclusion']=='success'
a=[x for x in api('/actions/runs/'+str(run)+'/artifacts')['artifacts'] if x['name']=='numeric-storage-probe-repairs'];assert len(a)==1 and a[0]['size_in_bytes']<200000 and not a[0]['expired']
raw=subprocess.check_output(['gh','api',repo+'/actions/artifacts/'+str(a[0]['id'])+'/zip']);assert len(raw)<200000
out=Path('/private/tmp/fwp-pr126-probe-repair-export');assert not out.exists();out.mkdir()
with zipfile.ZipFile(io.BytesIO(raw)) as z:
 assert set(z.namelist())=={'old_reclamation.rs','retain_unwind_ownership.rs','unboxed_worker_locals.rs','head.txt','hashes.txt'}
 for n in z.namelist():
  b=z.read(n);assert len(b)<100000;(out/n).write_bytes(b)
assert (out/'head.txt').read_text().strip()==head
for line in (out/'hashes.txt').read_text().splitlines():
 sha,name=line.split();assert hashlib.sha256((out/Path(name).name).read_bytes()).hexdigest()==sha
(out/'download.json').write_text(json.dumps(dict(head=head,run=run,artifact=a[0],archiveSha256=hashlib.sha256(raw).hexdigest()),indent=2)+'\n')
print('Retained verified runner-formatted repair sources')
