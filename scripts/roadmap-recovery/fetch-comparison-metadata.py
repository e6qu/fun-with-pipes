"""Retain bounded comparison metadata after exact three-platform runner success."""
import argparse,io,json,subprocess,zipfile,hashlib
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--run',required=True);p.add_argument('--head',required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args()
def api(s):return json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes'+s],text=True))
r=api('/actions/runs/'+a.run);assert r['head_sha']==a.head and r['conclusion']=='success' and r['status']=='completed'
j=api('/actions/runs/'+a.run+'/jobs')['jobs'];assert len(j)==3 and all(x['conclusion']=='success' for x in j)
arts=api('/actions/runs/'+a.run+'/artifacts')['artifacts'];assert len(arts)==3
a.out.mkdir(exist_ok=True,parents=True);reports={}
for item in arts:
 assert not item['expired'] and item['size_in_bytes']<32*1024*1024
 raw=subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/actions/artifacts/'+str(item['id'])+'/zip']);assert len(raw)<32*1024*1024
 z=zipfile.ZipFile(io.BytesIO(raw));selected=[i for i in z.infolist() if i.filename.endswith('comparison.json')];assert len(selected)==1
 f=selected[0];assert f.file_size<256*1024;data=z.read(f);report=json.loads(data)
 dest=a.out/(item['name']+'.json');dest.write_bytes(data);reports[item['name']]=dict(artifactId=item['id'],zipHash=hashlib.sha256(raw).hexdigest(),reportHash=hashlib.sha256(data).hexdigest(),report=report)
 print(item['name'],json.dumps({k:{m:v[m] for m in ['managedCalls','managedRequestedBytes','managedFreedBytes'] if m in v} for k,v in report['results'].items()}))
(a.out/'proof.json').write_text(json.dumps(dict(run=r['id'],head=a.head,jobs=[dict(name=x['name'],conclusion=x['conclusion']) for x in j],reports=reports),indent=2)+'\n')
