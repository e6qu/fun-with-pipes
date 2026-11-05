#!/usr/bin/env python3
"""Require a live consuming pair helper and its proved-private reuse path."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('storage', Path(__file__).with_name('inspect-iteration-storage.py'))
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)

MARKERS = (
    '/* Consume private overlapping windows;',
    'fwp_value_owner input = {l0, fwp_rc_free_arr};',
    'fwp_value_protect(&input, &input_cleanup);',
    'V buffer = l0;',
    '#ifdef FWP_NO_REUSE',
    '#ifndef FWP_NO_REUSE',
    'return fwp_value_finish(&input, &input_cleanup);',
    'ARR(buffer)->len = count * 2;',
    'fwp_value_release(&input);',
    '(void)fwp_value_finish(&input, &input_cleanup);',
)


def check(emitted):
    bodies, reached = STORAGE.reachable_bodies(emitted)
    selected = {name: bodies[name] for name in reached if MARKERS[0] in bodies[name]}
    assert len(selected) == 1, ('live private pair helper', list(selected))
    name, body = next(iter(selected.items()))
    for marker in MARKERS:
        assert body.count(marker) == 1, marker
    assert 'fwp_rc_unique' not in body, 'private proof must not become a runtime uniqueness query'
    assert body.index('fwp_value_protect(&input') < body.index('fwp_arr_new(')
    assert 'input.value = 0;' not in body, 'reuse must keep its original protected owner'
    allocation = body.split('#ifdef FWP_NO_REUSE\n', 1)[1].split('#endif', 1)[0]
    assert 'fwp_value_protect(&owner, &cleanup);' in allocation
    assert body.count('fwp_value_protect(&owner, &cleanup);') == 1
    assert body.index('#endif') < body.index('for (size_t i = 0;')
    assert body.index('ARR(buffer)->len =') < body.index('return fwp_value_finish(&input')
    assert re.search(r'ARR\(l0\)->d\[\(i \+ 0\) \* 2', body)
    assert re.search(r'ARR\(l0\)->d\[\(i \+ 1\) \* 2', body)
    assert body.index(' mapped = w') < body.index('ARR(buffer)->d[')
    assert body.index('ARR(buffer)->d[') < body.index('ARR(buffer)->len =')
    return dict(helper=name, consumesInput=True, staticPrivateReuse=True, inputWidth=2, resultWidth=2)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    args = parser.parse_args()
    manifest_path = args.input / 'manifest.json'
    manifest = json.loads(manifest_path.read_text())
    for name, expected in manifest['files'].items():
        assert hashlib.sha256((args.input / name).read_bytes()).hexdigest() == expected, name
    observed = {}
    for name in ('descent-small', 'descent-large', 'current-large'):
        source = (args.input / (name + '-optimized.c')).read_text()
        observed[name] = check(source)
        for marker in MARKERS:
            try:
                check(source.replace(marker, 'deliberately missing selection'))
            except AssertionError:
                continue
            raise AssertionError(('missing selection accepted', name, marker))
    output = args.input / 'packed-pair-selection.json'
    output.write_text(json.dumps(observed, indent=2) + '\n')
    manifest['files'][output.name] = hashlib.sha256(output.read_bytes()).hexdigest()
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('Private pair reuse selected in three complete programs; every missing-marker control rejected')


if __name__ == '__main__':
    main()
