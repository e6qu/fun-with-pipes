"""Retain bounded byte/layout reports and source/assembly; binaries stay on CI."""
from pathlib import Path
import hashlib,io,json,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes';RUN=38195896907;HEAD='9fe843746e9dd9a7ebf890caaa58a5b656a46076'
OUT=Path('/private/tmp/fwp-typed-worker-abi-evidence');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
r=api('/actions/runs/'+str(RUN));assert r['head_sha']==HEAD and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
artifacts=api('/actions/runs/'+str(RUN)+'/artifacts')['artifacts'];OUT.mkdir();provenance={}
for runner in ['ubuntu-latest','macos-15','macos-15-intel']:
 selected={}
 for category in ['metadata','controls']:
  names=[x for x in artifacts if x['name']=='numeric-layout-'+category+'-'+runner];assert len(names)==1 and not names[0]['expired']
  artifact=names[0];assert artifact['size_in_bytes']<64*1024*1024
  data=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(artifact['id'])+'/zip']);assert len(data)<64*1024*1024
  with zipfile.ZipFile(io.BytesIO(data)) as archive:
   if category=='metadata':wanted=['baseline.json']
   else:wanted=['baseline.original.c','floats.original.c','scalar.original.c','baseline.bytes.c','floats.bytes.c','scalar.bytes.c','abi-diagnostic.asm','floats.asm','scalar.asm','abi-diagnostic.symbols','floats.symbols','scalar.symbols','cgen.formatted.rs','bits64.original.c','bits32.original.c','bits64.bytes.c','bits32.bytes.c','bits64.asm','bits32.asm','bits64.symbols','bits32.symbols','scalar.signature.c','records.original.out']
   for name in wanted:
    entries=[x for x in archive.infolist() if x.filename==name];assert len(entries)==1 and entries[0].file_size<2*1024*1024
    selected[name]=archive.read(entries[0])
  provenance[runner+'-'+category]=dict(artifact=artifact,archiveSha256=hashlib.sha256(data).hexdigest())
 report=json.loads(selected['baseline.json']);assert report['driver']==HEAD and report['head']=='cbf68ea60c3b9439a117ef9d9b28b472f23dc632'
 for name,contents in selected.items():
  if name!='baseline.json':assert report['hashes'][name]==hashlib.sha256(contents).hexdigest()
 for opt in ['-O1','-O2']:
  result=report['results'][opt];assert result['headerBytes']==8 and result['payloadOffset']==8 and result['wordBytes']==8
  assert len(result['arrays'])==8 and all(x['length']==257 and x['elementBytes']==8 and x['storageRequestBytes']==2064 for x in result['arrays'])
 assert report['abiResults']['floats']['structBytes']==24 and report['abiResults']['floats']['fieldBytes']==8
 destination=OUT/runner;destination.mkdir()
 for name,contents in selected.items():(destination/name).write_bytes(contents)
provenance.update(run=RUN,driver=HEAD,source='cbf68ea60c3b9439a117ef9d9b28b472f23dc632',scope='Reports, source and diagnostic disassembly only; no binaries or local compiler execution')
(OUT/'proof.json').write_text(json.dumps(provenance,indent=2)+'\n');print('Retained verified current array bytes and ABI sources for all three platforms')
