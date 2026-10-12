from pathlib import Path
import json,hashlib
T=Path('/private/tmp')
k=(T/'fwp-kernel-stack-runtime-draft.c').read_text()
k=k.replace('/* check a kernel and gather its inputs; *inputs is malloc\'ed */', '''static int fwp_kernel_workspace_fits(size_t depth) {
    return depth <= SIZE_MAX / FWP_KCHUNK / sizeof(double);
}

/* check a kernel and gather its inputs; *inputs is malloc'ed */''')
old='''        xs = OBJ(xs)->f[1];
    }
}

static V fwp_p_device_run'''
new='''        xs = OBJ(xs)->f[1];
    }
    if (!fwp_kernel_workspace_fits(depth)) {
        free((void *)k->inputs);
        fwp_trap("device: kernel too large");
    }
}

static V fwp_p_device_run'''
assert k.count(old)==1;k=k.replace(old,new)
start=k.index('static V fwp_p_device_run');end=k.index('static V fwp_p_device_sum',start)
s=k[start:end];s=s.replace('size_t n = (int64_t)nv < 0 ? 0 : (size_t)(int64_t)nv;', 'uint64_t count = (int64_t)nv < 0 ? 0 : (uint64_t)nv;\n    size_t n = (size_t)count;')
s=s.replace('    double *out =', '''    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) {
        free((void *)k.inputs);
        fwp_trap("array too large");
    }
    double *out =''');k=k[:start]+s+k[end:]
(T/'fwp-device-bounds-runtime-draft.c').write_text(k)
r=(T/'fwp-numeric-representation-source/src/numerics.rs').read_text()
r=r.replace('fn check(code:', 'fn workspace_fits(depth: usize) -> bool {\n    depth <= usize::MAX / CHUNK / std::mem::size_of::<f64>()\n}\n\nfn check(code:',1)
old='''    Ok(depth)
}

impl Kernel''';assert r.count(old)==1;r=r.replace(old,'''    if !workspace_fits(depth) {
        return trap("device: kernel too large");
    }
    Ok(depth)
}

impl Kernel''')
start=r.index('            "device.run" | "device.sum"');end=r.index('            "device.gpu-available"',start)
s=r[start:end].replace('let n = int(&a[1]).max(0) as usize;', 'let count = int(&a[1]).max(0) as u64;\n                let n = count as usize;')
s=s.replace('''                if sym == "device.run" {
                    f64_array''','''                if sym == "device.run" {
                    let limit = (usize::MAX - std::mem::size_of::<u64>()) / std::mem::size_of::<u64>();
                    if count > limit as u64 {
                        return trap("array too large");
                    }
                    f64_array''');r=r[:start]+s+r[end:]
(T/'fwp-device-bounds-interpreter-draft.rs').write_text(r)
# Existing interpreter/native size controls retain their artifact and optimization policy.
t=(T/'fwp-array-size-test.rs').read_text();t=t[:t.index('#[test]\nfn generic_array_constructor')]
t=t.replace('array_size_limits_agree_with_raw_interpreter_and_generic_wrappers','device_output_limits_preserve_kernel_validation_order').replace('fwp-array-size-', 'fwp-device-size-').replace('FWP_ARRAY_SIZE_ARTIFACTS','FWP_DEVICE_BOUNDS_ARTIFACTS')
a=t.index('    let prefix =');b=t.index('    let fwp =',a)
t=t[:a]+'''    let prefix = "run-constant : I64 -> Array[F64]\\nrun-constant = device.run 1 | apply ([1] | array.from-list) | apply ([2.5] | array.from-list) | apply []\\nbad-code : I64 -> Array[F64]\\nbad-code = device.run 1 | apply ([99] | array.from-list) | apply ([2.5] | array.from-list) | apply []\\nbad-input : I64 -> Array[F64]\\nbad-input = device.run 1 | apply ([0] | array.from-list) | apply ([] | array.from-list) | apply [([] | array.from-list)]\\n";
    let cases = [
        ("output-overflow", "add 2305843009213693952 | run-constant", Some("array too large"), ""),
        ("code-order", "add 2305843009213693952 | bad-code", Some("device: malformed kernel"), ""),
        ("input-order", "add 2305843009213693952 | bad-input", Some("device: input 0 has 0 elements, the kernel 2305843009213693952"), ""),
        ("negative", "sub 1 | run-constant", None, "0\\n"),
        ("valid", "add 3 | run-constant", None, "3\\n"),
    ];
''' +t[b:]
t=t.replace('for (label, expression, trap) in cases','for (label, expression, trap, stdout) in cases').replace('assert_eq!(reference.stdout, b"0\\n");','assert_eq!(reference.stdout, stdout.as_bytes());')
(T/'fwp-device-bounds-test.rs').write_text(t)
for name in ['fwp-finalize-phase2-exit-on-runner.py','fwp-publish-phase2-exit-history.py']:
 p=T/name;s=p.read_text().replace('28db5471d503763aa27e7da4f60c5ad880ad4183','d240231c5dd33e83ecdd5bf3df06715a0e279768').replace('38185769269','38186836622');p.write_text(s)
p=T/'fwp-kernel-stack-preparation.json';j=json.loads(p.read_text());j['latestVerifiedHead']='d240231c5dd33e83ecdd5bf3df06715a0e279768';j['latestVerifiedRun']=38186836622;j['latestStatus']='All three platform preflights pass stack guard and constant word-decoding controls';p.write_text(json.dumps(j,indent=2)+'\n')
