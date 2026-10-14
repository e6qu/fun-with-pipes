#!/usr/bin/env python3
"""Require host-native OpenSSL DLLs and CLI before Windows TLS acceptance."""
import importlib.util
from pathlib import Path
import platform
import sys

spec = importlib.util.spec_from_file_location('package_native', Path(__file__).with_name('package-native.py'))
package = importlib.util.module_from_spec(spec)
spec.loader.exec_module(package)
prefix = Path(sys.argv[1])
expected = {'amd64': 'amd64', 'arm64': 'arm64'}[platform.machine().lower()]
files = [prefix / 'tools/openssl/openssl.exe']
for library in ['ssl', 'crypto']:
    matches = list((prefix / 'bin').glob(f'lib{library}-3*.dll'))
    assert len(matches) == 1, (library, matches)
    files.extend(matches)
    assert (prefix / f'lib/lib{library}.lib').is_file()
for binary in files:
    assert package.architecture(binary) == expected, binary
    print(f'{binary.name}: native {expected}')
