#!/usr/bin/env python3
"""Collect the declared ordinary-buffer baseline; retain every attempted process."""
import argparse
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import shutil
import signal
import subprocess
import time

from process_wait import WAIT_POLICY, communicate

SPEC = importlib.util.spec_from_file_location('buffer_baselines', Path(__file__).with_name('unique-buffer-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)


def measure_process(command, environment, timeout):
    """One serial child: no other children may be reaped during the CPU interval."""
    command = list(map(str, command))
    status, timed_out, interrupted, spawn_error = None, False, False, None
    stdout, stderr = b'', b''
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    started = time.perf_counter_ns()
    try:
        child = subprocess.Popen(command, env=environment, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE, start_new_session=True)
    except OSError as error:
        spawn_error = str(error)
    else:
        try:
            stdout, stderr = communicate(child, timeout, None)
        except (subprocess.TimeoutExpired, KeyboardInterrupt) as error:
            timed_out = isinstance(error, subprocess.TimeoutExpired)
            interrupted = isinstance(error, KeyboardInterrupt)
            try:
                if child.returncode is None:
                    os.killpg(child.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass  # Child exited after the deadline and before the kill.
            stdout, stderr = child.communicate()
        except BaseException:
            try:
                if child.returncode is None:
                    os.killpg(child.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            child.communicate()
            raise
        status = child.returncode
    elapsed = time.perf_counter_ns() - started
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    return dict(command=command, status=status, timedOut=timed_out, interrupted=interrupted, spawnError=spawn_error,
                elapsedNs=elapsed, userNs=round((after.ru_utime - before.ru_utime) * 1e9),
                systemNs=round((after.ru_stime - before.ru_stime) * 1e9),
                stdoutBase64=base64.b64encode(stdout).decode(), stderrBase64=base64.b64encode(stderr).decode(),
                stdoutSha256=hashlib.sha256(stdout).hexdigest(), stderrSha256=hashlib.sha256(stderr).hexdigest())


def cancel(signum, frame):
    raise KeyboardInterrupt


def main():
    signal.signal(signal.SIGTERM, cancel)
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['programs', 'qualification', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--time', required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    parser.add_argument('--cpu-policy', choices=['all'], required=True)
    parser.add_argument('--timeout', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.timeout == 45
    source = os.environ['GITHUB_SHA']
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == source
    qualification = json.loads(args.qualification.read_text())
    BASELINE.check_host(qualification, source, platform.machine())
    assert len(os.sched_getaffinity(0)) == qualification['actual']['processors']
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    shutil.copytree(args.programs, out / 'programs')
    programs = BASELINE.check_programs(out / 'programs', source, platform.machine())
    environment = dict(PATH='/usr/bin:/bin', LANG='C', LC_ALL='C', TZ='UTC')
    configuration = dict(source=source, origin='observed', waitPolicy=WAIT_POLICY, directory=str(out), session=args.session, cpuPolicy=args.cpu_policy,
        timeout=args.timeout, environment=environment, affinity=sorted(os.sched_getaffinity(0)),
        qualification=qualification, run=os.environ['GITHUB_RUN_ID'], attempt=os.environ['GITHUB_RUN_ATTEMPT'],
        time=args.time, timeVersion=subprocess.check_output([args.time, '--version'], text=True),
        platform=platform.platform(), python=platform.python_version(),
        timingScope='Serial whole child including spawn, startup, checked work, output and cleanup; excludes artifact writes.',
        memoryScope='Separate GNU time maximum resident KiB; not per-stage live payload or allocator bookkeeping.')
    (out / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    summaries = {}
    for entry in BASELINE.ENTRIES:
        for length, calls in BASELINE.CASES:
            name = f'{entry}-{length}'
            rows = []
            with (out / (name + '.jsonl')).open('x', buffering=1) as log:
                for warmup, rounds in [(True, BASELINE.WARMUPS), (False, BASELINE.ROUNDS)]:
                    for index in range(rounds):
                        for position, label in enumerate(BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES, BASELINE.LABELS)):
                            binary = out / 'programs' / programs['entries'][entry][label]['binary']
                            row = measure_process([binary, entry, length, calls], environment, args.timeout)
                            row.update(entry=entry, length=length, calls=calls, warmup=warmup,
                                       round=index, position=position, label=label)
                            log.write(json.dumps(row) + '\n')
                            rows.append(row)
                            BASELINE.check_result(row, entry, length, calls)
                summaries[name] = BASELINE.summarize_case(rows, entry, length, calls)
            print(f'Collected {name}: {len(rows)} retained child observations', flush=True)
    memory = []
    with (out / 'memory.jsonl').open('x', buffering=1) as log:
        for entry in BASELINE.ENTRIES:
            for length, calls in BASELINE.CASES:
                for label in BASELINE.LABELS:
                    path = out / f'{entry}-{length}-{label}.rss'
                    binary = out / 'programs' / programs['entries'][entry][label]['binary']
                    row = measure_process([args.time, '-f', '%M', '-o', path, binary, entry, length, calls],
                                          environment, args.timeout)
                    row.update(entry=entry, length=length, calls=calls, label=label, file=path.name)
                    log.write(json.dumps(row) + '\n')
                    BASELINE.check_result(row, entry, length, calls)
                    raw = path.read_text()
                    assert raw.endswith('\n') and raw[:-1].isdecimal() and int(raw) >= 0, raw
                    memory.append(dict(entry=entry, length=length, label=label, maximumResidentKiB=int(raw)))
    report = dict(source=source, session=args.session, complete=True, cases=summaries, memory=memory,
                  decision='Descriptive baseline only; no optimization accepted.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    manifest = {p.relative_to(out).as_posix(): dict(bytes=p.stat().st_size,
                sha256=hashlib.sha256(p.read_bytes()).hexdigest()) for p in sorted(out.rglob('*')) if p.is_file()}
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('Completed 32,832 ordinary processes and 72 separate maximum-resident observations')


if __name__ == '__main__':
    main()
