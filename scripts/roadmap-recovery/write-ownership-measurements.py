from pathlib import Path
import hashlib,json
root=Path('/Users/zardoz/projects/fun-with-pipes');numbers=Path('/private/tmp/fwp-complete-ownership-platform-evidence');arc=Path('/private/tmp/fwp-complete-arc-platform-evidence')
n=json.loads((numbers/'download.json').read_text());a=json.loads((arc/'download.json').read_text());assert (n['head'],n['run'])==(a['head'],a['run'])
platforms={}
for report in n['reports']:
 name=report['platform'];comparison=json.loads((numbers/name/'performance/comparison.json').read_text());assert comparison['head']==n['head'];ar=next(r for r in a['reports'] if r['platform']==name)
 platforms[name]=dict(numerical= comparison,arcCorpus=ar['corpus'],numericalArtifact=dict(id=report['artifact']['id'],archiveSha256=report['archiveSha256']),arcArtifact=dict(id=ar['artifact']['id'],archiveSha256=ar['archiveSha256'],files=ar['hashes']))
report=dict(preparationHead=n['head'],preparationRun=n['run'],platforms=platforms,scope='Numerical timings compare equivalent C/Rust/generated workloads using the existing native memory mode with zero observed collections. ARC eligibility, physical reclamation, omission controls and actual binary disassembly are separate checks compiled with --gc arc. Expected compiler errors, rejected programs and successful ARC executions remain distinct. The original deep-recursion workload is checked against the optimized interpreter and golden output; a bounded version compares against the raw interpreter without raising stack limits. No universal speedup or C/Rust parity claim.',evidenceHashes={'numericalDownload':hashlib.sha256((numbers/'download.json').read_bytes()).hexdigest(),'arcDownload':hashlib.sha256((arc/'download.json').read_bytes()).hexdigest()})
p=root/'docs/measurements/ownership-and-arc-2026-10-12.json';assert not p.exists();p.write_text(json.dumps(report,indent=2)+'\n');print(p,len(p.read_bytes()))
