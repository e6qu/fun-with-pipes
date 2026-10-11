"""Finalize the prepared bundle on GitHub after verified PR123 acceptance.

Draft only: publish its runner workflow after all prerequisite gates pass.
This publishes a preparation branch, never a PR or a merge.
"""
from pathlib import Path
import hashlib
import json
import os
import subprocess

ROOT = Path.cwd()
OUT = ROOT / 'finalization-evidence'
OUT.mkdir()
REPO = 'repos/e6qu/fun-with-pipes'
OLD = '68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'
PREP_BASE = 'b0ae00d5512df825271970cafcf569f52dbfc0cd'
TESTED = '9e7d0b24610524cf54125c44b47ee07185c0b7c3'
RECOVERY = os.environ['FWP_RECOVERY_HEAD']
GC_HEAD = os.environ['FWP_GC_EVIDENCE_HEAD']
GC_RUN = int(os.environ['FWP_GC_EVIDENCE_RUN'])
AD_HEAD = os.environ['FWP_AD_EVIDENCE_HEAD']
AD_RUN = int(os.environ['FWP_AD_EVIDENCE_RUN'])
SCOPE_HEAD = os.environ['FWP_SCOPE_EVIDENCE_HEAD']
SCOPE_RUN = int(os.environ['FWP_SCOPE_EVIDENCE_RUN'])
ALLOCATION_HEAD = os.environ['FWP_ALLOCATION_EVIDENCE_HEAD']
ALLOCATION_RUN = int(os.environ['FWP_ALLOCATION_EVIDENCE_RUN'])
AP_HEAD = os.environ['FWP_LIST_AP_EVIDENCE_HEAD']
AP_RUN = int(os.environ['FWP_LIST_AP_EVIDENCE_RUN'])
PREP_RUN = 38140923130
PREP_DRIVER = '82c7bc7509c04b9e94004c06b02d83d665539ac6'
BRANCH = 'ownership-resource-network-bundle'
DOCS = ['CONTRIBUTING.md', 'PLAN.md', 'docs/design.md',
        'docs/development-state.md', 'docs/ownership.md',
        'docs/primitive-ownership.md', 'docs/roadmap-queue.md',
        'docs/roadmap-history.md', 'docs/reference.md',
        'docs/concurrency.md', 'docs/numerics.md']
NAMES = {'test', 'bench', 'macos (macos-15)', 'macos (macos-15-intel)',
         'macos_gc (macos-15)', 'macos_gc (macos-15-intel)'}


def command(*args, cwd=ROOT):
    return subprocess.check_output(list(args), cwd=cwd, text=True).strip()


def git(*args, cwd=ROOT):
    return command('git', *args, cwd=cwd)


def blob(revision, name):
    return subprocess.check_output(['git', 'show', revision + ':' + name], cwd=ROOT)


def gate(number, head, names):
    result = json.loads(command('gh', 'run', 'view', str(number), '--json',
                                'headSha,status,conclusion,jobs,url'))
    assert result['headSha'] == head, result
    assert result['status'] == 'completed' and result['conclusion'] == 'success', result
    assert len(result['jobs']) == len(names)
    assert {job['name'] for job in result['jobs']} == names
    assert all(job['status'] == 'completed' and job['conclusion'] == 'success'
               for job in result['jobs'])
    return result


ci = gate(38138731040, TESTED, NAMES)
docs = gate(38138731036, TESTED, {'roadmap_docs'})
prep_gate = gate(PREP_RUN, PREP_DRIVER, {'prepare'})
gc_gate = gate(GC_RUN, GC_HEAD, {'diagnostics'})
ad_gate = gate(AD_RUN, AD_HEAD, {'tapes (ubuntu-latest)', 'tapes (macos-15)', 'tapes (macos-15-intel)'})
scope_gate = gate(SCOPE_RUN, SCOPE_HEAD, {'scopes (ubuntu-latest)', 'scopes (macos-15)', 'scopes (macos-15-intel)'})
allocation_gate = gate(ALLOCATION_RUN, ALLOCATION_HEAD,
    {'allocations (ubuntu-latest)', 'allocations (macos-15)', 'allocations (macos-15-intel)'})
allocation_artifacts = OUT / 'allocations'
subprocess.run(['gh', 'run', 'download', str(ALLOCATION_RUN), '--pattern',
                'scope-allocations-*', '--dir', str(allocation_artifacts)], check=True)
