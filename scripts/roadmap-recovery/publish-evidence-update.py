"""Publish bounded evidence repairs with an exact branch lease."""
from pathlib import Path
import argparse,hashlib,json,subprocess
p=argparse.ArgumentParser();p.add_argument('--branch',required=True);p.add_argument('--old',required=True);p.add_argument('--subject',required=True);p.add_argument('--receipt',type=Path,required=True);p.add_argument('--file',action='append',required=True);a=p.parse_args()
assert len(a.subject)<=80 and '\n' not in a.subject
assert not any(t in a.subject.lower() for t in ['co-authored','authored by','authored-by','ai attribution'])
assert not a.receipt.exists()
def api(path,data=None,graphql=False):
 cmd=['gh','api','graphql' if graphql else 'repos/e6qu/fun-with-pipes'+path]
 if data is not None:
  f=Path('/private/tmp/fwp-evidence-update-api-input.json');f.write_text(json.dumps(data));cmd+=['--method','POST','--input',str(f)]
 return json.loads(subprocess.check_output(cmd,text=True))
assert api('/git/ref/heads/'+a.branch)['object']['sha']==a.old
parent=api('/git/commits/'+a.old);files={}
for item in a.file:
 dest,local=item.split('=',1);assert not dest.startswith('/') and '..' not in Path(dest).parts
 files[dest]=Path(local).read_bytes()
assert sum(len(v) for v in files.values())<8*1024*1024
tr=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=k,mode='100644',type='blob',content=v.decode()) for k,v in files.items()]))
def entries(sha):
 r=api('/git/trees/'+sha+'?recursive=1');assert not r['truncated'];return {x['path']:(x['sha'],x['mode'],x['type']) for x in r['tree'] if x['type']!='tree'}
b=entries(parent['tree']['sha']);n=entries(tr['sha']);assert set(b)<=set(n)
assert {k for k in n if b.get(k)!=n[k]}<=set(files)
for k,v in files.items():assert n[k][0]==hashlib.sha1(b'blob '+str(len(v)).encode()+b'\0'+v).hexdigest()
c=api('/git/commits',dict(message=a.subject,tree=tr['sha'],parents=[a.old]));assert c['message']==a.subject and [x['sha'] for x in c['parents']]==[a.old]
r=api('',dict(query='mutation($repo:ID!,$updates:[RefUpdate!]!){updateRefs(input:{repositoryId:$repo,refUpdates:$updates}){clientMutationId}}',variables=dict(repo=api('')['node_id'],updates=[dict(name='refs/heads/'+a.branch,beforeOid=a.old,afterOid=c['sha'],force=False)])),graphql=True);assert not r.get('errors'),r
assert api('/git/ref/heads/'+a.branch)['object']['sha']==c['sha']
a.receipt.write_text(json.dumps(dict(head=c['sha'],previous=a.old,branch=a.branch,tree=tr['sha'],files={k:hashlib.sha256(v).hexdigest() for k,v in files.items()}),indent=2)+'\n');print(c['sha'])
