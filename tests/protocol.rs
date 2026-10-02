//! Protocol and text-format unit tests: round trips, golden bytes and
//! fingerprint sensitivity.

use fwp::driver::compile_source;
use fwp::ir::{Program, MT};
use fwp::mono::Roots;
use fwp::proto;
use fwp::value::{display, Value};

const SRC: &str = r#"
User = { name: String, age: U8, tags: List[String] }
Shape = | Circle F64 | Rect F64 F64
export make-user : String -> User
make-user = make User { name = id, age = const 7u8, tags = const ["a", "b"] }
export shape : F64 -> Shape
shape = Circle
export misc : I64 -> (Option[I128], Map[String, F32], Bytes, TInt[3])
misc = const (Some -5i128, map.from-list [("k", 1.5f32)], string.to-bytes "hi", 0t+-0)
"#;

fn program() -> Program {
    compile_source(
        "t.fwp",
        SRC,
        Roots {
            exports: true,
            ..Default::default()
        },
    )
    .map_err(|f| f.rendered)
    .unwrap()
    .1
}

fn result_type(prog: &Program, name: &str) -> MT {
    let (_, id) = prog.exports.iter().find(|(n, _)| n == name).unwrap();
    let f = &prog.funcs[*id];
    f.ty.params(f.arity as usize).1.clone()
}

fn value_of(prog: &Program, name: &str, arg: Value) -> Value {
    let (_, id) = prog.exports.iter().find(|(n, _)| n == name).unwrap();
    let mut sink = Vec::new();
    let mut it = fwp::interp::Interp::new(prog, Box::new(&mut sink));
    let f = Value::Closure(std::rc::Rc::new(fwp::value::Closure {
        func: *id,
        args: vec![],
    }));
    it.apply(f, vec![arg]).ok().unwrap()
}

#[test]
fn encode_decode_round_trip() {
    let prog = program();
    for (name, arg) in [
        ("make-user", Value::str("Ada")),
        ("shape", Value::F64(2.5)),
        ("misc", Value::I64(0)),
    ] {
        let mt = result_type(&prog, name);
        let v = value_of(&prog, name, arg);
        let mut bytes = Vec::new();
        proto::encode(&mut bytes, &v, &mt, &prog);
        let mut r = proto::Reader::new(&bytes);
        let back = proto::decode(&mut r, &mt, &prog).unwrap();
        assert_eq!(r.pos, bytes.len());
        assert_eq!(
            display(&back, &mt, &prog, false),
            display(&v, &mt, &prog, false)
        );
        // and through the text format
        let shown = display(&v, &mt, &prog, false);
        let parsed = fwp::textio::parse(&shown, &mt, &prog).unwrap();
        assert_eq!(display(&parsed, &mt, &prog, false), shown, "{}", name);
    }
}

#[test]
fn golden_bytes() {
    let prog = program();
    let mt = result_type(&prog, "make-user");
    let v = value_of(&prog, "make-user", Value::str("Ada"));
    let mut bytes = Vec::new();
    proto::encode(&mut bytes, &v, &mt, &prog);
    // fields in canonical order: age (u8), name (len + utf8), tags (count + strings)
    assert_eq!(bytes, vec![7, 3, b'A', b'd', b'a', 2, 1, b'a', 1, b'b']);
    assert_eq!(proto::frame(&[1, 2]), vec![1, 2, 0, 0, 0, 1, 2]);
    assert_eq!(proto::end_frame(), vec![0, 0, 0, 0, 0]);
    let h = proto::header(&MT::con("std::I64"), &prog);
    assert_eq!(&h[..5], b"FWP1\x01");
}

#[test]
fn fingerprints_depend_on_structure() {
    let prog = program();
    let user = result_type(&prog, "make-user");
    let canon = proto::canonical_type(&user, &prog);
    assert_eq!(
        canon,
        "main::User<age:std::U8,name:std::String,tags:std::List[std::String]>"
    );
    let a = proto::fingerprint(&canon);
    let b = proto::fingerprint(&canon.replace("U8", "U16"));
    assert_ne!(a, b);
    assert_eq!(a, proto::fingerprint(&canon));
}

#[test]
fn pipeline_parsing() {
    let st = fwp::exec::parse_pipeline("a.fwp:f 1 \"x | y\" | b.fwp:g").unwrap();
    assert_eq!(st.len(), 2);
    assert_eq!(st[0].args, vec!["1".to_string(), "x | y".to_string()]);
    assert_eq!(st[1].function, "g");
    assert!(fwp::exec::parse_pipeline("a.fwp:f | ").is_err());
}
