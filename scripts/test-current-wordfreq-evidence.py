#!/usr/bin/env python3
"""Reject damaged measured evidence, even after its file hashes are updated."""
import argparse
import base64
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('wordfreq_check', Path(__file__).with_name('check-current-wordfreq.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


class EvidenceRejections(unittest.TestCase):
    files = None
    source = None
    machine = None
    session = None

    def verify(self, files):
        return CHECK.audit(files, self.source, self.machine, self.session)

    def rewrite(self, name, data):
        files = dict(self.files)
        files[name] = data
        report = json.loads(files['comparison.json'])
        report['files'][name] = dict(bytes=len(data), sha256=CHECK.sha(data))
        files['comparison.json'] = json.dumps(report).encode()
        return files

    def change_row(self, field, value):
        rows = [json.loads(line) for line in self.files['commands.jsonl'].splitlines()]
        row = next(r for r in rows if r['phase'] == 'timing')
        row[field] = value
        if field == 'stdoutBase64':
            row['stdoutSha256'] = CHECK.sha(base64.b64decode(value))
        return self.rewrite('commands.jsonl', b'\n'.join(json.dumps(r).encode() for r in rows)+b'\n')

    def test_complete_observations_pass(self):
        self.assertEqual(self.verify(self.files)['commands'], 9270)

    def test_missing_observation_is_rejected(self):
        rows = self.files['commands.jsonl'].splitlines()
        with self.assertRaises(AssertionError):
            self.verify(self.rewrite('commands.jsonl', b'\n'.join(rows[:-1])+b'\n'))

    def test_wrong_output_with_matching_hash_is_rejected(self):
        with self.assertRaises(AssertionError):
            self.verify(self.change_row('stdoutBase64', base64.b64encode(b'wrong\n').decode()))

    def test_status_timeout_and_position_are_not_discarded(self):
        for field, value in [('status', 7), ('timedOut', True), ('position', 99)]:
            with self.subTest(field=field), self.assertRaises(AssertionError):
                self.verify(self.change_row(field, value))

    def test_changed_copy_with_updated_manifest_is_rejected(self):
        with self.assertRaises(AssertionError):
            self.verify(self.rewrite('program-i', self.files['program-i']+b'changed'))

    def test_invented_median_in_both_reports_is_rejected(self):
        results = json.loads(self.files['results.json'])
        results['4096:64']['medianRoundTotalNs']['fwp'] += 1
        files = self.rewrite('results.json', json.dumps(results).encode())
        report = json.loads(files['comparison.json'])
        report['results'] = results
        files['comparison.json'] = json.dumps(report).encode()
        with self.assertRaises(AssertionError):
            self.verify(files)

    def test_nonzero_live_storage_in_both_reports_is_rejected(self):
        rows = [json.loads(line) for line in self.files['commands.jsonl'].splitlines()]
        row = next(r for r in rows if r['phase'] == 'profile')
        counts = json.loads(base64.b64decode(row['stderrBase64']))
        counts['finalChargedBytes'] = 8
        raw = json.dumps(counts).encode()
        row.update(stderrBase64=base64.b64encode(raw).decode(), stderrSha256=CHECK.sha(raw))
        files = self.rewrite('commands.jsonl', b'\n'.join(json.dumps(r).encode() for r in rows)+b'\n')
        results = json.loads(files['results.json'])
        results[row['case']]['managedProfile'] = counts
        files['results.json'] = json.dumps(results).encode()
        report = json.loads(files['comparison.json'])
        report['files']['results.json'] = dict(bytes=len(files['results.json']), sha256=CHECK.sha(files['results.json']))
        report['results'] = results
        files['comparison.json'] = json.dumps(report).encode()
        with self.assertRaises(AssertionError):
            self.verify(files)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    inputs = parser.add_mutually_exclusive_group(required=True)
    inputs.add_argument('--archive', type=Path)
    inputs.add_argument('--directory', type=Path)
    inputs.add_argument('--retained-index', type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=['aarch64', 'x86_64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    args = parser.parse_args()
    EvidenceRejections.files = (CHECK.read_retained(args.retained_index, args.machine, args.session)
        if args.retained_index else CHECK.read_files(args.archive, args.directory))
    EvidenceRejections.source = args.source
    EvidenceRejections.machine = args.machine
    EvidenceRejections.session = args.session
    unittest.main(argv=['test-current-wordfreq-evidence'])


if __name__ == '__main__':
    main()
