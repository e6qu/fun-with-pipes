"""Summarize the original AMD64 session-2 copy control without new timings."""
import argparse
from collections import Counter
import gzip
import hashlib
import json
from pathlib import Path
import statistics

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--report', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
raw = gzip.decompress(args.report.read_bytes())
report = json.loads(raw)
assert report['source'] == '51edfc0e7884e1a75201bc9876fd13cb8ca25eee'
assert report['machine'] == 'x86_64'
case = report['results']['3-1999']
labels = ('fwp-ad', 'fwp-ad-identical')
assert case['binaries'][labels[0]]['sha256'] == case['binaries'][labels[1]]['sha256']
assert len(case['orders']) == 98
copies = {}
for label in labels:
    samples = case['samplesNs'][label]
    assert len(samples) == 98 and all(value > 0 for value in samples)
    positions = Counter(position for order in case['orders'] for position, program in enumerate(order) if program == label)
    assert len(positions) == 49 and set(positions.values()) == {14}
    copies[label] = dict(medianNs=statistics.median(samples),
                        first49MedianNs=statistics.median(samples[:49]),
                        last49MedianNs=statistics.median(samples[49:]),
                        minNs=min(samples), maxNs=max(samples),
                        positionCounts=dict(sorted(positions.items())))
ratios = {field: copies[labels[0]][field] / copies[labels[1]][field]
          for field in ('medianNs', 'first49MedianNs', 'last49MedianNs')}
ratio = ratios['medianNs']
assert max(ratio, 1 / ratio) > 1.02
result = dict(source=report['source'], reportSha256=hashlib.sha256(raw).hexdigest(),
              executableSha256=case['binaries'][labels[0]]['sha256'],
              samplesPerCopy=98, processesPerSample=case['processesPerLabel'],
              copies=copies, candidateIdenticalRatios=ratios,
              conclusion='Copy control fails; balanced positions and split samples establish no cause')
args.output.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(ratios))
