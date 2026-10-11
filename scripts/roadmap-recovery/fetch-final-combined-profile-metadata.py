"""Retain bounded combined profile reports while keeping binaries on GitHub."""
from pathlib import Path
import gzip,hashlib,io,json,subprocess,zipfile
ROOT=Path('/private/tmp/fwp-pr124-final-ownership-export');OUT=Path('/private/tmp/fwp-pr124-final-combined-profile-metadata');assert not OUT.exists()
download=json.loads((ROOT/'download.json').read_text());manifest=json.loads((ROOT/'final-ownership.json').read_text());package=json.loads(gzip.decompress((ROOT/'prepared-commits.json.gz').read_bytes()));first=package['commits'][0]['sha']
run=json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/actions/runs/'+str(download['run'])]));assert run['head_sha']==download['driver'] and run['status']=='completed' and run['conclusion']=='success'
data=subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/actions/artifacts/'+str(download['artifact'])+'/zip']);assert len(data)<64*1024*1024
reports={};raws={}
with zipfile.ZipFile(io.BytesIO(data)) as z:
 for kind in ['state','ad','list']:
  names=[x for x in z.infolist() if x.filename=='combined-'+kind+'-profile/'+('' if kind=='ad' else 'allocations/')+'comparison.json'];assert len(names)==1 and names[0].file_size<256*1024
  raw=z.read(names[0]);r=json.loads(raw);assert r['candidate']==first
  assert set(r['results'])=={'baseline-O1','baseline-O2','candidate-O1','candidate-O2'}
  for opt in ['-O1','-O2']:
   b=r['results']['baseline'+opt];a=r['results']['candidate'+opt]
   assert a['managedCalls']<=b['managedCalls'] and a['managedRequestedBytes']<=b['managedRequestedBytes']
  reports[kind]=r;raws[kind]=raw
OUT.mkdir()
for kind,raw in raws.items():(OUT/(kind+'.json')).write_bytes(raw)
(OUT/'proof.json').write_text(json.dumps(dict(run=download['run'],driver=download['driver'],artifact=download['artifact'],testedProductionHead='d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0',tree=manifest['tree'],measuredCandidate=first,reportHashes={k:hashlib.sha256(v).hexdigest() for k,v in raws.items()},scope='Combined-source Linux O1/O2 complete managed allocation comparisons; no timing or tracing-free claim'),indent=2)+'\n')
print('Retained three complete combined profile reports at',first,flush=True)
