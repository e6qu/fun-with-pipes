"""Summarize all native memory observations and verify one retained raw snapshot."""
import argparse
import hashlib
import json
from pathlib import Path
import re

from nested_resource_memory import categories, fast_counters
from parser_process_memory import mappings, summary

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--identity', choices=('prefix', 'complete'), required=True)
args = parser.parse_args()
root = args.input
if args.identity == 'prefix':
    prefix = (root / 'nested-memory/report.json.prefix').read_text()
    identity = json.loads(prefix.split('  "controls":')[0].rstrip().rstrip(',') + '\n}')
else:
    identity = json.loads((root / 'nested-memory/identity.json').read_text())
rows = json.loads((root / 'memory-audit.json').read_text())
controls = json.loads((root / 'memory-audit-controls.json').read_text())
assert controls == {'rejected': ['rss-summary', 'fast-counter', 'binary-hash']}
assert identity['binarySource'] == 'd80357c8c81d206c9d9934b141b5a5fafe97c430'
assert set(rows) == {f'{n}-{m}' for n in (64, 4096) for m in range(4)}
flat = [row for part in rows.values() for row in part]
assert len(flat) == 128
for part in rows.values():
    assert len(part) == 16
    assert {(r['label'], r['round']) for r in part} == {
        (label, i) for label in ('reference', 'reference-copy', 'candidate', 'candidate-copy') for i in range(4)}
    assert all(2 <= r['snapshots'] <= 600 for r in part)
folder = root / 'nested-memory/64-0/0-reference'
observation = json.loads((folder / 'observation.json').read_text())
snapshot = observation['snapshots'][0]
raw = {}
for name, file in snapshot['files'].items():
    data = (folder / file['file']).read_bytes()
    assert hashlib.sha256(data).hexdigest() == file['sha256']
    raw[name] = data.decode()
assert re.search(r'^State:\s+T\b', raw['status'], re.M)
parsed = mappings(raw['smaps'])
assert summary(parsed) == snapshot['metrics']
assert categories(parsed, Path(observation['command'][0])) == snapshot['categories']
assert fast_counters(raw['status'], raw['statm'], identity['pageBytes']) == snapshot['fast']
result = dict(identity=identity, cases={}, totalSnapshots=sum(r['snapshots'] for r in flat),
              fastMinusWalkRangeKiB=[min(r['minimumFastMinusWalkKiB'] for r in flat),
                                    max(r['maximumFastMinusWalkKiB'] for r in flat)],
              wholeChildWait4RangeKiB=[min(r['wait4PeakRssKiB'] for r in flat), max(r['wait4PeakRssKiB'] for r in flat)],
              scope='Summaries audited on runners; local review verifies schedule, summaries and one raw snapshot. Page snapshots are not exact transient peaks. Whole-child wait4 includes pre-exec memory.')
for key, part in rows.items():
    case = result['cases'][key] = {}
    for role in ('reference', 'candidate'):
        selected = [r for r in part if r['label'] in (role, role+'-copy')]
        case[role] = {field: [min(r[field] for r in selected), max(r[field] for r in selected)]
                      for field in ('observedResidentPeakKiB', 'observedAnonymousPeakKiB')}
        case[role]['categoryResidentPeaksKiB'] = {
            name: [min(r['categoryResidentPeaksKiB'][name] for r in selected),
                   max(r['categoryResidentPeaksKiB'][name] for r in selected)]
            for name in ('heap', 'stack', 'executable', 'otherFiles', 'otherMappings')}
args.output.write_text(json.dumps(result, indent=2) + '\n')
print(identity['architecture'], len(flat), 'executions;', result['totalSnapshots'], 'snapshots; fast minus walk', result['fastMinusWalkRangeKiB'])
for key, case in result['cases'].items():
    print(key, *(case[role]['observedResidentPeakKiB'] for role in ('reference', 'candidate')))
