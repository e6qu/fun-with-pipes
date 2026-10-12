from pathlib import Path
import ast,base64,json
old=Path('/private/tmp/fwp-publish-packed-controls-recovery-checkpoint.py');s=old.read_text();module=ast.parse(s)
node=next(n for n in module.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='HELPERS' for t in n.targets))
helpers=ast.literal_eval(node.value)
new=Path('/private/tmp/fwp-publish-current-numeric-recovery-checkpoint.py')
helpers['scripts/roadmap-recovery/publish-current-numeric-recovery-checkpoint.py']=str(new)
selected=['fwp-merge-numeric-storage.py','fwp-prepare-protocol-bounds.py','fwp-protocol-empty-wire-draft.c','fwp-protocol-count-probe-draft.c','fwp-finalize-numeric-storage-on-runner.py','fwp-download-numeric-storage-finalization.py','fwp-publish-numeric-storage-production.py','fwp-numeric-storage-production-publication.json','fwp-numeric-storage-history-repair-publication.json','fwp-numeric-storage-superseded-history-ci.json','fwp-fetch-phase4-source.py','fwp-prepare-numeric-array-fusion.py','fwp-numeric-array-fusion-fixture-draft.fwp','fwp-array-fusion-allocation-probe-draft.c','fwp-measure-numeric-array-fusion.py','fwp-prepare-pr126-probe-repairs.py','fwp-pr126-probe-repair.yml','fwp-publish-pr126-probe-preparation.py','fwp-pr126-probe-preparation-publication.json','fwp-download-pr126-probe-repairs.py','fwp-publish-pr126-verified-probe-repairs.py','fwp-pr126-verified-probe-repairs-publication.json','fwp-array-fusion-preparation.yml','fwp-publish-numeric-array-fusion-preparation.py','fwp-numeric-array-fusion-preparation-publication.json','fwp-download-array-fusion-initial.py','fwp-pr126-superseded-probe-ci.json','fwp-restore-numeric-finalization-archive.py','fwp-prepare-current-numeric-recovery.py']
for name in selected:
 p=Path('/private/tmp')/name;assert p.exists(),name;helpers['scripts/roadmap-recovery/'+name.removeprefix('fwp-')]=str(p)
out=Path('/private/tmp/fwp-numeric-storage-finalization-export');(out/'production-files.json.gz.base64').write_bytes(base64.b64encode((out/'production-files.json.gz').read_bytes()))
for dirname in ['fwp-numeric-storage-finalization-export','fwp-phase4-source','fwp-phase4-array-fusion-draft','fwp-pr126-probe-repair-export','fwp-array-fusion-initial-evidence','fwp-verified-packed-controls-restoration']:
 directory=Path('/private/tmp')/dirname
 for p in directory.rglob('*'):
  if p.is_file() and (p.suffix in {'.rs','.c','.json','.fwp','.base64'} or p.name in {'head.txt','hashes.txt'}):
   helpers['scripts/roadmap-recovery/'+dirname.removeprefix('fwp-')+'/'+str(p.relative_to(directory))]=str(p)
lines=s.splitlines(keepends=True);lines[node.lineno-1:node.end_lineno]=['HELPERS = '+repr(helpers)+'\n'];s=''.join(lines)
s=s.replace("OLD = '2091ad9bacf33806b8de1cecddf626e667575eef'", "OLD = 'b61cde67f467fc67d672b1d0efd3c0cf59a3acad'").replace("SUBJECT = 'Retain packed array controls and current roadmap handoff'", "SUBJECT = 'Retain numeric storage repairs and next compiler preparation'").replace('/actions/runs/38198377356','/actions/runs/38200778577').replace('/private/tmp/fwp-packed-controls-recovery-checkpoint.json','/private/tmp/fwp-current-numeric-recovery-checkpoint.json')
assert all(Path(v).exists() or Path(v)==new for v in helpers.values())
new.write_text(s)
Path('/private/tmp/fwp-current-recovery-map.json').write_text(json.dumps(dict(version=1,publisher='scripts/roadmap-recovery/publish-current-numeric-recovery-checkpoint.py',scope='Current production numeric storage repairs, exact-head receipts and unverified next-phase source; older checkpoints preserve complete historical evidence'),indent=2)+'\n')
print('Prepared current recovery mapping:',len(helpers),'temporary targets')
