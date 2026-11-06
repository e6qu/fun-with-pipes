"""Reject incomplete native coverage and production edits after correctness checks."""
import copy
import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('safety', Path(__file__).with_name('check-measurement-safety.py'))
SAFETY = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SAFETY)


class Safety(unittest.TestCase):
    def test_complete_native_jobs_and_all_failure_modes(self):
        run = {'head_sha': '1' * 40}
        for protocol, group, hosts in [
                ('recording-inline', 'gradient_call_checks',
                 ('ubuntu-latest, gcc', 'ubuntu-24.04-arm, gcc', 'macos-15, clang')),
                ('tape-records', 'tape_records / records',
                 ('ubuntu-latest, gcc, x86-64', 'ubuntu-24.04-arm, gcc, armv8-a', 'macos-15, clang, armv8-a'))]:
            jobs = [dict(name=group + ' (' + host + ')', conclusion='success', head_sha=run['head_sha'])
                    for host in hosts]
            SAFETY.check_jobs(run, [{'jobs': jobs}], protocol)
            for mode in ('missing', 'duplicate', 'failed', 'skipped', 'other-source'):
                altered = copy.deepcopy(jobs)
                if mode == 'missing':
                    altered.pop()
                elif mode == 'duplicate':
                    altered.append(altered[0])
                elif mode == 'other-source':
                    altered[1]['head_sha'] = '2' * 40
                else:
                    altered[1]['conclusion'] = mode
                with self.subTest(mode=mode), self.assertRaises(AssertionError):
                    SAFETY.check_jobs(run, [{'jobs': altered}], protocol)

    def test_changed_production_tree_is_rejected_for_every_path(self):
        for changed in SAFETY.SOURCE_PATHS:
            def revision(command, cwd):
                return b'changed' if command[-1] == 'HEAD:' + changed else b'original'
            with self.subTest(path=changed), patch.object(SAFETY.subprocess, 'check_output', side_effect=revision):
                with self.assertRaisesRegex(AssertionError, changed.replace('.', r'\.')):
                    SAFETY.check_sources(Path('.'), '1' * 40)
        with patch.object(SAFETY.subprocess, 'check_output', return_value=b'same') as read:
            SAFETY.check_sources(Path('.'), '1' * 40)
            self.assertEqual(read.call_count, 2 * len(SAFETY.SOURCE_PATHS))

    def test_identity_specific_step_cannot_be_skipped(self):
        run = {'head_sha': '1' * 40}
        jobs = [dict(name='scalar_array_checks (' + host + ')', conclusion='success', head_sha=run['head_sha'],
                     steps=[dict(name='Same-type float bits, conversion maps and owner transfer', conclusion='success')])
                for host in ('ubuntu-latest, gcc', 'ubuntu-24.04-arm, gcc', 'macos-15, clang')]
        SAFETY.check_jobs(run, [{'jobs': jobs}], 'scalar-array-identity')
        jobs[0]['steps'][0]['conclusion'] = 'skipped'
        with self.assertRaises(AssertionError):
            SAFETY.check_jobs(run, [{'jobs': jobs}], 'scalar-array-identity')


if __name__ == '__main__':
    unittest.main()
