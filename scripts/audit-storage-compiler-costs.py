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

sys.path.insert(0,str(Path('scripts').resolve()))
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument("--comparison", required=True, choices=("gradient-call", "packed-pair", "scalar-constant"))
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
pages=json.loads(subprocess.check_output(['gh','api','--paginate','--slurp',repo+f'actions/runs/{run}/jobs?per_page=100']))
job,=[job for page in pages for job in page['jobs'] if job['name']==f'numeric_input_analysis ({runner})']
assert job['head_sha']==source and job['status']=='completed' and job['run_id']==run
artifacts=json.loads(api(f'actions/runs/{run}/artifacts?per_page=100'))['artifacts']
artifact,=[a for a in artifacts if a['name']==args.comparison+'-analysis-'+arch and not a['expired']]
assert artifact['workflow_run']['head_sha']==source
path=root/(machine+'.zip')
if not path.exists():
    with path.with_suffix('.part').open('wb') as stream:subprocess.run(['gh','api','--allow-escape-sequences',repo+f"actions/artifacts/{artifact['id']}/zip"],stdout=stream,check=True)
    partial=path.with_suffix('.part')
    with partial.open('rb') as stream:assert artifact['digest']=='sha256:'+hashlib.file_digest(stream,'sha256').hexdigest()
    partial.rename(path)
with path.open('rb') as stream:assert artifact['digest']=='sha256:'+hashlib.file_digest(stream,'sha256').hexdigest()
log=api(f"actions/jobs/{job['id']}/logs")
(root/(machine+'-job.log.gz')).write_bytes(gzip.compress(log,mtime=0))
assert str(artifact['id']).encode() in log, 'artifact not identified in original job log'
clean=re.sub(rb'\x1b\[[0-?]*[ -/]*[@-~]',b'',log)
diagnostics=[line for line in clean.decode(errors='replace').splitlines() if re.search(r'warning:|error:(?!:)|error\[|Traceback|##\[error\]',line,re.I)]
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
        for copy in measure.COPIES:
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
