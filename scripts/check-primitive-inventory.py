#!/usr/bin/env python3
"""Recheck candidate contracts against the frozen prepared112 declaration review."""
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
baseline_bytes = args.baseline.read_bytes()
baseline_hash = hashlib.sha256(baseline_bytes).hexdigest()
assert baseline_hash == 'fa71949b3e93e8696b7c8bc7c35b729641c3ef156896803b679b05ccb4b62e0e'
baseline = json.loads(baseline_bytes)
assert baseline['head'] == '669c19e7cb6779536377af7f78651f97dc1e51d9'
mono = (root / 'src/mono.rs').read_text()
start = mono.index('fn combinator(symbol:')
end = mono.index('\nfn local_name(', start)
lowered = re.findall(r'^\s*"([^"\n]+)"\s*=>', mono[start:end], re.M)
assert len(lowered) == len(set(lowered)) == 19
assert 'Some((a, e)) => (a, Body::Expr(e))' in mono
assert 'None => (arity, Body::Prim(symbol.to_string()))' in mono
args.output.parent.mkdir(parents=True, exist_ok=True)

def recorded_command(label, command, environment=None):
    result = subprocess.run(command, cwd=root, env=environment, capture_output=True)
    prefix = args.output.parent / (args.output.stem + '.' + label)
    prefix.with_suffix(prefix.suffix + '.stdout').write_bytes(result.stdout)
    prefix.with_suffix(prefix.suffix + '.stderr').write_bytes(result.stderr)
    prefix.with_suffix(prefix.suffix + '.status').write_text(str(result.returncode) + '\n')
    if result.returncode:
        raise RuntimeError(f'{command}: exit {result.returncode}: '
                           + result.stderr.decode(errors='replace'))
    return result.stdout.decode()

with tempfile.TemporaryDirectory(prefix='fwp-primitive-inventory-') as temporary:
    executable = Path(temporary) / 'audit'
    recorded_command('compile', ['rustc', '--edition=2021', '-Awarnings',
                     str(root / 'scripts/primitive-inventory.rs'), '-o', str(executable)])
    output = recorded_command('declarations', [str(executable)],
                              dict(os.environ, FWP_AUDIT_LOWERED=','.join(lowered)))
fields = ['file', 'declared', 'symbol', 'aliased', 'bucket', 'contract', 'signature']
rows = [dict(zip(fields, line.split('\t', 6), strict=True)) for line in output.splitlines()]
for row in rows:
    assert row['aliased'] in {'true', 'false'}
    row['aliased'] = row['aliased'] == 'true'
counts = dict(Counter(row['bucket'] for row in rows))
head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip()
expected_head = os.environ.get('FWP_INVENTORY_EXPECTED_HEAD')
if expected_head:
    assert head == expected_head, ('Audit must inspect the declared candidate head', head, expected_head)
files = sorted((root / 'src').rglob('*.rs'))
files.extend(path for path in sorted((root / 'runtime').rglob('*'))
             if path.is_file() and path.suffix in {'.c', '.h', '.S'})
files.extend(sorted((root / 'lib').rglob('*.fwp')))
files.extend([Path(__file__).resolve(), root / 'scripts/primitive-inventory.rs'])
source_hashes = {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
                 for path in files}
observed = dict(head=head, baselineHead=baseline['head'], baselineSha256=baseline_hash,
                declarations=len(rows), distinctSymbols=len({row['symbol'] for row in rows}),
                explicitAliases=sum(row['aliased'] for row in rows), counts=counts,
                lowered=lowered, rows=rows, sourceHashes=source_hashes,
                status='Observed candidate; contract assertions have not passed')
args.output.with_suffix('.observed.json').write_text(json.dumps(observed, indent=2) + '\n')
assert len(rows) == len(baseline['rows']) + 1
assert len({(row['file'], row['declared']) for row in rows}) == len(rows)
assert len({row['symbol'] for row in rows}) == baseline['distinctSymbols'] + 1
assert sum(row['aliased'] for row in rows) == 40
raw_symbols = {'mem.alloc', 'mem.free', 'mem.string', 'ptr.cast', 'ptr.at',
               'ptr.read', 'ptr.write', 'ptr.read-string', 'ptr.address'}
