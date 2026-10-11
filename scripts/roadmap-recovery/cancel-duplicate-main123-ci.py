"""Avoid repeating full CI on the exact tree already accepted before squash."""
from pathlib import Path
import json,subprocess
REPO='repos/e6qu/fun-with-pipes';RUN=38161107239
def api(path):return json.loads(subprocess.check_output(['gh','api',REPO+path],text=True))
proof=json.loads(Path('/private/tmp/fwp-pr123-merge-proof.json').read_text())
gates=json.loads(Path('/private/tmp/fwp-pr123-final-gate-proof.json').read_text())
assert proof['verification']=='GitHub verified signed commit payload'
assert proof['parents']==['68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4']
assert proof['acceptedHead']=='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
assert len(gates['ci']['jobs'])==6 and len(gates['docs']['jobs'])==1
for gate in (gates['ci'],gates['docs']):
    assert gate['headSha']==proof['acceptedHead'] and gate['status']=='completed' and gate['conclusion']=='success'
    assert all(j['conclusion']=='success' and j['completedAt']<=proof['mergedAt'] for j in gate['jobs'])
assert api('/git/commits/'+proof['sha'])['tree']['sha']==proof['tree']
assert api('/git/commits/'+proof['acceptedHead'])['tree']['sha']==proof['tree']
run=api('/actions/runs/'+str(RUN));assert run['head_sha']==proof['sha']
jobs=api('/actions/runs/'+str(RUN)+'/jobs')['jobs']
assert len(jobs)==6 and {j['name'] for j in jobs}=={j['name'] for j in gates['ci']['jobs']}
assert run['status']=='queued' and all(j['status']=='queued' for j in jobs)
subprocess.run(['gh','run','cancel',str(RUN)],check=True)
Path('/private/tmp/fwp-main123-duplicate-ci-proof.json').write_text(json.dumps(dict(
    run=RUN,head=proof['sha'],testedHead=proof['acceptedHead'],tree=proof['tree'],
    acceptedGates=gates,stage='Duplicate same-tree full run cancellation requested; not a passing gate'),indent=2)+'\n')
print('Cancelled queued duplicate full CI; actual-main documentation audit retained',flush=True)
