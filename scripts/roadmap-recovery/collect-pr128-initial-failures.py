from pathlib import Path
import hashlib,json,re,subprocess
repo='repos/e6qu/fun-with-pipes';run=38244684931;head='82d552c48663c28d05543313fa91e05b8c327b14'
out=Path('/private/tmp/fwp-pr128-initial-ci-failures.json');assert not out.exists()
def api(p):return json.loads(subprocess.check_output(['gh','api',repo+p]))
r=api('/actions/runs/'+str(run));assert r['head_sha']==head and r['status']=='completed' and r['conclusion']=='failure'
jobs=api('/actions/runs/'+str(run)+'/jobs')['jobs'];assert len(jobs)==6 and all(j['status']=='completed' for j in jobs)
failed=[]
for j in jobs:
 if j['conclusion']=='success':continue
 raw=subprocess.check_output(['gh','api',repo+'/actions/jobs/'+str(j['id'])+'/logs','--allow-escape-sequences']);assert len(raw)<8*1024*1024
 p=Path('/private/tmp/fwp-pr128-failed-job-'+str(j['id'])+'.log');p.write_bytes(raw)
 text=re.sub(r'\x1b\[[0-?]*[ -/]*[@-~]','',raw.decode())
 targets=sorted(set(re.findall(r'error: test failed, to rerun pass [^\n]*--test ([a-z_0-9]+)',text)))
 tests=sorted(set(re.findall(r'test ([^\n]+?) \.\.\. FAILED',text)))
 failed.append(dict(job=j,log=str(p),sha256=hashlib.sha256(raw).hexdigest(),targets=targets,tests=tests))
 print(j['name'],j['conclusion'],targets,tests)
out.write_text(json.dumps(dict(head=head,run=run,jobs=jobs,failures=failed),indent=2)+'\n')