allocation_reports = {}
for platform in ['ubuntu-latest', 'macos-15', 'macos-15-intel']:
    directory = allocation_artifacts / ('scope-allocations-' + platform)
    assert (directory / 'driver.txt').read_text().strip() == ALLOCATION_HEAD
    report = json.loads((directory / 'comparison.json').read_text())
    assert report['baseline'] == AD_HEAD and report['candidate'] == SCOPE_HEAD
    assert set(report['results']) == {'baseline-O1', 'baseline-O2', 'candidate-O1', 'candidate-O2'}
    for name, expected_hash in report['sourceHashes'].items():
        assert Path(name).name == name
        assert hashlib.sha256((directory / name).read_bytes()).hexdigest() == expected_hash
    for opt in ['-O1', '-O2']:
        before, after = report['results']['baseline' + opt], report['results']['candidate' + opt]
        for label, measured, head in [('baseline', before, AD_HEAD), ('candidate', after, SCOPE_HEAD)]:
            assert measured['head'] == head and measured['opt'] == opt
            assert measured['iterations'] == 4096 and measured['collections'] >= 2
            assert measured['managedCalls'] > 0 and measured['externalCalls'] == 5 * 4096
            assert measured['externalLiveBytes'] == measured['tapeSize']
            assert label + '.measured.c' in report['sourceHashes']
            assert label + opt in report['sourceHashes']
        assert after['managedCalls'] <= before['managedCalls']
        assert after['managedRequestedBytes'] <= before['managedRequestedBytes']
        assert after['externalCalls'] == before['externalCalls']
        assert after['externalRequestedBytes'] == before['externalRequestedBytes']
    allocation_reports[platform] = report
ap_gate = gate(AP_RUN, AP_HEAD, {'applicative (ubuntu-latest)', 'applicative (macos-15)', 'applicative (macos-15-intel)'})
# Require equivalent managed allocation and reclamation evidence as well as
# native lifetime controls; a source-level owner alone is not allocation proof.
ap_artifacts = OUT / 'list-callbacks'
subprocess.run(['gh', 'run', 'download', str(AP_RUN), '--pattern',
                'list-applicative-*', '--dir', str(ap_artifacts)], check=True)
ap_reports = {}
for platform in ['ubuntu-latest', 'macos-15', 'macos-15-intel']:
    directory = ap_artifacts / ('list-applicative-' + platform)
    assert (directory / 'head.txt').read_text().strip() == AP_HEAD
    measured_dir = directory / 'allocations'
    report = json.loads((measured_dir / 'comparison.json').read_text())
    assert report['baseline'] == TESTED and report['candidate'] == AP_HEAD
    assert report['settings'] == dict(FWP_GC_STRESS='0', FWP_GC_VERIFY='1', FWP_REUSE_VERIFY='0')
    assert set(report['results']) == {'baseline-O1', 'baseline-O2', 'candidate-O1', 'candidate-O2'}
    for name, expected_hash in report['sourceHashes'].items():
        assert Path(name).name == name
        assert hashlib.sha256((measured_dir / name).read_bytes()).hexdigest() == expected_hash
    for opt in ['-O1', '-O2']:
        before, after = report['results']['baseline' + opt], report['results']['candidate' + opt]
        for label, measured, head in [('baseline', before, TESTED), ('candidate', after, AP_HEAD)]:
            assert measured['head'] == head and measured['opt'] == opt
            assert measured['iterations'] == 2048 and measured['collections'] >= 2
            assert measured['managedCalls'] > 0 and measured['peakRssKiB'] > 0
            assert measured['valueSize'] == measured['valueAlignment'] == 8
            assert label + '.measured.c' in report['sourceHashes']
            assert label + opt in report['sourceHashes']
        assert after['managedCalls'] <= before['managedCalls']
        assert after['managedRequestedBytes'] <= before['managedRequestedBytes']
        assert after['sharedCountClears'] < before['sharedCountClears']
        assert after['managedFreedBytes'] > before['managedFreedBytes']
    ap_reports[platform] = report
