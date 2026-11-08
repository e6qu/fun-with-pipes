"""Disable only borrowed-array metadata selection in a separate measured build."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SELECTION = 'let borrowed_arrays = if array {\n            borrowed_array_reads(self.prog, &body, &locals, *captures)'
DISABLED = SELECTION.replace('if array {', 'if false {')


def reference_source(source):
    assert source.count(SELECTION) == 1 and DISABLED not in source
    return source.replace(SELECTION, DISABLED)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout, output = args.checkout.resolve(), args.output.resolve()
    assert checkout != ROOT
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
    candidate = (ROOT / 'src/cgen.rs').read_text()
    assert (checkout / 'src/cgen.rs').read_text() == candidate
    reference = reference_source(candidate)
    (checkout / 'src/cgen.rs').write_text(reference)
    assert subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True).splitlines() == ['src/cgen.rs']
    output.mkdir(parents=True, exist_ok=False)
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    (output / 'reference.patch').write_bytes(patch)
    (output / 'cgen-reference.rs').write_text(reference)
    (output / 'manifest.json').write_text(json.dumps(dict(
        source=source, disabled='borrowed array metadata selection',
        candidateSha256=hashlib.sha256(candidate.encode()).hexdigest(),
        referenceSha256=hashlib.sha256(reference.encode()).hexdigest(),
        patchSha256=hashlib.sha256(patch).hexdigest()), indent=2) + '\n')


if __name__ == '__main__':
    main()
