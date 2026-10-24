#!/usr/bin/env python3
"""Record Linux mappings during the API memory scenario; never relax its budget."""
from concurrent.futures import ThreadPoolExecutor
import argparse
import hashlib
import http.client
import json
import math
import os
from pathlib import Path
import platform
import queue
import re
import signal
import socket
import struct
import subprocess
import threading
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--binary', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--repetitions', type=int, required=True)
args = parser.parse_args()
assert platform.system() == 'Linux' and args.repetitions > 0
binary = args.binary.resolve()
raw = binary.read_bytes()
assert raw[:6] == b'\x7fELF\x02\x01'
assert struct.unpack_from('<H', raw, 18)[0] == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
args.output.mkdir(parents=True, exist_ok=True)
assert not (args.output / 'report.json').exists()


def metrics(connection):
    connection.request('GET', '/metrics')
    response = connection.getresponse()
    body = response.read().decode()
    assert response.status == 200, body
    value, = [float(line.removeprefix('http_requests_total '))
              for line in body.splitlines() if line.startswith('http_requests_total ')]
    assert math.isfinite(value) and value >= 1 and value.is_integer()
    return value


def client(address, repeats):
    connection = http.client.HTTPConnection(address, timeout=15)
    try:
        for _ in range(repeats):
            for method, path, headers, body, status, expected in [
                ('GET', '/health', {}, '', 200, '{"status":"ok"}'),
                ('GET', '/items/42', {}, '', 200, '{"id":42,"name":"item 42"}'),
                ('GET', '/items/x', {}, '', 404, 'no such item'),
                ('GET', '/nothing', {}, '', 404, 'not found'),
                ('POST', '/items', {'authorization': 'Bearer secret'}, '{"name":"héllo"}', 201, '{"id":1,"name":"héllo"}'),
                ('POST', '/items', {}, '{}', 401, 'missing or invalid bearer token'),
                ('POST', '/items', {'authorization': 'Bearer secret'}, '{}', 422, 'name is required'),
                ('GET', '/slow?ms=0', {}, '', 200, 'slept 0 ms'),
                ('GET', '/stream', {}, '', 200, 'line 1\nline 2\nline 3\nline 4\nline 5\n'),
            ]:
                connection.request(method, path, body.encode(), headers)
                response = connection.getresponse()
                actual = response.read().decode()
                assert (response.status, actual) == (status, expected), (path, response.status, actual)
            metrics(connection)
    finally:
        connection.close()


def mappings(pid):
    raw = Path(f'/proc/{pid}/smaps').read_text()
    rows = []
    current = None
    for line in raw.splitlines():
        if re.match(r'^[0-9a-f]+-[0-9a-f]+ ', line):
            current = {'mapping': line}
            rows.append(current)
        elif current is not None:
            name, value = line.split(':', 1)
            current[name] = value.strip()
    return raw, [row for row in rows if row['Rss'] != '0 kB']


def measure(repetition):
    destination = args.output / str(repetition)
    destination.mkdir()
    environment = dict(os.environ, FWP_ADDR='127.0.0.1:0')
    for name in ['FWP_TLS_CERT', 'FWP_TLS_KEY']:
        environment.pop(name, None)
    process = subprocess.Popen([str(binary)], env=environment, stdin=subprocess.PIPE,
                               stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True)
    lines = queue.Queue()
    diagnostics = []

    def drain():
        for line in process.stderr:
            diagnostics.append(line)
            lines.put(line)

    reader = threading.Thread(target=drain)
    reader.start()
    samples = []
    pending = []
    try:
        ready = lines.get(timeout=20)
        assert ready.startswith('listening on http://'), ready
        address = ready.strip().removeprefix('listening on http://')
        host, port = address.split(':')
        endpoint = (host, int(port))
        for index, repeats in enumerate([1, 4, 16, 1, 16, 4, 0, 1]):
            if repeats:
                with ThreadPoolExecutor(max_workers=8) as pool:
                    list(pool.map(lambda _: client(address, repeats), range(8)))
            else:
                for _ in range(8):
                    with socket.create_connection(endpoint, timeout=15) as stream:
                        stream.sendall(b'POST /items HTTP/1.1\r\nhost: test\r\ncontent-length: 100\r\n\r\n{')
            deadline = time.monotonic() + 20
            while True:
                remaining = deadline - time.monotonic()
                assert remaining > 0, 'idle checkpoint deadline'
                checkpoint = lines.get(timeout=remaining).strip()
                if not checkpoint.startswith('http-wait'):
                    break
            assert checkpoint.startswith('http-memory\t'), checkpoint
            status = Path(f'/proc/{process.pid}/status').read_text()
            resident, = [int(line.split()[1]) for line in status.splitlines() if line.startswith('VmRSS:')]
            raw, regions = mappings(process.pid)
            destination.joinpath(f'{index}.smaps').write_text(raw)
            destination.joinpath(f'{index}.status').write_text(status)
            samples.append(dict(checkpoint=checkpoint, rssKiB=resident, mappings=regions))
            print(repetition, checkpoint, 'RSS KiB', resident, flush=True)
            process.stdin.write('\n')
            process.stdin.flush()
        control = http.client.HTTPConnection(address, timeout=15)
        try:
            baseline = metrics(control)
            for _ in range(7):
                stream = socket.create_connection(endpoint, timeout=15)
                pending.append(stream)
                stream.sendall(b'GET /slow?ms=60000 HTTP/1.1\r\nhost: test\r\n\r\n')
            deadline = time.monotonic() + 10
            polls = 0
            while True:
                polls += 1
                if metrics(control) == baseline + polls + 7:
                    break
                assert time.monotonic() < deadline
                time.sleep(.01)
        finally:
            control.close()
        process.send_signal(signal.SIGTERM)
        process.wait(timeout=20)
        assert process.returncode == 0
    finally:
        if process.poll() is None:
            process.kill()
            process.wait()
        for stream in pending:
            stream.close()
        reader.join()
        destination.joinpath('stderr').write_text(''.join(diagnostics))
        destination.joinpath('exit').write_text(str(process.returncode))
        destination.joinpath('samples.json').write_text(json.dumps(samples, indent=2) + '\n')
    growth = max(sample['rssKiB'] for sample in samples) - samples[0]['rssKiB']
    return dict(repetition=repetition, rssGrowthKiB=growth, budgetExceeded=growth > 8192, samples=samples)


report = dict(binarySha256=hashlib.sha256(raw).hexdigest(), platform=platform.platform(),
              scope='Diagnostic mappings; exceeding 8 MiB remains an unresolved failure.',
              repetitions=[measure(index) for index in range(args.repetitions)])
(args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
