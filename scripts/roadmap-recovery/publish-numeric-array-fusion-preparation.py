from pathlib import Path
import json,subprocess,hashlib
REPO='repos/e6qu/fun-with-pipes';BASE='8d244fedf2b22c6b3df3d88c4fa15673c8ff28ba';BRANCH='ownership-evidence-numeric-array-fusion'
receipt=Path('/private/tmp/fwp-numeric-array-fusion-preparation-publication.json');assert not receipt.exists()
def api(path,data=None):
 c=['gh','api',REPO+path]
 if data is not None:
  p=Path('/private/tmp/fwp-pr126-probe-api.json');p.write_text(json.dumps(data));c+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(c))
assert api('/pulls/126')['head']['sha']==BASE
files={'tests/'+n+'.rs':Path('/private/tmp/fwp-pr126-probe-repairs/'+n+'.rs').read_text() for n in ['old_reclamation','retain_unwind_ownership','unboxed_worker_locals']}
files.update({
 'src/fuse.rs':Path('/private/tmp/fwp-phase4-array-fusion-draft/fuse.rs').read_text(),
 'src/cgen.rs':Path('/private/tmp/fwp-phase4-array-fusion-draft/cgen.rs').read_text(),
 'tests/fixtures/numeric_array_fusion.fwp':Path('/private/tmp/fwp-numeric-array-fusion-fixture-draft.fwp').read_text(),
 'tests/fixtures/array_fusion_allocation_probe.c':Path('/private/tmp/fwp-array-fusion-allocation-probe-draft.c').read_text(),
 'scripts/measure-numeric-array-fusion.py':Path('/private/tmp/fwp-measure-numeric-array-fusion.py').read_text(),
 '.github/workflows/numeric-array-fusion-preparation.yml':Path('/private/tmp/fwp-array-fusion-preparation.yml').read_text(),
})
parent=api('/git/commits/'+BASE)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=k,mode='100644',type='blob',content=v) for k,v in files.items()]))
subject='Prepare numeric Array fusion with allocation and semantic controls'
assert len(subject)<=80
commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[BASE]));assert commit['message']==subject
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
receipt.write_text(json.dumps(dict(head=commit['sha'],base=BASE,branch=BRANCH,files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()}),indent=2)+'\n');print(commit['sha'])
