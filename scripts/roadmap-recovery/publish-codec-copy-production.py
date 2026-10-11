"""Publish the codec fixture repair only after both path controls pass."""
from pathlib import Path
import json,subprocess
HEAD='647d45ca45a76f46aaa22d0901d7fd3ea7949220'
r=json.loads(subprocess.check_output(['gh','run','view','38184029472','--repo','e6qu/fun-with-pipes','--json','headSha,status,conclusion,jobs'],text=True))
assert r['headSha']==HEAD and r['status']=='completed' and r['conclusion']=='success'
assert len(r['jobs'])==3 and {j['name'] for j in r['jobs']}=={'codecs ('+p+')' for p in ['ubuntu-latest','macos-15','macos-15-intel']}
assert all(j['status']=='completed' and j['conclusion']=='success' for j in r['jobs'])
for j in r['jobs']:
 assert {s['name'] for s in j['steps'] if s['conclusion']=='success'} >= {'Format and verify focused contracts','Verify explicit artifact directory'}
Path('/private/tmp/fwp-codec-copy-passing-proof.json').write_text(json.dumps(r,indent=2)+'\n')
subprocess.run(['python3','/private/tmp/fwp-publish-evidence-update.py','--branch','ownership-resource-network-bundle','--old','d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0','--subject','Preserve codec fixtures while copying test artifacts','--receipt','/private/tmp/fwp-codec-copy-production-publication.json','--file','tests/serializer_leaf_ownership.rs=/private/tmp/fwp-codec-artifact-copy-test.rs'],check=True)
