"""Integrate verified State source, format and audit the final ownership bundle."""
from pathlib import Path
import hashlib, json, os, subprocess
from export_prepared_commits import export_history

assert os.environ.get('GITHUB_ACTIONS') == 'true'
ROOT = Path.cwd()
OUT = ROOT / 'repair-evidence'
OUT.mkdir(exist_ok=True)
WT = ROOT.parent / 'pr124-combined-repair'
BASE = '9550aab94bf5cb2adb4f6a462381537d37ce3644'
STATE = 'ec1915e7386128352a792071701c16b076084e75'
PROFILE = 'ac7b518c5b1d80dd55c385728cdae5bbdde1f44e'
RECOVERY = os.environ['FWP_RECOVERY_HEAD']
BRANCH = 'ownership-resource-network-bundle'
NATIVE = ['src/cgen.rs', 'src/ownership.rs', 'runtime/fwp_rt.c',
          'runtime/fwp_rt_task.c', 'runtime/fwp_rt_prims.c']
DOCS = ['CONTRIBUTING.md', 'PLAN.md', 'docs/design.md', 'docs/development-state.md',
        'docs/ownership.md', 'docs/primitive-ownership.md', 'docs/roadmap-queue.md',
        'docs/roadmap-history.md', 'docs/reference.md', 'docs/concurrency.md', 'docs/numerics.md']
def git(*args, cwd=ROOT):
    return subprocess.check_output(['git', *args], cwd=cwd, text=True).strip()
def blob(head, name):
    return subprocess.check_output(['git', 'show', head + ':' + name], cwd=ROOT)
def gate(number, head, prefix):
    value = json.loads(subprocess.check_output(['gh', 'run', 'view', str(number), '--json',
        'headSha,status,conclusion,jobs,url'], text=True))
    assert value['headSha'] == head
    assert value['status'] == 'completed' and value['conclusion'] == 'success'
    assert {job['name'] for job in value['jobs']} == {
        prefix + ' (' + runner + ')' for runner in ['ubuntu-latest','macos-15','macos-15-intel']}
    assert all(job['status'] == 'completed' and job['conclusion'] == 'success' for job in value['jobs'])
    return value

state_gate = gate(38167118922, STATE, 'state')
profile_gate = gate(38166896486, PROFILE, 'allocations')
assert git('rev-parse', 'origin/' + BRANCH) == BASE
assert git('rev-parse', 'origin/main') == 'b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
assert git('rev-parse', 'origin/roadmap/handoff-pr123-20261011') == RECOVERY
assert json.loads(subprocess.check_output(['gh','pr','view','124','--json','headRefOid'],text=True))['headRefOid'] == BASE
# Allocation drivers change only test/administrative files: every compiler,
# runtime and library byte must equal the exact passing State source head.
source_names = [name for name in git('ls-tree','-r','--name-only',STATE).splitlines()
    if name.startswith(('src/','runtime/','lib/')) and name.endswith(('.rs','.c','.h','.S','.fwp'))]
for name in source_names:
    assert blob(STATE,name) == blob(PROFILE,name), name
profile_dir = OUT / 'allocation-reports'
subprocess.run(['gh','run','download','38166896486','--dir',str(profile_dir)],check=True)
reports = {}
for runner in ['ubuntu-latest','macos-15','macos-15-intel']:
    directory = profile_dir / ('typed-state-allocation-' + runner)
    assert (directory/'driver.txt').read_text().strip() == PROFILE
    measured = directory/'allocations'
    report = json.loads((measured/'comparison.json').read_text())
    assert report['baseline'] == BASE and report['candidate'] == PROFILE
    assert report['settings'] == dict(FWP_GC_STRESS='0',FWP_GC_VERIFY='1',FWP_REUSE_VERIFY='0')
    assert set(report['results']) == {'baseline-O1','baseline-O2','candidate-O1','candidate-O2'}
    for name, expected in report['sourceHashes'].items():
        assert Path(name).name == name
        assert hashlib.sha256((measured/name).read_bytes()).hexdigest() == expected
    for opt in ['-O1','-O2']:
        before = report['results']['baseline'+opt]
        after = report['results']['candidate'+opt]
        for value, head, label in [(before,BASE,'baseline'),(after,PROFILE,'candidate')]:
            assert value['head'] == head and value['opt'] == opt
            assert value['iterations'] == 4096 and value['collections'] >= 2
            assert value['managedCalls'] > 0 and value['peakRssKiB'] > 0
            assert value['valueSize'] == value['valueAlignment'] == 8
            assert label+'.measured.c' in report['sourceHashes'] and label+opt in report['sourceHashes']
        assert after['managedCalls'] <= before['managedCalls']
        assert after['managedRequestedBytes'] <= before['managedRequestedBytes']
        assert after['sharedCountClears'] < before['sharedCountClears']
        assert after['managedFreedBytes'] > before['managedFreedBytes']
    reports[runner] = report
subprocess.run(['git','worktree','add','--detach',str(WT),BASE],check=True)
recipe = json.loads(blob(STATE,'scripts/typed-state-ownership-patch.json'))
assert set(recipe) == set(NATIVE)
for name in NATIVE:
    source = (WT/name).read_text()
    for edit in recipe[name]:
        assert source.count(edit['old']) == 1, name
        source = source.replace(edit['old'],edit['new'],1)
    assert source.encode() == blob(STATE,name), name
    (WT/name).write_text(source)
