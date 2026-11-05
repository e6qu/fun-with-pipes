#!/usr/bin/env python3
"""Check exact scalar reads in complete programs while preserving prior storage."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('pair_selection', Path(__file__).with_name('check-packed-pair-selection.py'))
PAIR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PAIR)
SYMBOLS = ('One[F64].one', 'prim.one')


def check(emitted, representation):
    assert representation in ('literal', 'cached'), representation
    storage = PAIR.check(emitted)
    bodies, reached = PAIR.STORAGE.reachable_bodies(emitted)
    # Scalar cache entries occupy one generated line. Follow their aliases too;
    # the storage inspector deliberately focuses on multiline numeric workers.
    for match in re.finditer(r'^static V (caf\d+)\(void\) \{ ([^\n]*) \}$', emitted, re.M):
        bodies[match[1]] = match[2]
    pending = list(reached)
    while pending:
        name = pending.pop()
        calls = set(re.findall(r'\b([A-Za-z_]\w*)\(', bodies[name]))
        new = (calls & bodies.keys()) - reached
        reached.update(new)
        pending.extend(new)
    entries = {}
    for symbol in SYMBOLS:
        pattern = r'/\* ' + re.escape(symbol) + r' : F64 \*/\nstatic V f(\d+)\(void\)'
        matches = re.findall(pattern, emitted)
        if representation == 'literal':
            assert not matches, ('scalar still has a live cache definition', symbol, matches)
        else:
            assert len(matches) == 1, ('missing scalar reference entry', symbol, matches)
            cache = 'caf' + matches[0]
            assert cache in reached, ('scalar reference cache is unreachable', cache)
            assert 'static int st' in bodies[cache], ('reference lost lazy initialization', cache)
            entries[symbol] = cache
    if representation == 'literal':
        assert any('0x3ff0000000000000ULL' in bodies[name] for name in reached), 'no live exact F64 one bits'
    return dict(representation=representation, preservedStorage=storage, cachedEntries=entries)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--representation', choices=('literal', 'cached'), required=True)
    args = parser.parse_args()
    manifest_path = args.input / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    for name, expected in manifest['files'].items():
        assert hashlib.sha256((args.input / name).read_bytes()).hexdigest() == expected, name
    observed = {}
    for name in ('descent-small', 'descent-large', 'current-large'):
        source = (args.input / (name + '-optimized.c')).read_text()
        observed[name] = check(source, args.representation)
        changed = (source + '\n/* One[F64].one : F64 */\nstatic V f999999(void) {}\n'
                   if args.representation == 'literal' else source.replace('/* One[F64].one : F64 */', '/* removed constant entry */'))
        try:
            check(changed, args.representation)
        except AssertionError:
            pass
        else:
            raise AssertionError(('wrong constant selection accepted', name))
    output = args.input / 'scalar-constant-selection.json'
    output.write_text(json.dumps(observed, indent=2) + '\n')
    manifest['files'][output.name] = hashlib.sha256(output.read_bytes()).hexdigest()
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('Exact scalar selection checked in three complete programs; wrong-selection controls rejected')


if __name__ == '__main__':
    main()
