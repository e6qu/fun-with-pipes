#!/usr/bin/env python3
"""Check current ownership contracts against the frozen declaration baseline."""
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
assert len(rows) == len(baseline['rows']) + 5
assert len({(row['file'], row['declared']) for row in rows}) == len(rows)
assert len({row['symbol'] for row in rows}) == baseline['distinctSymbols'] + 5
assert sum(row['aliased'] for row in rows) == 40
raw_symbols = {'mem.alloc', 'mem.free', 'mem.string', 'ptr.cast', 'ptr.at',
               'ptr.read', 'ptr.write', 'ptr.read-string', 'ptr.address'}
baseline_rows = {(row['file'], row['declared']): row for row in baseline['rows']}
scope_keys = {('lib/autodiff.fwp', 'ad.scope'), ('lib/autodiff.fwp', 'ad.scope2')}
owned_tapes = {
    'ad.tape-owned': (2, 'Shared', '(t, t -> t -> t, t -> t -> t, t -> Bool) -> List[t] -> I64 where Dup[t]'),
    'ad.push-owned': (1, 'Shared', '(I64, t, I64, t) -> I64 where Dup[t]'),
    'ad.backward-owned': (3, 'OwnedTree', 'I64 -> List[I64] -> List[t] -> List[t] where Dup[t]'),
}
new_keys = scope_keys | {('lib/autodiff.fwp', name) for name in owned_tapes}
leaf_symbols = {'json.encode', 'json.write', 'url.encode', 'int.to-hex', 'cli.help', 'zlib.gzip', 'zlib.gzip-chunk', 'zlib.deflate', 'ws.accept', 'ws.deflate', 'ws.key', 'zlib.gzip-end', 'ws.close-payload', 'ws.frame'}
assert set(baseline_rows) | new_keys == {(row['file'], row['declared']) for row in rows}
# These reviewed contract changes are checked against the frozen baseline.
bundle_contracts = {}
bundle_contracts['not'] = (1, 'Shared', [])
for symbol in ['and', 'or']:
    bundle_contracts[symbol] = (2, 'Shared', [])
bundle_contracts['prim.trap'] = (1, 'Never', [])
for symbol in ['prim.zero', 'prim.one']:
    bundle_contracts[symbol] = (0, 'Numeric', [])
for symbol in ['prim.neg', 'prim.from-int', 'prim.from-float', 'bit.not', 'int.convert', 'float.to-int',
               'float.convert', 'int.to-float', 'sqrt', 'exp', 'ln', 'sin', 'cos', 'tan', 'floor', 'ceil', 'round']:
    bundle_contracts[symbol] = (1, 'Numeric', [])
bundle_contracts['abs'] = (1, 'Numeric', [0])
for symbol in ['prim.add', 'prim.sub', 'prim.mul', 'prim.div', 'prim.rem',
               'wrapping.add', 'wrapping.sub', 'wrapping.mul',
               'saturating.add', 'saturating.sub', 'saturating.mul',
               'overflowing.add', 'overflowing.sub', 'overflowing.mul',
               'checked.add', 'checked.sub', 'checked.mul', 'checked.div',
               'bit.and', 'bit.or', 'bit.xor', 'bit.shl', 'bit.shr', 'pow']:
    bundle_contracts[symbol] = (2, 'Numeric', [])
bundle_contracts['min'] = bundle_contracts['max'] = (2, 'SelectedArgument', [0, 1])
bundle_contracts['csv.parse-with'] = (2, 'OwnedTree', [])
bundle_contracts['cli.parse'] = (2, 'OwnedTree', [])
for symbol in ['lines', 'read-line', 'read-lines', 'read-all', 'args', 'env.get', 'env.vars', 'dir.list']:
    bundle_contracts[symbol] = (1, 'OwnedTree', [])
for symbol in ['dir.create-all', 'dir.create', 'dir.remove', 'file.remove', 'file.exists', 'file.is-dir']:
    bundle_contracts[symbol] = (1, 'Shared', [])
for symbol in ['file.rename', 'file.append', 'file.write-bytes']:
    bundle_contracts[symbol] = (2, 'Shared', [])
bundle_contracts['file.read-bytes'] = (1, 'FreshLeaf', [])
bundle_contracts['env.cwd'] = (1, 'FreshLeaf', [])
for symbol in ['time.monotonic', 'time.unix']:
    bundle_contracts[symbol] = (1, 'FreshLeaf', [])