fixtures = {
    'tests/typed_state_ownership.rs': (RECOVERY,'scripts/roadmap-recovery/typed-state-expanded-test.rs'),
    'tests/fixtures/typed_state_probe.c': (STATE,'tests/fixtures/typed_state_probe.c'),
    'scripts/check-roadmap.py': (RECOVERY,'scripts/check-roadmap.py'),
    'scripts/check-primitive-inventory.py': (RECOVERY,'scripts/roadmap-recovery/check-primitive-inventory-state.py'),
}
for name,(head,saved) in fixtures.items():
    (WT/name).write_bytes(blob(head,saved))
for name in DOCS:
    (WT/name).write_bytes(blob(RECOVERY,name))
subprocess.run(['rustfmt','src/cgen.rs','src/ownership.rs','tests/typed_state_ownership.rs'],cwd=WT,check=True)
env = dict(os.environ,CARGO_PROFILE_DEV_DEBUG='0',CARGO_PROFILE_TEST_DEBUG='0',CARGO_INCREMENTAL='0',RUST_TEST_THREADS='1')
subprocess.run(['cargo','build','--bin','fwp'],cwd=WT,env=env,check=True)
subprocess.run([str(WT/'target/debug/fwp'),'fmt','lib/autodiff.fwp'],cwd=WT,check=True)
subprocess.run([str(WT/'target/debug/fwp'),'fmt','--check','lib/autodiff.fwp'],cwd=WT,check=True)
subprocess.run(['cargo','fmt','--check'],cwd=WT,check=True)
# Check the library's formatting/faithfulness and reference before another full
# matrix, and exercise the newly added aggregate/escaping-closure State cases.
subprocess.run(['cargo','test','--test','fmt','--test','stdlib_doc','--test','typed_state_ownership','--','--nocapture'],cwd=WT,env=env,check=True)
subprocess.run(['python3','scripts/check-roadmap.py'],cwd=WT,check=True)
state_doc = WT/'docs/development-state.md'
state_doc.write_text(state_doc.read_text() + '\n## Combined repair prepared on GitHub\n\n'
    'This candidate integrates the passing typed State source, preserves all\n'
    'original resource tests and mandatory WASI, formats scoped autodiff and\n'
    'scopes the live-table documentation parser. Runner preflight verifies\n'
    'fwp/Rust formatting, formatting faithfulness, stdlib docs and expanded\n'
    'array/record/escaping-closure State controls. The current-head primitive\n'
    'inventory follows. Full six-job production CI and roadmap_docs remain\n'
    'mandatory before PR124 squash; earlier passes do not satisfy that gate.\n')
changed = set(NATIVE + list(fixtures) + DOCS + ['lib/autodiff.fwp'])
git('add',*sorted(changed),cwd=WT)
assert set(git('diff','--cached','--name-only',cwd=WT).splitlines()) <= changed
git('commit','-m','Own scoped State and repair library formatting and roadmap validation',cwd=WT)
head = git('rev-parse','HEAD',cwd=WT)
inventory = OUT/'primitive-inventory.json'
subprocess.run(['python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(inventory)],
    cwd=WT,env=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head),check=True)
inventory_report = json.loads(inventory.read_text())
assert inventory_report['head'] == head and inventory_report['status'] == 'Expected contract changes verified'
assert inventory_report['counts'] == dict(contract=153, runtime_or_specialization_review=191,
    flat_scalar_signature=11, ir_template=19)
assert inventory_report['reviewSymbols'] == 181
for name, expected in inventory_report['sourceHashes'].items():
    assert hashlib.sha256((WT/name).read_bytes()).hexdigest() == expected
old_counts = 'its expected153 contracts\nand191 review declarations are not verified counts yet.'
text = state_doc.read_text()
assert text.count(old_counts) == 1
state_doc.write_text(text.replace(old_counts,
    'the runner verifies153 contracts,191 review declarations/181 symbols,\n'
    '374 total declarations/364 symbols,40 aliases,19 IR combinators and11 flat\n'
    'signatures. Source classification does not establish tracing-free eligibility.'))
git('add','docs/development-state.md',cwd=WT)
git('commit','-m','Record the verified State inventory and combined runner checks',cwd=WT)
head = git('rev-parse','HEAD',cwd=WT)
subprocess.run(['python3','scripts/check-primitive-inventory.py','--baseline','tests/fixtures/primitive-inventory-baseline.json','--output',str(inventory)],
    cwd=WT,env=dict(env,FWP_INVENTORY_EXPECTED_HEAD=head),check=True)
inventory_report = json.loads(inventory.read_text())
assert inventory_report['head'] == head and inventory_report['status'] == 'Expected contract changes verified'
subprocess.run(['python3','scripts/check-roadmap.py'],cwd=WT,check=True)
assert not git('status','--porcelain',cwd=WT)
record = dict(base=BASE,previous=BASE,head=head,branch=BRANCH,stateEvidence=state_gate,
    allocationEvidence=profile_gate,allocationReports=reports,recoveryHead=RECOVERY,
    sourceHashes={name:hashlib.sha256((WT/name).read_bytes()).hexdigest() for name in changed},
    inventoryReport=inventory_report,
    stage='Combined runner repair preflight passed; exact-lease publication and full current-head matrix pending')
record['export'] = export_history(WT,BASE,head,OUT/'prepared-commits.json.gz')
record['tree'] = record['export']['tree']
(OUT/'repair.json').write_text(json.dumps(record,indent=2)+'\n')
print('Combined repair exported:',head,flush=True)
