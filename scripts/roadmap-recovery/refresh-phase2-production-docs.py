"""Apply current docs before opening the next PR, preserving verified native code."""
from pathlib import Path
import json,subprocess
OUT=Path('/private/tmp/fwp-phase2-exit-finalization-export')
manifest=json.loads((OUT/'phase2-exit.json').read_text());publication=json.loads((OUT/'publication.json').read_text());download=json.loads((OUT/'download.json').read_text())
assert publication['identity']['exportedHead']==manifest['head'] and publication['tree']==manifest['tree']
previous=json.loads(Path('/private/tmp/fwp-pr124-merge-proof.json').read_text());assert manifest['base']==previous['sha']
run=json.loads(subprocess.check_output(['gh','run','view',str(download['run']),'--json','headSha,status,conclusion,jobs'],text=True))
assert run['status']=='completed' and run['conclusion']=='success' and run['headSha']==download['driver']
assert len(run['jobs'])==1 and run['jobs'][0]['conclusion']=='success'
state=Path('docs/development-state.md');s=state.read_text();label='Combined ownership exit preparation passes';assert label not in s
s+='\n'+label+' runner'+str(download['run'])+' at driver'+download['driver']+'.\nNative export '+manifest['head']+' has tree'+manifest['tree']+' on the actual\nPR124 squash. All original allocation, sanitizer, raw/native, codec, type,\nformat/library/docs, inventory and finite fallback controls pass together.\nCurrent root docs are refreshed before opening the production PR; this update\nchanges documentation only. Query ownership-exit-and-buffer-bundle for its\ncurrent tip and require all six exact-head jobs and roadmap_docs before squash.\nPhase2 stays open until the actual merged-source audit passes.\n'
state.write_text(s)
DOCS=['CONTRIBUTING.md','PLAN.md','docs/design.md','docs/development-state.md','docs/ownership.md','docs/primitive-ownership.md','docs/roadmap-queue.md','docs/roadmap-history.md','docs/reference.md','docs/concurrency.md','docs/numerics.md']
argv=['python3','/private/tmp/fwp-publish-evidence-update.py','--branch','ownership-exit-and-buffer-bundle','--old',publication['head'],'--subject','Streamline current roadmap delivery and validation status','--receipt','/private/tmp/fwp-phase2-exit-docs-publication.json']
for name in DOCS:argv+=['--file',name+'='+str(Path(name).resolve())]
subprocess.run(argv,check=True)
print('Published current docs before any production PR or full gate')