bundle_contracts['file.info'] = (1, 'OwnedTree', [])
bundle_contracts['process.run-input'] = (2, 'OwnedTree', [])
bundle_contracts['process.call'] = (1, 'Shared', [])
bundle_contracts['term.read-secret'] = (1, 'OwnedTree', [])
bundle_contracts['list.transpose'] = (1, 'CopiedStructure', [0])
for symbol, arity in [('linalg.lu-solve', 3), ('linalg.inverse', 2),
                      ('linalg.cholesky', 2), ('linalg.qr', 3), ('linalg.cg', 5)]:
    bundle_contracts[symbol] = (arity, 'OwnedTree', [])
bundle_contracts['linalg.det'] = (2, 'Numeric', [])
for symbol in ['csv.decode', 'json.parse', 'json.read']:
    bundle_contracts[symbol] = (1, 'OwnedTree', [])
promoted = []
changed_symbols = set()
for row in rows:
    key = (row['file'], row['declared'])
    if row['symbol'] in owned_tapes:
        arity, result, signature = owned_tapes[row['symbol']]
        arguments = '[' + ', '.join(['Borrow'] * arity) + ']'
        assert row == dict(file='lib/autodiff.fwp', declared=row['symbol'], symbol=row['symbol'],
            aliased=False, bucket='contract', signature=signature,
            contract='Some(Contract { arguments: ' + arguments + ', result: ' + result + ', callback: None, aliases: [] })')
        continue
    if key in scope_keys:
        name = key[1]
        arity = 2 if name == 'ad.scope' else 3
        signature = '(a -> b) -> a -> b where Dup[a]' if arity == 2 else '(a -> b -> c) -> a -> b -> c where Dup[a], Dup[b]'
        arguments = '[Borrow, Borrow]' if arity == 2 else '[Borrow, Borrow, Borrow]'
        aliases = '[0, 1]' if arity == 2 else '[0, 1, 2]'
        assert row == dict(file='lib/autodiff.fwp', declared=name, symbol=name,
            aliased=False, bucket='contract', signature=signature,
            contract='Some(Contract { arguments: ' + arguments + ', result: OwnedCallback, callback: Some(Borrowed(0)), aliases: ' + aliases + ' })')
        continue
    before = baseline_rows[key]
    if row['symbol'] in {'map.empty', 'set.empty'}:
        assert before['contract'] == 'Some(Contract { arguments: [], result: Shared, callback: None, aliases: [] })'
        assert all(row[name] == before[name] for name in fields if name != 'contract')
        assert row['contract'] == 'Some(Contract { arguments: [], result: Static, callback: None, aliases: [] })'
        changed_symbols.add(row['symbol'])
        continue
    if row['symbol'] in {'fail', 'parse-int', 'parse-float'}:
        assert before['contract'] == 'Some(Contract { arguments: [Borrow], result: Shared, callback: None, aliases: [] })'
        assert all(row[name] == before[name] for name in fields if name != 'contract')
        result = 'Never' if row['symbol'] == 'fail' else 'FreshTree'
        assert row['contract'] == 'Some(Contract { arguments: [Borrow], result: ' + result + ', callback: None, aliases: [] })'
        changed_symbols.add(row['symbol'])
        continue
    if row['symbol'] in bundle_contracts:
        expected_before = ('Some(Contract { arguments: [Borrow], result: FreshTree, callback: None, aliases: [] })'
                           if row['symbol'] == 'lines' else 'None')
        assert before['contract'] == expected_before and row['bucket'] == 'contract', (before, row)
        changed_fields = {'bucket', 'contract'}
        if row['symbol'] == 'env.cwd':
            # An unavailable directory is an explicit error, not a substitute path.
            assert before['signature'] == '() -> String ! {IO}'
            assert row['signature'] == '() -> String ! {IO, Error[IoError]}'
            changed_fields.add('signature')
        assert all(row[name] == before[name] for name in fields if name not in changed_fields)
        arity, result, aliases = bundle_contracts[row['symbol']]
        arguments = '[' + ', '.join(['Borrow'] * arity) + ']'
        expected = f'Some(Contract {{ arguments: {arguments}, result: {result}, callback: None, aliases: {aliases} }})'
        assert row['contract'] == expected, (row, expected)
        promoted.append(before)
        changed_symbols.add(row['symbol'])
        continue
    if row['symbol'] in leaf_symbols:
        assert before['contract'] == 'None' and before['bucket'] == 'runtime_or_specialization_review'
        assert row['bucket'] == 'contract'
        assert all(row[name] == before[name] for name in fields if name not in {'bucket', 'contract'})
        arity = 3 if row['symbol'] == 'ws.frame' else 2 if row['symbol'] in {'zlib.gzip-end', 'ws.close-payload'} else 1
        arguments = '[' + ', '.join(['Borrow'] * arity) + ']'
        assert row['contract'] == 'Some(Contract { arguments: ' + arguments + ', result: FreshLeaf, callback: None, aliases: [] })'
        changed_symbols.add(row['symbol'])
        continue
    if row['symbol'] in {'get', 'put', 'modify', 'run-state'}:
        assert before['contract'] == 'None' and before['bucket'] == 'runtime_or_specialization_review'
        assert row['bucket'] == 'contract'
        assert all(row[name] == before[name] for name in fields if name not in {'bucket', 'contract'})
        arguments = '[Borrow, Borrow, Borrow]' if row['symbol'] == 'run-state' else '[Borrow]'
        callback = 'Some(Borrowed(1))' if row['symbol'] == 'run-state' else 'Some(Borrowed(0))' if row['symbol'] == 'modify' else 'None'
        aliases = '[0, 1, 2]' if row['symbol'] == 'run-state' else '[]'
        assert row['contract'] == 'Some(Contract { arguments: ' + arguments + ', result: OwnedState, callback: ' + callback + ', aliases: ' + aliases + ' })'
        changed_symbols.add(row['symbol'])
        continue
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
    result = ('FreshLeaf' if row['symbol'] == 'ptr.read-string' else
              'Numeric' if row['symbol'] == 'ptr.read' else 'Shared')
    expected = ('Contract { arguments: ' + arguments + ', result: ' + result +
                ', callback: None, aliases: [] }')
    assert row['contract'] == 'Some(' + expected + ')', row
    changed_symbols.add(row['symbol'])
