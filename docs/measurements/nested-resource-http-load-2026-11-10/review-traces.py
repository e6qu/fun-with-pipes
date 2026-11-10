import argparse
import json
import math
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
report = json.loads((args.input / 'http-load/summary.json').read_text())
identity = json.loads((args.input / 'http-load/identity.json').read_text())
assert report['identity'] == identity
assert identity['source'] == (args.input / 'http-load-source.txt').read_text().strip() == 'cd661ff84b88736ceec83c75e0e2ecf7e6de551d'
assert identity['phase'] == 'measure' and identity['session'] in (1, 2)
assert identity['optimization'] == 'O2' and identity['serverCpu'] != identity['generatorCpu']
assert not report['failures']
levels = (1, 8, 32, 64) if identity['session'] == 1 else (64, 32, 8, 1)
expected = [(f'connections-{level}-run-{run}', level, 30) for level in levels for run in (1, 2)]
if identity['session'] == 1:
    expected.append(('soak', 32, 300))
assert len(report['trials']) == len(expected)
rows = []
for trial, (name, connections, duration) in zip(report['trials'], expected):
    assert (trial['name'], trial['connections'], trial['durationSeconds'], trial['warmupSeconds']) == (name, connections, duration, 5)
    assert trial['generatorStatus'] == trial['allFailures'] == trial['measuredFailures'] == trial['setupErrors'] == 0
    assert trial['failureFraction'] == 0
    assert trial['windowNs'] == duration * 10**9
    assert trial['completedPerSecond'] == trial['correctInWindow'] / duration
    assert trial['measuredAttempts'] == trial['correctInWindow'] + trial['correctLate']
    assert trial['totalAttempts'] == trial['warmupAttempts'] + trial['measuredAttempts'] == sum(w['attempts'] for w in trial['workers'])
    assert trial['successfulResponseLatency'] == trial['timeToResponseOrFailure']
    samples = [json.loads(line) for line in (args.input / 'http-load' / name / 'processes.jsonl').read_text().splitlines()]
    header = trial['header']
    start = header['epochUnixNs'] + header['warmupNs']
    finish = start + header['durationNs']
    for role in ('server', 'generator'):
        points = [(r['monotonicNs'], r[role]) for r in samples if start <= r['unixNs'] <= finish and r[role] is not None and 'error' not in r[role]]
        observed = trial['processSamples'][role]
        assert observed['samples'] == len(points) and observed['sufficientForTrend'] and len(points) >= duration - 2
        seconds = [(ns - points[0][0]) / 1e9 for ns, _ in points]
        memory = [p['rssBytes'] for _, p in points]
        mx, my = sum(seconds) / len(seconds), sum(memory) / len(memory)
        slope = sum((x - mx) * (y - my) for x, y in zip(seconds, memory)) / sum((x - mx)**2 for x in seconds)
        cpu = (points[-1][1]['cpuTicks'] - points[0][1]['cpuTicks']) / identity['clockTicksPerSecond']
        calculated = dict(firstRssBytes=memory[0], lastRssBytes=memory[-1], peakRssBytes=max(memory), rssSlopeBytesPerSecond=slope, sampledCpuSeconds=cpu, sampledElapsedSeconds=seconds[-1], sampledCpuFraction=cpu / seconds[-1])
        for key, value in calculated.items():
            assert math.isclose(value, observed[key], rel_tol=1e-12, abs_tol=1e-12), (name, role, key)
    rows.append(dict(name=name, connections=connections, seconds=duration, attempts=trial['totalAttempts'], responsesPerSecond=trial['completedPerSecond'], p99Ms=trial['successfulResponseLatency']['p99Ms'], server=trial['processSamples']['server'], generator=trial['processSamples']['generator']))
result = dict(identity=identity, trials=rows, attempts=sum(r['attempts'] for r in rows))
args.output.write_text(json.dumps(result, indent=2) + '\n')
print(identity['machine'], identity['session'], len(rows), 'trial summaries and complete process traces reconstruct;', result['attempts'], 'attempts reported without failures')
