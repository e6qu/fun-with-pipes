#!/usr/bin/env python3
"""Audit saved compiler-cost commands and retain observations on GitHub runners."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import zipfile

from github_records import records

sys.path.insert(0,str(Path('scripts').resolve()))
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument("--comparison", required=True, choices=("gradient-call", "packed-pair", "scalar-constant", "recording-lookup", 'recording-inline', 'recording-capacity', 'recording-context', 'tape-records'))
parser.add_argument("--repository", required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--run',required=True,type=int)
parser.add_argument('--machine',required=True,choices=('aarch64','x86_64'))
parser.add_argument('--output',required=True,type=Path)
args=parser.parse_args()
assert os.environ.get("GITHUB_ACTIONS") == "true", "large artifact processing belongs on GitHub"
assert re.fullmatch("[0-9a-f]{40}", args.source)
assert re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", args.repository)
source=args.source
run=args.run
machine=args.machine
runner,arch={'aarch64':('ubuntu-24.04-arm','ARM64'),'x86_64':('ubuntu-latest','X64')}[machine]
root = args.output
root.mkdir(exist_ok=True)
repo='repos/' + args.repository + '/'

def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences', repo + path])

def module(name):
    spec=importlib.util.spec_from_file_location(name,Path('scripts')/(name+'.py'))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

measure = module('measure-numeric-input-analysis')
check = module('check-array-list-evidence')
baseline = module('descent-baselines')
jobs=records(api, f'actions/runs/{run}/jobs', 'jobs')
job_name = ('tape_measurements / ' if args.comparison == 'tape-records' else '') + f'numeric_input_analysis ({runner})'
job,=[job for job in jobs if job['name'] == job_name]
assert job['head_sha']==source and job['status']=='completed' and job['run_id']==run
artifacts=records(api, f'actions/runs/{run}/artifacts', 'artifacts')
log=api(f"actions/jobs/{job['id']}/logs")
(root/(machine+'-job.log.gz')).write_bytes(gzip.compress(log,mtime=0))
clean=re.sub(rb'\x1b\[[0-?]*[ -/]*[@-~]',b'',log)
diagnostics=[line for line in clean.decode(errors='replace').splitlines() if re.search(r'warning:|error:(?!:)|error\[|Traceback|##\[error\]',line,re.I)]
failed_steps = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
if args.comparison in ('recording-context', 'tape-records') and failed_steps == [f'Qualify {args.comparison} compiler timing host']:
    assert job['conclusion'] == 'failure'
    host_artifact, = [item for item in artifacts if item['name'] == args.comparison + '-analysis-host-' + arch and not item['expired']]
    assert host_artifact['workflow_run']['head_sha'] == source
    host_zip = api('actions/artifacts/' + str(host_artifact['id']) + '/zip')
    assert 'sha256:' + hashlib.sha256(host_zip).hexdigest() == host_artifact['digest']
    host_path = root / (machine + '-rejected-host.zip')
    host_path.write_bytes(host_zip)
    with zipfile.ZipFile(host_path) as saved:
        assert saved.namelist() == ['compiler-cost-host.json']
        host = json.loads(saved.read('compiler-cost-host.json'))
    assert host['source'] == source and host['actual']['machine'] == machine
    assert host['qualified'] is False and host['failures']
    assert host['failures'] == baseline.host_failures(host['actual'], host['expected'])
    for name in ('Build candidate at production settings', 'Build and verify the selected same-source reference',
                 'Measure balanced compiler commands and peak memory'):
        step, = [step for step in job['steps'] if step['name'] == name]
        assert step['conclusion'] == 'skipped', step
    # The always-run uploader still retains preflight metadata. Verify that it
    # contains only that metadata, not a partial build or timing session.
    safety_artifact, = [item for item in artifacts if item['name'] == args.comparison + '-analysis-' + arch and not item['expired']]
    assert safety_artifact['workflow_run']['head_sha'] == source
    safety_zip = api('actions/artifacts/' + str(safety_artifact['id']) + '/zip')
    assert 'sha256:' + hashlib.sha256(safety_zip).hexdigest() == safety_artifact['digest']
    safety_path = root / (machine + '-rejected-preflight.zip')
    safety_path.write_bytes(safety_zip)
    with zipfile.ZipFile(safety_path) as saved:
        check.check_zip(saved)
        assert saved.namelist() and all(name.startswith('numeric-analysis-safety/') for name in saved.namelist())
    assert len(diagnostics) == 1 and '##[error]Process completed with exit code 1.' in diagnostics[0], diagnostics
    record = dict(source=source, run=run, job=job, artifact=host_artifact, safetyArtifact=safety_artifact,
                  qualification=host, expectedDiagnostics=diagnostics, complete=False,
                  decision='host-rejected-before-building-or-timing')
    (root / (machine + '-host-rejected.json')).write_text(json.dumps(record, indent=2) + '\n')
    print(machine, record['decision'], flush=True)
    sys.exit(0)
artifact,=[a for a in artifacts if a['name']==args.comparison+'-analysis-'+arch and not a['expired']]
assert artifact['workflow_run']['head_sha']==source
if args.comparison == 'tape-records':
    host_artifact, = [item for item in artifacts if item['name'] == 'tape-records-analysis-host-' + arch and not item['expired']]
    assert host_artifact['workflow_run']['head_sha'] == source
    host_bytes = api('actions/artifacts/' + str(host_artifact['id']) + '/zip')
    assert host_artifact['digest'] == 'sha256:' + check.digest(host_bytes)
    host_path = root / (machine + '-host.zip')
    host_path.write_bytes(host_bytes)
    with zipfile.ZipFile(host_path) as saved:
        assert saved.namelist() == ['compiler-cost-host.json']
        host = json.loads(saved.read('compiler-cost-host.json'))
    assert host['source'] == source and host['qualified'] and host['failures'] == []
    check.GROUPS.check_frozen_host(dict(machine=machine, qualification=host), 'tape-records')
    (root / (machine + '-host-artifact.json')).write_text(json.dumps(host_artifact, indent=2) + '\n')
path=root/(machine+'.zip')
if not path.exists():
    with path.with_suffix('.part').open('wb') as stream:subprocess.run(['gh','api','--allow-escape-sequences',repo+f"actions/artifacts/{artifact['id']}/zip"],stdout=stream,check=True)
    partial=path.with_suffix('.part')
    with partial.open('rb') as stream:assert artifact['digest']=='sha256:'+hashlib.file_digest(stream,'sha256').hexdigest()
    partial.rename(path)
with path.open('rb') as stream:assert artifact['digest']=='sha256:'+hashlib.file_digest(stream,'sha256').hexdigest()
assert str(artifact['id']).encode() in log, 'artifact not identified in original job log'
expected_diagnostics = []
if job['conclusion'] == 'failure':
    expected_diagnostics = diagnostics
else:
    assert not diagnostics,diagnostics
with zipfile.ZipFile(path) as z:
    check.check_zip(z)
    names = z.namelist()
    assert len(names) == len(set(names))
    if 'numeric-analysis/report.json' not in names or not json.loads(z.read('numeric-analysis/report.json'))['complete']:
        record=dict(source=source,run=run,job=job,artifact=artifact,diagnostics=diagnostics,complete=False,files={name:check.digest(z.read(name)) for name in names if not name.endswith('/')})
        (root/(machine+'-incomplete.json')).write_text(json.dumps(record,indent=2)+'\n')
        if 'numeric-analysis/report.json' in names:
            (root/(machine+'-incomplete-report.json.gz')).write_bytes(gzip.compress(z.read('numeric-analysis/report.json'),mtime=0))
        print(machine,'incomplete preparation/measurement retained; inspect job log and report',flush=True)
        sys.exit(1)
    report=json.loads(z.read('numeric-analysis/report.json'))
    assert report['source']==source and report['machine']==machine and report['complete'] and report['comparison']==args.comparison
    assert report['executionOverrides']==dict(FWP_LTO='0',LC_ALL='C',FWP_VRET='1',FWP_FRAME_FIELDS='1',FWP_PACKED_ARRAYS='1',FWP_STACK='1',FWP_ARRAY_FUSION='1',otherFWPSettings='removed')
    report_files={name.removeprefix('numeric-analysis/') for name in names if name.startswith('numeric-analysis/') and not name.endswith('/')}
    assert report_files==set(report['files'])|{'report.json'}
    for name,checksum in report['files'].items():
        with z.open('numeric-analysis/'+name) as stream:assert hashlib.file_digest(stream,'sha256').hexdigest()==checksum,name
    manifest=json.loads(z.read('numeric-analysis-reference/manifest.json'))
    assert manifest==report['referenceManifest'] and manifest['source']==source
    check.check_reference(zipfile.Path(z,'numeric-analysis-reference/'),dict(referenceCompiler=manifest),source,machine,args.comparison)
    assert manifest['compilerSha256']==report['compilerHashes']['reference']
    for copy in measure.COPIES:
        data=z.read('numeric-analysis/'+copy)
        assert check.digest(data)==report['compilerHashes']['candidate' if copy.startswith('candidate') else 'reference']
        check.instruction_bytes(data,machine)
    assert len(report['cases'])==7
    expected_inputs={name:subprocess.check_output(['git','show',source+':'+path]) for name,path in [('field-transfer','tests/fixtures/field_owner_transfer.fwp'),('autodiff-tutorial','docs/tutorials/20-autodiff-and-devices/main.fwp')]}
    assert subprocess.check_output(['git','show',source+':scripts/measure-ad-application.py'])==Path('scripts/measure-ad-application.py').read_bytes()
    expected_inputs.update({f'derivative-{d}-{u}':measure.COSTS.AD.program(d,u+1,False).encode() for d,u in ((3,0),(33,199),(129,199))})
    expected_inputs.update({name: value.encode() for name, value in measure.scoped_cost_inputs().items()})
    assert set(report['cases'])==set(expected_inputs)
    assert subprocess.check_output(['git','show',source+':scripts/measure-numeric-input-analysis.py'])==Path('scripts/measure-numeric-input-analysis.py').read_bytes()
    for kind, specialized in [('candidate', True), ('reference', True)]:
        rows=json.loads(z.read('numeric-analysis/preflight-'+kind+'/checks.json'))
        assert rows==report['preflight'][kind] and len(rows)==2
        for row in rows:
            assert row['returncode']==0 and 'failure' not in row
            base='numeric-analysis/preflight-'+kind+'/'+row['name']
            assert z.read(base+'.fwp')==expected_inputs[row['name']]
            assert z.read(base+'.stdout')==z.read(base+'.stderr')==b''
            assert z.read(base+'.status')==b'0\n'
            assert row['observed']==measure.scoped_cost_output(row['name'],z.read(base+'.c').decode(),specialized)
    for kind, selected in [('candidate', True), ('reference', True)]:
        base='numeric-analysis/consuming-'+kind+'/'
        record=json.loads(z.read(base+'record.json'))
        assert record==report['consumingPreflight'][kind] and record['returncode']==0
        assert z.read(base+'stdout')==z.read(base+'stderr')==b''
        assert record['sourceSha256']==check.digest(z.read(base+'input.fwp'))
        assert record['cSha256']==check.digest(z.read(base+'input.c'))
        assert record['observed']==measure.consuming_cost_output(z.read(base+'input.c').decode(),selected)
        expected_source=Path('tests/fixtures/owned_numeric_updates.fwp').read_text()
        expected_source+='\nexport retained : Array[I64] -> (Array[I64], List[I64]) ! {Async}\n'
        expected_source+='retained = fn input ->\n    let changed = array.map increment input\n    in (changed, array.to-list input)\n'
        assert z.read(base+'input.fwp').decode()==expected_source
    for name,case in report['cases'].items():
        assert measure.summarize(case['samples'])==case['summary']
        assert len(case['samples'])==48
        expected=[(round_number,copy) for round_number in range(-2,10) for copy in measure.ORDERS[round_number%2]]
        assert [(row['round'],row['copy']) for row in case['samples']]==expected
        base='numeric-analysis/'+name+'/'
        assert z.read(base+'program.fwp')==expected_inputs[name]
        assert check.digest(z.read(base+'program.fwp'))==report['inputs'][name]['sha256']
        if args.comparison == 'tape-records':
            preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-tape-records-reference.py'], text=True)
            frozen = subprocess.check_output(['git', 'show', source + ':scripts/fixtures/tape_column_reference.c'], text=True)
            expected = check.recorded_tape_reference({'runtime/fwp_rt_kernel.c': z.read(base + 'candidate1.c').decode()}, preparation, frozen)
            assert expected['runtime/fwp_rt_kernel.c'] == z.read(base + 'reference1.c').decode()
        for copy in measure.COPIES:
            if args.comparison == 'recording-inline':
                measure.RECORDING_SELECTION.check_inline_declaration(z.read(base + copy + '.c').decode(), copy.startswith('candidate'))
                if name in ('derivative-33-199', 'derivative-129-199'):
                    measure.RECORDING_SELECTION.check(z.read(base + copy + '.c').decode(), True)
            if args.comparison in ('recording-context', 'tape-records'):
                measure.RECORDING_SELECTION.check_capacity_gate(z.read(base + copy + '.c').decode(), True)
                if name in ('derivative-33-199', 'derivative-129-199'):
                    measure.CONTEXT_SELECTION.check(z.read(base + copy + '.c').decode(), args.comparison == 'tape-records' or copy.startswith('candidate'))
            if args.comparison == 'recording-capacity':
                measure.RECORDING_SELECTION.check_capacity_gate(z.read(base + copy + '.c').decode(), copy.startswith('candidate'))
                if name in ('derivative-33-199', 'derivative-129-199'):
                    measure.RECORDING_SELECTION.check(z.read(base + copy + '.c').decode(), True)
            if args.comparison == 'recording-lookup' and name in ('derivative-33-199', 'derivative-129-199'):
                measure.RECORDING_SELECTION.check(z.read(base + copy + '.c').decode(), copy.startswith('candidate'))
            if args.comparison == 'scalar-constant' and name in ('derivative-33-199', 'derivative-129-199'):
                measure.SCALAR_SELECTION.check(z.read(base+copy+'.c').decode(), 'literal' if copy.startswith('candidate') else 'cached')
            assert check.digest(z.read(base+copy+'.c'))==case['generatedCHashes']['candidate' if copy.startswith('candidate') else 'reference']
        for row in case['samples']:
            assert row['returncode']==0 and 'timeout' not in row
            command = row['command']
            assert command[1:3] == ['-v', '-o']
            assert command[5:10]==['build','--memory','dynamic','--emit-c','-O2'] and command[-2]=='-o'
            assert Path(command[4]).name==row['copy'] and Path(command[10]).name=='program.fwp'
            stem=f"{row['round']}-{row['copy']}"
            assert not z.read(base+stem+'.stdout') and not z.read(base+stem+'.stderr')
            resources=z.read(base+stem+'.resources.txt').decode()
            peak,=re.findall(r'Maximum resident set size \(kbytes\): (\d+)',resources)
            assert int(peak)==row['peakCommandKiB'] and 'Exit status: 0' in resources
        print(machine,name,'time ratio',round(case['summary']['candidateReferenceSeconds'],6),'RSS ratio',round(case['summary']['candidateReferencePeakRSS'],6),'failures',case['summary']['failures'],flush=True)
    failures={name:case['summary']['failures'] for name,case in report['cases'].items() if case['summary']['failures']}
    assert job['conclusion']==('failure' if failures else 'success')
    if failures:
        assert len(diagnostics)==3 and 'Traceback (most recent call last):' in diagnostics[0] and '##[error]Process completed with exit code 1.' in diagnostics[2], diagnostics
        assert ("AssertionError: " + repr(failures)) in diagnostics[1], 'unexpected failure diagnostic'
        failed_steps=[step['name'] for step in job['steps'] if step['conclusion']=='failure']
        assert failed_steps==['Measure balanced compiler commands and peak memory']
    (root/(machine+'-report.json.gz')).write_bytes(gzip.compress(z.read('numeric-analysis/report.json'),mtime=0))
    (root/(machine+'-reference.json')).write_bytes(z.read('numeric-analysis-reference/manifest.json'))
    record=dict(source=source,run=run,job=job,artifact=artifact,commands=336,untimedChecks=6,failures=failures,referenceVerified=True, expectedDiagnostics=expected_diagnostics)
    (root/(machine+'-audit.json')).write_text(json.dumps(record,indent=2)+'\n')
    print(machine,'all 336 scheduled commands and six untimed checks, source/reference files, images and measurements audited',flush=True)

    retained = {}
    with zipfile.ZipFile(root / (machine + '-records.zip'), 'w', zipfile.ZIP_DEFLATED) as bundle:
        for name in names:
            if name.endswith('/') or name in ['numeric-analysis/' + copy for copy in measure.COPIES] or name == 'numeric-analysis-reference/fwp':
                continue
            data = z.read(name)
            bundle.writestr(name, data)
            retained[name] = check.digest(data)
    (root / (machine + '-retained-files.json')).write_text(json.dumps(retained, indent=2) + '\n')
    print(machine, len(retained), 'observation files retained; compiler binaries remain in the original artifact', flush=True)
