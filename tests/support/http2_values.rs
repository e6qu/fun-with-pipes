use fwp::ir::*;

// Generate the real result descriptors and primitive calls without starting a server.
pub fn generated() -> String {
    let unit = MT::unit();
    let string = MT::con("std::String");
    let bytes = MT::con("std::Bytes");
    let int = MT::con("std::I64");
    let option = MT::Con("std::Option".into(), vec![string.clone()]);
    let result = MT::Con("std::Result".into(), vec![bytes.clone(), int.clone()]);
    let tuple = |fields: Vec<MT>| {
        MT::Record(
            fields
                .into_iter()
                .enumerate()
                .map(|(i, t)| (i.to_string(), t))
                .collect(),
        )
    };
    let pair = tuple(vec![string.clone(), string.clone()]);
    let headers = MT::Con("std::List".into(), vec![pair.clone()]);
    let request = tuple(vec![
        string.clone(),
        string.clone(),
        headers.clone(),
        string.clone(),
        option.clone(),
    ]);
    let primitive = |name: &str, args: Vec<MT>, result: MT| Func {
        name: name.into(),
        arity: args.len() as u32,
        locals: args.clone(),
        ty: args.into_iter().rev().fold(result, |result, arg| {
            MT::Fun(Box::new(arg), Box::new(result))
        }),
        body: Body::Prim(name.into()),
    };
    let program = Program {
        funcs: vec![
            primitive("tls.available", vec![unit], MT::con("std::Bool")),
            primitive("http2.request", vec![MT::con("std::H2Stream")], request),
            primitive(
                "http2.body",
                vec![
                    int.clone(),
                    MT::con("std::Duration"),
                    MT::con("std::H2Stream"),
                ],
                result.clone(),
            ),
        ],
        shapes: [
            (
                headers.clone(),
                TypeShape::Adt(vec![
                    ("Nil".into(), vec![]),
                    ("Cons".into(), vec![pair, headers]),
                ]),
            ),
            (
                option,
                TypeShape::Adt(vec![("None".into(), vec![]), ("Some".into(), vec![string])]),
            ),
            (
                result,
                TypeShape::Adt(vec![("Ok".into(), vec![bytes]), ("Err".into(), vec![int])]),
            ),
        ]
        .into(),
        exports: vec![("available".into(), 0)],
        named: vec![("request".into(), 1), ("body".into(), 2)],
        ..Program::default()
    };
    let (code, _) = fwp::cgen::generate_library(&program, "http2_values").unwrap();
    if let Some(path) = std::env::var_os("FWP_SERVICE_ARTIFACTS") {
        let path = std::path::PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        std::fs::write(path.join("http2-generated.c"), &code).unwrap();
    }
    let descriptor = |prefix: &str| {
        code.lines()
            .find_map(|line| {
                line.trim()
                    .strip_prefix(prefix)
                    .and_then(|line| line.strip_suffix(");"))
            })
            .unwrap()
            .to_owned()
    };
    let macros = format!(
        "\n#define REQUEST_TYPE ({})\n#define BODY_TYPE ({})\n",
        descriptor("return fwp_p_http2_request(l0, "),
        descriptor("return fwp_p_http2_body(l0, l1, l2, ")
    );
    code + &macros
}
