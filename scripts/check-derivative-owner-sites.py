#!/usr/bin/env python3
"""Locate remaining derivative owners in the retained packed-record baseline."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import re
import zipfile

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--counts', type=Path, required=True)
parser.add_argument('--arm64-archive', type=Path, required=True)
parser.add_argument('--amd64-archive', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
summary = json.loads(gzip.decompress(args.counts.read_bytes()))
assert summary['source'] == args.source
rows = []
sources = []
for arch, path in [('aarch64', args.arm64_archive), ('x86_64', args.amd64_archive)]:
    host = summary['hosts'][arch]
    assert hashlib.sha256(path.read_bytes()).hexdigest() == host['archiveSha256']
    with zipfile.ZipFile(path) as archive:
        for case, evidence in host['cases'].items():
            dimensions, updates, form, optimization = case.split('-')
            dimensions, updates = int(dimensions), int(updates)
            name = case + '/ownership-base.c'
            raw = archive.read(name)
            assert hashlib.sha256(raw).hexdigest() == host['files'][name]
            source = raw.decode()
            maps = re.findall(r'/\* Eager packed numeric records:[\s\S]*?fwp_args(\d+)\(arguments, 0, 2\);', source)
            assert len(maps) == 1, (arch, case, maps)
            callback = 'fwp_args' + maps[0]
            workers = re.findall(r'/\* fn : \(Rev\[F64\], Rev\[F64\]\) -> Rev\[F64\] \*/\nstatic fwp_wr(\d+) w\1\(V l0_0, V l0_1\) \{([\s\S]*?)\n}', source)
            selected = []
            for number, body in workers:
                pattern = r'    (l\d+) = l0_0;\n    fwp_rc_dup\(\1\);\n    l\d+ = \1;\n    /\* move owned field \*/ l\d+ = l0_1;\n    fwp_drop\d+\(l0_0\);'
                match = re.search(pattern, body)
                if match:
                    selected.append(('w' + number, 'fwp_rc_dup(' + match[1] + ');'))
            assert len(selected) == 1, (arch, case, selected)
            projection, statement = selected[0]
            sites = {}
            for site in evidence['sites']['ownership']:
                if site['operation'] != 'dup':
                    continue
                if site['caller'] == callback:
                    role = 'mapperInputs'
                elif site['caller'] == projection and site['source'] == statement:
                    role = 'separatedFieldTransfer'
                else:
                    continue
                assert source.splitlines()[site['line'] - 1].strip() == site['source']
                sites[site['id']] = dict(role=role, **site)
            sources.append(dict(architecture=arch, case=case, sha256=hashlib.sha256(raw).hexdigest(),
                                callback=callback, projection=projection, sites=list(sites.values())))
            for workspace, observation in evidence['observations'].items():
                counts = dict(mapperInputs=0, separatedFieldTransfer=0)
                for row in observation['ownership']:
                    if row['site'] in sites:
                        assert row['phase'] == 'forwardWithRecording'
                        assert row['calls'] == row['effective'] and row['last'] == 0
                        counts[sites[row['site']]['role']] += row['effective']
                pairs = (dimensions - 1) * updates
                assert counts == dict(mapperInputs=2*pairs, separatedFieldTransfer=pairs), (arch, case, workspace, counts)
                rows.append(dict(architecture=arch, case=case, workspace=workspace,
                                 retains=observation['totals']['managed']['retains'], counts=counts))
assert len(rows) == 96 and len(sources) == 48
args.output.write_text(json.dumps(dict(
    source=summary['source'], run=summary['run'],
    scope='Source-attributed remaining ARC sites; no optimization or speed claim.',
    sources=sources, observations=rows), indent=2) + '\n')
print('All 48 saved sources and 96 observations match 2*p mapper-input and p separated-field retains')
