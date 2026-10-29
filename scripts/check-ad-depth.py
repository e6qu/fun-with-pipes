#!/usr/bin/env python3
"""Verify retained derivative depth reports against their artifact identities."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import statistics


def check_report(report, files, source, machine):
    assert report['source'] == source and report['machine'] == machine
    expected = {f'{scalar}-depth{depth}-n{number}'
                for scalar in ['F64', 'F128'] for depth in [1, 2, 3] for number in [1, 16, 128]}
    assert set(report['results']) == expected
    assert len(files) == 2195 and len(report['stack']) == 76
    assert report['configuration']['samples'] == 12 and report['configuration']['warmups'] == 2
    settings = dict(report['settings'])
    # The two original archives recorded an unused environment variable. Keep
    # that observation intact; it is not evidence of a runtime reuse control.
    if 'FWP_REUSE' in settings:
        assert settings.pop('FWP_REUSE') == '1'
    assert settings == dict(FWP_STACK='1', FWP_AD_WORKSPACE='0', FWP_LTO='0')
    assert not any(flag.startswith('-DFWP_NO_REUSE') for flag in report['cflags'])
    for case, row in report['results'].items():
        assert case == f"{row['scalar']}-depth{row['depth']}-n{row['inputs']}"
        assert set(row['programs']) == {'ad', 'formula'}
        output = files[case + '-ad-interp.stdout']['sha256']
        for variant, program in row['programs'].items():
            name = case + '-' + variant
            assert files[name + '-interp.stdout']['sha256'] == output
            for kind, image in program['images'].items():
                image_name = name + ('-profile' if kind == 'profile' else '')
                assert files[image_name] == dict(bytes=image['bytes'], sha256=image['sha256'])
                assert files[image_name + '.c']['sha256'] == image['sourceSha256']
                assert image['instructionBytes'] > 0
                assert files[name + '-' + kind + '-check.stdout']['sha256'] == output
            assert set(program['images']) == {'ordinary', 'profile'}
            assert program['managed']['finalChargedBytes'] == 0
            raw = program['raw']['rawDerivativeStorage']
            assert raw['finalBytes'] == 0
            if variant == 'ad':
                assert len(raw['afterBackward']) == row['depth']
                last = raw['afterBackward'][-1]
                assert last['otherBytes'] == last['workspaceBytes'] == 0
                assert raw['beforeShutdownBytes'] == last['registryBytes']
            else:
                assert raw['peakBytes'] == 0 and not raw['afterBackward']
            for phase, count, field in [('warmup', 2, 'warmupWallNs'), ('sample', 12, 'processWallNs')]:
                assert len(program[field]) == count and all(v > 0 for v in program[field])
                for index in range(count):
                    assert files[f'{name}-{phase}-{index}.stdout']['sha256'] == output
            assert program['medianProcessWallNs'] == statistics.median(program['processWallNs'])
    for name, row in report['stack'].items():
        assert hashlib.sha256(row['text'].encode()).hexdigest() == row['sha256'] == files[name]['sha256']
    assert set(report['controls']) == {'F64-depth1-n1-ad', 'F128-depth2-n1-ad'}
    for name, control in report['controls'].items():
        assert control['status'] == (232 if name.startswith('F64') else 0)
        assert control['interruption'] is None
        assert control['stdoutSha256'] == files[name + '-interp.stdout']['sha256']
        for suffix, field in [('', 'binarySha256'), ('.c', 'sourceSha256'),
                              ('.stdout', 'stdoutSha256'), ('.stderr', 'stderrSha256')]:
            assert control[field] == files[name + '-missing-release' + suffix]['sha256']
    assert set(report['exactFloat']) == {'float.c', 'float.cpp'}
    for extension, row in report['exactFloat'].items():
        assert files['exact.' + extension]['sha256'] == row['sourceSha256']
        assert files['exact.' + extension + '.o']['sha256'] == row['objectSha256']


def check_archive(path):
    archive = json.loads(path.read_text())
    assert set(archive['sessions']) == {'arm', 'amd'}
    assert len({row['job'] for row in archive['sessions'].values()}) == 2
    for arch, session in archive['sessions'].items():
        report = None
        for kind in ['report', 'log']:
            raw = gzip.decompress((path.parent / session[kind]).read_bytes())
            assert hashlib.sha256(raw).hexdigest() == session[kind + 'Sha256']
            if kind == 'report':
                report = json.loads(raw)
        check_report(report, session['files'], archive['source'], 'aarch64' if arch == 'arm' else 'x86_64')
    print('Both 18-case depth matrices, cleanup checkpoints, outputs and retained identities pass')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    check_archive(parser.parse_args().archive)
