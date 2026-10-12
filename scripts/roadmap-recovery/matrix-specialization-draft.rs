/// Replace only the canonical standard F64 matrix product. Numeric primitive
/// impls cannot be overridden: inference rejects overlapping trait impls.
/// Runtime casts can forge shape fields, so every fast path retains the old
/// body as a fallback and checks exact storage lengths before indexing.
pub fn specialize_matrices(prog: &mut Program) {
    if std::env::var("FWP_MATRIX_BLOCKING").as_deref() == Ok("0") { return; }
    let candidates: Vec<_> = prog.std_names.iter()
        .filter(|(_, name)| name.as_str() == "std::matmul")
        .map(|(id, _)| *id).collect();
    let scalar = MT::con("std::F64");
    let array = MT::Con("std::Array".into(), vec![scalar]);
    for id in candidates {
        let f = &prog.funcs[id];
        if f.arity != 2 { continue; }
        let (params, result) = f.ty.params(2);
        let matrix = |ty: &MT| {
            matches!(ty, MT::Con(name, args) if name == "std::Matrix" && args.first() == Some(&MT::con("std::F64")))
                && record_fields(&prog.shapes, ty).is_some_and(|fields| fields == [
                    ("cols".into(), MT::con("std::I64")),
                    ("data".into(), array.clone()),
                    ("rows".into(), MT::con("std::I64")),
                ])
        };
        if !params.iter().all(|p| matrix(p)) || !matrix(result) { continue; }
        let Body::Expr(original) = &f.body else { continue; };
        let original = original.clone();
        let params: Vec<_> = params.into_iter().cloned().collect();
        let valid = prog.funcs.len();
        let compute = valid + 1;
        let fun_type = |result| MT::Fun(Box::new(params[0].clone()),
            Box::new(MT::Fun(Box::new(params[1].clone()),Box::new(result))));
        prog.funcs.push(Func {name:"matrix._valid-f64".into(), arity:2,
            locals:params.clone(), ty:fun_type(MT::con("std::Bool")),
            body:Body::Prim("matrix._valid-f64".into())});
        prog.funcs.push(Func {name:"matrix._mul-f64".into(), arity:2,
            locals:params.clone(), ty:fun_type(array.clone()),
            body:Body::Prim("matrix._mul-f64".into())});
        prog.funcs[id].body = Body::Expr(Expr::Match(
            Box::new(Expr::Call(valid,vec![Expr::Local(0),Expr::Local(1)])),
            vec![(Pat::Construct(1,vec![]), Expr::Record(vec![
                Expr::Field(Box::new(Expr::Local(0)),0),
                Expr::Call(compute,vec![Expr::Local(0),Expr::Local(1)]),
                Expr::Field(Box::new(Expr::Local(1)),2),
            ])),(Pat::Wild,original)]));
    }
}
