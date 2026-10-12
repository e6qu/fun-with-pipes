# Publish the verified variant repair to the existing ownership PR.
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes');REPO='repos/e6qu/fun-with-pipes'
BRANCH='checked-arc-and-loop-ownership';OLD='82d552c48663c28d05543313fa91e05b8c327b14'
OUT=Path('/private/tmp/fwp-variant-return-pr-repair-publication.json');assert not OUT.exists()
primary=Path('/private/tmp/fwp-ownership-production-publication.json');publication=json.loads(primary.read_text());assert publication['head']==OLD
failure=json.loads(Path('/private/tmp/fwp-pr128-initial-ci-failures.json').read_text());assert failure['head']==OLD and failure['run']==38244684931
assert failure['failures'] and all(f['job']['conclusion']=='failure' and f['targets']==['stack'] and f['tests']==['variants_returned_as_structs_are_not_allocated'] for f in failure['failures']),failure['failures']
proof=json.loads(Path('/private/tmp/fwp-aggregate-return-repair-evidence/download.json').read_text())
def api(path,payload=None,graphql=False,method='POST'):
 cmd=['gh','api','graphql' if graphql else REPO+path]
 if payload is not None:
  p=Path('/private/tmp/fwp-variant-return-pr-api.json');p.write_text(json.dumps(payload));cmd+=['--method',method,'--input',str(p)]
 return json.loads(subprocess.check_output(cmd))
r=api('/actions/runs/'+str(proof['run']));assert r['head_sha']==proof['head'] and r['status']=='completed' and r['conclusion']=='success'
j=api('/actions/runs/'+str(proof['run'])+'/jobs')['jobs'];assert len(j)==3 and all(x['conclusion']=='success' for x in j)
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
pr=api('/pulls/'+str(publication['pr']));assert pr['state']=='open' and pr['head']['sha']==OLD and pr['base']['sha']==publication['base']
source=Path('/private/tmp/fwp-aggregate-return-repair-evidence/ubuntu-latest/source/cgen.rs').read_text();assert all(hashlib.sha256(source.encode()).hexdigest()==p['formattedSourceSha256'] for p in proof['reports'])
files={'src/cgen.rs':source,'.github/workflows/numerics.yml':Path('/private/tmp/fwp-ownership-production-draft/numerics.yml').read_text()}
for name,artifact in [('tests/stack.rs','stack.rs'),('tests/stack/wide_alias.fwp','wide_alias.fwp')]:
 value=(Path('/private/tmp/fwp-aggregate-return-repair-evidence/ubuntu-latest/source')/artifact).read_text()
 assert all(hashlib.sha256(value.encode()).hexdigest()==p['formattedSourceHashes']['source/'+artifact] for p in proof['reports'])
 files[name]=value

for name in publication['docs']+['docs/measurements/ownership-and-arc-2026-10-12.json']:files[name]=(ROOT/name).read_text()
parent=api('/git/commits/'+OLD);before=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not before['truncated'];prior={x['path']:(x['sha'],x['mode'],x['type']) for x in before['tree'] if x['type']!='tree'}
entries=[]
for name,value in files.items():
 data=value.encode();digest=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
 if prior.get(name,(None,))[0]!=digest:entries.append(dict(path=name,mode='100644',type='blob',content=value))
assert len(json.dumps(entries).encode())<2*1024*1024
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=entries));after=api('/git/trees/'+tree['sha']+'?recursive=1');assert not after['truncated'];now={x['path']:(x['sha'],x['mode'],x['type']) for x in after['tree'] if x['type']!='tree'}
assert set(prior)<=set(now) and {n for n in now if now[n]!=prior.get(n)}<=set(files)
for name,value in files.items():
 data=value.encode();assert now[name][0]==hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
subject='Keep typed aggregate returns unboxed through local aliases';assert len(subject)<=80
commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[OLD]));assert commit['message']==subject
node=api('')['node_id'];result=api('',dict(query='mutation($repo:ID!,$updates:[RefUpdate!]!){updateRefs(input:{repositoryId:$repo,refUpdates:$updates}){clientMutationId}}',variables=dict(repo=node,updates=[dict(name='refs/heads/'+BRANCH,beforeOid=OLD,afterOid=commit['sha'],force=False)])),graphql=True);assert not result.get('errors'),result
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==commit['sha']
backup=Path('/private/tmp/fwp-ownership-production-initial-publication.json');assert not backup.exists();backup.write_bytes(primary.read_bytes())
publication['previousHeads']=[OLD];publication['head']=commit['sha'];publication['tree']=tree['sha'];publication['variantReturnRepair']=dict(head=proof['head'],run=proof['run'])
publication['files'].update({n:hashlib.sha256(v.encode()).hexdigest() for n,v in files.items()});primary.write_text(json.dumps(publication,indent=2)+'\n')
OUT.write_text(json.dumps(dict(head=commit['sha'],previous=OLD,tree=tree['sha'],branch=BRANCH,pr=pr['number'],repairHead=proof['head'],repairRun=proof['run'],files={n:hashlib.sha256(v.encode()).hexdigest() for n,v in files.items()}),indent=2)+'\n')
body=pr['body'];needle='Formatting writes directly into one buffer, removing managed rendering temporaries.';assert needle in body
body=body.replace(needle,'Aggregate-return analysis follows typed constructor aliases and keeps variant and wide-record fields in C structs, preserving the original allocation controls and the added wide-record alias regression without erasing ownership types. '+needle,1)
api('/pulls/'+str(pr['number']),dict(body=body),method='PATCH')
print('Updated PR',pr['number'],commit['sha'])
