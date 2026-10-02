//! fwp ("foop"): a tacit, statically typed, pipe-oriented language.

// `Value` keys in maps and sets contain `RefCell`s only inside file
// handles, whose ordering is by pointer and never by their contents.
#![allow(clippy::mutable_key_type)]

pub mod ast;
pub mod cgen;
pub mod diag;
pub mod driver;
pub mod env;
pub mod exec;
pub mod exhaust;
pub mod infer;
pub mod interp;
pub mod ir;
pub mod lexer;
pub mod linalg;
pub mod macros;
pub mod mono;
pub mod opt;
pub mod parser;
pub mod pretty;
pub mod prims_std;
pub mod proto;
pub mod solve;
pub mod stdgen;
pub mod syntax;
pub mod textio;
pub mod types;
pub mod value;
