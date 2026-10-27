//! Keep known `(I64, String)` sort keys in a contiguous, owned field buffer.

use super::{record_fields, FnGen, Gen};
use crate::ir::*;

impl FnGen<'_, '_> {
    pub(super) fn inline_sort_keys(&mut self, id: FuncId, args: &[Expr]) -> Option<String> {
        if !matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "sort-by") {
            return None;
        }
        let [Expr::Func(callback), input] = args else {
            return None;
        };
        let callback = *callback;
        let f = &self.g.prog.funcs[callback];
        let abi = self.g.abis[callback].as_ref()?;
        if f.arity != 1
            || abi.params != [Some(2)]
            || abi.ret != Some(2)
            || self.g.wide_workers[callback]
            || !crate::rc::consumes_arg(self.g.prog, callback, 0)
        {
            return None;
        }
        let fields = record_fields(&self.g.prog.shapes, &f.locals[0])?;
        let result = record_fields(&self.g.prog.shapes, f.ty.params(1).1)?;
        let string = MT::con("std::String");
        let integer = MT::con("std::I64");
        if fields[0].1 != string
            || fields[1].1 != integer
            || result[0].1 != integer
            || result[1].1 != string
        {
            return None;
        }
        if !self.g.inline_sort_keys.contains(&callback) {
            self.g.inline_sort_keys.push(callback);
        }
        let input = self.expr(input);
        Some(format!("fwp_sort_keys{callback}({input})"))
    }
}

impl Gen<'_> {
    pub(super) fn inline_sort_keys_def(&mut self, callback: FuncId) -> String {
        let abi = self.abis[callback].as_ref().expect("selected key worker");
        let arguments = abi
            .args_decode_words(
                self.prog,
                callback,
                vec!["text".into(), "OBJ(vals[i])->f[1]".into()],
            )
            .join(", ");
        let fields = abi.result_words(self.prog, callback, "key");
        let number = &fields[0];
        let text = &fields[1];
        let string = MT::con("std::String");
        let string_desc = self.desc(&string);
        let drop_string = self.value_drop(&string);
        let element = self.prog.funcs[callback].locals[0].clone();
        let list = self.desc(&MT::Con("std::List".into(), vec![element]));
        format!(
            r#"static V fwp_sort_keys{callback}(V xs) {{
    size_t n;
    V *vals = fwp_map_items(xs, &n);
    fwp_cleanup vals_cleanup; fwp_scratch_protect(&vals, &vals_cleanup);
    if (n >= SIZE_MAX / sizeof(fwp_i64_string_key)) fwp_trap("sort too large");
    fwp_i64_string_keys owner = {{
        (fwp_i64_string_key *)fwp_mem_alloc((n + 1) * sizeof(fwp_i64_string_key)),
        0, {drop_string}
    }};
    fwp_cleanup keys_cleanup;
#if FWP_UNWIND
    fwp_cleanup_push(&keys_cleanup, fwp_i64_string_keys_release, &owner);
#endif
    for (size_t i = 0; i < n; i++) {{
        V text = OBJ(vals[i])->f[0];
        fwp_rc_dup(text);
        /* The worker consumes this field owner, including at its entry tick. */
        fwp_wr{callback} key = w{callback}({arguments});
        owner.keys[i] = (fwp_i64_string_key){{(int64_t)({number}), {text}}};
        owner.count++;
    }}
    if (n > 1) {{
        /* Scratch copies borrow the main key buffer's field owners. */
        V *tk = (V *)fwp_mem_alloc((n + 1) * sizeof(fwp_i64_string_key));
        fwp_cleanup tk_cleanup; fwp_scratch_protect(&tk, &tk_cleanup);
        V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup tv_cleanup; fwp_scratch_protect(&tv, &tv_cleanup);
        fwp_i64_string_msort(owner.keys, vals, n, {string_desc},
                             (fwp_i64_string_key *)tk, tv);
        fwp_scratch_finish(&tv, &tv_cleanup);
        fwp_scratch_finish(&tk, &tk_cleanup);
    }}
#if FWP_UNWIND
    fwp_cleanup_pop(&keys_cleanup);
#endif
    fwp_i64_string_keys_release(&owner);
    V result = fwp_copy_finish(vals, n, 0, {list});
    fwp_scratch_finish(&vals, &vals_cleanup);
    return result;
}}
"#
        )
    }
}
