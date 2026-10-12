from pathlib import Path
import base64,hashlib,json,subprocess
head='3a4582368f987ddb0233086be50c47995eb4ed3f';out=Path('/private/tmp/fwp-matrix-pass-source');out.mkdir(exist_ok=True);manifest={}
for name in ['src/mono.rs','src/ownership.rs','src/aot.rs']:
 r=json.loads(subprocess.check_output(['gh','api','repos/e6qu/fun-with-pipes/contents/'+name+'?ref='+head]));b=base64.b64decode(r['content']);assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==r['sha'];p=out/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);manifest[name]=dict(blob=r['sha'],sha256=hashlib.sha256(b).hexdigest())
(out/'manifest.json').write_text(json.dumps(dict(head=head,files=manifest),indent=2)+'\n')
print('Retained actual accepted matrix pass integration sources')