post = json.loads(command('gh', 'api', REPO + '/pulls/123'))
assert post['merged'] and post['head']['sha'] == TESTED
assert post['base']['sha'] == OLD
accepted = post['merge_commit_sha']
assert git('rev-parse', 'origin/main') == accepted
assert all(job['completedAt'] <= post['merged_at']
           for result in (ci, docs) for job in result['jobs'])
raw = subprocess.check_output(['git', 'cat-file', 'commit', accepted], cwd=ROOT)
headers, message = raw.split(b'\n\n', 1)
subject = message.decode().rstrip('\n')
expected = 'Own library file and raw-memory resource lifetimes'
assert subject in {expected, expected + ' (#123)'} and len(subject) <= 80
assert message in {subject.encode(), subject.encode() + b'\n'}
assert [line[7:].decode() for line in headers.splitlines()
        if line.startswith(b'parent ')] == [OLD]
tree = git('rev-parse', accepted + '^{tree}')
assert tree == git('rev-parse', TESTED + '^{tree}')
proof = dict(sha=accepted, mergedAt=post['merged_at'], subject=subject,
             message=message.decode(), characters=len(subject), tree=tree,
             acceptedHead=TESTED, parents=[OLD])
(OUT / 'fwp-pr123-merge-proof.json').write_text(json.dumps(proof, indent=2) + '\n')
(OUT / 'fwp-pr123-final-gate-proof.json').write_text(
    json.dumps(dict(ci=ci, docs=docs), indent=2) + '\n')

# Obtain the immutable preparation proof, rather than trusting a branch name.
artifact = OUT / 'preparation'
subprocess.run(['gh', 'run', 'download', str(PREP_RUN), '--name',
                'resource-network-preparation', '--dir', str(artifact)], check=True)
prep = json.loads((artifact / 'preparation.json').read_text())
assert prep['base'] == PREP_BASE and prep['branch'] == BRANCH
assert prep['includedRows'] == list(range(74, 113))
assert len(prep['originalCommits']) == len(prep['rebasedCommits']) == 85
prepared = os.environ['FWP_PREPARATION_HEAD']
assert git('rev-parse', 'origin/' + BRANCH) == prepared
assert git('rev-parse', prepared + '^{tree}') == prep['tree']
assert len(git('rev-list', PREP_BASE + '..' + prepared).splitlines()) == prep['export']['commits']
# Publication may normalize metadata; every complete snapshot tree is retained.
for original, published in zip(prep['originalCommits'], git('rev-list', '--reverse', PREP_BASE + '..' + prepared).splitlines()):
    assert git('show', '-s', '--format=%s', original) == git('show', '-s', '--format=%s', published)

# Apply the reviewed acceptance updater on an actual-squash worktree first.
accepted_wt = ROOT.parent / 'accepted-main'
git('worktree', 'add', '--detach', str(accepted_wt), accepted)
backup = OUT / 'fwp-main-docs-pre123'
backup.mkdir()
protected_hashes = {}
for name in DOCS:
    data = blob(RECOVERY, name)
    saved = backup / name
    saved.parent.mkdir(parents=True, exist_ok=True)
    saved.write_bytes(data)
    protected_hashes[name] = hashlib.sha256(data).hexdigest()
    (accepted_wt / name).write_bytes(data)
    assert (accepted_wt / name).read_bytes() == saved.read_bytes()
(backup / 'sha256.json').write_text(json.dumps(protected_hashes, indent=2) + '\n')
(backup / 'metadata.json').write_text(json.dumps(dict(
    recoveryHead=RECOVERY, acceptedHead=TESTED, squash=accepted,
    scope='GitHub runner acceptance snapshot; local main is unchanged'), indent=2) + '\n')
updater = blob(RECOVERY, 'scripts/roadmap-recovery/record-pr123-acceptance.py').decode()
assert updater.count("ROOT = Path('/Users/zardoz/projects/fun-with-pipes')") == 1
updater = updater.replace("ROOT = Path('/Users/zardoz/projects/fun-with-pipes')",
                          'ROOT = Path(' + repr(str(accepted_wt)) + ')')
updater = updater.replace('/private/tmp/', str(OUT) + '/')
update_path = OUT / 'record-acceptance.py'
update_path.write_text(updater)
subprocess.run(['python3', str(update_path)], check=True)
state_path = accepted_wt / 'docs/development-state.md'
state = state_path.read_text()
assert 'Main is `' + accepted + '` (PR #123)' in state
state = state.replace('All11 live docs are protected', 'All11 runner docs are protected', 1)
state = state.replace('and restored byte-for-byte.',
                      'and restored byte-for-byte before recording acceptance. Local main\n'
                      'remains unchanged while the disk guard refuses its protected update.', 1)
