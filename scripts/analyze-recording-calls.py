"""Rebuild saved, measured C with GCC inlining reports; never execute the images."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import subprocess
import zipfile

from process_wait import run_capture

ROOT = Path(__file__).resolve().parents[1]
ORIGINAL_ROOT = Path('/home/runner/work/fun-with-pipes/fun-with-pipes')
CASES = ('3-0', '3-1', '3-199', '3-1999', '33-199', '129-199')
FORMS = ('fwp-ad', 'fwp-ad-history')


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


def compile_one(command, source, metadata, output, symbol):
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
    record = {'status': result.returncode, 'sourceSha256': digest(source), 'inliningTarget': symbol,
              'expectedImageSha256': metadata['sha256']}
    for name, path in [('image', binary), ('stack', stack), ('inline', inline)]:
        if path.is_file():
            data = path.read_bytes()
            record[name + 'Sha256'] = digest(data)
            record[name + 'Bytes'] = len(data)
            if name != 'inline':
                (output / name).write_bytes(data)
    if inline.is_file():
        record['inlineDecisions'] = inline_decisions(inline.read_text(), symbol)
    (output / 'result.json').write_text(json.dumps(record, indent=2) + '\n')
    check_result(result, binary, inline, metadata['sha256'])
    if not stack.is_file() or not stack.stat().st_size:
        raise ValueError('missing stack report')
    return record


def load_session(index_path, arch, source, protocol, output):
    index = json.loads(git_file(index_path))
    if index['auditErrors']:
        raise ValueError('input audit has unresolved artifact errors')
    session = index['sessions'][arch + '-1']
    if index['protocol'] != protocol or index['source'] != source or session['source'] != source:
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


def inline_decisions(text, symbol):
    assert symbol in ('fwp_p_ad_push', 'fwp_tape_reserve')
    lines = text.splitlines()
    name = re.escape(symbol)
    return dict(inlined=sum(bool(re.search(r'optimized:.*\bInlin(?:ing|ed) ' + name + r'[./]', line)) for line in lines),
                rejected=sum('not inlinable:' in line and bool(re.search(r'-> ' + name + r'[./]', line)) for line in lines))


def check_plan(plan, arch):
    assert set(plan) == {'contractCommit', 'architectures'}
    assert re.fullmatch('[0-9a-f]{40}', plan['contractCommit'])
    assert set(plan['architectures']) == {'aarch64', 'x86_64'}
    groups = plan['architectures'][arch]
    assert [group['protocol'] for group in groups] in (['scalar-constant', 'recording-lookup'], ['recording-inline'], ['recording-capacity'], ['recording-context'], ['tape-records'])
    seen = set()
    for group in groups:
        assert set(group) == {'name', 'index', 'source', 'protocol', 'variants'}
        assert re.fullmatch('[a-z][a-z-]+', group['name'])
        assert re.fullmatch('[0-9a-f]{40}', group['source'])
        assert group['protocol'] in ('scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context', 'tape-records')
        assert group['index'].startswith('docs/measurements/') and '..' not in Path(group['index']).parts
        expected_variants = {
            'scalar-constant': {'previous': ('', 'observe')},
            'recording-lookup': {'reference': ('-reference', 'observe'), 'candidate': ('', 'observe')},
            'recording-inline': {'reference': ('-reference', 'observe'), 'candidate': ('', 'require')},
            'recording-capacity': {'reference': ('-reference', 'observe'), 'candidate': ('', 'require')},
            'recording-context': {'reference': ('-reference', 'require'), 'candidate': ('', 'require')},
            'tape-records': {'reference': ('-reference', 'require'), 'candidate': ('', 'require')},
        }[group['protocol']]
        assert len(group['variants']) == len(expected_variants)
        assert all(set(variant) == {'name', 'suffix', 'inlining'} for variant in group['variants'])
        assert {variant['name']: (variant['suffix'], variant['inlining'])
                for variant in group['variants']} == expected_variants
        for variant in group['variants']:
            assert set(variant) == {'name', 'suffix', 'inlining'}
            assert re.fullmatch('[a-z][a-z-]+', variant['name']) and variant['name'] not in seen
            seen.add(variant['name'])
            assert variant['suffix'] in ('', '-reference')
            assert variant['inlining'] in ('observe', 'require')
            if variant['inlining'] == 'require':
                assert group['protocol'] in ('recording-context', 'tape-records') or (group['protocol'] in ('recording-inline', 'recording-capacity') and variant['suffix'] == '')
    return groups


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--plan', required=True, help='committed JSON with explicit sources, indexes and variants')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if not args.plan:
        parser.error('--plan must name a committed input JSON')
    if os.environ.get('GITHUB_ACTIONS') != 'true' or platform.system() != 'Linux':
        raise RuntimeError('native compiler diagnostic runs only on GitHub Linux runners')
    if platform.machine() != args.arch or ROOT != ORIGINAL_ROOT:
        raise RuntimeError('native architecture or original workspace path differs')
    plan_bytes = git_file(args.plan)
    plan = json.loads(plan_bytes)
    groups = check_plan(plan, args.arch)
    expected = len(CASES) * len(FORMS) * sum(len(group['variants']) for group in groups)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    (output / 'plan.json').write_bytes(plan_bytes)
    source = execute(['git', 'rev-parse', 'HEAD'])
    source.check_returncode()
    summary = {'source': source.stdout.decode().strip(), 'architecture': args.arch,
               'protocolCommit': plan['contractCommit'], 'planSha256': digest(plan_bytes),
               'compilations': [], 'errors': []}
    try:
        for group in groups:
            symbol = {'scalar-constant': 'fwp_p_ad_push', 'recording-lookup': 'fwp_p_ad_push',
                      'recording-inline': 'fwp_p_ad_push', 'recording-capacity': 'fwp_tape_reserve', 'recording-context': 'fwp_p_ad_push', 'tape-records': 'fwp_p_ad_push'}[group['protocol']]
            report, archive = load_session(group['index'], args.arch, group['source'], group['protocol'], output / group['name'])
            with zipfile.ZipFile(archive) as saved:
                if len(saved.namelist()) != len(set(saved.namelist())):
                    raise ValueError('duplicate archive members')
                for variant in group['variants']:
                    for case in CASES:
                        for form in FORMS:
                            program = form + variant['suffix']
                            label = f"{variant['name']}/{case}/{form}"
                            try:
                                metadata = report['results'][case]['binaries'][program]
                                data = saved.read(f'{case}/{program}.c')
                                require_hash(saved.read(f'{case}/{program}'), metadata['sha256'], 'original image')
                                command = recorded_command(report, args.arch, case, program)
                                result = compile_one(command, data, metadata, output / label, symbol)
                                if variant['inlining'] == 'require':
                                    declaration = {'fwp_p_ad_push': b'static inline __attribute__((always_inline)) V fwp_p_ad_push(',
                                                   'fwp_tape_reserve': b'static inline __attribute__((always_inline)) void fwp_tape_reserve('}[symbol]
                                    assert data.count(declaration) == 1, 'forced declaration missing or duplicated: ' + symbol
                                    assert result['inlineDecisions']['rejected'] == 0, 'GCC rejected forced inlining: ' + symbol
                                    if case != '3-0':
                                        assert result['inlineDecisions']['inlined'] > 0, 'no inlining reported in a positive-update program: ' + symbol
                                summary['compilations'].append({'case': label, **result})
                                print('verified', label, flush=True)
                            except (AssertionError, ValueError, OSError, KeyError, subprocess.SubprocessError) as error:
                                summary['errors'].append({'case': label, 'error': type(error).__name__ + ': ' + str(error)})
                                print('failed', label, str(error), flush=True)
            archive.unlink()
    except (ValueError, OSError, KeyError, subprocess.SubprocessError) as error:
        summary['errors'].append({'input': True, 'error': str(error)})
    finally:
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    if summary['errors'] or len(summary['compilations']) != expected:
        raise SystemExit('recording call diagnostic failed; inspect every retained error')
    print(f'{expected} original images reproduced; no native programs executed')


if __name__ == '__main__':
    main()
