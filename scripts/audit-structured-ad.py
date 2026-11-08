#!/usr/bin/env python3
"""Reconstruct all structured-gradient observations and verify native images."""
import argparse
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import subprocess

from structured_ad_costs import ROOT, cases, driver, entry_and_drops, expected, program, raw_program
from structured_ad_observations import check_reports, instrument, stack_report
from structured_ad_statistics import order, summarize

SPEC = importlib.util.spec_from_file_location('resource_reports', ROOT / 'scripts/observe-array-costs.py')
RESOURCES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RESOURCES)


def native_hash(path, machine):
    data = path.read_bytes()
    assert len(data) >= 64 and data[:6] == b'\x7fELF\x02\x01'
    assert int.from_bytes(data[18:20], 'little') == {'aarch64':183, 'x86_64':62}[machine]
    return hashlib.sha256(data).hexdigest()


def audit(directory, compiler, cc, source, machine, session):
    identity = json.loads((directory / 'identity.json').read_text())
    assert identity['source'] == source and identity['machine'] == machine and identity['session'] == session
    assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip() == source
    assert identity['compilerSha256'] == native_hash(compiler,machine)
    assert identity['ccVersion'] == subprocess.check_output([cc,'--version'],text=True)
    assert identity['rustVersion'] == subprocess.check_output(['rustc','-Vv'],text=True)
    assert identity['compilerBuildSettings'] == dict(CARGO_PROFILE_DEV_OPT_LEVEL='1',
        CARGO_PROFILE_DEV_DEBUG_ASSERTIONS='true', CARGO_PROFILE_DEV_OVERFLOW_CHECKS='true')
    flags=['-O2','-std=gnu11','-ffp-contract=off','-fno-fast-math','-fno-lto',
           '-march='+{'aarch64':'armv8-a','x86_64':'x86-64'}[machine],'-fstack-usage']
    assert identity['flags'] == flags and identity['stackLimitBytes'] == 64*1024*1024
    cpus=identity['availableCpus']
    assert len(cpus)>=4 and cpus == sorted(set(cpus)) and identity['timingCpu'] == cpus[0]
    assert identity['model'] == next(row['data'] for row in identity['host']['lscpu'] if row['field']=='Model name:')
    settings=dict(FWP_LTO='0',FWP_STACK='1',FWP_ARRAY_FUSION='1',FWP_PACKED_ARRAYS='1',
                  FWP_VRET='1',FWP_FRAME_FIELDS='1',FWP_AD_WORKSPACE='1')
    assert identity['settings'] == settings
    rows=[json.loads(line) for line in (directory/'commands.jsonl').read_text().splitlines()]
    commands={row['output']:row for row in rows}
    assert len(commands)==len(rows)
    consumed=set()

    def command(relative, arguments, observed, pinned, expected_settings, profile):
        row=commands[relative]; consumed.add(relative)
        assert row['status']==0 and row['timedOut'] is False and row['settings']==expected_settings
        assert type(row['elapsedNs']) is int and row['elapsedNs']>0
        path=directory/relative
        wanted=list(map(str,arguments))
        if pinned:
            wanted=['taskset','--cpu-list',str(identity['timingCpu']),*wanted]
        cost=dict(elapsedNs=row['elapsedNs'])
        if observed:
            wanted=['/usr/bin/time','-v','-o',str(path.with_suffix('.resources')),*wanted]
            cost.update(RESOURCES.resources(path.with_suffix('.resources').read_text()))
            assert all(value>=0 for value in cost.values())
        assert row['command']==wanted,(relative,row['command'],wanted)
        stderr=path.with_suffix('.stderr').read_bytes()
        if not profile:
            assert not stderr,(relative,stderr)
        return path.with_suffix('.stdout').read_bytes(),stderr,cost

    def observation(raw):
        value=json.loads(raw)
        assert set(value)=={'constructionNs','computationNs','releaseNs','loopNs','checksum',
                            'retainedManagedBytesAfterCall','initialLiveBytes','finalLiveBytes'}
        assert all(type(number) is int and number>=0 for number in value.values())
        assert value['initialLiveBytes']==value['finalLiveBytes']
        assert value['loopNs']>=value['constructionNs']+value['computationNs']+value['releaseNs']
        return value

    summary={}; observations={}
    for case in cases():
        name=case['name']; path=directory/name
        assert json.loads((path/'case.json').read_text())==dict(case,methods=list(case['methods']))
        assert json.loads((path/'expected.json').read_text())==expected(case['family'],case['count'])
        hashes={role:native_hash(path/role,machine) for role in order(case['methods'],0)}
        checks={}
        for method in case['methods']:
            prefix=name+'/'+method
            assert hashes[method]==hashes[method+'-copy']
            assert (path/(method+'.fwp')).read_text()==program(case['family'],method)
            if case['count']<=3:
                raw_file=path/(method+'-raw.fwp')
                assert raw_file.read_text()==raw_program(case,method)
                raw,_,_=command(prefix+'-interpreter',[compiler,'run','--interp',raw_file],False,False,
                                dict(settings,FWP_NO_OPT='1'),False)
                values=json.loads(raw); oracle=expected(case['family'],case['count'])
                assert len(values)==len(oracle)
                assert all(math.isfinite(a) and abs(a-b)<=1e-10+1e-10*abs(b) for a,b in zip(values,oracle))
            emitted=path/(method+'-generated.c')
            raw,_,_=command(prefix+'-emit',[compiler,'build','--fn','measure','--emit-c','-O2',
                path/(method+'.fwp'),'-o',emitted],False,False,settings,False)
            assert not raw
            assert (path/(method+'.c')).read_text()==driver(emitted.read_text(),case)
            raw,_,_=command(prefix+'-build',[cc,*flags,path/(method+'.c'),'-o',path/method,
                                           '-lm','-lpthread','-ldl'],False,False,settings,False)
            assert not raw
            raw,_,_=command(prefix+'-check',[path/method,case['count']],False,True,settings,False)
            checks[method]=observation(raw)
            stack_report((path/(method+'.su')).read_text(),entry_and_drops(emitted.read_text())[0])
        samples=[json.loads(line) for line in (path/'samples.jsonl').read_text().splitlines()]
        assert [(row['round'],row['role']) for row in samples]==[
            (number,role) for number in range(-2,24) for role in order(case['methods'],number)]
        for row in samples:
            raw,_,cost=command(f"{name}/round-{row['round']}-{row['role']}",
                [path/row['role'],case['count']],False,True,settings,False)
            value=observation(raw)
            method=row['role'].removesuffix('-copy')
            for field in ('checksum','retainedManagedBytesAfterCall','initialLiveBytes','finalLiveBytes'):
                assert value[field]==checks[method][field]
            assert row==value|dict(round=row['round'],role=row['role'],processNs=cost['elapsedNs'])
        summary[name]=summarize(samples,case['methods'],case['repeats'])|dict(binaryHashes=hashes)
        if session==1:
            reports={}
            for method in case['methods']:
                prefix=name+'/'+method
                raw,_,rss=command(prefix+'-rss',[path/method,case['count']],True,True,settings,False)
                timing=observation(raw)
                assert timing['checksum']==checks[method]['checksum']
                emitted=path/(method+'-observed-generated.c')
                raw,_,emitter=command(prefix+'-compiler-cost',[compiler,'build','--fn','measure','--emit-c',
                    '-O2',path/(method+'.fwp'),'-o',emitted],True,False,settings,False)
                assert not raw and emitted.read_bytes()==(path/(method+'-generated.c')).read_bytes()
                raw,_,c_compiler=command(prefix+'-c-cost',[cc,*flags,path/(method+'.c'),'-o',path/(method+'-rebuilt'),
                    '-lm','-lpthread','-ldl'],True,False,settings,False)
                assert not raw
                native_hash(path/(method+'-rebuilt'),machine)
                raw,_,_=command(prefix+'-rebuilt-check',[path/(method+'-rebuilt'),case['count']],False,True,settings,False)
                assert observation(raw)['checksum']==timing['checksum']
                measured=path/(method+'-memory.c')
                assert measured.read_text()==instrument((path/(method+'.c')).read_text())
                raw,_,_=command(prefix+'-memory-build',[cc,*flags,measured,'-o',path/(method+'-memory'),
                    '-lm','-lpthread','-ldl'],False,False,settings,False)
                assert not raw
                native_hash(path/(method+'-memory'),machine)
                memory={}
                for workspace in (True,False):
                    raw,stderr,_=command(prefix+'-memory-'+str(int(workspace)),[path/(method+'-memory'),case['count']],
                        False,True,dict(settings,FWP_AD_WORKSPACE=str(int(workspace))),True)
                    value=observation(raw)
                    assert value['checksum']==timing['checksum']
                    assert value['retainedManagedBytesAfterCall']==timing['retainedManagedBytesAfterCall']
                    managed,raw_storage=[json.loads(line) for line in stderr.splitlines()]
                    check_reports(managed,raw_storage['rawDerivativeStorage'],case['count'],case['repeats'],method,workspace)
                    memory[str(int(workspace))]=dict(managed=managed,rawDerivativeStorage=raw_storage['rawDerivativeStorage'])
                reports[method]=dict(memory=memory,process=rss,compiler=emitter,cCompiler=c_compiler,
                    imageBytes=(path/method).stat().st_size,
                    retainedManagedBytesAfterCall=timing['retainedManagedBytesAfterCall'],
                    stack=stack_report((path/(method+'.su')).read_text(),
                                       entry_and_drops((path/(method+'-generated.c')).read_text())[0]))
            observations[name]=reports
    assert consumed==set(commands),'unexamined commands'
    assert summary==json.loads((directory/'summary.json').read_text())
    if session==1:
        assert observations==json.loads((directory/'observations.json').read_text())
    else:
        assert not (directory/'observations.json').exists()
    return dict(source=source,machine=machine,session=session,inputCases=len(summary),methodCases=41,
                commands=len(commands),vsReverse={name:row['vsReverse'] for name,row in summary.items()})


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory',type=Path,required=True)
    parser.add_argument('--compiler',type=Path,required=True)
    parser.add_argument('--cc',required=True)
    parser.add_argument('--source',required=True)
    parser.add_argument('--machine',choices=('aarch64','x86_64'),required=True)
    parser.add_argument('--session',type=int,choices=(1,2),required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    result=audit(args.directory.resolve(),args.compiler.resolve(),args.cc,args.source,args.machine,args.session)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('Complete commands, sources, samples, native images and storage observations pass audit.')


if __name__=='__main__':
    main()
