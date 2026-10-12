"""Prepare acceptance of the actual numeric squash only after its verified merge."""
from pathlib import Path
import hashlib,json,subprocess
repo='repos/e6qu/fun-with-pipes';proof=json.loads(Path('/private/tmp/fwp-numerical-merge-proof.json').read_text());gates=json.loads(Path('/private/tmp/fwp-numerical-final-gate-proof.json').read_text());base=proof['sha'];branch='ownership-evidence-accepted-numerical-kernels'
receipt=Path('/private/tmp/fwp-accepted-numerical-source-audit-publication.json');assert not receipt.exists()
def api(path,data=None):
 cmd=['gh','api',repo+path]
 if data is not None:
  p=Path('/private/tmp/fwp-accepted-numerical-audit-api.json');p.write_text(json.dumps(data));cmd+=['--method','POST','--input',str(p)]
 return json.loads(subprocess.check_output(cmd))
assert api('/git/ref/heads/main')['object']['sha']==base
report=json.loads(Path('/private/tmp/fwp-numerical-production-publication.json').read_text());assert report['head']==proof['acceptedHead'];files=report['files']
expected=dict(accepted=base,files=files,docs=report['docs'],gates={n:v['run'] for n,v in gates['gates'].items()})
workflow='''name: Accepted numerical kernel source audit
on:
  push:
    branches: [ownership-evidence-accepted-numerical-kernels]
permissions:
  contents: read
  actions: read
  pull-requests: read
jobs:
  accept_numeric_source:
    runs-on: ubuntu-latest
    timeout-minutes: 8
    steps:
      - uses: actions/checkout@v7
      - name: Retain acceptance instructions
        run: |
          cp scripts/audit-accepted-numerical-source.py "$RUNNER_TEMP/"
          cp tests/fixtures/accepted-numerical-source.json "$RUNNER_TEMP/"
          cp tests/fixtures/accepted-numerical-merge-proof.json "$RUNNER_TEMP/"
      - uses: actions/checkout@v7
        with:
          ref: ACCEPTED_SHA
          fetch-depth: 0
      - name: Retain immutable review references
        run: git fetch origin "+refs/pull/*/head:refs/remotes/origin/review/*"
      - name: Verify actual merged source and exact-head gates
        env:
          GH_TOKEN: ${{ github.token }}
        run: python3 "$RUNNER_TEMP/audit-accepted-numerical-source.py" --expected "$RUNNER_TEMP/accepted-numerical-source.json" --proof "$RUNNER_TEMP/accepted-numerical-merge-proof.json"
      - uses: actions/upload-artifact@v7
        if: always()
        with:
          name: accepted-numerical-kernels-source
          path: numerical-kernels-acceptance/
'''.replace('ACCEPTED_SHA',base)
content={'scripts/audit-accepted-numerical-source.py':Path('/private/tmp/fwp-audit-accepted-numerical-source-on-runner.py').read_text(),'tests/fixtures/accepted-numerical-source.json':json.dumps(expected,indent=2)+'\n','tests/fixtures/accepted-numerical-merge-proof.json':json.dumps(proof,indent=2)+'\n','.github/workflows/accepted-numerical-kernels-source-audit.yml':workflow}
parent=api('/git/commits/'+base);tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=n,mode='100644',type='blob',content=s) for n,s in content.items()]))
subject='Audit accepted numerical kernels and complete platform gates';assert len(subject)<=80
commit=api('/git/commits',dict(message=subject,tree=tree['sha'],parents=[base]));assert commit['message']==subject
ref=api('/git/refs',dict(ref='refs/heads/'+branch,sha=commit['sha']));assert ref['object']['sha']==commit['sha']
receipt.write_text(json.dumps(dict(head=commit['sha'],accepted=base,branch=branch,expected=expected),indent=2)+'\n');print(commit['sha'])
