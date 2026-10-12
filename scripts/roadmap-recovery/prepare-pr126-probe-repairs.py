from pathlib import Path
p=Path('/private/tmp/fwp-pr126-probe-repairs/old_reclamation.rs');s=p.read_text()
a='''    let drop_array = call
        .split(';')
        .next()
        .unwrap()
        .rsplit(", ")
        .next()
        .unwrap()
        .trim_end_matches(')');'''
b='''    let arguments = call.split(';').next().unwrap();
    let mut arguments = arguments.rsplit(", ");
    let element = arguments.next().unwrap().trim_end_matches(')');
    let drop_array = arguments.next().unwrap();'''
assert s.count(a)==1;s=s.replace(a,b).replace('fwp_array_typed_new(2);','fwp_array_typed_new(2, ARRAY_ELEMENT);').replace('.replace("DROP_ARRAY", drop_array)','.replace("DROP_ARRAY", drop_array)\n        .replace("ARRAY_ELEMENT", element)');p.write_text(s)
p=Path('/private/tmp/fwp-pr126-probe-repairs/retain_unwind_ownership.rs');s=p.read_text();a='static fwp_r2 w{repeat}(V l0) {{';assert s.count(a)==1;p.write_text(s.replace(a,'static fwp_wr{repeat} w{repeat}(V l0) {{'))
p=Path('/private/tmp/fwp-pr126-probe-repairs/unboxed_worker_locals.rs');s=p.read_text();assert s.count('fwp_r2 results=w3')==1;s=s.replace('fwp_r2 results=w3','fwp_wr3 results=w3').replace('results.f[0]','results.f0').replace('results.f[1]','results.f1');p.write_text(s)
print('Prepared probe interface repairs; all original ownership assertions retained')
