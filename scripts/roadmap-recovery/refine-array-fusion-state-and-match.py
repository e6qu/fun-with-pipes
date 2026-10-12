"""Flatten numeric Array loop state and remove lookup-only Option aliases."""
from pathlib import Path
base=Path('/private/tmp/fwp-array-fusion-initial-evidence/source');out=Path('/private/tmp/fwp-phase4-array-fusion-draft')
s=(base/'cgen.rs').read_text();a=s.index('                // `let o = map.get k m in match o ...');b=s.index('                let body = self.bind_local(*l, v, body);',a)
s=s[:a]+'''                // Lookup-only aliases need no Option box or reference counts.
                let mut aliases = vec![*l];
                let mut inner = &**body;
                loop {
                    match inner {
                        Expr::Let(alias, value, next)
                            if matches!(&**value, Expr::Local(x) if Some(x) == aliases.last()) => {
                                aliases.push(*alias);
                                inner = next;
                            }
                        Expr::Dup(x, next) | Expr::Drop(x, next) if aliases.contains(x) => inner = next,
                        _ => break,
                    }
                }
                if !aliases.iter().any(|x| self.resource_slots.contains_key(x)) {
                    if let Expr::Match(scrutinee, arms) = inner {
                        if matches!(&**scrutinee, Expr::Local(x) if Some(x) == aliases.last()) {
                            let stripped: Option<Vec<(Pat, Expr)>> = arms.iter().map(|(pattern, arm)| {
                                let body = aliases.iter().try_fold(arm.clone(), |body, local| without_counts(&body, *local));
                                body.map(|body| (pattern.clone(), body))
                            }).collect();
                            if let Some(arms) = stripped {
                                if let Some(result) = self.lookup_match(v, &arms) { return result; }
                            }
                        }
                    }
                }
'''+s[b:];(out/'cgen.rs').write_text(s)
s=(base/'fuse.rs').read_text();a=s.index('    fn fuse_chain(');b=s.index('\n}\n',a);part=s[a:b]
def replace(old,new,count=1):
 global part
 assert part.count(old)==count,(old,part.count(old),count);part=part.replace(old,new)
replace('        let funcs = self.funcs;', '        let accumulator = if array { 2 } else { 1 };\n        let capture_start = if array { 3 } else { 2 };\n        let funcs = self.funcs;')
replace('(i + 2) as u32','(i + capture_start) as u32',2)
replace('st(1)','st(accumulator)',5)
replace('''            let mut fs = vec![pos.clone(), acc];''','''            let mut fs = if array { vec![pos.clone(), st(1), acc] } else { vec![pos.clone(), acc] };''')
replace('''                let position = Expr::Field(Box::new(st(0)), 0);
                let input = Expr::Field(Box::new(st(0)), 1);
                let next = Expr::Record(vec![
                    Expr::Call(add, vec![Expr::Const(Value::I64(1)), position.clone()]),
                    input.clone(),
                ]);''','''                let position = st(0);
                let input = st(1);
                let next = Expr::Call(add, vec![Expr::Const(Value::I64(1)), position.clone()]);''')
replace('''            Producer::Array(_) => MT::Record(vec![
                ("0".into(), MT::con("std::I64")),
                ("1".into(), prod_ty.clone()),
            ]),''','''            Producer::Array(_) => MT::con("std::I64"),''')
replace('''        let mut fields = vec![
            ("0".to_string(), pos_ty.clone()),
            ("1".to_string(), acc_ty.clone()),
        ];''','''        let mut fields = if array {
            vec![("0".into(), pos_ty.clone()), ("1".into(), prod_ty.clone()), ("2".into(), acc_ty.clone())]
        } else {
            vec![("0".into(), pos_ty.clone()), ("1".into(), acc_ty.clone())]
        };''')
replace('((i + 2).to_string(), self.locals[*l as usize].clone())','((i + capture_start).to_string(), self.locals[*l as usize].clone())')
replace('''        let mut init = vec![start, z];''','''        let mut init = if array {
            let Expr::Record(mut positions) = start else { return None; };
            positions.push(z);
            positions
        } else { vec![start, z] };''')
s=s[:a]+part+s[b:];(out/'fuse.rs').write_text(s)
print('Prepared flattened state and lookup-only alias lowering; runner validation required')
