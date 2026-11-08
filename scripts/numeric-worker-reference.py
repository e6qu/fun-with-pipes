"""Record the frozen pre-worker compiler used only for measurement."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

BASELINE = 'f1cc94cf4e013369cccb8a836bd745f41e5d757c'
SOURCE_PATH = 'src/cgen/numeric_parameters.rs'
NATIVE_PATHS = ['src', 'runtime', 'lib', 'vendor', 'build.rs', 'Cargo.toml', 'Cargo.lock']
ROOT = Path(__file__).resolve().parents[1]


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    baseline = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=args.checkout, text=True).strip()
    assert baseline == BASELINE
    for directory in [ROOT, args.checkout]:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD', '--', *NATIVE_PATHS], cwd=directory, check=True)
    changed = subprocess.check_output(['git', 'diff', '--name-only', BASELINE, source, '--', *NATIVE_PATHS], cwd=ROOT, text=True)
    assert changed.splitlines() == [SOURCE_PATH], changed
    previous = subprocess.check_output(['git', 'show', BASELINE + ':' + SOURCE_PATH], cwd=ROOT)
    assert (args.checkout / SOURCE_PATH).read_bytes() == previous
    args.output.mkdir(parents=True, exist_ok=False)
    shutil.copy2(args.compiler, args.output / 'fwp')
    (args.output / 'numeric_parameters.rs').write_bytes(previous)
    manifest = dict(source=source, referenceSource=BASELINE, changedNativeFiles=[SOURCE_PATH],
                    candidateSha256=digest((ROOT / SOURCE_PATH).read_bytes()),
                    referenceSha256=digest(previous), compilerSha256=digest(args.compiler.read_bytes()))
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