baseline_rows = {(row['file'], row['declared']): row for row in baseline['rows']}
new_key = ('lib/autodiff.fwp', 'ad.scope')
assert set(baseline_rows) | {new_key} == {(row['file'], row['declared']) for row in rows}
changed_symbols = set()
for row in rows:
    key = (row['file'], row['declared'])
    if key == new_key:
        assert row == dict(file='lib/autodiff.fwp', declared='ad.scope', symbol='ad.scope',
            aliased=False, bucket='contract', signature='(() -> a) -> a',
            contract='Some(Contract { arguments: [Borrow], result: OwnedCallback, callback: Some(Borrowed(0)), aliases: [0] })')
        continue
    before = baseline_rows[key]
    if row['symbol'] in {'list.ap', 'list.flat-map'}:
        assert before['contract'] == 'None' and before['bucket'] == 'runtime_or_specialization_review'
        assert row['bucket'] == 'contract'
        assert all(row[name] == before[name] for name in fields if name not in {'bucket', 'contract'})
        callback = 'Some(Borrowed(0))' if row['symbol'] == 'list.flat-map' else 'None'
        assert row['contract'] == 'Some(Contract { arguments: [Borrow, Borrow], result: FreshSpine, callback: ' + callback + ', aliases: [0, 1] })'
        changed_symbols.add(row['symbol'])
        continue
    if row['symbol'] in {'ad.tape', 'ad.push', 'ad.backward'}:
        assert before['contract'] == 'None' and row['bucket'] == 'contract'
        assert all(row[name] == before[name] for name in fields if name not in {'bucket', 'contract'})
        arguments = '[Borrow, Borrow, Borrow]' if row['symbol'] == 'ad.backward' else '[Borrow]'
        result = 'FreshLeaf' if row['symbol'] == 'ad.backward' else 'Shared'
        expected = 'Some(Contract { arguments: ' + arguments + ', result: ' + result + ', callback: None, aliases: [] })'
        assert row['contract'] == expected
        changed_symbols.add(row['symbol'])
        continue
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
assert changed_symbols == raw_symbols | {'ad.tape', 'ad.push', 'ad.backward', 'list.ap', 'list.flat-map'}
expected_counts = dict(baseline['counts'])
expected_counts['contract'] += len(raw_symbols) + 6
expected_counts['runtime_or_specialization_review'] -= len(raw_symbols) + 4
expected_counts['flat_scalar_signature'] -= 1
assert counts == expected_counts, counts
review = [row for row in rows if row['bucket'] == 'runtime_or_specialization_review']
review_symbols = len({row['symbol'] for row in review})
assert review_symbols == baseline['reviewSymbols'] - len(raw_symbols) - 4
report = {
    'head': head,
    'declarations': len(rows), 'distinctSymbols': len({row['symbol'] for row in rows}), 'explicitAliases': 40,
    'counts': counts, 'reviewSymbols': review_symbols, 'lowered': lowered,
    'baselineHead': baseline['head'],
    'baselineSha256': baseline_hash,
    'changedContractSymbols': sorted(changed_symbols),
    'addedContractSymbols': ['ad.scope'],
    'sourceHashes': source_hashes,
    'rows': rows,
    'status': 'Expected contract changes verified',
    'limits': 'Source declaration review using actual runtime contracts. Flat scalar signatures do not prove absence of external allocation/state. Remaining declarations require monomorphic wrapper, retention and teardown review, not an assumed number of sharing bugs. Single-line declarations and literal unescaped aliases are asserted for this source snapshot.',
}
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: report[key] for key in ['head', 'declarations', 'distinctSymbols',
                                            'explicitAliases', 'counts', 'reviewSymbols']}, indent=2))
