"""Prepare every descriptor-aware representation boundary on the accepted base."""
from pathlib import Path
import re
BASE=Path('/private/tmp/fwp-numeric-representation-phase2-candidate-source');OUT=Path('/private/tmp/fwp-packed-array-runtime-draft')
s=Path('/private/tmp/fwp-typed-worker-abi-evidence/ubuntu-latest/cgen.formatted.rs').read_text()
def replace(old,new,count=1):
 global s
 assert s.count(old)==count,(old[:75],s.count(old),count)
 s=s.replace(old,new)
replace('    let _ = writeln!(out, "#define FWP_UNWIND {}", u8::from(g.unwind));','''    let _ = writeln!(out, "#define FWP_UNWIND {}", u8::from(g.unwind));
    let packed = std::env::var("FWP_PACKED_ARRAYS").map_or(true, |v| v != "0");
    let _ = writeln!(out, "#define FWP_PACKED_ARRAYS {}", u8::from(packed));''')
replace('        let s = match sym {','''        if sym == "array.length" {
            return Ok("return (V)(int64_t)fwp_array_len(l0);".into());
        }
        if matches!(sym, "array.from-list" | "array.to-list" | "array.get" | "array.set" |
            "array.push" | "array.make" | "array.generate" | "array.map" | "array.fold" |
            "array.slice" | "array.append" | "array.sort") {
            let array = if matches!(sym, "array.from-list" | "array.make" | "array.generate" | "array.map") {
                &result
            } else {
                params.last().expect("array primitive input")
            };
            let MT::Con(_, types) = array else { return Err(format!("array primitive `{sym}` has no element type")); };
            let element = types.first().ok_or_else(|| format!("array primitive `{sym}` has no element type"))?;
            let mut args: Vec<_> = (0..func.arity).map(|i| format!("l{i}")).collect();
            args.push(self.desc(element));
            if sym == "array.map" {
                let MT::Con(_, input) = &params[1] else { return Err("array.map input has no element type".into()); };
                args.push(self.desc(&input[0]));
            }
            return Ok(format!("return fwp_p_{}_with_elem({});", sym.replace(['.', '-'], "_"), args.join(", ")));
        }
        let s = match sym {''')
# Typed ownership hooks keep their existing argument and drop order.
needle='''                                s = format!(
                                    "return fwp_p_{}_typed({});",
                                    sym.replace(['.', '-'], "_"),
                                    args.join(", ")
                                );'''
assert s.count(needle)>=2
at=s.index(needle,s.index('ResultOwnership::ArrayOperation'))
addition='''                                if sym != "array.sort" {
                                    let ty = if let Some(ty) = element.as_ref() {
                                        ty.clone()
                                    } else {
                                        let array = if matches!(sym.as_str(), "array.generate" | "array.map") {
                                            func.ty.params(func.arity as usize).1
                                        } else {
                                            &func.locals[func.arity as usize - 1]
                                        };
                                        let MT::Con(_, types) = array else { return Err("typed array element missing".into()); };
                                        types[0].clone()
                                    };
                                    args.push(self.desc(&ty));
                                }
                                if sym == "array.map" {
                                    let MT::Con(_, input) = &func.locals[1] else { return Err("typed array.map input missing".into()); };
                                    args.push(self.desc(&input[0]));
                                }
'''
s=s[:at]+addition+s[at:]
# Constant Value arrays have concrete scalar variants. Empty arrays need no payload.
old='''                format!(
                    "fwp_p_array_from_list(fwp_list_from((V[]){{{}}}, {}))",'''
new='''                let kind = match items.first() {
                    Some(Value::I8(_)) => "K_I8", Some(Value::U8(_)) => "K_U8",
                    Some(Value::I16(_)) => "K_I16", Some(Value::U16(_)) => "K_U16",
                    Some(Value::I32(_)) => "K_I32", Some(Value::U32(_)) => "K_U32",
                    Some(Value::I64(_)) => "K_I64", Some(Value::U64(_)) => "K_U64",
                    Some(Value::F32(_)) => "K_F32", Some(Value::F64(_)) => "K_F64",
                    _ => "K_OPAQUE",
                };
                format!(
                    "fwp_array_from_words((V[]){{{}}}, {}, &(const fwp_desc){{.kind = {kind}}})",'''
replace(old,new)
# Numeric views own a backing reference; release it in the existing tail loop.
needle='''            let mut elements = String::new();
            if let MT::Con(name, types) = mt {'''
new='''            let mut elements = String::new();
            if matches!(mt, MT::Con(name, _) if name == "std::Array") {
                elements.push_str("        if (fwp_array_is_view(v)) { V owner = fwp_array_owner(v); fwp_rc_free_arr(v); v = owner; continue; }\\n");
            }
            if let MT::Con(name, types) = mt {'''
