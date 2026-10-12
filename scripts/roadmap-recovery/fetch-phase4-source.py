"""Read bounded immutable sources needed for the next numeric bundle."""
from pathlib import Path
import base64,hashlib,json,subprocess
BASE='cbf68ea60c3b9439a117ef9d9b28b472f23dc632';OUT=Path('/private/tmp/fwp-phase4-source');assert not OUT.exists();OUT.mkdir()
names=['src/fuse.rs','src/opt.rs','src/ownership.rs','src/driver.rs','src/ir.rs','lib/numeric.fwp','lib/autodiff.fwp','tests/fusion.rs','tests/protocol.rs']
manifest={}
for name in names:
 result=subprocess.run(['gh','api','repos/e6qu/fun-with-pipes/contents/'+name+'?ref='+BASE],capture_output=True)
 if result.returncode:
  assert name=='tests/fusion.rs' and b'404' in result.stderr;continue
 j=json.loads(result.stdout);data=base64.b64decode(j['content']);assert len(data)<512*1024
 assert j['sha']==hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
 p=OUT/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data);manifest[name]=dict(blob=j['sha'],sha256=hashlib.sha256(data).hexdigest())
(OUT/'manifest.json').write_text(json.dumps(dict(base=BASE,status='Independent phase4 source investigation; phase3 production gate remains required',files=manifest),indent=2)+'\n');print('Retained bounded phase4 source for independent preparation')
