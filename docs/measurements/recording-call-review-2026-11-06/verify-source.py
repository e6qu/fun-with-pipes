"""Verify the saved C comparison against all four original runtime reports."""
import difflib
import gzip
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent
TIMINGS = ROOT.parent / 'recording-lookup-time-2026-11-06'


def main():
    review = json.loads((ROOT / 'review.json').read_text())
    sources = {}
    for name, record in review['programs'].items():
        raw = gzip.decompress((ROOT / record['file']).read_bytes())
        assert len(raw) == record['bytes']
        assert hashlib.sha256(raw).hexdigest() == record['sha256']
        sources[name] = raw.decode()
    sessions = json.loads((TIMINGS / 'sessions.json').read_text())
    assert set(sessions['sessions']) == {'arm-1', 'arm-2', 'amd-1', 'amd-2'}
    for session in sessions['sessions'].values():
        report = json.loads(gzip.decompress((TIMINGS / session['report']).read_bytes()))
        assert report['source'] == review['source']
        for name, program in [('candidate', 'fwp-ad'), ('reference', 'fwp-ad-reference')]:
            assert report['results']['129-199']['binaries'][program]['sourceSha256'] == review['programs'][name]['sha256']
    state = '    fwp_ad_recording recording = {-1, NULL};\n'
    assert sources['candidate'].count(state) == 1 and state not in sources['reference']
    restored, count = re.subn(r'fwp_p_ad_push\(([^;\n]*), &recording\)', r'f141(\1)', sources['candidate'].replace(state, ''))
    assert count == 6 and restored == sources['reference']
    wrapper = 'static V f141(V l0, V l1, V l2, V l3) {\n    return fwp_p_ad_push(l0, l1, l2, l3, NULL);\n}'
    assert wrapper in sources['candidate'] and wrapper in sources['reference']
    patch = ''.join(difflib.unified_diff(sources['reference'].splitlines(True), sources['candidate'].splitlines(True), fromfile='reference.c', tofile='candidate.c'))
    assert patch == (ROOT / 'reference-to-candidate.patch').read_text()
    print('Four measured sessions share these C files; only one state declaration and six calls differ')


if __name__ == '__main__':
    main()
