"""Allocator attribution must detect incomplete traces and omitted release."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import tarfile
import tempfile
from types import SimpleNamespace
import unittest

SPEC = importlib.util.spec_from_file_location('swift_allocations', Path(__file__).with_name('profile-swift-allocations.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)


class AllocationRecords(unittest.TestCase):
    def test_retained_native_profiles_recompute_from_raw_stacks(self):
        path = PROFILE.ROOT / 'docs/measurements/swift-allocations-2026-11-01.tar.xz'
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         '8690b2516204c1b40a86a9211ae72f77fbd229482db43d61ae76da8c264169e5')
        source = '9d47a5fcfb5c9342d9fca9da2a8c162f5ac1d38c'
        with tempfile.TemporaryDirectory(prefix='fwp-allocations-record-') as scratch:
            root = Path(scratch)
            with tarfile.open(path, 'r:xz') as archive:
                for member in archive:
                    relative = Path(member.name)
                    self.assertFalse(relative.is_absolute() or '..' in relative.parts)
                    if member.isdir():
                        continue
                    self.assertTrue(member.isfile())
                    target = root / relative
                    target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(archive.extractfile(member).read())
            run = json.loads((root / 'run.json').read_text())
            self.assertEqual(run['headSha'], source)
            for architecture, job in [('x86_64', 124699803387), ('aarch64', 124699803048)]:
                with self.subTest(architecture=architecture):
                    metadata = json.loads((root / f'job-{job}.json').read_text())
                    self.assertEqual((metadata['head_sha'], metadata['conclusion']), (source, 'success'))
                    folder = root / f'swift-allocations-{architecture}-1/swift-allocation-evidence'
                    PROFILE.audit(SimpleNamespace(input=folder, source=source, arch=architecture))
                    report = json.loads((folder / 'report.json').read_text())
                    system = report['systemControls']
                    if architecture == 'aarch64':
                        with self.assertRaises(AssertionError):
                            PROFILE.check_control(system['release'], system['omit-release'])
                    else:
                        PROFILE.check_control(system['release'], system['omit-release'])

    def test_unwinding_must_walk_callers_with_the_selected_library(self):
        record = dict(selectedLibrary='/chosen/libunwind.so.8', selected=dict(
            libraries='libunwind.so.8 => /chosen/libunwind.so.8',
            observation=dict(frames=4, steps=3, stepStatus=0, contextStatus=0, initStatus=0, pageBytes=4096)))
        PROFILE.check_unwinding(record)
        for key, value in [('frames', 0), ('steps', 0), ('stepStatus', -10), ('initStatus', -1)]:
            changed = copy.deepcopy(record)
            changed['selected']['observation'][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                PROFILE.check_unwinding(changed)
        record['selected']['libraries'] = 'libunwind.so.8 => /system/libunwind.so.8'
        with self.assertRaises(AssertionError):
            PROFILE.check_unwinding(record)

    def test_recompute_and_reject_incomplete_stack_counts(self):
        with tempfile.TemporaryDirectory() as temporary:
            folder = Path(temporary)
            (folder / 'allocations.txt').write_text('calls to allocation functions: 7 (100/s)\n')
            (folder / 'allocations.stacks').write_text('main;allocate_control 3\nruntime;malloc 4\n')
            (folder / 'peak.stacks').write_text('main;allocate_control 3145731\nruntime;malloc 100\n')
            (folder / 'leaked.stacks').write_text('main;allocate_control 0\nruntime;malloc 20\n')
            result = PROFILE.summarize(folder)
            self.assertEqual(result['totals'], dict(allocations=7, peak=3145831, leaked=20))
            self.assertEqual(result['control'], dict(allocations=3, peak=3145731, leaked=0))
            for damaged in ('main;allocate_control 3\n', '', 'main;allocate_control -3\n', 'main;allocate_control nan\n'):
                (folder / 'allocations.stacks').write_text(damaged)
                with self.subTest(damaged=damaged), self.assertRaises(AssertionError):
                    PROFILE.summarize(folder)

    def test_omitted_release_and_missing_allocations_cannot_pass(self):
        ordinary = dict(control=dict(allocations=3, peak=3145731, leaked=0))
        omitted = dict(control=dict(allocations=3, peak=3145731, leaked=1048578))
        PROFILE.check_control(ordinary, omitted)
        for key, value in [('allocations', 2), ('peak', 3145730), ('leaked', 0)]:
            changed = copy.deepcopy(omitted)
            changed['control'][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                PROFILE.check_control(ordinary, changed)
        with self.assertRaises(AssertionError):
            PROFILE.check_control(omitted, omitted)


if __name__ == '__main__':
    unittest.main()
