from pathlib import Path
import ast,json
p=Path('/private/tmp/fwp-publish-numerics-workspace-recovery.py');s=p.read_text()
m=next(ast.literal_eval(n.value) for n in ast.parse(s).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='HELPERS' for t in n.targets))
removed=[]
for k,v in list(m.items()):
 if k.endswith('.md'):
  removed.append(k);del m[k];m[k+'.source']=v
# The authoritative root documents retain live links; draft snapshots keep exact
# source bytes under non-document names so moved relative links aren't published.
selfpath='/private/tmp/fwp-publish-repaired-workspace-recovery.py'
m['scripts/roadmap-recovery/publish-repaired-workspace-recovery.py']=selfpath
m['scripts/roadmap-recovery/repair-workspace-recovery-links.py']='/private/tmp/fwp-repair-workspace-recovery-links.py'
m['scripts/roadmap-recovery/current-map.json']='/private/tmp/fwp-repaired-workspace-current-map.json'
Path(m['scripts/roadmap-recovery/current-map.json']).write_text(json.dumps({'version':1,'publisher':'scripts/roadmap-recovery/publish-repaired-workspace-recovery.py','scope':'Current verified preparation and exact draft source snapshots; root docs supply live links'},indent=2)+'\n')
a=s.index('HELPERS = ');b=s.index('\nREMOVED_SNAPSHOT_DOCS',a);s=s[:a]+'HELPERS = '+repr(m)+s[b:]
s=s.replace('REMOVED_SNAPSHOT_DOCS = []','REMOVED_SNAPSHOT_DOCS = '+repr(removed)).replace("OLD = '593553e47efa314b9c2b5df1803d9620caa7d693'","OLD = '3c555fd4c653b989c6afe3cac7550e2f8ac4c3d5'").replace('38207907474','38212799992').replace("audit['conclusion']=='success'","audit['conclusion']=='failure'").replace('Retain verified fusion and bounded autodiff workspace evidence','Repair relative links in retained numerical source snapshots').replace('fwp-numerics-workspace-recovery-checkpoint.json','fwp-repaired-workspace-recovery-checkpoint.json')
Path(selfpath).write_text(s)
