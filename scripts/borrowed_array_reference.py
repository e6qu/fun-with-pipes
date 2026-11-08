"""Disable one declared array transformation in a same-source measured build."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SELECTION = 'let borrowed_arrays = if array {\n            borrowed_array_reads(self.prog, &body, &locals, *captures)'
DISABLED = SELECTION.replace('if array {', 'if false {')
FRESH_SELECTION = 'let fresh_f64 = hof.0 == "array.generate"\n'
FRESH_DISABLED = 'let fresh_f64 = false\n'
CAPTURED_SELECTION = 'const CAPTURED_MAPS: bool = true;'
CAPTURED_DISABLED = 'const CAPTURED_MAPS: bool = false;'


def reference_source(source):
    assert source.count(SELECTION) == 1 and DISABLED not in source
    return source.replace(SELECTION, DISABLED)


def fresh_reference_source(source):
    assert source.count(FRESH_SELECTION) == 1 and FRESH_DISABLED not in source
    return source.replace(FRESH_SELECTION, FRESH_DISABLED)


def captured_reference_source(source):
    assert source.count(CAPTURED_SELECTION) == 1 and CAPTURED_DISABLED not in source
    return source.replace(CAPTURED_SELECTION, CAPTURED_DISABLED)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--transformation', choices=('array-metadata', 'fresh-array', 'captured-maps'), required=True)
    args = parser.parse_args()
    checkout, output = args.checkout.resolve(), args.output.resolve()
    assert checkout != ROOT
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
    path = 'src/cgen/owned_numeric.rs' if args.transformation == 'captured-maps' else 'src/cgen.rs'
    candidate = (ROOT / path).read_text()
    assert (checkout / path).read_text() == candidate
    transform = {'array-metadata': reference_source, 'fresh-array': fresh_reference_source,
                 'captured-maps': captured_reference_source}[args.transformation]
    reference = transform(candidate)
    (checkout / path).write_text(reference)
    assert subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True).splitlines() == [path]
    output.mkdir(parents=True, exist_ok=False)
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    (output / 'reference.patch').write_bytes(patch)
    (output / 'cgen-reference.rs').write_text(reference)
    (output / 'manifest.json').write_text(json.dumps(dict(
        source=source, disabled=args.transformation,
        candidateSha256=hashlib.sha256(candidate.encode()).hexdigest(),
        referenceSha256=hashlib.sha256(reference.encode()).hexdigest(),
        patchSha256=hashlib.sha256(patch).hexdigest()), indent=2) + '\n')


if __name__ == '__main__':
    main()
