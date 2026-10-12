from pathlib import Path
import json,subprocess,hashlib
REPO='repos/e6qu/fun-with-pipes';BASE='8d244fedf2b22c6b3df3d88c4fa15673c8ff28ba';BRANCH='ownership-evidence-pr126-probe-repairs'
receipt=Path('/private/tmp/fwp-pr126-probe-preparation-publication.json');assert not receipt.exists()
def api(path,data=None):
 c=['gh','api',REPO+path]
 if data is not None:
  p=Path('/private/tmp/fwp-pr126-probe-api.json');p.write_text(json.dumps(data));c+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(c))
assert api('/pulls/126')['head']['sha']==BASE
files={'tests/'+n+'.rs':Path('/private/tmp/fwp-pr126-probe-repairs/'+n+'.rs').read_text() for n in ['old_reclamation','retain_unwind_ownership','unboxed_worker_locals']}
files['.github/workflows/numeric-storage-probe-repair.yml']=Path('/private/tmp/fwp-pr126-probe-repair.yml').read_text()
parent=api('/git/commits/'+BASE)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=k,mode='100644',type='blob',content=v) for k,v in files.items()]))
subject='Adapt ownership regression probes to packed arrays and typed workers'
assert len(subject)<=80
commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[BASE]));assert commit['message']==subject
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
receipt.write_text(json.dumps(dict(head=commit['sha'],base=BASE,branch=BRANCH,files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()}),indent=2)+'\n');print(commit['sha'])
