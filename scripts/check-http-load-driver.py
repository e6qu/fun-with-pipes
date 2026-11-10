#!/usr/bin/env python3
"""Exercise the native load driver against controlled HTTP responses and failures."""
import argparse
import json
from pathlib import Path
import socket
import socketserver
import subprocess
import threading

from http_load import BODY, REQUEST, audit
from process_wait import run_capture

WIRE = b'HTTP/1.1 200 OK\r\ncontent-length: ' + str(len(BODY)).encode() + b'\r\n\r\n' + BODY


class Server(socketserver.ThreadingTCPServer):
    daemon_threads = True
    allow_reuse_address = False


class Handler(socketserver.BaseRequestHandler):
    def handle(self):
        self.request.settimeout(3)
        try:
            while True:
                request = bytearray()
                while not request.endswith(b'\r\n\r\n'):
                    block = self.request.recv(1)
                    if not block:
                        return
                    request.extend(block)
                    if len(request) > 8192:
                        raise ValueError('unexpected driver request')
                assert bytes(request) == REQUEST
                mode = self.server.mode
                if mode == 'timeout':
                    self.server.stopping.wait(2)
                    return
                if mode == 'partial':
                    self.request.sendall(WIRE[:-5])
                    return
                if mode == 'wrong':
                    self.request.sendall(WIRE.replace(b'item 42', b'item 43'))
                    return
                self.request.sendall(WIRE)
        except (ConnectionResetError, BrokenPipeError, socket.timeout):
            return


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--driver', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    for mode, outcome in [('good', 0), ('wrong', 2), ('partial', 3), ('timeout', 1)]:
        with Server(('127.0.0.1', 0), Handler) as server:
            server.mode = mode
            server.stopping = threading.Event()
            thread = threading.Thread(target=server.serve_forever)
            thread.start()
            try:
                directory = output / mode
                command = [str(args.driver.resolve()), f'127.0.0.1:{server.server_address[1]}',
                           '2', '0', '1', '100' if mode == 'timeout' else '5000', str(directory)]
                result = run_capture(command, env=None, cwd=None, input_data=None,
                    input_stream=subprocess.DEVNULL, text=True, encoding='utf-8', timeout=10, check=False)
                directory.with_suffix('.stdout').write_text(result.stdout)
                directory.with_suffix('.stderr').write_text(result.stderr)
                header = json.loads(result.stdout)
                report = audit(directory, header, False)
                assert header['setupErrors'] == 0
                if outcome == 0:
                    assert result.returncode == 0 and not result.stderr
                    assert report['measuredAttempts'] >= 2 and report['allFailures'] == 0
                else:
                    assert result.returncode != 0 and report['allFailures'] == 2
                    assert report['measuredAttempts'] == 2 and report['failureFraction'] == 1
                    for worker in range(2):
                        raw = (directory / f'worker-{worker}.bin').read_bytes()
                        assert int.from_bytes(raw[24:28], 'little') == outcome
                directory.with_suffix('.json').write_text(json.dumps(report, indent=2) + '\n')
                print(mode, 'pass', flush=True)
            finally:
                server.stopping.set()
                server.shutdown()
                thread.join()


if __name__ == '__main__':
    main()
