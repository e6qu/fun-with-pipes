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
TESTED = 'b0ae00d5512df825271970cafcf569f52dbfc0cd'
RECOVERY = os.environ['FWP_RECOVERY_HEAD']
GC_HEAD = os.environ['FWP_GC_EVIDENCE_HEAD']
GC_RUN = int(os.environ['FWP_GC_EVIDENCE_RUN'])
PREP_RUN = 38130008122
PREP_DRIVER = 'cfcb70d16044915206c2e681a72618021ba0ea97'
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


ci = gate(38128387224, TESTED, NAMES)
docs = gate(38128387231, TESTED, {'roadmap_docs'})
prep_gate = gate(PREP_RUN, PREP_DRIVER, {'prepare'})
gc_gate = gate(GC_RUN, GC_HEAD, {'diagnostics'})
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
assert prep['base'] == TESTED and prep['branch'] == BRANCH
assert prep['includedRows'] == list(range(74, 113))
assert len(prep['originalCommits']) == len(prep['rebasedCommits']) == 85
prepared = prep['head']
assert git('rev-parse', 'origin/' + BRANCH) == prepared

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
                         '--onto', accepted, TESTED], cwd=wt,
                        env=dict(os.environ, GIT_EDITOR='true'), capture_output=True)
(OUT / 'rebase.stdout').write_bytes(result.stdout)
(OUT / 'rebase.stderr').write_bytes(result.stderr)
assert result.returncode == 0, 'Unexpected conflict: retain evidence and repair it'
rebased = git('rev-list', '--reverse', accepted + '..HEAD', cwd=wt).splitlines()
before = git('rev-list', '--reverse', TESTED + '..' + prepared).splitlines()
assert len(rebased) == len(before)
for old, new in zip(before, rebased):
    assert git('show', '-s', '--format=%s', old) == git('show', '-s', '--format=%s', new)
assert git('rev-parse', 'HEAD^{tree}', cwd=wt) == git('rev-parse', prepared + '^{tree}')

# Integrate only the tested harness and its GC artifact additions. In particular,
# preserve the new mandatory WASI environment and every existing test command.
(wt / 'tests/gc.rs').write_bytes(blob(GC_HEAD, 'tests/gc.rs'))
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
(wt / '.github/workflows/ci.yml').write_text(updated_ci)
assert set(git('diff', '--name-only', cwd=wt).splitlines()) == {
    'tests/gc.rs', '.github/workflows/ci.yml'}
git('add', 'tests/gc.rs', '.github/workflows/ci.yml', cwd=wt)
git('commit', '-m', 'Report GC compiler failures and preserve native diagnostics', cwd=wt)
for name in DOCS:
    (wt / name).write_bytes((accepted_wt / name).read_bytes())
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
              includedRows=prep['includedRows'], gcEvidence=gc_gate,
              preparationGate=prep_gate, recoveryHead=RECOVERY,
              sourceHashes={name: hashlib.sha256((wt / name).read_bytes()).hexdigest()
                            for name in DOCS + ['tests/gc.rs', '.github/workflows/ci.yml']},
              stage='Preparation only; publish one PR and require all exact-head production gates')
(OUT / 'finalization.json').write_text(json.dumps(record, indent=2) + '\n')
git('push', '--force-with-lease=refs/heads/' + BRANCH + ':' + prepared,
    'origin', 'HEAD:refs/heads/' + BRANCH, cwd=wt)
assert git('ls-remote', 'origin', 'refs/heads/' + BRANCH).split()[0] == head
print(head)
