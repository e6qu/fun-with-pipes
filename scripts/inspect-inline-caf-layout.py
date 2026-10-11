import hashlib, json, os, platform, re, subprocess
from pathlib import Path
root=Path(os.environ['FWP_LAYOUT_CAPTURE'])
cc=os.environ['FWP_LAYOUT_REAL_CC']
machine=platform.machine()
magic={'arm64':'cffaedfe0c0000010000000002000000','x86_64':'cffaedfe070000010300000002000000'}
assert machine in magic
records=[]
for folder in sorted((root/'owner').glob('O*-*')):
 code=(folder/'probe.c').read_text()
 assert (folder/'probe').read_bytes()[:16].hex()==magic[machine]
 digest=hashlib.sha256((folder/'probe.c').read_bytes()).hexdigest()
 assert digest==json.loads((folder/'header.json').read_text())['sourceSha256']
 start=code.index('/* main :');stop=start+code[start:].index('\n}\n')+3
 body=code[start:stop]
 binding=re.search(r'V (?P<temp>t\d+) = caf(?P<caf>\d+)\(\);\s+(?P<owner>l\d+) = (?P=temp);',body)
 assert binding,body
 owner=binding.group('owner');caf=binding.group('caf')
 argument_drops=len(re.findall(r'\bfwp_drop\d+\('+re.escape(owner)+r'\);',body))
 record=dict(directory=folder.name,sourceSha256=digest,argumentDropCalls=argument_drops,
             totalTypedDropCalls=body.count('fwp_drop'),cafArgumentLocal=owner,cafId=caf)
 for command,filename in [(['nm','-nm',str(folder/'probe')],'symbols.txt'),(['otool','-tv',str(folder/'probe')],'assembly.txt')]:
  result=subprocess.check_output(command,text=True);(folder/filename).write_text(result)
 records.append(record)
assert len(records)==4
for opt in ['O1','O2']:
 values=[r['argumentDropCalls'] for r in records if r['directory'].startswith(opt+'-')]
 assert sorted(values)==[0,1],values
positive=next(r for r in records if r['directory'].startswith('O2-') and r['argumentDropCalls']==1)
folder=root/'owner'/positive['directory']
layout=root/'layout.c'
caf=positive['cafId']
layout.write_text(f'#define FWP_SELECTED_CAF_VALUE fwp_caf_value{caf}\n#define FWP_SELECTED_CAF_STATE fwp_caf_state{caf}\n'+'#define main layout_original_main\n'+(folder/'probe.c').read_text()+'\n#undef main\n#include <stddef.h>\nint main(void){printf("V=%zu align=%zu object_header=%zu payload=%zu cleanup=%zu cache_value=%zu cache_state=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup),sizeof(FWP_SELECTED_CAF_VALUE),sizeof(FWP_SELECTED_CAF_STATE));return 0;}\n')
args=json.loads((folder/'args.json').read_text())
args=[str(layout) if arg.endswith('.c') else arg for arg in args]
args[args.index('-o')+1]=str(root/'layout')
subprocess.run([cc,*args],check=True)
report=dict(head=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),machine=machine,
 hardware=subprocess.check_output(['sysctl','-n','machdep.cpu.brand_string'],text=True).strip(),
 os=subprocess.check_output(['sw_vers'],text=True),compiler=subprocess.check_output([cc,'--version'],text=True),
 binaries=records,layoutSourceSha256=positive['sourceSha256'],
 layout=subprocess.check_output([str(root/'layout')],text=True).strip(),
 limits='Original observer/omission fixtures. Static drop sites and separate cache globals are not dynamic counts, contiguous cache size, speed or production ABI evidence.')
(root/'inspection.json').write_text(json.dumps(report,indent=2)+'\n')
print(machine,report['layout'],flush=True)
