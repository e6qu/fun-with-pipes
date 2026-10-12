# Publish final roadmap documentation after accepted implementation.
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path('/Users/zardoz/projects/fun-with-pipes');REPO='repos/e6qu/fun-with-pipes'
proof=json.loads(Path('/private/tmp/fwp-ownership-merge-proof.json').read_text());BASE=proof['sha']
a=json.loads(Path('/private/tmp/fwp-accepted-ownership-source/phase5-6-acceptance.json').read_text());assert a['accepted']==BASE
BRANCH='complete-language-roadmap-docs';SUBJECT='Record completed roadmap and accepted ownership evidence'
RECEIPT=Path('/private/tmp/fwp-roadmap-docs-publication.json');assert not RECEIPT.exists()
DOCS=['AGENTS.md','CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
def api(path,payload=None):
 cmd=['gh','api',REPO+path]
 if payload is not None:
  p=Path('/private/tmp/fwp-roadmap-docs-api.json');p.write_text(json.dumps(payload));cmd+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(cmd))
assert api('/git/ref/heads/main')['object']['sha']==BASE
assert not api('/pulls?state=open&base=main&per_page=100')
p=subprocess.run(['gh','api',REPO+'/git/ref/heads/'+BRANCH],capture_output=True,text=True);assert p.returncode and '404' in p.stderr
files={n:(ROOT/n).read_text() for n in DOCS};assert '| 5 | Done:' in files['PLAN.md'] and '| 6 | Done:' in files['PLAN.md']
parent=api('/git/commits/'+BASE);before=api('/git/trees/'+parent['tree']['sha']+'?recursive=1');assert not before['truncated'];prior={x['path']:(x['sha'],x['mode'],x['type']) for x in before['tree'] if x['type']!='tree'}
entries=[]
for name,value in files.items():
 data=value.encode();digest=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
 if prior[name][0]!=digest:entries.append(dict(path=name,mode='100644',type='blob',content=value))
assert entries and len(json.dumps(entries).encode())<2*1024*1024
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=entries));after=api('/git/trees/'+tree['sha']+'?recursive=1');assert not after['truncated'];now={x['path']:(x['sha'],x['mode'],x['type']) for x in after['tree'] if x['type']!='tree'}
assert set(now)==set(prior) and {n for n in now if now[n]!=prior[n]}<=set(DOCS)
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[BASE]));assert commit['message']==SUBJECT
ref=api('/git/refs',dict(ref='refs/heads/'+BRANCH,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
body=f'''The implementation roadmap is accepted through PR #{proof['pr']}, including all six production jobs and the actual merged-source audit. This closes the plan, consolidates the handoff around accepted evidence, removes stale preparation wording and retains explicit ARC exclusions and measurement limits. No implementation source changes.

The documentation records the supported subset and distinguishes numerical timing from ARC reclamation evidence. It preserves the no-needless-wrappers/fallbacks rule, normal register spilling and protocol alternatives.

This final documentation PR still requires all six exact-head jobs and the roadmap audit before its single-line squash.'''
pr=api('/pulls',dict(title=SUBJECT,head=BRANCH,base='main',body=body,draft=False))
RECEIPT.write_text(json.dumps(dict(head=commit['sha'],base=BASE,tree=tree['sha'],branch=BRANCH,pr=pr['number'],url=pr['html_url'],files={n:hashlib.sha256(v.encode()).hexdigest() for n,v in files.items()},docs=DOCS),indent=2)+'\n');print(pr['html_url'],commit['sha'])
