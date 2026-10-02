//! Generated parts of the standard library: trait impls for every
//! primitive numeric type.

use crate::solve::{FLOAT_TYPES, INT_TYPES, SIGNED_INT_TYPES};

/// Source text with the numeric trait impls for primitive types.
pub fn numeric_impls() -> String {
    let mut s = String::from("# Generated: numeric trait impls for primitive types.\n");
    let all: Vec<&str> = INT_TYPES.iter().chain(FLOAT_TYPES).cloned().collect();
    for t in &all {
        for (tr, m, prim) in [
            ("Add", "add", "prim.add"),
            ("Sub", "sub", "prim.sub"),
            ("Mul", "mul", "prim.mul"),
            ("Div", "div", "prim.div"),
            ("Rem", "rem", "prim.rem"),
            ("Zero", "zero", "prim.zero"),
            ("One", "one", "prim.one"),
            ("FromInt", "from-int", "prim.from-int"),
        ] {
            s.push_str(&format!("impl {}[{}] = {{ {} = {} }}\n", tr, t, m, prim));
        }
        s.push_str(&format!("impl Ring[{}] = {{}}\n", t));
    }
    for t in SIGNED_INT_TYPES.iter().chain(FLOAT_TYPES) {
        s.push_str(&format!("impl Neg[{}] = {{ neg = prim.neg }}\n", t));
    }
    for t in FLOAT_TYPES {
        s.push_str(&format!(
            "impl FromFloat[{}] = {{ from-float = prim.from-float }}\n",
            t
        ));
        s.push_str(&format!("impl Field[{}] = {{}}\n", t));
    }
    for (tr, m) in [("Add", "add"), ("Sub", "sub"), ("Mul", "mul")] {
        s.push_str(&format!(
            "impl {}[TInt[n]] = {{ {} = prim.{} }}\n",
            tr, m, m
        ));
    }
    s.push_str("impl Neg[TInt[n]] = { neg = prim.neg }\n");
    s.push_str("impl Zero[TInt[n]] = { zero = prim.zero }\n");
    s.push_str("impl One[TInt[n]] = { one = prim.one }\n");
    s.push_str("impl FromInt[TInt[n]] = { from-int = prim.from-int }\n");
    s
}
