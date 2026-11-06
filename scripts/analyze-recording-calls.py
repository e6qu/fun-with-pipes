"""Rebuild saved, measured C with GCC inlining reports; never execute the images."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import zipfile

from process_wait import run_capture

ROOT = Path(__file__).resolve().parents[1]
ORIGINAL_ROOT = Path('/home/runner/work/fun-with-pipes/fun-with-pipes')
CASES = ('3-0', '3-1', '3-199', '3-1999', '33-199', '129-199')
FORMS = ('fwp-ad', 'fwp-ad-history')
PARENT = '76690b385514c58ad94c5591da3553fa48218535'
CURRENT = '31c04650527d7a3c9efdd63bd5b4eae8a15d5732'
PARENT_INDEX = 'docs/measurements/scalar-constant-time-2026-11-05/42078637088/index.json'
CURRENT_INDEX = {
    'aarch64': 'docs/measurements/recording-lookup-time-2026-11-06/run-42136888829/summary/index.json',
    'x86_64': 'docs/measurements/recording-lookup-time-2026-11-06/run-42137772065/summary/index.json',
}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def require_hash(data, expected, label):
    if digest(data) != expected:
        raise ValueError(f'{label}: SHA-256 mismatch')


def execute(command):
    return run_capture(command, env=dict(os.environ), cwd=ROOT, input_data=None,
                       input_stream=subprocess.DEVNULL, text=False, encoding='utf-8',
                       timeout=120, check=False)


def git_file(path):
    result = execute(['git', 'show', 'HEAD:' + path])
    result.check_returncode()
    return result.stdout


def expected_command(arch, case, program):
    source = ORIGINAL_ROOT / 'descent-peers-evidence' / case / (program + '.c')
    target = source.with_suffix('')
    march = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[arch]
    return ['gcc', '-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
            '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + march, '-w', str(source),
            '-o', str(target), '-lm', '-lpthread', '-ldl']


def recorded_command(report, arch, case, program):
    expected = expected_command(arch, case, program)
    matches = [c for c in report['commands'] if c['command'] == expected]
    if len(matches) != 1 or matches[0]['status'] or matches[0]['stdout'] or matches[0]['stderr']:
        raise ValueError(f'{case}/{program}: missing unique successful original command')
    return expected


def check_result(result, binary, inline, expected):
    if result.returncode or result.stdout or result.stderr:
        raise ValueError('compiler failed or emitted unexpected stdout/stderr')
    if not inline.is_file() or not inline.stat().st_size:
        raise ValueError('missing or empty inlining report')
    require_hash(binary.read_bytes(), expected, 'rebuilt executable')


def compile_one(command, source, metadata, output):
    output.mkdir(parents=True, exist_ok=False)
    require_hash(source, metadata['sourceSha256'], 'saved source')
    source_path = Path(command[9])
    binary = Path(command[11])
    source_path.parent.mkdir(parents=True, exist_ok=True)
    source_path.write_bytes(source)
    binary.unlink(missing_ok=True)
    stack = binary.with_suffix('.su')
    stack.unlink(missing_ok=True)
    inline = output / 'inline.txt'
    actual = [*command, '-fopt-info-inline-optimized-missed=' + str(inline)]
    (output / 'command.json').write_text(json.dumps(actual, indent=2) + '\n')
    (output / 'source.c').write_bytes(source)
    try:
        result = execute(actual)
    except subprocess.TimeoutExpired as error:
        (output / 'stdout').write_bytes(error.output or b'')
        (output / 'stderr').write_bytes(error.stderr or b'')
        (output / 'result.json').write_text(json.dumps({'error': 'compiler deadline exceeded'}) + '\n')
        raise
    (output / 'stdout').write_bytes(result.stdout)
    (output / 'stderr').write_bytes(result.stderr)
    record = {'status': result.returncode, 'sourceSha256': digest(source),
              'expectedImageSha256': metadata['sha256']}
    for name, path in [('image', binary), ('stack', stack), ('inline', inline)]:
        if path.is_file():
            data = path.read_bytes()
            record[name + 'Sha256'] = digest(data)
            record[name + 'Bytes'] = len(data)
            if name != 'inline':
                (output / name).write_bytes(data)
    (output / 'result.json').write_text(json.dumps(record, indent=2) + '\n')
    check_result(result, binary, inline, metadata['sha256'])
    if not stack.is_file() or not stack.stat().st_size:
        raise ValueError('missing stack report')
    return record


def load_session(index_path, arch, source, output):
    index = json.loads(git_file(index_path))
    session = index['sessions'][arch + '-1']
    if index['source'] != source or session['source'] != source:
        raise ValueError('unexpected saved source identity')
    report_path = str(Path(index_path).parent / session['report'])
    raw = gzip.decompress(git_file(report_path))
    require_hash(raw, session['reportSha256'], 'saved report')
    report = json.loads(raw)
    if report['source'] != source or report['machine'] != arch or set(report['results']) != set(CASES):
        raise ValueError('report source, architecture or cases differ')
    version = execute(['gcc', '--version'])
    version.check_returncode()
    if version.stderr or version.stdout.decode() != report['cCompiler']:
        raise ValueError('GCC version differs from measured compiler')
    runner = {'aarch64': 'ubuntu-24.04-arm', 'x86_64': 'ubuntu-latest'}[arch]
    artifact = session['artifacts']['descent-peers-' + runner + '-1']
    if artifact['workflow_run']['head_sha'] != source or artifact['workflow_run']['id'] != index['run']:
        raise ValueError('artifact source/run differs')
    output.mkdir(parents=True, exist_ok=False)
    (output / 'session.json').write_text(json.dumps(session, indent=2) + '\n')
    (output / 'report.json.gz').write_bytes(gzip.compress(raw, mtime=0))
    download = execute(['gh', 'api', f'repos/e6qu/fun-with-pipes/actions/artifacts/{artifact["id"]}/zip'])
    download.check_returncode()
    if download.stderr or len(download.stdout) != artifact['size_in_bytes']:
        raise ValueError('artifact download differs in size or has diagnostics')
    require_hash(download.stdout, artifact['digest'].removeprefix('sha256:'), 'original artifact')
    archive = output / 'original.zip'
    archive.write_bytes(download.stdout)
    return report, archive


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if os.environ.get('GITHUB_ACTIONS') != 'true' or platform.system() != 'Linux':
        raise RuntimeError('native compiler diagnostic runs only on GitHub Linux runners')
    if platform.machine() != args.arch or ROOT != ORIGINAL_ROOT:
        raise RuntimeError('native architecture or original workspace path differs')
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    source = execute(['git', 'rev-parse', 'HEAD'])
    source.check_returncode()
    summary = {'source': source.stdout.decode().strip(), 'architecture': args.arch,
               'protocolCommit': '4e7ff3ef', 'compilations': [], 'errors': []}
    try:
        for group, index, revision, variants in [
            ('previous', PARENT_INDEX, PARENT, [('previous', '')]),
            ('lookup', CURRENT_INDEX[args.arch], CURRENT, [('reference', '-reference'), ('candidate', '')]),
        ]:
            report, archive = load_session(index, args.arch, revision, output / group)
            with zipfile.ZipFile(archive) as saved:
                if len(saved.namelist()) != len(set(saved.namelist())):
                    raise ValueError('duplicate archive members')
                for variant, suffix in variants:
                    for case in CASES:
                        for form in FORMS:
                            program = form + suffix
                            label = f'{variant}/{case}/{form}'
                            try:
                                metadata = report['results'][case]['binaries'][program]
                                data = saved.read(f'{case}/{program}.c')
                                require_hash(saved.read(f'{case}/{program}'), metadata['sha256'], 'original image')
                                command = recorded_command(report, args.arch, case, program)
                                result = compile_one(command, data, metadata, output / label)
                                summary['compilations'].append({'case': label, **result})
                                print('verified', label, flush=True)
                            except (ValueError, OSError, KeyError, subprocess.SubprocessError) as error:
                                summary['errors'].append({'case': label, 'error': str(error)})
                                print('failed', label, str(error), flush=True)
            archive.unlink()
    except (ValueError, OSError, KeyError, subprocess.SubprocessError) as error:
        summary['errors'].append({'input': True, 'error': str(error)})
    finally:
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    if summary['errors'] or len(summary['compilations']) != 36:
        raise SystemExit('recording call diagnostic failed; inspect every retained error')
    print('36 original images reproduced; no native programs executed')


if __name__ == '__main__':
    main()