assert changed_symbols == raw_symbols | leaf_symbols | set(bundle_contracts) | {'map.empty', 'set.empty', 'ad.tape', 'ad.push', 'ad.backward', 'list.ap', 'list.flat-map', 'get', 'put', 'modify', 'run-state', 'fail', 'parse-int', 'parse-float'}
expected_counts = dict(baseline['counts'])
expected_counts['contract'] += len(raw_symbols) + 25 + len(owned_tapes)
expected_counts['runtime_or_specialization_review'] -= len(raw_symbols) + 22
expected_counts['flat_scalar_signature'] -= 1
for before in promoted:
    expected_counts[before['bucket']] -= 1
    expected_counts['contract'] += 1
assert counts == expected_counts, counts
review = [row for row in rows if row['bucket'] == 'runtime_or_specialization_review']
review_symbols = len({row['symbol'] for row in review})
assert review_symbols == baseline['reviewSymbols'] - len(raw_symbols) - 22 - len({x['symbol'] for x in promoted if x['bucket'] == 'runtime_or_specialization_review'})
report = {
    'head': head,
    'declarations': len(rows), 'distinctSymbols': len({row['symbol'] for row in rows}), 'explicitAliases': 40,
    'counts': counts, 'reviewSymbols': review_symbols, 'lowered': lowered,
    'baselineHead': baseline['head'],
    'baselineSha256': baseline_hash,
    'changedContractSymbols': sorted(changed_symbols),
    'addedContractSymbols': sorted(name for _, name in new_keys),
    'sourceHashes': source_hashes,
    'rows': rows,
    'status': 'Expected contract changes verified',
    'limits': 'Source declaration review using actual runtime contracts. Flat scalar signatures do not prove absence of external allocation/state. Remaining declarations require monomorphic wrapper, retention and teardown review, not an assumed number of sharing bugs. Single-line declarations and literal unescaped aliases are asserted for this source snapshot.',
}
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: report[key] for key in ['head', 'declarations', 'distinctSymbols',
                                            'explicitAliases', 'counts', 'reviewSymbols']}, indent=2))
