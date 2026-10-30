#!/usr/bin/env python3
"""Exercise paired scan evidence with synthetic timings and real native programs."""
import argparse
import base64
from collections import Counter
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil

SPEC = importlib.util.spec_from_file_location('scan_comparison', Path(__file__).with_name('scan-comparison.py'))
SCAN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCAN)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['reference', 'candidate', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    for family, path in [('old', args.reference), ('new', args.candidate)]:
        shutil.copytree(path, out / family)
    programs = json.loads((out / 'new/programs.json').read_text())
    source, machine = programs['source'], programs['machine']
    actual = dict(system='Linux', machine=machine, processors=4,
        cpu='Neoverse-N2' if machine == 'aarch64' else 'AMD EPYC 7763 64-Core Processor',
        cVersion=programs['versions']['cc'].splitlines()[0], rustVersion=programs['versions']['rustc'].strip())
    config = dict(source=source, reference=SCAN.REFERENCE, session=1, origin='synthetic', waitPolicy='posix-alarm', directory=str(out),
        environment=SCAN.ENVIRONMENT, timeout=45, cpuPolicy='all', affinity=[0, 1, 2, 3], labels=list(SCAN.LABELS),
        length=4096, calls=256, rounds=36, warmups=2, processes=12, seed=20261030, run='1', attempt='1',
        qualification=dict(source=source, actual=actual, expected=actual, qualified=True, failures=[]))
    (out / 'configuration.json').write_text(json.dumps(config))
    (out / 'SYNTHETIC.txt').write_text('Synthetic timings; not performance evidence.\n')
    for label in SCAN.LABELS:
        family = label[:3]
        metadata = json.loads((out / family / 'programs.json').read_text())['entries']['scan']['fwp']
        shutil.copyfile(out / family / metadata['binary'], out / (label + '.exe'))
    output = SCAN.BASELINE.expected_output('scan', 4096, 256)
    rows = []
    orders = [SCAN.BASELINE.execution_order(index, 20261030, 12, SCAN.LABELS) for index in range(36)]
    assert all(Counter(order) == dict.fromkeys(SCAN.LABELS, 12) for order in orders)
    assert all(Counter(order[position] for order in orders) == dict.fromkeys(SCAN.LABELS, 6) for position in range(72))
    assert Counter(pair for order in orders for pair in zip(order, order[1:])) == {(a, b): 71 for a in SCAN.LABELS for b in SCAN.LABELS}
    for warmup, count in [(True, 2), (False, 36)]:
        for index in range(count):
            for position, label in enumerate(orders[index]):
                duration = 100 if label.startswith('old') else 80
                rows.append(dict(command=[str(out / (label + '.exe')), 'scan', '4096', '256'],
                    entry='scan', length=4096, calls=256, warmup=warmup, round=index, position=position, label=label,
                    status=0, timedOut=False, interrupted=False, spawnError=None, elapsedNs=duration * (100 if warmup else 1),
                    userNs=30, systemNs=20, stdoutBase64=base64.b64encode(output).decode(), stderrBase64='',
                    stdoutSha256=hashlib.sha256(output).hexdigest(), stderrSha256=hashlib.sha256(b'').hexdigest()))
    raw = ''.join(json.dumps(row) + '\n' for row in rows).encode()
    (out / 'observations.jsonl').write_bytes(raw)
    report = dict(source=source, reference=SCAN.REFERENCE, session=1, origin='synthetic', timing=SCAN.summarize(rows),
        code=SCAN.code_budget(SCAN.check_inputs(out, source, machine, config['qualification'])),
        decision='Timing/code evidence only; semantic and storage gates are required separately.')
    assert report['timing']['candidateReferenceRatio'] == 0.8 and report['timing']['copyRatios'] == dict(old=1, new=1)
    assert report['timing']['familyMedianRoundElapsedNs'] == dict(old=3600, new=2880)
    (out / 'report.json').write_text(json.dumps(report))
    SCAN.manifest(out)
    SCAN.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
    # A bad identical-copy control or a slower candidate remains visible, not
    # discarded. Neither may turn into a passing numerical result.
    for mode in ['unstable', 'slow']:
        changed = copy.deepcopy(rows)
        for row in changed:
            selected = row['label'] == 'new2' if mode == 'unstable' else row['label'].startswith('new')
            if selected:
                row['elapsedNs'] *= 2
        summary = SCAN.summarize(changed)
        assert not summary['copyControlPassed'] if mode == 'unstable' else not summary['elapsedPassed']
    wrong_wait = dict(config, waitPolicy='timed-polling')
    damages = [('configuration.json', json.dumps(wrong_wait).encode())]
    wrong_report = copy.deepcopy(report)
    wrong_report['timing']['candidateReferenceRatio'] = 0.1
    damages.append(('report.json', json.dumps(wrong_report).encode()))
    lines = raw.splitlines(keepends=True)
    damages.extend([('observations.jsonl', b''.join(lines[1:])),
                    ('observations.jsonl', b''.join([lines[1], lines[0], *lines[2:]]))])
    for key, value in [('command', ['/wrong/program']), ('status', 1), ('timedOut', True), ('interrupted', True),
                       ('spawnError', 'cannot start'), ('stdoutBase64', 'MAo='), ('elapsedNs', 0), ('warmup', 1)]:
        row = dict(rows[0]); row[key] = value
        damages.append(('observations.jsonl', json.dumps(row).encode() + b'\n' + b''.join(lines[1:])))
    build = (out / 'new/commands.jsonl').read_bytes()
    damages.append(('new/commands.jsonl', build.replace(b'-O2', b'-O1')))
    damages.append(('new0.exe', b'not the candidate'))
    wrong_config = copy.deepcopy(config); wrong_config['qualification']['actual']['processors'] = 8
    damages.append(('configuration.json', json.dumps(wrong_config).encode()))
    for name, damaged in damages:
        path = out / name
        original = path.read_bytes()
        path.write_bytes(damaged)
        SCAN.manifest(out)
        try:
            SCAN.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
        except (AssertionError, KeyError, ValueError):
            pass
        else:
            raise AssertionError('accepted deliberately damaged ' + name)
        finally:
            path.write_bytes(original)
    SCAN.manifest(out)
    try:
        SCAN.check_evidence(out, source, machine, 1, 'observed', 'posix-alarm')
    except AssertionError:
        pass
    else:
        raise AssertionError('synthetic evidence accepted as observed')
    SCAN.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
    print(f'Paired scan: balanced schedule, slow/unstable results and {len(damages) + 1} damaged-evidence rejections pass')


if __name__ == '__main__':
    main()
