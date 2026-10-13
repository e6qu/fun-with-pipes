#!/usr/bin/env python3
"""Validate the finite fallback review against an exact candidate inventory."""
import argparse,hashlib,json,subprocess
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--inventory',type=Path,required=True)
p.add_argument('--review',type=Path,required=True)
p.add_argument('--output',type=Path,required=True)
a=p.parse_args();root=Path.cwd()
r=json.loads(a.inventory.read_text());review=json.loads(a.review.read_text())
head=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip()
assert r['head']==head, 'Inventory must describe the exact source being reviewed'
rows=[x for x in r['rows'] if x['bucket']=='runtime_or_specialization_review']
key=lambda x:(x['file'],x['declared'])
actual={key(x):x for x in rows};prepared={key(x):x for x in review['rows']}
assert len(actual)==len(rows) and len(prepared)==len(review['rows'])
assert actual.keys()==prepared.keys(), 'New or missing declaration needs explicit review'
assert len(rows)==review['declarations']==141
assert len({x['symbol'] for x in rows})==review['symbols']==131
for k,x in actual.items():
 y=prepared[k]
 assert x['contract']=='None'
 assert y['classification']=='shared_fallback'
 assert all(x[field]==y[field] for field in ['file','declared','symbol','signature'])
 assert y['policy'] in review['policies']
 assert all(y[field] for field in ['arguments','result','callback'])
 policy=review['policies'][y['policy']]
 assert set(policy)=={'retention','teardown','eligibility'} and all(policy.values())
 assert 'tracing' in policy['eligibility']
# These shared compiler rules are intentionally conservative and type-directed.
rc=(root/'src/rc.rs').read_text();cgen=(root/'src/cgen.rs').read_text();ownership=(root/'src/ownership.rs').read_text()
assert '''pub fn prim_reads_only(sym: &str, j: usize) -> bool {
    crate::ownership::primitive(sym)
        .is_some_and(|c| c.argument(j) != crate::ownership::Argument::Share)
}''' in rc
assert '''if crate::rc::needs_rc(&self.prog.shapes, &f.locals[i as usize])
                    && !crate::rc::prim_reads_only(sym, i as usize)''' in cgen
assert 'fwp_rc_share(l{});' in cgen
assert '.unwrap_or(Argument::Share)' in ownership
assert 'None => (arity, Body::Prim(symbol.to_string()))' in (root/'src/mono.rs').read_text()
assert review['cyclePolicy'] and 'require tracing' in review['cyclePolicy']
for name,digest in r['sourceHashes'].items():
 assert hashlib.sha256((root/name).read_bytes()).hexdigest()==digest,name
record=dict(head=head,status='Explicit shared fallback coverage verified; no tracing-free claim',declarations=len(rows),symbols=review['symbols'],rows=review['rows'],policies=review['policies'],cyclePolicy=review['cyclePolicy'],inventorySha256=hashlib.sha256(a.inventory.read_bytes()).hexdigest(),reviewSha256=hashlib.sha256(a.review.read_bytes()).hexdigest(),sourceHashes=r['sourceHashes'])
a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(record,indent=2)+'\n')
print(f'Verified {len(rows)} fallback declarations at {head}; tracing remains required')
