#!/usr/bin/env python3
"""Run the fixed loopback API protocol; retain attempts, CPU/RSS traces and shutdown."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shlex
import shutil
import signal
import subprocess
import threading
import time
import traceback

from http_load import audit
from process_wait import communicate, run_capture

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def command(arguments, prefix, environment, deadline):
    arguments = list(map(str, arguments))
    start = time.monotonic_ns()
    try:
        result = run_capture(arguments, cwd=ROOT, env=environment, input_data=None,
            input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', timeout=deadline, check=False)
    except subprocess.TimeoutExpired as error:
        prefix.with_suffix('.stdout').write_bytes(error.stdout or b'')
        prefix.with_suffix('.stderr').write_bytes(error.stderr or b'')
        prefix.with_suffix('.command.json').write_text(json.dumps(dict(command=arguments,
            elapsedNs=time.monotonic_ns() - start, timedOut=True, status=124), indent=2) + '\n')
        raise
    prefix.with_suffix('.stdout').write_bytes(result.stdout)
    prefix.with_suffix('.stderr').write_bytes(result.stderr)
    prefix.with_suffix('.command.json').write_text(json.dumps(dict(command=arguments,
        elapsedNs=time.monotonic_ns() - start, status=result.returncode), indent=2) + '\n')
    assert result.returncode == 0 and not result.stderr, (arguments, result.stderr)
    return result.stdout


def process_sample(pid):
    path = Path('/proc') / str(pid)
    # comm may contain spaces/parentheses. Fields after its last ')' start at state.
    stat = (path / 'stat').read_text().rsplit(')', 1)[1].split()
    memory = (path / 'statm').read_text().split()
    return dict(pid=pid, cpuTicks=int(stat[11]) + int(stat[12]),
                rssBytes=int(memory[1]) * os.sysconf('SC_PAGE_SIZE'),
                threads=int(stat[17]), descriptors=len(list((path / 'fd').iterdir())))


def sample_processes(server, client, path, stopping, errors):
    try:
        with path.open('w') as log:
            while True:
                row = dict(monotonicNs=time.monotonic_ns(), unixNs=time.time_ns())
                for name, child in [('server', server), ('generator', client)]:
                    try:
                        row[name] = process_sample(child.pid)
                    except FileNotFoundError:
                        row[name] = None  # Process exited between stat reads; retain that fact.
                    except OSError as error:
                        errors.append(f'{name}: {error}')
                        row[name] = dict(error=str(error))
                log.write(json.dumps(row) + '\n')
                log.flush()
                if stopping.wait(1):
                    break
    except Exception as error:
        errors.append(f"process sampling failed: {error}")


def stop(child, deadline):
    if child.poll() is None:
        try:
            os.killpg(child.pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
        try:
            child.wait(timeout=deadline)
        except subprocess.TimeoutExpired:
            try:
                os.killpg(child.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            child.wait()
            raise
    return child.returncode


def summarize_samples(path, header):
    rows = [json.loads(line) for line in path.read_text().splitlines()]
    start = header['epochUnixNs'] + header['warmupNs']
    end = start + header['durationNs']
    result = {}
    for name in ('server', 'generator'):
        points = [(r['monotonicNs'], r[name]) for r in rows
                  if start <= r['unixNs'] <= end and r[name] is not None and 'error' not in r[name]]
        if len(points) < 2:
            result[name] = dict(samples=len(points), sufficientForTrend=False)
            continue
        seconds = [(ns - points[0][0]) / 1e9 for ns, _ in points]
        memory = [p['rssBytes'] for _, p in points]
        mean_x = sum(seconds) / len(seconds)
        mean_y = sum(memory) / len(memory)
        variance = sum((x - mean_x) ** 2 for x in seconds)
        slope = sum((x - mean_x) * (y - mean_y) for x, y in zip(seconds, memory)) / variance
        cpu_seconds = (points[-1][1]['cpuTicks'] - points[0][1]['cpuTicks']) / os.sysconf('SC_CLK_TCK')
        result[name] = dict(samples=len(points), sufficientForTrend=True,
            firstRssBytes=memory[0], lastRssBytes=memory[-1], peakRssBytes=max(memory),
            rssSlopeBytesPerSecond=slope, sampledCpuSeconds=cpu_seconds,
            sampledElapsedSeconds=seconds[-1], sampledCpuFraction=cpu_seconds / seconds[-1])
    offsets = [r['unixNs'] - r['monotonicNs'] for r in rows]
    result['wallToMonotonicOffsetSpreadNs'] = max(offsets) - min(offsets) if offsets else None
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--driver', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--cxx', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--requests-per-connection', type=int, required=True)
    parser.add_argument('--phase', choices=['check', 'measure'], required=True)
    parser.add_argument('--session', type=int, choices=[0, 1, 2], required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and (args.phase == 'check') == (args.session == 0)
    assert 1 <= args.requests_per_connection < 2**63
    machine = platform.machine()
    march = {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[machine]
    cpus = sorted(os.sched_getaffinity(0))
    assert len(cpus) >= 2, 'two distinct allowed CPUs are required'
    server_cpu, generator_cpu = cpus[:2]
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', FWP_ADDR='127.0.0.1:0', LC_ALL='C')
    # fwp's CC/CXX settings accept executable paths, not argument lists. These
    # explicit launchers apply the declared native target to every C/C++ unit.
    flags = ['-march=' + march, '-ffp-contract=off', '-fno-fast-math', '-fno-lto']
    for key, tool in [('CC', args.cc), ('CXX', args.cxx)]:
        executable = shutil.which(tool)
        assert executable, tool
        launcher = output / ('gcc-policy' if key == 'CC' else 'gxx-policy')
        launcher.write_text('#!/bin/sh\nexec ' + shlex.join([executable, *flags]) + ' "$@"\n')
        launcher.chmod(0o755)
        environment[key] = str(launcher)
    maintained_source = ROOT / 'examples/server/api.fwp'
    original = maintained_source.read_text()
    before = 'config = "unused" | http.config | with { shutdown-grace = 3s }'
    assert original.count(before) == 1, 'maintained API configuration changed'
    configured = original.replace(before, 'config = "unused" | http.config | with { shutdown-grace = 3s, '
                                  + f'max-requests-per-connection = {args.requests_per_connection}' + ' }')
    source = output / 'api.fwp'
    source.write_text(configured)
    (output / 'api-original.fwp').write_text(original)
    identity = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        programSha256=digest(source), maintainedProgramSha256=digest(maintained_source),
        maxRequestsPerConnection=args.requests_per_connection,
        machine=machine, phase=args.phase, session=args.session,
        compilerSha256=digest(args.compiler), generatorSha256=digest(args.driver),
        gccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        gxxVersion=subprocess.check_output([args.cxx, '--version'], text=True),
        topology=subprocess.check_output(['lscpu'], text=True), allowedCpus=cpus,
        serverCpu=server_cpu, generatorCpu=generator_cpu, clockTicksPerSecond=os.sysconf('SC_CLK_TCK'),
        environment={k: environment[k] for k in ['CC', 'CXX', 'FWP_LTO', 'FWP_ADDR']},
        flags=flags, optimization='O2', requestDeadlineSeconds=5, shutdownDeadlineSeconds=20,
        placement='Distinct allowed logical CPUs, not exclusive physical cores',
        scope='fwp API only; no C/Rust/Swift peer throughput claim. Closed loop, one request outstanding per persistent connection. Setup excluded; request send, response consumption and validation included. Native logging overhead is included in throughput, outside request latency.')
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')
    compiler = args.compiler.resolve()
    command([compiler, 'build', '--target', 'native', '--emit-c', '-O2', source, '-o', output / 'api.c'],
            output / 'emit', environment, 120)
    binary = output / 'api.exe'
    command([compiler, 'build', '--target', 'native', '-O2', source, '-o', binary],
            output / 'build', environment, 180)
    identity.update(binarySha256=digest(binary), binaryBytes=binary.stat().st_size,
                    generatedCSha256=digest(output / 'api.c'))
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')
    schedule = [(2, 0, 1, 'check')]
    if args.phase == 'measure':
        levels = [1, 8, 32, 64] if args.session == 1 else [64, 32, 8, 1]
        schedule = [(level, 5, 30, f'connections-{level}-run-{run}') for level in levels for run in (1, 2)]
        if args.session == 1:
            schedule.append((32, 5, 300, 'soak'))
    summary = dict(identity=identity, trials=[], failures=[])
    for connections, warmup, duration, name in schedule:
        path = output / name
        path.mkdir()
        server = None
        client = None
        sampler = None
        stopping = threading.Event()
        sample_errors = []
        try:
            with (path / 'server.stderr').open('wb') as stderr, (path / 'server.stdout').open('wb') as stdout:
                server_command = ['taskset', '-c', str(server_cpu), str(binary)]
                server = subprocess.Popen(server_command, env=environment, cwd=ROOT,
                    stdin=subprocess.DEVNULL, stdout=stdout, stderr=stderr, start_new_session=True)
                started = time.monotonic()
                while True:
                    text = (path / 'server.stderr').read_text()
                    addresses = re.findall(r'listening on http://(127\.0\.0\.1:\d+)', text)
                    if addresses:
                        assert len(addresses) == 1
                        break
                    assert server.poll() is None and time.monotonic() - started < 60, text
                    time.sleep(.02)
                directory = path / 'attempts'
                driver_command = ['taskset', '-c', str(generator_cpu), str(args.driver.resolve()),
                    addresses[0], str(connections), str(warmup), str(duration), '5000', str(directory)]
                (path / 'commands.json').write_text(json.dumps(dict(server=server_command, generator=driver_command), indent=2) + '\n')
                client = subprocess.Popen(driver_command, env=environment, cwd=ROOT,
                    stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=subprocess.PIPE, start_new_session=True)
                sampler = threading.Thread(target=sample_processes,
                    args=(server, client, path / 'processes.jsonl', stopping, sample_errors))
                sampler.start()
                try:
                    stdout_data, stderr_data = communicate(client, warmup + duration + 15, None)
                except BaseException:
                    if client.poll() is None:
                        try:
                            os.killpg(client.pid, signal.SIGKILL)
                        except ProcessLookupError:
                            pass
                    client.communicate()
                    raise
                (path / 'generator.stdout').write_bytes(stdout_data)
                (path / 'generator.stderr').write_bytes(stderr_data)
                header = json.loads(stdout_data)
                report = audit(directory, header, False)
                report.update(name=name, connections=connections, warmupSeconds=warmup,
                              durationSeconds=duration, generatorStatus=client.returncode, header=header)
                (path / 'attempt-summary.json').write_text(json.dumps(report, indent=2) + '\n')
                summary['trials'].append(report)
                assert stop(server, 20) == 0, (path / 'server.stderr').read_text()
                stopping.set()
                sampler.join()
                report['processSamples'] = summarize_samples(path / 'processes.jsonl', header)
                (path / 'attempt-summary.json').write_text(json.dumps(report, indent=2) + '\n')
                assert client.returncode == 0 and not stderr_data and report['allFailures'] == 0, (client.returncode, stderr_data.decode(errors='replace'), report)
                assert report['measuredAttempts'] >= connections and not sample_errors, sample_errors
                print(name, report['completedPerSecond'], 'correct responses/s', flush=True)
        except (AssertionError, OSError, ValueError, subprocess.SubprocessError) as error:
            summary['failures'].append(dict(trial=name, error=str(error), traceback=traceback.format_exc()))
            print(name, 'FAIL', traceback.format_exc(), flush=True)
        finally:
            stopping.set()
            if sampler is not None:
                sampler.join()
            for child in (client, server):
                if child is not None:
                    try:
                        stop(child, 20)
                    except subprocess.TimeoutExpired as error:
                        summary['failures'].append(dict(trial=name, shutdownError=str(error)))
            # Lossless compression bounds retained disk use; no attempts are sampled out.
            for raw in path.glob('attempts/worker-*.bin'):
                with raw.open('rb') as original, gzip.open(str(raw) + '.gz', 'wb') as compressed:
                    shutil.copyfileobj(original, compressed)
                raw.unlink()
            (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    assert not summary['failures'], summary['failures']


if __name__ == '__main__':
    main()
