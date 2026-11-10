"""Reconstruct static holder counts from both complete compiler stderr reports."""
import gzip
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SOURCE = '9b24e6965dd4c7cfb6e88163a34722e0b99ec901'
summary = json.loads((ROOT / 'summary.json').read_text())
for arch in ('arm', 'amd'):
    report = json.loads(gzip.decompress((ROOT / f'{arch}-report.json.gz').read_bytes()))
    assert report['source'] == SOURCE and report['kind'] == 'plain-fields'
    assert not report['failures'] and len(report['cases']) == 17
    rebuilt = {}
    for name, case in report['cases'].items():
        ordinary, observed = case['commands']['ordinary'], case['commands']['observed']
        assert ordinary['status'] == observed['status'] == 0
        assert not ordinary['stdout'] and not ordinary['stderr'] and not observed['stdout']
        rows = []
        for line in observed['stderr'].splitlines():
            assert line.startswith('FWP_RESOURCE_FIELDS ')
            rows.append(json.loads(line.removeprefix('FWP_RESOURCE_FIELDS ')))
        assert rows == case['observations']
        assert len({row['context'] for row in rows}) == len(rows)
        totals = dict(frames=len(rows), fields=sum(len(row['fields']) for row in rows),
                      plainFields=sum(field['observable'] is False for row in rows for field in row['fields']),
                      variants=sum(row['variants'] for row in rows))
        assert totals == case['totals']
        rebuilt[name] = dict(totals=totals, cSha256=case['cSha256'])
    assert rebuilt == summary
print('Both hosts: all 17 raw classifications/totals and recorded C hashes agree')