state_path.write_text(state)

# Rebase only the verified preparation onto the tree-identical squash.
wt = ROOT.parent / 'final-resource-network'
git('worktree', 'add', '--detach', str(wt), prepared)
result = subprocess.run(['git', 'rebase', '--reapply-cherry-picks', '--empty=keep',
                         '--onto', accepted, PREP_BASE], cwd=wt,
                        env=dict(os.environ, GIT_EDITOR='true'), capture_output=True)
(OUT / 'rebase.stdout').write_bytes(result.stdout)
(OUT / 'rebase.stderr').write_bytes(result.stderr)
assert result.returncode == 0, 'Unexpected conflict: retain evidence and repair it'
rebased = git('rev-list', '--reverse', accepted + '..HEAD', cwd=wt).splitlines()
before = git('rev-list', '--reverse', PREP_BASE + '..' + prepared).splitlines()
assert len(rebased) == len(before)
for old, new in zip(before, rebased):
    assert git('show', '-s', '--format=%s', old) == git('show', '-s', '--format=%s', new)
# The sole accepted tree change after preparation is generated stdlib docs.
assert git('diff', '--name-only', prepared, 'HEAD', cwd=wt).splitlines() == ['docs/stdlib.md']
assert (wt / 'docs/stdlib.md').read_bytes() == blob(TESTED, 'docs/stdlib.md')
assert git('diff', '--name-only', PREP_BASE, TESTED).splitlines() == ['docs/stdlib.md']

# Integrate only the tested harness and its GC artifact additions. In particular,
# preserve the new mandatory WASI environment and every existing test command.
(wt / 'tests/gc.rs').write_bytes(blob(GC_HEAD, 'tests/gc.rs'))
(wt / 'tests/compiler_diagnostics.rs').write_bytes(blob(GC_HEAD, 'tests/compiler_diagnostics.rs'))
(wt / 'tests/cache_lifetime.rs').write_bytes(blob(GC_HEAD, 'tests/cache_lifetime.rs'))
# Applying the tested transforms preserves the later resource/network changes
# in these files; copying the older evidence branch's entire files would not.
compiler_patch = blob(GC_HEAD, 'scripts/compiler-diagnostics-patch.json')
compiler_edits = json.loads(compiler_patch)
assert set(compiler_edits) == {'src/cgen.rs', 'src/ffi_interp.rs', 'src/aot.rs'}
for name, edits in compiler_edits.items():
    evidence_source = blob(TESTED, name).decode()
    for edit in edits:
        assert evidence_source.count(edit['old']) == 1, (name, edit['old'])
        evidence_source = evidence_source.replace(edit['old'], edit['new'])
    assert evidence_source.encode() == blob(GC_HEAD, name), (
        name, 'Compiler recipe must match the exact tested and formatted evidence source')
    source = (wt / name).read_text()
    for edit in edits:
        assert source.count(edit['old']) == 1, (name, edit['old'])
        source = source.replace(edit['old'], edit['new'])
    (wt / name).write_text(source)
original_ci = (wt / '.github/workflows/ci.yml').read_text()
assert 'FWP_REQUIRE_WASM_RESOURCE_COUNTS: "1"' in original_ci
draft_ci = blob(RECOVERY, 'scripts/roadmap-recovery/gc-diagnostics-ci-draft.yml').decode()
start = draft_ci.index('      - name: Preserve failed GC stress binaries, C and statuses')
end = draft_ci.index('\n  test:', start)
addition = draft_ci[start:end]
anchor = ('      - name: Full GC stress and verification golden suite\n'
          '        run: cargo test --test gc golden_programs_under_gc_stress -- --exact --nocapture\n')
