#!/usr/bin/env python3
"""Collect service-memory and iteration measurements from a passing CI run.

Requires authenticated gh and all six native jobs from the context-owners suite.
Downloads retained artifacts when absent, checks the source revision and measured
allocation limits, and writes a JSON report with environment details and hashes.
It inspects existing artifacts; it never compiles or runs their executables.
"""

import argparse, csv, hashlib, json, re, subprocess
from fractions import Fraction
from pathlib import Path

parser=argparse.ArgumentParser(description='Retain verified native service-context memory evidence')
parser.add_argument('--run', required=True)
parser.add_argument('--head', required=True)
parser.add_argument('--artifacts', required=True, type=Path)
parser.add_argument('--output', required=True, type=Path)
parser.add_argument('--capture-requests', required=True, type=int, choices=[1, 2])
parser.add_argument('--each-comparison', action='store_true')
args=parser.parse_args()
def gh(*parts): return subprocess.check_output(['gh', *parts])
run=json.loads(gh('run','view',args.run,'--repo','e6qu/fun-with-pipes','--json','headSha,status,conclusion,jobs,url'))
assert run['status']=='completed' and run['conclusion']=='success', 'Native run must pass before retaining acceptance'
assert run['headSha']==args.head
jobs={j['name'][7:-1]:j for j in run['jobs'] if j['conclusion']!='skipped'}
assert set(jobs)=={'ubuntu-latest','ubuntu-24.04-arm','macos-15','macos-15-intel','windows-2025','windows-11-arm'}
assert all(j['status']=='completed' and j['conclusion']=='success' for j in jobs.values())
args.artifacts.mkdir(parents=True,exist_ok=True)
(args.artifacts/'run.json').write_text(json.dumps(run,indent=2)+'\n')
cases=['plain','gzip','deadline','metadata','empty-metadata','filtered-metadata','capture']
metrics=['managed_requests','requested_bytes','final_charged_bytes']
hosts=[]
for host,job in sorted(jobs.items()):
    folder=args.artifacts/('context-storage-'+host)
    if not folder.exists():
        subprocess.run(['gh','run','download',args.run,'--repo','e6qu/fun-with-pipes','--name',folder.name,'--dir',str(folder)],check=True)
    logpath=folder/'job.log'
    if not logpath.exists(): logpath.write_bytes(gh('api','--allow-escape-sequences',f'repos/e6qu/fun-with-pipes/actions/jobs/{job["databaseId"]}/logs'))
    log=re.sub(r'\x1b\[[0-?]*[ -/]*[@-~]','',logpath.read_text())
    for test in ['repeated_service_scopes_preserve_state_and_report_storage','children_keep_scope_settings_after_return_failure_and_cancellation','canonical_decoding_scratch_releases_on_malformed_values_and_allocation_traps']:
        assert f'test {test} ... ok' in log,(host,test)
    rows=[{k:v if k=='case' else int(v) for k,v in r.items()} for r in csv.DictReader((folder/'storage.tsv').open(),delimiter='\t')]
    indexed={(r['case'],r['iterations']):r for r in rows}
    assert len(rows)==21 and set(indexed)=={(case,n) for case in cases for n in [1,32,128]}
    assert all(set(r) == {'case', 'iterations', 'managed_requests', 'requested_bytes', 'final_charged_bytes'} for r in rows)
    extra={case:{k:Fraction(indexed[(case,128)][k]-indexed[(case,32)][k]-indexed[('plain',128)][k]+indexed[('plain',32)][k],96) for k in metrics} for case in cases[1:]}
    for case in ['gzip','deadline','empty-metadata','filtered-metadata']: assert set(extra[case].values())=={0},(host,case,extra[case])
    assert extra['metadata']['managed_requests']==1 and extra['metadata']['final_charged_bytes']==0
    assert extra['capture']['managed_requests']==args.capture_requests, (host, extra['capture'])
    assert extra['capture']['requested_bytes']==24*args.capture_requests
    assert extra['capture']['final_charged_bytes']==0
    layouts=[{k:v if k=='case' else int(v) for k,v in r.items()} for r in csv.DictReader((folder/'layout.tsv').open(),delimiter='\t')]
    assert len(layouts)==21
    environment=(folder/'environment.txt').read_text()
    assert f'Source: {args.head}' in environment and all(k in environment for k in ['C compiler:','CPU:','Rust compiler:'])
    def fingerprint(path): return {'bytes':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
    inventory=json.loads((folder/'contracts.json').read_text())
    assert inventory['head']==args.head
    assert inventory['counts']['contract']==347 and inventory['counts']['runtime_or_specialization_review']==7
    files={name:fingerprint(folder/name) for name in ['environment.txt','storage.tsv','layout.tsv','job.log','contracts.json']}
    binaries={}
    for case in cases:
        path=folder/f'{case}-128.exe'
        binaries[path.name]={**fingerprint(path),'format':subprocess.check_output(['file','-b',str(path)],text=True).strip()}
        for suffix in ['.fwp','.c','-measured.c']:
            path=folder/f'{case}-128{suffix}';files[path.name]=fingerprint(path)
    for prefix in ['scope','capture']:
        for suffix in ['.c','.exe']:
            path=folder/f'{prefix}-counted{suffix}';files[path.name]=fingerprint(path)
    result=(folder/'capture-counted.txt').read_text()
    assert 'capture alias 0: 14 allocation failures; final charged delta 0; capture owners 0' in result
    assert 'capture alias 1: 13 allocation failures; final charged delta 0; capture owners 0' in result
    files['capture-counted.txt']=fingerprint(folder/'capture-counted.txt')
    iteration=None
    if args.each_comparison:
        for test in ['each_preserves_aliases_effect_order_and_early_failures','each_avoids_allocating_a_discarded_result_list']:
            assert f'test {test} ... ok' in log,(host,test)
        each_rows=[{k:v if k=='implementation' else int(v) for k,v in r.items()} for r in csv.DictReader((folder/'each-storage.tsv').open(),delimiter='\t')]
        each_index={(r['implementation'],r['iterations']):r for r in each_rows}
        assert len(each_rows)==4 and set(each_index)=={(kind,n) for kind in ['map','fold'] for n in [32,128]}
        savings={metric:Fraction(each_index[('map',128)][metric]-each_index[('map',32)][metric]-each_index[('fold',128)][metric]+each_index[('fold',32)][metric],96) for metric in ['managed_requests','requested_bytes']}
        assert savings['managed_requests']>=1 and savings['requested_bytes']>=24,(host,savings)
        assert each_index[('fold',128)]['managed_requests']-each_index[('fold',32)]['managed_requests']<=96
        if 'dynamic_calls' in each_rows[0]:
            assert each_index[('fold',128)]['dynamic_calls']==each_index[('fold',32)]['dynamic_calls'],(host,each_rows)
        files['each-storage.tsv']=fingerprint(folder/'each-storage.tsv')
        for opt in ['-O1','-O2']:
            for suffix in ['.fwp','.c','.exe','.txt']:
                name=f'each-trap-counted{opt}{suffix}'
                files[name]=fingerprint(folder/name)
        for kind in ['map','fold']:
            for n in [32,128]:
                for suffix in ['.fwp','.c','.exe']:
                    name=f'each-{kind}-{n}{suffix}'
                    files[name]=fingerprint(folder/name)
        iteration={'rows':each_rows,'saved_per_additional_element_between_32_and_128':{k:str(v) for k,v in savings.items()},'comparison':'Old map-based each versus fold-based each, identical counting program and input list, O2 with counted ownership. Includes input construction, startup and printing; slope differences cancel fixed costs. Managed allocation requests and requested payload bytes only, not elapsed time or peak/process memory.'}
    timing=None
    if args.each_comparison and host.startswith('ubuntu-'):
        timing_path=folder/'iteration-timing/timings.json'
        timing=json.loads(timing_path.read_text())
        assert timing['source_revision']==args.head
        assert [r['elements'] for r in timing['rows']]==[10000,100000,1000000]
        assert len(timing['programs'])==6
        for row in timing['rows']:
            assert row['run_order'] == ['map', 'fold', 'fold', 'map'] * 4
            for label in ['map','fold']:
                samples=row['samples'][label]
                assert len(samples)==8 and all(s['process_wall_ns']>0 and s['peak_rss_kib']>0 for s in samples)
        for stem, program in timing['programs'].items():
            for key,suffix in [('source','.fwp'),('generated_c','.c'),('binary','')]:
                artifact=folder/'iteration-timing'/(stem+suffix)
                assert fingerprint(artifact)==program[key],(host,artifact)
                files[str(artifact.relative_to(folder))]=fingerprint(artifact)
        files['iteration-timing/timings.json']=fingerprint(timing_path)
    observations=None
    if (folder/'binary-observations.json').exists():
        observations=json.loads((folder/'binary-observations.json').read_text())
        assert observations['source_revision']==args.head
        assert fingerprint(folder/observations['binary'])['sha256']==observations['binary_sha256']
        assert fingerprint(folder/observations['assembly'])['sha256']==observations['assembly_sha256']
        files['binary-observations.json']=fingerprint(folder/'binary-observations.json')
        files[observations['assembly']]=fingerprint(folder/observations['assembly'])
        if 'baseline_assembly' in observations:
            baseline_assembly=folder/observations['baseline_assembly']
            assert fingerprint(baseline_assembly)['sha256']==observations['baseline_assembly_sha256']
            files[observations['baseline_assembly']]=fingerprint(baseline_assembly)
    hosts.append({'runner':host,'iteration':iteration,'iteration_timing':timing,'binary_observations':observations,'job':{k:job[k] for k in ['name','databaseId','conclusion']},'environment':environment,'primitive_counts':inventory['counts'],'extra_per_call_versus_plain_between_32_and_128':{case:{k:str(v) for k,v in values.items()} for case,values in extra.items()},'layouts':{name:next({k:v for k,v in row.items() if k!='case'} for row in layouts if row['case']==name+'-128') for name in cases},'rows':rows,'files':files,'binaries':binaries})
report={'title':'Memory used by service helpers and list iteration','source_revision':args.head,'run':run['url'],'comparison':'Each fwp service scope versus plain fwp state updates at 1/32/128 calls, O2 with counted ownership. Managed requests, requested bytes and final charged storage from constant initialization through main cleanup. Fixed scheduler startup remains included in rows; per-call slopes subtract fixed costs.','limits':'Service allocation rows exclude raw TLS/capture buffers, allocator metadata, pages and total process memory; they do not measure speed. Separate iteration_timing entries retain elapsed time and peak process memory when present. Neither comparison establishes C/Rust parity. Plain programs omit service fields; their task sizes are not the old service-task baseline.','hosts':hosts}
args.output.write_text(json.dumps(report,indent=2)+'\n')
for host in hosts: print(host['runner'],host['extra_per_call_versus_plain_between_32_and_128'],host['layouts']['gzip'])
