#!/usr/bin/env python3
"""Verify complete evidence with synthetic observations and real built programs."""
import argparse
import base64
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil

SPEC = importlib.util.spec_from_file_location('buffer_check', Path(__file__).with_name('check-buffer-baselines.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
BASELINE = CHECK.BASELINE


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--programs', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    (out / 'SYNTHETIC-CONTROL.txt').write_text('Synthetic observations, never performance evidence.\n')
    shutil.copytree(args.programs, out / 'programs')
    programs = json.loads((out / 'programs/programs.json').read_text())
    source, machine = programs['source'], programs['machine']
    actual = dict(system='Linux', machine=machine, processors=4,
        cpu='Neoverse-N2' if machine == 'aarch64' else 'AMD EPYC 7763 64-Core Processor',
        cVersion=programs['versions']['cc'].splitlines()[0], rustVersion=programs['versions']['rustc'].strip())
    configuration = dict(source=source, origin='synthetic', waitPolicy='posix-alarm', directory=str(out), session=1, cpuPolicy='all', timeout=45,
        environment=dict(PATH='/usr/bin:/bin', LANG='C', LC_ALL='C', TZ='UTC'), affinity=[0, 1, 2, 3],
        qualification=dict(source=source, actual=actual, expected=actual, qualified=True, failures=[]),
        run='1', attempt='1', time='/usr/bin/time', timeVersion='GNU Time synthetic control',
        scope='Synthetic observations only; these are not benchmark results.')
    (out / 'configuration.json').write_text(json.dumps(configuration))
    summaries, memory, memory_rows = {}, [], []
    for entry in BASELINE.ENTRIES:
        for length, calls in BASELINE.CASES:
            rows = []
            expected = BASELINE.expected_output(entry, length, calls)
            common = dict(entry=entry, length=length, calls=calls, status=0, timedOut=False, interrupted=False, spawnError=None,
                elapsedNs=100, userNs=30, systemNs=20,
                stdoutBase64=base64.b64encode(expected).decode(), stderrBase64='',
                stdoutSha256=hashlib.sha256(expected).hexdigest(), stderrSha256=hashlib.sha256(b'').hexdigest())
            for warmup, rounds in [(True, BASELINE.WARMUPS), (False, BASELINE.ROUNDS)]:
                for index in range(rounds):
                    for position, label in enumerate(BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES, BASELINE.LABELS)):
                        binary = out / 'programs' / programs['entries'][entry][label]['binary']
                        rows.append(dict(common, label=label, warmup=warmup, round=index, position=position,
                                         command=[str(binary), entry, str(length), str(calls)]))
            name = f'{entry}-{length}'
            (out / (name + '.jsonl')).write_text(''.join(json.dumps(row) + '\n' for row in rows))
            summaries[name] = BASELINE.summarize_case(rows, entry, length, calls)
            for label in BASELINE.LABELS:
                name = f'{entry}-{length}-{label}.rss'
                binary = out / 'programs' / programs['entries'][entry][label]['binary']
                (out / name).write_text('1234\n')
                memory_rows.append(dict(common, label=label, file=name,
                    command=['/usr/bin/time', '-f', '%M', '-o', str(out / name), str(binary), entry, str(length), str(calls)]))
                memory.append(dict(entry=entry, length=length, label=label, maximumResidentKiB=1234))
    (out / 'memory.jsonl').write_text(''.join(json.dumps(row) + '\n' for row in memory_rows))
    report = dict(source=source, session=1, complete=True, cases=summaries, memory=memory,
                  decision='Descriptive baseline only; no optimization accepted.')
    (out / 'report.json').write_text(json.dumps(report))

    def manifest():
        values = {p.relative_to(out).as_posix(): dict(bytes=p.stat().st_size,
                  sha256=hashlib.sha256(p.read_bytes()).hexdigest())
                  for p in sorted(out.rglob('*')) if p.is_file() and p.name != 'manifest.json'}
        (out / 'manifest.json').write_text(json.dumps(values))

    manifest()
    CHECK.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
    rejections = 0
    # Recompute hashes after each change: checks must reject false evidence, not
    # merely notice that a checksum is stale. Restore each original immediately.
    damages = []
    wrong_wait = dict(configuration, waitPolicy='timed-polling')
    damages.append(('configuration.json', json.dumps(wrong_wait).encode()))
    changed_report = copy.deepcopy(report)
    changed_report['cases']['unique-0']['fwpPeerElapsedRatios']['c'] = 0.1
    damages.append(('report.json', json.dumps(changed_report).encode()))
    rows = (out / 'unique-0.jsonl').read_text().splitlines()
    damages.append(('unique-0.jsonl', ('\n'.join(rows[1:]) + '\n').encode()))
    bad_row = json.loads(rows[0]); bad_row['command'][0] = '/different/program'
    damages.append(('unique-0.jsonl', ('\n'.join([json.dumps(bad_row), *rows[1:]]) + '\n').encode()))
    bad_build = (out / 'programs/commands.jsonl').read_text().splitlines()
    damages.append(('programs/commands.jsonl', ('\n'.join(bad_build[1:]) + '\n').encode()))
    damages.append(('programs/commands.jsonl', (out / 'programs/commands.jsonl').read_bytes().replace(b'opt-level=2', b'opt-level=1')))
    altered_build = [json.loads(line) for line in bad_build]
    altered_build[9]['command'].pop()
    damages.append(('programs/commands.jsonl', ''.join(json.dumps(row) + '\n' for row in altered_build).encode()))
    damages.append(('unique-0-c.rss', b'-1\n'))
    damages.append(('memory.jsonl', ('\n'.join((out / 'memory.jsonl').read_text().splitlines()[1:]) + '\n').encode()))
    bad_config = copy.deepcopy(configuration); bad_config['qualification']['actual']['processors'] = 8
    damages.append(('configuration.json', json.dumps(bad_config).encode()))
    first = programs['entries']['unique']['c']['binary']
    damages.append(('programs/' + first, b'wrong executable'))
    for name, data in damages:
        path = out / name
        saved = path.read_bytes()
        path.chmod(0o644)
        path.write_bytes(data)
        manifest()
        try:
            CHECK.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
        except AssertionError:
            rejections += 1
        else:
            raise AssertionError(f'damaged evidence accepted: {name}')
        finally:
            path.write_bytes(saved)
    manifest()
    CHECK.check_evidence(out, source, machine, 1, 'synthetic', 'posix-alarm')
    try:
        CHECK.check_evidence(out, source, machine, 1, 'observed', 'posix-alarm')
    except AssertionError:
        rejections += 1
    else:
        raise AssertionError('synthetic observations accepted as measurements')
    print(f'Complete synthetic evidence and {rejections} rehashed damaged-evidence rejections pass')


if __name__ == '__main__':
    main()