assert original_ci.count(anchor) == 1 and addition not in original_ci
updated_ci = original_ci.replace(anchor, anchor + addition, 1)
assert updated_ci.replace(addition, '', 1) == original_ci
# Fail on stale generated docs before the expensive Cargo gates, using the
# actual generator test rather than a second implementation of its rules.
preflight = (
    '      - name: Generated standard-library docs preflight\n'
    '        run: |\n'
    '          CARGO_MANIFEST_DIR="$PWD" rustc --test tests/stdlib_doc.rs -o "$RUNNER_TEMP/fwp-stdlib-doc-check"\n'
    '          env -u FWP_BLESS "$RUNNER_TEMP/fwp-stdlib-doc-check" --exact stdlib_doc_is_current\n')
assert updated_ci.count('      - name: fmt\n') == 2
updated_ci = updated_ci.replace('      - name: fmt\n', preflight + '      - name: fmt\n')
assert updated_ci.count('      - name: Full GC stress and verification golden suite\n') == 1
updated_ci = updated_ci.replace('      - name: Full GC stress and verification golden suite\n',
                               preflight + '      - name: Full GC stress and verification golden suite\n')
assert updated_ci.count('      - name: benchmarks against C and Rust (docs/benchmarks.md)\n') == 1
updated_ci = updated_ci.replace('      - name: benchmarks against C and Rust (docs/benchmarks.md)\n',
                               preflight + '      - name: benchmarks against C and Rust (docs/benchmarks.md)\n')
assert updated_ci.count(preflight) == 4
assert updated_ci.replace(preflight, '').replace(addition, '', 1) == original_ci
(wt / '.github/workflows/ci.yml').write_text(updated_ci)
# Preserve all later device changes when adding the independently checked AD repair.
ad_patch = blob(AD_HEAD, 'scripts/ad-ownership-patch.json')
ad_edits = json.loads(ad_patch)
assert set(ad_edits) == {'src/numerics.rs', 'runtime/fwp_rt_kernel.c'}
for name, edits in ad_edits.items():
    evidence_source = blob(PREP_BASE, name).decode()
    source = (wt / name).read_text()
    for edit in edits:
        assert evidence_source.count(edit['old']) == source.count(edit['old']) == 1, name
        evidence_source = evidence_source.replace(edit['old'], edit['new'])
        source = source.replace(edit['old'], edit['new'])
    assert evidence_source.encode() == blob(AD_HEAD, name), name
    (wt / name).write_text(source)
for name in ['tests/ad_tape_ownership.rs', 'tests/fixtures/ad_unwind_probe.c']:
    (wt / name).parent.mkdir(parents=True, exist_ok=True)
    (wt / name).write_bytes(blob(AD_HEAD, name))
# Add the checked gradient scope without copying older whole native files.
scope_patch = blob(SCOPE_HEAD, 'scripts/ad-scope-patch.json')
scope_edits = json.loads(scope_patch)
assert set(scope_edits) == {'src/numerics.rs', 'src/interp.rs', 'src/ownership.rs',
                            'src/cgen.rs', 'lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c'}
for name, edits in scope_edits.items():
    evidence_source = blob(AD_HEAD, name).decode()
    source = (wt / name).read_text()
    for edit in edits:
        assert evidence_source.count(edit['old']) == source.count(edit['old']) == 1, name
        evidence_source = evidence_source.replace(edit['old'], edit['new'])
        source = source.replace(edit['old'], edit['new'])
    assert evidence_source.encode() == blob(SCOPE_HEAD, name), name
    (wt / name).write_text(source)
for name in ['tests/ad_tape_scopes.rs', 'tests/fixtures/ad_scope_probe.c']:
    (wt / name).parent.mkdir(parents=True, exist_ok=True)
    (wt / name).write_bytes(blob(SCOPE_HEAD, name))
# Add owned Cartesian-product callbacks without replacing later native files.
ap_patch = blob(AP_HEAD, 'scripts/list-ap-ownership-patch.json')
ap_edits = json.loads(ap_patch)
assert set(ap_edits) == {'src/cgen.rs', 'src/ownership.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_gc.c'}
for name, edits in ap_edits.items():
    evidence_source = blob(TESTED, name).decode()
    source = (wt / name).read_text()
    for edit in edits:
        assert evidence_source.count(edit['old']) == source.count(edit['old']) == 1, name
        evidence_source = evidence_source.replace(edit['old'], edit['new'])
        source = source.replace(edit['old'], edit['new'])
    assert evidence_source.encode() == blob(AP_HEAD, name), name
    (wt / name).write_text(source)
