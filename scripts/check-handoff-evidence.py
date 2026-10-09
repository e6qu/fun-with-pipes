import re, subprocess
from pathlib import Path
root=Path(__file__).resolve().parent.parent
files=['AGENTS.md','CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/primitive-ownership.md','docs/reference.md','docs/concurrency.md']
for name in files:
 p=root/name
 for target in re.findall(r'\]\(([^)]+)\)',p.read_text()):
  target=target.split(' ')[0]
  path, _, fragment=target.partition('#')
  if '://' in path or path.startswith('/') : continue
  linked=(p.parent/path) if path else p
  assert linked.exists(), (name,target)
  if fragment and linked.suffix=='.md':
   anchors=set()
   counts={}
   for heading in re.findall(r'^#{1,6} +(.+)$',linked.read_text(),re.M):
    anchor=re.sub(r'[^\w -]','',heading.lower()).replace(' ','-')
    count=counts.get(anchor,0);counts[anchor]=count+1
    anchors.add(anchor if not count else f'{anchor}-{count}')
   assert fragment in anchors,(name,target,'missing heading')
pairs=0
revisions={"HEAD"}
for row in (root/'docs/roadmap-queue.md').read_text().splitlines():
 if not re.match(r'\| \d+ \|',row): continue
 fields=row.split('|'); old=fields[5].strip().strip('`'); parent=fields[6].strip().strip('`')
 subprocess.run(['git','merge-base','--is-ancestor',parent,old],cwd=root,check=True)
 revisions.update([fields[4].strip().strip("`"),old])
 pairs+=1
for revision in sorted(revisions):
 body=subprocess.check_output(['git','show','-s','--format=%B',revision],cwd=root,text=True).rstrip('\n')
 assert len(body.splitlines())==1 and len(body)<=80,(revision,body)
 assert not any(s in body.lower() for s in ['co-authored','authored-by','ai attribution']),body
print(f'{len(files)} doc link sets and {pairs} immutable queue pairs pass; commit messages pass')
