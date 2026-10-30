#!/usr/bin/env python3
"""Reject damaged executable-name observations using the complete measured artifact."""
import argparse
from contextlib import ExitStack
import gzip
import importlib.util
import json
from pathlib import Path
import shutil
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('timing_names', Path(__file__).with_name('check-timing-names.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


class NamingEvidence(unittest.TestCase):
    def test_complete_artifact_recomputes_all_rounds(self):
        actual = CHECK.audit(self.directory, self.source)
        self.assertEqual(actual['observations'], 1024)
        self.assertEqual(actual['decision'], 'diagnostic-only')
        self.assertEqual(set(actual['ratios']), {'kernel', 'derivative'})

    def test_each_corruption_is_rejected(self):
        for change in ['source', 'missing', 'command', 'order', 'cpu', 'live', 'binary', 'extra']:
            with self.subTest(change=change), tempfile.TemporaryDirectory() as temporary:
                directory = Path(temporary) / 'artifact'
                shutil.copytree(self.directory, directory)
                source = self.source
                if change == 'source':
                    source = '0' * 40
                elif change == 'missing':
                    path = directory / 'observations.jsonl'
                    path.write_bytes(b'\n'.join(path.read_bytes().splitlines()[:-1]) + b'\n')
                elif change == 'binary':
                    path = directory / 'derivative/slot0exe'
                    path.write_bytes(path.read_bytes() + b'changed')
                elif change == 'extra':
                    (directory / 'discarded-samples.json').write_text('[]')
                else:
                    paths = [directory / name for name in ['processes.jsonl', 'observations.jsonl']]
                    rows = [[json.loads(line) for line in path.read_bytes().splitlines()] for path in paths]
                    record = rows[0][0]
                    if change == 'command':
                        record['command'][0] += '-changed'
                        rows[1][0]['command'] = record['command']
                    elif change == 'order':
                        for records in rows:
                            records[0], records[1] = records[1], records[0]
                    elif change == 'cpu':
                        for records in rows:
                            records[0]['resources']['userSeconds'] = -1
                    else:
                        name = f"{record['group']}-{record['round']}-{record['policy']}-{record['position']}.stdout.gz"
                        path = directory / name
                        output = json.loads(gzip.decompress(path.read_bytes()))
                        live = 'liveChargedBytes' if record['label'].startswith('fwp') else 'livePayloadBytes'
                        output['samples'][0][live] = 1
                        raw = json.dumps(output).encode()
                        path.write_bytes(gzip.compress(raw, mtime=0))
                        for records in rows:
                            records[0]['stdoutSha256'] = CHECK.digest(raw)
                        rows[1][0]['samples'] = output['samples']
                    for path, records in zip(paths, rows):
                        path.write_text(''.join(json.dumps(row) + '\n' for row in records))
                with self.assertRaises(AssertionError):
                    CHECK.audit(directory, source)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    inputs = parser.add_mutually_exclusive_group(required=True)
    inputs.add_argument('--directory', type=Path)
    inputs.add_argument('--retained-index', type=Path)
    parser.add_argument('--source', required=True)
    args = parser.parse_args()
    with ExitStack() as stack:
        if args.retained_index:
            directory = Path(stack.enter_context(tempfile.TemporaryDirectory()))
            CHECK.restore(args.retained_index, directory, args.source)
        else:
            directory = args.directory
        NamingEvidence.directory = directory
        NamingEvidence.source = args.source
        unittest.main(argv=['test-timing-names'])
