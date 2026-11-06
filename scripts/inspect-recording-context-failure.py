#!/usr/bin/env python3
"""Reproduce a saved recording probe and report its failing release counters."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import zipfile

from github_records import records


def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences',
                                    'repos/e6qu/fun-with-pipes/' + path])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    artifacts = records(api, f'actions/runs/{args.run}/artifacts', 'artifacts')
    artifact, = [a for a in artifacts if a['name'] == 'gradient-call-checks-ubuntu-latest']
    assert artifact['workflow_run']['head_sha'] == args.source and not artifact['expired']
    archive = args.output / 'original.zip'
    with archive.open('wb') as out:
        subprocess.run(['gh', 'api', '--allow-escape-sequences',
                        f"repos/e6qu/fun-with-pipes/actions/artifacts/{artifact['id']}/zip"], stdout=out, check=True)
    with archive.open('rb') as stream:
        assert artifact['digest'] == 'sha256:' + hashlib.file_digest(stream, 'sha256').hexdigest()
    (args.output / 'artifact.json').write_text(json.dumps(artifact, indent=2) + '\n')
    with zipfile.ZipFile(archive) as z:
        assert z.read('source.txt').decode().strip() == args.source
        name, = [n for n in z.namelist() if n.endswith('recording_context/scoped-O1-reusetrue-workspace0.c')]
        source = z.read(name).decode()
        assert z.read(name[:-2] + '.status') == b'Some(92)\n'
        (args.output / 'original.c').write_text(source)
        (args.output / 'target.log').write_bytes(z.read('targets/test-ad_tape_scopes.log'))
    marker = '|| fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 92;'
    assert source.count(marker) == 1
    diagnostic = source.replace(marker, '''|| fwp_heap.live != baseline || fwp_heap.rc_wide_len) {
            fprintf(stderr, "count=%d mode=%d alias=%d baseline=%zu live=%zu tapes=%p ntapes=%lld capacity=%lld cached=%zu wide=%zu\\n",
                    count, mode, alias, baseline, fwp_heap.live, (void *)fwp_tapes,
                    (long long)fwp_ntapes, (long long)fwp_tapes_cap,
                    fwp_tape_cached_bytes, fwp_heap.rc_wide_len);
            return 92;
        }''')
    (args.output / 'diagnostic.c').write_text(diagnostic)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_AD_WORKSPACE='0', FWP_LTO='0', LC_ALL='C')
    for kind in ('original', 'diagnostic'):
        binary = args.output / (kind + '.exe')
        command = ['gcc', '-O1', '-std=gnu11', '-ffp-contract=off', '-w',
                   str(args.output / (kind + '.c')), '-o', str(binary), '-lm', '-lpthread', '-ldl']
        compiled = subprocess.run(command, env=environment, capture_output=True, timeout=180)
        (args.output / (kind + '-compile.stdout')).write_bytes(compiled.stdout)
        (args.output / (kind + '-compile.stderr')).write_bytes(compiled.stderr)
        assert compiled.returncode == 0, compiled
        result = subprocess.run([str(binary.resolve())], env=environment, capture_output=True, timeout=180)
        (args.output / (kind + '.stdout')).write_bytes(result.stdout)
        (args.output / (kind + '.stderr')).write_bytes(result.stderr)
        (args.output / (kind + '.status')).write_text(str(result.returncode) + '\n')
        print(kind, result.returncode, result.stderr.decode())
        assert result.returncode == 92 and not result.stdout, result
    print('The original release failure is reproduced; this is not a passing safety check')


if __name__ == '__main__':
    main()
