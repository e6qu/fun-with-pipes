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
for row in (root/'docs/roadmap-queue.md').read_text().splitlines():
 if not re.match(r'\| \d+ \|',row): continue
 fields=row.split('|'); old=fields[5].strip().strip('`'); parent=fields[6].strip().strip('`')
 subprocess.run(['git','merge-base','--is-ancestor',parent,old],cwd=root,check=True)
 pairs+=1
for revision in ['49f9108','bcdfb16','e21c92e','923ad4a','30fe112','046f7e8','c889479','681dd55','e9f31a9','dbdaee4','8e6a891','658e5b7','22a520c','74a6e3f','6364bed','2d903d6','750a5cf','1786922','7222247','5fd2ed6','cca99c0','7018086','786e4bb','ae00e69','3a0cbdb','f85cc4e','8abfd46','dc2ad1f','ee4bd22','291f8f7','cb0d7e6','5fe5692','5c19337','15743b8','7af6961','112f3c8','6ce37fb','3c0685c','bd7a20b','8723724','bf05481','7741d09','443524e','1689c03','3606f2c','d2e0e29','f4716a0','90762aa','9f4e3bb','cde58f4','123d8b5','216e673','786f170','e3c49d9','8093bf3','69b1ad1','6a09138','1e8d1e3','dc9bfd5','ada6a3a','646cca0','1358267','5d0a3f3','df58628','3b6bf09','7ae7813','f0049c4','c90fe5a','3956d5c','1b18b11','f22b5b5','e2f944c','610fd74','321cc31','6d01e92','762cc82','af073c7','427076c','aa181f8','28de179','4b6a2cb','ccbf295','82f32b2','60e5d62','03d25ac','f240ecd','878b25a','5b6e65f','00013d5','838cf5d','d56a24e','c299edb','0be5083','66e80d3','ae05b2b','2ba7084','b728cf5','22b95b0','7d8ab67','821e6c1','0d09a61','8a061cb','d461164','cf45252','3c87e1f','4b5da4a','d174e73','db3bcf0','65fedd8','b4860bf','b4482c2','9609b73','35c2aeb','e7d3882','faac017','06c93ef','f3c9ee4','d2936a0','46b163c','97dca76','5915ac0','f086110','e91dcb3','d29dda9','6f310b5','3c268c3','2c1003c','6b1cd9b','09751c8','a92c951','8bd9e78','542fc08','6b82bc5','ea79bde','671ada6','663ef59','4114b70','79bc00f','b44f53c','2339ff0','33661b2','de969ee','c8d4b57','c48864c','b244d5f','cb20833','7a89dd0','559f4ac','dc85b67','ea18e54','36ad634','d178d86','c9ef3d8','352affa']:
 body=subprocess.check_output(['git','show','-s','--format=%B',revision],cwd=root,text=True).rstrip('\n')
 assert len(body.splitlines())==1 and len(body)<=80,(revision,body)
 assert not any(s in body.lower() for s in ['co-authored','authored-by','ai attribution']),body
print(f'{len(files)} doc link sets and {pairs} immutable queue pairs pass; commit messages pass')
