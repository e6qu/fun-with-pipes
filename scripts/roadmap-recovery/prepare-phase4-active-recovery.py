from pathlib import Path
import ast,json
source=Path('/private/tmp/fwp-publish-repaired-workspace-recovery.py').read_text();m=next(ast.literal_eval(n.value) for n in ast.parse(source).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='HELPERS' for t in n.targets))
patterns=['fwp-*matrix*.py','fwp-*matrix*.rs','fwp-*matrix*.c','fwp-*matrix*.fwp','fwp-*matrix*.json','fwp-*matrix*.yml','fwp-*library*-draft.*','fwp-*rust*workspace*.py','fwp-*rust*workspace*.json','fwp-*library*workspace*.json','fwp-prepare-workspace-scope-and-library-cleanup.py','fwp-prepare-rust-autodiff-workspace.py','fwp-download-accepted-numeric-source.py','fwp-record-accepted-numeric-source.py','fwp-accepted-numeric-source-audit-publication.json','fwp-numeric-storage-merge-proof.json','fwp-numeric-storage-final-gate-proof.json','fwp-numeric-storage-signed-payload.txt','fwp-main126-duplicate-ci-status.json','fwp-workspace-library-initial-failure.log','fwp-fetch-numerics-workspace-restoration.py','fwp-prepare-phase4-active-recovery.py']
paths=set()
for pat in patterns:paths.update(Path('/private/tmp').glob(pat))
for dirname in ['fwp-phase4-ad-workspace-draft','fwp-phase4-matrix-draft','fwp-matrix-pass-source','fwp-rust-numeric-workspace-evidence','fwp-accepted-numeric-source','fwp-verified-numerics-workspace-restoration']:
 paths.update(p for p in (Path('/private/tmp')/dirname).rglob('*') if p.is_file() and p.suffix in {'.rs','.c','.json','.txt'})
for p in sorted(paths):
 assert p.stat().st_size<4*1024*1024
 m['scripts/roadmap-recovery/'+p.relative_to('/private/tmp').as_posix().removeprefix('fwp-')]=str(p)
selfpath='/private/tmp/fwp-publish-phase4-active-recovery.py';m['scripts/roadmap-recovery/publish-phase4-active-recovery.py']=selfpath;m['scripts/roadmap-recovery/current-map.json']='/private/tmp/fwp-phase4-active-current-map.json'
Path(m['scripts/roadmap-recovery/current-map.json']).write_text(json.dumps({'version':1,'publisher':'scripts/roadmap-recovery/publish-phase4-active-recovery.py','scope':'Accepted phase3 proofs, active phase4 sources and controls, current user constraints'},indent=2)+'\n')
a=source.index('HELPERS = ');b=source.index('\nREMOVED_SNAPSHOT_DOCS',a);s=source[:a]+'HELPERS = '+repr(m)+source[b:]
s=s.replace("OLD = '3c555fd4c653b989c6afe3cac7550e2f8ac4c3d5'","OLD = '85ea2b6d130c86ff260f4ad1850f9eae444b5919'").replace('38212799992','38213004389').replace("audit['conclusion']=='failure'","audit['conclusion']=='success'").replace('Repair relative links in retained numerical source snapshots','Record accepted numeric storage and active numerical optimization work').replace('fwp-repaired-workspace-recovery-checkpoint.json','fwp-phase4-active-recovery-checkpoint.json')
# Obsolete snapshot docs were removed by the previous repair.
a=s.index('REMOVED_SNAPSHOT_DOCS = ');b=s.index('\ndef api',a);s=s[:a]+'REMOVED_SNAPSHOT_DOCS = []'+s[b:]
Path(selfpath).write_text(s);print('Prepared',len(m),'current recovery targets')
