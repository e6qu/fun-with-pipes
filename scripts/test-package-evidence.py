#!/usr/bin/env python3
"""Require complete evidence archives and a named failure on unreadable input."""
import errno
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import zipfile

SPEC = importlib.util.spec_from_file_location('package_evidence', Path(__file__).with_name('package-evidence.py'))
PACKAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PACKAGE)
SOURCE = 'a' * 40


class Evidence(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.base = Path(self.temporary.name).resolve()
        self.root = self.base / 'input'
        self.root.mkdir()
        self.output = self.base / 'evidence.zip'
        self.manifest = self.base / 'manifest.json'

    def package(self):
        PACKAGE.package(self.root, self.output, self.manifest, SOURCE, 6)
        return json.loads(self.manifest.read_text())

    def test_binary_hidden_unicode_and_empty_files_round_trip(self):
        expected = {'nested/image.exe': bytes(range(256)) * 8193,
                    '.status': b'', 'unicode-é.txt': 'example λ'.encode()}
        for name, data in expected.items():
            path = self.root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(data)
        report = self.package()
        self.assertTrue(report['complete'])
        self.assertEqual(report['source'], SOURCE)
        with zipfile.ZipFile(self.output) as archive:
            self.assertEqual(set(archive.namelist()), set(expected))
            for name, data in expected.items():
                self.assertEqual(archive.read(name), data)
                self.assertEqual(report['files'][name], dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest()))

    def test_read_error_names_file_and_does_not_publish_archive(self):
        path = self.root / 'unreadable.exe'
        path.write_bytes(b'image')
        ordinary_open = Path.open

        def failing_open(target, *args, **kwargs):
            if target == path and args == ('rb',):
                raise OSError(errno.EILSEQ, 'illegal byte sequence')
            return ordinary_open(target, *args, **kwargs)

        with patch.object(Path, 'open', failing_open), self.assertRaises(OSError):
            self.package()
        report = json.loads(self.manifest.read_text())
        self.assertFalse(report['complete'])
        self.assertEqual(report['failure']['file'], 'unreadable.exe')
        self.assertEqual(report['failure']['type'], 'OSError')
        self.assertFalse(self.output.exists())

    def test_changed_file_is_rejected(self):
        path = self.root / 'changing'
        path.write_bytes(b'first')
        ordinary_open = Path.open

        def changing_open(target, *args, **kwargs):
            if target == path and args == ('rb',):
                with ordinary_open(target, 'wb') as stream:
                    stream.write(b'changed size')
            return ordinary_open(target, *args, **kwargs)

        with patch.object(Path, 'open', changing_open), self.assertRaisesRegex(ValueError, 'changed while reading'):
            self.package()
        self.assertFalse(self.output.exists())

    def test_empty_directory_and_symlink_are_rejected(self):
        with self.assertRaisesRegex(ValueError, 'no evidence'):
            self.package()
        (self.base / 'evidence.zip.partial').unlink()
        (self.root / 'link').symlink_to(self.manifest)
        with self.assertRaisesRegex(ValueError, 'non-regular'):
            self.package()
        self.assertFalse(self.output.exists())

    def test_existing_archive_is_preserved(self):
        self.output.write_bytes(b'previous evidence')
        with self.assertRaisesRegex(AssertionError, 'refuse to replace'):
            self.package()
        self.assertEqual(self.output.read_bytes(), b'previous evidence')

    def test_wrong_archived_bytes_prevent_publication(self):
        (self.root / 'source').write_bytes(b'correct')
        ordinary_open = zipfile.ZipFile.open

        def altered_read(archive, name, mode='r', *args, **kwargs):
            if mode == 'r':
                return io.BytesIO(b'changed')
            return ordinary_open(archive, name, mode, *args, **kwargs)

        with patch.object(zipfile.ZipFile, 'open', altered_read), self.assertRaises(AssertionError):
            self.package()
        self.assertFalse(self.output.exists())
        report = json.loads(self.manifest.read_text())
        self.assertEqual(report['failure']['file'], 'source')
        self.assertFalse(report['complete'])


if __name__ == '__main__':
    unittest.main()