for name in ['tests/list_applicative_ownership.rs', 'tests/fixtures/list_ap_probe.c', 'tests/fixtures/closure_drop_probe.c']:
    (wt / name).parent.mkdir(parents=True, exist_ok=True)
    (wt / name).write_bytes(blob(AP_HEAD, name))
repair_files = ['tests/gc.rs', 'tests/compiler_diagnostics.rs', 'tests/cache_lifetime.rs',
                'src/cgen.rs', 'src/ffi_interp.rs', 'src/aot.rs', '.github/workflows/ci.yml',
                'src/numerics.rs', 'runtime/fwp_rt_kernel.c', 'tests/ad_tape_ownership.rs',
                'tests/fixtures/ad_unwind_probe.c', 'src/interp.rs', 'src/ownership.rs',
                'lib/autodiff.fwp', 'tests/ad_tape_scopes.rs', 'tests/fixtures/ad_scope_probe.c']
repair_files += ['runtime/fwp_rt_prims.c', 'runtime/fwp_rt_gc.c', 'tests/list_applicative_ownership.rs', 'tests/fixtures/list_ap_probe.c', 'tests/fixtures/closure_drop_probe.c']
# Runner formatting makes the final candidate reviewable; full exact-head CI
# verifies these candidate bytes rather than transferring older evidence gates.
subprocess.run(['rustfmt', *[name for name in repair_files if name.endswith('.rs')]],
               cwd=wt, check=True)
git('add', *repair_files, cwd=wt)
assert set(git('diff', '--cached', '--name-only', cwd=wt).splitlines()) == set(repair_files)
git('commit', '-m', 'Protect autodiff buffers and cached executable lifetimes', cwd=wt)
for name in DOCS:
    (wt / name).write_bytes((accepted_wt / name).read_bytes())
reference = wt / 'docs/reference.md'
reference_text = reference.read_text()
cache_row = '| `FWP_CACHE_MAX` | how many executables it keeps, the least recently used going first (256) |'
assert reference_text.count(cache_row) == 1
reference.write_text(reference_text.replace(cache_row,
    '| `FWP_CACHE_MAX` | how many executables it keeps (256; minimum 1, including when set to 0); pruning preserves the current executable |'))
git('add', *DOCS, cwd=wt)
git('commit', '-m', 'Record accepted library ownership and the resource network bundle', cwd=wt)
subprocess.run(['python3', 'scripts/check-roadmap.py'], cwd=wt, check=True)
head = git('rev-parse', 'HEAD', cwd=wt)
assert not git('status', '--porcelain', cwd=wt)
for revision in git('rev-list', accepted + '..HEAD', cwd=wt).splitlines():
    text = git('show', '-s', '--format=%B', revision)
    assert len(text.splitlines()) == 1 and len(text) <= 80
    assert not any(term in text.lower() for term in
                   ('co-authored', 'authored-by', 'authored by', 'ai attribution'))
record = dict(base=accepted, head=head, previous=prepared, branch=BRANCH,
              originalCommits=prep['originalCommits'], rebasedCommits=rebased,
              includedRows=prep['includedRows'], gcEvidence=gc_gate, adEvidence=ad_gate,
              scopeEvidence=scope_gate, allocationEvidence=allocation_gate,
              allocationReports=allocation_reports, applicativeEvidence=ap_gate,
              applicativeAllocationReports=ap_reports,
              applicativePatchHash=hashlib.sha256(ap_patch).hexdigest(), scopePatchHash=hashlib.sha256(scope_patch).hexdigest(),
              adPatchHash=hashlib.sha256(ad_patch).hexdigest(),
              preparationGate=prep_gate, recoveryHead=RECOVERY,
              compilerPatchHash=hashlib.sha256(compiler_patch).hexdigest(),
              sourceHashes={name: hashlib.sha256((wt / name).read_bytes()).hexdigest()
                            for name in DOCS + repair_files},
              stage='Verified runner finalization exported; authorized exact-lease publication and full production CI pending')
from export_prepared_commits import export_history
record['export'] = export_history(wt, accepted, head, OUT / 'prepared-commits.json.gz')
record['tree'] = record['export']['tree']
(OUT / 'finalization.json').write_text(json.dumps(record, indent=2) + '\n')
print('Verified finalization exported for authorized exact-lease publication: ' + head)
