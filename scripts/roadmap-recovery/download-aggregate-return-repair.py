from pathlib import Path
import hashlib,io,json,re,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes';HEAD='c94f759a25205d818e7f62d65873e34585a7685d';RUN=38255126357
OUT=Path('/private/tmp/fwp-aggregate-return-repair-evidence');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path]))
r=api('/actions/runs/'+str(RUN));assert r['head_sha']==HEAD and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
artifacts=api('/actions/runs/'+str(RUN)+'/artifacts')['artifacts'];assert len(artifacts)==3
OUT.mkdir();reports=[];source=None
for a in artifacts:
 assert a['name'].startswith('variant-return-evidence-') and not a['expired'] and a['size_in_bytes']<8*1024*1024
 platform=a['name'].removeprefix('variant-return-evidence-');raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(a['id'])+'/zip']);assert len(raw)<8*1024*1024
 files={};total=0
 with zipfile.ZipFile(io.BytesIO(raw)) as z:
  for i in z.infolist():
   if i.is_dir():continue
   p=Path(i.filename);assert not p.is_absolute() and '..' not in p.parts
   assert i.file_size<2*1024*1024;total+=i.file_size;assert total<24*1024*1024
   data=z.read(i);files[p.as_posix()]=data
 digest=hashlib.sha256(files['source/cgen.rs']).hexdigest()
 source_hashes={n:hashlib.sha256(data).hexdigest() for n,data in files.items() if n.startswith('source/')}
 assert set(source_hashes)=={'source/cgen.rs','source/stack.rs','source/wide_alias.fwp'}
 if source is None:source=source_hashes
 else:assert source==source_hashes
 counts={}
 for mode in (0,1):
  assert files[f'digits-{mode}.out']==b'182551542\n'
  counts[mode]=float(re.search(rb'([0-9.]+) MiB allocated',files[f'digits-{mode}.stats']).group(1))
 assert counts[0]>10 and counts[1]<1,counts
 corpus=files['arc/corpus.txt'].decode();assert 'total=71 executed=21 rejected=47 compile-errors=3' in corpus
 hashes={}
 for name,data in files.items():
  if platform!='ubuntu-latest' and Path(name).suffix in {'.c','.rs'}:continue
  p=OUT/platform/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data);hashes[name]=hashlib.sha256(data).hexdigest()
 reports.append(dict(platform=platform,artifact=a,archiveSha256=hashlib.sha256(raw).hexdigest(),formattedSourceSha256=digest,formattedSourceHashes=source_hashes,hashes=hashes,allocatedMiB=counts,corpus=corpus))
 print(platform,counts,corpus.splitlines()[-1])
(OUT/'download.json').write_text(json.dumps(dict(head=HEAD,run=RUN,reports=reports,scope='Original stack allocation thresholds, the added wide-record alias control and variant alias/conversion/unwind ownership controls pass; explicit ARC corpus remains21 executions with physical reclamation and native binary controls. Allocation controls are validation, not a new timing comparison.'),indent=2)+'\n')
