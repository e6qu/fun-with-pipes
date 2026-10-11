#!/usr/bin/env python3
"""Recheck merged contracts against the frozen prepared112 declaration review."""
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
parser.add_argument('--baseline', type=Path, required=True)
args = parser.parse_args()
baseline = json.loads(args.baseline.read_text())
assert baseline['head'] == '669c19e7cb6779536377af7f78651f97dc1e51d9'
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
raw_symbols = {'mem.alloc', 'mem.free', 'mem.string', 'ptr.cast', 'ptr.at',
               'ptr.read', 'ptr.write', 'ptr.read-string', 'ptr.address'}
baseline_rows = {(row['file'], row['declared']): row for row in baseline['rows']}
assert set(baseline_rows) == {(row['file'], row['declared']) for row in rows}
changed_symbols = set()
for row in rows:
    before = baseline_rows[(row['file'], row['declared'])]
    if row['symbol'] not in raw_symbols:
        assert row == before, (before, row)
        continue
    assert row['file'] == 'lib/ffi.fwp' and not row['aliased']
    assert before['bucket'] == 'runtime_or_specialization_review'
    assert before['contract'] == 'None' and row['bucket'] == 'contract'
    assert all(row[key] == before[key] for key in fields
               if key not in {'bucket', 'contract'})
    arguments = '[Borrow, Borrow]' if row['symbol'] in {'ptr.at', 'ptr.write'} else '[Borrow]'
    result = 'FreshLeaf' if row['symbol'] == 'ptr.read-string' else 'Shared'
    expected = ('Contract { arguments: ' + arguments + ', result: ' + result +
                ', callback: None, aliases: [] }')
    assert row['contract'] == 'Some(' + expected + ')', row
    changed_symbols.add(row['symbol'])
assert changed_symbols == raw_symbols
expected_counts = dict(baseline['counts'])
expected_counts['contract'] += len(raw_symbols)
expected_counts['runtime_or_specialization_review'] -= len(raw_symbols)
assert counts == expected_counts, counts
review = [row for row in rows if row['bucket'] == 'runtime_or_specialization_review']
review_symbols = len({row['symbol'] for row in review})
assert review_symbols == baseline['reviewSymbols'] - len(raw_symbols)
files = [root / name for name in ['src/ownership.rs', 'src/mono.rs', 'src/cgen.rs', 'src/rc.rs', 'src/parser.rs']]
files.extend(sorted((root / 'lib').rglob('*.fwp')))
report = {
    'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip(),
    'declarations': len(rows), 'distinctSymbols': 363, 'explicitAliases': 40,
    'counts': counts, 'reviewSymbols': review_symbols, 'lowered': lowered,
    'baselineHead': baseline['head'],
    'changedContractSymbols': sorted(changed_symbols),
    'sourceHashes': {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
                     for path in files},
    'rows': rows,
    'limits': 'Source declaration review using actual runtime contracts. Flat scalar signatures do not prove absence of external allocation/state. Remaining declarations require monomorphic wrapper, retention and teardown review, not an assumed number of sharing bugs. Single-line declarations and literal unescaped aliases are asserted for this source snapshot.',
}
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: report[key] for key in ['head', 'declarations', 'distinctSymbols',
                                            'explicitAliases', 'counts', 'reviewSymbols']}, indent=2))
