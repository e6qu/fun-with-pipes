"""Prepare numeric Array map/consumer fusion with existing trap/effect analysis."""
from pathlib import Path
BASE=Path('/private/tmp/fwp-phase4-source/src');OUT=Path('/private/tmp/fwp-phase4-array-fusion-draft');OUT.mkdir(exist_ok=True)
s=(BASE/'cgen.rs').read_text()
old='''        if !matches!(&f.body, Body::Prim(s) if s == "map.get") || args.len() != 2 {
            return None;
        }'''
new='''        if args.len() != 2 { return None; }
        let array_element = match (&f.body, &f.locals[1]) {
            (Body::Prim(s), MT::Con(n, elements)) if s == "array.get" && n == "std::Array"
                && elements.len() == 1 && scalar(&elements[0]).is_some() => Some(elements[0].clone()),
            _ => None,
        };
        if array_element.is_none() && !matches!(&f.body, Body::Prim(s) if s == "map.get") {
            return None;
        }'''
assert s.count(old)==1;s=s.replace(old,new)
old='''        let kd = self.g.desc(&f.ty.params(2).0[0].clone());'''
assert s.count(old)==1;s=s.replace(old,'''        let descriptor = array_element.clone().unwrap_or_else(|| f.ty.params(2).0[0].clone());
        let kd = self.g.desc(&descriptor);''')
a=s.index('        self.line(&format!(\n            "int {found}; uint64_t {at} = fwp_map_find',s.index('fn lookup_match'))
b=s.index('        let value_type = match &f.locals[1]',a)
old=s[a:b]
new='''        if array_element.is_some() {
            self.line(&format!("int {found} = (int64_t){index} >= 0 && (uint64_t){index} < fwp_array_len({array});", index=xs[0], array=xs[1]));
            self.line(&format!("V {v} = {found} ? fwp_array_load({array}, (size_t){index}, {kd}) : 0;", array=xs[1], index=xs[0]));
        } else {
'''+old+'''        }
'''
s=s[:a]+new+s[b:]
s=s.replace('''        let value_type = match &f.locals[1] {''','''        let value_type = array_element.or_else(|| match &f.locals[1] {''',1)
at=s.index('        let value_type = array_element.or_else')
end=s.index('        let owned_value =',at)
part=s[at:end];assert part.endswith('        };\n');s=s[:at]+part[:-len('        };\n')]+'        });\n'+s[end:]
(OUT/'cgen.rs').write_text(s)
s=(BASE/'fuse.rs').read_text()
def replace(old,new,count=1):
 global s
 assert s.count(old)==count,(old[:90],s.count(old),count)
 s=s.replace(old,new)
replace('    List(Expr),\n}', '    List(Expr),\n    Array(Expr),\n}',1)
replace('''            ("fold", 3) => Some("fold"),''','''            ("fold", 3) => Some("fold"),
            ("array.fold", 3) if std::env::var("FWP_ARRAY_FUSION").map_or(true, |v| v != "0") => Some("array-fold"),
            ("array.length", 1) if std::env::var("FWP_ARRAY_FUSION").map_or(true, |v| v != "0") => Some("array-length"),''')
replace('''        let funcs = self.funcs;
        let list = args.last()?;''','''        let array = kind.starts_with("array-");
        let kind = match kind { "array-fold" => "fold", "array-length" => "length", other => other };
        let funcs = self.funcs;
        let list = args.last()?;''')
replace('''                    Some("map") => stages.push(Stage::Map(a[0].clone())),
                    Some("filter") => stages.push(Stage::Filter(a[0].clone())),''','''                    Some("map") if !array => stages.push(Stage::Map(a[0].clone())),
                    Some("filter") if !array => stages.push(Stage::Filter(a[0].clone())),
                    Some("array.map") if array => stages.push(Stage::Map(a[0].clone())),''')
replace('''        let producer = match cur {
            Expr::Call(id, a)''','''        let producer = match cur {
            e if array && !stages.is_empty() => Producer::Array(e.clone()),
            _ if array => return None,
            Expr::Call(id, a)''')
