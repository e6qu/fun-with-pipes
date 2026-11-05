#!/usr/bin/env python3
"""Require all four storage reductions in the saved complete gradient programs."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('storage', Path(__file__).with_name('inspect-iteration-storage.py'))
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)


def check(emitted):
    bodies, reached = STORAGE.reachable_bodies(emitted)
    live = {name: bodies[name] for name in reached}
    scopes = {name: body for name, body in live.items() if '/* Direct AD scope;' in body}
    assert len(scopes) == 1, ('direct scope selection', list(scopes))
    scope, = scopes.values()
    worker, = re.findall(r'V result = (w\d+)\(', scope)
    assert worker in live and '/* caller-owned parameters: 1 */' in live[worker], 'gradient input must borrow'
    folds = [name for name, body in live.items() if 'seed and result are numeric fields.' in body]
    assert len(folds) == 1, ('numeric fold fields', folds)
    scratch = [name for name, body in live.items() if 'reuse exclusive 64-bit array scratch.' in body]
    assert len(scratch) == 1, ('consumed coordinate scratch', scratch)
    roots = [name for name, body in live.items() if 'fwp_p_ad_backward_one(l0, l1, l2)' in body]
    assert len(roots) == 1, ('single-root backward', roots)
    assert not any('fwp_p_ad_backward(l0, l1, l2)' in body for body in live.values())
    assert '/* Zero[Rev[t]].zero : Rev[F64] */' not in emitted, 'cached numeric seed box remains'
    return dict(scope=list(scopes), borrowedWorker=worker, fold=folds, scratch=scratch, backward=roots)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    args = parser.parse_args()
    manifest_path = args.input / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    for name, expected in manifest['files'].items():
        assert hashlib.sha256((args.input / name).read_bytes()).hexdigest() == expected, name
    observed = {}
    for name in ('descent-small', 'descent-large', 'current-large'):
        source = (args.input / (name + '-optimized.c')).read_text()
        observed[name] = check(source)
        for marker in ('/* Direct AD scope;', '/* caller-owned parameters: 1 */',
                       'seed and result are numeric fields.', 'reuse exclusive 64-bit array scratch.',
                       'fwp_p_ad_backward_one(l0, l1, l2)'):
            try:
                check(source.replace(marker, 'deliberately removed selection'))
            except AssertionError:
                continue
            raise AssertionError(('selection control was not rejected', name, marker))
    (args.input / 'gradient-call-selection.json').write_text(json.dumps(observed, indent=2) + '\n')
    output = args.input / 'gradient-call-selection.json'
    manifest['files'][output.name] = hashlib.sha256(output.read_bytes()).hexdigest()
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('All four storage reductions selected in all three complete programs; missing-selection controls rejected')


if __name__ == '__main__':
    main()
