#!/usr/bin/env python3
"""Exercise collection and independent reconstruction without native workloads."""
from contextlib import ExitStack, redirect_stdout
import hashlib
import io
import json
import os
from pathlib import Path
import struct
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

import cpu_samples
import service_cpu_collect
from service_cpu_audit import audit
from service_cpu_replay import verify_recordings
from weak_callback_service import expected

TABLE = 'static const fwp_fninfo fwp_fn_table[] = {\n    {1, e0, "service", &fwp_owned_info0},\n};\n'
FLAT = '# Total Lost Samples: 0\n# Event count (approx.): 1000\n# Overhead\tSamples\tPeriod\tShared Object\tSymbol\n100.00%\t1\t1000\tprogram\t[.] service_run\n'
ENTRIES = {'c': 'service_run', 'fwp': 'service_run', 'rs': 'weak_callback_service::service_run',
           'swift': 'WeakCallbackService.serviceRun(Swift.Int, Swift.Int) -> WeakCallbackService.Stats'}


class CollectionTests(unittest.TestCase):
    def exercise(self, folder, fault):
        output = folder/'evidence'
        compiler = folder/'fwp'
        compiler.write_bytes(b'compiler identity')
        addr2line = folder/'llvm-addr2line'
        addr2line.write_bytes(b'addr2line identity')
        calls = []

        def child(command, **settings):
            command = list(map(str, command))
            calls.append(command)
            stdout, stderr = '', ''
            if command[0] == '/perf' and '--version' not in command:
                if command[1] == 'record':
                    Path(command[command.index('--output')+1]).write_bytes(b'recording')
                    command = command[command.index('--')+1:]
                    if fault == 'lost':
                        stderr = '[ perf record: lost samples ]\n'
                elif command[1] == 'report':
                    return subprocess.CompletedProcess(command, 0, FLAT, '')
                elif command[1] == 'script':
                    key = Path(command[command.index('--input')+1]).parent.name
                    peer = key.split('-')[0]
                    return subprocess.CompletedProcess(command, 0,
                        f'1000 cpu-clock:u:\n 123 {ENTRIES[peer]} (program)\n', '')
                else:
                    self.fail(command)
            if command[0] in ('/c++filt', '/swift-demangle') and '--version' not in command:
                stdout = settings['input_data']
            elif command[0] == str(compiler.resolve()):
                Path(command[command.index('-o')+1]).write_text(TABLE)
            elif Path(command[0]).name == 'program':
                population, mode, batches = map(int, command[-3:])
                values = {k: v if k in ('population', 'mode') else v*batches
                          for k, v in expected(population, mode).items()}
                values.update(batches=batches, serviceNs=500_000_000 if batches < 64 else 1_000_000_000)
                if fault == 'wrong result' and population == 4096 and mode == 0:
                    values['received'] = 0
                stdout = json.dumps(values)+'\n'
            elif command[:2] == ['ar', 'crs']:
                Path(command[2]).write_bytes(b'archive')
            elif '-o' in command:
                artifact = Path(command[command.index('-o')+1])
                header = bytearray(20)
                header[:6] = b'\x7fELF\x02\x01'
                struct.pack_into('<H', header, 18, 183)
                artifact.write_bytes(header)
            elif '--version' in command or command == ['lscpu']:
                stdout = 'test identity\n'
            else:
                self.fail(command)
            return subprocess.CompletedProcess(command, 0, stdout, stderr)

        arguments = ['service_cpu_collect.py', 'collect', '--compiler', str(compiler), '--perf', '/perf',
            '--addr2line', str(addr2line), '--demangler', '/c++filt', '--swift-demangler', '/swift-demangle', '--output', str(output),
            '--source', 'source', '--tag', 'roadmap/service-cpu-control', '--arch', 'aarch64', '--cc', 'gcc',
            '--ar', 'ar', '--rustc', 'rustc', '--swiftc', 'swiftc', '--target', 'aarch64-unknown-linux-gnu',
            '--c-arch', 'armv8-a', '--rust-cpu', 'generic', '--user-registers', ','.join(cpu_samples.CORE_REGISTERS['aarch64']),
            '--cpu', '0', '--frequency', '997', '--stack-bytes', '32768', '--ring-bytes', '262144',
            '--addr2line-timeout-ms', '10000', '--deadline', '120']
        with ExitStack() as stack:
            stack.enter_context(patch.dict(os.environ, GITHUB_ACTIONS='true', GITHUB_SHA='source'))
            stack.enter_context(patch.object(sys, 'argv', arguments))
            stack.enter_context(patch.object(service_cpu_collect.platform, 'platform', return_value='test kernel'))
            stack.enter_context(patch.object(service_cpu_collect.platform, 'system', return_value='Linux'))
            stack.enter_context(patch.object(service_cpu_collect.platform, 'machine', return_value='aarch64'))
            stack.enter_context(patch.object(os, 'sched_getaffinity', return_value={0}, create=True))
            stack.enter_context(patch.object(os, 'sched_setaffinity', create=True))
            stack.enter_context(patch.object(subprocess, 'check_output', return_value='source\n'))
            stack.enter_context(patch.object(service_cpu_collect, 'run_capture', side_effect=child))
            stack.enter_context(patch.object(cpu_samples, 'run_capture', side_effect=child))
            stack.enter_context(patch.object(service_cpu_collect.shutil, 'which', return_value=str(addr2line)))
            stack.enter_context(patch.object(service_cpu_collect, 'boundary', side_effect=lambda s: s))
            stack.enter_context(redirect_stdout(io.StringIO()))
            if fault:
                with self.assertRaises(AssertionError):
                    service_cpu_collect.main()
            else:
                service_cpu_collect.main()
        return output, json.loads((output/'summary.json').read_text())

    def test_all_peers_cases_pilots_and_raw_reconstruction(self):
        with tempfile.TemporaryDirectory() as name:
            folder, report = self.exercise(Path(name), None)
            result = audit(folder, 'source', 'aarch64')
            retained, counts = verify_recordings(folder, 'source', 'aarch64')
            self.assertEqual(retained, report)
            self.assertEqual(len(counts), 32)
            with self.assertRaises(AssertionError):
                verify_recordings(folder, 'wrong source', 'aarch64')
            self.assertEqual((result['cases'], result['profiles']), (32, 16))
            for row in report['cases'].values():
                if row['pilots']:
                    self.assertEqual([p['batches'] for p in row['pilots']], [16, 64])
            # Updating a hash cannot conceal a changed sample period from reconstruction.
            path = folder/'c-4096-0/user-stacks.demangled.txt'
            path.write_text(path.read_text().replace('1000 cpu-clock', '999 cpu-clock'))
            manifest = json.loads((folder/'sha256.json').read_text())
            manifest[str(path.relative_to(folder))] = hashlib.sha256(path.read_bytes()).hexdigest()
            (folder/'sha256.json').write_text(json.dumps(manifest))
            with self.assertRaises(AssertionError):
                audit(folder, 'source', 'aarch64')

    def test_wrong_results_fail_and_other_cases_continue(self):
        with tempfile.TemporaryDirectory() as name:
            folder, report = self.exercise(Path(name), 'wrong result')
            self.assertEqual(len(report['cases']), 32)
            self.assertEqual(len(report['failures']), 4)
            self.assertTrue(report['cases']['fwp-4096-3']['correct'])
            with self.assertRaises(AssertionError):
                verify_recordings(folder, 'source', 'aarch64')
            with self.assertRaises(AssertionError):
                audit(folder, 'source', 'aarch64')

    def test_lost_samples_fail_every_profile_without_skipping_small_controls(self):
        with tempfile.TemporaryDirectory() as name:
            folder, report = self.exercise(Path(name), 'lost')
            self.assertEqual(len(report['cases']), 32)
            self.assertEqual(len(report['failures']), 16)
            self.assertTrue(all(row['correct'] for key, row in report['cases'].items() if '-64-' in key))
            with self.assertRaises(AssertionError):
                audit(folder, 'source', 'aarch64')


if __name__ == '__main__':
    unittest.main()
