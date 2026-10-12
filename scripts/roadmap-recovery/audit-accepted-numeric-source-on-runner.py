"""Audit actual merged numeric source and exact-head CI without rebuilding it."""
from pathlib import Path
import argparse,hashlib,json,os,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
p=argparse.ArgumentParser();p.add_argument('--expected',type=Path,required=True);p.add_argument('--proof',type=Path,required=True);a=p.parse_args()
expected=json.loads(a.expected.read_text());proof=json.loads(a.proof.read_text());out=Path('numeric-storage-acceptance');out.mkdir(exist_ok=True)
repo='repos/e6qu/fun-with-pipes'
def api(path):return json.loads(subprocess.check_output(['gh','api',repo+path]))
sha=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip();assert sha==proof['sha']==expected['accepted']
pr=api('/pulls/126');assert pr['merged'] and pr['merge_commit_sha']==sha and pr['head']['sha']==proof['acceptedHead']
accepted=api('/git/commits/'+sha);tested=api('/git/commits/'+pr['head']['sha']);assert accepted['tree']['sha']==tested['tree']['sha']==proof['tree']
assert [x['sha'] for x in accepted['parents']]==proof['parents']==['cbf68ea60c3b9439a117ef9d9b28b472f23dc632']
verification=accepted['verification'];assert verification['verified']
raw=verification['payload'].encode();headers,message=raw.split(b'\n\n',1);subject=message.decode().rstrip('\n');assert message in {subject.encode(),subject.encode()+b'\n'} and len(subject)<=80
assert subject in {'Pack numeric arrays and specialize worker ABI boundaries','Pack numeric arrays and specialize worker ABI boundaries (#126)'}
assert not any(x in subject.lower() for x in ['co-authored','authored by','authored-by','ai attribution'])
assert [x[7:].decode() for x in headers.splitlines() if x.startswith(b'parent ')]==proof['parents']
checks={}
required={'test','bench','macos (macos-15)','macos (macos-15-intel)','macos_gc (macos-15)','macos_gc (macos-15-intel)'}
for workflow,names in [('CI',required),('Roadmap documentation',{'roadmap_docs'})]:
 run=expected['gates'][workflow];r=api('/actions/runs/'+str(run));assert r['head_sha']==pr['head']['sha'] and r['status']=='completed' and r['conclusion']=='success'
 jobs=api('/actions/runs/'+str(run)+'/jobs')['jobs'];assert len(jobs)==len(names) and {j['name'] for j in jobs}==names
 assert all(j['status']=='completed' and j['conclusion']=='success' and j['completed_at']<=pr['merged_at'] for j in jobs)
 checks[workflow]=dict(run=run,jobs=[dict(name=j['name'],status=j['status'],conclusion=j['conclusion'],completedAt=j['completed_at']) for j in jobs])
actual={}
for name,digest in expected['files'].items():
 data=Path(name).read_bytes();assert hashlib.sha256(data).hexdigest()==digest,name;actual[name]=digest
# Check the whole source delta, including CI, rather than selected implementation files.
def tree_map(head):
 j=api('/git/trees/'+api('/git/commits/'+head)['tree']['sha']+'?recursive=1');assert not j['truncated']
 return {x['path']:(x['sha'],x['mode'],x['type']) for x in j['tree'] if x['type']!='tree'}
before=tree_map(proof['parents'][0]);after=tree_map(sha);assert set(before)<=set(after)
changed={name for name in after if after[name]!=before.get(name)};assert changed<=set(expected['files'])|set(expected['docs'])
env=dict(os.environ,FWP_INVENTORY_EXPECTED_HEAD=sha)
subprocess.run(['python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(out/'inventory.json')],env=env,check=True)
subprocess.run(['python3','scripts/check-explicit-fallback-review.py','--inventory',str(out/'inventory.json'),'--review','tests/fixtures/primitive-fallback-review.json','--output',str(out/'fallback-review.json')],check=True)
subprocess.run(['python3','scripts/check-roadmap.py'],check=True)
(out/'signed-payload.txt').write_bytes(raw)
report=dict(accepted=sha,tested=pr['head']['sha'],tree=accepted['tree']['sha'],mergedAt=pr['merged_at'],gates=checks,sourceHashes=actual,changedPaths=sorted(changed),signedPayloadSha256=hashlib.sha256(raw).hexdigest(),subject=subject,status='Actual merged-source phase3 accepted: full tested tree, signed squash and numeric storage sources verified',scope='Natural narrow storage, owner-retaining numeric views, typed worker boundaries and checked protocol/count paths. Existing F16/BF16/F128 formats and tracing compatibility fallbacks remain explicit. Full six-job CI is reused only after complete-tree parity; no skipped or repeated focused run substitutes for that gate.')
(out/'phase3-acceptance.json').write_text(json.dumps(report,indent=2)+'\n');print(report['status'],sha)
