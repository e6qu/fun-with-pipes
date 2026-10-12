"""Verify temporary restoration on a disposable runner without helper execution."""
from pathlib import Path
import ast,hashlib,json,os,re,subprocess
assert os.environ.get('GITHUB_ACTIONS')=='true'
HEAD=os.environ['GITHUB_SHA'];assert re.fullmatch(r'[0-9a-f]{40}',HEAD)
ROOT=Path.cwd();OUT=ROOT/'recovery-restoration-evidence';OUT.mkdir(exist_ok=True)
source=ROOT/'scripts/roadmap-recovery/restore-roadmap-recovery.py'
module=ast.parse(source.read_text());external=[n for n in ast.walk(module) if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute) and isinstance(n.func.value,ast.Name) and n.func.value.id=='subprocess']
assert len(external)==2 and {call.func.attr for call in external}=={'check_output','Popen'}
for call in external:
 command=call.args[0];assert isinstance(command,ast.List)
 assert [ast.literal_eval(v) for v in command.elts[:2]]==['gh','api']
# This directory belongs only to this fresh GitHub runner, never a local checkout.
subprocess.run(['sudo','install','-d','-m','1777','/private/tmp'],check=True)
r=subprocess.run(['python3',str(source),'--head',HEAD],capture_output=True)
(OUT/'restore.stdout').write_bytes(r.stdout);(OUT/'restore.stderr').write_bytes(r.stderr);(OUT/'restore.status').write_text(str(r.returncode)+'\n')
assert r.returncode==0,r.stderr.decode(errors='replace')
record_path=Path('/private/tmp/fwp-recovery-restoration.json');raw=record_path.read_bytes();record=json.loads(raw)
assert record['head']==HEAD and len(record['restored'])>40
assert record['tree']==subprocess.check_output(['git','rev-parse','HEAD^{tree}'],text=True).strip()
assert record['stage']=='Verified published source restored; no helper executed or compiler run'
count=0;total=0
for name,item in record['restored'].items():
 path=Path(name);assert path.resolve().is_relative_to(Path('/private/tmp').resolve())
 # The restorer emits fresh evidence after restoring the old evidence file.
 if path==record_path:continue
 data=path.read_bytes();assert hashlib.sha256(data).hexdigest()==item['sha256'],name
 count+=1;total+=len(data)
assert total<64*1024*1024
(OUT/'recovery-restoration.json').write_bytes(raw)
(OUT/'validation.json').write_text(json.dumps(dict(head=HEAD,tree=record['tree'],verifiedTargets=count,bytes=total,status='Temporary recovery restoration and source hashes verified; helpers and compiler were not executed',restorationSha256=hashlib.sha256(raw).hexdigest()),indent=2)+'\n')
print('Verified temporary recovery restoration:',count,'targets,',total,'bytes at',HEAD)
