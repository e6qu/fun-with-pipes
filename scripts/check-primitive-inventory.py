#!/usr/bin/env python3
"""Reproduce the finite declaration review without treating missing metadata as bugs."""
import argparse
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

root = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
mono = (root / 'src/mono.rs').read_text()
start = mono.index('fn combinator(symbol:')
end = mono.index('\nfn local_name(', start)
lowered = re.findall(r'^\s*"([^"\n]+)"\s*=>', mono[start:end], re.M)
assert len(lowered) == len(set(lowered)) == 19
assert 'Some((a, e)) => (a, Body::Expr(e))' in mono
assert 'None => (arity, Body::Prim(symbol.to_string()))' in mono
with tempfile.TemporaryDirectory(prefix='fwp-primitive-inventory-') as temporary:
    executable = Path(temporary) / 'audit'
    subprocess.run(['rustc', '--edition=2021', '-Awarnings',
                    str(root / 'scripts/primitive-inventory.rs'), '-o', str(executable)],
                   cwd=root, check=True)
    output = subprocess.check_output([str(executable)], cwd=root, text=True,
                                     env=dict(os.environ, FWP_AUDIT_LOWERED=','.join(lowered)))
fields = ['file', 'declared', 'symbol', 'aliased', 'bucket', 'contract', 'signature']
rows = [dict(zip(fields, line.split('\t', 6), strict=True)) for line in output.splitlines()]
for row in rows:
    assert row['aliased'] in {'true', 'false'}
    row['aliased'] = row['aliased'] == 'true'
counts = dict(Counter(row['bucket'] for row in rows))
assert len(rows) == 373
assert len({(row['file'], row['declared']) for row in rows}) == len(rows)
assert len({row['symbol'] for row in rows}) == 363
assert sum(row['aliased'] for row in rows) == 40
assert counts == {'contract': 134, 'ir_template': 19, 'flat_scalar_signature': 12,
                  'runtime_or_specialization_review': 208}
review = [row for row in rows if row['bucket'] == 'runtime_or_specialization_review']
assert len({row['symbol'] for row in review}) == 198
files = [root / name for name in ['src/ownership.rs', 'src/mono.rs', 'src/cgen.rs', 'src/rc.rs', 'src/parser.rs']]
files.extend(sorted((root / 'lib').rglob('*.fwp')))
report = {
    'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
    'declarations': len(rows), 'distinctSymbols': 363, 'explicitAliases': 40,
    'counts': counts, 'reviewSymbols': 198, 'lowered': lowered,
    'sourceHashes': {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
                     for path in files},
    'rows': rows,
    'limits': 'Source declaration review using actual runtime contracts. Flat scalar signatures do not prove absence of external allocation/state. Remaining declarations require monomorphic wrapper, retention and teardown review, not an assumed number of sharing bugs. Single-line declarations and literal unescaped aliases are asserted for this source snapshot.',
}
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: report[key] for key in ['head', 'declarations', 'distinctSymbols',
                                            'explicitAliases', 'counts', 'reviewSymbols']}, indent=2))
