"""Restore a bounded source export from verified recovery text; run no compiler."""
from pathlib import Path
import base64,hashlib,json
out=Path('/private/tmp/fwp-numeric-storage-finalization-export')
proof=json.loads((out/'download.json').read_text());text=(out/'production-files.json.gz.base64').read_bytes();assert len(text)<4*1024*1024
raw=base64.b64decode(text,validate=True);assert len(raw)<3*1024*1024
assert hashlib.sha256(raw).hexdigest()==proof['hashes']['production-files.json.gz']
p=out/'production-files.json.gz'
if p.exists():assert p.read_bytes()==raw
else:p.write_bytes(raw)
print('Restored verified source archive; no helper or compiler executed')
