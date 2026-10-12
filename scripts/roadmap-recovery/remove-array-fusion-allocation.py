"""Prepare direct flat loop entries and numeric lookup release ordering."""
from pathlib import Path
base=Path('/private/tmp/fwp-array-fusion-flat-evidence/source');out=Path('/private/tmp/fwp-phase4-array-fusion-draft');(out/'fuse.rs').write_text((base/'fuse.rs').read_text())
s=(base/'cgen.rs').read_text()
a='''                let mut aliases = vec![*l];
                let mut inner = &**body;'''
b='''                let mut lookup = &**v;
                while let Expr::Let(_, _, body) = lookup { lookup = body; }
                let numeric_array = matches!(lookup, Expr::Call(id, _) if matches!(&self.g.prog.funcs[*id].body, Body::Prim(symbol) if symbol == "array.get"));
                let mut releases = Vec::new();
                let mut aliases = vec![*l];
                let mut inner = &**body;''';assert s.count(a)==1;s=s.replace(a,b)
a='''                        _ => break,
                    }
                }
                if !aliases.iter().any''';b='''                        Expr::Drop(local, next) if numeric_array && !self.resource_slots.contains_key(local) => {
                            releases.push(*local);
                            inner = next;
                        }
                        _ => break,
                    }
                }
                if !aliases.iter().any''';assert s.count(a)==1;s=s.replace(a,b)
a='''                                body.map(|body| (pattern.clone(), body))''';b='''                                body.map(|body| {
                                    let body = releases.iter().rev().fold(body, |body, local| Expr::Drop(*local, Box::new(body)));
                                    (pattern.clone(), body)
                                })''';assert s.count(a)==1;s=s.replace(a,b)
a='''        if sym == "loop" && n == 0 {
            let s = self.expr(&args[1]);
            if let Some(shape) = loop_shape(&self.g.prog.funcs[g]) {''';b='''        if sym == "loop" && n == 0 {
            if let Some(Some(width)) = loop_shape(&self.g.prog.funcs[g]) {
                let flat = record_fields(&self.g.prog.shapes, &self.g.prog.funcs[g].locals[0])
                    .is_some_and(|fields| fields.iter().all(|(_, ty)| record_fields(&self.g.prog.shapes, ty).is_none()));
                if flat && self.unboxed(&args[1]) == Some(width) {
                    if !self.g.loops.iter().any(|(step, _)| *step == g) { self.g.loops.push((g, Some(width))); }
                    let fields = self.expr_fields(&args[1], width);
                    return Some(format!("fwp_loop_fields{g}({})", fields.join(", ")));
                }
            }
            let s = self.expr(&args[1]);
            if let Some(shape) = loop_shape(&self.g.prog.funcs[g]) {''';assert s.count(a)==1;s=s.replace(a,b)
a='''        out
    }

    fn func(&mut self, id: FuncId)'''
b='''        if record.is_some() && slots.iter().all(|(_, width)| width.is_none()) {
            let parameters = (0..n).map(|i| format!("V a{i}")).collect::<Vec<_>>().join(", ");
            let initial = (0..n).map(|i| format!("a{i}")).collect::<Vec<_>>().join(", ");
            let _ = write!(out, "static V fwp_loop_fields{step}({parameters}) {{\\n    V st[{n}] = {{{initial}}}, nx[{n}] = {{0}}, out = 0;\\n    {protect}\\n    for (;;) {{\\n        {save}{tick}\\n        {transfer}\\n        int done = fs{step}(st, nx, &out);\\n{root_fences}        if (done) {{ {finish} return out; }}\\n        for (int i = 0; i < {n}; i++) st[i] = nx[i];\\n    }}\\n}}\\n");
        }
        out
    }

    fn func(&mut self, id: FuncId)''';assert s.count(a)==1;s=s.replace(a,b)
a='''        let _ = writeln!(out, "static V fwp_loop{}(V s);", step);''';b=a+'''
        if let Some(fields) = record_fields(&prog.shapes, &prog.funcs[*step].locals[0]) {
            if fields.iter().all(|(_, ty)| record_fields(&prog.shapes, ty).is_none()) {
                let parameters = (0..fields.len()).map(|i| format!("V a{i}")).collect::<Vec<_>>().join(", ");
                let _ = writeln!(out, "static V fwp_loop_fields{step}({parameters});");
            }
        }''';assert s.count(a)==1;s=s.replace(a,b)
(out/'cgen.rs').write_text(s)
print('Prepared direct flat loop ownership transfer and unboxed numeric lookup release ordering')
