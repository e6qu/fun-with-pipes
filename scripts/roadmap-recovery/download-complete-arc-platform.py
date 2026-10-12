from pathlib import Path
import hashlib,io,json,subprocess,zipfile
REPO='repos/e6qu/fun-with-pipes';RUN=38239726785;HEAD='a2500e0f68887412a80cd3ca00ae579b89bef560'
OUT=Path('/private/tmp/fwp-complete-arc-platform-evidence');assert not OUT.exists()
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path]))
r=api('/actions/runs/'+str(RUN));assert r['head_sha']==HEAD and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
artifacts=[a for a in api('/actions/runs/'+str(RUN)+'/artifacts')['artifacts'] if a['name'].startswith('arc-evidence-')];assert len(artifacts)==3
OUT.mkdir();reports=[]
for a in artifacts:
 assert not a['expired'] and a['size_in_bytes']<8*1024*1024
 platform=a['name'].removeprefix('arc-evidence-');raw=subprocess.check_output(['gh','api',REPO+'/actions/artifacts/'+str(a['id'])+'/zip']);assert len(raw)<8*1024*1024
 total=0;hashes={};assembly=0;corpus=None
 with zipfile.ZipFile(io.BytesIO(raw)) as z:
  for item in z.infolist():
   p=Path(item.filename);assert not p.is_absolute() and '..' not in p.parts
   assert item.file_size<2*1024*1024;total+=item.file_size;assert total<24*1024*1024
   if p.suffix not in {'.c','.asm','.txt'}:continue
   data=z.read(item)
   if p.name=='corpus.txt':corpus=data.decode()
   if p.suffix=='.asm':assembly+=1
   if platform=='ubuntu-latest' or p.suffix!='.c':
    q=OUT/platform/p;q.parent.mkdir(parents=True,exist_ok=True);q.write_bytes(data);hashes[p.as_posix()]=hashlib.sha256(data).hexdigest()
 assert corpus is not None and 'total=71 executed=21 rejected=47 compile-errors=3' in corpus
 assert assembly==7,(platform,assembly)
 reports.append(dict(platform=platform,artifact=a,archiveSha256=hashlib.sha256(raw).hexdigest(),hashes=hashes,corpus=corpus))
 print(platform,corpus.splitlines()[-1],assembly,'native disassemblies')
(OUT/'download.json').write_text(json.dumps(dict(head=HEAD,run=RUN,reports=reports,scope='All three complete ownership jobs passed. Checked ARC corpus, physical-free omission, forced tracing, symbols and actual native disassemblies retained; rejection and compile-error entries are not executed ARC support.'),indent=2)+'\n')
