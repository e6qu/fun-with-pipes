#!/usr/bin/env python3
"""Validate and package one host-native compiler outside the source checkout."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import struct
import subprocess
import tarfile
import tempfile

ROOT = Path(__file__).resolve().parent.parent


def run(args, cwd, env=None):
    result = subprocess.run(args, cwd=cwd, env=env, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f"{args}: {result.stdout}\n{result.stderr}")
    return result.stdout


def architecture(path):
    data = path.read_bytes()[:64]
    if data[:4] == b"\x7fELF":
        assert data[4:6] == b"\x02\x01", "expected 64-bit little-endian ELF"
        return {62: "amd64", 183: "arm64"}[struct.unpack_from('<H', data, 18)[0]]
    assert data[:4] == b"\xcf\xfa\xed\xfe", "expected single-architecture Mach-O"
    return {0x1000007: "amd64", 0x100000c: "arm64"}[struct.unpack_from('<I', data, 4)[0]]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    options = parser.parse_args()
    system = {"Linux": "linux", "Darwin": "macos"}[platform.system()]
    arch = {"x86_64": "amd64", "aarch64": "arm64", "arm64": "arm64"}[platform.machine()]
    options.output.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='fwp-package-') as temporary:
        work = Path(temporary)
        package = work / f'fwp-{system}-{arch}'
        package.mkdir()
        compiler = package / 'fwp'
        shutil.copy2(ROOT / 'target/release/fwp', compiler)
        shutil.copy2(ROOT / 'LICENSE', package / 'LICENSE')
        licenses = package / 'licenses'
        licenses.mkdir()
        shutil.copy2(ROOT / 'vendor/softfloat/LICENSE.txt', licenses / 'SoftFloat.txt')
        assert architecture(compiler) == arch
        source = work / 'smoke.fwp'
        source.write_text('main = range 0 10 | sum | echo\n')
        env = dict(os.environ, FWP_NO_OPT='1')
        reference = run([str(compiler), 'run', '--interp', str(source)], work, env)
        assert reference == '45\n', reference
        env = dict(os.environ)
        env.pop('FWP_NO_OPT', None)
        executions = {}
        for mode in ['tracing', 'arc']:
            binary = work / f'smoke-{mode}'
            run([str(compiler), 'build', '-O2', '--gc', mode, str(source), '-o', str(binary)], work, env)
            assert architecture(binary) == arch
            output = run([str(binary)], work, env)
            assert output == reference, (mode, output, reference)
            executions[mode] = output
        dependency_command = ['otool', '-L'] if system == 'macos' else ['ldd']
        manifest = dict(
            head=run(['git', 'rev-parse', 'HEAD'], ROOT).strip(),
            os=system, architecture=arch, hardware=platform.uname()._asdict(),
            compilerBuild=['cargo', 'build', '--release', '--bin', 'fwp'],
            rustc=run(['rustc', '--version', '--verbose'], work),
            cc=run([os.environ.get('CC', 'cc'), '--version'], work),
            sha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
            dependencies=run(dependency_command + [str(compiler)], work),
            rawInterpreter=reference, nativeExecutions=executions,
            scope='Copied compiler and generated binaries executed outside checkout on the native host. System C toolchain required for native compilation; TLS requires OpenSSL 3.')
        (package / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
        (package / 'README.txt').write_text(
            'fwp: place this executable on PATH. Standard library and C runtime are embedded.\n'
            'Native compilation requires the system C compiler and development tools.\n'
            'TLS programs require OpenSSL 3; on macOS configure FWP_OPENSSL_DIR.\n'
            'This artifact is for the OS and architecture in manifest.json.\n')
        with tarfile.open(options.output / f'{package.name}.tar.gz', 'w:gz') as archive:
            archive.add(package, arcname=package.name)
        shutil.copy2(package / 'manifest.json', options.output / 'manifest.json')
        print(json.dumps(manifest, indent=2))


if __name__ == '__main__':
    main()
