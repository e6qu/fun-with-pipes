//! fwp ("foop"): a tacit, statically typed, pipe-oriented language.

pub mod ast;
pub mod diag;
pub mod driver;
pub mod env;
pub mod exhaust;
pub mod infer;
pub mod interp;
pub mod ir;
pub mod lexer;
pub mod mono;
pub mod parser;
pub mod pretty;
pub mod proto;
pub mod solve;
pub mod stdgen;
pub mod types;
pub mod value;
