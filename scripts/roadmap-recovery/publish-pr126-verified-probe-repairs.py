from pathlib import Path
import hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';OLD='8d244fedf2b22c6b3df3d88c4fa15673c8ff28ba';BRANCH='numeric-storage-and-worker-abi';ROOT=Path('/Users/zardoz/projects/fun-with-pipes');OUT=Path('/private/tmp/fwp-pr126-probe-repair-export')
receipt=Path('/private/tmp/fwp-pr126-verified-probe-repairs-publication.json');assert not receipt.exists()
def api(path,data=None,graphql=False):
 c=['gh','api','graphql' if graphql else REPO+path]
 if data is not None:
  p=Path('/private/tmp/fwp-pr126-verified-probe-api.json');p.write_text(json.dumps(data));c+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(c))
proof=json.loads((OUT/'download.json').read_text());r=api('/actions/runs/'+str(proof['run']));assert r['head_sha']==proof['head'] and r['conclusion']=='success' and r['status']=='completed'
assert api('/pulls/126')['head']['sha']==OLD and api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
files={'tests/'+n+'.rs':(OUT/(n+'.rs')).read_text() for n in ['old_reclamation','retain_unwind_ownership','unboxed_worker_locals']}
files.update({n:(ROOT/n).read_text() for n in ['docs/design.md','docs/development-state.md']})
parent=api('/git/commits/'+OLD);tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=k,mode='100644',type='blob',content=v) for k,v in files.items()]))
subject='Update ownership probes for numeric storage and worker layouts';assert len(subject)<=80
commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[OLD]));assert commit['message']==subject
node=api('')['node_id'];result=api('',dict(query='mutation($repo:ID!,$updates:[RefUpdate!]!){updateRefs(input:{repositoryId:$repo,refUpdates:$updates}){clientMutationId}}',variables=dict(repo=node,updates=[dict(name='refs/heads/'+BRANCH,beforeOid=OLD,afterOid=commit['sha'],force=False)])),graphql=True);assert not result.get('errors'),result
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==commit['sha']
receipt.write_text(json.dumps(dict(head=commit['sha'],previous=OLD,tree=tree['sha'],focusedRun=proof['run'],files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()}),indent=2)+'\n');print(commit['sha'])
