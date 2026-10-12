"""Publish bounded reviewed source changes with an exact preparation branch lease."""
from pathlib import Path
import argparse,hashlib,json,subprocess
p=argparse.ArgumentParser();p.add_argument('--branch',required=True);p.add_argument('--old',required=True);p.add_argument('--files-json',type=Path,required=True);p.add_argument('--subject',required=True);p.add_argument('--receipt',type=Path,required=True);a=p.parse_args()
assert a.branch.startswith('ownership-evidence-') and not a.receipt.exists()
assert len(a.subject)<=80 and '\n' not in a.subject and not any(x in a.subject.lower() for x in ['co-authored','authored by','authored-by','ai attribution'])
repo='repos/e6qu/fun-with-pipes'
def api(path,data=None,graphql=False):
 cmd=['gh','api','graphql' if graphql else repo+path]
 if data is not None:
  q=Path('/private/tmp/fwp-source-preparation-api.json');q.write_text(json.dumps(data));cmd+=['--method','POST','--input',str(q)]
 return json.loads(subprocess.check_output(cmd))
assert api('/git/ref/heads/'+a.branch)['object']['sha']==a.old
mapping=json.loads(a.files_json.read_text());files={}
for name,source in mapping.items():
 assert not Path(name).is_absolute() and '..' not in Path(name).parts
 q=Path(source);assert q.resolve().is_relative_to(Path('/private/tmp'))
 files[name]=q.read_text();assert len(files[name].encode())<1024*1024
entries=[dict(path=k,mode='100644',type='blob',content=v) for k,v in files.items()];assert len(json.dumps(entries).encode())<2*1024*1024
parent=api('/git/commits/'+a.old);tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=entries))
commit=api('/git/commits',dict(message=a.subject,tree=tree['sha'],parents=[a.old]));assert commit['message']==a.subject
node=api('')['node_id'];r=api('',dict(query='mutation($repo:ID!,$updates:[RefUpdate!]!){updateRefs(input:{repositoryId:$repo,refUpdates:$updates}){clientMutationId}}',variables=dict(repo=node,updates=[dict(name='refs/heads/'+a.branch,beforeOid=a.old,afterOid=commit['sha'],force=False)])),graphql=True);assert not r.get('errors'),r
assert api('/git/ref/heads/'+a.branch)['object']['sha']==commit['sha']
a.receipt.write_text(json.dumps(dict(head=commit['sha'],previous=a.old,tree=tree['sha'],branch=a.branch,files={k:hashlib.sha256(v.encode()).hexdigest() for k,v in files.items()}),indent=2)+'\n');print(commit['sha'])
