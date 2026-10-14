#!/usr/bin/env python3
"""Validate and package one host-native compiler outside the source checkout."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import struct
import subprocess
import tarfile
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent.parent


def run(args, cwd, env=None):
    result = subprocess.run(args, cwd=cwd, env=env, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f"{args}: {result.stdout}\n{result.stderr}")
    return result.stdout


def architecture(path):
    with path.open('rb') as binary:
        data = binary.read(64)
        if data[:2] == b'MZ':
            assert len(data) == 64, 'truncated DOS header'
            binary.seek(struct.unpack_from('<I', data, 60)[0])
            pe = binary.read(26)
            assert pe[:4] == b'PE\0\0' and len(pe) == 26, 'invalid PE header'
            assert struct.unpack_from('<H', pe, 24)[0] == 0x20b, 'expected PE32+'
            return {0x8664: 'amd64', 0xaa64: 'arm64'}[struct.unpack_from('<H', pe, 4)[0]]
    if data[:4] == b"\x7fELF":
        assert data[4:6] == b"\x02\x01", "expected 64-bit little-endian ELF"
        return {62: "amd64", 183: "arm64"}[struct.unpack_from('<H', data, 18)[0]]
    assert data[:4] == b"\xcf\xfa\xed\xfe", "expected single-architecture Mach-O"
    return {0x1000007: "amd64", 0x100000c: "arm64"}[struct.unpack_from('<I', data, 4)[0]]


def windows_dependencies(path, cwd, require_system=True):
    report = run(['llvm-readobj', '--coff-imports', str(path)], cwd)
    names = re.findall(r'^\s+Name: (\S+\.dll)\s*$', report, flags=re.MULTILINE | re.IGNORECASE)
    assert names, f'no PE import evidence: {path}'
    if require_system:
        system = {'kernel32.dll', 'ntdll.dll', 'advapi32.dll', 'user32.dll',
                  'shell32.dll', 'ws2_32.dll', 'bcrypt.dll', 'bcryptprimitives.dll',
                  'crypt32.dll', 'secur32.dll', 'iphlpapi.dll', 'psapi.dll',
                  'ole32.dll', 'oleaut32.dll', 'version.dll', 'normaliz.dll',
                  'ucrtbase.dll', 'msvcrt.dll', 'userenv.dll', 'dbghelp.dll'}
        external = [name for name in names if name.lower() not in system
                    and not name.lower().startswith(('api-ms-win-', 'ext-ms-win-'))]
        assert not external, f'non-system DLL dependencies in {path}: {external}'
    return dict(imports=names, inspection=report)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    options = parser.parse_args()
    system = {"Linux": "linux", "Darwin": "macos", "Windows": "windows"}[platform.system()]
    arch = {"x86_64": "amd64", "amd64": "amd64", "aarch64": "arm64", "arm64": "arm64"}[platform.machine().lower()]
    executable = 'fwp.exe' if system == 'windows' else 'fwp'
    options.output.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='fwp-package-') as temporary:
        work = Path(temporary)
        package = work / f'fwp-{system}-{arch}'
        package.mkdir()
        compiler = package / executable
        shutil.copy2(ROOT / 'target/release' / executable, compiler)
        shutil.copy2(ROOT / 'LICENSE', package / 'LICENSE')
        licenses = package / 'licenses'
        licenses.mkdir()
        shutil.copy2(ROOT / 'vendor/softfloat/LICENSE.txt', licenses / 'SoftFloat.txt')
        shutil.copy2(ROOT / 'vendor/gdtoa/LICENSE.txt', licenses / 'gdtoa.txt')
        shutil.copy2(ROOT / 'vendor/tlfloat/LICENSE.txt', licenses / 'TLFloat.txt')
        assert architecture(compiler) == arch
        source = work / 'smoke.fwp'
        source.write_text('main = [range 0 10 | sum | echo, 0.125f128 | add 0.25f128 | echo, 1.5f16 | echo] | ignore\n')
        env = dict(os.environ, FWP_NO_OPT='1')
        reference = run([str(compiler), 'run', '--interp', str(source)], work, env)
        assert reference == '45\n3.75e-1\n1.5\n', reference
        env = dict(os.environ)
        env.pop('FWP_NO_OPT', None)
        executions = {}
        generated_dependencies = {}
        for mode in ['tracing', 'arc']:
            binary = work / (f'smoke-{mode}' + ('.exe' if system == 'windows' else ''))
            run([str(compiler), 'build', '-O2', '--gc', mode, str(source), '-o', str(binary)], work, env)
            assert architecture(binary) == arch
            output = run([str(binary)], work, env)
            assert output == reference, (mode, output, reference)
            executions[mode] = output
            if system == 'windows':
                generated_dependencies[mode] = windows_dependencies(binary, work)
        dependency_command = ['otool', '-L'] if system == 'macos' else ['ldd']
        dependencies = (windows_dependencies(compiler, work) if system == 'windows'
                        else run(dependency_command + [str(compiler)], work))
        manifest = dict(
            head=run(['git', 'rev-parse', 'HEAD'], ROOT).strip(),
            os=system, architecture=arch, hardware=platform.uname()._asdict(),
            compilerBuild=['cargo', 'build', '--release', '--bin', 'fwp'],
            rustc=run(['rustc', '--version', '--verbose'], work),
            cc=run([os.environ.get('CC', 'cc'), '--version'], work),
            sha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
            dependencies=dependencies, generatedDependencies=generated_dependencies,
            rustflags=os.environ.get('RUSTFLAGS', ''),
            rawInterpreter=reference, nativeExecutions=executions,
            scope='Copied compiler and generated binaries executed outside checkout on the native host. System C toolchain required for native compilation; TLS requires OpenSSL 3.')
        (package / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
        (package / 'README.txt').write_text(
            'fwp: place this executable on PATH. Standard library and C runtime are embedded.\n'
            'Native compilation requires the system C compiler and development tools.\n'
            'TLS programs require OpenSSL 3; on macOS/Windows configure FWP_OPENSSL_DIR.\n'
            'Windows native compilation uses LLVM-MinGW; TLS needs matching import libraries and DLLs.\n'
            'This artifact is for the OS and architecture in manifest.json.\n')
        if system == 'windows':
            with zipfile.ZipFile(options.output / f'{package.name}.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
                for entry in package.rglob('*'):
                    if entry.is_file():
                        archive.write(entry, entry.relative_to(work))
        else:
            with tarfile.open(options.output / f'{package.name}.tar.gz', 'w:gz') as archive:
                archive.add(package, arcname=package.name)
        shutil.copy2(package / 'manifest.json', options.output / 'manifest.json')
        print(json.dumps(manifest, indent=2))


if __name__ == '__main__':
    main()