replace('''            Producer::List(e) => match self.ty_in(&self.locals, e) {''','''            Producer::List(e) | Producer::Array(e) => match self.ty_in(&self.locals, e) {''')
replace('''        // the accumulator: a fold's, a count, the list so far in reverse,''','''        if array {
            if !elem(&prod_ty).is_some_and(|t| unboxed_numeric(&t)) { return None; }
            for (id, captures) in &fns {
                let (params, result) = funcs[*id].ty.params(captures.len()+1);
                if !unboxed_numeric(params.last()?) || !unboxed_numeric(result) { return None; }
            }
            if kind == "fold" && (!unboxed_numeric(&cparams[1]) || !unboxed_numeric(&result_ty)) { return None; }
        }
        // the accumulator: a fold's, a count, the list so far in reverse,''')
replace('''            Producer::List(e) => (bind(self, e, &prod_ty), None),''','''            Producer::List(e) => (bind(self, e, &prod_ty), None),
            Producer::Array(e) => (Expr::Record(vec![Expr::Const(Value::I64(0)), bind(self, e, &prod_ty)]), None),''')
replace('''            Producer::List(_) => {
                let (h, t) = (next(&mut nl), next(&mut nl));''','''            Producer::List(_) | Producer::Array(_) => {
                let (h, t) = (next(&mut nl), next(&mut nl));''')
needle='''            Producer::List(_) => {
                let (h, t) = cell?;'''
new='''            Producer::Array(_) => {
                let (h, t) = cell?;
                let index_ty = MT::con("std::I64");
                let element = elem(&prod_ty)?;
                let option = MT::Con("std::Option".into(), vec![element]);
                let get = self.prim("array.get", fun2(&index_ty, &prod_ty, &option), 2);
                let add = self.prim("prim.add", fun2(&index_ty, &index_ty, &index_ty), 2);
                let position = Expr::Field(Box::new(st(0)), 0);
                let input = Expr::Field(Box::new(st(0)), 1);
                let next = Expr::Record(vec![Expr::Call(add, vec![Expr::Const(Value::I64(1)), position.clone()]), input.clone()]);
                Expr::Match(Box::new(Expr::Call(get, vec![position, input])), vec![
                    (Pat::Construct(1, vec![Pat::Bind(h)]), Expr::Let(t, Box::new(next), Box::new(body))),
                    (Pat::Wild, stop),
                ])
            }
'''+needle
replace(needle,new)
replace('''            Producer::List(_) => prod_ty.clone(),''','''            Producer::List(_) => prod_ty.clone(),
            Producer::Array(_) => MT::Record(vec![("0".into(), MT::con("std::I64")), ("1".into(), prod_ty.clone())]),''')
replace('''pub fn fuse(prog: &mut Program) {
    let snapshot''','''pub fn fuse(prog: &mut Program) {
    let elements: Vec<_> = prog.funcs.iter().flat_map(|f| &f.locals).filter_map(|ty| match ty {
        MT::Con(name, args) if name == "std::Array" && args.len() == 1 && unboxed_numeric(&args[0]) => Some(args[0].clone()),
        _ => None,
    }).collect();
    for element in elements {
        prog.shapes.entry(MT::Con("std::Option".into(), vec![element.clone()])).or_insert_with(||
            TypeShape::Adt(vec![("None".into(), vec![]), ("Some".into(), vec![element])]));
    }
    let snapshot''')
at=s.index('/// A stage of a fused pipeline')
s=s[:at]+'''fn unboxed_numeric(ty: &MT) -> bool {
    let MT::Con(name, args) = ty else { return false; };
    args.is_empty() && matches!(name.strip_prefix("std::").unwrap_or(name),
        "I8" | "I16" | "I32" | "I64" | "ISize" | "U8" | "U16" | "U32" | "U64" | "USize" | "F32" | "F64")
}

'''+s[at:]
(OUT/'fuse.rs').write_text(s)
print('Prepared numeric Array fusion and scalar lookup matching; no compiler execution or verified support')
