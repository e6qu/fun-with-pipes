"""Use the foreign function signature to infer the fixture's numeric type."""
from pathlib import Path
import base64,hashlib,json,subprocess
REPO='repos/e6qu/fun-with-pipes';OLD='a27f8e5f78ab12e397119b76049aa6eefbf88157'
BRANCH='ownership-evidence-gc-build-diagnostics';RUN=38151169253
SUBJECT='Use inferred types in foreign compiler failure controls'
def api(endpoint,payload=None,method='POST'):
    args=['gh','api',REPO+endpoint]
    if payload is not None:
        path=Path('/private/tmp/fwp-foreign-compiler-fixture-input.json');path.write_text(json.dumps(payload))
        args+=['--method',method,'--input',str(path)]
    return json.loads(subprocess.check_output(args,text=True))
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
gate=api('/actions/runs/'+str(RUN));assert gate['head_sha']==OLD
assert gate['status']=='completed' and gate['conclusion']=='failure'
name='tests/compiler_diagnostics.rs';draft=Path('/private/tmp/fwp-compiler-diagnostics-test.rs').read_text()
content=api('/contents/'+name+'?ref='+OLD);prior=base64.b64decode(content['content']).decode()
assert prior.count('main = -7:I32')==1
assert prior.replace('main = -7:I32','main = -7')==draft
log=Path('/private/tmp/fwp-gc-a27-failed.log').read_bytes()
assert b'expected end of declaration, found `:`' in log
parent=api('/git/commits/'+OLD)
tree=api('/git/trees',dict(base_tree=parent['tree']['sha'],tree=[dict(path=name,mode='100644',type='blob',content=draft)]))
assert len(SUBJECT)<=80 and '\n' not in SUBJECT
commit=api('/git/commits',dict(message=SUBJECT,tree=tree['sha'],parents=[OLD]))
assert commit['message']==SUBJECT and commit['parents'][0]['sha']==OLD
staged=api('/contents/'+name+'?ref='+commit['sha']);assert base64.b64decode(staged['content']).decode()==draft
assert api('/git/ref/heads/'+BRANCH)['object']['sha']==OLD
ref=api('/git/refs/heads/'+BRANCH,dict(sha=commit['sha'],force=False),method='PATCH')
assert ref['object']['sha']==commit['sha']
Path('/private/tmp/fwp-foreign-compiler-fixture-publication.json').write_text(json.dumps(dict(
    head=commit['sha'],previous=OLD,branch=BRANCH,failedRun=RUN,
    sourceHashes={name:hashlib.sha256(draft.encode()).hexdigest()},failedLogHash=hashlib.sha256(log).hexdigest(),
    stage='Foreign fixture corrected; compiler/cache/runtime source unchanged; replacement checks pending'),indent=2)+'\n')
print(commit['sha'],flush=True)
