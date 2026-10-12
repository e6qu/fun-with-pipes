from pathlib import Path
import hashlib,io,json,subprocess,zipfile
repo='repos/e6qu/fun-with-pipes';run=38229158359;head='c600a9343283c975be018ba59c40c7d0068d161e'
def api(p):return json.loads(subprocess.check_output(['gh','api',repo+p]))
r=api('/actions/runs/'+str(run));assert r['head_sha']==head and r['status']=='completed' and r['conclusion']=='success'
jobs=api('/actions/runs/'+str(run)+'/jobs')['jobs'];assert len(jobs)==3 and all(j['conclusion']=='success' for j in jobs)
out=Path('/private/tmp/fwp-const-descriptors-platform-evidence');assert not out.exists();out.mkdir();reports=[];source_hashes=None
artifacts=api('/actions/runs/'+str(run)+'/artifacts')['artifacts'];assert len(artifacts)==3
for a in sorted(artifacts,key=lambda a:a['name']!='numeric-array-fusion-evidence-ubuntu-latest'):
 assert a['name'].startswith('numeric-array-fusion-evidence-') and not a['expired'] and a['size_in_bytes']<8*1024*1024
 raw=subprocess.check_output(['gh','api',repo+'/actions/artifacts/'+str(a['id'])+'/zip']);assert len(raw)<8*1024*1024
 platform=a['name'].removeprefix('numeric-array-fusion-evidence-');hashes={};sources={};total=0
 with zipfile.ZipFile(io.BytesIO(raw)) as z:
  for i in z.infolist():
   p=Path(i.filename);assert not p.is_absolute() and '..' not in p.parts
   assert i.file_size<2*1024*1024;total+=i.file_size;assert total<24*1024*1024
   if p.suffix not in {'.rs','.c','.json','.asm','.txt'}:continue
   data=z.read(i);digest=hashlib.sha256(data).hexdigest()
   if p.parts[0]=='source':sources[p.name]=digest
   retain=platform=='ubuntu-latest' or p.suffix=='.json' or (p.parts[0]=='performance' and p.suffix in {'.asm','.txt'})
   if retain:
    target=out/platform/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data);hashes[p.as_posix()]=digest
 if source_hashes is None:source_hashes=sources
 else:assert sources==source_hashes,(platform,'formatted source differs')
 report=json.loads((out/platform/'performance/comparison.json').read_text());assert report['head']==head
 reports.append(dict(platform=platform,artifact=a,archiveSha256=hashlib.sha256(raw).hexdigest(),hashes=hashes,formattedSourceHashes=sources))
 print(platform,json.dumps(report['summary']))
(out/'download.json').write_text(json.dumps(dict(run=run,head=head,reports=reports,scope='All three coherent numerical/AD jobs pass; formatted source agrees across targets; exact C/Rust/generated hashes, allocations and uninstrumented disassembly retained'),indent=2)+'\n')
