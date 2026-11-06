"""Compare saved AMD64 compiler copies by round, position and CPU observations."""
import gzip
import hashlib
import json
from pathlib import Path
import statistics
import zipfile

ROOT = Path(__file__).resolve().parent
report = json.loads(gzip.decompress((ROOT / 'x86_64-report.json.gz').read_bytes()))
case = report['cases']['derivative-3-0']
observations = []
with zipfile.ZipFile(ROOT / 'x86_64-records.zip') as records:
    for index, sample in enumerate(case['samples']):
        name = f"numeric-analysis/derivative-3-0/{sample['round']}-{sample['copy']}.resources.txt"
        raw = records.read(name)
        fields = dict(line.strip().split(': ', 1) for line in raw.decode().splitlines() if ': ' in line)
        observations.append(dict(
            copy=sample['copy'], round=sample['round'], position=index % 4,
            seconds=sample['seconds'], peakKiB=sample['peakCommandKiB'],
            cpuSeconds=float(fields['User time (seconds)']) + float(fields['System time (seconds)']),
            voluntarySwitches=int(fields['Voluntary context switches']),
            involuntarySwitches=int(fields['Involuntary context switches']),
            minorFaults=int(fields['Minor (reclaiming a frame) page faults']),
            majorFaults=int(fields['Major (requiring I/O) page faults']),
            fileSystemOutputs=int(fields['File system outputs']),
            resourceSha256=hashlib.sha256(raw).hexdigest()))
summary = {}
for copy in ('candidate1', 'reference1', 'reference2', 'candidate2'):
    rows = [row for row in observations if row['copy'] == copy and row['round'] >= 0]
    assert len(rows) == 10
    summary[copy] = dict(
        positions=sorted({row['position'] for row in rows}),
        medians={key: statistics.median(row[key] for row in rows) for key in (
            'seconds', 'cpuSeconds', 'voluntarySwitches', 'involuntarySwitches', 'minorFaults', 'majorFaults', 'fileSystemOutputs')},
        firstHalfMedianSeconds=statistics.median(row['seconds'] for row in rows if row['round'] < 5),
        lastHalfMedianSeconds=statistics.median(row['seconds'] for row in rows if row['round'] >= 5))
    assert summary[copy]['medians']['seconds'] == case['summary']['copyMediansSeconds'][copy]
result = dict(source=report['source'], compilerHashes=report['compilerHashes'],
              generatedCHashes=case['generatedCHashes'], frozenSummary=case['summary'],
              copies=summary, observations=observations,
              limitation='Each copy occupies only two positions. Copy identity and position are confounded. GNU time CPU values have 0.01-second resolution; these observations establish no scheduling or compiler root cause.')
(ROOT / 'sample-review.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(dict(generatedCHashes=result['generatedCHashes'], copies=summary), indent=2))
