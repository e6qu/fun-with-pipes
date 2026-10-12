from pathlib import Path
import ast,json
old=Path('/private/tmp/fwp-publish-current-numeric-recovery-checkpoint.py').read_text()
helpers=next(ast.literal_eval(n.value) for n in ast.parse(old).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='HELPERS' for t in n.targets))
patterns=['fwp-*fusion*.py','fwp-*fusion*.json','fwp-*fusion*.yml','fwp-*fusion*.rs','fwp-*fusion*.c','fwp-*autodiff*.py','fwp-*autodiff*.rs','fwp-*autodiff*.c','fwp-*workspace*.py','fwp-*workspace*.json','fwp-publish-source-preparation-update.py','fwp-audit-accepted-numeric-source-on-runner.py','fwp-publish-accepted-numeric-source-audit.py','fwp-phase4-*.md','fwp-prepare-numerics-workspace-recovery.py','fwp-download-array-fusion-*.py']
paths=set()
for pattern in patterns:paths.update(Path('/private/tmp').glob(pattern))
for name in ['fwp-phase4-ad-source','fwp-phase4-ad-draft','fwp-phase4-ad-workspace-draft','fwp-phase4-array-fusion-draft','fwp-numeric-fusion-workspace-evidence','fwp-array-fusion-zero-allocation-evidence','fwp-verified-current-numeric-restoration']:
 paths.update(p for p in (Path('/private/tmp')/name).rglob('*') if p.is_file() and p.suffix in {'.rs','.c','.json','.fwp','.md','.txt'})
for p in sorted(paths):
 assert p.is_file() and p.stat().st_size<4*1024*1024
 helpers['scripts/roadmap-recovery/'+p.relative_to('/private/tmp').as_posix().removeprefix('fwp-')]=str(p)
pub='/private/tmp/fwp-publish-numerics-workspace-recovery.py'
helpers['scripts/roadmap-recovery/publish-numerics-workspace-recovery.py']=pub
helpers['scripts/roadmap-recovery/current-map.json']='/private/tmp/fwp-numerics-workspace-current-map.json'
Path(helpers['scripts/roadmap-recovery/current-map.json']).write_text(json.dumps({'version':1,'publisher':'scripts/roadmap-recovery/publish-numerics-workspace-recovery.py','scope':'Verified Linux numerics preparation, current production gates and actual-source audit helpers; earlier checkpoints retain historical assembly'},indent=2)+'\n')
a=old.index('HELPERS = ');b=old.index('\nREMOVED_SNAPSHOT_DOCS',a)
s=old[:a]+'HELPERS = '+repr(helpers)+old[b:]
s=s.replace("OLD = 'b61cde67f467fc67d672b1d0efd3c0cf59a3acad'","OLD = '593553e47efa314b9c2b5df1803d9620caa7d693'").replace('38200778577','38207907474').replace('Retain numeric storage repairs and next compiler preparation','Retain verified fusion and bounded autodiff workspace evidence').replace('fwp-current-numeric-recovery-checkpoint.json','fwp-numerics-workspace-recovery-checkpoint.json')
Path(pub).write_text(s)
print('Prepared',len(helpers),'recovery targets')