replace(needle,new)
replace('elements = format!("        for (uint64_t i = 0; i < ARR(v)->len; i++) fwp_drop{child}(ARR(v)->d[i]);\\n");','elements.push_str(&format!("        for (uint64_t i = 0; i < fwp_array_len(v); i++) fwp_drop{child}(ARR(v)->d[i]);\\n"));')
# SIMD carries descriptors through its backing arrays, including from-array views.
replace('"simd.splat" => format!("return fwp_p_simd_splat(l0, {});", vec_shape(&result).0),','''"simd.splat" => format!("return fwp_p_simd_splat(l0, {}, {});", vec_shape(&result).0, self.desc(&vec_shape(&result).1)),''')
replace('''                    w
                )
            }
            "simd.sum"''','''                    w,
                    self.desc(&vec_shape(&p(0)).1)
                )
            }
            "simd.sum"''')
replace('"return fwp_p_simd_op({}, {}, l1, l0, {}, {});"','"return fwp_p_simd_op({}, {}, l1, l0, {}, {}, {});"')
replace('"return fwp_p_simd_sum({}, l0, {}, {});"','"return fwp_p_simd_sum({}, l0, {}, {}, {});"')
# Locate the scalar sum's final arguments without changing other numeric primitives.
a=s.index('            "simd.sum"');b=s.index('            "wrapping.add"',a);chunk=s[a:b];assert 'rw\n' in chunk;chunk=chunk.replace('rw\n','rw,\n                self.desc(&vec_shape(&p(0)).1)\n');s=s[:a]+chunk+s[b:]
(OUT/'cgen.rs').write_text(s)
# Descriptor-directed structural operations preserve logical text/ordering/encoding.
for name in ['fwp_rt_ops.c','fwp_rt_json.c','fwp_rt_exec.c']:
 t=(BASE/'runtime'/name).read_text()
 for v in ['a','b','v']:
  t=t.replace(f'ARR({v})->len',f'fwp_array_len({v})')
  t=re.sub(r'ARR\('+v+r'\)->d\[([^\]]+)\]',lambda m:'fwp_array_load('+v+', '+m[1]+', d->elem)',t)
 if name in {'fwp_rt_json.c','fwp_rt_exec.c'}:t=t.replace('fwp_p_array_from_list(l) : l','fwp_p_array_from_list_with_elem(l, d->elem) : l')
 (OUT/name).write_text(t)
# Word-wide AD/kernel inputs still resolve view lengths and backing pointers.
t=(BASE/'runtime/fwp_rt_kernel.c').read_text()
at=t.index('static void fwp_kernel_eval(')
constant_reader='''static inline double fwp_kernel_constant(const fwp_kernel *k, size_t index) {
    V bits;
    memcpy(&bits, (const unsigned char *)k->consts + index * sizeof(V), sizeof bits);
    return fwp_f64(bits);
}

'''
t=t[:at]+constant_reader+t[at:]
t=t.replace('fwp_f64(k->consts[ci++])','fwp_kernel_constant(k, ci++)')
for v in ['outs','seeds','code','consts','a']:
 t=t.replace(f'ARR({v})->len',f'fwp_array_len({v})').replace(f'ARR({v})->d',f'((const V *)fwp_array_data({v}))')
for v in ['outs','seeds']:
 t=t.replace('((const V *)fwp_array_data('+v+'))[i]', 'fwp_array_load('+v+', i, NULL)')
(OUT/'fwp_rt_kernel.c').write_text(t)
# Existing F64 linalg adapters use word-sized elements but can receive views.
t=Path('/private/tmp/fwp-packed-array-typed-core-draft.c').read_text();t=t.replace('ARR(arr)->len','fwp_array_len(arr)').replace('ARR(arr)->d[i]','fwp_array_load(arr, i, NULL)')
anchor='/* Typed array boundaries:';at=t.index(anchor);raw=Path('/private/tmp/fwp-packed-array-unowned-draft.c').read_text();t=t[:at]+raw+'\n'+t[at:];(OUT/'fwp_rt_prims.c').write_text(t)
# All SIMD lane aliases use the same element descriptor as Array producers.
t=(BASE/'runtime/fwp_rt_num.c').read_text();a=t.index('/* ----- portable SIMD:');part=t[a:]
part=part.replace('static V fwp_p_simd_splat(V x, size_t n)','static V fwp_p_simd_splat(V x, size_t n, const fwp_desc *elem)').replace('int w) {','int w, const fwp_desc *elem) {').replace('fwp_arr_new(n)','fwp_array_new_packed(n, elem)').replace('ARR(a)->len','fwp_array_len(a)')
part=part.replace('xs->len','fwp_array_len(PTR(xs))').replace('ys->len','fwp_array_len(PTR(ys))')
part=re.sub(r'ARR\(a\)->d\[([^\]]+)\] = ([^;]+);',lambda m:'fwp_array_store(a, '+m[1]+', '+m[2]+', elem);',part)
part=part.replace('    V *out = ARR(r)->d;\n','')
part=re.sub(r'out\[([^\]]+)\] = ([^;]+);',lambda m:'fwp_array_store(r, '+m[1]+', '+m[2]+', elem);',part)
for v in ['xs','ys']:part=re.sub(v+r'->d\[([^\]]+)\]',lambda m:'fwp_array_load(PTR('+v+'), '+m[1]+', elem)',part)
t=t[:a]+part;(OUT/'fwp_rt_num.c').write_text(t)
print('Prepared descriptor-directed producers, consumers, SIMD, views and drop paths; runner verification pending')
